Return-Path: <linux-kselftest+bounces-49338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD626D3A244
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 09:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF713006596
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8A339843;
	Mon, 19 Jan 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BNBcLUTS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Eli5uWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28347350A19;
	Mon, 19 Jan 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813160; cv=fail; b=Nqu6eDEXcLzafiXUMXB/1lmmSS1ywZ5e8zA6Y/SKIV8yjHDIQ0h4ztaDF7o0k9QscJX6UwQPNpNOaKf7WTj0XhslRJf2K+QDUqfeg6hZh8ZyagVUbktGVKnnp15cSNkxrXMFv/ooNsmABw0nlSNmATJG/AW2sGKbzTSbmFTSr9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813160; c=relaxed/simple;
	bh=OrBjKzKveb8vU7rUrnVci3oO+t6MEwHDSuJmfEc1SVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfpIOSUljrDQsBFLcIpb3J2eIB5DmQfcZMEw83vF1u2yeB17foqwrbAIH16pLUGUP34GiofLzSPuRGFDZypIBer/mcSuHgk+DJeHR+IatvaCvf7/XvXoKku5tSn0ZmLopaA9A6SKDli4xu1DhZtzaBNN7tmxdr5B0Kwp1MmX1KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BNBcLUTS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Eli5uWY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INtcQE427804;
	Mon, 19 Jan 2026 08:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0HVPt/VYDu/UAWYrz7
	OMFux0yvMsJ2r5bJeofO/K2qg=; b=BNBcLUTSYBPjsRu2K6bE9ANHLZyr9dcf2s
	6NY1qEdZzjKoRrnua4b3vEQCUQKK4YMahqc/tSPINoB8ALUNEYIlk6nznWlegVmd
	ZWsWayIZQq8bV7m95aqS7/R0qbd4QSMzZKc9bR9L9aztgJ1FwlbtJwC3dukIxyLc
	9BxmjBwTgGr2gd2Gj8K7gDff2QyAPpD78YUqVPeWH4AN6976bJGYg156ba8YuiTA
	25esITXT1OJKI+uHMkL5NQUIiHXAh16yYSo+oBgu7R4F5bO+3OPyBRMudxhISEgn
	Ggb85EE0Y0AoRkeREFPkGT6fCw+n6ZIK95POiVKuI8tihyW+NDTQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21q9x0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:59:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J8f56l015541;
	Mon, 19 Jan 2026 08:59:04 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v83ued-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGtUwbkJivU3tFVqdYnGaP58AY13iuzWfopQZqAH+6FtS2joVl9k8Y3JHalG2ePDnThJaQQcPsx93ptCoumNQm/ld+Ug0Qt3MO6sD/yVMFK/CnpXxqmqKPyMgyKjBOKjfZ/ERkhp4H6K4s83EEPqcrQQtv7p6AAtqyJKesT2+GPEouXpvlKCmjJrXm9F3jtY3sIbX9Qyc7IRnaXIOH/A7isotmekHuWbrVmzeJNWTB6kpWINPVAzccg+b6sflfa3BTGdx+7P4n3Tf4i2XCrzWtxnpN/GbWxvB00Rq9GJhPOQKJH+CYXg2U03o+xET9N7lIxfpta4TDww4VIm5P/6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HVPt/VYDu/UAWYrz7OMFux0yvMsJ2r5bJeofO/K2qg=;
 b=yO/Y5VP2CRLy3RTqIr4GLfkaXp4vzQ2OtVT7uoqOBewZsgYnqD500zL8qJ5Qz5dkz1oHfQ0I8izawIWu0Nn9OFeosNJwzlhPwHjVxII2SQwWtuI8k0lpnsZ+o3F8rA6swsQrygtz/kbpmb81yxuMwOZumKXdMtg6IyJD30w95E/rZRYJqNNgVb1zpfIb6KwBRjpOGzqsHh/tjjOqRVfEdh7V0DKs3rgV/cjfubzQOPGZzYtKdxURXfN0z71OxfN5qMon/rzTcmVi0kpiEpy6Erhn92sSmcKNLYsddQqjoBHwhLfH5vOfkLxPFuw1zCiJtQuCIR9NztvtOyYQunqAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HVPt/VYDu/UAWYrz7OMFux0yvMsJ2r5bJeofO/K2qg=;
 b=0Eli5uWYcbu1wg2rabXfYgF7VkeObMxOHCa7kW23oLCnwToEwk1cSAzKJ+I8Mnb0cNtMkLssRIKlZbEPi/kF6OjqJZcgx0h97ijS4h7lcMlIVrmMBqpTJBWvhpum0n76DNyGK2zmMh+eZzhT3BA6AEKwxf6/WsDAyO/HFCN9PVY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:59:01 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 08:59:01 +0000
