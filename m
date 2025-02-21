Return-Path: <linux-kselftest+bounces-27135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A98A3EBCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 05:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751DE19C55F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 04:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFC1F9AB6;
	Fri, 21 Feb 2025 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M3WDFcjJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhnCUkOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CD17C9F1;
	Fri, 21 Feb 2025 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111676; cv=fail; b=RToCafl5QJJ+4+HSz0nGN3lnzVRtwRJYl8u+xi7z5XGWvd7Cv1SyW6ssVqAYC+4Rxmg0LOKX+1KZGbujnTIaBaoRZWT5pyHLO/7Z5OccuWWB+aaU9dLxGAxRhbp/Xry9CNYS8NKi/75jxE0zTUz1PIotpg66BM75bQ+4cX8gowA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111676; c=relaxed/simple;
	bh=ALN//A3oE8zCnveJjeBY6bjDoYpWjcTTm/DXDOPL5vA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hI06XSGBalvvdE3o/nW+WPtK830GDxsE6jpbtNFIXkE6z8KsEwwHsDgHpxN19fuevvq3ew0PJM7jJ129reBZNeCixGVIcHeF0bVVtM9FiWJzhpRXJJWH6q1034acVopk0LJF2xbhmI3Zq/gdGJKa0oPahAXgI0mjRxTySn41nk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M3WDFcjJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YhnCUkOl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLrZNK016236;
	Fri, 21 Feb 2025 04:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hJZ1lLsHKRuA+YrpOWSrDSA+0q7wbcvBGTPsXP7EyMc=; b=
	M3WDFcjJkKuRmj6s6BVaDza4pAKV110ik4l7wZffoRcwI+KMLH8YtgvDNVipfjSh
	bxMku1b0uXTICKfBWHH2ecMTJ2xRtyPy9ooKcpqBxp15Xc+Y+RIUtNePOOcdKuB/
	XkA8eI+RB7zWRVo8fZDFP8uequFKkvn00jj7BWStzhYpr5+ascUv02ynCNzwzW+m
	cBLDv3E8KBvk262MaVK05sJU5bOfrwoyEbtmEUVegZYw/xIl2eYmS1LGHbWj1QDq
	3bT4VHz63GuOvSyr3LDSTlsgCWXoK+sKr/Q5x7ZY3Wil35yTL8F1+6lvNoMNEvmd
	AVvUkgb0lu60AX8xJ6wsnA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02ynjar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 04:21:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L2Xkpg002176;
	Fri, 21 Feb 2025 04:21:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tp677c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 04:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu+VEeoDk7nXqNPG/UAu+XRIvfHfSaqPK2df9EVXWbveKSAj1dD6LJRq232h95EJ4S++g0ESlHHlBXT6bTokTRgzHstkAWVJu19lJLn9zY4ZBZlDNet8csYl5pmODKgEbbLHa6PyDprBxUs0xH9wF9c+EX0av29pANW3wVZMEv0rD8S6LMEgaEKL8wZrJ4IqtnXRbFT7hKwIWxgWegpaWbn+1S4zApLmcI0W5wUlPayoCOMhakUYEffmoQj7IrgYA1DqNpUhJedVt4pa8ZbucfbuwNjX6xQdTbRWjQ/Qd/4Tu7xy77+oeANFyeZdjMY19VVhj7opqetnwRt4+qMZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJZ1lLsHKRuA+YrpOWSrDSA+0q7wbcvBGTPsXP7EyMc=;
 b=L8rm71MUfSn5SpD0Oz9P8Ww8CblfllRlCLFNZ8EKxavrSPhkXpDDTsRqygzwpUKJ/tXiHmj8fOkLA8U+Jfri3IOEf6jbYd9V2c5LgM61tfXLOGeeJrUJ/9jqEwbr/2iFEWf9ELAzm5d3KqfDe1mrinG5G/LH0R676V0RssSNnEbKtRE1fSWPlTchwqboT2oXTTgM2ybyqOOLxYv+x8Y+aCAE6cX3SA1ppPbo1kZzhE+ubB9fSZzR6o9VGiwP0eLfaq83FGvsdsicQeIEP1hlIMgdN5gvQXqMY4m1OTDNlJmWC318WYZuQT39HU449GoHtYbqvWqX0o6uDFmpk0rfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJZ1lLsHKRuA+YrpOWSrDSA+0q7wbcvBGTPsXP7EyMc=;
 b=YhnCUkOlvtI3l1cHY7Q94wh19ZKYhVrU9yihuC7cZatVZUgW8lHME9QdrC2r14DwLTVULkC1FJShAaZimvhJy47HTsimv/L2084xMzI6oN82IDOHsaKqtuv9nIqsdGkNdmph06Ucy8KTrPQch/3HWFanIRB58U00abwibZtQhMs=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 04:21:06 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735%3]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 04:21:06 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Sinadin Shan <sinadin.shan@oracle.com>,
        Shrikanth Hegde
	<sshegde@linux.ibm.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Topic: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Index: AQHbgpobAwexZNUbBkmXCDWzivovC7NP0a4AgAB3QoCAAAjatYAAELEAgADHpzM=
