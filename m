Return-Path: <linux-kselftest+bounces-37074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA9B016CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E068A1889051
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 08:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09281F582F;
	Fri, 11 Jul 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nz5jFXan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSHVWrn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562657DA6C;
	Fri, 11 Jul 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223794; cv=fail; b=PeKTUtVGcs+MLwg4RoLGKC6AeLJIM51ciCiqP6MmgkaofA/AVkTjGG93YdPOQleqRxMmZNN27bbO7FBy0JtKVG9Kjm1Zw1JPi87mk/FIFG5z0QURp8qnCeDT8ExlOpf+hHTjOkMw6B9ZHJ7dgJEVrZlmrAZwXujzM4ANLNmE9V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223794; c=relaxed/simple;
	bh=Ia8nqXcvjcVMtlb09phZgJ7dNeYGc7iY5X/AqEpjGNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qylvjIKcSeLX4DnvaYOaoqiwpEA3EgYnU1mdekVARSsKXtutdlD8n+yO7qCY83CArZK0VP5rCbZw/52UMVZwJ8KnwmPSNsZuWOdHyI7hm7xlmUihrHTPlDDijL8U+UXJyuiWhmNHll3vyA/VUnXggNVjSLHLDgkACX4xuEDMfoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nz5jFXan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WSHVWrn6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B87KOY022874;
	Fri, 11 Jul 2025 08:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=P5MTaRTAGyBgNf2eiR
	BODcgd2Jq7Nv5QEnDavvVrfUI=; b=Nz5jFXanbJn0J1rxHULu44qdrXRmaZdO3C
	ZKoFfayDTkbJi534eB28M8Io01TOWSshWFdDn3A80ql6cYdAVX75oI8ZJtlyla20
	fPoiHSQjpHf0lRVk6k7dVuScqY1MgvC6KpETipyyL4ik/6hxNFA7KjBHUHkLYic/
	mVoDz9fCz9F1HjtyrKMStfv7QUopN2SA+VxUWaaxW5PLlkqMnxarEIwA1/8bnq6M
	gCnC2mF46ls6ojmiTOWg+smqwns5iS00PQD6dxROUlqGb3nOfGcrTqM1xS78LMwd
	qMAJVskSyOOCk6GxQJ+W1t6Wsg6rGjw7ahdmO+OGxuWAilObFpmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47txtn02fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:49:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7CAmF014058;
	Fri, 11 Jul 2025 08:49:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdbdn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh4xuzCmw+540cWvJZSxAJYqoJULZ89ww4R1bTptqP1ZMD5fUW4x06kqB7hWPIp9oKUeeuOr6UxQg47sY1QxCkgYksKWGxjZSH06TzqwAlhVUbi+kEL6TZZ8ZF+49PYdM83fB0Z/PtHVRFBWnPP9OZr2533RjjxQtVeGMC1sC6iUMOn+zNP04EnpcqY63HaNeW6QvmLNCrJFfTHjmpJ82TTzDPfRylAuVCj3i75I2YBW3iMrkLAla4N8w6qtmlqAM2I0wKwdV3we97fa4MYvn9gvuV8+W+BO/8l28zrJXrdh6cixuPFnl586GTh1vHrekmwWiflXnezC8UP8PcUUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5MTaRTAGyBgNf2eiRBODcgd2Jq7Nv5QEnDavvVrfUI=;
 b=zRAzT+uoLpLAfiQvYKqyFfX9zrFdPhPrNROXd6OB+AH0Wfkjkyl3ZYYQ5tSeJl8HKiypvI0gjko3lLaSwsKQqm5S/CEKzuqWgjFDt7BVRZ+//b4mh9ocqZktovyon8149jbx2F+Rno35fBL/sfWi9IPSY7EwO8uXd2/7msBXiMCqKcLTcamawlMh3zjvSGD5T/ep6OHey+2p6tbX6dIO2Y/tm3ohiSU/YpalctzGbnhGu0xi1NQiBCx/qz+Kge4WcEV+SeLF++vpepNvK2Z1aL5ucUaa5WEa7ECDoPztWMSi+tG4G95aDTrICoL2bVpHX1hAoCt8UxMFxNj1UjQEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5MTaRTAGyBgNf2eiRBODcgd2Jq7Nv5QEnDavvVrfUI=;
 b=WSHVWrn6mRZ84hsWKR8fYPN1ZUV5HxWONbftvcGccRm8ymi+ol55DA23Arv5n4l8sujwKUkDBSP9mcS1I3034mF6XPGU0d1ZQq7b+b8gk0jLIl6vV2PqbvjtdeUsOSAbA3EdYWjGm+KFI6K9mfD1xtSGzNw6koQrUuruNvvmab8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7335.namprd10.prod.outlook.com (2603:10b6:208:3d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 08:49:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 08:49:16 +0000
Date: Fri, 11 Jul 2025 09:49:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, wang lian <lianux.mm@gmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
        david@redhat.com, gkwang@linx-info.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, p1ucky0923@gmail.com, ryncsn@gmail.com,
        shuah@kernel.org, sj@kernel.org, vbabka@suse.cz,
        zijing.zhang@proton.me
Subject: Re: [PATCH v3] selftests/mm: add process_madvise() tests
Message-ID: <e05e7e0d-02e3-435c-bb82-91200a868448@lucifer.local>
References: <48D7AAD0-07C9-4E2D-9171-081A503B47AF@nvidia.com>
 <20250709123224.6593-1-lianux.mm@gmail.com>
 <A1603D53-03B1-412F-8FE8-851A37E4C08C@nvidia.com>
 <aG9889HWQ8K24z5w@finisterre.sirena.org.uk>
 <D536C704-BE27-43CD-AB58-4F55A7C97C9E@nvidia.com>
 <aHDMnogm_EOx4oMU@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDMnogm_EOx4oMU@finisterre.sirena.org.uk>
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: df7573ea-f577-4e16-be6d-08ddc057d14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rddqyeB20wwhInJSPHQdsQ5gr4Vm8iOhElnZ1mrC2kMV5PViNiDc1O0ot737?=
 =?us-ascii?Q?6+5pnAyb3eX55po1fkFrso6LrIyveL+2crmMXnSkv8ZCGZnYTFZbL3QgxD96?=
 =?us-ascii?Q?7WJBrMbmDVat697WA4zO6BpCWEiFOqtOuqNCfVXyJ6uLGqENBlIs/vOovEsO?=
 =?us-ascii?Q?uX1zNjqSWeUhhctdK9fCZOZPwBsAIivFGurNwvFbB3h7KmnGI1a1KeZu7Kw1?=
 =?us-ascii?Q?uda3DeaxutXfjElHMcPokEHD0rQ5PfPD6ERBHQNYqmV3X15ivXhA5obrYfwu?=
 =?us-ascii?Q?XIocWTs0xa7mbjjFFZwCgPzXxgkWDAfrVLV6+jQ2PF045Hrihprl9m0gzYQ+?=
 =?us-ascii?Q?cpRtzbNPVaPIIsaOno2l5LF6my1K67BdZ7IInaAc9o4xlH7mowWH8mCiC/PU?=
 =?us-ascii?Q?RideNDqkkI9U2b+tgBR2i5fJAEW6MqgLpEQBNBPobpjerW7Qfby+XqImnm1Z?=
 =?us-ascii?Q?Woj6HVFoPuHYfkydkSlOZkRmTIjDiyycibdXMDqO1pOvQTolg/v0JPxj4cUO?=
 =?us-ascii?Q?m6TVkU8xtJ7yb+LNzmFPHk3zv5zbmolF//qrhFp1bsXzwqdJwwe4luLCU4Cu?=
 =?us-ascii?Q?q65fvndAL9hcCRRHKJ4sh8dkmK74hJnuDAODpS/MtoAINE95Sy6hZjeMeAjL?=
 =?us-ascii?Q?Tl3Q4Vv+OCWExpKzeXpRHRpuAns3loN3qKi4TOKIml3CsfCCYmXhO3ZyLzAV?=
 =?us-ascii?Q?VA1oCNkARVMk5GAcbgmG6otV08pGRHUUgigTNqQjkBB+lmYC2BBBHgu2Olg2?=
 =?us-ascii?Q?z0cqHE6yqsy6YKNY1VYZWL3XUJxxUX9k9P9nBEGOImz7w29m9cfyIBzMdV6w?=
 =?us-ascii?Q?yZuoH+UNgjtPD8+MZsiInomTq0a1ZPyRXkXqKVbM5ctYA1YnIqlR0ESgwIIP?=
 =?us-ascii?Q?yAWFTkxB5u57+gRG7Ig0IDwwEoy8z+Itpvxj/fc+EO5iGsunYhpQ+4SCjwQW?=
 =?us-ascii?Q?1Tmi+alw1JOEYIaOftmJG8cp4P4fz5438jcaqcVw004ieYz9FrgN68uX0+TD?=
 =?us-ascii?Q?9x3D82oVhwnK8b+zgf+g4ZRO/IE/qJe2JqNFLTqnTHEDNejJyLCamZMGRSp3?=
 =?us-ascii?Q?8fxnaoAkhkaFdyBDrcPS8BP+ht6ydSaWUZWRWnolxUUS7FvswJAIMB3Lxi4c?=
 =?us-ascii?Q?ITun65AmqROw4xcLZlzvuVu5waEBcNuIPdREkOHwyvKu/qsQYydzYANpzA5/?=
 =?us-ascii?Q?TJRymm2eJ/lnKutmxYEr7Dpn49eMDJY/2/XZAVCX/2Ec6BmtQU+ZFiUIpqBp?=
 =?us-ascii?Q?fUIe5KnG3y1chlUh3E5YAtmKgjec0BQN6zaWB7G306DFAA86aFzp35VRppHa?=
 =?us-ascii?Q?4HxkvIDWOaUwggkD8futiiVMA9eotZh2I//0pkMl7qLarPGbYLYGKF4ebb+M?=
 =?us-ascii?Q?LIjFTBrxKYubUzP5ZkQz4iW5ilgX3FXNB5PQvXPcwmBgtnDF4OH58Gz1Szte?=
 =?us-ascii?Q?YRbY63DJCfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+htZNy+qHJeuqqTXUvwfcQZJpMUIjxhzpbHVpNXIbpmoOHdcXinINfXtKEq?=
 =?us-ascii?Q?uxftskc53Qnk7RijdIvzz3rkWaIC5NTYzis09gMZxkksWLo26ZBRXcouKdtG?=
 =?us-ascii?Q?vGXztR2c8SATYnKX3zgOxPddw3uBWZeryo5Viy5mafKFvQtIjl92IXUVnMMU?=
 =?us-ascii?Q?CXZgJZ0OsYKAqujWdGcmxBXW6fM/GkTNfe4hrj/+jfmQmCohRKyODmgN2CZX?=
 =?us-ascii?Q?RuIW2A9e8emgVT6t5yGqgESEGLVB1VNJ18d57jL/pqhBXpHltTiCYMSnSqM7?=
 =?us-ascii?Q?1CeRPoLJIYTkM4YdS/H5UH+lETEOo4DaWsPKimcvnU7SlhmNDH4YhNHpkw+N?=
 =?us-ascii?Q?W+GhqHWd7RiyVmJLPiapW97VP7drFkyFBuq3T1MUm6F0OBv/JCRAB7z5q53i?=
 =?us-ascii?Q?KiFKbF2Pqyttqe/CmCv1qnsFCKqrI1Cy3PjAKb/WVUgDGuK78t7UbtLqISPV?=
 =?us-ascii?Q?j81sPBeJW0FAd7L7QCoTLuROdgpPa7aLx5gbklqXGeQNZd5916haf0m76qqQ?=
 =?us-ascii?Q?zMoVrSv/kZg9O/pqMs4KjJlFwMlleAE+TE7uqas+uvN9HecdK6/7Ftg2KukE?=
 =?us-ascii?Q?5ENAPelbYvMfBj8Un14AnCvv6TWeSOksinZJzJUMDMPuy+g9yR3N1UoZcoLP?=
 =?us-ascii?Q?xqQfc3E6U+OJIfsqaq0uJcM+kP+/yFkg+D2md6uoADucbpnBH7XvparMvRt0?=
 =?us-ascii?Q?VrMzA/iEqvzoDWlKp7T/7xuLtq4Lfl2DkBTNu+IHcxysrNvB5CSL4ZGugr0x?=
 =?us-ascii?Q?CAkPFCgzdaCMAG5RRRvUhuJn7WP8QBk/VzP8KrnEI/L0q+pgdm6hIaLtxu8H?=
 =?us-ascii?Q?q3Dacc3DBNotZyv2fyJ8kC7V8Ya/aqGb3YHhRMhRLOYfEPy1lnHSLTsAa/l2?=
 =?us-ascii?Q?Zxit//bJlI7+ihbn48DYjPKy6hWvb64V5Cr6hXI/wsc5DGABrc8lZeIrfoz2?=
 =?us-ascii?Q?eYyhbzhvN5D8nh6cWU/qlUdE2yDM+PJi4pliXgbaHaK2CSs5EwchSVz+7noh?=
 =?us-ascii?Q?Aag5/CDl/xTzqgmPsXBbTny09nKHC0HhOQUYfNWBenE2eUlwAMyLLpE9YOR5?=
 =?us-ascii?Q?9Byga7Zr0iDeC9xIG/RZ5jEJBm35TDLAkgKzjmuPmq7NpfXYW7IbtwcRpvZs?=
 =?us-ascii?Q?dJy4qFIQgvxLiossQUgCuncNZ668Pk2KiXK/6OtdmKH8ZB70aujQ8CDGN53d?=
 =?us-ascii?Q?T8p/Xw9U5FgYYF7CAZcacRKFlCrJYpRchpEkP4LgmUjVzvGQQ4h7vCOJLqns?=
 =?us-ascii?Q?sA/uhCW/Osh0699CArXUnrwz11UqS1zmHDuGMcvyiqm8x9eOx32DDUd6Z1DN?=
 =?us-ascii?Q?MaCT6rf6sJt67goY6MrostCUUyFOJ14Yu3lKgmmdZQa2EwUc8KqNCja0M/Jq?=
 =?us-ascii?Q?L6U9SlxzRTJ0N4b3KWE2sz2/+QuDR6nwtNa80unuItNJnzku59Ez9qmz8gMH?=
 =?us-ascii?Q?LEgrYJZGPUV99L5yaD12buuc4eO1mBufRD9zZBHc+7txWrNB9vZpPrwCUV3G?=
 =?us-ascii?Q?TNqhopwaTydNOQ2uYVVICzuhZ3YdiA77cZi5T4AyoJaZx4W/EQrMowdtH6Qw?=
 =?us-ascii?Q?DmPjKW+Yq8Fok3KISTuBhg2B0FyyXB3JYUddYD/CSR7M5swebl0a01o/bR3i?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nYVG6WTvILLBmG7N7xUY2ZCKBRWCw6LwjMVus1GtOQdiYN21Uq3l9RmLdbsb4DE/WPJOb3dv9tzUPEq8fUHx1r9ScMt/AilCXt/HA4q2G1R8TFq/E0ALUerGuEnpnleRMqxRocdVDFR6nEHxTAU//jQTfW0VAAn3H12p8Hf3GkRgFlpNFGoHrqsspRe1JfZVULyBDNR03XpTtwe32ibZFyd/jesMjBuspw11p4MbtMFlk8mroCalS2KaX3zUWwLwW/EHqheUI9GWbrPMkWboUcidi9Ghu96JKfukluBAV63uIScFwGKZVv4Oq4c2J/7cEgdTw1FJIDsvpnD4vL5SXIgQ1mQQmeTYf8dEMofeuE/uMzwOCm6BjJ0Ov3/5RKJuKaI97XRCW2qwbBrfbspyiXx88BhEB8QSnoaSIYHDc02k5tHlxa/FY3+ESIh11ZG9qO4Ma7yzUI4YOG06x5Mv9MK/84581zsiDWDgEpChnSOg0n2DcfkbWYlUA/pIYV2hhFQn8qvqK2AGIxTJAfENhjEXHGNQFwlfA8/pEhGBsMpUIEZyX0AVH59cRQgQebgaqlpPttY0rpNiI/9ogg3e/76K8OoFixuf9ZrBhJzngPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7573ea-f577-4e16-be6d-08ddc057d14a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 08:49:16.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyDIq6oncB4vBF5rpRFxiHyPOocmRGS476UxYiFU1JsNel3/tyzKdYlWKGZ+wrsPxQY5UCMj6krzHctk8iBj6OSZUctXrVhNyg5oXQ9nkFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507110061
X-Proofpoint-GUID: aHc-2srN_PRVoMHIWg07IXj45xw5ZSOs
X-Authority-Analysis: v=2.4 cv=FucF/3rq c=1 sm=1 tr=0 ts=6870d010 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=rjNzJ-5dvgE4mmTVUIIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: aHc-2srN_PRVoMHIWg07IXj45xw5ZSOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA2MSBTYWx0ZWRfX48h2dUJJ09mN Dh5i4h0NZ8gR+oNfzXb1IYBREkGkfTKtfy2DAObH9xgYFQeCIXSewZrhwSws85VTRgayoBFsAUu AxjQlPOykvObtnFcfAiFSq1hR0gW6g78zhA1fKQWbWK89eySRRklejhwQZRcjkN+1yUlxsYo0Pp
 E6jqYuYUxgWD1Y4mvjE+tBcC2woHcK6qCk5vnmZ+cARmjX++I+0t/+iBrnkkYastEajy0nzHuT2 fy1j7s5mg8ZSBobEY7THcu8+FjOHa40l1SzDztl5oY8X0B9tn7Qeq6vmxY3jczCSXU82dZstKjG Uysqf/3XEBuObn7B2/hoEs8SELYTMfLjqBSvpoOmdD2x5g5ZjLZZzR3Zr/b8caAjOvmZIW7gjgD
 EoFuNgv8EBLNIrhmMQSS3Z85/evRPStuqEeiA+BTgDEM/tO8sx8nFDEjCWH8knCzPJQHYKQ8

On Fri, Jul 11, 2025 at 09:34:38AM +0100, Mark Brown wrote:
> On Thu, Jul 10, 2025 at 12:28:13PM -0400, Zi Yan wrote:
> > On 10 Jul 2025, at 4:42, Mark Brown wrote:
> > > On Wed, Jul 09, 2025 at 10:46:07AM -0400, Zi Yan wrote:
>
> > >> Right. My /usr/include/sys does not have pidfd.h. IMHO selftests
> > >> should not rely on userspace headers, otherwise we cannot test
> > >> latest kernel changes.
>
> > > That's not realistic, we need to be able to use things like libc and for
> > > many areas you'd just end up copying or reimplmenenting the userspace
> > > libraries.  There's some concerns for sure, for example we used to have
>
> > Sure. For libraries like libc, it is unrealistic to not rely on it.
> > But for header files, are we expecting to install any kernel headers
> > to the running system to get selftests compiled? If we are testing
> > RC versions and header files might change before the actual release,
> > that would pollute the system header files, right?
>
> Right, for the kernel's headers there's two things - we use a
> combination of tools/include and 'make headers_install' which populates
> usr/include in the kernel tree (apparently mm rejects the latter but it
> is widely used in the selftests, especially for architecture specifics).
> These install locally and used before the system headers.
>
> > > OTOH in a case like this where we can just refer directly to a kernel
> > > header for some constants or structs then it does make sense to use the
> > > kernel headers, or in other cases where we're testing things that are
>
> > That is exactly my point above.
>
> What was said was a bit stronger though, and might lead people down a
> wheel reinvention path.

Let's PLEASE not rehash all this again...

This patch literally just needs PIDFD_SELF, I've provided a couple of ways
of doing that without introducing this requirement.

We already have a test that uses this with no problems ever reported on
which this patch was based.

Thanks.

