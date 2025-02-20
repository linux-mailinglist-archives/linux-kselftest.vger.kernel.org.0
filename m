Return-Path: <linux-kselftest+bounces-27084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C62BA3DF8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D13E188A794
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C121FFC71;
	Thu, 20 Feb 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajEVtC+a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8rYoyFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5851FBC9E;
	Thu, 20 Feb 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067018; cv=fail; b=RrRHTP/qQnCpQQn+jdfyJD80p2iSzJOD20uLeAn/49wXst0uSlEY3a338l6TO6ra51KjCa7Z9UzSoUnwQxTWiGFwBh8rIGhMKKqz9RvgvsGQ0bzmfVa2MvvWrGN/7F/3RMMi9wGaiAUQwyZ7WLBHFo0GL9wqb5Z3p9+mDZgA9fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067018; c=relaxed/simple;
	bh=4RJmxZlcV1cQdQCajVk5VcTcuiV63l84FObNDrRA8ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBj0fJIgwtk36cSyZ/Cew3zGDmWpzCQFdoPm3KNPxQ97pWMHvILsYq3wHWkxoVTwyJyqAI2LPCiqIgSbaIJAKPAQI4Hww+uLmjXT50GviPt2Q2YBfUVO5okD+p9m5sxPp+kpM4a9m1GprWI6EF+8lPkNBjiKJBx7yoeh/MpQG5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ajEVtC+a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F8rYoyFg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMdUp012624;
	Thu, 20 Feb 2025 15:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TCpvx7CgXpXKj9w2uEz3KZfqK0zaFHO8RTqMRjgXFF8=; b=
	ajEVtC+aOBtSyIYFZ09WtKuYyKCzgW3ULi6AaXZ+hkkqVo9ghuXToxiy3RpkKepj
	jBKRksRVoJodtApQzeD9G5RDfR4rwJjOsqudEoJDXYE72oyCMHXeazULKshlYCpN
	XD4eJsq5xoFr2MNROJdjRye+o6v95tuJHYNMdj0yGUQQqkjBOzF9nxMnuLW1dlZv
	G7ln4yKcvbTqj8aXjqGGvYEvjKMqppsaIaNe38fls7ijEZOdc/PrYN7xHIu8cw0R
	1iDEG4B5kRkMrCPFh6nFLbT54AWDtT09XkYnU9UEv1Jg5bF+yE4VnIQF+xHZfYL5
	wdFJdB9RP/kYKpLq8RQVFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nmde6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:56:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFfCC7025288;
	Thu, 20 Feb 2025 15:56:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08y32nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXM3C7wpRFN8+hGKyjHMEEnHtYgN1JBx4iZS2tPXa1TfunXSB8LL2O8awKA6EZZi/aHoNBKpPrKEGm3CnK6K2LRgZ6uhh/ElyOLH8Y7s0bRvklZj865241mCqhfJQW1J5o5xSMFsUucA/dqjMp5v3eDRKQ6M4aV3DoHjzV/CyhIoaGDQJzkL5FvfqwshaRLDAUg78YTiLZVHwIMRQk2Zd1sFpZBUFY9+3ODJ3cSj7sW+ihJ7nuKGAQ9AfRyE8u+sYAeCTBwmPygqFJhLSERW8OMjCpj540dNjk/jWikXJsjjecOsUEorM+3Jghb7eDNfXWvvQAFY1fisVjhlFXK7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCpvx7CgXpXKj9w2uEz3KZfqK0zaFHO8RTqMRjgXFF8=;
 b=Rg3rvK7u0HYXkPiHUQ4WD705XROZ/6mmfwjzT4+zEFFvPwaI4wvIxSlE74RwGGNXBSiHp4IUXBhmlcxlnezFYAZmW8mzKKUERL1RZVofp0N8CgGJd0hthxN2iXAvTl9OwrtUlPmF/K/g4dgE1PFlvDbgY2gYVfqBmTyVz6vuI1oiT+TaKYg69oNlNjNRNINY2YB2FpFzAKfizHl9GCvr81KbBR2iMU2DDLe3eg1qVdkp8MFhGojJQnbXbfwfb5L6VeWv5w/UHfOCPqBlaINyoBoGm0kTBWgcJCgVUMvnTcOjLXS8j5P65dmXcvZIfAoXCFEDXe6tIS6Qu1k2IH4l+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCpvx7CgXpXKj9w2uEz3KZfqK0zaFHO8RTqMRjgXFF8=;
 b=F8rYoyFgS7hv6otDZGpP+jpfmr+JIqiVv35f3SnPqny491PmCO1gNtCMwYI/3eiJ56I2S16/88f3/yDYJNXw2TxNRoK5H61TBRA/T8ki28WOxfoyXetXn+xII7X0RZ9xe6MANdFT5xFDCFD6GqTIASzbBldXS13KPpZ8n/jM8WA=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 15:56:43 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 15:56:43 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Sinadin Shan <sinadin.shan@oracle.com>,
        Shrikanth Hegde
	<sshegde@linux.ibm.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Topic: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Index: AQHbgpobAwexZNUbBkmXCDWzivovC7NP0a4AgAB3QoCAAAjatQ==
