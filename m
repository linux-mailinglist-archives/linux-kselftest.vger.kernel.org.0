Return-Path: <linux-kselftest+bounces-33847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CFEAC4C02
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2176E3A3C7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126D1F4624;
	Tue, 27 May 2025 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PlYxkEcn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pvC9FSMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A462110E;
	Tue, 27 May 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340517; cv=fail; b=TmNpq9vbMHurfJHc8Y6bt1Tn/USp8IkQfMQNfHDdPD6/YE3GBUxKgX1E6H2vfZzyq2oRCPF3Rx8o4Y2az1HAyajk/24jp3yFL9ZCAv136gZ+/KOB43/WLNUdcNWHvFo6JUKRv7ZTeOJSV49XPnyWNRMt++0bpnMlq3ACzim6BdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340517; c=relaxed/simple;
	bh=sWVUFanZZk8vaoqddXeiZwN+9ZLjgT3VJbEq16mLxLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sEu8aVN+uaenP2pH/j1owpTukJ8lkebIgIPb1tomSbtGwPXZIjkS0/Le7UFRUzocFSCZD96sAvQbxEbb3wwgbmC+lf6jUoPkdaAYAedgqpYb7HpYAfmxJIEyV9WFcxFPeRmiqWT57iXjzO/UePrQBbLcLwHdB9HN1jX26Aafc48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PlYxkEcn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pvC9FSMb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R69llH002805;
	Tue, 27 May 2025 10:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Vrw0Nr1SmsmR5oPmzl
	TWMS2IowI0TLQ/Bd8CeL5IZYk=; b=PlYxkEcnWmZ18xN09PEIK8MBBCnxL93WCK
	6ncoIQsuVQmwef99fKmrCGB/eZi5MHi6EB2FLGSqDUDHtX10GKCBLogToVDekgik
	hZQGuyoLqdvfWEq4VvvDlygKp1fEipuprX7dyovYEbfh6VyBC/TatiRFKrnWyDBG
	6lFKsbwcahyZDfcCNddBiCaY/8dnorUIxEeymusuWiIK9ay20KGJLx4WvsBGwaEN
	W8wpwm13MbXjJKwATIH8D1gBkU74BKEwaI5cRRGeQX8jsx+HvEWyZgG9VUzIuqi5
	y7G+IxyDBP1/s/2ITkK9QbBvuGo3lkNQuM6R0d9Ps0CKmNocdbvQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd2r8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 10:08:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54R8aArR027873;
	Tue, 27 May 2025 10:08:21 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j8ph4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 10:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGaAAe6NnERhoZDK3OsGokqBCQTeeYvY+9b3plad60WMFcWKSQhTA54XGcdK29IoTk/M81ZeW8jf9KfqZ6Cat1zMR9RhYrPFjiD2Yy0/IsBXyRgP1tNkUKPA8N6hWdaf5FOCFM3wjQd6a7mBfsGjlaMXfZLvrs7UfHD091l0p33+9dvrKLh8ktscLud33Fa4tBNXCe76/GgO2br0dbkYeVlNuQrXPKq+/P998YPqi/uX9vHLtM17Z6p6q12eJbsWMHRTsZ5jfTyBxXUZANYJDf06TUnw4m/CiVC52qrcrMoL0NOG8tR+dbWKBhsE/4rel7v8Fo5tUFKdQrSpYT7vwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrw0Nr1SmsmR5oPmzlTWMS2IowI0TLQ/Bd8CeL5IZYk=;
 b=arN+LXIlvVaYyjJNGALjx1qyRsbb3sImHwpYfkPLUIVfqlN7osCilMWgmHK4Rm2V+nRMcyfpfvZyA3MNqRZzWitzfpjlZSzC3lJEzdNlN/VJN4pQM464P1oErS9BsglD0cr0SA1DFq8vMrk8bXfbGeDQ8RYpRa1Tfdh4t84B0NteD90o0xJ4kALi9d7i486mnzYTWZ40LHLtTedlRhmR1L0r9AS7yt3VF/tHaAxcxDiQzKA8BGR0sIVIgA8XGLQZULUexaka90Fm0RdakR0tK1uKbI1fzgaq0sXYqMcTap6RWjLcjSTzRbNX5EO+PP4eWqG+kbv2sWvJk0aXRNuosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrw0Nr1SmsmR5oPmzlTWMS2IowI0TLQ/Bd8CeL5IZYk=;
 b=pvC9FSMbd1Ha7TFhvlFMh8uS21ZyoNb5kcVK1QE4ea5PIdpvimeT3i+BMwHVUX8Qa4/PNtZYbyk4weokduVYQROBa6VczUY2RM4UotzAQ8CYkAZ5C8Qfivy4JYfVRAuLkKkxyr08HfAfewTqNMVx25l9E9Xy9A+cImO4AN0Ano0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 27 May
 2025 10:08:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 10:08:09 +0000
Date: Tue, 27 May 2025 11:08:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] selftests/mm: Report unique test names for each cow
 test
