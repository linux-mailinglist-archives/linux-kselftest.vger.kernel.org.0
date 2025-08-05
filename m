Return-Path: <linux-kselftest+bounces-38313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0DAB1BA8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64C04E2B03
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70B298CDE;
	Tue,  5 Aug 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TjeoqNhm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="stuE7HY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1F295DBE;
	Tue,  5 Aug 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420465; cv=fail; b=UxklCYJ3pohHCtNt/L/CtsKFpN9vldO2ajJG+bAYLCEYkSuUl8uNsQwsnc/OgUtnA1bh5jNm8Xka9k7RF3lDVjkBh1oUin5tXv0TxCr+b9xCPjRQwxBoPmzkV2Z4gAfkwcq09BMVYLGKXHQLXmux0z43cYTIjUuqpL1DknGGVSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420465; c=relaxed/simple;
	bh=V8BYHS0SpKh1tBqaaPzKao3H6Q0GdJWODShI77fzdW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Miyh8jYxaW7retKfa/czeRa1euRZ+xfWt8Y/Hjfao9ZuDfrd9QAHy8wTAsP+FkpbdNfRLp6v3JkprjynaxI9Ggk65sm2OR1RlrHGXreWf9NMM2F9I/jRN3YzRW3Hlgl40KOdFDMaEQaVI+BKVNTAyeaO10ghj9J4T7advreTbMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TjeoqNhm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=stuE7HY2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IuBFD014244;
	Tue, 5 Aug 2025 19:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+P5I7aMz1ueIWZsJvB
	uL2FDujybMNTWxeaL0Red80K4=; b=TjeoqNhmZzN4JC6gx80XJulvrJgnXm2J+o
	YpRH9w5sAobURJR46ND8nl7Fxj8VkP1mvphV+eh9zZhio6HVRDJtY9ljBjvYT6jj
	wo1fbI1KQkeYKOPFT3DtzXuPRZe0c/IsZWuT2fQdo95pu6PZtYWBMPUZ6FPfZbzx
	+aF34KN6SLnSL1afFZOumPtQaK/sGWcefHdnDg6eIpUNnXosOZKW08DUoRaz0OL5
	47GxE3/foHqXTxpX2AtlkRuhViG+u7WxAXQWjIwmai1vQhYt7wqFysGiT8Hiao12
	/mXxolbs1jj0ArGqA8QesjngGjogzYX1EtaZA+clf7/b7I15/z0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf037h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 19:00:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575I42xa008402;
	Tue, 5 Aug 2025 19:00:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwm2020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 19:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ5Nbvisw9pDaCOcH7GhfvgIwElrcwH0Jv/keQNL4/oRhzhNpnpWT+5L9ARnXE95hmxjQ0VJH9AwFWUbTjtV93sPnLPEwhM6JKVBS6nuPpRVx7EA6RKUANdpNAxSwKPIc5WA8PEDRC5uqxJAukeEjhA+tzriyrBqY6oRcHb+nme/KmEPo3RSf8hoh/lT+5f3Ug74VwIRPvLTT0vb9/v7TnZZvOyJ2iFP4KLdSfiS50PBlT8TBsyog5HEkFA65bMDlkDmvVYnIMkOMLnyJT0UfKXO+DBSzv7PXvbIkcBy1ZcFxIg1eXepnTLTyt2HY3fSkIJ7NlnLzc25BVo2qKUW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P5I7aMz1ueIWZsJvBuL2FDujybMNTWxeaL0Red80K4=;
 b=tcoPKwSaCMumj/j2x1fRrmcgRdtTwuSS0GYQoqTKwu/EvJ6h5E/zhEOm6yNFTaRk7nKIrz3F660KpS7DF6uEktLg52P2BAqF3hB5CDRxTo4p6GIRs5J0jHq0lhM8CwkKNSSyQNh1TgZ4m2qTICPRd0qVvu8zYYuHf5KiwDtK3rRiAwqqOGi1jigDpv34QoBqylCEqpOtu+8KnrCSTpD5AFe+nASVnSc3bVkAfGvUeg0nnqrVEa7cOWROxcnJaO5qt3jk2Ai/Ev/EVHB5VES5rKM6XgySTsgotfR90AMMcHdtFck59kpbWYxWtsIPn8BibIwVH6/i2b40jbAVkjd8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P5I7aMz1ueIWZsJvBuL2FDujybMNTWxeaL0Red80K4=;
 b=stuE7HY27wSb1qkVcYCU6MxqSgNjbYIrVB+0r8EFeA0ngmQHlW0o77+adhy//j75srVUGU0Qn7Te9BGTNNCp7tu94EVOyEuU56wqRPThS4e13d23aMefXX7KItUhcK8ZGu7HcDBoAEq0Sz90wTErEJI8l+E2JhNUOqYRtidbgQU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4645.namprd10.prod.outlook.com (2603:10b6:510:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 19:00:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 19:00:10 +0000
