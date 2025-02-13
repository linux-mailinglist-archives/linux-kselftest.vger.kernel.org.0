Return-Path: <linux-kselftest+bounces-26579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41550A34D77
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B716450A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AE245AEB;
	Thu, 13 Feb 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cnFnC4bn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oRQafwdz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052BB241690;
	Thu, 13 Feb 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470755; cv=fail; b=MBXpdCEEuVjVecEGpbFtNeXDT4ENyeRO8bT8O/EWmJKhBpdgPAps2axkWR04+jAlz5B5Ia743CwMaRWGW0l8Ik8v6Rd2BiDmGnBFPv+TptDYefuV6abKtnku0poJtxLqsVMooapaxPHR7qNsHOFDGjTPQIyc6l+1gh0V+N/caAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470755; c=relaxed/simple;
	bh=9iDnA/SdCGN1zum9rYjrjOe8HXQ2jl2vb7R/M9lEaH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmYir3GUg8SOOIi4fmo9qnH04OtuOiU+NDaPVvsfP8nX2VZ005hq9qLMLlB6T/cgQdam6bnmd/Obx/ai9pIFbEcrY4Fg0spBvKodQrEmfaS0ati7tstbzWV+JK7s6cshYuJVyMgckEN0ukDPfEw/JQ9XHEy0mEoGPjUzZ2TdgrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cnFnC4bn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oRQafwdz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfbck008245;
	Thu, 13 Feb 2025 18:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9a5t7PvtX4X6M3hC9nqwwUGYHDxODOBBA7AycvR78f8=; b=
	cnFnC4bnJ47XdhbEEdMqL3KxxEvwMGO3pZEDBb0D59rMXkGdTw/GOupPA3TjpQCh
	/q5Uze7q15QKQFlN2o80CalTZ8XcnKilZLvvgVNcavofh9SDY2iAGS9xwCpaf76d
	br7Al7JeriCa01WlcsCzPgChj1Aoyt6I2fRNfpsZ3N+2T5NkZYKM3bY6rNUIap2H
	qnRzkH5JoUbnqPnuoiZ0Lrs6iaoDrAugfMHpusaruvmLQnXrhmJa5ligKETqGjtT
	6VGkfTUOx9Mc4MpqGyor/CPl5APvZPEFY7NW9SSaS61AP2Bmun0kJ1bih63ZczqZ
	KR7mef2Ca1h5hF08ZQCL8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tna53w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHG2W6005110;
	Thu, 13 Feb 2025 18:18:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc2ahq-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 18:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjVp/XGps8cZ96zxvV1PyOfncGb0vsW0Fi1BszOw389nESw8MgWjtkBrd6pqt1PjqULEjGOyVvFz+lv2KVxe3RFAGlpPOyH48m/FU2y5F8x5+9fQ3oDFSRsLCnXQtKzwuKed+a/NNs88fDD9wt4UQzVxjEweN4onW5beb8kXlN1Vi9nfBT1BmtSKKpTSu3do1DLJIcjo/WYo2vr4HV6BuhRdkod3mviKH7v8SJSTGc1q5CwnhL5pfDJjSsMjMXhqJVpwTTt1n5Q7mD1+lzoD6K6P6hIcNW8PPPEejDeDwaQUoakaKSu0FADaGfuP+fOcDtGa9OyJdt8nnZBWgwSKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a5t7PvtX4X6M3hC9nqwwUGYHDxODOBBA7AycvR78f8=;
 b=xlI0WeSJMJt3b7FzX/L5RnbyibbXtxNauAyj00iNY+RUlK4Q7X+Z/SjzK3ypY0LRMDGBcYEuwaafZ3H4cuYWa15ipOjpoX/tk6X9a0zwrEGpoBViUKDLQp47Ka/BqzNv4/hw9KF/RXe7npJflwHMf0yzotGI5mgg888NvkJN9Qj+OaF2w+ruWsaTAQPQX9vT9eMqd7Zz12x7Mp0tAltJAKVmUs45VFZ4QNTNpTgXWCxWa+hbQsVVqeIeGi35fmvkuOLbu/aSShrdcOfhzPQrq9Lv9Aio2nhN5L8pgGM5v4vermFEG6JTqHk0hDYp5LMgJV9iCkvCpTmadVjRtBb/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a5t7PvtX4X6M3hC9nqwwUGYHDxODOBBA7AycvR78f8=;
 b=oRQafwdzZSF35ENBSOtAreHFEwVNeUaocsLS1TvkkqvDHGvYO9C5+TLWfRxxGbGQKDoFX21l0Nxj6zbsUlaEX02YMxnAGCwPE0/IVrtVyHFHI4ldygaCntUCNuLWwgcKIl2pW/E+cCxlmSp2Z/Okfcraz//57n54NenL2Jlt9aQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:18:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 18:18:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 4/4] tools/selftests: add file/shmem-backed mapping guard region tests
