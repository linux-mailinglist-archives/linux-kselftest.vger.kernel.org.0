Return-Path: <linux-kselftest+bounces-15821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BF959523
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1595B268F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FDD1925A2;
	Wed, 21 Aug 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzBr/YEK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YrNjdhJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77819258A;
	Wed, 21 Aug 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223247; cv=fail; b=WCAa4rmv88l7SjLn8DqfjTdy3m1Ue65oht20PyDMiDBm4/GuRyGLofc8yDZLNombHejLpsT2pbkpd5l3lvLsF8QY+c189v1Mh8MzQp7pnbCHeX+G/C+weLkjmGoHuHLKqlDtYnKPPnnwSMnBv5llXgMpRSP3intqA8pjWbTzWO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223247; c=relaxed/simple;
	bh=nJ7w/BjM9e46JSkevvqAD0huZbBRJ816O03+v5mkpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WhDs2edQQehEwZ/BxZ6/pLVDm7/wtGE26ze567LJXZL/EJh706Z6Jd0sGXLwoqHeGhTId9QF037mU3Mzu/cTzpjc4sC86FavefbhUw4BMOhEW6WYdMLPC0dwHx1VtKmX9iN/ewk/5CljtvO33WMVxJtGrmwQXrYfiXkKp4VAwYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzBr/YEK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YrNjdhJY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4giYQ001625;
	Wed, 21 Aug 2024 06:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=hvdVgnp0NWyP3HG
	/2oh9rfQSxjrvBgqY3AxNN5WCjWc=; b=MzBr/YEKpkPtEsFBb/bU5RBivqVwNww
	LPbmZctuF+Cgk5OKODJC2M5uqvmu0o8MX7OwyL1GdLZ6KyPYhmWUhz0jJaQlo4b0
	ARbybCVE7xKTa5nQBpDMvCHMHW6RNjhKJdYMZKLqdqFvlHIHKcqAgFn8TJc0z4L9
	daiUK1M+oyfJ8zmxbdPmb/vMBrGiAq1MaaHQrhn1eGD2WQfBO8MTZhJKJZoX6a/T
	OdmS/ttn/0KRcIAOTY2WsRmkovwjs4E0pkQFRR/2/xLixzq2T1U5aRF8ougFlWiR
	+fCMatm9AwjhkChUVM1rx0Rd7sCmkDnChsnCT/tvhakv3nTDOTvglqA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6geubq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:53:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47L64FLt022351;
	Wed, 21 Aug 2024 06:53:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415an61j7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 06:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nixcQiCvdTjJ4aEDwSyyW41PVfBZMKyEuyaQxdMpUVQ7NkLakvLQAJPGeKN4MlACBlbVds5QlhFC0q3eiVN1u6Lez957SBeDn6hRJdkv7a99zf2N5EHjybtOPgL8y2p4VxPVYJe3ZqfHW9q8ZSk6KJFAVC27o8QFttL4geZT86rE7KPIQkAs6u5Vajwd8mP/M8iVfaoamyiDE7JCZ5FbH1D/GgHomdOlt5bDrZvclxDKWvj3K+4VL0lI4/of8klK+KxnjHZ11/5u6DxpWyrF3ovA5esu961yfQolLDVqf9UhW9ZXscTzd+FOgDsk/0hKtiIIOSepbElXR5eJliZg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvdVgnp0NWyP3HG/2oh9rfQSxjrvBgqY3AxNN5WCjWc=;
 b=yTEq5fHRXUO8o6AB2iVg9rhxV0rLPwETkU0PkpzuSbc7/5fkzby3hKGQaa8iElhDMYdPSELZIqXtrrrBrIaWrhh17nxvaPVmNrAPwom55q8moUAn6WoRY/huyovooF9KAyOZM8v5qNf2or99jU7r/DIdou0IxeaVxNkII9XoET9tPr0PPnJyMVA5M+Qs1jpmqxyNOcv2lUap9nW1QmGC1/9cPy1wMVbs2+DxtOa5MedcaPh0oq8dnuy+rDf2mGTdUjHlw/QRNOCrQLtS1aqy2nav3s6iUpBEtdMJN9vwKvjMBU2W/UVrFZ1y8P2yoh2Us3TgpvmsXn95h5FRliBs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvdVgnp0NWyP3HG/2oh9rfQSxjrvBgqY3AxNN5WCjWc=;
 b=YrNjdhJY7VYir9RQhsjXlpLyr4jXAPPXdvUWWZV4dCGgwaNkTZh+jxUBjAk7fW/HOfZGyHRPDrrpFvaRItP0VB6FtzJRWZZZ7FnuTFbwDr9/DwreLxP7AqKS2SPNmeEVkPjg3DNpXDPkFvCPcO3ZIW7EHFS6xxQQazI7xgIMEb0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB6722.namprd10.prod.outlook.com (2603:10b6:208:440::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 06:53:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:53:46 +0000
Date: Wed, 21 Aug 2024 07:53:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, jeffxu@chromium.org,
        oliver.sang@intel.com, torvalds@linux-foundation.org,
        Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 4/7] mm/mremap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <2c7a5fcb-198a-42b3-98ec-ab4e81259b52@lucifer.local>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-4-d8d2e037df30@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-mseal-depessimize-v3-4-d8d2e037df30@gmail.com>
