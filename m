Return-Path: <linux-kselftest+bounces-49262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EADD3952B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0270330210E2
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705132D7FF;
	Sun, 18 Jan 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rIK38fi6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TYTGrFc2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C632B994;
	Sun, 18 Jan 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741101; cv=fail; b=CcLn1ff16K6gE6jkgQkJG1O17lvTuuazCXJrtmEyoIP22sDRuNgSD/4bioRcyf2JMlK7bp+IW5/XofAYKwF/JQPWt5+fF2yUN4jONNzavTqoTU/pBKMlQ2Gjsb1prBoUXYo3Jip1K0QLAJPxYQJuUyRkJemyNZaE674smY5/zvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741101; c=relaxed/simple;
	bh=6z5INrI7ibCm4hvcgwL2tEGFmNIQATHMOiK2tESEx80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7jfZOG7JHr8sb5KBHqpojViJPVS+UkXQI1X9arkYfcYblCknc2hUCfbahRhp+Lh+GxkvtdaNq3zwXIV/c5ZQSji+c4p4Hvv4QNqhs2JlXfcDFP5XJVEWt9FCeWzmgRAbpvG2o3MSzgDXvsgjHwuPzP+Rs7ZLVNdEu04bXIO/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rIK38fi6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TYTGrFc2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ICO7vj3385441;
	Sun, 18 Jan 2026 12:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6z5INrI7ibCm4hvcgw
	L2tEGFmNIQATHMOiK2tESEx80=; b=rIK38fi6Fuer5QlcuyHVJWmLezLU61m9t3
	GWt35qVSFJGGeXp2ZXZQ6BORal8DeUi9cGexVad01JXe8Af9GLTaxra8H8piVdvH
	JtS/vv9y0A+zsfpZAivk2GAnLehTsKlLll1gwX46OVIKNqBvJZgcwgE/OQEW26mO
	68JMD1BWExvkkSy5x4n1vCl6VHESWwl69msNxb49/szeKRZjL05JNwmA4plNzmqY
	MbDokK/vEgJI2uBOwy6XU8kosToHufRePq2F9d5XUhzSIqL7y5hEO/SMYsKfVNEB
	t0fYpDKyOyQJRvzfUhS4iFH1UZUl5kjIHGb3AD2/2nvVqWgyL+KA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1709b6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Jan 2026 12:58:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60IC7TLv038751;
	Sun, 18 Jan 2026 12:58:03 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v7d7vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Jan 2026 12:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPLVlRXfLwsjnUPtP9u2nJqxdfmbZ5yVUHLR5j9hiJp9PYIyXDNH4XI/lSYBP/5i9OZpP6qan10XmQSVhVt5iAEQ4nbbSx1AoU/S+J2oJSD0Txm1wAbhM7OeirRkezKJo5zqRQOruGumjiu4XlGUCBIKAJ6eukW5xG6Dei3CXve82AJdFPz6ZRoq7jffOdBs41OUSpyUUpbxTLhe6d9mBqHuLxVxVTZ98nKB2sswTgmhQy5pMLuxBb23AidlYaKyEBQ5Wgvoh2sjs+zhWHLqKd0oz/49Psb45Wax++8L1cJwoD/YHRZyWBi67SiDRXsJMRhAT1nbVWKabjCAa4LcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z5INrI7ibCm4hvcgwL2tEGFmNIQATHMOiK2tESEx80=;
 b=weiphVVFm/PJCRlsK/1sRRUwQY5+SWnZzrnvzGe3WWg7rh0/yhUxwfXIUE9j/YvKf9FX32Ld1Kl12mcJ6W8uSsP5mqWLILV+sRYijAcwhHsp0EtWQ3BrHy/aemve51m2bQetWwH7Uism7ewcd1HovEcEFJzrCbEVyHvrdZxtgQSQO2L404WMqTSQGHDPADKtFIDpjb0w/aKYNE6WITDmhPVcwXm1tTIfANDnxb6cw2CZBq2NP6IOrdXcVuUYPKewrYe7WIJeydxcFzwQn+WSSvs2RhCpQGtWsgZS+hABSKAg828EVADsqGBw6MVeDprgW/dSscmbsSN6FQdoWTtVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z5INrI7ibCm4hvcgwL2tEGFmNIQATHMOiK2tESEx80=;
 b=TYTGrFc2H9BY+Tk9iMxsntpuZ1OWB1QOcwUk4ONFPgODzGb+Z8Lx4He6zNmdpxlgE8sbx4zI3Nw7hh44COAcjUBQyFUPBApin4TG+O9KxCGOHv2r/0HaBWwau/Z/+TO10Q6kuaZAimDRQzyNtltpWSTxKdrTgCzNHbMHENCaIcw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 18 Jan
 2026 12:57:58 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 12:57:57 +0000