Message-ID: <3745cced-199a-4c9f-a282-d9587f2edd41@lucifer.local>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-3-713cee2fdd6d@kernel.org>
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 213511ec-2ba2-48c3-d064-08dd9d066192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?488DAKy3LV160QDFhJ7KusjLUcYnAS1BjDDBse1S0zD6U5H5PhgLyQzNWJda?=
 =?us-ascii?Q?lCjxAmmf1/E1P77ssFRBjFmjCDfXOToFUgeaiuGFXnz2pXRx+C8kjGpGhMep?=
 =?us-ascii?Q?ePsY+RO1bweT3GGOAed/1JKyNR4ZiivARQ/GKJtgT2bDSDV98zA7stb+RSeN?=
 =?us-ascii?Q?AegWFQmkv5N6UBYc+OgF5han7gfBKuXpXmivkJDvtuzpOzGNWUP25O24Xm3k?=
 =?us-ascii?Q?ITcCfTWhJoqH9lhh5ADy35F8/llZ+ar+DGb367+Tk0RdAqKfl0XLuECkXpNY?=
 =?us-ascii?Q?nRj5HqlUnr3yATvjh6Vcxj8xKAwbPA8byA9dRwVE85yMA9OpSPvdfAoUhKW4?=
 =?us-ascii?Q?5zxZahUs1ftaCtVCGJT7OSTMMqzu+64KakPZu5nfNNf4J35t5LV/fMAXAW2k?=
 =?us-ascii?Q?497uPd6m6xfPxGesa/ByRUByVnm2eokas5vmVo0Ds23M/rsneFEkKIgcEo9i?=
 =?us-ascii?Q?ykfmj9MD8a7K181AYxBZYM7eBWSpN6y+1e6ApOWP9ezb67dA2Uxu5mwRfq8i?=
 =?us-ascii?Q?WIco0xVNuPLCpnYK0FaOMKb/snh1wcRVI9/geQGWQV2SjLrvrUl0OMq8IxLH?=
 =?us-ascii?Q?hVgzg9xA4/BKgORmG1Q1HzvLB80F0pKo2a5kj+/hkQRTDQPWYffLXy89Wpt8?=
 =?us-ascii?Q?UdyJIhEam352fUfMIGabeGJv6Z4LB4VTjAww4ztOTWO9TGJxQDT5ty8FooaO?=
 =?us-ascii?Q?3tyWqt/6DR9k0L+S2aTpnYtbk3TmcfVWaL75aWS9qDuaC1LfCy+J9dUwwwAn?=
 =?us-ascii?Q?6hFTUDa97UupSfcSC8rkLa8dCbOgZW3bLizmH4tgxmuAVmR29Yn/JbaiYfvw?=
 =?us-ascii?Q?GNk2MGbgo6GzZ7Ol1SFjF4Vr7eww46w2zzNhNu59ZcvPkJaCScV4yyE0RRFq?=
 =?us-ascii?Q?VbmmV2Yyy2hYvoG9nWUaycTLtqug02x3kEzTjtjBRMHEvZSbzGwoIYfwtgSN?=
 =?us-ascii?Q?qbTOfOR6yj3r/tvZYluXooU5k0Dow8nZB8Q3vf+UOFqXoETVkT45yt3WBNxn?=
 =?us-ascii?Q?TNrqBoO17VZc7UhaT6U58C0HsydHPLBPGTfId7p1ehM2ujpQTFA2vuS9GbVm?=
 =?us-ascii?Q?yctVOWEFfEIpxfqApx+0xuRR1RgwYAdXS5AvD2NTFvyOZGv/knCFpZQ6Dm/+?=
 =?us-ascii?Q?uZCwUt3hJ7NFwmMjHu10YdMMyplszTUiI9DhpS3mR3FKMj+EdweWVhAhc3Ea?=
 =?us-ascii?Q?uuVeoVCEKCZl+iTEiosvKSMTfS1dgOvSPqjAbLY6m3svcu0Vb1JRatIZGT3W?=
 =?us-ascii?Q?DPhK5yrzjuGg6VrOGrqHlyqqPxnt4OoFe0O+dI5la9umqQw0C9AExDodbO8V?=
 =?us-ascii?Q?gplMvHcYlWGeEDpHdf7lyOynhRP3gAOtfG0N3x+T7avL5euzeDfQMDDlrFg2?=
 =?us-ascii?Q?wwPJN1YeDrIQ5dCYGoQWCz108PFfHsIa7G94rKpg7Ce90VSVekQGajHAKFIK?=
 =?us-ascii?Q?18tyO9f6jFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?24Y9fjv3vJw9c8SLsjY3P4/S+jl9xh2yrGRLjZjnCl8M+o+Urtqu3oid1KvC?=
 =?us-ascii?Q?oxS7S0KipbHvvneG+vXTT9EieJv7TWPHs8Wo3ryiEHC0a0xvQSreyJNJU3s8?=
 =?us-ascii?Q?aXHrWjdfwrMX7v/r/tuz9vqY9ntxIzYhJ3T6vvOFi8uS8oYTJdTSqgFiYUBv?=
 =?us-ascii?Q?7ZLbMmMqZr+Hys8MlynSkE7GR0SYlKcya37K2bsu0bf/q+UOA2UQYPJvgZ/W?=
 =?us-ascii?Q?myZ1MO6zjiazEPcIrhrgYJkh7SsJoeaJqbSq3TRmvnUhn33UoHjMhVfNjdIC?=
 =?us-ascii?Q?mk4OX/fYebpB+ZKQKnFC4BxDbvHCaTdmS88rQoEVWkCClA9qrY1CMTeat7qW?=
 =?us-ascii?Q?D+qNhX2e1b+ynN5l6pT3UsSXTRzeVNzwMraaQ3dbVJO8wRuTOOJvdJyUFoCh?=
 =?us-ascii?Q?VpxGQq4JF1w9Mbcj7Eis/OP0thDFd+um1TDKtTq9o5NrhQEalzEylsRDF2If?=
 =?us-ascii?Q?FYGl26fMyrWcQ9SkuaIBIlXAruBgPZeK/T+bQwakTSQcQd/sDCePQbk++8kD?=
 =?us-ascii?Q?cTVTsW2WODGjNTFjdsf2Qx69WsyoPgXDeCXjhTj0rcHhp5XhHk05VrtQB5hg?=
 =?us-ascii?Q?JmqDrsOCDFsrf1J21tP0cJTjG5FEfMbFmSxGdXwahlsL9UTTfpee9/cNCMJG?=
 =?us-ascii?Q?vNaqBKkA54uGbwOwLw8Qnql7xs41k9xp18rl/zpdokrBjLB5+pZ2cZ6JciPS?=
 =?us-ascii?Q?rX7k0zlM41L2RendvtqtLg0SFQpCeMmIgMcvzSYjyycikLC+uAQUWAy6sx47?=
 =?us-ascii?Q?B4RzXxjImkTUBG6eX9X0HfJ9nxGx26SrQ59NedhZlT+/3+cbXzLDZsOQXCBi?=
 =?us-ascii?Q?GlQpRBPK//lHKbNIq056VQaQOhYC1geakP+Thh4ITtYKyBZl/5XS2fTKHizr?=
 =?us-ascii?Q?YOXWlGE/tQJU4qKG7O3RAqbHPLzr67UV2Ozz555QIs3UYJ430wm42j54itmY?=
 =?us-ascii?Q?s/B96FZSdrSfnsBjXUp4+B+19xgR47LS4FDAP4zSPeMPtIHYYcgAdKJw/KaM?=
 =?us-ascii?Q?V32pHJkqnSUw0MqS3VHlq4hn0WB9NGpmSfru0zSFMxUyQs/Jf6AdzXqHNAhP?=
 =?us-ascii?Q?CU1oT1m3m0SUSgLc5Xmvgc0U9AFlS/vJ9OyDXxwG5goyVWoKv63YEW8R+zIU?=
 =?us-ascii?Q?5g96xP/ixtTqQNHdliS1dNKsRbXMxHy3rcAp2TNUtCW1apt7wdgH1OY8eqOO?=
 =?us-ascii?Q?U76WLtImlvBPj9rOf2qZ9uPiBiUwOm3HI5d9P+PcraqhxNLftAsgWp19InfA?=
 =?us-ascii?Q?L7bSsZVvfuB+mC7Zs8HyrJfkAXr/KuH9Rktff7315XMl6KQXw3aoBuo2vHP/?=
 =?us-ascii?Q?+VzGXu0D3rErDWs3ng3Vo1nw54aEeWuQTbRuSiXhInnjX/qPWP/xhtUVGIJQ?=
 =?us-ascii?Q?XCyejlY09Kv58jZ4Y6zBFPeSoEm+/IJ1r6c+5Cbqjn/2nvnXn6BW2Kcp19x9?=
 =?us-ascii?Q?kSTrwz7kxGoXwkwqXutirBMn7B1iDnZnlEQHNzOmdhaSk5CYI7cyQu6KTGtQ?=
 =?us-ascii?Q?9nIeao3bhThHwk6X+9Fo6dW+H0+kg8zBi/TrE0TMcJf8iL99SV40qunkxPiJ?=
 =?us-ascii?Q?8oc8W0bZN8FUb7wvSfyz0MeO7PSLARR59q4RE3ElOhtyiiWOUqpmMKaYVheN?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yEh3jmm0+Y0RNENSNbclNF0oNNriFOf9n0FtSYhrCPVijhC5R8KdJ2QbD4zX80Bj/WqgQ81qk42pty/6zmHjZCgt0BywYIngAq1DFwzx7ollMfa72G4kbKniqaEYJ0EkTQ3l1fRh9UGazt2y11uj4Yln6bSwEmDp4LOKc5zD2nCwO7q+YF8hGjCOR62lKQgwR6GVIoYrY09vaIyb/bLAerhg91mPdVjEBRVUUAbE4fyu7XXVKZnUA3Q5bwdtY4mq+MwIA+Ot9dYuLfRBavN3+94AfsB792xjYhvFOYvpO+sx6tQ0c+3HQnpn7dZzAJgQFPrurY4feXjFu26hmEd3SvsCaX97R8UK/Oc6sHpCRK8QspW4Tvu72zgaLgS6h3EZSdGR1LmdtF86Xvei0dRtm6WLaah03uOIb7LGwAkLhBzV42scX5fXfZfaygp56PQgHfyhamU1YraWoCigCi6LApL3TpGE3yIIX89kcI4FevWN67g/iKluNB3Hq9+v/InDQY2C6QFO6OI8v35spcRkxpzbXx3zVmLwWJbtENyR+1ZF6v0J3KqSKP2euj/3LrXazXu2uu6cibqQt+ag/UHf4+sV4uitGdLVuqHItStPNR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213511ec-2ba2-48c3-d064-08dd9d066192
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 10:08:09.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5nTJ1gevBKH8El0ku9e2bWVA60jGOb6e4915mY/ewM96cMlN7SzVuswgsbhbY0P11wigjMkgEgOfEeejRQ1nnCUtnQMqvVA3bKxFUxCH4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270083
X-Proofpoint-ORIG-GUID: ntYjXMcQZcgSlk__1bm5oEHX4rcKN7XT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA4MyBTYWx0ZWRfX4ALid7HBz6Gc DP393AtzNj55jOvtTCZRuTA8CtHZ4K47Q6pp8qFn6hmT5zC5dHR66l/bj/ruuUWNexUKAFkus6x s0L4ipLtdJxsBZuU4w5swYle8YZpcUpOCr1laHloaxj4GUIpnHkh5LI9fnE7SWF3GTqoO061UNc
 Atrar6Au4eMlzgFWpVzFh4Mavl/ZWTJM/tnmeGwuPpA9F+ZtHFinuak1H11m3vPDxNzAR/A7PEe KIzycLvjI58Q66L7GWOEgYms4wzJvfDA1ASDd8ONe5f4vR5nLWQzDm8nmRCNkhN6WU7ncRMoFPW B8uG1dTYmTKv/Ze6Xv7amSycO7Y5hfAQOiiwRdQ3uOSUlxGdluR9FcLpQ7BD13kvIxA9KZ7cxZd
 t0JyW8cnFG16rzMJjWPaftcm5vjvau23dtq/Uo7H9DXlO86bXqYJQwVARwPVfCE2FPMp3YL3
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68358f16 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=jLSmZfShH1B5MZ_3vvcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ntYjXMcQZcgSlk__1bm5oEHX4rcKN7XT

