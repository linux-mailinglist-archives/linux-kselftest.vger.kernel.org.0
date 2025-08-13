Return-Path: <linux-kselftest+bounces-38836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD22B24420
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF417A3F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAF2D97BD;
	Wed, 13 Aug 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4EITF7S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lKdz/+Pl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD62D0267;
	Wed, 13 Aug 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073220; cv=fail; b=RcxDSv8W+aMDQ/YJkhjYJ4ZwTbulrrNGNbTrnNZsg7VSNEG6Mt50bARyhu+WPcjxwa3Xj8Hu6nbVqh/rugHat/HzDWpz6EaCd0oodmRy2SZ3K8K6eXDyeosBzsv5MjhCd9WKoDHB+KjGB/K32C6ZxwkLctEm6j0apqClegCcEo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073220; c=relaxed/simple;
	bh=0GCwL/RMAX9yzgbi71v7/T8L/MpS9n1YQC7JqCfAZOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZseDQuN4XitvkiI7FjIvXoL0UJogifmvh4f7murItQXIE1xS8dhhOHWcjcgwPIvXj3vSv8u0Y+F/sTssAkXvNJcCdAM7rW2z4GNEDR/mTcPMlmN7MA2LGyHsAZPfXHoa6bG4+i92SbRbvvSDe37VDgCQsywHEqJO8XcJQk7l/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4EITF7S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lKdz/+Pl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u3Rx008497;
	Wed, 13 Aug 2025 08:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2bm/Gki9DzSvT+MYGB
	cgUS9qAtU6ei7j7WV4vDAq27s=; b=Y4EITF7SmxAV58Jusw4QgelpU8ro+NJMVG
	3RXZ4ygkOhUe+FBXeL4oo5YTrPc5rTqUbnVfCLsDmSDsF8iFsxc3hgamZiAFuFZS
	vYMpVb2bj3gDh1SVkB9ln6vHKCu9yUUoyzbJx/0gGuoj4a7KJs4V4LT7B9WULer5
	uDaIm07Ew5PqtOwqcYjhHYSQg1PlJl5bqi6WbpK67qggQk29mGXSsNWFED/NCpsL
	CTyKJxF4dhN/aDmac/bCoGFw5feDf7/u+ujP30Hw+or8MFuWN6p6pwPDcf2Go3ew
	JuNVdY79ai8BwQjJNMfobiEpG8DYmozdNTKhDqSK6dBZBpgY2yLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44xtnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:20:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D746r8017390;
	Wed, 13 Aug 2025 08:20:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb3b88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoJ9zIDaO7fBwkSBgFjgogIwgWSCKDJgILAPKj+2XAfYNeMak3KvUylO3b1cJk76ZshSHN8Xvd7T8DkzGMSb5KnLu8IxcF1xNXnV6qtQlELyETH21ZAuWq3GzeiF6hTTibosy9YT0u6DIEnSlvSgK6B5fJ83qA60HbHv5S8pcuJ0ElPtD8gT2iNhAcamvyHMYEMX4APIO4kE49LrseLhQbcSrQxltnMw2sz6SAKsJTTbt48YuCx+lM88mQy1uzZoUuLSiJB1S9MkeRRpaucOMzrP9RuvV3T7dCah+LaUYzEuv+Sdx/UZF8WaWIpeR+OuhpYFLXlLZQqf9+Yvf4JdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bm/Gki9DzSvT+MYGBcgUS9qAtU6ei7j7WV4vDAq27s=;
 b=JDLs0wOyslS9nwKx9uU4DMOBVUDlRZ2cN6Pd3NzDGZx5gx4RuZ+JnoFg68ldxD4oou+smTe4vqC5tnH4bR9LGrJGaPgPZRn2wECHRlyh9FcWAkW/dalb06yGGJkByQyAc9xh17nquX76rjNQKZKuRBbwZKM1aN6hhdtInKb5LrKoNJZSVsEAYSzFfXDK3isCd4KJWahW7/PnX3e0lJhASyd1PzKBIAT7+w/t05KUAJlZk9i3UqxMhzGe6VXQIejWswWusSwwCKNsEc+Ahu1LqKMIBiyXWgvMZJpknP8TN0ZMwDZXHx1XL9aBx6rEzDGqN2DeoyYxl0lwhgvsm4DfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bm/Gki9DzSvT+MYGBcgUS9qAtU6ei7j7WV4vDAq27s=;
 b=lKdz/+PlwOreEOvyZ/c5iMGwk7jI4KczQEh7zj/ZNaG5D5mJ1ZQTi8LH75ggtsQFiruNXbog+7jM321GqJFKSWykvDaGux54Q3idCMTuCjjJeKgY5DRQ+KyYArelwbhRPyh8mjBJAaCH41SdUtFPly+hU8rhUxTbF56E3EyPxPE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 08:20:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 08:19:57 +0000