Date: Mon, 19 Jan 2026 08:59:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        aneesh.kumar@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] selftests/mm: remove virtual_address_range test
Message-ID: <f7ed83bf-3554-4bfb-8d77-30ed4785a4a8@lucifer.local>
References: <20260116132053.857887-1-lorenzo.stoakes@oracle.com>
 <5957ae48-87b8-4981-a6f7-8113141e7b6b@arm.com>
 <f44fdda0-80da-49a6-a9dd-75b9a46e1f76@lucifer.local>
 <e71ffffc-8623-48d6-88b7-4684af4534aa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71ffffc-8623-48d6-88b7-4684af4534aa@arm.com>
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 82835b8b-265e-4871-e8bd-08de5738fd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIx9pwcf120zH96nqTggJt8aBKNPxkRnWhENyv1UaTgPcipHLPre7Z3MDdvz?=
 =?us-ascii?Q?7jQZBGR5CeQDABqo6K4MYuQQw4tnwMxH55A2La5qDLhUUdgf0dHHjHet6gI7?=
 =?us-ascii?Q?8Q5fKfVSSjpqinfNEDnPcuov/gkQWF2thTs9b9gFLUFdgoyGHhr3uFgeKB03?=
 =?us-ascii?Q?LReUJwgAUHOVJePHsWWaKqFT+TXfo/zZLMq0LL5Xzv0+DGoE+yNEiSfHNlWy?=
 =?us-ascii?Q?nUoFMD4AP7aeqhM/BDP7uB2jZXD8Z16UcpMNub90D5eWS1M4FIdVFqgreM8K?=
 =?us-ascii?Q?k6EeWNV1v4mf/sAjAA82/ZyfMmoj8XGxhkXnhFQg+qs0ov8FKj1sU70OxvRS?=
 =?us-ascii?Q?E1gae5Gk2xq2d25W1fWNaF/+9rJewa3bEnw8T4cFQqpvLwPwe8fw7vbtobNO?=
 =?us-ascii?Q?Bo2RqPlaDKF6xKQqp8nSJBYcaEvq4WO3Shgu5yeMvTgI24E9gqCANqvULOJM?=
 =?us-ascii?Q?gri+7Y7CTC2GbcufMlKfENwIPDC82PkZWhDcwtOiq0aLM+kOanMbO2gSKYM4?=
 =?us-ascii?Q?evsmlstRWxen3C2w5ZkC5SALTINeASsUaATXQQYQxQnlj7Dql81VHrrw/Gho?=
 =?us-ascii?Q?kyD2nnN7ufHw8xTH3cq1rofnju9qt25mdHZHm8OIwcC/89rM5PsP3h+YcHja?=
 =?us-ascii?Q?jh0aOVubsxu8Hv//Uog9pmajDh4/YR0bidQoTjF5aIt5CnXbRDLPreIdSSzD?=
 =?us-ascii?Q?D5vpvefMEvIee+f1GNxCYF3nH76Marv16W0aQT+xxmhGtlVgQl3Op93j8vMp?=
 =?us-ascii?Q?Mrysm9lUSLPNhYqXC6CGuljkm9VKy25c2VeRqwP2oqYymfSgeZHKYT403RWi?=
 =?us-ascii?Q?Ira1FdkFm7LEWak78tv40mP4gd1quEn4bYZAASVvrbh5n71EDNnZ9U6uelRM?=
 =?us-ascii?Q?RdjSyUAfz3QS/T5FWJVLtFJPyfckFhbrBfgQp86uxpJkvtizJCR8DlMfYe+M?=
 =?us-ascii?Q?6uKrHpXuMT8RoXaZx1SAUcJ2VZtesUg+UlQNJBS9j0oJXC54Izgl/XavDq/A?=
 =?us-ascii?Q?GcSFKTbLg6Y6mouy1y+JJqyG8hPL+sYaliQDrqWkEd5MKmZ7SxpDFFMHs4jF?=
 =?us-ascii?Q?rEwJXcPodxZtntgw6ff6x0S+svTWx8KaleoZLNnUcgV15aDWhl556VNk5Gip?=
 =?us-ascii?Q?8B8pyFFyr7q9LekjjkgjLLnn+2dvUyrwaKkz/ramGXSLcvqsFyOTg9CRos9+?=
 =?us-ascii?Q?4AiKTin8NnIi36+evhQgkDDsY3yTEOnd4VSDNKsMw5j4W4PoxWZQl3O0qOTh?=
 =?us-ascii?Q?s1aWEoj5rjVSiszAvr/cGUQrBuYOWMltge2Xi2/8f7LIeJ9VE3IBRfXtwzBH?=
 =?us-ascii?Q?TTzr8zMXWg/a3U2rx6/Qlyd2JYLtSQvvOz393lKjFobblvQ/55g6Njod0eGB?=
 =?us-ascii?Q?molzFHrfXwdbJvnVj62I0sr9DLjRk0KbiyXnDKUKxOam5O9NvP4T+GHUM3/A?=
 =?us-ascii?Q?LvuPrcGkz7dMcxFywJJzaJ0/VmNCkfz/LGKKyl+xijzz9kScZK+K+t63d6FE?=
 =?us-ascii?Q?cerdC7C9QkosKeiOi27EgcQAisrrHDgkDnq0fxHVDXsc9ZfkDURFZDxs1qJ/?=
 =?us-ascii?Q?QtAs9B5zv3ww3VVQe2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5PrRMQX0VkssRD2aNTZS52q6naY73DT8G+dk5tjQ7PzcTcE1/c+w1l8CzUo?=
 =?us-ascii?Q?E9LHZF/zbDu8cL73+imILNNZ52GsRKYUGuyj+d5Qs82cVQrJhUkwxbz8YGNt?=
 =?us-ascii?Q?xWrpO0uOTkNyPQO1zkDSL0ymYelf6eCJGK1r+e3EWKj7GPz7654ug9tZ30wL?=
 =?us-ascii?Q?ZmUF8v8bE6v2FtxHrWsTSb3SDGYr44cbGNweKt037mkcAIiaNXm1Ak+cFWoN?=
 =?us-ascii?Q?46PXjE4P8zIGaOtNGee88vmeF1f+tCO0D9KYeKQmKAflFi/l+BSKsHTgpzMO?=
 =?us-ascii?Q?eGvV3eunN28VCiLrMWeL7+iGkxOAyRQhRDGaIztZltbeP7cOgNceXuT6mSqG?=
 =?us-ascii?Q?fjuxkoiZIVU81uNEZEnMx9DHurY2eRY76LJ0QKLKqX8PiYK59D2gTxj67MBd?=
 =?us-ascii?Q?TRx2z7JCRzKwbgH2uNzvENNPg48YucVgO8GAr8DShrWgjgFdDKZImPenTofj?=
 =?us-ascii?Q?yk4AkfAbtaJZQvMJB7May5MegoJbdFiBrw8ZeECfrtZWcYIxoXA27pdWn1JU?=
 =?us-ascii?Q?50cHRwGY0ubhRuFZiEGhOA4b8ZUw7QTk0VTmQv0/nw/sFsl6hcBqBunSHxyt?=
 =?us-ascii?Q?/rDPA6Cxj/A1f21z7LK+riSJTgEbsIiJNfUb/p5s2vdSwfTNplwh3A2fZMLV?=
 =?us-ascii?Q?roQDNbO2f87pR/dY+uYekflIFxCkka5BfexDNbwEg7qg7wBOhFgmVHk2/YtD?=
 =?us-ascii?Q?ILvuU9DlM8OGmZt/NPxcW9tODsiQHUvp8jKn5Qd8BBTeiVMiBFaRETv3dMn5?=
 =?us-ascii?Q?n17tG0094WsNNakTMUqfjsMzy2E1ZtJEGYx+On2ZpSpb8CBQmYCS7EgxQtND?=
 =?us-ascii?Q?J2xbCL7FxfoclrKLdC9oIshcV8mCr+jG4/vuJdhQIsoiDoo157VROx2/Ejeo?=
 =?us-ascii?Q?I5+yFOkayVPblX2zEHGTTsQh0hetJ5Ikv4yETJ7JduDjjWVdXdxmhIxQDHg7?=
 =?us-ascii?Q?Ae8u0YpdI3sfWyqpc/Sg1HcL4OdMuCtCX2iZDohmNue5bXaXSA7cWop97NSu?=
 =?us-ascii?Q?kxVv9JYfvI7T9fy6vjoddXoSqBPuKAxfuRYfUmeIeqSVqtVlPrwoa32HRz/c?=
 =?us-ascii?Q?rc7RHXkn75f2BQXFWhxD/f3xKgK8119PvpcqG+FG10d6NN9nDSitpJIOl0N6?=
 =?us-ascii?Q?1TLyt6p5wnZxVfjxFyxd0Zd9hf4pLtrAT8mszEjYtT+b6E3vPoJGkhNd1Weq?=
 =?us-ascii?Q?OU93GAkoC5dV8+Kmwb+L3FBM1N+87rFtH+l0JAEdZoxD3ELpnnhDfXttOLBm?=
 =?us-ascii?Q?JV0GTFMkRj5uQTNn8K6s4tX5gyazxCkEQva97x88FrgRTfiJ8DrWBp5sFSWZ?=
 =?us-ascii?Q?4NjJqUHOKd7naWzfZA8w8TE5HO8nwvDAWugODog4b6R6j52HBtZ8BNqr/ijs?=
 =?us-ascii?Q?Lv7kHs1Ktq/sPIoHH00+G8yQmOSG7NdRYhWJl+csDYmRdi1a670ikYXWJsqS?=
 =?us-ascii?Q?hvgIWkDlv1+XT2tcY8Tl8L3X28+vY3TnSvvgdXnWC7efN470FKltpbBGhemz?=
 =?us-ascii?Q?0ilPdi8bM/POWWZ4Bqdwkv2PLolaQlJDhzvbm6zsGcfYZPBcBvmwuYCPjqLa?=
 =?us-ascii?Q?e/QtMer3qofzVgvOTzXT3ff+cfGRVOzo9uDk/d7UkEFd6fywFGZTAdWBMd0W?=
 =?us-ascii?Q?9BfuC0M0forS9NxVXfeFypdK6s3/Oce0qWDDfq+NM37P8vdCsUhHz9QccgAI?=
 =?us-ascii?Q?MF6S2QvTmSo4OhVTo/hYdXbhf8/lPdRQdv4dETa1NDKmpqBcOM1qu/QoHIWB?=
 =?us-ascii?Q?gBRO6UIbxsOdNS2ZFDi9IvS68rkbxvM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DPwScgDR5WL4MyhH14xexKH4NFeP5F/MEUpxAF4jwvK+b+KW0uhShzz2gUD4hhyFxDpkAKNIqzyGvDvlcO112XLvEvkqECFKupnQtYTO+rM0VXLzdSaRos51CfA4WGveiLu1cJ7AGQY6QnUgy1HzG5xIRHzKZqa2HKid0NZusaMWjopp7q5j9jH8ofWRG4U7hoQiwPnbNdeEvi+SySxE8BOeHZZDqCHdwF3wGfVeKX+3ltXi2MxyxkqGGovga1Z6kcBhwyLL/SKliqmIUasKKmvIg13zQS+ye02D17Vy9EIbF4b56QpWZcqEJEbGDe6InTT0eBNcKWgVHR3LKrZAu1k97A+/iTK8ygu6PfWP8OC7YeXKKqlVYoigoE4Dm0Ke64/gbpYXkQQgvwmDJjf90AWQng6WpfrR4oS5wS0MYyBBSwnLobHxCGkuMRZ4rB0JpeEaFStsEnBsVGaiSc2ugd8Kr9ipj8GmsKkszvuAARDBeoBU6Jhudzdnmj7bZ9xKXDCWaG0bcCZs5x9GYi/c+WueUOc7UFZMd+TeFF+Em7Bk6Cd3d8GXvVsHxMGY7jRsDp3rv8OaQiNN8lSUnRGi6PatBdfMV7PHm5ZgiDlCtuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82835b8b-265e-4871-e8bd-08de5738fd2a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:59:01.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEVStBxp/Cgip5k2eUOtowHXAe1o7oDWcwIN9ufinN/xRAKCk+fU9xjkwemSJbDCW4li/YhCGSXQ0cVI+MsUXnBMrJRBn9gxWQQkYXrxX/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190073