Date: Thu, 20 Feb 2025 15:56:43 +0000
Message-ID:
 <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
 <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
In-Reply-To: <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_|MW6PR10MB7552:EE_
x-ms-office365-filtering-correlation-id: c4ff9a0d-240c-4ddf-0254-08dd51c72c37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1LjyZ1TmkHPQcTc1nPGOcHjBJOW77LV2YLPZ7Jq7zdSF5nsGawVoPIFMOx?=
 =?iso-8859-1?Q?5AriBcbzmHwYZBcclc3wFeKZwB6ki9lMc4W3kEu3FxUi9pWGBKeG776CDe?=
 =?iso-8859-1?Q?GKGtiIcg4anaoLSJtBEvAQj6U3Gy0RLuX5uNW/ufemgZB78AJDpub4JZZ/?=
 =?iso-8859-1?Q?Z+JHqdCfgWNEoo/J4ciwdmATHQR4IDB0XPVy2ybqkxD3O6z00NY+rsZEZi?=
 =?iso-8859-1?Q?DME/rbMxNVThOiBoTJ0C3LA13Sa0DGDgii8SDcXKwvZ7JkpvrcZHgFyHBc?=
 =?iso-8859-1?Q?nMuwJbZdmpgO6JwaqK0JyygMc5tBUswnJO4GkrZ9vLsI5z1u+JftHLQRgZ?=
 =?iso-8859-1?Q?oWjFjbvZKHzjx/zYCJ9fQUX3wMhnGvtS6ezyXl7jzlV2jxPpNA6myl5rjH?=
 =?iso-8859-1?Q?BDCY90DvgFq+CqjWqBrTJSujZCQR0zzahVL263fO8it5w93Cb4/iY3Xutj?=
 =?iso-8859-1?Q?sSqgLq3jfcqNox/qQUEfSihYZ6DUD1CLjzhmJRZ55V2hN3VomRqHc7OnfC?=
 =?iso-8859-1?Q?y/Q9ma2EV2CMGr2SkK+wnMbh0grEsX5i8892na33bczWU1H81AeDoqB2ks?=
 =?iso-8859-1?Q?uSXRq8G6nH95wwHFzIB7C7VxzN1FJ4HePOSG3fT9iMcmusbwWZPBUl0YH7?=
 =?iso-8859-1?Q?8vvLYpSeNGY3dEBdmACg5mYGuWhOymdkmCNj9yF2JUY7+q6g4qkkrFF558?=
 =?iso-8859-1?Q?yElRW5/TfrfwDzxX89KaNFEeMzRfbM+mvcN082aa9PclGNNbXU5IriS6uf?=
 =?iso-8859-1?Q?FWEJRkE98TYYXPh5Q9ifM+56dapv0fIE/yzJ3Vq83HSJ+uNSuqQnXYSJWG?=
 =?iso-8859-1?Q?cBhYYCZZIpeB2hK+E3HjvJ6Sf4voUXXHcg1jd2loNx2zXFClhx7Tl8xCNx?=
 =?iso-8859-1?Q?P7kzsPTt3wF+pD1gTtq5uJWULLNvNhrUeUsxD5pLSNDHPn3hivYSEoBK3o?=
 =?iso-8859-1?Q?yQLhF4HiRKP08yUVwMiALPWVTxkIb0zMPJmxVITDDg902FMlEPvZ+SSweh?=
 =?iso-8859-1?Q?VjFDzzJyHKAXSttOJ4g5VHeGdOWNGE7Nd1HRs6KPmMWpcC40vJNnV4PLTb?=
 =?iso-8859-1?Q?4FFMZ6L4lY9d+pTTh9mjxJ/PY8OHyVgh3CbB0cLsICVqSYVVjsKwacoXQ1?=
 =?iso-8859-1?Q?v3AUKvxxx3rGdc0eQPze9rAOX/XggGzWGbjnePXhI3cD3F1oms5uNz7tx5?=
 =?iso-8859-1?Q?LNaFeBsy1GTAWNO/q7xozsxK02b7YeumroE/RdBO/Si+/G4c+KeNuL/RxT?=
 =?iso-8859-1?Q?q7++dP7E2uZe0z3r2ox4v0N8k7b7zz7EypBJTw7rTiqe7tCFTpNceRq6A1?=
 =?iso-8859-1?Q?B2ho8Qq9r9Q67YT2oVkZAoK93bGUGV+I+dsWJ12hSf6GP+uT+VkZ08sE25?=
 =?iso-8859-1?Q?GOIyS4w7g6QbHa6VwEPufqewzAmaGi5B3BjBkkhvj69Fhn41LKf1HCJKOx?=
 =?iso-8859-1?Q?mtvclDvRe0I0Sa82Sb6FlKmSVCv2WQsJRlZyV6mIQpy6U8xhm6JDmy92tX?=
 =?iso-8859-1?Q?lmQ0d4wHTtUXGERL1KGBDX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GBjAj39Sl3e9PPC+H3rwYjh/T3zC2ALzlap8PZ9isCZRmyaIXzHANQibX8?=
 =?iso-8859-1?Q?fPRC/e5NQyH5YfGzCHTPNyCdLaNwpXd1DHFizClS3ZvB4Q91pZcl+j7eUl?=
 =?iso-8859-1?Q?UG45YN0HqVgPS3PIBBpPscBlIbrNpPzkSGYei4ap/XSpzluyTr8C5/wIpq?=
 =?iso-8859-1?Q?fWC8FjZI73YKM3HoBKWhWi/VauM16JHRqvnxUJcxgF//VCMRSBnE+bwKQy?=
 =?iso-8859-1?Q?ZdqRpIptBJfhVjsTbrsWsP98XUK7zJDRARIX8TJJGO9PI9OtDCSdsKeTnx?=
 =?iso-8859-1?Q?70DdkHb39o/BPfU7nZmyumqlav3+P+UKR19FGkfJesEAkh4lgzmg2mI5GS?=
 =?iso-8859-1?Q?cVDb8k32tpnClKi72nPDg9RU3iaPwPFld9bFILeUxmKY4huXyrH4yMIIR6?=
 =?iso-8859-1?Q?6fy2Dn7AXUr4wvOdnySsjrZupRF0VrT7zjtOyGEGyN4xPHcBD+CHI9NIQ1?=
 =?iso-8859-1?Q?oAq9yXBlnuM9n5JqpJ/vHJfYTNq+15GQiIa+UlgNquzk/xwtXrzdYi/a0U?=
 =?iso-8859-1?Q?9oNnYKfAV4ndciQWZts404RwStKI+w3un7iwqz4S7KrVyUyISg2hH20EjO?=
 =?iso-8859-1?Q?sigSrCDcI72KJ6M32gVHVif+7fEFmoFW0K3UnGggmtGZhrhwUcf24j2HsG?=
 =?iso-8859-1?Q?8nhmmreASV5KPAk6RpOHM6ooitGpL0sBG6FomOQ6H34ODemxwnYbjfiJ//?=
 =?iso-8859-1?Q?AbXICxjLzT/AqONSZXCWjNElMorCrRWw5Y5ueSJjtb2WdX4Xyv58ipoqVt?=
 =?iso-8859-1?Q?6DOCT98flT3uIHSpX5piawG7fXKrkB9LdWBB6CxLpeQQaB5D9nqdJiCq6L?=
 =?iso-8859-1?Q?Jpuug+PJekZBP0aEBC8R6Q+upu2NZRzObPvt+MwRc0xmNQkD7M8uKIQyUc?=
 =?iso-8859-1?Q?yGC6asvU1bjVuQV0XvwVVuI/0on6I3tmFESK5eE+t34J/DJRhZyrd4ROEj?=
 =?iso-8859-1?Q?DrB6g0FDhaC9M5WlvvIPkDc5CCZPTcBohThSVBZ+DBCI0/DrBwJhHCSu9P?=
 =?iso-8859-1?Q?TzX8XcTb7OUVeFBU68EVYYiCbw8Vnx8vy1j8ZD4LoophXCEr8YXVHmA1ui?=
 =?iso-8859-1?Q?I9Eheo50wRS3rvJN4Jpc1figtWV0jCE/Vem57OPXypVXGfT99d0N14DDQL?=
 =?iso-8859-1?Q?dIJY9iWAKmWHzyPnaLF1Dt3PL3epDg5fGhCpytIJnzEfdiPkMwRIMhGc54?=
 =?iso-8859-1?Q?ROjzEQovhggCR9NMFolIY4+9tZfP/6+GEkxfOvuQLejZaXOfpS7b8D1r11?=
 =?iso-8859-1?Q?vI4St9gnF2/tlcfC4af+sxrEGIucPUM3vlDE/xGMnAN3v74ca3VqcWub8n?=
 =?iso-8859-1?Q?hc7kmjRyr6NtaPFIl/3R4M95OwZzQ6DuVK0juZWWlg3baEDbACX6PTYtsd?=
 =?iso-8859-1?Q?4NJ9gNnmIyOBlnwvfmFPTtW4uGBx9g8E/rU3UOzlU0V7lse8TmsebtIzRk?=
 =?iso-8859-1?Q?zIFCud9cB/UB/LCngqUSn6/Lm+lH2MWDQ7sldqTvrKZ/RrTwqNLNnEK4Yh?=
 =?iso-8859-1?Q?h360oD1LQp7wf3Mmje0zsTYVNQou9S3EyyfID2caFcwywiuPs0F2QVkZbp?=
 =?iso-8859-1?Q?Cqf9uGSvvjoU+GcNCPQIaJKTXqc4fvsz+NmvhOEdqOTGw/a3z8ox9dQGVV?=
 =?iso-8859-1?Q?hEVTebJpb5IJKDPWrxOg58u2O3Kx1rcC3A?=
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
	v69kQlfyovFGU8KToGjKMLfDTMMWMmtHfkxwnbMY87V988eG54EelxQoolcEB02+Y3cD8wOItuFxqgsV9wC43QdTTuVKiY2R2TjyNGfwVLFtjhv1slsNshgQ19wEHXjjCasU3y4DdW/HhmvE0uRknXoVpIAoEBwoZHDnZhnXH6PnH6+VdOUaGoJYgQ+EzCNkwiyKsE0UPUm2xCykRE+pdvpPqxAXVpUHcbFwwCedbANdSTIut1eHqAlt3O5Yv0jjLFew7Txt+dioCe9SE/OLrFD5w6guYUhuRqP3ZbWJqKBML2R49nU77WcdW3rAGJras0j6Z9pLToBIH2dJHwUprdyYfwP53Vpfdka8dTU8D/6D9sIrEV6Vf0/P6CxHuYMfiu4IQnshVagYUhoaCg53JlDXFyT2BkGuk6XgtLddl2g0kyfZ3b+VDVUX8aezhUqSXS4uSJLQhppKdtliai5bCP4jMwV37KT+uqhSkpc8tJjjjT6n2AMxRUqdpO1I1k4OCqAsHfOan58BsybhCjeVxMdTnRXe8LP3euq1RPC2KZ8I7pGEMYlK8QSLRowhcMhCJImVLKTtbrBU4gmZVgFis3Yg7w3GGP8PK+qRMBg66fE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ff9a0d-240c-4ddf-0254-08dd51c72c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 15:56:43.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLP2vQ5GIY9JlqXZh/VITzNzb1U5cI5gDtCm8wC1JNLCZGo22Il2dtqFBzvFRVKQvVCVEeW+4dQBnY2Y8+sDYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200113