X-ClientProxiedBy: LO4P123CA0181.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b8314b-0fea-4a67-46e0-08dcc1ae00e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B8JwOHSr4NEONmWCUvThIJ5WGrKv/zo7pM0cTHhg17dXJJkZZcgw/baOdveD?=
 =?us-ascii?Q?mIOD7gYClPSuhfcn7/8ezrLREDGzn6FADgrr3DTz1A3iqcxEWIIguE9soOsh?=
 =?us-ascii?Q?HKRNPO+lOp3/qjzZljhT/gD/mk74PghsLrsRIr4pPe5rGt+1SBFqhFPwZAf1?=
 =?us-ascii?Q?ONaXGAOVXhHukveazKOd8Rodjr0d6yD+POLB1T3RnGH58LIV960YjI0FO/KU?=
 =?us-ascii?Q?1mljfI8ysQGFrjrMxgKtGXejwj3VI4UxwpVpjPhLMxv0nby0jbSlmlBwfe0H?=
 =?us-ascii?Q?/hDVBcyptgUZ7boefA14TG1DvOXRi/8Y3F99UdreuFnJpe2Q8WLfv2kYVgpa?=
 =?us-ascii?Q?pOS+hN2PbTRWBP3AI2obfUF3znT3Hk4hAedngyTLMTxA2kuoAg+Ngl7wWCvl?=
 =?us-ascii?Q?rV/uGbqSKK4w0TN4+vcQXJ+4BtY6y7MflKko3nAx3ZyjxbxzekTVnNc1XoCi?=
 =?us-ascii?Q?vLRa4ioyMu1SOi+Kc7+uVWGHMvSxb2jb7yBS+MLkkMi0WjPNWfteU+L7PIPZ?=
 =?us-ascii?Q?t/qTSsqH7Xj3UM14TJ0KSrvOcSjp4ooNHJW+Ohx76MXAE/FPd4MiEUA1J1i0?=
 =?us-ascii?Q?BA03W+Kyk5wJ8IKzxQSJ697apu1vcMyGWwIdyPbHBMiYIkS+h026gmwO7qQP?=
 =?us-ascii?Q?138w/ERg6pDadazQlcalUmDqaGpPUpDoqBZU4qVWfKnRovrDBCxHn1xrbsH+?=
 =?us-ascii?Q?CnYjtlzEELRrnWW+Ow93tZ5/LwkHc+rQSOhHgrEC7jAoQHYuAlWb386M+iqp?=
 =?us-ascii?Q?rMeNACfVwjaSHMySTyEjoIDI3QtBdzLX8PRJgd5r88+XdzqPDuaCEyoq/rwq?=
 =?us-ascii?Q?wrslpGfYmhF1MSYlg2tyVKIS+fbvYXg1mTQ3E+ziCLVodWPbcHwy8pK0wojo?=
 =?us-ascii?Q?MuTEMPJVmXZk7GU8bOSAoEXwtdHzsh63XuUNTHt/+KGtGBcTUjfrX0YAvXV3?=
 =?us-ascii?Q?27InV+j8mRFReXqCIsQBF+FljPnrgWFpgXMoFykJf/rvkBmNNvJ8emc6gjCQ?=
 =?us-ascii?Q?jxByeIt6YohGLIK/GGfQ42T9RRJyXPn0BklkJTKT5nMYn/gSKRjiWYnHg+t2?=
 =?us-ascii?Q?5En0G6uy5jVyLKf73tv99LgDGtRT3QL5TcTenpgmiiv5Cc5O0obpQl+U+nRB?=
 =?us-ascii?Q?ghUcVx2TMx+mbwY2SJ70/nTrJcKAccqN//2E0nWep4bZ2gwSB7VcD8x6IOxm?=
 =?us-ascii?Q?kp6ROY8seeskvAko+5o4FdXRugSc2H9N+jWw+rPBuOs48ejqLD/AtODfQHBR?=
 =?us-ascii?Q?FqwJP2PQ5uhbBokhx8fShTLQpppGYSGXvzi9MmHPfsKh8LhVA8/xUbXtovw2?=
 =?us-ascii?Q?GFKIIvIbSts362nf6ZX9Ya+rZEXDSEGK/S6KQGGFwkKliw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOw3L6pCDwZG59ymcqU5WvFz5wURRPtIIMs0OcbOHy+Ayj3r+AkogzGHBQCt?=
 =?us-ascii?Q?RcBJLh/2zWwHmj4CJiRcqgDoUScqqmFzzlysVKND2p1he+iefDFpBhA08gBM?=
 =?us-ascii?Q?KAb8K52QfWLNkpC99K+kiNrNZux5bDZmkoKmOEMcW3PD7jFxSZxXwL4LBJBR?=
 =?us-ascii?Q?+Bs7D/8BQd0pK13Jc2ZAbqodB9Ozk/W8lpWHab5Z372xjw23jw55EhUmQN36?=
 =?us-ascii?Q?my5TcYhXHE39NwxBTV7164XJEwFZ/YVioL/0WTbWVVn3EtBUIuXziq8sYc/c?=
 =?us-ascii?Q?O6jD+P2C5QQEfDCV6XzKqz1cvOlzi1qSfTSwQWwJZtj7rDP43m/HOj9SYY7w?=
 =?us-ascii?Q?aKc/M3dObBYmoXtLbaOCaC4IpQ9MJTQeFi6dBlWFhBjiRH153OXdXTPKHuXz?=
 =?us-ascii?Q?8jIxJLzdLoFiBuiIJyQS89maTJsaF37/HqptHy0/wwlOfM9qWlSU6vfwJYGK?=
 =?us-ascii?Q?o1jxN23IASwo8uqpq0UX2YqP+++Evq57APPw49p15HkuOZKjihcLVaI0ZIFa?=
 =?us-ascii?Q?i9fra7hnECki51Xw05goZW6Fx6Zgzs/rGI2Z2pnmLFh3ogZUGkA2pvrMjI4u?=
 =?us-ascii?Q?d/2B+AZ61MXdCibCyNkh8zY3wVmTFgiI6J8jRn+ttU03VcjvXAVN+T3hCz6s?=
 =?us-ascii?Q?A60mXdxcIIoovWrt59j9+UkL+l9fnPjrrw4cyPaK5BtM94AkMKzyx4NKsXSx?=
 =?us-ascii?Q?gX1S6WUAO00l3ZkYie8mVSlE6nE/lxRLBiHLUq8ZTqryJbni99UWr7efcLQj?=
 =?us-ascii?Q?npCbdKuVkpeUtoC2qE3aqD8+MEl+32ulED80lGxjOoLLudErrYnTA+pg0jac?=
 =?us-ascii?Q?5BKf/hmShJzwnluj9SMkjDdWaWk0GhZdFdbpI8qjwCJm4s8cJ+g+IqaFdzAn?=
 =?us-ascii?Q?OEy7S3ergV/80Zck+oYA1s9W+pUT/xyCadjuLQVxpuAd7OvYX5T9Uxippdnd?=
 =?us-ascii?Q?OgTtuA4Ct6fjM7lDvSwilsUdH+nJOTFLPc39MrpHndbseAcUGC9ufyYXAbll?=
 =?us-ascii?Q?ElB/45McYcPxGJzPesEbgYxaC5bn2JEZC1aKjHa3TIS54vuHXoEOAuIDr9QT?=
 =?us-ascii?Q?v3aN9QPD/Gk2kMQ0ncAIqkJHDWsnj2tJHM8GHCZUGpSEmwp39CfkcBJokH3s?=
 =?us-ascii?Q?5IxTXeaeE4ZXiW7bln3lFZIRIxxEr4JPl4ogrT59T2ROggIVXdeHX3uq1VVm?=
 =?us-ascii?Q?WPWbdYCFHDhEHUjfBrVwDuU5OfD0X3yPXF21fdycsbxf1MjpwCEAahAxj4u3?=
 =?us-ascii?Q?bHrj1KdHBQRE6arLOxWBuYRjmB988xScINechrz3NYfvCi281nyJXqhc3le0?=
 =?us-ascii?Q?VCR+vZPwfxv2Cj02Nt23MELPbh7Apy0HhK6UZ+Jxeza45TDXFEug0X5mYAzY?=
 =?us-ascii?Q?707kapmO8BAaT6uhVwqRrR+YbctLkBeco0eENmgSn8oPWiOD2T6sQrxHvpwi?=
 =?us-ascii?Q?pSMyaoueG1678FmgQOkahs5ejENdxiB5Da4Sy+i0Uy/sDoHEI709mS90vrv+?=
 =?us-ascii?Q?4P7v5JbtTk+57oExTwX5QiZ1iZoRgvLS5DJRXxltU4unOURZNlNRwnsCtUGy?=
 =?us-ascii?Q?U+Wl+EubjNgTEGax21Ixq62FXnLPF2SBspKfiM5M7qlyrWR0CkZjQBzVeS1U?=
 =?us-ascii?Q?SLHtM8k717/wnyayi49USYWtpnepeq+t0+O2vRS0pbNg0nvy8xMgsfuKV3H3?=
 =?us-ascii?Q?KnmjPg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uNRBDfB2g3OPa8nGYGoQnQBLyMXJeAal6EtBCg2rwZjGZAze+E1WrtURDYp5DVSYyaMV+ZvFmLNdxXwYBJf3UgvDz22+y365UH0QOLZfKHcQ8t5rpLVLyDQ2O7+ylp7DYbYzTT61lDDBrqSuSTZWdlvBcJ3iB3MhZuto78HajSJBVv7obsiHNiXxqb5ZTjzehvSqYLW411ahvTBba/Ldc90qz7YALGB085XU7hOkj5xmjzCGm3dbORP2IpbnbK2ilUXvkrUexHhV7bHHZiO26afWdBNeEQe6lcjmRybxOOduJAtZKpPEk3LqxICpyd8pAjXGWqljZmGZOGneQ7Zzs7h0tbKjm/1eFfNDaQ1CiBAnbkOaAnphxmDTuhShakVAyEKbfxIyWCOvLr5aVxPzQKlMUZ7eWg4SbhSeHLl5b3B7s2FJWMXs4cS2xXFvpZSEh2G6PW6lrijJzl4tHwX6f0LC6vgSLPHAHnfYlvmLafbDFpyg/e0d5O/XFeLkutCLqd98VBkjaCWtuOLY9iB30pL7xnhpSTDErEyQBc+luE/DPrfZMoymJk+sX9MBoaViSG80L4IDx9VXP4KJhQCbc7vN/bAeSFogr5e9o2aSB7M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b8314b-0fea-4a67-46e0-08dcc1ae00e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:53:46.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uk3HOo8MT/egNBwzBF7mb09aERp2D2QSCd6EB/54njvZkTXSExaR2bf9/JBNeOeUpa9u1JoGkl+Rx9cSLvdzehdFdLYJvnknPzdp+n8gf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408210049