X-Proofpoint-GUID: CKsndBNDovf9uRoSnv4sTW4AQG90Eui2
X-Proofpoint-ORIG-GUID: CKsndBNDovf9uRoSnv4sTW4AQG90Eui2
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696df259 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T3ry4rk0TCPijMMctH4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MyBTYWx0ZWRfX3M2ISFQ73czI
 MFQTrfXFFQkI3gFeeIWSk/eFhvZrXuPbe9yJCi4nhFmNw37vFyTVkbMpbWnGhtCLZQ7M/j9SLji
 7gkhKywa9wfMwpzg3wMhvNn2eHXsoKd9uwwA/2Yq2n664LxMsSXeuQhLWKzggW+ucH9vP/jUiIA
 +j/VsBAzzaxstalN5rXDMgZnjmLVvoj79sawJHyO4eviLveHCKhyU+Hrxemh/Q0qJvho2opyGN+
 iTAJOE7eeyqxMazqtGHnQzYpICjpdIUjemlLC444zVjNBY18t9MKr1DUrBMpbPGv60+IuhGanLH
 P1J5QHWizm5awUjrLTvxjaIuoXyRHEmcGRo4DMeWW3TVmUwdT+IAzInPhhb64fC+Gq1bkc1tj8z
 ZrRGpqj/bWo8vdrG7ykkVIFBlhN6q1BC24Ey62v8i+ysaPlyxz0fe+823IRnr26XzukQ6+n69+E
 iiG3jwfSKDLlILFWxhA==