Date: Sun, 18 Jan 2026 12:58:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Message-ID: <f44fdda0-80da-49a6-a9dd-75b9a46e1f76@lucifer.local>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
X-ClientProxiedBy: LO4P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6520d74f-408e-40b7-d8ab-08de56913417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJMpy0DUMstWtZG17T2oqelKJ80xgYHtP4MmYrqP0q0LJ16wDl6CEBjaRsFN?=
 =?us-ascii?Q?kJWc9+/7NwY5+PFkc3w002HmhWXvYqzI3LpZJPi84C9qWip3ZiMtA1NzVNMn?=
 =?us-ascii?Q?vEOa9Au3xXscL3mOktqmUS80p87z8cnMPxZP2EbEIQl5sZ86nCgaNEVr7zWr?=
 =?us-ascii?Q?exO7Y+kVoBSTVutFKgisWgh96nXYfsEUzmHDe7B+1Lw5G+IW+FHcZfYdp5rh?=
 =?us-ascii?Q?SWBcgoA/rt/wfZWny+T1Adtg0xX0TxtzWGAe0c1SsfmVn6cqhY32gQDqx4ut?=
 =?us-ascii?Q?vPK+/4IZ4qHuGbScrEUl1/OmxPnlj2ZLqY0wtkev8WflI/0DlXRUr7hfaSEj?=
 =?us-ascii?Q?vWY8USUUigTtjMajgMhFmYdXIvR5ELG8EIUqK5A+4WU/48G9fi3+up5izQ21?=
 =?us-ascii?Q?SQR6tHR/DXfH3hbnpkcBxeuU8MQZ0mUw5vdBsGTYCrCMzpEnvnr83SvqOxYc?=
 =?us-ascii?Q?RKMA6Rk1eHARxRYjt/OvrC3duGE9iFeCaiJ/8LioYoe7+2KYFva0j8hi8dTR?=
 =?us-ascii?Q?OUG+ywzmjyBGs5n1E9DPuxubynwgYSNdDuO7k3J1xQCDDEV3I3Bqi0B4ShMl?=
 =?us-ascii?Q?Ts1AtertaB7Mfq6QT2qiCGwlwRJVh42xudq3MI8W58mywbVqK4gk62CIPVeO?=
 =?us-ascii?Q?VFgi7ZwLhLTNlsArNv8PIVkHBL6e7/ru4YuMnSKCLisEQRB8sDETiF+bEVjm?=
 =?us-ascii?Q?gxChjQGubdi+e+/2xuHzIDPxSmxpx0lXqoBJqFUW/HYrCo1nXnaipVknVyrT?=
 =?us-ascii?Q?U8rX5YZimtkSxCkRHaQkzDyfVvzTd9KaqieE4CvRD+O451CGRl5GMQMarqlx?=
 =?us-ascii?Q?h3sXyx7MwSM9X7bHmbpkpowe1i6H6N2zzcgSXwHGqO9t/4bPFpuowFxysYwq?=
 =?us-ascii?Q?IWqk+puceaLmgar6482UTz9WLdjP+AYbgtWHTR+XQrLfegFZsnTM1DR/ZyEH?=
 =?us-ascii?Q?rR3Q0BtktBgZPOyw1YLkZSffe/GZviNIr085FlZTtmZjg1aPblZpSt3+mlfy?=
 =?us-ascii?Q?0qk3ln2Tp4TuM6lH597Kb2qwooegE/0OhZN3r8Jl1/m5tZs+ifWq+z38wywk?=
 =?us-ascii?Q?Ns6tT61qsPXo2iW7/1mOLv4zco0UnAUCgczb1RatGYwU9jviNGazKvZurckZ?=
 =?us-ascii?Q?1G+tmj8dUwtO4Udr/vlwWjTU7H21Hx8CkcEyaUtIfv/+uuWRnuvkYSJyhzHL?=
 =?us-ascii?Q?+aG9GFe17lJlCRXr5QJ4tGYyCx0yFUUSaf9WJ7fOWuZ5Jd5mcjxGBCB9emJD?=
 =?us-ascii?Q?VkvDwxL0kKlFKCI/Mkv7ipXfHdO6nSq85Gq7o3UtoSC/2tg/vJ0CdnmtQyTJ?=
 =?us-ascii?Q?rFBfD2JvyYUCVXIlY+9JPDBYB8/x3LCNv5lkHRP7QsE+t9ohQfXL14OPMjr7?=
 =?us-ascii?Q?+bWug/FJZ/mjPJRF1gbS925P7ZV1AdizKEycObA/z486g/hwGeC7nQMH2i+K?=
 =?us-ascii?Q?voOtHz/ab/0nilAP/uhpjgdA9j1VQMGgXfrQadBGXkLr2fyWBXC/Y9NIcH3E?=
 =?us-ascii?Q?oCVrfU+R+dmkc3qPQJSzsVxs65YAr/KoV5g+R8AtwJ7Unp019e5a7v9psdeq?=
 =?us-ascii?Q?XCSX1WCJqfgnGCkpff4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiZyZIIGNcOub1iAyomxdj+AT4dk1lJSbKnSN6xrkjpM6So+GTF04Js6cfJj?=
 =?us-ascii?Q?/ZyYNG14La4KQMiMkot4H0g94BpzvgI3/9V8CVdpuKp7yIC84DO+wJiN8TJm?=
 =?us-ascii?Q?dn/NT3nKRQjGhfK0hlPGHQArnkSWfDkOnWb+RGupqhvJQhUD8uE5VvkixzDp?=
 =?us-ascii?Q?L520Xl01quB56jKcCpT89f3K2so49sC5jzEngvmDXAwDVwHR/jh4DVA13k9e?=
 =?us-ascii?Q?ubsxZWd72jkoXV/5HzgYPofitfe/qCJ2VqPRH4tPBLvKQC34GsGJBP58aBpf?=
 =?us-ascii?Q?ZqIoPzSs5jjflfACXLfaN+06djWjxwzCx8eAo28ZZDIfhAqGYPr8IHadKX4F?=
 =?us-ascii?Q?xp3F0vmafDEvUvYhGCLKRmEbkAEXitBCWb6oKzY3sLII+RDrCsobU5pxvlOI?=
 =?us-ascii?Q?othV7OQNtPluD5S/ah0WgVdnYbt6qm4jodUPot1ehzpSE2e6LGEVYiS4auIa?=
 =?us-ascii?Q?GMaX9Lt5SzXxFl2jNNnOEgzTmUOGeQEF8L3gaKNvQGp2OyMwZlSiibfh9pNC?=
 =?us-ascii?Q?234UYrXZWjvne0apSRi8dxP7cIJWf4mzxJQp+SX552zVB48Jv5c5vgli/v8W?=
 =?us-ascii?Q?o66ZoDVSPiby6foV/aWvM2nNiRJqnyiD3ImkTWWvcaSBHOweE4qAwaJVnXCn?=
 =?us-ascii?Q?Z3goSTHKnG3jgAoPcpQtG2EGrfexBHibT7zVIJx3rifN4P0UuRul8XMzcbit?=
 =?us-ascii?Q?gWPI2tiielLVGMmUhEEC/zDdEtlwzfhq0FjhS6VsOyx0XnFviZVYbmvep7c9?=
 =?us-ascii?Q?7d9KZe/AsyK33vvUqQT/wrMV1mdtieyqnuVIiJyLfjdh6VfCfzJPrGWhQ4sd?=
 =?us-ascii?Q?ahJ3kj+lS6duR2OBAFTLN/uhibqJBqr9h4Keiv9woNtM+HFlgGQyi+CPMaXi?=
 =?us-ascii?Q?tnyyhB9iIX1qZp9lYmcOXFR1j4fpYF/xKud6YjbaOQAMQmFdStIhsCEWFr1W?=
 =?us-ascii?Q?f/0XwmizJB1kp9lwJVeBuUnYLaMJn9pi53/gSYK+DAk9yGbmCspX3DzDTiBv?=
 =?us-ascii?Q?GTMmblx8rAcenbV+Pn/hvB9jCKHfIvVIwkS1hVAAcNafylvebHxCJ42pU4XZ?=
 =?us-ascii?Q?QRPimZvpr8w2o93w4T1HAW/iHAF0OBfHet+yztMrX1uquc8M1eApbp9blB3b?=
 =?us-ascii?Q?UAtTUEauYBzFfihGZTRyPNzLKN4I4DTczAqBjYieavWU2V/rY3In91oDL5E6?=
 =?us-ascii?Q?9/TRL5vVrFZlu7npajcDsoNFxpWRhmee2Z0RvDRbNrTVzFKuhKprbdGpEOgU?=
 =?us-ascii?Q?viwJZ+bYbRY+DJp9fX0sryNmSstArPUExHNbJh8AYR1PA9VGmrVugh1P9Jce?=
 =?us-ascii?Q?5o5T/RUgCD44XpA1m1Vjkx04ErODxKAr1CmjyITrpVdx+8vLD1AkdN/P9jCb?=
 =?us-ascii?Q?N9X3C7MpKh5GWro3jcBF6fCjya0XtCTKG99/X9uuwFh8OMZFGz4u8D0YHXHE?=
 =?us-ascii?Q?9Ad66VhigM2IRTVHRFiiUuU4lwzaWKx7BbRrdAbfa8JBGDsyO5xcDJofMbpU?=
 =?us-ascii?Q?vpubGLNJ4oGhLh/J1HwnC/f6RVmXYYDOnQprus3E+kfyfmDFtf5uhhoQFQDK?=
 =?us-ascii?Q?hQEmtrisBhLD+M9lZeY/FjF83kD/SwfK7jUEgrUFfPFItbjqL74OOKtsCuvS?=
 =?us-ascii?Q?qGu1PM2j/dx//UyxjuhNuLgjWkaL8bVHk+oafq+i9iJ+i73FMxY1100BuqIz?=
 =?us-ascii?Q?ou61UAaO0HIOwLQUv05QG15X75BLlN7Y5a30TRdMp74Gbt6NWxhh+vbSj8jb?=
 =?us-ascii?Q?mtZhQLQDvgiajbcCXmfL1wigsgdOAAo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8khSWZC4s0iSdY4Mqruhke3AQqOmbf0MkAi+o1N182GxkNuZEU+EFnoYW3xEGmZrfx2JWjWO+d4DO8WCzVRVxWq9PgPLK/qz6DCHqJyz3umG/5P6bWrch+J6b5P8AGTsO/TRZeFwjROBx0gKzU1zWbh/2WYZd/jwfg0qghe3A4EnMAxXIYbrnqlOQGCIEfQHMLfHdfCGshyibIs32IirhcZGuZU7JFWNqonboFercMzKZV9SPN31WTM7h4FUZMETJmv5vBN7naDQCMkfyglt95d5B3W8LJKzkL0o2w5pjHYDvXdAJDDFKRQavDkkTP7iNUX9GUBjf7yDMcpSaKHrIbWOULhT9e6b6HBWO+FZWAx7UgvOStKB4R3OxpnVft6Q4uj3Krmep/piyuzpQg99UN94aN4PT5NxUwpQVcwFSfEa9C07GdJ9SbWirvjwYuTfTdcktANOqsLaZokCpAgUNtGvo+tY3vTYHP9OpEOxQKD6+TNgsuuuSyRSDjA3+4Ckk8XmDlI1OH5uY2D+tzpxRxLUnrkNyoOPZcUEpu4slW/k6fYKxil3/kdFmeV3QCGQxNUxrl9UOFZ3Dg2oeY19nZ462lzvhC3HNA3jtRjxIWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520d74f-408e-40b7-d8ab-08de56913417
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 12:57:57.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kWcCqGM1WFPJIVb7zYWJOcpew+64U65DrxYquwGjIa3c0SE1akn1G8ivrdOekoU4O6sGA39QGK09KhD2qmD4rc/Z0AEMJoB2y/dntLrAsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601180114
X-Proofpoint-ORIG-GUID: aI4_ffUjwF9CtIwDVM9ccHkds7mRkHq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDExMyBTYWx0ZWRfX/fc3JTsMgOhR
 FFlAnmObuR2nOsT8zvPxXn0zMlQxoc9E3mHGcXePsDNbBXEE2qQXGd1Y0Q+Q10dmZAojGLuNIDL
 MSNRetggDEcB368v/2sck5EtkNaEL/vjraq+RNurXjRSnK1ttW4N0WVEk0krexf66lpPWZMhgZ2
 hsbrQZ/vbyNpfObnm0hF+IlB6iLN550EdH8fIYAvwyTqG1+zsunVFT6hpjPE8XQyWcjzc3RW+K1
 1JxrqvsNvFm2ZyfQLZ4ZF+8hYVxTuGA2EvBFdkuWpNj+e1PkGrGfHbPxM6q1zibKCJ0/dPXL/tt
 rkbH5i0svaYvI7l+CD+5OxKMaSJdwUXAT/9lwlNXqM2nmWv+yMtkqfDKA5V4NkjHWBI4YzfjQkO
 q7m4y9enYM6pDRYaUuU1imh0F1a1imiBlOlAMqK4algI+L2jeFc+oukLeAP/9OUUTfeaqeHO4xk
 /KXWgtNIk1FaREc4FjQ==