Date: Wed, 13 Aug 2025 09:19:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/mm: Fix spelling mistake "mrmeap" ->
 "mremap"
Message-ID: <3caf3621-c1f9-42d2-9004-7e8660285630@lucifer.local>
References: <20250813081333.1978096-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813081333.1978096-1-colin.i.king@gmail.com>
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 252b3342-71bf-424d-2470-08ddda4230d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIpIjkWK35lDbRQrTSfpPv+i2t9Kwi316czQtH2QKasoxpX242MfF1NILQWO?=
 =?us-ascii?Q?ynFYBS/+eXe5cNowon9FOpLhbBdSSHLA0GGnYX/eDwjnQJE/ZLmAzB0n04EA?=
 =?us-ascii?Q?V19S99hu6NcW+n1QyJwwtahQxp+Cpx964yPsBNiiQRXnntP5irf3VAN00IBf?=
 =?us-ascii?Q?9GHmXrK4kbgDGcbAy9GACD+dQU4kuJ1Fg30Aws4CuK4fKMiBuXNQZu3gCHjN?=
 =?us-ascii?Q?ydBo0Nb+39R3tUjbBZAUqw1gww4ZMfuJgo6j5dsOhB6AxJCx9dI3t0CHIS3F?=
 =?us-ascii?Q?7tq2cyCjqj2h82KyR04DbppkrKhey38ReMZx6hHWVOF7/qtZyq10OCdFn9ku?=
 =?us-ascii?Q?baNeOd2RIAVFWlBS9GbDzWqeBlug15S2KLe/dOFN7Jq4peGiKVvzDtUAgD22?=
 =?us-ascii?Q?si+72yOQHA3H9yiZhoWwkMC3ug3O4LrFppVstD41zuQ3lzWvADf8L8HOA1cQ?=
 =?us-ascii?Q?aalRrlsDk2HKySC9dinZ9mclp+uxIqGVy3i34N5tSo87dMyP99ygTffBnsng?=
 =?us-ascii?Q?ISjXZ39pNSlo69C3iAXRYU8ArFwBcedFTqa4hT0ih/Y2YGlnKjlN75THk2lH?=
 =?us-ascii?Q?+S3RMBBYEl4vKJhUb76/iv8ayw9r6VAr9gb1B02n1PWH7M2utOt2H+OcYG4M?=
 =?us-ascii?Q?kyq0II9OFye2CeeRj7uAFmdVPyL36i1S1l/c5TNqraXX45HI4LVmiU9tZbZn?=
 =?us-ascii?Q?0Tfk+K2MSdfu1fOjLuY131whVDfGh/r/qP+spXu1FsOKozCjqc8H1Zk02jWo?=
 =?us-ascii?Q?vvQkPVVssJf1lirNQNewU6uhxclm7kwd48tpcmELiWZTDCAh6Dbt8AH8nGZk?=
 =?us-ascii?Q?ftO87Tdsl5KjS5L7bHmk4MKMxnYEmgEppzqM7beIGDcCqTRdYXTyZ94VGUAx?=
 =?us-ascii?Q?d5SvJDSOXObq55h9e3d5q1RCmZw/Nc5wtPBGRsJvb7VWKpq2dM68xj565/2m?=
 =?us-ascii?Q?+JXgy2883g5VsbT4ddme0PNppkuT6B2fpqlN5kkCXYyQCjxkM4L8rfat3iGb?=
 =?us-ascii?Q?L6DLoYy6W91sGMNfGOWsWocs3o2L1la18CpzKhWhkTlAP7LFk4BDbUlidtr3?=
 =?us-ascii?Q?OxmFs0Ywiuc5DSX5/Q4IfZ9wh4Z/XoJvdxlPXuLnyxzLWJHZ7ryg3y38hdw/?=
 =?us-ascii?Q?YQaJHXhiP9Iyt7O0JgM+exRtc3qCAa8OrcJ+cRZ7th7axJds2HJXl8RdOolC?=
 =?us-ascii?Q?e+N/RX3LTAOCPcoHL0yZrcEmn+zHOcQ1hQyT8sj1avjaIdf6xYdEo0fLUmeo?=
 =?us-ascii?Q?9+tCget3yJT5JWzEssXj3rZoMIF1w/NJr0GCg92cTQxsaXuzkaC5CGf+ZtMP?=
 =?us-ascii?Q?8atmOU0kO0OiNEiICi8BUCswmPpxR6U9TK/uOhy/NHHw1W3jrzXYQzZW+9Rj?=
 =?us-ascii?Q?eCo6rxxeHlTkERvlKD40zobSd9kUNc29Xd+DCmNiwF1GcBGIJF4Qb6Qjs38i?=
 =?us-ascii?Q?bLTXAYULS1k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cWAPLOXDWwDaW4TS5o29jJFkL5EoTCm7tu1kFZo4SzGyOmzvT8/iRfqZUsAe?=
 =?us-ascii?Q?QBO7iV0BOjor+8t6oHdw2k+/UoXP/u64JZIfPIGVrw2W2KkXX1qDbQzyJR9l?=
 =?us-ascii?Q?3l5QG4ZBc6qpR46opW7g55ukMnaWOli5Vb8YEII4w9ZPGmCekp4nkZdKMYKK?=
 =?us-ascii?Q?IMvr4VBcoxWAwSN6bPFonlLiRLJ0INu8xj8NpM/yIV4TRf38jyC7gRaPcpqk?=
 =?us-ascii?Q?/4tLf0JIdqxnYDHCOVgsa53HwvnV0b7KJRqQbhMVUvfSKudeS3nhHEfpe8zI?=
 =?us-ascii?Q?AqCUNlQRpELgiPvblV6+FMcm56ecxzSfsgux9pliXanMxfWbUHrC7dVCm1/C?=
 =?us-ascii?Q?74+UQavedrDMVMI1BuOJfUzq9qW62yp306ExSkkcd65XTPd74OtXTdbW9Q0v?=
 =?us-ascii?Q?5SiwLxoThhMvedbgMvkMr+qNxcAgOMFdRYb+jd4jzORefyDQkn/jq8tPQYoH?=
 =?us-ascii?Q?K4JXKI2o9eVbPaKXKasnjQlWL/BauDi48xKIKWmmGbw109NWHZumkQa+sgha?=
 =?us-ascii?Q?HHCgDdI7TGC9lKwq6ASYAbSxIfDKbMYtQivK1F5um1jM+wgqWuedkCDpfuPM?=
 =?us-ascii?Q?jykBE0gFfAJnB7CwxwDzU5Tq6Z9yozFrEJbdzqyMMXXWLE8VRzZuod1GRz+6?=
 =?us-ascii?Q?K23TcQb1lni/aOtHVTBjuNKvqOZCaV9zE+CVQ15YVmLzW/8gbj4KHq4DgBFv?=
 =?us-ascii?Q?gytxhvxO7tKktfWXGZA/JAcnyCQnTVPhMDmzCSaqKVyCxTp6smRAlxHx2LLO?=
 =?us-ascii?Q?OQ/HfCkEByrb51gBPCE2yfoGgGDUYQUTt0J919DfOphOUmKoyvhUBuj2ln4M?=
 =?us-ascii?Q?I3XiWAWMH27hmU6RmtVj2IN0p9jA2if2WCml9MvkuYZxP4M16WdsXV5WuoMP?=
 =?us-ascii?Q?PT+FSJvuwoBafeWaGso2rs2iWNc4JTuimNJpUVwvdf6KYy4jRfsU7dyDiPcq?=
 =?us-ascii?Q?oLqywyayHn/24IZDsbEsk4OG87qBJnrPMU1Ku90W6052o91/uqe4yi8cq3YG?=
 =?us-ascii?Q?gTKWhWiM+2MaenLCFyLmXmjzWRbXF4yi/vnuxPb63XMjfDm7Yhnk8/WCxgqA?=
 =?us-ascii?Q?ZqvyfSl3krT3U325rjLEs08U8tRLXdPM1YYj3IY5XUWA9/JJEvfMoxc30VCS?=
 =?us-ascii?Q?8wtOq/ON66fZLgW97Q0mQWyGYghckqCGH3YzXtAeab61UR+BqgDR/ul5Tiqn?=
 =?us-ascii?Q?tt8uYwj3lsbIcv868aUneLw95wnQIwlx7qWl2rDLzV2Fq7dwfR0MkITL+E5P?=
 =?us-ascii?Q?iWU7OUrxHOrTs+aALSOOdvzQT3YNpSF9gv+HF+lrkeyukFWpcFvFuiIVRMJU?=
 =?us-ascii?Q?Q4C/QI/r49zMu0Z9Covwascgl9+Il5oY1yRbKNisBtIyXK6+3TiNeX+qvMF3?=
 =?us-ascii?Q?Z2uQIHQHI+0gvFlxGBjcfj7IKO1qnrqJ1xjKuO6dED+jNyhRIVDczXogCWcj?=
 =?us-ascii?Q?uptEsqBPxQrxKIR1umcf0Ffqh9DvtBT2mbKI19rwTYqzxPZWWaTG3wMctHVy?=
 =?us-ascii?Q?OBTgg37GqC8WvZY0fP+gihSpEuRk/FI4Rmq7S5CClYZti9brwvhWWgsny9s2?=
 =?us-ascii?Q?bjeyobpOmNu7YF82ekA4UYJVyLfWHIWb+bVaMWaCr5hrzeV7cseWTXpT3Rew?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kdtUZgYr6m3Rw5SOSYm7JIuScWVu/1E4Z8g0FMJ9k/CuNSdZTsgvXcNtNe/pTUyilX6M8rDH3AGrWT6Qo9Knic9DYL+mPLY7hAxS85FptlxSbFIRbxtxt8u4MtMNO9dcqzY2tEA+dp7z6fBUI/setyeYkIrT/FNQH2N76FIlGYavtzPlzYqCPxKvFTla/iYFpQnTbN1hX6QZH3x+Ul+bzw/4syAfd7PtJnC3FAXIAAVAh1sDVipWEeWZiwaY2eHeEd39dGH9BS3APXUZxAW6EjzMkN4Fih738xTeScP53OkhTrZy2kwvXg7QjGkeGAboywfVy1kugCj874muVOuToOuCKk98f31noI3UR2jnHz1xJ0ebNK9an91hsQKjfWRvzTfi8r0ChMXhgwrNx6hDGLIR87hFbYxnJ4NMOJVkVpvNjXzHvlpaQ9tvVtGaK9CgxTaE3uvHu7NI4k7GsEyUMpNkqz/MGAeYczMjusmrmb1GNP7kaBsM6QKdwZygEaVN5nZHy5YDK7GWAvC/v1vG7dQVe/COs+vP1Acg61kQGsWcmgWMEkfFdqRJN6KwkK5hvJECUD2vHipmwmURjCuqicW20KULPC5a9tx0KHafPb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252b3342-71bf-424d-2470-08ddda4230d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 08:19:57.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmM0/hOqo0HQ8TV5J+VqoUbwziz0eMnwMo0184QKNDKiUa/NDF9Q+KiPCXFk5dV1VdZl2vR44ANeo34oP/50aFqL+vuiq6OT92KtPmnS5oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130080
