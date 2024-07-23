-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2024 at 11:17 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tourist-guidence`
--

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `monument_id` int(11) NOT NULL,
  `isFavourite` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`id`, `user_id`, `monument_id`, `isFavourite`) VALUES
(6, 11, 43, 1),
(7, 11, 13, 1),
(8, 11, 33, 1),
(9, 0, 2, 1),
(10, 0, 12, 1),
(11, 0, 48, 1),
(12, 0, 45, 1),
(13, 0, 20, 1),
(14, 10, 19, 1),
(15, 10, 28, 1),
(16, 10, 34, 1),
(17, 10, 7, 1),
(18, 10, 33, 1),
(19, 11, 21, 1),
(20, 11, 18, 1);

-- --------------------------------------------------------

--
-- Table structure for table `monument`
--

CREATE TABLE `monument` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `weather` varchar(255) NOT NULL,
  `historical_period` varchar(255) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `availability` varchar(255) NOT NULL DEFAULT 'available from 12 am to 11 pm',
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `monument`
--

INSERT INTO `monument` (`id`, `name`, `description`, `location`, `weather`, `historical_period`, `instructions`, `availability`, `image_url`) VALUES
(0, 'Khan Elkhalili', 'Khan El Khalili dates back to more than 600 years ago and named after its founder the Mamluk prince and well-known merchant (Jerksy al Khalili) during the Mamluky the period in 1400, at the Fatimid kingdom it was a massive necropolis for the Fatimid princes and sultans, but then came their first enemies and competitors the Mamluks who took over Egypt and replaced the royal necropolis with the bazaar. Merchants traveled from all over the world with their goods and centered in the El Khalili market to offer and sell their merchandise. The Arab historian (al maqrezy ) described the bazaar as a huge square-shaped yard with stores, mini bazaars and houses', 'cairo, Egypt', 'clear', 'ancient', 'camera,pets,drink', 'from 9 am to 12 pm', '1711829855157.webp'),
(1, 'karnak', 'The Karnak Temple Complex consists of a number of temples, chapels, and other buildings in the form of a village, and is for that reason that the name Karnak was given to this complex as in Arabic Karnak means fortified village.The Karnak Temple was built between 2055 BC and around 100 AD. It was built as a cult temple and was dedicated to the gods Amun, Mut, and khonsu. Being the largest building for religious purposes ever to be constructed, the Karnak Temple was known as “most select of places” by ancient Egyptians.', 'luxor , Egypt', 'sunny', 'ancient', 'camera,pets', 'from 8 am to 9 pm', '1711830540726.webp'),
(2, 'Amenhotep III and Tiye', 'This colossal statue depicts the royal couple, Amenhotep III and his wife Tiye, along with their three daughters. This is the largest known ancient Egyptian family group statue ever carved, and it is fitting that it dates to the reign of Amenhotep III, whose prosperous rule was marked by great such monumentality.', 'luxor , Egypt', 'sunny', 'ancient', 'camera', 'from 8 am to 9 pm', '1711831224538.webp'),
(3, 'bab zewyla', 'Built in the 11th century, beautiful Bab Zuweila was an execution site during Mamluk times, and today is the only remaining southern gate of the medieval city of Al Qahira. There are interesting exhibits about the gate\'s history, all with thorough explanations in English, inside the gate, while up on the roof you get panoramic vistas that stretch out to the citadel. Those with a head for heights can also wind their way up to the top of the two minarets.\nThe spirit of a healing saint was (and still is) said to reside behind one towering wooden door, which supplicants have studded with nails and teeth as offerings over the centuries.', 'cairo, Egypt', 'sunny', 'ancient', 'camera,pets', 'from 9 am to 5 pm', '1711831676241.webp'),
(4, 'roman museum', 'The Graeco-Roman Museum of Alexandria is one of Egypt\'s principal museums, the oldest building in Egypt to be architecturally designed for the purpose of preserving and displaying antiquities. Furthermore, it is the only museum fully dedicated to the antiquities and civilization of Egypt during the Greek and Roman eras.\nSince 1889, the Italian Giuseppe Botti sought to establish a museum for Alexandria that would protect its antiquities from displacement and destruction. He continued to work on that until the decision to establish the museum was issued on June 1, 1892. The museum began in a modest rented property, and Khedive Abbas Helmy II inaugurated it on 17 October 1892. Giuseppe Botti was its first director', 'alexandria,Egypt', 'sunny', 'medieval', 'camera', 'from 9 am to 5 pm', '1711832547681.webp'),
(5, 'white dessert', 'The white sand desert stretches over a 20 kilometer long strip. It is crossed by the road that connects Al-Bahariya and Al-Farafra. The entrance to this mineral site is marked by a sparkling hill called “the crystal mountain”.\nMany millions of years ago the ocean floor was here, and the white rock is the remains of marine microorganisms. Over the centuries, wind and sand have turned the former seabed into a semblance of the surface of some other planet. \nThe name of this desert comes from the layer of chalk and limestone which partially covers the landscape. The white desert is a unique place, nothing like this you will not find anywhere in the world. It actually has a white color due to rock formations that make up a bizarre contrast with the yellow desert sand. At night, especially when the terrain is lit by the full moon, the desert looks like the Arctic with its snow-white landscapes (many scientists also note its similarity to the Dry Valleys located in the Antarctic). The most beautiful views here can be seen at sunrise and sunset or at night.', 'Qasr Al Farafra ,Egypt', 'clear', 'ancient', 'camera,drink', 'all day', '1711833323558.webp'),
(6, 'Nefertiti', 'Nefertiti was the great royal wife of King Akhenaten and, in contemporary Western culture, is perhaps ancient Egypt’s most famous queen – as the iconic bust in the Berlin Museum evinces. She and Akhenaten produced six daughters, a female royal contingent that enjoyed unusual prominence during Akhenaten’s reign. In fact, Nefertiti holds the position as the Egyptian queen with the most surviving appearances on monuments and other artistic mediums. \nDuring his reign, Akhenaten enacted a series of shocking religious and societal changes that re-centered the Egyptian pantheon around a formerly peripheral god: the Aten. This political move most likely created a place of prominence for Nefertiti within official mediums. To cement the pharaoh’s societal changes, greater authority was placed on the royal family – a decision in which  Nefertiti’s influence was continually emphasized. As a result, Nefertiti is frequently shown making offerings to the Aten without her husband, suggesting that she possessed an unusual level of autonomy in the Egyptian court. Images even show Nefertiti smiting the enemies of Egypt – a motif previously reserved only for the pharaoh.', 'Neues Museum Berlin,Berlin', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1711833849345.webp'),
(7, 'Cairo Tower', 'The Cairo Tower (Egyptian Arabic: برج القاهرة, Borg El-Qāhira) is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it was the tallest structure in Egypt for 37 years until 1998, when it was surpassed by the Suez Canal overhead powerline crossing. It was the tallest structure in North Africa for 21 years until 1982, when it was surpassed by the Nador transmitter in Morocco. It was the tallest structure in Africa for one year until 1962, when it was surpassed by Sentech Tower in South Africa.One of Cairo\'s well-known modern monuments, sometimes considered Egypt\'s second most famous landmark[citation needed] after the Pyramids of Giza, it stands in the Gezira district on Gezira Island in the River Nile, close to downtown Cairo.\",\"location\":\"It is located in the middle of Cairo at the edge of Zamalek island', 'cairo ,Egypt', 'sunny', 'ancient', 'camera,drink', 'from 9 am to 5 pm', '1711834795581.webp'),
(8, 'Hatshepsut face', 'Hatshepsut, was the female king of Egypt (reigned as coregent c. 1479–73 BCE and in her own right c. 1473–58 BCE) who attained unprecedented power for a woman, adopting the full titles and regalia of a pharaoh.\nthe elder daughter of the 18th-dynasty king Thutmose I and his consort Ahmose, was married to her half brother Thutmose II, son of the lady Mutnofret. Since three of Mutnofret’s older sons had died prematurely, Thutmose II inherited his father’s throne about 1492 BCE, with Hatshepsut as his consort. Hatshepsut bore one daughter, Neferure, but no son. When her husband died about 1479 BCE, the throne passed to his son Thutmose III, born to Isis, a lesser harem queen. As Thutmose III was an infant, Hatshepsut acted as regent for the young king.', 'Egyption Museum ,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 5 pm', '1711835967468.webp'),
(9, 'Pyramid of Djoser', 'Djoser’s Step Pyramid in Saqqara is one of Egypt’s most iconic monuments—and rightfully so. It constitutes a significant historical turning point in ancient Egyptian funerary monuments, revolutionizing stone architecture and royal burials. In addition to its beauty and monumental scale, it is not only the very first pyramid that the ancient Egyptians ever built, but also the oldest known ancient Egyptian stone structure.\nThe sheer age of the Step Pyramid is astounding. It was built in the early Third Dynasty, during the reign of King Netjerykhet (c.2667–2648 BC), who is now more well-known as Djoser.Before his reign, royal and elite Egyptians were buried in mastabas. This word, meaning “bench” in Arabic, refers to a type of funerary structure that was generally rectangular in shape and built over the tomb proper, which was underground. The Step Pyramid is composed of six stacked mastabas, thus creating the stepped effect. Imhotep, its architect, may very well have been responsible for this major innovation.\nAt one end of the pyramid complex, a structure known as the South Tomb is believed to have acted as an additional, symbolic, tomb for Djoser, perhaps reflecting his role as the dual king of both Upper and Lower Egypt.', 'Saqqara,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'from 8 am to 4.5 pm', '1712083448066.webp'),
(10, 'Qaitbay Castle', 'Qaitbay Citadel is one of the most important forts on the coast of the Mediterranean Sea. The Mamluk sultan al-Ashraf Abu al-Nasr Qaitbay built it between 882 AH/ 1477 AD and 884/ 1479 AD over the ruins of Alexandria’s Lighthouse. It served as Alexandria’defence against naval attacks.The citadel was made of limestone and spanned an area of approximately 17550 m2. An outer wall plotted with defence towers surrounds the building.An inner wall surrounds the citadel’s courtyard and includes a number of rooms some of them used as barracks and others for storage.The citadel’s entrance leads to the courtyard where we find the main tower located in the northwest. It consists of a massive three-floored square fort. Its four corners are occupied by half-circular towers that carry protruding balconies for the defence of the city. A tank near the tower supplied soldiers and their horses with water.Qaitbay citadel drew the attention of rulers throughout the ages, on account of its strategic location. The building was also enlarged and subject to other conservation operations in 2003.', 'Alexandria,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 7 pm', '1712084085411.webp'),
(11, 'dendarah', 'Dendera one of the best sights in Luxor, originally called Tentyris, was one of the most important religious centers in ancient Egypt. It is situated on the west bank of the Nile, south of Qena in Egypt. The city was rendered sacred by three sanctuaries: the Sanctuary of Horus, the god of the sky and protector of the pharaohs, the Sanctuary of Ihy, the young sistrum-playing son of Horus, and the Sanctuary of Hathor. Only the latter has survived practically inact, while no more than a few traces remain of the other two.', 'luxor,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 4 pm', '1712085128616.webp'),
(12, 'Hatshepsut Statue', 'Hatshepsut, was the female king of Egypt (reigned as coregent c. 1479–73 BCE and in her own right c. 1473–58 BCE) who attained unprecedented power for a woman, adopting the full titles and regalia of a pharaoh.\\nthe elder daughter of the 18th-dynasty king Thutmose I and his consort Ahmose, was married to her half brother Thutmose II, son of the lady Mutnofret. Since three of Mutnofret’s older sons had died prematurely, Thutmose II inherited his father’s throne about 1492 BCE, with Hatshepsut as his consort. Hatshepsut bore one daughter, Neferure, but no son. When her husband died about 1479 BCE, the throne passed to his son Thutmose III, born to Isis, a lesser harem queen. As Thutmose III was an infant, Hatshepsut acted as regent for the young king.', 'Egyption Museum ,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 5 pm', '1712085490249.webp'),
(13, 'Babylon Fortress', 'The fort was first built by the Persians in about the sixth century B.C., but at that time it was on the cliffs near the river.When the Romans took possession of Egypt, they used the old fort for a while, recognizing its strategic importance on the Nile, but because the problems of water delivery, the Roman Emperor Trajan relocated the fort to its present location, which at that time was nearer to the River. Since then, the Nile\'s course has moved some 400 yards to the north.The fort\'s name has been a matter of controversy. The most dominant view seems to be that the name is derived from a corruption of the ancient Egyptian per-hapi-n-On, which means the House of the Nile of On, which was what the earlier Egyptians called Roda Island', 'cairo,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 5 pm', '1712086156375.webp'),
(14, 'asaden qasr wl nile', '\"They were alleged to stand as guards on the animals of the Giza Zoo, but their breathtaking beauty told Khedive Ismail ali to use them to brighten the oldest bridge on the Nile\".. I don\'t think that anyone in Egypt knows this information, when he started building the bridge \"Palace of the Nile\", the primary bridge on the Nile within the late 19th century, specifically in 1869, wanted to embellish its entrances with giant statues, so he converted the location of lions on the doors of the zoo, and replaced them when the opening of the zoo in 1891, with stereoscopic paintings on the doorway depicting various animals of the forest.', 'cairo,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'all day', '1712086634623.webp'),
(15, 'Azhar Mosque', 'Al-Azhar was first established in the first place as an educational institution to teach Shi\'ite theology and its main target was to spread it all over the country. It is located in El-Hussein Square. The name of.Al-Azhar mosque is believed to be taken from the name of the Prophet Mohammed\'s daughter \"Fatima\". Because it was the first mosque and the first Islamic university to be built in Cairo, the city was named since then \"The City of A Thousand Minarets\". After Al Karaouine in Irisid Fes, which is a university in Morocco, Al-Azhar has developed to be the second most important university in the world', 'cairo,Egypt', 'clear', 'medieval', 'camera', 'from 8 am to 4 pm', '1712087388522.webp'),
(16, 'Statue of King Zoser', 'Statue representing King Djoser, the first ruler of the Third Dynasty and owner of the Step Pyramid in the Saqqara necropolis seated on his throne. This statue, originally painted, is the oldest know life-size statue in Egypt and has been found during the excavations of the Egyptian Antiquities Service in the years 1924-25 inside the serdab (Arabic name for «cellar»)  located on the east side of the Step Pyramid and now replaced by a plaster replica. The ancient robbers removed the eyes that were originally inlaid with rock crystal and obsidian. The pedestal is inscribed with the titles of the king and his Horus name Netjerkhet «His body is divine» in hieroglyphic text', 'Egyption Museum,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712090945845.webp'),
(17, 'Statue of Tutankhamun with Ankhesenamun', 'Ankhesenamun, was one of the six daughters of king Akhenaten and Nefertiti. It is believed Ankhesenamun was born in the Theban Capital, around year 4 of her father’s reign, and later grew up in the then newly established Atenist capital of Akhetaten, founded by her father and mother.The boy king, Tutankhamun is believed to be the son of king Akhenaten and a currently unknown sister-wife of the king. Although it must be noted that the identity of mummy KV55 as Akhenaten is not entirely agreed upon by all scholars. However, what is known for certain and is accepted by all scholars, is that Tutankhamun and his sister-wife Ankhesenamun both originally had Atenist names, which were later changed once Akhenaten’s Atenist revolution eventually crumbled and Tutankhamun reinstated the Amun pantheon.', 'Luxor Temple,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712091933812.webp'),
(18, 'Sphinx', 'Huge statues are one of the distinguished features of the ancient Egyptian civilization. The Sphinx is the most famous of them. The statue was carved in the rock of the same area during the era of the Fourth Dynasty (2613-2494 BC) that makes it the oldest.As the ancient Egyptian sphinxes represented the king with a lion\'s body as a clear indication of his strength\n\n ', 'giza,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'from 7 am to 6 pm', '1712092257002.webp'),
(19, 'abydos', 'Abydos Egypt\'s Sacred City of the Dead and Gateway to the Afterlife Abydos, one gé the most ancient cities of Upper Egypt, beckons history enthusiasts and spiritual seekers alike with its potent blend of myth, history, and archaeology. Richly steeped in religious significance, this city has played a pivotal role in Egypt\'s cultural and religious history, serving as a sacred pilgrimage site and necropolis for several millennia.', 'sohag,Egypt', 'sunny', 'ancient', 'camera,pets', 'from 7 am to 3 pm', '1712094068424.webp'),
(20, 'Tutankhamun statue', 'Upper section of a granodiorite figure of Tutankhamun: wearing a royal \'nemes\' headcloth, false beard, beaded broad collar, and elaborately pleated kilt, steps forward to present a chest-high pillar that once tapered toward the statue base (now lost). The three exposed surfaces of the pillar are decorated with low raised relief depicting lotus blossoms, bunches of grapes, pomegranates, sheaves of grain, and clutches of bagged ducks hung by their feet. An adjoining fragment from the lower part of the statue preserves the umbels of papyrus plants that \"grew\" from the base on the proper left side of the sculpture. This may be a depiction of the pharaoh in the guise of the god Hapi, who embodied the Nile in flood. The back-pillar is inscribed.', 'Egyptian Museum i,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712094774533.webp'),
(21, 'abu simple temple', 'Abu Simbel is a temple built by Ramesses II (c.1279-1213 B.C.E.) in ancient Nubia, where he wished to demonstrate his power and his divine nature. Four colossal (65 feet/20 meters high) statues of him sit in pairs flanking the entrance. The head and torso of the statue to the left of the entrance fell during ancient times, probably the result of an earthquake. This temple faces the east, and Re-Horakhty, one manifestation of the sun god, is shown inside the niche directly above the entrance. The alignment of the temple is such that twice a year the sun\'s rays reach into the innermost sanctuary to illuminate the seated statues of Ptah, Amun-Re, Ramesses II, and Re-Horakhty.The temple was cut out of the sandstone cliffs above the Nile River in an area near the Second Cataract. When the High Dam was being constructed in the early 1960s, international cooperation assembled funds and technical expertise to move this temple to higher ground so that it would not be inundated by the waters of Lake Nasser.', 'Aswan,Egypt', 'clear', 'ancient', 'camera', 'from 6 am to 5 pm', '1712095146178.webp'),
(22, 'Hanging church', 'History of the Hanging Church\nThe church of the Virgin Mary has become known as the hanging church because it was built on top of a 4th century BC on the southern wall of a Roman fortress of Babylon. The church is also referred to as the suspended church or the Staircase Church or Al-Moallaqa as its nave is suspended over the passage. The church dates back to the 5th century AD and from the 7th century to the 13th century AD, it served as the residence of the Coptic patriarch where it witnessed many historically decisive events like general elections and religious ceremonies, which makes it one of the oldest and important Christian landmarks in Egypt.', 'cairo,Egypt', 'clear', 'medieval', 'camera', 'from 9 am to 5 pm', '1712095496101.webp'),
(23, 'mohamed ali statue', 'Muhammad Ali[a] (4 March 1769 – 2 August 1849) was the Ottoman Albanian[3] governor and de facto ruler of Egypt from 1805 to 1848, considered the founder of modern Egypt. At the height of his rule, he controlled Egypt, Sudan, Hejaz, Najd, the Levant, Crete and parts of Greece.', 'Alexandria,Egypt', 'sunny', 'medieval', 'camera,drink,pets', 'all day', '1712262775014.webp'),
(24, 'Akhenaten', 'King Akhenaten or Amenhotep IV was the great Egyptian pharaoh for the 18th dynasty for 17 years and died in 1336 B.C. The previous name of Akhenaten was King Amenhotep IV before the fifth year of his reign and he was also known as Akhenaton', 'Egyption Museum,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712265433070.webp'),
(25, 'mamnon statue', 'The Colossi of Memnon (also known as el-Colossat or el-Salamat) are two monumental statues representing Amenhotep III (1386-1353 BCE) of the 18th Dynasty of Egypt. They are located west of the modern city of Luxor and face east looking toward the Nile River. The statues depict the seated king on a throne ornamented with imagery of his mother, his wife, the god Hapy, and other symbolic engravings. The figures rise 60 ft (18 meters) high and weigh 720 tons each; both carved from single blocks of sandstone.', 'luxor,Egypt', 'sunny', 'ancient', 'camera', 'from 6 am to 5 pm', '1712265677232.webp'),
(26, 'luxor temple', 'Luxor Temple, Ipet-resyt “Southern Sanctuary” to the ancient Egyptians, was so called because of its location within ancient Thebes (modern Luxor). It is located around three kilometers to the south of Karnak Temple, to which it was once linked with a processional way bordered with sphinxes. The oldest evidence for this temple dates to the Eighteenth Dynasty (c.1550–1295 BC).', 'luxor,Egypt', 'sunny', 'ancient', 'camera', 'from 6 am to 8 pm', '1712266124705.webp'),
(27, 'valley of kings', 'The rulers of the Eighteenth, Nineteenth, and Twentieth Dynasties of Egypt’s prosperous New Kingdom (c.1550–1069 BC) were buried in a desolate dry river valley across the river from the ancient city of Thebes (modern Luxor), hence its modern name of the Valley of the Kings. This moniker is not entirely accurate, however, since some members of the royal family aside from the king were buried here as well, as were a few non-royal, albeit very high-ranking, individuals. The Valley of the Kings is divided into the East and West Valleys. The eastern is by far the more iconic of the two, as the western valley contains only a handful of tombs. In all, the Valley of the Kings includes over sixty tombs and an additional twenty unfinished ones that are little more than pits.', 'luxor,Egypt', 'sunny', 'ancient', 'camera', 'from 6 am to 5 pm', '1712266288559.webp'),
(28, 'katharninkloster', 'On the slopes of Mount Sinai, where Moses received the Ten Commandments from God, lies one of the oldest functioning monasteries in the world. Commonly known as Saint Catherine’s Monastery, its actual name is the “Sacred Monastery of the God-Trodden Mount Sinai”. It was built by the order of the Byzantine Emperor Justinian I (527–565 AD) in 548–565 ADin order to house the monks that had been living in the Sinai Peninsula since the 4th century AD.', 'South Sinai,Egypt', 'sunny', 'ancient', 'camera', 'from 8:45 am to 12:45 pm', '1712274582678.webp'),
(29, 'The Seated Scribe', 'The Louvre’s scribe, known as the “Seated Scribe”, is indeed sitting cross-legged, his right leg crossed in front of his left. The white kilt, stretched over his knees, serves as a support. He is holding a partially rolled papyrus scroll in his left hand. His right hand must have held a brush, now missing. ', 'Egyption Museum,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712277098201.webp'),
(30, 'pharonic village', 'Located just a stone\'s throw from the bustling metropolis of Cairo, the Museum of the Pharaonic Village offers visitors a rare opportunity to step back in time and experience Ancient Egyptian culture first-hand. The brainchild of Dr Hassan Ragab, one of Egypt\'s foremost archaeologists, the Museum is spread over 30 acres of land and includes several reconstructions of actual Pharaonic-era structures.Walking around the museum grounds, you\'ll get to explore a replica of an Old Kingdom tomb, see how papyrus was made using traditional techniques, and even take a ride in a ceremonial barge. There are also some workshops where artisans demonstrate their skills in creating everything from pottery to jewellery. And don\'t forget to stop by the Museum\'s very own zoo, which is home to ancient animals revered by the Ancient Egyptians, such as crocodiles and hippos!', 'giza,Egypt', 'sunny', 'recent', 'camera', 'from 9 am to 6 pm', '1712279372215.webp'),
(31, 'Bibliotheca Alexandrina', 'The Great Library of Alexandria in Alexandria, Egypt, was one of the largest and most significant libraries of the ancient world. The library was part of a larger research institution called the Mouseion, which was dedicated to the Muses, the nine goddesses of the arts.[10] The idea of a universal library in Alexandria may have been proposed by Demetrius of Phalerum, an exiled Athenian statesman living in Alexandria, to Ptolemy I Soter, who may have established plans for the Library, but the Library itself was probably not built until the reign of his son Ptolemy II Philadelphus. The Library quickly acquired many papyrus scrolls, owing largely to the Ptolemaic kings\' aggressive and well-funded policies for procuring texts. It is unknown precisely how many scrolls were housed at any given time, but estimates range from 40,000 to 400,000 at its height.', 'Alexandria,Egypt', 'clear', 'ancient', 'camera', 'from 10 am to 7 pm', '1712280430578.webp'),
(32, 'Great Pyramids of Giza', 'The pyramids of Giza and the Great Sphinx are among the most popular tourist destinations in the world, and indeed already were even in Roman times. Each of these spectacular structures served as the final resting place of a king of the 4th Dynasty (c.2613–2494 BC). The Great Pyramid of Giza was built for king Khufu (c.2589–2566 BC), and the other two for Khafre and Menkaure, his son and grandson. Khufu’s pyramid is both the oldest and largest of the three, and the first building to exceed it in height would not be built for another 3,800 years!', 'giza,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'from 8 am to 4:30 pm', '1712280668028.webp'),
(33, 'Isis with her child', 'Isis, one of the most important goddesses of ancient Egypt. Her name is the Greek form of an ancient Egyptian word for “throne.”Isis was initially an obscure goddess who lacked her own dedicated temples, but she grew in importance as the dynastic age progressed, until she became one of the most important deities of ancient Egypt. Her cult subsequently spread throughout the Roman Empire, and Isis was worshipped from England to Afghanistan. She is still revered by pagans today. As mourner, she was a principal deity in rites connected with the dead; as magical healer, she cured the sick and brought the deceased to life; and as mother, she was a role model for all women.', 'Egyption Museum,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712328231034.webp'),
(34, 'Ramesseum', 'In the heart of ancient Thebes, on the west bank of the majestic Nile River, stands a testament to the grandeur and ambition of one of Egypt’s most illustrious pharaohs: the Ramesseum Temple. Built over 3,000 years ago by Ramesses II, this colossal memorial temple has weathered the sands of time, revealing glimpses of a civilization that once thrived along the fertile banks of the Nile.\nApproaching the Ramesseum, one cannot help but be struck by the sheer magnitude of its presence. The massive pylons, once adorned with towering statues and intricate hieroglyphs, stand as silent sentinels guarding the secrets of the past. As we pass through the towering entrance, we are transported back in time to an age of unparalleled splendor and opulence.', 'luxor,Egypt', 'sunny', 'ancient', 'camera,drink', 'all day', '1712328771605.webp'),
(35, 'Mohammed Ali Mosque in cairo citadel', 'The Mosque of Muhammad Ali is located inside the Citadel of Salah al-Din al-Ayyubi (Saladin) in Cairo. It was built by Muhammad Ali Pasha in 1265 AH\\ 1848 AD on the site of Mamluk palaces. This mosque is known as the \"Alabaster Mosque\", in reference to its marble paneling on its interior and exterior walls. The mosque’s twin minarets are the highest in all of Egypt, each reaching a height of 84 meters.', 'cairo,Egypt', 'clear', 'ancient', 'camera', 'from 9 am  to 5 pm', '1712329064419.webp'),
(36, 'Hatshepsut Temple', 'Hatshepsut (c.1473–1458 BC), the queen who became pharaoh, built a magnificent temple at Deir al-Bahari, on the west back of Luxor. It lies directly across the Nile from Karnak Temple, the main sanctuary of the god Amun. Hatshepsut’s temple, Djeser-djeseru “the Holy of Holies” was designed by the chief steward of Amun, Senenmut.', 'Deir al-Bahari,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'from 6 am to 5 pm', '1712329379581.webp'),
(37, 'Alhakim biAmr Allah', 'The Mosque of al-Hakim bi-Amr Allah is the fourth oldest mosque in Egypt, and the second largest after the Mosque of ibn Tulun. The construction of the mosque was begun by al-Hakim’s father, the Fatimid Caliph al-Aziz bi Allah in 380 AH/990 AD, but he died before its completion, leaving his son to finish it in 403 AH/1013 AD. The mosque is located at the end of al-Muizz Street in al-Gamaliya district, near Bab al-Futuh. Originally, the mosque was constructed outside the walls of the city commissioned by the Fatimid Vizier Jawhar al-Siqilli, and was later incorporated into the walls that built by Badr al-Din al-Jamali (480 AH/1078 AD).\n\n          The main ent', 'cairoEgypt', 'clear', 'medieval', 'camera', 'all day', '1712329733774.webp'),
(38, 'Bust of Ramesses II', 'This colossal bust of Ramesses II is one of the largest sculptures in the British Museum, but it is only the top part of a much bigger seated statue of the king. The bottom part is still in the Ramesseum, Ramesses’ memorial temple on the west bank of the Nile at Thebes (modern Luxor). It offers the opportunity to study several different aspects of kingship in ancient Egypt, including the connection between the pharaoh and the gods.', 'British MuseumEgypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712330096198.webp'),
(39, 'philae temple', 'The monuments of Philae include many structures dating predominantly to the Ptolemaic Period (332–30 BC). The most prominent of these is a temple begun by Ptolemy II Philadelphus (285–246 BC), which he dedicated to Isis, the mother of Horus, the god of kingship. A scene in the mammisi, or birth room, where the birth of Horus was celebrated, depicts Isis suckling her son Horus in the marshes.', 'aswan,Egypt', 'sunny', 'ancient', 'camera,drink', 'from 7 am to 4 pm', '1712330453290.webp'),
(40, 'Muizz Street', 'Al-Muizz Street is named after the Fatimid Caliph, al-Muizz li-Din Allah (341–365 AH / 953–975 AD), who first founded this street. He is also the founder of the Fatimid caliphates in Egypt since he ruled Egypt in (358-365AH\\ 969-975AD). Today, it is the largest open-air museum for Islamic monuments in the world, and a unique heritage site that was added to the UNESCO World Heritage List in 1979. The street has borne many names over the centuries, and in 1937 it came to be known as al-Muizz in honour of the founder of Cairo.', 'cairo,Egypt', 'clear', 'ancient', 'camera,drink,pets', 'all day', '1712330738825.webp'),
(41, 'Statue of Ramesses II', 'The Statue of Ramesses II is a 3,200-year-old statue representing Ramesses II. The statue depicts Ramesses II standing. The discovery was made in 1820 by explorer Giovanni Battista Cavellia in the Great Temple of Met Rahina near Memphis in Egypt..', 'Grand Egyption Museum,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 5 pm', '1712331506283.webp'),
(42, 'Siwa Oasis', 'Siwa Oasis seems to spring out of nowhere, its lush, green orchards glistening like a mirage in the surrounding barren and inhospitable desert. More than 300 freshwater springs and streams sustain this remote desert oasis, feeding 300,000 date palms and 70,000 olive trees.Huge saltwater lakes add to the spectacular scenery. Isolated on the edge of the Great Sand Sea, Siwa remained unchanged and largely unvisited for centuries. Roads now link Siwa to Marsa Matrouh on the Mediterranean coast and to Bahariyya Oasis in the southeast, bringing an influx of tourists to the area.', 'Matrouh,Egypt', 'clear', 'ancient', 'camera,pets,drink,food', 'all day', '1712357633676.webp'),
(43, 'alexander', 'He was born in 356 BCE at Pella in Macedonia, the son of Philip II and Olympias (daughter of King Neoptolemus of Epirus). From age 13 to 16 he was taught by Aristotle, who inspired him with an interest in philosophy, medicine, and scientific investigation, but he was later to advance beyond his teacher’s narrow precept that non-Greeks should be treated as slaves. Left in charge of Macedonia in 340 during Philip’s attack on Byzantium, Alexander defeated the Maedi, a Thracian people. Two years later he commanded the left wing at the Battle of Chaeronea, in which Philip defeated the allied Greek states, and displayed personal courage in breaking the Sacred Band of Thebes, an elite military corps composed of 150 pairs of lovers. A year later Philip divorced Olympias, and, after a quarrel at a feast held to celebrate his father’s new marriage, Alexander and his mother fled to Epirus, and Alexander later went to Illyria. Shortly afterward, father and son were reconciled and Alexander returned, but his position as heir was jeopardized.', 'Library of Alexandria,Egypt', 'clear', 'ancient', 'camera', 'from 10 am to 7 pm', '1712358495419.webp'),
(44, 'nahdet misr statue', 'The Egyptian Renaissance Statue is a large statue made of granite stone. It is a symbol of modern Egypt and the most important work of the Egyptian artist, sculptor Mahmoud Mukhtar, ever. It also has a special significance in referring to the political events that Egypt went through in that important period when Egypt was demanding independence. It is considered one of the greatest statues of the modern .', 'giza,Egypt', 'sunny', 'recent', 'camera,pets,drink', 'all day', '1712359544885.webp'),
(45, 'Ibn Tulun Mosque', 'Mosque of Aḥmad ibn Ṭūlūn, huge and majestic red brick building complex built in 876 by the Turkish governor of Egypt and Syria. It was built on the site of present-day Cairo and includes a mosque surrounded by three outer ziyādahs, or courtyards. Much of the decoration and design recalls the ʿAbbāsid architecture of Iraq. The crenellated outside walls have merlons that are shaped and perforated in a decorative pattern. The courtyards are lined with arcades of broad arches and heavy pillars. In the mosque and the courtyard the arches are decorated with elaborate designs in carved stucco. The roofed oratory of the mosque is divided by pillars into five long aisles or naves originally ornamented with panels of carved wood.', 'cairo,Egypt', 'clear', 'medieval', 'camera', 'from 9 am to 4 pm', '1712359946368.webp'),
(46, 'snefro pyramid', 'The Bent Pyramid is one of the pyramids built by King Sneferu, the first king of the Dynasty 4. It was called “bent” because of its broken lines due to a change of angle, an engineering issue in its design. Indeed, the pyramid construction began at an angle of 55 degrees but had to be adjusted to 43 degrees due to an overload of blocks resulting in instability. Despite their adjustments, the king’s designers made a new pyramid at a short distance, the Red Pyramid. The first angle of the Bent Pyramid suggests the transition phase between the Step-pyramid design of King Djoser in Saqqara and the later smooth-faced pyramids.', 'Dahshur,Egypt', 'sunny', 'ancient', 'camera', 'from 9 am to 4 pm', '1712360349262.webp'),
(47, 'Egyptian Museum Tahrir', 'The Egyptian Museum in Cairo (EMC) is the oldest archaeological museum in the Middle East, housing over 170,000 artefacts. It has the largest collection of Pharaonic antiquities in the world.\n\nThe Museum’s exhibits span the Pre-Dynastic Period till the Graeco-Roman Era (c. 5500 BC - AD 364).', 'cairo,Egypt', 'clear', 'medieval', 'camera', 'from 9 am to 5 pm', '1712361619635.webp'),
(48, 'Amr Ibn Al-Aas Mosque', 'The mosque of ‘Amr ibn al-‘As is the oldest surviving mosque in Egypt and Africa. General ʿAmr ibn al-ʿAs was one of the first companions of the Prophet Muhammad. After conquering Egypt in 20 AH/640 AD, he founded its first Islamic capital, Fustat, which falls within the modern city of Cairo. A year later, by order of the Caliph ‘Umar ibn al-Khattab, he also founded the eponymous mosque of ‘Amr ibn al-‘As, which thus became the new capital’s very first building.', 'cairo,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 4 pm', '1712361964846.webp');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `trip_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id`, `user_id`, `trip_id`) VALUES
(5, 9, 8),
(6, 7, 8),
(8, 6, 13),
(9, 10, 13),
(10, 0, 13),
(12, 8, 13),
(14, 8, 8),
(15, 8, 20),
(19, 9, 20);

-- --------------------------------------------------------

--
-- Table structure for table `scaned_monument`
--

CREATE TABLE `scaned_monument` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `weather` varchar(255) NOT NULL,
  `historical_period` varchar(255) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `availability` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scaned_monument`