X-Proofpoint-GUID: aI4_ffUjwF9CtIwDVM9ccHkds7mRkHq2
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696cd8dc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=W6ku4D2temez3o2mvw8A:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22

One note - Dev please wrap lines to 75 chars as per standard kernel
practice. It's super hard to read your mail with unwrapped lines, thanks.

On Sun, Jan 18, 2026 at 01:25:25PM +0530, Dev Jain wrote:
>
> On 16/01/26 6:50 pm, Lorenzo Stoakes wrote:
> > This self test is asserting internal implementation details and is highly
> > vulnerable to internal kernel changes as a result.
> >
> > It is currently failing locally from at least v6.17, and it seems that it
> > may have been failing for longer in many configurations/hardware as it
> > skips if e.g. CONFIG_ANON_VMA_NAME is not specified.
>
> True, the test gets skipped for me since the mark_range function was added.

This is underlining the issue with this test.

>
> >
> > With these skips and the fact that run_vmtests.sh won't run the tests in
> > certain configurations it is likely we have simply missed this test being
> > broken in CI for a long while.
> >
> > I have tried multiple versions of these tests and am unable to find a
> > working bisect as previous versions of the test fail also.
>
> Does the test fail for you even for commit 13e860961fd4 ("selftests/mm: virtual_address_range: Switch to ksft_exit_fail_msg").
> I have never observed failure at this.