X-Proofpoint-ORIG-GUID: lHJJXa27YN8DAQqiQT5Ed6Ft9S90-lCU
X-Proofpoint-GUID: lHJJXa27YN8DAQqiQT5Ed6Ft9S90-lCU

On Sat, Aug 17, 2024 at 01:18:31AM GMT, Pedro Falcato wrote:
> Delegate all can_modify checks to the proper places. Unmap checks are
> done in do_unmap (et al). The source VMA check is done purposefully
> before unmapping, to keep the original mseal semantics.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mremap.c | 32 ++++++--------------------------
>  1 file changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e7ae140fc640..24712f8dbb6b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -902,19 +902,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>
> -	/*
> -	 * In mremap_to().
> -	 * Move a VMA to another location, check if src addr is sealed.
> -	 *
> -	 * Place can_modify_mm here because mremap_to()
> -	 * does its own checking for address range, and we only
> -	 * check the sealing after passing those checks.
> -	 *
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
> -		return -EPERM;
> -

I'm honestly confused as to why the original implementation felt it
necessary to split the checks. I guess for the purposes of efficiency? But
doesn't seem efficient to me.

>  	if (flags & MREMAP_FIXED) {
>  		/*
>  		 * In mremap_to().
> @@ -1052,6 +1039,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>
> +	/* Don't allow remapping vmas when they have already been sealed */
> +	if (!can_modify_vma(vma)) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +

This is much better, and having it be a VMA check is so obviously correct
here. Again confused as to why this implemented at an mm granularity
anyway...

>  	if (is_vm_hugetlb_page(vma)) {
>  		struct hstate *h __maybe_unused = hstate_vma(vma);
>
> @@ -1079,19 +1072,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  		goto out;
>  	}
>
> -	/*
> -	 * Below is shrink/expand case (not mremap_to())
> -	 * Check if src address is sealed, if so, reject.
> -	 * In other words, prevent shrinking or expanding a sealed VMA.
> -	 *
> -	 * Place can_modify_mm here so we can keep the logic related to
> -	 * shrink/expand together.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
>  	/*
>  	 * Always allow a shrinking remap: that just unmaps
>  	 * the unnecessary pages..
>
> --
> 2.46.0
>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