On Mon, Jan 19, 2026 at 11:51:47AM +0530, Dev Jain wrote:
> > Well no, you're asserting gap lengths repeatedly, you are making assertions
> > about get_unmapped_area() behaviour that are totally inappropriate in a
> > self-test.
>
> Apologies - so I discussed with Aneesh and Anshuman (CCed) and it turns out that the objective
> of the test was to test the switch boundary. Upon exhaustion of the lower VA space, kernel
> must not start giving out VMAs in the higher VA space, if the hint address is not given. The
> original commit is 4e5ce33ceb32 ("selftests/vm: add a test for virtual address range mapping").

This doesn't change anything, this is still testing get_unmapped_area() which by
definition is what is returning this.

Also exhausting VA space is an inherently silly thing for a test to do, you're
making assumptions about existing VMA layout which is absolutely an
implementation detail and may even be influence by libc...

>
> I cannot find this API requirement on the man page (because no one bothered to update it),
> but it is mentioned in Documentation/arch/arm64/memory.rst:
>
> "To maintain compatibility with software that relies on the ARMv8.0 VA space maximum size
> of 48-bits, the kernel will, by default, return virtual addresses to userspace from
> a 48-bit range.
>
> Software can "opt-in" to receiving VAs from a 52-bit space by specifying an mmap hint
> parameter that is larger than 48-bit."
>
> So this is a thing that needs to be tested on arm64, and on ppc64 (for which the test
> was originally added). Not sure about x86.