On Thu, May 22, 2025 at 06:38:52PM +0100, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The cow test completely fails to follow this pattern,
> it runs test functions repeatedly with various parameters with each result
> report from those functions being a string logging an error message which
> is fixed between runs.
>
> Since the code already logs each test uniquely before it starts refactor
> to also print this to a buffer, then use that name as the test result.
> This isn't especially pretty but is relatively straightforward and is a
> great help to tooling.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/mm/cow.c | 333 +++++++++++++++++++++++++--------------
>  1 file changed, 217 insertions(+), 116 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index e70cd3d900cc..a97f5ef79f17 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -112,9 +112,12 @@ struct comm_pipes {
>
>  static int setup_comm_pipes(struct comm_pipes *comm_pipes)
>  {
> -	if (pipe(comm_pipes->child_ready) < 0)
> +	if (pipe(comm_pipes->child_ready) < 0) {
> +		ksft_perror("pipe()");
>  		return -errno;
> +	}
>  	if (pipe(comm_pipes->parent_ready) < 0) {
> +		ksft_perror("pipe()");
>  		close(comm_pipes->child_ready[0]);
>  		close(comm_pipes->child_ready[1]);
>  		return -errno;
> @@ -207,13 +210,14 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
>
>  	ret = setup_comm_pipes(&comm_pipes);
>  	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	ret = fork();
>  	if (ret < 0) {
> -		ksft_test_result_fail("fork() failed\n");
> +		ksft_perror("fork() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	} else if (!ret) {
>  		exit(fn(mem, size, &comm_pipes));
> @@ -228,9 +232,18 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
>  		 * write-faults by directly mapping pages writable.
>  		 */
>  		ret = mprotect(mem, size, PROT_READ);
> -		ret |= mprotect(mem, size, PROT_READ|PROT_WRITE);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
> +			write(comm_pipes.parent_ready[1], "0", 1);
> +			wait(&ret);
> +			goto close_comm_pipes;
> +		}
> +
> +		ret = mprotect(mem, size, PROT_READ|PROT_WRITE);
> +		if (ret) {
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>  			write(comm_pipes.parent_ready[1], "0", 1);
>  			wait(&ret);
>  			goto close_comm_pipes;
> @@ -248,16 +261,16 @@ static void do_test_cow_in_parent(char *mem, size_t size, bool do_mprotect,
>  		ret = -EINVAL;
>
>  	if (!ret) {
> -		ksft_test_result_pass("No leak from parent into child\n");
> +		log_test_result(KSFT_PASS);
>  	} else if (xfail) {
>  		/*
>  		 * With hugetlb, some vmsplice() tests are currently expected to
>  		 * fail because (a) harder to fix and (b) nobody really cares.
>  		 * Flag them as expected failure for now.
>  		 */
> -		ksft_test_result_xfail("Leak from parent into child\n");
> +		log_test_result(KSFT_XFAIL);
>  	} else {
> -		ksft_test_result_fail("Leak from parent into child\n");
> +		log_test_result(KSFT_FAIL);
>  	}
>  close_comm_pipes:
>  	close_comm_pipes(&comm_pipes);
> @@ -306,26 +319,29 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>
>  	ret = setup_comm_pipes(&comm_pipes);
>  	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto free;
>  	}
>
>  	if (pipe(fds) < 0) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		ksft_perror("pipe() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	}
>
>  	if (before_fork) {
>  		transferred = vmsplice(fds[1], &iov, 1, 0);
>  		if (transferred <= 0) {
> -			ksft_test_result_fail("vmsplice() failed\n");
> +			ksft_print_msg("vmsplice() failed\n");
> +			log_test_result(KSFT_FAIL);
>  			goto close_pipe;
>  		}
>  	}
>
>  	ret = fork();
>  	if (ret < 0) {
> -		ksft_test_result_fail("fork() failed\n");
> +		ksft_perror("fork() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto close_pipe;
>  	} else if (!ret) {
>  		write(comm_pipes.child_ready[1], "0", 1);
> @@ -339,7 +355,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>  	if (!before_fork) {
>  		transferred = vmsplice(fds[1], &iov, 1, 0);
>  		if (transferred <= 0) {
> -			ksft_test_result_fail("vmsplice() failed\n");
> +			ksft_perror("vmsplice() failed");
> +			log_test_result(KSFT_FAIL);
>  			wait(&ret);
>  			goto close_pipe;
>  		}
> @@ -348,7 +365,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>  	while (read(comm_pipes.child_ready[0], &buf, 1) != 1)
>  		;
>  	if (munmap(mem, size) < 0) {
> -		ksft_test_result_fail("munmap() failed\n");
> +		ksft_perror("munmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_pipe;
>  	}
>  	write(comm_pipes.parent_ready[1], "0", 1);
> @@ -356,7 +374,8 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>  	/* Wait until the child is done writing. */
>  	wait(&ret);
>  	if (!WIFEXITED(ret)) {
> -		ksft_test_result_fail("wait() failed\n");
> +		ksft_perror("wait() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_pipe;
>  	}
>
> @@ -364,22 +383,23 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>  	for (total = 0; total < transferred; total += cur) {
>  		cur = read(fds[0], new + total, transferred - total);
>  		if (cur < 0) {
> -			ksft_test_result_fail("read() failed\n");
> +			ksft_perror("read() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto close_pipe;
>  		}
>  	}
>
>  	if (!memcmp(old, new, transferred)) {
> -		ksft_test_result_pass("No leak from child into parent\n");
> +		log_test_result(KSFT_PASS);
>  	} else if (xfail) {
>  		/*
>  		 * With hugetlb, some vmsplice() tests are currently expected to
>  		 * fail because (a) harder to fix and (b) nobody really cares.
>  		 * Flag them as expected failure for now.
>  		 */
> -		ksft_test_result_xfail("Leak from child into parent\n");
> +		log_test_result(KSFT_XFAIL);
>  	} else {
> -		ksft_test_result_fail("Leak from child into parent\n");
> +		log_test_result(KSFT_FAIL);
>  	}
>  close_pipe:
>  	close(fds[0]);
> @@ -416,13 +436,14 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>
>  	ret = setup_comm_pipes(&comm_pipes);
>  	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KAFT_FAIL);

Looks like a typo here :) Should be KSFT not KAFT.

This is breaking the mm self test build for mm-new, could you fix-patch/respin?
Thanks!

>  		return;
>  	}
>
>  	file = tmpfile();
>  	if (!file) {
> -		ksft_test_result_fail("tmpfile() failed\n");
> +		ksft_perror("tmpfile() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	}
>  	fd = fileno(file);
> @@ -430,14 +451,16 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>
>  	tmp = malloc(size);
>  	if (!tmp) {
> -		ksft_test_result_fail("malloc() failed\n");
> +		ksft_pring_msg("malloc() failed\n");

Also another typo :P

Makes me think of pringles so that's at least a bonus ;)

> +		log_test_result(KSFT_FAIL);
>  		goto close_file;
>  	}
>
>  	/* Skip on errors, as we might just lack kernel support. */
>  	ret = io_uring_queue_init(1, &ring, 0);
>  	if (ret < 0) {
> -		ksft_test_result_skip("io_uring_queue_init() failed\n");
> +		ksft_print_msg("io_uring_queue_init() failed\n");
> +		log_test_result(KSFT_SKIP);
>  		goto free_tmp;
>  	}
>
> @@ -452,7 +475,8 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>  	iov.iov_len = size;
>  	ret = io_uring_register_buffers(&ring, &iov, 1);
>  	if (ret) {
> -		ksft_test_result_skip("io_uring_register_buffers() failed\n");
> +		ksft_print_msg("io_uring_register_buffers() failed\n");
> +		log_test_result(KSFT_SKIP);
>  		goto queue_exit;
>  	}
>
> @@ -463,7 +487,8 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>  		 */
>  		ret = fork();
>  		if (ret < 0) {
> -			ksft_test_result_fail("fork() failed\n");
> +			ksft_perror("fork() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto unregister_buffers;
>  		} else if (!ret) {
>  			write(comm_pipes.child_ready[1], "0", 1);
> @@ -483,10 +508,17 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>  		 * if the page is mapped R/O vs. R/W).
>  		 */
>  		ret = mprotect(mem, size, PROT_READ);
> +		if (ret) {
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
> +			goto unregister_buffers;
> +		}
> +
>  		clear_softdirty();
> -		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
> +		ret = mprotect(mem, size, PROT_READ | PROT_WRITE);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto unregister_buffers;
>  		}
>  	}
> @@ -498,25 +530,29 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>  	memset(mem, 0xff, size);
>  	sqe = io_uring_get_sqe(&ring);
>  	if (!sqe) {
> -		ksft_test_result_fail("io_uring_get_sqe() failed\n");
> +		ksft_print_msg("io_uring_get_sqe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto quit_child;
>  	}
>  	io_uring_prep_write_fixed(sqe, fd, mem, size, 0, 0);
>
>  	ret = io_uring_submit(&ring);
>  	if (ret < 0) {
> -		ksft_test_result_fail("io_uring_submit() failed\n");
> +		ksft_print_msg("io_uring_submit() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto quit_child;
>  	}
>
>  	ret = io_uring_wait_cqe(&ring, &cqe);
>  	if (ret < 0) {
> -		ksft_test_result_fail("io_uring_wait_cqe() failed\n");
> +		ksft_print_msg("io_uring_wait_cqe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto quit_child;
>  	}
>
>  	if (cqe->res != size) {
> -		ksft_test_result_fail("write_fixed failed\n");
> +		ksft_print_msg("write_fixed failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto quit_child;
>  	}
>  	io_uring_cqe_seen(&ring, cqe);
> @@ -526,15 +562,18 @@ static void do_test_iouring(char *mem, size_t size, bool use_fork)
>  	while (total < size) {
>  		cur = pread(fd, tmp + total, size - total, total);
>  		if (cur < 0) {
> -			ksft_test_result_fail("pread() failed\n");
> +			ksft_print_msg("pread() failed\n");
> +			log_test_result(KSFT_FAIL);
>  			goto quit_child;
>  		}
>  		total += cur;
>  	}
>
>  	/* Finally, check if we read what we expected. */
> -	ksft_test_result(!memcmp(mem, tmp, size),
> -			 "Longterm R/W pin is reliable\n");
> +	if (!memcmp(mem, tmp, size))
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);
>
>  quit_child:
>  	if (use_fork) {
> @@ -582,19 +621,21 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>  	int ret;
>
>  	if (gup_fd < 0) {
> -		ksft_test_result_skip("gup_test not available\n");
> +		ksft_print_msg("gup_test not available\n");
> +		log_test_result(KSFT_SKIP);
>  		return;
>  	}
>
>  	tmp = malloc(size);
>  	if (!tmp) {
> -		ksft_test_result_fail("malloc() failed\n");
> +		ksft_print_msg("malloc() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	ret = setup_comm_pipes(&comm_pipes);
>  	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		goto free_tmp;
>  	}
>
> @@ -609,7 +650,8 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>  		 */
>  		ret = fork();
>  		if (ret < 0) {
> -			ksft_test_result_fail("fork() failed\n");
> +			ksft_perror("fork() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto close_comm_pipes;
>  		} else if (!ret) {
>  			write(comm_pipes.child_ready[1], "0", 1);
> @@ -646,7 +688,8 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>  		clear_softdirty();
>  		ret |= mprotect(mem, size, PROT_READ | PROT_WRITE);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto close_comm_pipes;
>  		}
>  		break;
> @@ -661,9 +704,11 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>  	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
>  	if (ret) {
>  		if (errno == EINVAL)
> -			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
> +			ret = KSFT_SKIP;
>  		else
> -			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
> +			ret = KSFT_FAIL;
> +		ksft_perror("PIN_LONGTERM_TEST_START failed");
> +		log_test_result(ret);
>  		goto wait;
>  	}
>
> @@ -676,22 +721,26 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
>  	 */
>  	tmp_val = (__u64)(uintptr_t)tmp;
>  	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_READ, &tmp_val);
> -	if (ret)
> -		ksft_test_result_fail("PIN_LONGTERM_TEST_READ failed\n");
> -	else
> -		ksft_test_result(!memcmp(mem, tmp, size),
> -				 "Longterm R/O pin is reliable\n");
> +	if (ret) {
> +		ksft_perror("PIN_LONGTERM_TEST_READ failed");
> +		log_test_result(KSFT_FAIL);
> +	} else {
> +		if (!memcmp(mem, tmp, size))
> +			log_test_result(KSFT_PASS);
> +		else
> +			log_test_result(KSFT_FAIL);
> +	}
>
>  	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_STOP);
>  	if (ret)
> -		ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
> +		ksft_perror("PIN_LONGTERM_TEST_STOP failed");
>  wait:
>  	switch (test) {
>  	case RO_PIN_TEST_SHARED:
>  		write(comm_pipes.parent_ready[1], "0", 1);
>  		wait(&ret);
>  		if (!WIFEXITED(ret))
> -			ksft_print_msg("[INFO] wait() failed\n");
> +			ksft_perror("wait() failed");
>  		break;
>  	default:
>  		break;
> @@ -746,14 +795,16 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
>  	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
>  		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	ret = madvise(mem, pagesize, MADV_NOHUGEPAGE);
>  	/* Ignore if not around on a kernel. */
>  	if (ret && errno != EINVAL) {
> -		ksft_test_result_fail("MADV_NOHUGEPAGE failed\n");
> +		ksft_perror("MADV_NOHUGEPAGE failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -763,7 +814,8 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
>  	if (swapout) {
>  		madvise(mem, pagesize, MADV_PAGEOUT);
>  		if (!pagemap_is_swapped(pagemap_fd, mem)) {
> -			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
> +			ksft_print_msg("MADV_PAGEOUT did not work, is swap enabled?\n");
> +			log_test_result(KSFT_SKIP);
>  			goto munmap;
>  		}
>  	}
> @@ -775,13 +827,13 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
>
>  static void run_with_base_page(test_fn fn, const char *desc)
>  {
> -	ksft_print_msg("[RUN] %s ... with base page\n", desc);
> +	log_test_start("%s ... with base page", desc);
>  	do_run_with_base_page(fn, false);
>  }
>
>  static void run_with_base_page_swap(test_fn fn, const char *desc)
>  {
> -	ksft_print_msg("[RUN] %s ... with swapped out base page\n", desc);
> +	log_test_start("%s ... with swapped out base page", desc);
>  	do_run_with_base_page(fn, true);
>  }
>
> @@ -807,7 +859,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (mmap_mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
> @@ -816,7 +869,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>
>  	ret = madvise(mem, thpsize, MADV_HUGEPAGE);
>  	if (ret) {
> -		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
> +		ksft_perror("MADV_HUGEPAGE failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -826,7 +880,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  	 */
>  	mem[0] = 1;
>  	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
> -		ksft_test_result_skip("Did not get a THP populated\n");
> +		ksft_print_msg("Did not get a THP populated\n");
> +		log_test_result(KSFT_SKIP);
>  		goto munmap;
>  	}
>  	memset(mem, 1, thpsize);
> @@ -846,12 +901,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		 */
>  		ret = mprotect(mem + pagesize, pagesize, PROT_READ);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
>  		if (ret) {
> -			ksft_test_result_fail("mprotect() failed\n");
> +			ksft_perror("mprotect() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		break;
> @@ -863,7 +920,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		 */
>  		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTNEED);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DONTNEED failed\n");
> +			ksft_perror("MADV_DONTNEED failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		size = pagesize;
> @@ -877,13 +935,15 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>  				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  		if (mremap_mem == MAP_FAILED) {
> -			ksft_test_result_fail("mmap() failed\n");
> +			ksft_perror("mmap() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
>  			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
>  		if (tmp != mremap_mem) {
> -			ksft_test_result_fail("mremap() failed\n");
> +			ksft_perror("mremap() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		size = mremap_size;
> @@ -896,12 +956,14 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		 */
>  		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DONTFORK);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DONTFORK failed\n");
> +			ksft_perror("MADV_DONTFORK failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		ret = fork();
>  		if (ret < 0) {
> -			ksft_test_result_fail("fork() failed\n");
> +			ksft_perror("fork() failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		} else if (!ret) {
>  			exit(0);
> @@ -910,7 +972,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		/* Allow for sharing all pages again. */
>  		ret = madvise(mem + pagesize, thpsize - pagesize, MADV_DOFORK);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DOFORK failed\n");
> +			ksft_perror("MADV_DOFORK failed");
> +			log_test_result(KSFT_FAIL);
>  			goto munmap;
>  		}
>  		break;
> @@ -924,7 +987,8 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  	case THP_RUN_SINGLE_PTE_SWAPOUT:
>  		madvise(mem, size, MADV_PAGEOUT);
>  		if (!range_is_swapped(mem, size)) {
> -			ksft_test_result_skip("MADV_PAGEOUT did not work, is swap enabled?\n");
> +			ksft_print_msg("MADV_PAGEOUT did not work, is swap enabled?\n");
> +			log_test_result(KSFT_SKIP);
>  			goto munmap;
>  		}
>  		break;
> @@ -941,56 +1005,56 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>
>  static void run_with_thp(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with THP (%zu kB)\n",
> +	log_test_start("%s ... with THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PMD, size);
>  }
>
>  static void run_with_thp_swap(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with swapped-out THP (%zu kB)\n",
> +	log_test_start("%s ... with swapped-out THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PMD_SWAPOUT, size);
>  }
>
>  static void run_with_pte_mapped_thp(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with PTE-mapped THP (%zu kB)\n",
> +	log_test_start("%s ... with PTE-mapped THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PTE, size);
>  }
>
>  static void run_with_pte_mapped_thp_swap(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with swapped-out, PTE-mapped THP (%zu kB)\n",
> +	log_test_start("%s ... with swapped-out, PTE-mapped THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PTE_SWAPOUT, size);
>  }
>
>  static void run_with_single_pte_of_thp(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with single PTE of THP (%zu kB)\n",
> +	log_test_start("%s ... with single PTE of THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_SINGLE_PTE, size);
>  }
>
>  static void run_with_single_pte_of_thp_swap(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with single PTE of swapped-out THP (%zu kB)\n",
> +	log_test_start("%s ... with single PTE of swapped-out THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_SINGLE_PTE_SWAPOUT, size);
>  }
>
>  static void run_with_partial_mremap_thp(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with partially mremap()'ed THP (%zu kB)\n",
> +	log_test_start("%s ... with partially mremap()'ed THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PARTIAL_MREMAP, size);
>  }
>
>  static void run_with_partial_shared_thp(test_fn fn, const char *desc, size_t size)
>  {
> -	ksft_print_msg("[RUN] %s ... with partially shared THP (%zu kB)\n",
> +	log_test_start("%s ... with partially shared THP (%zu kB)",
>  		desc, size / 1024);
>  	do_run_with_thp(fn, THP_RUN_PARTIAL_SHARED, size);
>  }
> @@ -1000,14 +1064,15 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
>  	int flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB;
>  	char *mem, *dummy;
>
> -	ksft_print_msg("[RUN] %s ... with hugetlb (%zu kB)\n", desc,
> +	log_test_start("%s ... with hugetlb (%zu kB)", desc,
>  		       hugetlbsize / 1024);
>
>  	flags |= __builtin_ctzll(hugetlbsize) << MAP_HUGE_SHIFT;
>
>  	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_skip("need more free huge pages\n");
> +		ksft_perror("need more free huge pages");
> +		log_test_result(KSFT_SKIP);
>  		return;
>  	}
>
> @@ -1020,7 +1085,8 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
>  	 */
>  	dummy = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, flags, -1, 0);
>  	if (dummy == MAP_FAILED) {
> -		ksft_test_result_skip("need more free huge pages\n");
> +		ksft_perror("need more free huge pages");
> +		log_test_result(KSFT_SKIP);
>  		goto munmap;
>  	}
>  	munmap(dummy, hugetlbsize);
> @@ -1226,7 +1292,7 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>
>  	ret = setup_comm_pipes(&comm_pipes);
>  	if (ret) {
> -		ksft_test_result_fail("pipe() failed\n");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
> @@ -1236,12 +1302,14 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  	 */
>  	ret = mprotect(mem + pagesize, pagesize, PROT_READ);
>  	if (ret) {
> -		ksft_test_result_fail("mprotect() failed\n");
> +		ksft_perror("mprotect() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	}
>  	ret = mprotect(mem + pagesize, pagesize, PROT_READ | PROT_WRITE);
>  	if (ret) {
> -		ksft_test_result_fail("mprotect() failed\n");
> +		ksft_perror("mprotect() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	}
>
> @@ -1250,8 +1318,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  		/* Collapse before actually COW-sharing the page. */
>  		ret = madvise(mem, size, MADV_COLLAPSE);
>  		if (ret) {
> -			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
> -					      strerror(errno));
> +			ksft_perror("MADV_COLLAPSE failed");
> +			log_test_result(KSFT_SKIP);
>  			goto close_comm_pipes;
>  		}
>  		break;
> @@ -1262,7 +1330,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  		/* Don't COW-share the upper part of the THP. */
>  		ret = madvise(mem + size / 2, size / 2, MADV_DONTFORK);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DONTFORK failed\n");
> +			ksft_perror("MADV_DONTFORK failed");
> +			log_test_result(KSFT_FAIL);
>  			goto close_comm_pipes;
>  		}
>  		break;
> @@ -1270,7 +1339,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  		/* Don't COW-share the lower part of the THP. */
>  		ret = madvise(mem, size / 2, MADV_DONTFORK);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DONTFORK failed\n");
> +			ksft_perror("MADV_DONTFORK failed");
> +			log_test_result(KSFT_FAIL);
>  			goto close_comm_pipes;
>  		}
>  		break;
> @@ -1280,7 +1350,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>
>  	ret = fork();
>  	if (ret < 0) {
> -		ksft_test_result_fail("fork() failed\n");
> +		ksft_perror("fork() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close_comm_pipes;
>  	} else if (!ret) {
>  		switch (test) {
> @@ -1314,7 +1385,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  		 */
>  		ret = madvise(mem, size, MADV_DOFORK);
>  		if (ret) {
> -			ksft_test_result_fail("MADV_DOFORK failed\n");
> +			ksft_perror("MADV_DOFORK failed");
> +			log_test_result(KSFT_FAIL);
>  			write(comm_pipes.parent_ready[1], "0", 1);
>  			wait(&ret);
>  			goto close_comm_pipes;
> @@ -1324,8 +1396,8 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  		/* Collapse before anyone modified the COW-shared page. */
>  		ret = madvise(mem, size, MADV_COLLAPSE);
>  		if (ret) {
> -			ksft_test_result_skip("MADV_COLLAPSE failed: %s\n",
> -					      strerror(errno));
> +			ksft_perror("MADV_COLLAPSE failed");
> +			log_test_result(KSFT_SKIP);
>  			write(comm_pipes.parent_ready[1], "0", 1);
>  			wait(&ret);
>  			goto close_comm_pipes;
> @@ -1345,7 +1417,10 @@ static void do_test_anon_thp_collapse(char *mem, size_t size,
>  	else
>  		ret = -EINVAL;
>
> -	ksft_test_result(!ret, "No leak from parent into child\n");
> +	if (!ret)
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);
>  close_comm_pipes:
>  	close_comm_pipes(&comm_pipes);
>  }
> @@ -1430,7 +1505,7 @@ static void run_anon_thp_test_cases(void)
>  	for (i = 0; i < ARRAY_SIZE(anon_thp_test_cases); i++) {
>  		struct test_case const *test_case = &anon_thp_test_cases[i];
>
> -		ksft_print_msg("[RUN] %s\n", test_case->desc);
> +		log_test_start("%s", test_case->desc);
>  		do_run_with_thp(test_case->fn, THP_RUN_PMD, pmdsize);
>  	}
>  }
> @@ -1453,8 +1528,10 @@ static void test_cow(char *mem, const char *smem, size_t size)
>  	memset(mem, 0xff, size);
>
>  	/* See if we still read the old values via the other mapping. */
> -	ksft_test_result(!memcmp(smem, old, size),
> -			 "Other mapping not modified\n");
> +	if (!memcmp(smem, old, size))
> +		log_test_result(KSFT_PASS);
> +	else
> +		log_test_result(KSFT_FAIL);
>  	free(old);
>  }
>
> @@ -1472,18 +1549,20 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
>  {
>  	char *mem, *smem, tmp;
>
> -	ksft_print_msg("[RUN] %s ... with shared zeropage\n", desc);
> +	log_test_start("%s ... with shared zeropage", desc);
>
>  	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
>  		   MAP_PRIVATE | MAP_ANON, -1, 0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE | MAP_ANON, -1, 0);
>  	if (smem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -1504,10 +1583,11 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>  	size_t mmap_size;
>  	int ret;
>
> -	ksft_print_msg("[RUN] %s ... with huge zeropage\n", desc);
> +	log_test_start("%s ... with huge zeropage", desc);
>
>  	if (!has_huge_zeropage) {
> -		ksft_test_result_skip("Huge zeropage not enabled\n");
> +		ksft_print_msg("Huge zeropage not enabled\n");
> +		log_test_result(KSFT_SKIP);
>  		return;
>  	}
>
> @@ -1516,13 +1596,15 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>  	mmap_mem = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (mmap_mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>  	mmap_smem = mmap(NULL, mmap_size, PROT_READ,
>  			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  	if (mmap_smem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -1531,9 +1613,15 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
>  	smem = (char *)(((uintptr_t)mmap_smem + pmdsize) & ~(pmdsize - 1));
>
>  	ret = madvise(mem, pmdsize, MADV_HUGEPAGE);
> +	if (ret != 0) {
> +		ksft_perror("madvise()");
> +		log_test_result(KSFT_FAIL);
> +		goto munmap;
> +	}
>  	ret |= madvise(smem, pmdsize, MADV_HUGEPAGE);
> -	if (ret) {
> -		ksft_test_result_fail("MADV_HUGEPAGE failed\n");
> +	if (ret != 0) {
> +		ksft_perror("madvise()");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -1562,29 +1650,33 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
>  	char *mem, *smem, tmp;
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with memfd\n", desc);
> +	log_test_start("%s ... with memfd", desc);
>
>  	fd = memfd_create("test", 0);
>  	if (fd < 0) {
> -		ksft_test_result_fail("memfd_create() failed\n");
> +		ksft_perror("memfd_create() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	/* File consists of a single page filled with zeroes. */
>  	if (fallocate(fd, 0, 0, pagesize)) {
> -		ksft_test_result_fail("fallocate() failed\n");
> +		ksft_perror("fallocate() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close;
>  	}
>
>  	/* Create a private mapping of the memfd. */
>  	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close;
>  	}
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
>  	if (smem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -1607,35 +1699,40 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
>  	FILE *file;
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with tmpfile\n", desc);
> +	log_test_start("%s ... with tmpfile", desc);
>
>  	file = tmpfile();
>  	if (!file) {
> -		ksft_test_result_fail("tmpfile() failed\n");
> +		ksft_perror("tmpfile() failed");
> +		log_test_result(KSFT_FAIL);
>  		return;
>  	}
>
>  	fd = fileno(file);
>  	if (fd < 0) {
> -		ksft_test_result_skip("fileno() failed\n");
> +		ksft_perror("fileno() failed");
> +		log_test_result(KSFT_SKIP);
>  		return;
>  	}
>
>  	/* File consists of a single page filled with zeroes. */
>  	if (fallocate(fd, 0, 0, pagesize)) {
> -		ksft_test_result_fail("fallocate() failed\n");
> +		ksft_perror("fallocate() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close;
>  	}
>
>  	/* Create a private mapping of the memfd. */
>  	mem = mmap(NULL, pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto close;
>  	}
>  	smem = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
>  	if (smem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
> @@ -1659,20 +1756,22 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>  	char *mem, *smem, tmp;
>  	int fd;
>
> -	ksft_print_msg("[RUN] %s ... with memfd hugetlb (%zu kB)\n", desc,
> +	log_test_start("%s ... with memfd hugetlb (%zu kB)", desc,
>  		       hugetlbsize / 1024);
>
>  	flags |= __builtin_ctzll(hugetlbsize) << MFD_HUGE_SHIFT;
>
>  	fd = memfd_create("test", flags);
>  	if (fd < 0) {
> -		ksft_test_result_skip("memfd_create() failed\n");
> +		ksft_perror("memfd_create() failed");
> +		log_test_result(KSFT_SKIP);
>  		return;
>  	}
>
>  	/* File consists of a single page filled with zeroes. */
>  	if (fallocate(fd, 0, 0, hugetlbsize)) {
> -		ksft_test_result_skip("need more free huge pages\n");
> +		ksft_perror("need more free huge pages");
> +		log_test_result(KSFT_SKIP);
>  		goto close;
>  	}
>
> @@ -1680,12 +1779,14 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
>  	mem = mmap(NULL, hugetlbsize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
>  		   0);
>  	if (mem == MAP_FAILED) {
> -		ksft_test_result_skip("need more free huge pages\n");
> +		ksft_perror("need more free huge pages");
> +		log_test_result(KSFT_SKIP);
>  		goto close;
>  	}
>  	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
>  	if (smem == MAP_FAILED) {
> -		ksft_test_result_fail("mmap() failed\n");
> +		ksft_perror("mmap() failed");
> +		log_test_result(KSFT_FAIL);
>  		goto munmap;
>  	}
>
>
> --
> 2.39.5
>
>

