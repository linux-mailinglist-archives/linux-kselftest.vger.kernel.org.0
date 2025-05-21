Return-Path: <linux-kselftest+bounces-33455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F456ABF39F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8723A80DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5C26463A;
	Wed, 21 May 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IdY3nkQU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tsxu4T2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90C18C00B;
	Wed, 21 May 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828903; cv=fail; b=fuUwpQfM2ypTtla9WlOnJVumUCLhaOEe8HftwNAlRBA0WqeTLV52YxLYmkzU3wqBujCeHTBEnxJ6c/Cuy87aRkZpP/mLYu+oG75FsVvnkAsiVPyIZcJPFno0xnQ0bcQjS3gMNl7ESGyxDkCXMlbghG1IuliitCbk76mBK1/uN9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828903; c=relaxed/simple;
	bh=V/gktaOt2JtNTA/ds3qrkjmnvmoaEe5G8e36fcW0iqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cK/g5qrPLft6ODTzFBUcV92y0z7i6B2ywJvzs/UZ618rmfe4+PawbNyiFHjFoCyKOXTOdyGaGzTukrUI3PAnAU8p3N1hbRVCVfDL6CX7sdnb6fJbwJH8xnrr/PRDnMzxTCVcTJ+kYd3VPWXXI6B/ArhY2oZ0nNjhm0PON17U0MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IdY3nkQU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tsxu4T2r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LBM6KI032425;
	Wed, 21 May 2025 12:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6vL/N5iy5caonSBpe2
	/aSftZfZ5h/mKalkIQHInQ5LA=; b=IdY3nkQUnzirGY+QS6xOuyWILXM0HT5r4u
	d3CZHsVe1R/bGAj6bvkWStWw4gSSaUqNrGypivkIxehEX/2SO9445Yp56budVoZr
	N6V0OP5CC66ZWZEGfXlUIPLSmZCPXFaOdm3729zUiOPy3UV/F9jgiBhfmS9DxcSR
	1N/3yS2rkbvckMWz/fWiZyDjDfMf4f7ZTGLD1sIW0OCcv+d2hxaMM0nM53Aw94Xa
	V604m18EsUfo7cIBs9qgremmECWesbfNllrXqZBIWhGoZ3BY3GZ99h1JrrNbF+bH
	fWvRsLzVay4U/4OuWtCu5/tppyswO8V4NeGjbkAKQoeBrp0G9n1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sdw0g2am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:00:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LA4Exs033486;
	Wed, 21 May 2025 12:00:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwen88xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFqpYNTu9xPJEOpSIo2ZpX5IJJFUBwYzEHqBiPOi52ZxQFlE5ASgEDO/2uMbS2mfdBEu6rkbLFXJXxQK/tKHuL4R52xPTOwsqfEFy4wvsn0gcDctgsStK9ATNjQpTZIGU5nAW9jTrQsxYrkdwo1HmNh/cuUf135nBCB4hoGD+/lHF1byTZT5jO1oxY/sIybFr4U3zTK+PPcGKbGmeI57OR7GQ7bdrE6hH+/Gg1kHGGxIMupqTYjwBuZmRBuAggGMRY07gUVV3IB9dcDdHXH3LiClg1OtCo6uC8gZ5/+T8jd/h+Vp/VR0BspuAm1RG2RTQu6XcaUuwj/jhiRDlzMLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vL/N5iy5caonSBpe2/aSftZfZ5h/mKalkIQHInQ5LA=;
 b=kFIzwEUmtUdFMj+jQ16ENIoaLm37zTLq5TTpZTyDdWvcmtxrmqPSYBwRsYnG7wvaECeYvqw4E6Ix/ufDCQ0+mLK4EQcGiQfb3q2H/4f9FdZ2dzkfBWwCkGY+zIMjTeyyPJBSIU0buWdzOTR1SXWfBtBScZZ2htcJd16vJme67AQ9tOupLwdxDyVZ1K39hCwjkyhLvwziMoPZhh6W0Oc0ztv4MsWh1Kcc/HX9glMFM3naP9wuRYF+cO7GTSrfBGve/SQnoKrv8qKA9HRtDt4R7zQM662cBRoQrx77uqsopIc0BxsekoryzKcJfboO09BOnD5owiQjSAwkhAHr61/1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vL/N5iy5caonSBpe2/aSftZfZ5h/mKalkIQHInQ5LA=;
 b=tsxu4T2rsMfNE4tU+vM1n7deHzNXrMrhkAGQjdmmDiNQ19HE6DtSCdF/viRut/xo1XddsPaSXFg3Zm/chKumd8IuamtEU3iuZWXZOA3IJBRBxzeAQhe6M10iEg9egmNywW4C+PF6rbvrQl1sKy2/pUFloeF97VrBJIuso78AA7w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF92DC283F3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Wed, 21 May
 2025 12:00:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 12:00:48 +0000