Date: Thu, 13 Feb 2025 18:17:03 +0000
Message-ID: <90c16bec5fcaafcd1700dfa3e9988c3e1aa9ac1d.1739469950.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0232.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb984a6-d8ed-45f7-34d6-08dd4c5ad928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eV/I65XVWVIlf9UTCVu/gWULs4ykgLKvh5bgRjHLgKebj2oj7r4nCwP6RE1Q?=
 =?us-ascii?Q?L9lIi5tXdF+SE5fY52TiRhf5R9x1xU7cuboV/ggWTUG3MD4E1fTshu7Qlt4s?=
 =?us-ascii?Q?eyEC4qx+zaa3skfLh3Z1aey0v7zYIN4U0jxqz78A7CoJv6HAljEaB/A8e5JA?=
 =?us-ascii?Q?UmlvwnSj6ALru1YZo5mAyUwwCzLuuatNNB15mN2smWBE7HzfyELTZJcJP+mP?=
 =?us-ascii?Q?1D7dmRVKFRzcjBD0RFR+dfqBfZ7cXULkFHA+7a7sw+L6n9lb+8edaFsUukwM?=
 =?us-ascii?Q?apDoX/hkTy5qjJYSiFMeRI39Q8tT1nDVxC8rKvSakC87gRrrbqEibqzhgyix?=
 =?us-ascii?Q?zszYml0Zum0KZP/ar0Ody9Mp1HCEv+tR3ICbqGIyX2Cj8ueRAoRw1BhLH5lH?=
 =?us-ascii?Q?aGyBvMEUKNp7WafonMsfixjSRJQfKLu+VrU7Ln/y6TNBshlgxvwSIxxk1t3B?=
 =?us-ascii?Q?Wfdnz1LI6ystq4n2BRHJb6mSKgYsp6TFUhMobERQnSQNewpGre+D5McuMkz3?=
 =?us-ascii?Q?D677sSadBupa2bvT1HR1W1gugTua1eORHxHJkAhU0qsGBNL1gto/2mp3U8rv?=
 =?us-ascii?Q?kMmao1KiVgPS4MPYdzyrKJxKnjJFfkxqrt9LJFLe82aUtmA2kgd6XcjvBScg?=
 =?us-ascii?Q?BtK4fyCuLo/kP3qWZBwKma0mMbrMHlxxVsZHjqEK4nFbttj72VtsrxZSrmSX?=
 =?us-ascii?Q?THg1Ac9MUIoYjnQTpSwSA2jZQhCaGgXYDUdEGToYqU7N6zfNMg5MKOWeGSuw?=
 =?us-ascii?Q?XYdfjXGVfn5l1ate+LxgRXeto6qRyX+nEJ6EnRyfxoyFiiCJSPLYT5pc2OvI?=
 =?us-ascii?Q?DBMgV8FLDHo3Y8Tszs2k5IzkMPZqA8k5cwWOpNZYAWuHtyXzUqIlciuC5RXQ?=
 =?us-ascii?Q?zLGE99aptOYsCyMSsZm0s2uQwZefkWceMr+X2FKTLg+yix7xA7/GV3LAWg5o?=
 =?us-ascii?Q?5cL33B35Ii64ALFPzgLqAa+nuBopwTgUCMYCKwax0GWJUZHcA1pDszzBbvzC?=
 =?us-ascii?Q?qZ9W35YpBTfx9ImKiYA3x5LUoTc0aVWsrEm+ywoB2AWnT+s32HvDQnSByCwk?=
 =?us-ascii?Q?9CR7+AHgMCdYfwJ+2OjDFWjz14kEeBCXI0beJRMm2GLT0cuwczd2LTxG0jRh?=
 =?us-ascii?Q?fTBp2jScupkWLRJ73JTEdgKrzcJbt+nNZx3356mKZBPOQ/ztfyh2Li0aW8fC?=
 =?us-ascii?Q?7V3R3Ks4oU+ukgnGCN3fAW21ZYSLqt6QqLKC+QcW9bW8Rcq7VtCyrwO/Rdvc?=
 =?us-ascii?Q?tYzcaW9j3Nrzd/pvLL4ANyfnIVkpJQjnd7uoO2S41Z9PfDiGbIdTgWflYGqZ?=
 =?us-ascii?Q?CtLPsG0I+u8ywkOcrwqxwbEttI18+slo2BfudU/cSk3TCNSJuUQtPpJ7NTGC?=
 =?us-ascii?Q?RPes2RkRIlaBHc/QaD1GdY7p0rdQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoaOiyzzoDv8Z1fE0gbOfyMAzme4btPouBSM/yMw1Sd7sqY4jAIdpObGFYjt?=
 =?us-ascii?Q?Pc1Gq7Nu7JB4n+qe6iDbfjJqKHDLd/B+Gy8VJrDwRCMZWAJegwhdg4KjVLdj?=
 =?us-ascii?Q?6tteyjG5BzFKlNN69q68itJfVcmoRMyG7aByUOpKfWjnfefwwrjvtNEJXokv?=
 =?us-ascii?Q?8Xdwf13JM3NRlY6gXfkEeF8BsOh1uvxLq7V8yaXvbB5CC4wHFMfCR5e00RDt?=
 =?us-ascii?Q?gm2yLY0pQq6AWH86QO5U768ndE1M2I4t6hRmmrCd8cg6VzaJAo0C8i/2ZLhi?=
 =?us-ascii?Q?OqI2gtIiv6HRHS4MxNQnIjkfqcSlHDXFuNiIXnZafItwh9wZp1Sa/RoQAFad?=
 =?us-ascii?Q?sT4K845c/YQwfm0WTuaIw4m2ynmUjM84bM6Br+KZKWLmpQIYmz0myPUL3HhA?=
 =?us-ascii?Q?Jbf3zbkIJZ2FslVtlmaeIvP6g+e9o8EAmr0lxpk/yw4pRk/oS9W7pTqsmvPm?=
 =?us-ascii?Q?g7TB4e51wt1IarxasR7UJDdhZZsDuEag9SdZYHu3Z4kIEgtyT4/U8MqdP0qU?=
 =?us-ascii?Q?OfZf58zxYO16tLJz0FkPcT+iI3CxX5T0FI93E9sOnsn+y7y4j5zfGMCexMDe?=
 =?us-ascii?Q?BNnNKzcJQvrSLYGEWDcJEqIsCWk7dZ/j0zNfYXZZwijj2FS+KgIcMFJ6XWE6?=
 =?us-ascii?Q?XWlg1cV5btWaVsgRmn5E7WImKJnUQjjdtuPsc01eKhGH03sALi7/C/qLFC6+?=
 =?us-ascii?Q?0HdFVQkwOgaOMDbD8dt2tIXla9mpCVTj4F4IG0p7uDacRU+KrK9ato9dTbr8?=
 =?us-ascii?Q?Ropwx363FrTWIpFAhZ+nGOctXzNv/m9LJkK3O7ODQma5qfLOwqCf2n7Rs6mm?=
 =?us-ascii?Q?X15dRMcqJEeat+nMCVcKX6sQwHv+qWy2aDmowkcqmdCAJi4saREbQl2S7wEk?=
 =?us-ascii?Q?ozs5z96H4X52q9lWEaO/xBUMKV00YQWdeCOI4XIZikOmxySEu7WkwJD3PfiV?=
 =?us-ascii?Q?LFBycXByWOY3q3pK3pt5G9TlO7t72jC2qkRU6MaxsKV3ECPheLu/zGTuPAf8?=
 =?us-ascii?Q?8JK9FM4R0e4ymIU9f7rdcweJYJWUUl3RdEa3pCRmqLG9LcOed+vSRqmbXupd?=
 =?us-ascii?Q?JbRAP6tqIYwL5DF0nssGnupIdywyHZhCpj+Ry58ez4+Z9Sl1G7CwbawbH2xf?=
 =?us-ascii?Q?amZFdza9NbZyyziH4fJ2mdLG2dCrQUFJV09bMeaa2h31B6Dm6Hftyc3yTrY9?=
 =?us-ascii?Q?+7YOMAK96GixZKwgqqknk4ddf7ZbwBqZUADcvUYfamJR69fSOG4JMxeV1g/8?=
 =?us-ascii?Q?lz0L22AZFUr9agm5AqdJNrT3eZE9DXpXb2dpblx5nWT4PdlIQWJZKDw3l6DD?=
 =?us-ascii?Q?bISROcOWMEwq23PzLysSvFO7Wwzsw5c2G9JXVhdQXS62nKRneMd7QotptIgS?=
 =?us-ascii?Q?lTn2/JN8AtwwnfYFY3I2eHUhouiL3ApYNCoTQNNClKqBZRBxI5FBVnF4d9/p?=
 =?us-ascii?Q?zhmIBXGEIdzsuEIAQ1FrpeuHN2KZ3dt3IKmpTYMmv3XPPzEdmDc9e5GtUdT2?=
 =?us-ascii?Q?AAGmrlc6uyMSKMcQVXRWIum98dWUJSI5JFHdqX05rF4h5dvThb6pA9pf2n2G?=
 =?us-ascii?Q?td5oexZyi0n7g58ONfbxWGXtBcVxMuzY5Y7Ca0GdSkbjfJ6+duluYWEc19iD?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yz7hBBreXAaibirDoeRJo+qK8Kfs9UsS7f1t5/CbtqIR/hQh6ONSn3PGo/AVqoYuvuccmsC1fDar8IToT/B9Zq+vG/Daucxbt+Ybx6fxo5Oa4uezK7VCXMxhJEaHtH4Qz/X8eGamqoH73rPIH0qkNOlNqo3tp/yDMgcWPuCOHuC5Sl7qUc2iV6X4O07ppsJmM0clRZYl3YBpHcj/iLp0sUBhZud/YgDLmjNTtS8Vqx8R2Zb7esnX9n3bqbF9Wrjhg5loo4FPZKpsAZm6p2qjzURjSZY52fxBXg52K9GFZrVh2AsPSVvj6HjGmMXditT/KYSKowqRsN6F9ZMD0+MGXMeoasIWxKKfiznZg9RgvKLUTobPCnlNNSDNnUW3DwdOBDYlXMO6QrUtUVdSiH7MB7qKIYfmUKufmCl2OZzNVxrf6nhFVlEfgD5t8EU4/x3Qx4AeArZ4w8byrEPgZT7n8i6XKiu84Pzi0wP/AfhuCP1Gs2761a/KGErwgxoi+Oyo+O0XnrW0B+0CwwdHWdqhE4+Z+22JFzMd51lTHb+R2SFikEFsqMijCcltEd/kceQTQrcWFf9vBdrDvouAk3GSToFXOObHgdOO+bfQgZa+l7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb984a6-d8ed-45f7-34d6-08dd4c5ad928
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:18:43.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iJbad1UjmumSSBcRJ22gXZSatdxO/E4Vhupo1lycDRfbm7uXEdpvlusn/EMcGTuSYkhUAQIruFHrLSkr57JxJL8pDVZx1v3hBQa4lGBoHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130130
X-Proofpoint-GUID: sWyWgxkmBI3RN_RcCPK0J0zP3FMu8E51
X-Proofpoint-ORIG-GUID: sWyWgxkmBI3RN_RcCPK0J0zP3FMu8E51