Date: Fri, 21 Feb 2025 04:21:06 +0000
Message-ID:
 <CO1PR10MB47051B268FCBD44E24B281439BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
 <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
 <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
 <0d22f89a-d896-44ed-b4a9-c860c63450fa@oracle.com>
In-Reply-To: <0d22f89a-d896-44ed-b4a9-c860c63450fa@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_|MN0PR10MB5958:EE_
x-ms-office365-filtering-correlation-id: 82e9dbce-70ce-4b4a-c0d3-08dd522f2915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cKrJv2UnudFAjAvEGYEmWoI3h1tELUZH2wM46VayiS16iKDZhLjubz0CkM?=
 =?iso-8859-1?Q?2BMywSVJSn824FjuoyeXnAd8C8rkPfMp7za0MipmKq1yo7xdcwN34o9/t1?=
 =?iso-8859-1?Q?iNi2UgFaFQ+4tt2Izf3pbbjG1AyH2m69JK10Ejb5lRwODSWQZH8K2W1vU/?=
 =?iso-8859-1?Q?7uyC5661UhijChYdFRNdToPNyKG69UGcqbxfuID5vu5k+t6JJGIR1T0J2w?=
 =?iso-8859-1?Q?SuQhBMF5+DuweJ8QGcOvixSZezoXopPX7pmc5KNXXpOioXjwJUI8sPWNuL?=
 =?iso-8859-1?Q?sBB55YEI+ecX6MDLYy/tdOUcR94c6lkNYwpRzYtRlSjn1cKQhJTjZAegNv?=
 =?iso-8859-1?Q?OF6qok0uKvbs+elVHrbqzuQPAbhuAExcWynwzoVrRjpzSzHMbBYuz7dhyR?=
 =?iso-8859-1?Q?ck4olv4NX5sOMli3qtTTgKB8CvAi4ldg2QQfPhdBuhAGE1AQxCVM/wHgQC?=
 =?iso-8859-1?Q?DbzVXPqDrqmsYdsHDv61QT34pwd/liP5FtZCUmGtrKj91QoA2i/mZh+Dyh?=
 =?iso-8859-1?Q?A6nYKCL1vK4ezIG6bLqASOf2zyegTD7xzUZfRnaMf8/MFguNzJhtCux9Pm?=
 =?iso-8859-1?Q?NiZff4L0T1IkYSxnZHyuPbDduMmeom/g0drDC+0zriKmXnz3LXAR6HWNu9?=
 =?iso-8859-1?Q?bV9XukNlW0mqi5LYWZk5WweIS4LAsb3ra/G5uvekX0W9GJnvs6ccm+8Np3?=
 =?iso-8859-1?Q?0QHwG0wpcwq7mzF1oKIXpWevVr/11QWHvxgXizEV5CB8Gb4P7ygKvvDa/J?=
 =?iso-8859-1?Q?nP+gnVbWefVjT2O3EzYqZcwzR2PDarw7fISIRog5CBxNygFdnw+Bkp5pau?=
 =?iso-8859-1?Q?AJMVPSfx/PgiLyvKo34SERhMpAAkyqVfLAmcaSphrPOZBDZ8AiNs7/zCgs?=
 =?iso-8859-1?Q?jc8BSJSIwRlxVYd5w29XDptI8uxlRQgbwWoLJQ67YsVzjklgzpVX5r8eJg?=
 =?iso-8859-1?Q?kgLftljvj/C7iy2gCiqQ+3Ryv15cQdF5xoRJR+NdyCgS43TkgVUh2tsXfB?=
 =?iso-8859-1?Q?wlBKSFKJ4NMNRePohgMEnFd5Y6g87BhP4EoBXiUdo7xLkP2RxfwtcZIwKN?=
 =?iso-8859-1?Q?qlrSceF764kaE3cJ4dPNRCuP//8TI0bGCoosreUMBSgbKSoy06MmlZH/Bk?=
 =?iso-8859-1?Q?z/ET64mJkJ2jG8wV/FGPqzTrylvPDCht82Z1YR0B+geIfXEynCUu0FUoWU?=
 =?iso-8859-1?Q?4dp3bnQrlVpVFfTdaTW639B5HuBfmuNiAfMGYkAC9+G7O3+TqLD0zQvyYS?=
 =?iso-8859-1?Q?EY5jyJ3uOUXLUC2cU4StIB+PAb3i/hUnY9NHZ8hk43ZXOGaMAhgp+Sfjzd?=
 =?iso-8859-1?Q?Kh3Jt//cS37Gyxcz6VGAkgbXuKUVCphkD+UJJTONUsCjC6GrcrbqyDJ36y?=
 =?iso-8859-1?Q?IuvJcY/AUOZ+G1Mcyi9ArwNCadWycS0+Fah7mSwUGWaZNwg9LIzPxGZVTT?=
 =?iso-8859-1?Q?r8XQcT8M/OOonQs5B4UI42eyWkHlgSYkEUqwwO25zaRbgM4l2HZY2abEVG?=
 =?iso-8859-1?Q?hkyOGlji8AIQBC0E5vgegD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OqgZ+5mh0nsBeYqjHw+dX9efOZsFbiVjsnpQjjDjbHCWRs6G4QCNgTCCNK?=
 =?iso-8859-1?Q?TljeLG8Cib+mogvBLhVzwVJpjC9El6yOMPJnf0KE2Rioi9afruN1DUl5q9?=
 =?iso-8859-1?Q?S7bseQO8RpCLnT9mMIFwbK0Jnu7bken3iossWlOEWjPp1pvxSGqDASFVWX?=
 =?iso-8859-1?Q?dgqbnqaCQ1xyDhxzXUyNSNH6F/Oujjg1vMa7WLCtpgah0q9t7IGqSkKR6v?=
 =?iso-8859-1?Q?Jqi+93+6x3xPzIhP0eMzz/zhjTWXAXLr35D2OaR1CDxq4sL2medmW+PWyj?=
 =?iso-8859-1?Q?cvO2nFPLOEvrncoMWDiLa7NF5qPUHOtQD0BFe9QcmpEhgPH9FPcjvfZR/E?=
 =?iso-8859-1?Q?fVk3nH1ZO6DJ/PhAA063vZ89xUZi57rPjofGG8t9FlTCZPaY5l5w+wikPY?=
 =?iso-8859-1?Q?ILv2BrH2uVqbEylPlkQ3EHWFARY1lrAUktyGi8jRtaZy6/kFGV82L6yA0o?=
 =?iso-8859-1?Q?8UktOF9eD/dDvE8ytjAyKN9mctDJHx+tDULR7Jew2sZp+Vaa5XsyPkvFGu?=
 =?iso-8859-1?Q?slx+OiOnraVdm5ft1pIUUBMVGYYLzAuA98gqkvp7DcW16xoC6aRSF7ePaw?=
 =?iso-8859-1?Q?TaNS7fiAL6YB+znyhQOpnULOiQRadFU9piGYVi3detGV+E58FqTLbX1Rgm?=
 =?iso-8859-1?Q?dYG+YfAr4R9q0lgpIN9gBoX1IMDx8sKjBHCztWY0tk2oCrTsVCS8rTGNqJ?=
 =?iso-8859-1?Q?WTFDBvBqcZm0F6fZm2qid92zOGBTeJgSzGqa0RhWrKf42MFtOqLn1bI4Mf?=
 =?iso-8859-1?Q?FXtucKw8kgUFBNf26rPliRhuyw8xTBHlLhXJF4XM5jZlT3Da2JpaqtSMRH?=
 =?iso-8859-1?Q?MWkPRA5q43c07D467CWSdNc9l+lPjo7S2YtnFZdVPZN5pRvAG6hdDOEtRn?=
 =?iso-8859-1?Q?vhsA7kKiFH8NpNdBvQtUnb2F3nuUkwbd5vg96ivfjwnQRDVOVYYjjOdNDv?=
 =?iso-8859-1?Q?HAUKrf+lvaj/YFHlNUbiold4uAvNLhklKgUwsTQRCF2Z5yA+3RrTWGVqEm?=
 =?iso-8859-1?Q?MPZeBwkRzSnDKiTXo+86tQ1G+b2BBXaNEPmQXx7k2mW0wl84UWTD/BLGGy?=
 =?iso-8859-1?Q?CuQ1pIinR2cLihFUaIyXNXXeLk//pmBUvKwWIgq9JAuTIZktb+fdWOvR+T?=
 =?iso-8859-1?Q?6V5Ws7f+0f1VTrNY8lv0wLW35sDXu1mlamodRZMgeRoHt7mERpgqinh6eB?=
 =?iso-8859-1?Q?zOZRzd4qVad6Hregk2b0NEMGxNh1GACaZwQAAx8vmQ7izT1DFFt4sT1t00?=
 =?iso-8859-1?Q?1eVIxK33dl61Pyri8CJ0edEQZ//nqGqIhKmxrD8eCdO8kOoarxoXWwApsD?=
 =?iso-8859-1?Q?2BEQdVmRG9tBpqID1mW4rn4kPdCcniNbzw6OwTioec8Z5wLSqNRLai0Oqs?=
 =?iso-8859-1?Q?fG+lk6W/EipOYletvWk+huTyYbhFJNXitPwmcqeum+gpQhWqBFAh2Y62KY?=
 =?iso-8859-1?Q?2kyYtkfEJRFu1BhTnJ44B+rFFt9uHJyIFoY5p5s0tSxoAmzoz31znVkgFb?=
 =?iso-8859-1?Q?Ng/ZP0yMtvDsYDAKknojEZSWL4/8c0erDpRdJBdGtJNizuD4S6WH2+6bfh?=
 =?iso-8859-1?Q?qaeUebG3w5eZRLxJ6SxQMlnK6Q/WuW97TPXKS3i/7Zq93YCxQzfSzdl8EJ?=
 =?iso-8859-1?Q?vVjFUx3AtmwCenFC/75Pl3TJIaNVb2kbLn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l1U6NXtMF7uS9WUFzmRix/hfzTWy19KZLIj/5d/iqzhcbwHd9/7OfdE9sNTuLTDrbmNC89J6gWYzocgXjVquCnWeV4Huk32ctlWnZrOqVEz1hv3aJNHiMM9qCIAE/YIhdvyBYOJrG1DDFgkxlP8PIH74mG7vqJ5g17B13I6ShQypuuBG//YcxrTMW9hUl/r3cE53tG9BlCUwzANVnlqoSbMP7ey+1LVET+Y86O63atbseUXIf7YoTugExjoxKpYjWrLzRX+r9uGvEhV1/EhBCuXfun8uBgoTmgJrPFhgT8ZyYupM/sxRgTMjBwbeT1xVoO10P7HujTtQ+ncfpvgx4BoOhCpkrYnwUVhS80trXV6YL0zDoE6Kcb/QEyXf0l/f23uZ/MFUzKpY0bEiy5eHfVK/brACgVs8wL8s7H/Cf1TVohIAo5ofjAbLVj/fwlheEXC5NjA7J6EzG3z0cXsyj0NSSvIedswLLjP6ZX6a8JtlsBcjf1quRaGQQMLjS354s0wvacKR0VPsZbbuusQMlXilQtKybGg+0sqT7mjeQO+J7yKpL3YwEH/3fWKf393y9qezvR6r3w7tZfC0KeWsvMvo3+bS2gTAe2RJOhWXhNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e9dbce-70ce-4b4a-c0d3-08dd522f2915
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 04:21:06.2536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5Gmuhuf9Uwiw2JHlinX+oSfK9seyYxl4j8m+1uDP3MDTxsZAELuHwH474O8LuK0+SMuc9wAlGqVmQ8LSpFRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210029
X-Proofpoint-ORIG-GUID: iOwPj6Cf_DUIs5ch0f2B8-J8PEQbFmGR
X-Proofpoint-GUID: iOwPj6Cf_DUIs5ch0f2B8-J8PEQbFmGR

From: Sinadin Shan <sinadin.shan@oracle.com>=0A=
Sent: Thursday, February 20, 2025 11:23 AM=0A=
To: Chris Hyser; Shrikanth Hegde=0A=
Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@ke=
rnel.org=0A=
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest targ=
et=0A=
=0A=
>> I guess my question is what if SCHED_CORE was supposed to be configed in=
to=0A=
>> the test kernel?  Silently burying the error might be bad. I'm not stron=
gly tied to=0A=
>> that, just looking for opinions. At the same time, if you put the orig c=
hange in,=0A=
>> people w/o SCHED_CORE on will start seeing "failures" they didn't see be=
fore,=0A=
>> yes? and that seems bad.=0A=
>=0A=
> Yes, that seems bad as rightly pointed out by Shrikant. I have a patch=0A=
> that does the above mentioned skip, and if skipping is a right option to=
=0A=
> take here I can send it in the next version.=0A=
=0A=
If that is the plan, I prefer to fix it myself.=0A=
=0A=
-chrish=0A=