Date: Wed, 21 May 2025 13:00:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, rientjes@google.com,
        hannes@cmpxchg.org, rdunlap@infradead.org, mhocko@suse.com,
        Liam.Howlett@oracle.com, zokeefe@google.com, surenb@google.com,
        jglisse@google.com, cl@gentwo.org, jack@suse.cz,
        dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
        catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
        raquini@redhat.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, yang@os.amperecomputing.com,
        thomas.hellstrom@linux.intel.com, vishal.moola@gmail.com,
        sunnanyong@huawei.com, usamaarif642@gmail.com,
        wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
        peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
        baolin.wang@linux.alibaba.com, baohua@kernel.org,
        mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, corbet@lwn.net, akpm@linux-foundation.org
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
Message-ID: <a41ea49b-2bac-44c8-9a4a-dd55dfd0d171@lucifer.local>
References: <20250515033857.132535-1-npache@redhat.com>
 <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
 <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
 <43d6aa16-3e52-45df-9366-e072c0cb3065@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d6aa16-3e52-45df-9366-e072c0cb3065@redhat.com>
X-ClientProxiedBy: LO4P123CA0169.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a40507f-f723-4dd5-8ea6-08dd985f2016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j3xENStfN/dLtpsqszNoNymielZCfKwYkw08sdKWrkPRCNQljrsgDB/5HD+o?=
 =?us-ascii?Q?YmDtISdyINYC07yhTzs8whFvy39P6TGIy4kIdrSFFgx670Aoq+2N4FhkV0il?=
 =?us-ascii?Q?J9S11ZzUOD6Re5Uy9cMSBZ8hdY7KxOX/RLPjq4GqzvYE7DuZsuSoEHC12Emj?=
 =?us-ascii?Q?KKRsnEyvleNDH/mdDv1U70No/xpEdcce+ivEnTaydvJOE+21mn2voxqH995D?=
 =?us-ascii?Q?ZPwJac9+FztvsVXTLHgIlLbrdg05J08nI9Cgek1GVSRFr980KS7lQKc2WDCD?=
 =?us-ascii?Q?wXeURqeUyNPdDlDviz1u+yaBg/w2R83bAM4I6srPDqLFgqmGaa3foqXoEXAM?=
 =?us-ascii?Q?rUZ6AL+X5trWJWAiga8d+jCmXfHxstPYz1LCxUdNS/95r+koI0GTtnrou8Is?=
 =?us-ascii?Q?klq/mcwqYjBMpvZa+hwgnL880KCl+Om4EEC3X3lR7ncSnssl3NDvIgklqvZB?=
 =?us-ascii?Q?CUnjVWvTE/3d/SzzvPYcNboC4CHVQ0VDedzgHf+E8yEXYpKRI+2+mGECUoDN?=
 =?us-ascii?Q?qnPrShm8PF2Zl6aHpOpBjxJRGp2USieuNuwsuQ0ExEbPoehvlaplWZEFfufv?=
 =?us-ascii?Q?jCrXkroYhxwfV8m1ZltawGP8DyRFVbpleQe7k5vVTjxMEo7tw+HtR9DXPM6A?=
 =?us-ascii?Q?lNAqcE3Bz9OoMXfjW4zXoNjsrL2UpJrcua7nbLGv5Nwmp0FOzUsBBkG93TrW?=
 =?us-ascii?Q?Qpg+EevtNJAHjnIz527iztJYbBHYP0k42ZSYC9ZePJcSHrNZQxCgIWScynWp?=
 =?us-ascii?Q?lQJ/VdaDNO6bLCZCtTP3iXL798S5jan+as2NqxuiZ1e8WC6qTg68TN4qcJxy?=
 =?us-ascii?Q?bk8QYa0fDckr/mmHvxoPIsYtpX0JlAMdBNxjp/9uRtSbmsslUDl9KlnVnsnS?=
 =?us-ascii?Q?/14+YnN5OjXgX2GR+/hyngq20yiZKqSQlTpMK913160WPlID4aBwGN5UgPX4?=
 =?us-ascii?Q?k1ZAfeav3oc25Nk29nyOdySLtoSDYh3fkHUm12CgfK2ETZM4ETsOCtlMYQwB?=
 =?us-ascii?Q?0rtW6scQnnCheITkvjdvHRabXVQjWQHlELIHJOffgzV64nQAfd7yaQfVDlnh?=
 =?us-ascii?Q?rj1iCE12J6ePFa4x+L8kvC7Tr1/YE2feXn5VXT7XhZgrEhlO5Dlej1jJBLj7?=
 =?us-ascii?Q?QZ9BWwRNdP2ADazmphKSc9hr6ez8y8KRxA7ObuUJ6klqsv6BFoTeXU20fr5j?=
 =?us-ascii?Q?OQ0OeuqquyhdR3TnZG/zdVKktOuH40gRFmBoEF8dHT0B5FBeBaDO1/sH+7Xv?=
 =?us-ascii?Q?KAnB9i+MzKHt29r9usczY9vnxSGv06WY4BAhjSIgn13vv/3SyQ/P2rq9orjT?=
 =?us-ascii?Q?2TWl7eBVn+nqXDVJ3I7OgjI7pjWtrctieZLvWDAWCtU/6X0+0T4RCAkmGqyq?=
 =?us-ascii?Q?vrLh3es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxcvqlbUqOwwXValpANs9qNEhExCJLqoKjj11Ws7uCsm6xl09AGhS3pskDLG?=
 =?us-ascii?Q?5ExE7BOoBpXHCxt2J4n0UWvaySMqZ/u2bW0ARf8vz8ub5dqRWeQubmawzUqC?=
 =?us-ascii?Q?WycgOcSvzp9SLyc9Bv84FbGejJIQ6g+ZWG6wC7ZCZrz3seP6m6YC5joxlEfJ?=
 =?us-ascii?Q?QDURA/fcGZxlBgdpjDu8x6ie9I9dQMzgxS8K93ecv61a/gH5HS2TgdvnJEAe?=
 =?us-ascii?Q?xopE42J7BO3KmZfqB5Q+Px7rpIX4nG7JiZqGCB0qRafrzawkxzRqKgbpHi+D?=
 =?us-ascii?Q?lU9lhICDZqrAWr6v9dA5E4BkcrJT8J0KJN9nCs4WwGHdPR6903gL9j1FQQJE?=
 =?us-ascii?Q?XlySAxF8QZkcDKpNP5s4Ekh6/14IJl26at9XhCLqHToTJ601NLWAbVGoxIit?=
 =?us-ascii?Q?O4ApIG00heQvSIpKNIUVHytIJ53W7Q1ba38kvgqZGIF//lBhoB/tncVuKKPP?=
 =?us-ascii?Q?E2VSr7qI+YSK8ByvvxFtvEd5s+uqCowU86rEb5hPRM+2XXm8DatirLFCBaXc?=
 =?us-ascii?Q?2kWWg/Llaa35YlwhSjOxKK5nTBgPGPFoTOMi7Pqyv3B0UViSKnBN3J0aI+4+?=
 =?us-ascii?Q?3k9nVQPoB7gLiisWE0e/wDE9ePVqVzwc0nHZfB/WxxCNzNHrQr9B7kKVleug?=
 =?us-ascii?Q?DCHwNc1WdXCre1xEXT64WdDvVhAdFrH6fPFM4EUtgRqlpgdfLpDaSHlgBYW4?=
 =?us-ascii?Q?Ugqn/VwZ6URbID/3Upq1POJaHgWcsV2jD0at00exIo1W5/EBXGvAXg3Giql6?=
 =?us-ascii?Q?6OUwsKQg3lOtcq9Znpbz6YBexoxblWu7/j/OEQVRzYFozDKodSMQzaZN/vsY?=
 =?us-ascii?Q?uv2SI/cjtq+LY7TmqczeK2cvAnWUrrvQElw3IXxhHS4F33rva9+KJ9L3AdSA?=
 =?us-ascii?Q?fZFQy5UwMck/RiMcWB6nB3CHfUReN9gR/u+b+/PBuQIlf7avKyvSPx9qQrNn?=
 =?us-ascii?Q?REV7I6mEt2vMVQSSScRV5H+FovT3dsRxYD29lb07tELZvOoOeXw4PLGKzMSi?=
 =?us-ascii?Q?RL2rWoDqVpED8Etx4PjEM+EGTNVy+ho0ZSrjtLEOC8CIWkEZ8RM9zNGG0Ze3?=
 =?us-ascii?Q?2yB+wXktBOVRnf4XFK45y+3ICp+lQodh/jiL4CrJw0hGwyrFRIOZuGSKHNg0?=
 =?us-ascii?Q?d/TdsJlBDv9IZiMHChExNX13+fBFoLWu7CZByb/WWOVpAxw6OyN2aPwoIFb7?=
 =?us-ascii?Q?SPHhhOHaJbsIUKCWKLOSMNrLP3eHIGNEmYdegtbi4IHUXLoBTcViSGiSqBId?=
 =?us-ascii?Q?g2NuTcdgXD/Zz5H22qjv+I18d0I+MOi8kXLwEB8d2AAoJV6mR7u2JEPSySUv?=
 =?us-ascii?Q?Xt35UhY3VqYiIoCSkfSZYdv8kS3BdyKjWNaCUS1MrM3iRwwA6liAkz++fjxD?=
 =?us-ascii?Q?E6rrd/WRfFqQ+4NaNJTvGgILV6u7aaWhRDHiVvPJm6x44jV1xBNRj07y5HDC?=
 =?us-ascii?Q?RDnkcFMRel1YW3/+IXoSgia0sQ1ZzyVdeG1sgoXwDu9JtmesfLkYVOIAg6kT?=
 =?us-ascii?Q?In9kMOKvlAk0tmTYJdNlgtPik5lm68B6o2FblzPG16k/zq5UKk25uygIxSWh?=
 =?us-ascii?Q?MsD/4r2TAaesZC6ZsFg0EGpodGOvYbp+7hnT371KEFx5IwU+i4YJ8JRafjNv?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZGlGqBcIm2POXLdm++VEeZPQ7SGfudWNtqAMbbhVNPVhzHRyBqoqQuZ5dzlZKvfqoCjDenDvjxBlkNAnAAyeQ18wC30wzZ+tBPCtRfZn0VJcQxZ1tIMsxXZV3tiRLvUteA8cOJydBXNilZI3ECP9hVAavDarQGEqLK3o2Pd6tRJkGaOAWO5vEbuvWMcm8epKcty3R7J7lS6KtklMoY4xUfDp5gSk3Ktdi2O4sVwgjnSFwy+ub9eDcAeFoqc7LmgSKlJkDshKzh2zFfnuAe63N3ZjNKQOxcSD7SH2bVUp1KL2Kr58n4Lo5n+5nmWzDwGFi8W3qIkRsb1nxJz/v9Bh6er89cvFHAOvNV5toJ9dBRbHnAmt8RBeFm1x8nlFXu6NZFGV1SCrgm9sDdWPUS4PzcA49T1cHzpwIC609R721ypxcSXXdDaBA3j6vLVHBYoaHQCAat9wWtxueZ2l8YLY89FR16+hx5Qvb6OCzlpzNWIGXGDBup5J4pIwFGtT9u247WUNQwrDaRwVNrpCe06FFdmS/uTW7mECf6O9o8rbY6HNkMDmDLsxh2TXfLTXrWe4DBLrXIBX7zd/hVvszlASYgTSkc0gm5mfVRmChUSG1Ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a40507f-f723-4dd5-8ea6-08dd985f2016
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:00:48.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0PZqM/LVErFJoYp23wQ8szwzvocmzyaLjfp4Ja+SSLVSqgRC7FCwq3OoG4S7ZPImNIJRC22rgEIhXQuM5hNm3ZvXY2nVbkjv0km4R0xoCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210118
X-Authority-Analysis: v=2.4 cv=ebE9f6EH c=1 sm=1 tr=0 ts=682dc075 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=sHC3IpwmtJrE4aVBlOYA:9 a=CjuIK1q_8ugA:10 a=nT7k2FPyCkIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDExNyBTYWx0ZWRfX20J3hfMTNrP1 YhoMgkOiNxrOBRH871F/D9ZpmuTVPFJrCi7dE2Y4p7n8dv3UvC1Tbd6ZYsjXf2SxV/l0dT1PbRt tO7TIOWn/U9Q+hi8L1ASpKYdwVx28Jo/TRPjSVCrDOEp0KFhL75fvrEifHVYk1YPo1TVR14Kamn
 mReQPVJD4N6ERBeUlNIcGei6VhWbg+rOYIdatLNX+Ztas8BxOjqi4YozK3a6wMVAq6iwcHj08hf rM9Z/uRiANAocKy/ztWgT+BO7gRdm32SRlezKSLisj2Zfr87rQdlfUvbbMpvgN2+tRD4CP5DhSE okusspa8tKX4FmKMsoOak6bV/310EI91daFY2252wRbNFzblWRR3iHikg+gtrmEeG1gwapnnxCU
 /4EzdqRIfOuSFWOnSSTYWlb4MGBuEZZK3lbScDa9lpnFaIWGE3ygAZ5yjvOcJRTsl0feA3TN