Date: Tue, 5 Aug 2025 20:00:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: wang lian <lianux.mm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
        Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Message-ID: <7eaa1660-06d3-49b9-ba5e-28df1c35dcd1@lucifer.local>
References: <20250805175140.241656-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
X-ClientProxiedBy: AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: cb41e24b-d4eb-4321-033d-08ddd4524d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6lDRhogpyl9Kw85VlbE/nlJfZ/+sYcSECx/RdBkKx1HpWYNP15HpgfS9W1s?=
 =?us-ascii?Q?wBRr9b39UzYetJQ2S6H3idPnEsPlKBthRxjDg1awGJebWqExdiBroWgA61hP?=
 =?us-ascii?Q?L0PHZcW7QArFDgSnTJKwQEuWiZCSJe3LAHiIjQoC9UYXfRILPjlOZ33CBr+R?=
 =?us-ascii?Q?5Odaa26ctngdrRWO/xartP3nlxMSbfgE/y0SXGJY8pD2X2FwOmzHRuDqrdlG?=
 =?us-ascii?Q?y1iYf6Ft8IHyoi3+L3cMW14wqw4qLZmVk/xU2wUDm27LX+yTeqDLCKcZ1ewq?=
 =?us-ascii?Q?+Ep15NbrZa0EUW7xeQ2/IW2yw1lXQxzOtdl6curfvVwRtNe204faT5un1LLA?=
 =?us-ascii?Q?U0n9x2fOuzc8/UbXtnJz4dkwka8qIfS3t21VJDgSDDtUPJaSX81/+bhW0IxF?=
 =?us-ascii?Q?DDFaelTDnj9uUHGWRDe1pzohHuE9YMtr72CAjx/hf9PTf6RpbDVovQTZRT+4?=
 =?us-ascii?Q?P7GLnXuab8/0Pkrm1b9AMIIjjkUzvZFFMKCOg2I1v/t+CK36HP06diqVAOmw?=
 =?us-ascii?Q?5mq+i5K1UxPGryU48agWkKqPkYwdtStY5Pndm7paI3O4Ws5Vv4tm64TtkXjF?=
 =?us-ascii?Q?v/4AlyFS5cX9lY72vZsf0G4kbo4uIVvMQvLOjuTPJHIWe5WkVMHFEgKktR7r?=
 =?us-ascii?Q?qTQbgPeiKvEQmrlJGvuKNRDM1g3MFhAZvRI08X5/L/h/KNkHNPUQaABPSOa9?=
 =?us-ascii?Q?8OgMfa/AlA6wgWrFD0kz1jWeayyMLCdk8mnvLToaV5qus7cn6n0p5ivERhEK?=
 =?us-ascii?Q?hqAdpWn4rlPeO2QvWELSbk4WPOaGOd0XI9/xePJOMJ48lMNv3N4c91Zd9b7x?=
 =?us-ascii?Q?kRDjvf7zYRTxV8mJiJciOdf/JXqMUANE2RraiZX63Eh128Jni+M8I1tkArtq?=
 =?us-ascii?Q?uySd1mDSpklVTdKebSYQ4FJRj3NjVjBND6aH9XCvbAqUtzNb9N3OV0Z43EQj?=
 =?us-ascii?Q?v/Oifwx+55Zlw+acMytGXEcrdLlSgkZaovXXh/3RhApO3zRbapXT8F7heEOS?=
 =?us-ascii?Q?93e47hP9x0Z4eOOtlHOLKPVCju9LCc4+MhruFI6sT0CQ8bCgXwQpWx8+1DoR?=
 =?us-ascii?Q?shwUhf27ArI/W3dMDaJvdlo/Jyv/AgcKiqGaUNeLW+ALAziDO9ReGXtCINYK?=
 =?us-ascii?Q?5ydyrmxVuQ+pv2sHYfJwxk0rlBzBnAeIyz4+DJsZymmgASAgkpPgIkLcm8DX?=
 =?us-ascii?Q?SH6gezXjjJXqCywC5K7R1kWvjyq9gQo0derexQ+qRo1033wXJZPGxtjfBrm0?=
 =?us-ascii?Q?zDgWbwgA127TtFeNPwtm+fEZa/ENbwuMrghVsQ7jBmIIzOwK/JeV5CCGBdUn?=
 =?us-ascii?Q?gR9SVm0bZXq5YZnJXyRM86jSFfp0eF1xrlezyKuya2u1N0mqxjy1gKIEEixd?=
 =?us-ascii?Q?LMiBZlV4RHNSvyEoPOb2d4eL4WWOQ30WRNeme7Vh76CwLgYT/2dSXTX1P9Uj?=
 =?us-ascii?Q?C552T7DDMnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qBikORuH571qh1dXx1gYQZCIuPotOZxrl1tmYs0BxVE38iI66mfBChG4Ych?=
 =?us-ascii?Q?FUb8FSQupv5WJga06tlmjCXSV2QJDIAJNvliAEJN94k5TI9Uybrpyyr7yDLx?=
 =?us-ascii?Q?nfF3SdNPecuIFdhChkBrPJY8YQuPsk9CNMVZmArwuHrel98SqNGQ8BpxTiDZ?=
 =?us-ascii?Q?qJlMq6vjd8gK1PmGy9neU+1oGERwdX8RYvUF2OD8pDRvbaHiVruF+gon6Vjw?=
 =?us-ascii?Q?TPVP2/KaNGcaGL/fsSt6gYnUgzk8970FTGuF6XdReTYt73JQY6BBPO6Bd5Uj?=
 =?us-ascii?Q?Gxg9aVyD/ycB5c9D7SyHxW4+l1IgDkeil/ixOod/sNB7lhJ6jc3/0XAaN1q0?=
 =?us-ascii?Q?unKc5FC2aEh3+tZJvwLMAgVtvNbzRxYuqYVQVMPvQtNCk4x8qbouaE/LvY+b?=
 =?us-ascii?Q?pA+ZUuMaJ3b+Uw61I6vuRgEZ2nVmOnAeRnwIrSEn1L1rCu4tzo0TmNdvpLoN?=
 =?us-ascii?Q?x9q9czH9jAtuFqLrt0uXt05jKeoopt3xLRJOQw1sKbbVwZzDaTAIColUyYTW?=
 =?us-ascii?Q?7zGvJyFcqbn18y5KCNnsgI61YGLbhtJ2E25YoV4fHs90vC31BJfdp2aY5gLv?=
 =?us-ascii?Q?782ARyoKvJ2PC6sXrNpVvd2M0z5R9W9dxcm/w76KlfjXopoQsTSQ6pi3Bh6c?=
 =?us-ascii?Q?ywtPBKISOssHf7g0Y560DsXlo5FbDNqvpnTZq1EEf7X5U8rC3XekiB5roZBQ?=
 =?us-ascii?Q?eceqDzz0R9K3EScIoy+qDVed8HbHsK3oVIk8RIjUP3N9GAd03qTGfjQgYfyg?=
 =?us-ascii?Q?G3SXRrnl4Ip4PhLNRTGFp9L1Y6PJ3QgUeaEVCjJe2U2UsaLZMRJ52Q6oM3oj?=
 =?us-ascii?Q?hg4uHHgzECkM9CzutA7WEPp7+SByRSPsScDN4SorPb+yGkvxQ2LY2IjsGVPw?=
 =?us-ascii?Q?Qq0GjkjX/Vsra1wWgkocPEZ9v2xFSfejSiJJurfEskD/mx3vaufJoYIfpPWE?=
 =?us-ascii?Q?bnbyyj62yt/5bE2wgysmskRpceqVLmvIYoGiGcYqRnIUNzznoxFg9UHx/+TX?=
 =?us-ascii?Q?d+2rF4s/hu6S6YpWgRU1yiAZBE+Ggc3eOC2dU2b+KCSd6st8PZmpfbJIMgeo?=
 =?us-ascii?Q?in06Tru2Ueuibxs5e02GPOfeMoT7nnE8jENBs8v21oM48/cch9L846j48oST?=
 =?us-ascii?Q?WzOtjgPxAmFYzA++eJDZVTQj04WJKro34a5HbrHVUn8tcvbgH3IguZeugxOV?=
 =?us-ascii?Q?8hv2x4++wLDVWlhvcDa+2ZQAhBMhhjJV8HIBo01p9+aAAL4+58LwKwGSAd5q?=
 =?us-ascii?Q?c7HP/jLAyvMduead4iILXnSGzl8oESe1eANEtAsfmxJj3ys+QPkwqFkOQNE+?=
 =?us-ascii?Q?rAB2h/0JaxHDq3DMUhMps6D3FIPMxZFX4QbMLApk/jVSWWjpE9sJF0yhQH7e?=
 =?us-ascii?Q?FrmqgGXn2bEI+4sa1XbbAciwKv/BVwjOjAQ2tCeGrwcuB9H5pTMOHR74jEwL?=
 =?us-ascii?Q?YJJS0r3y6pnU1ELKACMBuEJb7+n5KbdnLPtMFwxembO5vynevvj0LYrnJaMX?=
 =?us-ascii?Q?La17gyHxXJ4I0YmJ3i8kqIUMDX7XHhMFdwRO81Ev2PyvUEOl0ZYCBCTykHxz?=
 =?us-ascii?Q?AYRC9zw4tI4Db8I9wIDD6dDOOKsMx1kO1vN5ArB5bq9sARsdo9kxj94zpbXc?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dBJGEOdnFwiSdggUqF75eQiAYSo3J8nd0VelxvRj70NyeCx8/PzUSG5EvAjszkwk8qMMLYxwE7sN7z7v5oC8bfXsekweunEaAouScLpSAwMo2Om7PQQA9XVsbtKlfADKAzLm3LIKv5ua0oTwWeOAXdx86xeeJ+iOubida4OJUPwSRIxLAUSs9LE08FmGkMeLwl0F6XZUFjy/1/AZN6LZ3HSUoY8SkOldqLdPVMVs3ptAbEDUx6xHh4pbV+86rIjcGV9twiCEkOnafsq2GcacIheUZ1PlZYUeEmgQ+hOV6OvkmRChJb4du/N5xAUVfgzWBNqb0DG4ns4Y7p11XJXwGyfCdDw45oS6Jdj7L5F0kKxkQLRSZfEALLLFgbrQ1Ol2kpbuW0D1WFmFEQaAR27IYrRyfxTLgY0UiXP0db0qzrIk7wv1IErR/peoaCj8r33rdAGjDnFEWseppOAOXpwonNJXTXCRPNJlhwDFL6H4ZSMncz+7WXrVm6gISzXAzBlxlJlsLTlOVedOPqkVjJxZnPgxbCcrUm4SNcMkwPB0/mrPymc9c5hi2gxie3nZ82hrSqUbssBmOSGdcfV7Vkhsjr9acMEJW0COtvZCcoER1m0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb41e24b-d4eb-4321-033d-08ddd4524d2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 19:00:10.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Km84Ci1uvQsbbLhZExvzHaFtSIeWkllHSwRlqxhs+/TC2+s86zz7IZqXOpYAFDsC1HZm4xsVtadDenhxixeYw6Ld2PMzvA/qho2SLDdenkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508050134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEzMyBTYWx0ZWRfX3MtraaUNaAre
 hVPKOnIZOBtjAQo+qkgyRDEa4mGplfwM14eal3XkIHKp1TBLO/WRPjpR01W1reqmZiNI6FfqH8a
 AOCQrYgK2jc5FWVmLJnen0Jj/esgoYm/4pCRzouH15DE/kwII3jspeAIE120hbgTifJUWHiWgmb
 DtKCED/3/oik9EdnTyEYpH4O+eu//3ZFYn4SKAzAO5OErbnAbt3rSSLBm3v/j8vOMejVI09G08D
 mH9dSai8Sl6/cdsjhiJZwONgLy1/NnsBy4snO02Fb35rS0bZ81q+TwR8Xg0mGKBzH+7AUxlY97a
 R7h/D2JIfqxbXh6TULGKLxxA/5JJlXfMlQn4JGfnCC3TEdlFJ77dwf8T18eU8fU/yT+1GEw8RB2
 ZURg94rYbCAlxLOrUZD/3fK5O1F/M0P6xfejZ8QNuvkbZsIITufa7nZrhxRRxuYJ6qaYxq8a
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=689254bf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=wJvJRYaxsKidUacMsqMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: c1Nrj9XNN9yUSRN9_oCVkdde5g_Qb4jv
X-Proofpoint-GUID: c1Nrj9XNN9yUSRN9_oCVkdde5g_Qb4jv