Well 'needs' is strong here...

It would be far more efficient to implement this as a kunit test and wouldn't
require a extremely slow test that makes assumptions about VMA layout.

> About internal impl details, how is this test any different from merge.c, cow.c,
> etc - which consistently test/depend on whether the VMA splits/merges?

This is not a hugely civil/productive way of responding here to be honest, it's
what-about-ery and implying something that isn't very kind...

But since I am a reasonable if grumpy maintainer, let me indulge you a second
here.

I thought I'd been clear BUT for avoidance of doubt, I want to remove this test
because of the COMBINATION of:

1. It is completely broken and has been broken for some time and nobody noticed.
2. It is asserting kernel implementation details.
3. It is poorly implemented and breaks often.
4. It takes a very long time to run even on fast machines and is a timeout risk.

So even if you had a point, it wouldn't argue against removal.

But you do not - both VMA merge and CoW impact API. Re: merging certain
user-facing functions, most notably mremap(), have API requirements that the
user must not cross VMA boundaries. It is therefore ENTIRELY a user-facing and
kernel/user API thing that has to be tested from this perspective.

CoW is equally a documented and expected behaviour and also affects merging.

Anyway.

Practically speaking I think there are two ways forward here (not mutually
exclusive):

1. Implement something in kunit or similar that explicitly tests
   get_unmapped_area().

2. Add a _new_ selftest, named something sensible like mmap_hint.c or something,
   that runs only on relevant arches, and does NOT try to do crazy stuff like
   mapping the entire VA space, but instead simply tries some trial unhinted
   mappings some hints in 48-bit space, and some hints in 52-bit space and
   asserts things are as expected.

If you do point 2, please please use a. use the kselftest_harness.h to write the
tests in a nice way (see e.g. guard-regions.c for an example of how it's used)
and b. use the procmap helpers in vm_util.h to check on VMA ranges, you can see
how they're used in... the merge.c tests you so deride :)

If you or others do both/either I promise to dedicate review resource to the
series(es). That fair enough?

Thanks, Lorenzo