X-Proofpoint-GUID: rcBe-2xq0n_FlscVLNR7fwa2IPPWHjgC
X-Proofpoint-ORIG-GUID: rcBe-2xq0n_FlscVLNR7fwa2IPPWHjgC

I think the TL;DR here to avoid too much back and forth is - let's please
make this super super simple :)

I would prefer anything that has a dependency to just sit in RFC until the
dependency is merged.

Or, alternatively, to have a big note at the top:

ANDREW - Please do not merge in mm-unstable until series [1] is merged, and
when that is merged please ping for a resend.

Or whatever it might be.

On Wed, May 21, 2025 at 01:46:38PM +0200, David Hildenbrand wrote:
> On 21.05.25 13:24, Lorenzo Stoakes wrote:
> > To start with I do apologise for coming to this at v6, I realise it's
> > irritating to have push back at this late stage. This is more so my attempt
> > to understand where this series -sits- so I can properly review it.
> >
> > So please bear with me here :)
> >
> > So, I remain very confused. This may just be a _me_ thing here :)
> >
> > So let me check my understanding:
> >
> > 1. This series introduces this new THP deferred mode.
> > 2. By 'follow-up' really you mean 'inspired by' or 'related to' right?
> > 3. If this series lands before [1], commits 2 - 4 are 'undefined
> >     behaviour'.
> >
> > In my view if 3 is true this series should be RFC until [1] merges.
> >
> > If I've got it wrong and this needs to land first, we should RFC [1].
> >
> > That way we can un-RFC once the dependency is met.
>
> I really don't have a strong opinion on the RFC vs. !RFC like others here --
> as long as the dependency is obvious. I treat RFC more as a "rough idea"
> than well tested work.
>
> Anyhow, to me the dependency is obvious, but I've followed the MM meeting
> discussions, development etc.