X-Proofpoint-ORIG-GUID: oINfwoNCEb030gw_VOF6y-D9WeTHOpn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA3OSBTYWx0ZWRfX+V+5LwXi3k3G
 f8J5GyhToHIlt4XeKR7uOly6SMXD4Ih/P1HBigRBXU73cJRpcEqwOjg6jgSkP9aQFEwYrK0Y/cr
 Zr9c4oXm+82hjGx5+vTweKCz7SbUiTAu3z7vEBry77/dUES0voi0bBjXJWMCYOHK1Yd+g0ROJs5
 0LjdFoxmPIeCGNyXImnK0LNhRjpQlm2KqInMrVQnARBOBOEo1Hyu5sBGgBwRy8y1Ew/SJKmtXwQ
 uH3ljJfzFDnOqxCUZKTtJcX+BGSiY7ugJJgar3t3nn2K3SCaxKrqrcNDxpMCCSHfckGYrIA+jL7
 oV/LB43cejZXXszeD8I2ytAzqD0ezg6HcZGvLw1BZTOyi1nRl6kAzLU/DQ7AGEM3Iypv5ymOXsp
 brLekZWAqHEbVqQBPiX6sa02259k6yIuo/nrQS/vpxQmfypBsU2tUrSQuycoLyI7AVBSfDpP
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689c4ab6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=C3DKd7Il3PkriANctBEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: oINfwoNCEb030gw_VOF6y-D9WeTHOpn6

On Wed, Aug 13, 2025 at 09:13:33AM +0100, Colin Ian King wrote:
> There are spelling mistakes in perror message. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks for this! LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> V2: fix typo fixes, I need more coffee

:)

> ---
>  tools/testing/selftests/mm/mremap_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index 5bd52a951cbd..e289bb1112db 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -846,7 +846,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
>  	}
>  	if (err != EFAULT) {
>  		errno = err;
> -		perror("mrmeap() unexpected error");
> +		perror("mremap() unexpected error");
>  		success = false;
>  		goto out_unmap;
>  	}
> @@ -899,7 +899,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
>  	}
>  	if (err != EFAULT) {
>  		errno = err;
> -		perror("mrmeap() unexpected error");
> +		perror("mremap() unexpected error");
>  		success = false;
>  		goto out_unmap;
>  	}
> @@ -948,7 +948,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp,
>  	}
>  	if (err != EFAULT) {
>  		errno = err;
> -		perror("mrmeap() unexpected error");
> +		perror("mremap() unexpected error");
>  		success = false;
>  		goto out_unmap;
>  	}
> --
> 2.50.1
>