It fails consistently with everything as I said, I gave up on trying to
bisect it at v6.17.

It's been broken for a whole bunch of commits all over the place so is also
an active bisection hazard.

>
>
> >
> > The tests are essentially mmap()'ing a series of mappings with no hint and
> > asserting what the get_unmapped_area*() functions will come up with, with
> > seemingly few checks for what other mappings may already be in place.
> >
> > It then appears to be mmap()'ing with a hint, and making a series of
> > similar assertions about the internal implementation details of the hinting
> > logic.
>
> The revelation of internal detail starts at 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()").
> All that does is to check whether mmap failure actually means exhaustion. This can reveal bugs in maple tree,
> if it cannot find a 1G chunk in it, even when the gap is present. This is an internal detail which is not
> expected to change - no one reports any breakage (AFAIK, please correct if I am wrong) until after 10 months, at

'Internal detail that is not expected to change' is incorrect - you can have no
expectations about internal implementation details.

Another thing I didn't mention is this test takes a LONG time to run, and we are
already having timeout issues with test runs.

> commit a005145b9c96 ("selftests/mm: virtual_address_range: mmap() without PROT_WRITE"), that too not at the
> gap assertion code - the breakage happens at the while (start_addr + hop < end_addr) chunk of code. In retrospect I should
> not have added this chunk - the purpose was to check whether the VMAs being advertised in procfs are actually usable, testing
> something which, in case breaks, is extremely easy to figure out and fix, without putting this functionality in the test. And, I
> had no knowledge at the time that this will cause pagetable allocation and will touch physical memory. So commits
> b2a79f62133a and 3bd6137220bb could have simply been avoided by removing the bit of code I mentioned.