On Tue, Aug 05, 2025 at 01:51:40PM -0400, Zi Yan wrote:
> FORCE_READ() converts input value x to its pointer type then reads from
> address x. This is wrong. If x is a non-pointer, it would be caught it
> easily. But all FORCE_READ() callers are trying to read from a pointer and
> FORCE_READ() basically reads a pointer to a pointer instead of the original
> typed pointer. Almost no access violation was found, except the one from
> split_huge_page_test.

Oops, sorry about that! I had incorrectly assumed typeof() decayed the type
when I wrote the guard-regions test code, and hadn't considered that we
were casting to (t **) and dereffing that.

And as discussed off-list, if you deref a char array like that, and are at
the end of an array, that's err... not brilliant :)

>
> Fix it by implementing a simplified READ_ONCE() instead.

I sort of intended to make this easier for pointers, but the semantics of
this are actually potentially a bit nicer - it's more like READ_ONCE() and
you're passing in the value you're actually reading so this is probably
better.

>
> Fixes: 3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

But see nits below.

> ---
> FORCE_READ() comes from commit 876320d71f51 ("selftests/mm: add self tests for
> guard page feature"). I will a separate patch to stable tree.
>
>
>  tools/testing/selftests/mm/cow.c                  | 4 ++--
>  tools/testing/selftests/mm/guard-regions.c        | 2 +-
>  tools/testing/selftests/mm/hugetlb-madvise.c      | 4 +++-
>  tools/testing/selftests/mm/migration.c            | 2 +-
>  tools/testing/selftests/mm/pagemap_ioctl.c        | 2 +-
>  tools/testing/selftests/mm/split_huge_page_test.c | 7 +++++--
>  tools/testing/selftests/mm/vm_util.h              | 2 +-
>  7 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index d30625c18259..c744c603d688 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -1554,8 +1554,8 @@ static void run_with_zeropage(non_anon_test_fn fn, const char *desc)
>  	}
>
>  	/* Read from the page to populate the shared zeropage. */
> -	FORCE_READ(mem);
> -	FORCE_READ(smem);
> +	FORCE_READ(*mem);
> +	FORCE_READ(*smem);
>
>  	fn(mem, smem, pagesize);
>  munmap:
> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
> index b0d42eb04e3a..8dd81c0a4a5a 100644
> --- a/tools/testing/selftests/mm/guard-regions.c
> +++ b/tools/testing/selftests/mm/guard-regions.c
> @@ -145,7 +145,7 @@ static bool try_access_buf(char *ptr, bool write)
>  		if (write)
>  			*ptr = 'x';
>  		else
> -			FORCE_READ(ptr);
> +			FORCE_READ(*ptr);
>  	}
>
>  	signal_jump_set = false;
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 1afe14b9dc0c..c5940c0595be 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -50,8 +50,10 @@ void read_fault_pages(void *addr, unsigned long nr_pages)
>  	unsigned long i;
>
>  	for (i = 0; i < nr_pages; i++) {
> +		unsigned long *addr2 =
> +			((unsigned long *)(addr + (i * huge_page_size)));
>  		/* Prevent the compiler from optimizing out the entire loop: */
> -		FORCE_READ(((unsigned long *)(addr + (i * huge_page_size))));
> +		FORCE_READ(*addr2);
>  	}
>  }
>
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index c5a73617796a..ea945eebec2f 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -110,7 +110,7 @@ void *access_mem(void *ptr)
>  		 * the memory access actually happens and prevents the compiler
>  		 * from optimizing away this entire loop.
>  		 */
> -		FORCE_READ((uint64_t *)ptr);
> +		FORCE_READ(*(uint64_t *)ptr);
>  	}
>
>  	return NULL;
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index 0d4209eef0c3..e6face7c0166 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -1525,7 +1525,7 @@ void zeropfn_tests(void)
>
>  	ret = madvise(mem, hpage_size, MADV_HUGEPAGE);
>  	if (!ret) {
> -		FORCE_READ(mem);
> +		FORCE_READ(*mem);
>
>  		ret = pagemap_ioctl(mem, hpage_size, &vec, 1, 0,
>  				    0, PAGE_IS_PFNZERO, 0, 0, PAGE_IS_PFNZERO);
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 718daceb5282..3c761228e451 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -440,8 +440,11 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>  	}
>  	madvise(*addr, fd_size, MADV_HUGEPAGE);
>
> -	for (size_t i = 0; i < fd_size; i++)
> -		FORCE_READ((*addr + i));
> +	for (size_t i = 0; i < fd_size; i++) {
> +		char *addr2 = *addr + i;
> +
> +		FORCE_READ(*addr2);
> +	}
>
>  	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
>  		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index c20298ae98ea..b55d1809debc 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -23,7 +23,7 @@
>   * anything with it in order to trigger a read page fault. We therefore must use
>   * volatile to stop the compiler from optimising this away.
>   */
> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))

NIT: but wonder if const is necessary, and also (as discussed off-list
again :) will this work with a (void) prefixed, just to a. make it clear
we're reading but discarding and b. to avoid any possible compiler warning
on this?

I know for some reason this form doesn't generate one currently (not sure
why), but we may hit that in future.

>
>  extern unsigned int __page_size;
>  extern unsigned int __page_shift;
> --
> 2.47.2
>

Cheers, Lorenzo