X-Proofpoint-ORIG-GUID: qcbenFUUUwlanSd28CPJKtGUVpw6Cplh
X-Proofpoint-GUID: qcbenFUUUwlanSd28CPJKtGUVpw6Cplh

From: Sinadin Shan <sinadin.shan@oracle.com>=0A=
Sent: Thursday, February 20, 2025 9:52 AM=0A=
To: Shrikanth Hegde; Chris Hyser=0A=
Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@ke=
rnel.org=0A=
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest targ=
et=0A=
=0A=
> On 20-02-2025 01:15 pm, Shrikanth Hegde wrote:=0A=
>=0A=
>> If CONFIG_SCHED_CORE=3Dn, the test fails. So you might end up seeing=0A=
>> default selftests failing on such systems? or this is only compiling?>=
=0A=
>=0A=
> Yes, this patch would enable the test to be compiled and run by default.=
=0A=
>=0A=
>> Likely the selftests/sched needs to modified for CONFIG_SCHED_CORE=3Dn=
=0A=
>=0A=
> Agree. Chris, I suppose then a graceful skip would be a more right=0A=
> option for kernels with core scheduling disabled?=0A=
=0A=
By graceful skip, do you mean a 0 return code and not printing failure? I c=
onfess, =0A=
I originally wrote the test as stand-alone for me to get the prctl code rig=
ht and it =0A=
got shoved in here. =0A=
=0A=
I guess my question is what if SCHED_CORE was supposed to be configed into =
=0A=
the test kernel?  Silently burying the error might be bad. I'm not strongly=
 tied to =0A=
that, just looking for opinions. At the same time, if you put the orig chan=
ge in, =0A=
people w/o SCHED_CORE on will start seeing "failures" they didn't see befor=
e, =0A=
yes? and that seems bad.=0A=
=0A=
I'm happy to make this better behaved. I'm the reason it is the way it is.=
=0A=
=0A=
-chrish=0A=
=0A=
=0A=