OK thanks for the explanation, but I don't think this changes anything.

>
> >
> > Commit 0ef3783d7558 ("selftests/mm: add support to test 4PB VA on PPC64"),
> > commit 3bd6137220bb ("selftests/mm: virtual_address_range: avoid reading
> > from VM_IO mappings"), and especially commit a005145b9c96 ("selftests/mm:
> > virtual_address_range: mmap() without PROT_WRITE") are good examples of the
> > whack-a-mole nature of maintaining this test.
> >
> > The last commit there being particularly pertinent as it was accounting for
> > an internal implementation detail change that really should have no bearing
> > on self-tests, that is commit e93d2521b27f ("x86/vdso: Split virtual clock
> > pages into dedicated mapping").
> >
> > The purpose of the mm self-tests are to assert attributes about the API
> > exposed to users, and to ensure that expectations are met.
> >
> > This test is emphatically not doing this, rather making a series of
> > assumptions about internal implementation details and asserting them.
> >
> > It therefore, sadly, seems that the best course is to remove this test
> > altogether.
>
> The objective of the test is to exhaust VA space and find out bugs in mmap(). It has

Well no, you're asserting gap lengths repeatedly, you are making assertions
about get_unmapped_area() behaviour that are totally inappropriate in a
self-test.

I would suggest looking into actually writing unit tests for get_unmapped_area()
functions using kunit or similar would be the correct approach.

But again I'm not sure that it's appropriate to just have a test assert
that functions do what they're implemented to do.

> been useful in discovering a bug at [1].
>
> [1] https://lore.kernel.org/all/20240123171420.3970220-1-ryan.roberts@arm.com/

I mean that proves my point that this test is _actually_ a wrongly-abstracted
get_unmapped_area() unit test...

I'm glad it was useful there, but it's just at the wrong level of abstraction.

The test has been broken consistently, right now it's broken and nobody noticed
because it got skipped (!), it simply does not work on my threadripper in any
configuration, nor in virtme-ng, I've looked at the CI and it seems it's not
been running there either, and it's adding maintenance burden and making test
runs slow even if you have CONFIG_ANON_VMA_NAME set up.

Every time somebody changes an internal implementation detail about mmap()
layout, this will fail even though nothing has broken. This alone renders the
test inappropriate.

It reminds me a little of CRIU, which is tooling that makes a bunch of internal
kernel impl detail assumptions to work - we are not obliged to keep these kinds
of things working.

When I first saw this test I felt it was asserting internal impl. details and
thus not suitable as a self-test but let it go as relatively harmless.

Now it's actively harming my work flow (I run mm selftests locally a
lot). I think on the basis of all the above it's appropriate to remove it.

Thanks, Lorenzo