--

INSERT INTO `scaned_monument` (`id`, `user_id`, `name`, `description`, `location`, `weather`, `historical_period`, `instructions`, `availability`, `image_url`) VALUES
(16, 11, 'Statue of King Zoser', 'Statue representing King Djoser, the first ruler of the Third Dynasty and owner of the Step Pyramid in the Saqqara necropolis seated on his throne. This statue, originally painted, is the oldest know life-size statue in Egypt and has been found during the excavations of the Egyptian Antiquities Service in the years 1924-25 inside the serdab (Arabic name for «cellar»)  located on the east side of the Step Pyramid and now replaced by a plaster replica. The ancient robbers removed the eyes that were originally inlaid with rock crystal and obsidian. The pedestal is inscribed with the titles of the king and his Horus name Netjerkhet «His body is divine» in hieroglyphic text', 'Egyption Museum,Egypt', 'clear', 'ancient', 'camera', 'from 9 am to 5 pm', '1712090945845.webp'),
(18, 11, 'Sphinx', 'Huge statues are one of the distinguished features of the ancient Egyptian civilization. The Sphinx is the most famous of them. The statue was carved in the rock of the same area during the era of the Fourth Dynasty (2613-2494 BC) that makes it the oldest.As the ancient Egyptian sphinxes represented the king with a lion\'s body as a clear indication of his strength\n\n ', 'giza,Egypt', 'sunny', 'ancient', 'camera,pets,drink', 'from 7 am to 6 pm', '1712092257002.webp');