Right but is it clear to Andrew? I mean the cover letter was super unclear
to me.

What's to prevent things getting merged out of order? And do people 'just
have to remember' to resend? And a resend doesn't necessarily mean patch
set X will come after patch set Y.

If there's a requirement related to the ordering of these series it really
has to be expressed very clearly.

(by the way, I feel expressing things like this is a kind of area where we
have _some kind_ of a break down in kernel process or it'd be nice to have
tags or something to properly express this sort of thing. But maybe another
discussion :)

>
> I interpret "follow up" as "depends on" here. Likely we should have spelled
> out "This series depends on the patch series X that was not merged yet, and
> likely a new version will be required once merged.".
>
> In this particular case, maybe we should just have sent one initial RFC, and
> then rebased it on top of the other work on a public git branch (linked from
> the RFC cover letter).
>
> Once the dependency gets merged, we could just resend the series. Looking at
> the changelog, only minor stuff changed (mostly rebasing etc).
>
> Moving forward, I don't think there is the need to resend as long as the
> dependency isn't merged upstream (or close to being merged upstream) yet.

I mean this is still 'just have to remember' stuff :)

Do we need patches 2-4 if the dependency isn't merged? That was unclear to
me.

>
> > > > Because again... that surely makes this series a no-go until we land the
> > > > prior (which might be changed, and thus necessitate re-testing).
> > > >
> > > > Are you going to provide any of these numbers/data anywhere?
> > > There is a link to the results in this cover letter
> > > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html
> > > >
> >
> > Ultimately it's not ok in mm to have a link to a website that might go away
> > any time, these cover letters are 'baked in' to the commit log. Are you
> > sure this website with 'testoutput2' will exist in 10 years time? :)
> >
> > You should at the very least add a summary of this data in the cover
> > letter, perhaps referring back to this link as 'at the time of writing full
> > results are available at' or something like this.
>
> Yeah, or of they were included in some other mail, we can link to that mail
> in lore.
>
> --
> Cheers,
>
> David / dhildenb
>