Extend the guard region self tests to explicitly assert that guard regions
work correctly for functionality specific to file-backed and shmem
mappings.

In addition to testing all of the existing guard region functionality that
is currently tested against anonymous mappings against file-backed and
shmem mappings (except those which are exclusive to anonymous mapping), we
now also:

* Test that MADV_SEQUENTIAL does not cause unexpected readahead behaviour.
* Test that MAP_PRIVATE behaves as expected with guard regions installed in
  both a shared and private mapping of an fd.
* Test that a read-only file can correctly establish guard regions.
* Test a probable fault-around case does not interfere with guard regions
  (or vice-versa).
* Test that truncation does not eliminate guard regions.
* Test that hole punching functions as expected in the presence of guard
  regions.
* Test that a read-only mapping of a memfd write sealed mapping can have
  guard regions established within it and function correctly without
  violation of the seal.
* Test that guard regions installed into a mapping of the anonymous zero
  page function correctly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 595 +++++++++++++++++++++
 1 file changed, 595 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0469c783f4fa..ea9b5815e828 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -216,6 +216,58 @@ static int open_file(const char *prefix, char *path)
 	return fd;
 }
 
+/* Establish a varying pattern in a buffer. */
+static void set_pattern(char *ptr, size_t num_pages, size_t page_size)
+{
+	size_t i;
+
+	for (i = 0; i < num_pages; i++) {
+		char *ptr2 = &ptr[i * page_size];
+
+		memset(ptr2, 'a' + (i % 26), page_size);
+	}
+}
+
+/*
+ * Check that a buffer contains the pattern set by set_pattern(), starting at a
+ * page offset of pgoff within the buffer.
+ */
+static bool check_pattern_offset(char *ptr, size_t num_pages, size_t page_size,
+				 size_t pgoff)
+{
+	size_t i;
+
+	for (i = 0; i < num_pages * page_size; i++) {
+		size_t offset = pgoff * page_size + i;
+		char actual = ptr[offset];
+		char expected = 'a' + ((offset / page_size) % 26);
+
+		if (actual != expected)
+			return false;
+	}
+
+	return true;
+}
+
+/* Check that a buffer contains the pattern set by set_pattern(). */
+static bool check_pattern(char *ptr, size_t num_pages, size_t page_size)
+{
+	return check_pattern_offset(ptr, num_pages, page_size, 0);
+}
+
+/* Determine if a buffer contains only repetitions of a specified char. */
+static bool is_buf_eq(char *buf, size_t size, char chr)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++) {
+		if (buf[i] != chr)
+			return false;
+	}
+
+	return true;
+}
+
 FIXTURE_SETUP(guard_regions)
 {
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
@@ -1437,4 +1489,547 @@ TEST_F(guard_regions, uffd)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+/*
+ * Mark a region within a file-backed mapping using MADV_SEQUENTIAL so we
+ * aggressively read-ahead, then install guard regions and assert that it
+ * behaves correctly.
+ *
+ * We page out using MADV_PAGEOUT before checking guard regions so we drop page
+ * cache folios, meaning we maximise the possibility of some broken readahead.
+ */
+TEST_F(guard_regions, madvise_sequential)
+{
+	char *ptr;
+	int i;
+	const unsigned long page_size = self->page_size;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "MADV_SEQUENTIAL meaningful only for file-backed");
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Establish a pattern of data in the file. */
+	set_pattern(ptr, 10, page_size);
+	ASSERT_TRUE(check_pattern(ptr, 10, page_size));
+
+	/* Mark it as being accessed sequentially. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_SEQUENTIAL), 0);
+
+	/* Mark every other page a guard page. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr2 = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr2, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Now page it out. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Now make sure pages are as expected. */
+	for (i = 0; i < 10; i++) {
+		char *chrp = &ptr[i * page_size];
+
+		if (i % 2 == 0) {
+			bool result = try_read_write_buf(chrp);
+
+			ASSERT_FALSE(result);
+		} else {
+			ASSERT_EQ(*chrp, 'a' + i);
+		}
+	}
+
+	/* Now remove guard pages. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Now make sure all data is as expected. */
+	if (!check_pattern(ptr, 10, page_size))
+		ASSERT_TRUE(false);
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Check that file-backed mappings implement guard regions with MAP_PRIVATE
+ * correctly.
+ */
+TEST_F(guard_regions, map_private)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr_shared, *ptr_private;
+	int i;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "MAP_PRIVATE test specific to file-backed");
+
+	ptr_shared = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr_shared, MAP_FAILED);
+
+	/* Manually mmap(), do not use mmap_() wrapper so we can force MAP_PRIVATE. */
+	ptr_private = mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, self->fd, 0);
+	ASSERT_NE(ptr_private, MAP_FAILED);
+
+	/* Set pattern in shared mapping. */
+	set_pattern(ptr_shared, 10, page_size);
+
+	/* Install guard regions in every other page in the shared mapping. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr = &ptr_shared[i * page_size];
+
+		ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	for (i = 0; i < 10; i++) {
+		/* Every even shared page should be guarded. */
+		ASSERT_EQ(try_read_buf(&ptr_shared[i * page_size]), i % 2 != 0);
+		/* Private mappings should always be readable. */
+		ASSERT_TRUE(try_read_buf(&ptr_private[i * page_size]));
+	}
+
+	/* Install guard regions in every other page in the private mapping. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr = &ptr_private[i * page_size];
+
+		ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	for (i = 0; i < 10; i++) {
+		/* Every even shared page should be guarded. */
+		ASSERT_EQ(try_read_buf(&ptr_shared[i * page_size]), i % 2 != 0);
+		/* Every odd private page should be guarded. */
+		ASSERT_EQ(try_read_buf(&ptr_private[i * page_size]), i % 2 != 0);
+	}
+
+	/* Remove guard regions from shared mapping. */
+	ASSERT_EQ(madvise(ptr_shared, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	for (i = 0; i < 10; i++) {
+		/* Shared mappings should always be readable. */
+		ASSERT_TRUE(try_read_buf(&ptr_shared[i * page_size]));
+		/* Every even private page should be guarded. */
+		ASSERT_EQ(try_read_buf(&ptr_private[i * page_size]), i % 2 != 0);
+	}
+
+	/* Remove guard regions from private mapping. */
+	ASSERT_EQ(madvise(ptr_private, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	for (i = 0; i < 10; i++) {
+		/* Shared mappings should always be readable. */
+		ASSERT_TRUE(try_read_buf(&ptr_shared[i * page_size]));
+		/* Private mappings should always be readable. */
+		ASSERT_TRUE(try_read_buf(&ptr_private[i * page_size]));
+	}
+
+	/* Ensure patterns are intact. */
+	ASSERT_TRUE(check_pattern(ptr_shared, 10, page_size));
+	ASSERT_TRUE(check_pattern(ptr_private, 10, page_size));
+
+	/* Now write out every other page to MAP_PRIVATE. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr = &ptr_private[i * page_size];
+
+		memset(ptr, 'a' + i, page_size);
+	}
+
+	/*
+	 * At this point the mapping is:
+	 *
+	 * 0123456789
+	 * SPSPSPSPSP
+	 *
+	 * Where S = shared, P = private mappings.
+	 */
+
+	/* Now mark the beginning of the mapping guarded. */
+	ASSERT_EQ(madvise(ptr_private, 5 * page_size, MADV_GUARD_INSTALL), 0);
+
+	/*
+	 * This renders the mapping:
+	 *
+	 * 0123456789
+	 * xxxxxPSPSP
+	 */
+
+	for (i = 0; i < 10; i++) {
+		char *ptr = &ptr_private[i * page_size];
+
+		/* Ensure guard regions as expected. */
+		ASSERT_EQ(try_read_buf(ptr), i >= 5);
+		/* The shared mapping should always succeed. */
+		ASSERT_TRUE(try_read_buf(&ptr_shared[i * page_size]));
+	}
+
+	/* Remove the guard regions altogether. */
+	ASSERT_EQ(madvise(ptr_private, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/*
+	 *
+	 * We now expect the mapping to be:
+	 *
+	 * 0123456789
+	 * SSSSSPSPSP
+	 *
+	 * As we removed guard regions, the private pages from the first 5 will
+	 * have been zapped, so on fault will reestablish the shared mapping.
+	 */
+
+	for (i = 0; i < 10; i++) {
+		char *ptr = &ptr_private[i * page_size];
+
+		/*
+		 * Assert that shared mappings in the MAP_PRIVATE mapping match
+		 * the shared mapping.
+		 */
+		if (i < 5 || i % 2 == 0) {
+			char *ptr_s = &ptr_shared[i * page_size];
+
+			ASSERT_EQ(memcmp(ptr, ptr_s, page_size), 0);
+			continue;
+		}
+
+		/* Everything else is a private mapping. */
+		ASSERT_TRUE(is_buf_eq(ptr, page_size, 'a' + i));
+	}
+
+	ASSERT_EQ(munmap(ptr_shared, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr_private, 10 * page_size), 0);
+}
+
+/* Test that guard regions established over a read-only mapping function correctly. */
+TEST_F(guard_regions, readonly_file)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "Read-only test specific to file-backed");
+
+	/* Map shared so we can populate with pattern, populate it, unmap. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	set_pattern(ptr, 10, page_size);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+	/* Close the fd so we can re-open read-only. */
+	ASSERT_EQ(close(self->fd), 0);
+
+	/* Re-open read-only. */
+	self->fd = open(self->path, O_RDONLY);
+	ASSERT_NE(self->fd, -1);
+	/* Re-map read-only. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Mark every other page guarded. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_pg = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_pg, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Assert that the guard regions are in place.*/
+	for (i = 0; i < 10; i++) {
+		char *ptr_pg = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_pg), i % 2 != 0);
+	}
+
+	/* Remove guard regions. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Ensure the data is as expected. */
+	ASSERT_TRUE(check_pattern(ptr, 10, page_size));
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_F(guard_regions, fault_around)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "Fault-around test specific to file-backed");
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Establish a pattern in the backing file. */
+	set_pattern(ptr, 10, page_size);
+
+	/*
+	 * Now drop it from the page cache so we get major faults when next we
+	 * map it.
+	 */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_PAGEOUT), 0);
+
+	/* Unmap and remap 'to be sure'. */
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Now make every even page guarded. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Now fault in every odd page. This should trigger fault-around. */
+	for (i = 1; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(ptr_p));
+	}
+
+	/* Finally, ensure that guard regions are intact as expected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_p), i % 2 != 0);
+	}
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_F(guard_regions, truncation)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "Truncation test specific to file-backed");
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Establish a pattern in the backing file, just so there is data
+	 * there.
+	 */
+	set_pattern(ptr, 10, page_size);
+
+	/* Now make every even page guarded. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Now assert things are as expected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_write_buf(ptr_p), i % 2 != 0);
+	}
+
+	/* Now truncate to actually used size (initialised to 100). */
+	ASSERT_EQ(ftruncate(self->fd, 10 * page_size), 0);
+
+	/* Here the guard regions will remain intact. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_write_buf(ptr_p), i % 2 != 0);
+	}
+
+	/* Now truncate to half the size, then truncate again to the full size. */
+	ASSERT_EQ(ftruncate(self->fd, 5 * page_size), 0);
+	ASSERT_EQ(ftruncate(self->fd, 10 * page_size), 0);
+
+	/* Again, guard pages will remain intact. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_write_buf(ptr_p), i % 2 != 0);
+	}
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+TEST_F(guard_regions, hole_punch)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (variant->backing == ANON_BACKED)
+		SKIP(return, "Truncation test specific to file-backed");
+
+	/* Establish pattern in mapping. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	set_pattern(ptr, 10, page_size);
+
+	/* Install a guard region in the middle of the mapping. */
+	ASSERT_EQ(madvise(&ptr[3 * page_size], 4 * page_size,
+			  MADV_GUARD_INSTALL), 0);
+
+	/*
+	 * The buffer will now be:
+	 *
+	 * 0123456789
+	 * ***xxxx***
+	 *
+	 * Where * is data and x is the guard region.
+	 */
+
+	/* Ensure established. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_p), i < 3 || i >= 7);
+	}
+
+	/* Now hole punch the guarded region. */
+	ASSERT_EQ(madvise(&ptr[3 * page_size], 4 * page_size,
+			  MADV_REMOVE), 0);
+
+	/* Ensure guard regions remain. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_p), i < 3 || i >= 7);
+	}
+
+	/* Now remove guard region throughout. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Check that the pattern exists in non-hole punched region. */
+	ASSERT_TRUE(check_pattern(ptr, 3, page_size));
+	/* Check that hole punched region is zeroed. */
+	ASSERT_TRUE(is_buf_eq(&ptr[3 * page_size], 4 * page_size, '\0'));
+	/* Check that the pattern exists in the remainder of the file. */
+	ASSERT_TRUE(check_pattern_offset(ptr, 3, page_size, 7));
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+/*
+ * Ensure that a memfd works correctly with guard regions, that we can write
+ * seal it then open the mapping read-only and still establish guard regions
+ * within, remove those guard regions and have everything work correctly.
+ */
+TEST_F(guard_regions, memfd_write_seal)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (variant->backing != SHMEM_BACKED)
+		SKIP(return, "memfd write seal test specific to shmem");
+
+	/* OK, we need a memfd, so close existing one. */
+	ASSERT_EQ(close(self->fd), 0);
+
+	/* Create and truncate memfd. */
+	self->fd = memfd_create("guard_regions_memfd_seals_test",
+				MFD_ALLOW_SEALING);
+	ASSERT_NE(self->fd, -1);
+	ASSERT_EQ(ftruncate(self->fd, 10 * page_size), 0);
+
+	/* Map, set pattern, unmap. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	set_pattern(ptr, 10, page_size);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+
+	/* Write-seal the memfd. */
+	ASSERT_EQ(fcntl(self->fd, F_ADD_SEALS, F_SEAL_WRITE), 0);
+
+	/* Now map the memfd readonly. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Ensure pattern is as expected. */
+	ASSERT_TRUE(check_pattern(ptr, 10, page_size));
+
+	/* Now make every even page guarded. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Now assert things are as expected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_p), i % 2 != 0);
+	}
+
+	/* Now remove guard regions. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Ensure pattern is as expected. */
+	ASSERT_TRUE(check_pattern(ptr, 10, page_size));
+
+	/* Ensure write seal intact. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_FALSE(try_write_buf(ptr_p));
+	}
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
+
+/*
+ * Since we are now permitted to establish guard regions in read-only anonymous
+ * mappings, for the sake of thoroughness, though it probably has no practical
+ * use, test that guard regions function with a mapping to the anonymous zero
+ * page.
+ */
+TEST_F(guard_regions, anon_zeropage)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr;
+	int i;
+
+	if (!is_anon_backed(variant))
+		SKIP(return, "anon zero page test specific to anon/shmem");
+
+	/* Obtain a read-only i.e. anon zero page mapping. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Now make every even page guarded. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Now assert things are as expected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(try_read_buf(ptr_p), i % 2 != 0);
+	}
+
+	/* Now remove all guard regions. */
+	ASSERT_EQ(madvise(ptr, 10 * page_size, MADV_GUARD_REMOVE), 0);
+
+	/* Now assert things are as expected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_TRUE(try_read_buf(ptr_p));
+	}
+
+	/* Ensure zero page...*/
+	ASSERT_TRUE(is_buf_eq(ptr, 10 * page_size, '\0'));
+
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1