-- --------------------------------------------------------

--
-- Table structure for table `search`
--

CREATE TABLE `search` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `keyword` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `search`
--

INSERT INTO `search` (`id`, `user_id`, `keyword`) VALUES
(1, 0, 'pyr'),
(2, 0, 'pyr'),
(3, 0, 'pyr'),
(4, 0, 'cairo'),
(5, 3, 'cairo'),
(6, 0, 'cairo'),
(7, 8, 'Amr Ibn Al-Aas '),
(8, 8, 'Amr Ibn Al-Aas ');

-- --------------------------------------------------------

--
-- Table structure for table `trip`
--

CREATE TABLE `trip` (
  `id` int(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` int(255) NOT NULL,
  `num_of_reservation` int(255) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trip`
--

INSERT INTO `trip` (`id`, `destination`, `description`, `price`, `num_of_reservation`, `image_url`) VALUES
(8, 'Gouna  10-Aug', 'the town\'s location offers good access to many of Egypt\'s natural wonders, historical sites, and archaeological treasures. The ancient temples of Luxor and Aswan are only a ride away. Day and overnight trips to Luxor, Aswan, Cairo, and Sinai are also easily arranged from El Gouna', 700, 7, '1710388167446.webp'),
(13, 'nile 20-Jun', 'Nile River, Arabic Baḥr Al-Nīl or Nahr Al-Nīl, the longest river in the world, called the father of African rivers. It rises south of the Equator and flows northward through northeastern Africa to drain into the Mediterranean Sea. It has a length of about 4,132 miles (6,650 kilometres) and drains an area estimated at 1,293,000 square miles (3,349,000 square kilometres). Its basin includes parts of Tanzania, Burundi, Rwanda, the Democratic Republic of the Congo, Kenya, Uganda, South Sudan, Ethiopia, Sudan, and the cultivated part of Egypt. Its most distant source is the Kagera River in Burundi.', 300, 6, '1710389205755.webp'),
(15, 'Bedouin Camp 27-Aug', 'The St. Catherine Bedouin Camp is a desert encampment roughly 200 kilometers north of Sharm El-Sheikh, Egypt. The camp is at the base of Mount Sinai, and serves as a departure point for desert safaris. A number of shows (including the Tanoura dance) take place there.', 400, 19, '1713278755711.webp'),
(16, 'Hot Air Balloon Ride Over Luxor Relics 05-Jul', 'Fly over Luxor\'s West bank on an early morning hot air balloon flight. Soar above the Nile and see ancient landmarks like the Colossi of Memnon, Valley of the Kings & Hatshepsut Temple', 550, 7, '1713279286367.webp'),
(18, 'Marsa Alam 18-Sep', 'Experience the best of both worlds on this unique horseback riding tour in Marsa Alam. Embark on a thrilling journey through the Red Sea desert.', 900, 10, '1713279835093.webp'),
(19, 'Sharm El Sheikh 09-Jul', 'Embark on a luxury snorkeling boat cruise and stop to swim and snorkel in the bright blue waters of the Red Sea. Enjoy an onboard buffet lunch and soft drinks all day', 1200, 15, '1713283274083.webp'),
(20, 'Fayoum 11-Jun', 'Get beyond the Cairo sights on a full-day, private tour to Al-Fayoum that explores nature, history, and wildlife in an ancient oasis. Visit the salty, scenic Lake Qarun, then explore the collection of Roman-era mummy portraits and statues in the Fayoum museum. Discover a series of waterfalls in the heart of the desert at Wadi El-Rayan, set sail on a traditional Egyptian felucca, and dine at a local restaurant before returning to the city.', 800, 18, '1713284376218.webp'),
(27, 'gggggg 07-Dec', 'Get beyond the Cairo sights on a full-day, private tour to Al-Fayoum that explores nature, history, and wildlife in an ancient oasis. Visit the salty, scenic Lake Qarun, then explore the collection of Roman-era mummy portraits and statues in the Fayoum museum. Discover a series of waterfalls in the heart of the desert at Wadi El-Rayan, set sail on a traditional Egyptian felucca, and dine at a local restaurant before returning to the city.', 800, 20, '1717619308656.webp'),
(28, 'gggggg 07-Dec', 'Get beyond the Cairo sights on a full-day, private tour to Al-Fayoum that explores nature, history, and wildlife in an ancient oasis. Visit the salty, scenic Lake Qarun, then explore the collection of Roman-era mummy portraits and statues in the Fayoum museum. Discover a series of waterfalls in the heart of the desert at Wadi El-Rayan, set sail on a traditional Egyptian felucca, and dine at a local restaurant before returning to the city.', 800, 20, '1717621860862.webp');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` int(255) NOT NULL,
  `mobile_num` int(255) DEFAULT NULL,
  `role` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 -> normal user\r\n1-> admin',
  `language` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `user_name`, `password`, `age`, `mobile_num`, `role`, `language`, `currency`, `token`) VALUES
(0, 'roaamahmoud@gmail.com', 'roaaaaa', '$2b$10$nwM7kymQqCjr304gfICrJe.bMWYho8G97Cv2WeWzUGDj893S5.Js2', 23, 1234569876, 0, 'english', 'dollar', '4b90267c6239a9b582919e2eeca63490'),
(3, 'admin@gmail.com', 'admin', '$2b$10$iXNieKPVzWLA3Fct2CCTiusPgX3dTuadoFDBarFoshcKwoqM0wWjO', 21, 1234569876, 1, 'Arabic', 'dollar', '7aa519a63213fef5c39b3661876170cf'),
(6, 'zeinab@gmail.com', 'ZEINAB HOSSAM', '$2b$10$kFf0bLcAWm3WtSk9/UkoseMw20wKBvYJJ67UHkdJLTpcj1MgkD3Ly', 23, 1234569876, 0, 'english', 'dollar', '539bf19dc28301d011c40084fe9ac7cb'),
(7, 'aliahmed@gmail.com', 'ali ahmed', '$2b$10$p/Az1UIsHkQrqKRUEiSbG.EpA7EhhduWQIDzfCBD5veWBacfXw16e', 23, 1234569876, 0, 'english', 'dollar', '20b41ba22ede92af7dc4e552959fd74e'),
(8, 'amrahmed@gmail.com', 'amr ahmed', '$2b$10$m/wLHT55gYgNa4ESc6Rs7eCftu2iOAph35lvc.8agTs6BdKy60nVe', 33, 1234569876, 0, 'english', 'dollar', '2b11f1bc41151f307fb99834e9e55cd9'),
(9, 'hadeerahmed@gmail.com', 'hadeer ahmed', '$2b$10$AcO3t1jjMG/2jqgijtRw.OlaqLZWIzXlGlHjZFKnTHY.oP88XyuYG', 33, 1234569876, 0, '', 'dollar', 'f1882b3b5c1abe8b7d24e0d3044b801c'),
(10, 'faridaahmed@gmail.com', 'farida ahmed', '$2b$10$gGUPzIEi1Y2DkC.tPStEIONdSa.67tkwJXZwqlv03Rkqv1vDfoa3i', 33, 1234569876, 0, 'english', '', 'a005d0c2c6b765ac058235014268d15c'),
(11, 'ahmedmohamed@gmail.com', 'ahmed mohamed', '$2b$10$rInBHcgtKnmvv4bpjlOn3.7VmmqpebFbzEplV7qqD/Bq8tFFGWblC', 29, 1234567891, 0, 'english', 'dollar', 'c43ea0a3d387023e9cdb95fc91ec4383');

-- --------------------------------------------------------

--
-- Table structure for table `user_action_on_monument`
--

CREATE TABLE `user_action_on_monument` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `monument_id` int(255) NOT NULL,
  `activity_type` enum('save','search','scan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_monument_review`
--

CREATE TABLE `user_monument_review` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `monument_id` int(11) NOT NULL,
  `review` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_trip_review`
--

CREATE TABLE `user_trip_review` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `review` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_trip_review`
--

INSERT INTO `user_trip_review` (`id`, `user_id`, `user_name`, `trip_id`, `review`) VALUES
(7, 7, 'ali ahmed', 8, 'my family go this trip and it is very nice'),
(8, 7, 'ali ahmed', 13, ' very nice'),
(9, 6, 'ZEINAB HOSSAM', 13, ' very nice'),
(10, 0, 'roaa mahmoud', 8, ' very nice');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `monument_constr_id4` (`monument_id`),
  ADD KEY `user_constr_id5` (`user_id`);

--
-- Indexes for table `monument`
--
ALTER TABLE `monument`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id7` (`user_id`),
  ADD KEY `trip_constr_id7` (`trip_id`);

--
-- Indexes for table `scaned_monument`
--
ALTER TABLE `scaned_monument`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id123` (`user_id`);

--
-- Indexes for table `search`
--
ALTER TABLE `search`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id2` (`user_id`);

--
-- Indexes for table `trip`
--
ALTER TABLE `trip`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_action_on_monument`
--
ALTER TABLE `user_action_on_monument`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id` (`user_id`),
  ADD KEY `monument_constr_id` (`monument_id`);

--
-- Indexes for table `user_monument_review`
--
ALTER TABLE `user_monument_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id3` (`user_id`),
  ADD KEY `monument_constr_id2` (`monument_id`);

--
-- Indexes for table `user_trip_review`
--
ALTER TABLE `user_trip_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_constr_id4` (`user_id`),
  ADD KEY `trip_constr_id` (`trip_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `monument`
--
ALTER TABLE `monument`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `scaned_monument`
--
ALTER TABLE `scaned_monument`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `search`
--
ALTER TABLE `search`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `trip`
--
ALTER TABLE `trip`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_action_on_monument`
--
ALTER TABLE `user_action_on_monument`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_monument_review`
--
ALTER TABLE `user_monument_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_trip_review`
--
ALTER TABLE `user_trip_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `monument_constr_id4` FOREIGN KEY (`monument_id`) REFERENCES `monument` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_constr_id5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `trip_constr_id7` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_constr_id7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scaned_monument`
--
ALTER TABLE `scaned_monument`
  ADD CONSTRAINT `user_constr_id123` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `search`
--
ALTER TABLE `search`
  ADD CONSTRAINT `user_constr_id2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_action_on_monument`
--
ALTER TABLE `user_action_on_monument`
  ADD CONSTRAINT `monument_constr_id` FOREIGN KEY (`monument_id`) REFERENCES `monument` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_constr_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_monument_review`
--
ALTER TABLE `user_monument_review`
  ADD CONSTRAINT `monument_constr_id2` FOREIGN KEY (`monument_id`) REFERENCES `monument` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_constr_id3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_trip_review`
--
ALTER TABLE `user_trip_review`
  ADD CONSTRAINT `trip_constr_id` FOREIGN KEY (`trip_id`) REFERENCES `trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_constr_id4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
