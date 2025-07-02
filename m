Return-Path: <linux-kselftest+bounces-36365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A0AF6645
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6C17B2CCA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07E5315511;
	Wed,  2 Jul 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMVSaFbV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A230E856;
	Wed,  2 Jul 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499029; cv=fail; b=Yt9Gs5vz41d+i+AWm8K1rO9XK752/lGmwCGLybxQXAnTECgy5wZnXJr+dbJA7TWb5OnqXwRTcHEnS5Vg3E3brN7ylBe2SNMNal2vKl6Og2L7ZS9uT0q0TtB96iWXlVgeLrgnVmQdhs8kSC8z8qidkzy/NFMz0XqJFIcQ9gPrq3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499029; c=relaxed/simple;
	bh=s2iGh051VPmnMAPt36ZVSB97PIVoTNR7PMctiD3K5Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzL4lLH0H4apaKfmDSkSB9nR+jVd36GU13Radj2z6ZghsxWGhv6LWiJS2lp/o/T8lSvW4xPon85K4kf4w0Agk4eczB3dKx9eiBHOEPKZ1kKTQhCrv5GnZXBMddG2MlqeI8C6cTREi0w8F+d+W6pSpYfQxbQgrO0llR3o/L30q8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMVSaFbV; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui1ZY8hPilgPqToRlQRXH0TinTbMdf44uPJ/pR0+pW2KnGt1P1sHAP9pTLLK15Cd0DPsI/Rx4a5RLUcQtNM7Q+tRmE1O4lk5XyMvVIJYTTm9YQUy0S52EAH+sRPVRZC97Uc4SFYgl6LfifNfx/2Z8+1tLQbAAdB2LhGvlDPOd/INE+7yY+1XWgRYki20byzEsH3dKM7TLOdnzDEDhpDkQGy9WuLhlrk2cerN5nravECidzWU21i6bRK9X+dCnQuef1fe0vizkmcSkAwUApsDjUjiRFj/30ZxlTWbWC17rGDQaovuXrhMgwrAHcWBlisbG0wQzroIXjbUuSkH2c2Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0XBiVdDdejACUoRwTBbTqmBQiMyfVXdmEGwrW93d0U=;
 b=dzwl2m7YH3LHgulocMrG4Bp3X2v25UUCKm2ne2jICoqt86fI95k2hz1437PzRbCNy8jwFGgHiqbAq8O6QDfHLLTnwQ3VcLUA/KSU0qexY3zO5WfQto8xjeoXSyhGRhRVv+9K8hDGtHszTjtYuPkN82CRAgxz7NxdOORSCNAi/35/fuF6IUb/DBSIezbEoJTe5NUqfND4u6nRp8qs8y5Sc2wKCP5DAdlDWF/qS+sdfoTp3HvXLZY3wpuiFgsFJn0ApZARQ48nzceGBqF3Pn8Hp5+KoEifFImPFe7YlNC7pdGX2G8tGCqB5VH7nx1OytnI/zeBwizedLYJFfYuapDU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0XBiVdDdejACUoRwTBbTqmBQiMyfVXdmEGwrW93d0U=;
 b=MMVSaFbVjeOD6Hvh//QrePedG/ddCutOXkkihc7lIQma5wvoNuMi5mBn+E5Mh+ySn2h4bSoRu44gcewW5ho5Sm4qDkujh2RA/IPLXvavZVE8FEIfrIjV3r2rSL9y9475dndsfmb9lAY7CSjlJ1GNaimEpTO65O6mIF31bKFfDqQj+aFeD/7bKaSrM5PA1wzEPEZ2/xLNph/t1mtcqTfUFxwkK72L0ZPo9LqwFOmZm10pLZBR9MC8slFTB0BnfGwLvJXHtMB7oUcLA8kcVlcP2xzRQmb2Q9FaWKzl8JjYSk2G01l/yFlHotKHGdUClJDtV3BAEYL6q9hRkzN/fRxBkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 23:30:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 23:30:24 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v6 14/14] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Wed,  2 Jul 2025 19:29:39 -0400
Message-ID: <20250702232944.3221001-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702232944.3221001-1-joelagnelf@nvidia.com>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:208:32e::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 47697c36-0f51-4ed1-770e-08ddb9c06b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T31xltPyPyp1dznhZiEnHfvbMSuNzUEREti0mp0VylAbOCGkMWUjIQUcWcQN?=
 =?us-ascii?Q?L78oGUlebfSc4m7ibyv+FD0lcRa8/An/RVMZlLoWc20AuYMiSdn8UlBvnkv1?=
 =?us-ascii?Q?KnLoIdbJggZQxmiQerEUll0XaNzMRCNm9/J+CuqGduBjFYYGdUOzE26+Brup?=
 =?us-ascii?Q?92h50Kk5O2scyGfx2a3e7UZ0PX+OVkCCEFNa2qdqNd2FrWhC13qG5b28UumQ?=
 =?us-ascii?Q?oKby+0vb4uViED9d6cbP7dHgprwe8PnxIoVo4UopW9j5nPEDrA8IDIhKqTaA?=
 =?us-ascii?Q?JhD3LVxf52wwA+LWdJ3YGHMXHPYRvNPzHItCev81C/XbRIU/WBgi9Ww4n0P8?=
 =?us-ascii?Q?NaSYqCQNKF52fFt73a8z0hi1vXmLIZicmvT6v0EvYPMciXGYWGXXyg1vr9c/?=
 =?us-ascii?Q?nsGGRaFBc7SPlIRIEaCTuOoyku0dSV2aIy98gZbJq5GYWOmGjCK70hQUrg+Q?=
 =?us-ascii?Q?l9P8qUEEtVLpQp2kV8X0GMXz16hmu3MnlE9gJ6g3haIIYejPuA/FqJXLSQsT?=
 =?us-ascii?Q?n4ekDJRRXARegYKqHZ3e1WxR4sxwHxDZ5HoID0wk5/ay5euD0cmIce0mwl6+?=
 =?us-ascii?Q?KWdksdgskqCUbaNo+euxkdLi0APb9o0pqrAlrZrgUnwAbaWvBrlpxtIFUcXF?=
 =?us-ascii?Q?CrqUAycHimn6rRfaj8YvvbJQQ4Uszqv+CPcsIokqIyuxS6Kd/OCuVIECdZRC?=
 =?us-ascii?Q?MXG5jwHEUW/ll9gfekR/6TalBN5h2FKPkPyDhDQJmKoYYIvJnrwvaxZ1a/tT?=
 =?us-ascii?Q?koZZTJnXZulald6kukgrgInZWnCuUsUfBlkRk4EeTp1WBLOv9KKJgAlzaZQe?=
 =?us-ascii?Q?TwL7EojNA/Ssj3EOiiz3wNxY7+iW+g0jfvAvPv/Ooq38uWIVyoqw5F29Bj89?=
 =?us-ascii?Q?AgVJ+SWNSXrEjl8y1wEvR+N7Mws8dKNFdqHiYiED+uj5svL4TJf2cIc3NA3y?=
 =?us-ascii?Q?UD4nL1fMidIoW1no7gJRV5nnDX6yEpPkXTJzaWY/cVVDwdGaezwUCgXWO72d?=
 =?us-ascii?Q?11ywePviV2t3vokHt/Rbj4tMRJo58O6c65AQU6oDmCzgK4J5J3Xf7OqvbG/a?=
 =?us-ascii?Q?IIS6iB+TiEMeke/WN/Se2tHP2VvUaQFZTcfiiVLfAKrFyfk6o76d5Zlc9t1i?=
 =?us-ascii?Q?SsevIXki3lyvrkxUHf7lUSfg3ckXU5LbNba0upSRH4SavCGCfS37jiIpyBkK?=
 =?us-ascii?Q?eoCCGzYlq8oBHZBRN0tHgvfWtN0JGa9GPebmhb7Gt3w089BKTtSaB2nGpcAw?=
 =?us-ascii?Q?q6nPehFPDHklDRlAsjnhO9lJZz1Z2JkU3Er2SabwOv3bBP2Nw8pcVFIX2uM1?=
 =?us-ascii?Q?9b8+9WY3ecu3dF/K+t1BklsTJxUuvtzoHRtjXCN3FzWX/S0WnOx+orP+hXvx?=
 =?us-ascii?Q?+J3HiRivgiQS2wJDBq9Vz+GHBPZw+wuLGMnBHkxiNGGsgRnbDCWX7Rte7d9m?=
 =?us-ascii?Q?JVkm7/krRPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6b+jBBLtLhrdhHqUk4lWELF+SEHrpIVRtlOeiGZAVX9lqJPiS6AgocXOQrbg?=
 =?us-ascii?Q?WodwyDWr2yLRdt2uKjlwtJUDpXdNBgglAmbGypTApNQKDvv60UowFFl7u9YA?=
 =?us-ascii?Q?/Z4EihD8K/Ewpy1b7aAe/I4jjvniNnLHAdnTc3PkFExI1Who58zdjDffO0rI?=
 =?us-ascii?Q?GK62hMi32vonIuJo8sbmOKGX7e3g+ub6u/ECE5wBgPaQR8JIdW3elcwOS8fn?=
 =?us-ascii?Q?tnuZ2eMjw+boWe3TG5lxDUAe9G8F03xzOrnQzXtiBw3IDAACXmRzEvvOuSii?=
 =?us-ascii?Q?UocFbxDB0aDdCWSMWEHdBPKS0VbKvBp/FqYfmjx3JDpBzWSR7uDHMKFO81C/?=
 =?us-ascii?Q?Y2TQGWBFOgjY89fPI/egzA3j/3ZkVXjXT2cj0J/dFuttuaEoNdP+ZBWG+6mN?=
 =?us-ascii?Q?uzWvFICHQcS96x+7fDyjvgomjp38pIrxPhtlAPvMpS8unjD29aMn9kO638MY?=
 =?us-ascii?Q?MHQpLl+U0mhqxyS4UMXiIGIL460AOSaHAuUiCLPvCj2Ti6mqjI/wjMbivFCN?=
 =?us-ascii?Q?eNwM3R1JAgTP9+v6dchO7OeujimONB+KZ2pP0akj2/3V8l4hYmd+dRI2+2zm?=
 =?us-ascii?Q?bni8P/sJPAx6hS9CmvBTxWJsbDqPyDjDspOBH1JTN8ttQU4W/QrymeFFkkQU?=
 =?us-ascii?Q?SJK/b5oRrNdNcAbEoR5LwY7XqX8nLEfYeVxvW4e5FtcCccv5AOoxL/ixUy/c?=
 =?us-ascii?Q?xpxqxT59blTZQLQOu/4nzAfxKtERFZVKDyaoWWVgqvqrCCh/D8yZ8+oDKo30?=
 =?us-ascii?Q?boGRvYq8CAio2qmpIuFBD5fhx8VC/9WJeqK7rXzvsF83PrxrTMtThmGsYP0O?=
 =?us-ascii?Q?SrEbs1mRfPxApd/VOR+YJ+3ESRGBndBwS+beX8OXIzMa9beewZcbgJVaxsPE?=
 =?us-ascii?Q?JYeBgOwKg3nvUIsrOaMo52pzGIjhjoHQyWGsY2a1CDcRVtjUFXTA+gjn3ZWv?=
 =?us-ascii?Q?by38j6FdaUEciuqqfN1VlA8PD3mwVxhNLltngjMNHy71LoKs6q/rNlqTYjcj?=
 =?us-ascii?Q?SdasZZLtdfUXX4mYygpHvzc8lQLEikaZJJy2+PklDCrzas8CjFAPMvy9o79D?=
 =?us-ascii?Q?6aMZ7hPo8d+ub7+6eVOT83jwhit4wvJuWr4+mZLg0uhOafcBJotPeoH2BRZE?=
 =?us-ascii?Q?9aYSHolyphi3fHprpoeCPz8oDtHWJKysxcdXO2cQabJHQrLGusXqwrtVpJR+?=
 =?us-ascii?Q?/yr3j3wKiBSebrH8PEgxU1/bvIwziTSAKKQWhftINrt/aesE/pkjLVkDAjvn?=
 =?us-ascii?Q?26u7EPoSICEAo6HRSSjjRbbOcq/N75zofzwtYF/QwjCYvFp3Im8pU9w9IPu7?=
 =?us-ascii?Q?7mi3wp/1+bTc38WJH6TkkCcONifhgsJ2hWYwFLPKMy9QpvCrEt0//paYgB5J?=
 =?us-ascii?Q?Otmm1SjyyuzY9Rw4XmlUvryB9uxUOTe1MBqMHKCwaOkBsaBYetWGBPl3BzMj?=
 =?us-ascii?Q?iRLIahvdMoAIvkzYlGDQU/c7ZAU8HuxosskV3jNPehE0KiWGz+4M3jwAuYRY?=
 =?us-ascii?Q?bQNQJjmK8+ihtyNhCzhGngC0Azf9v4X4BPYRBPiQpWOud5kdVSaX84S5Pkjt?=
 =?us-ascii?Q?L6bIjIKuIcRJer9GEzEUk27HCnHxZAU2zLsH4U8j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47697c36-0f51-4ed1-770e-08ddb9c06b4c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:30:24.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG3pYPqcfqxKlfIJNi2dT5yEbrxi/Syzci1shw/ggor2GEcp4qOJiyEXUrbsLaF2brELaYaMNJhUeYuk0todBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

Add a new kselftest to verify that the total_bw value in
/sys/kernel/debug/sched/debug remains consistent across all CPUs
under different sched_ext BPF program states:

1. Before a BPF scheduler is loaded
2. While a BPF scheduler is loaded and active
3. After a BPF scheduler is unloaded

The test runs CPU stress threads to ensure DL server bandwidth
values stabilize before checking consistency. This helps catch
potential issues with DL server bandwidth accounting during
sched_ext transitions.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 286 +++++++++++++++++++
 2 files changed, 287 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index f0a8cba3a99f..d48be158b0a1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -184,6 +184,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 000000000000..6b81d6c51054
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 Nvidia Corporation.
+ */
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+#define MAX_CPUS 512
+#define STABILIZATION_TIME_SEC 5
+#define STRESS_DURATION_SEC 5
+
+struct total_bw_ctx {
+	struct minimal *skel;
+	long baseline_bw[MAX_CPUS];
+	int nr_cpus;
+};
+
+static void *cpu_stress_thread(void *arg)
+{
+	volatile int i;
+	time_t end_time = time(NULL) + STRESS_DURATION_SEC;
+
+	while (time(NULL) < end_time) {
+		for (i = 0; i < 1000000; i++);
+	}
+
+	return NULL;
+}
+
+/*
+ * The first enqueue on a CPU causes the DL server to start, for that
+ * reason run stressor threads in the hopes it schedules on all CPUs.
+ */
+static int run_cpu_stress(int nr_cpus)
+{
+	pthread_t *threads;
+	int i, ret = 0;
+
+	threads = calloc(nr_cpus, sizeof(pthread_t));
+	if (!threads)
+		return -ENOMEM;
+
+	/* Create threads to run on each CPU */
+	for (i = 0; i < nr_cpus; i++) {
+		if (pthread_create(&threads[i], NULL, cpu_stress_thread, NULL)) {
+			ret = -errno;
+			fprintf(stderr, "Failed to create thread %d: %s\n", i, strerror(-ret));
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+	for (i = 0; i < nr_cpus; i++) {
+		if (threads[i])
+			pthread_join(threads[i], NULL);
+	}
+
+	free(threads);
+	return ret;
+}
+
+static int read_total_bw_values(long *bw_values, int max_cpus)
+{
+	FILE *fp;
+	char line[256];
+	int cpu_count = 0;
+
+	fp = fopen("/sys/kernel/debug/sched/debug", "r");
+	if (!fp) {
+		SCX_ERR("Failed to open debug file");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *bw_str = strstr(line, "total_bw");
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus) {
+					bw_values[cpu_count] = atol(bw_str + 1);
+				}
+				cpu_count++;
+			}
+		}
+	}
+
+	fclose(fp);
+	return cpu_count;
+}
+
+static bool verify_total_bw_consistency(long *bw_values, int count)
+{
+	int i;
+	long first_value;
+
+	if (count <= 0)
+		return false;
+
+	first_value = bw_values[0];
+
+	for (i = 1; i < count; i++) {
+		if (bw_values[i] != first_value) {
+			SCX_ERR("Inconsistent total_bw: CPU0=%ld, CPU%d=%ld",
+				first_value, i, bw_values[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int fetch_verify_total_bw(long *bw_values, int nr_cpus)
+{
+	int attempts = 0;
+	int max_attempts = 10;
+	int count;
+
+	/*
+	 * The first enqueue on a CPU causes the DL server to start, for that
+	 * reason run stressor threads in the hopes it schedules on all CPUs.
+	 */
+	if (run_cpu_stress(nr_cpus) < 0) {
+		SCX_ERR("Failed to run CPU stress");
+		return -1;
+	}
+
+	/* Let things settle down */
+	sleep(STABILIZATION_TIME_SEC);
+
+	/* Try multiple times to get stable values */
+	while (attempts < max_attempts) {
+		count = read_total_bw_values(bw_values, nr_cpus);
+		fprintf(stderr, "Read %d total_bw values (testing %d CPUs)\n", count, nr_cpus);
+		/* If system has more CPUs than we're testing, that's OK */
+		if (count < nr_cpus) {
+			SCX_ERR("Expected at least %d CPUs, got %d", nr_cpus, count);
+			attempts++;
+			sleep(1);
+			continue;
+		}
+
+		/* Only verify the CPUs we're testing */
+		if (verify_total_bw_consistency(bw_values, nr_cpus)) {
+			fprintf(stderr, "Values are consistent: %ld\n", bw_values[0]);
+			return 0;
+		}
+
+		attempts++;
+		sleep(1);
+	}
+
+	return -1;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct total_bw_ctx *test_ctx;
+
+	if (access("/sys/kernel/debug/sched/debug", R_OK) != 0) {
+		fprintf(stderr, "Skipping test: debugfs sched/debug not accessible\n");
+		return SCX_TEST_SKIP;
+	}
+
+	test_ctx = calloc(1, sizeof(*test_ctx));
+	if (!test_ctx)
+		return SCX_TEST_FAIL;
+
+	test_ctx->nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (test_ctx->nr_cpus <= 0) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* If system has more CPUs than MAX_CPUS, just test the first MAX_CPUS */
+	if (test_ctx->nr_cpus > MAX_CPUS) {
+		test_ctx->nr_cpus = MAX_CPUS;
+	}
+
+	/* Test scenario 1: BPF program not loaded */
+	/* Read and verify baseline total_bw before loading BPF program */
+	fprintf(stderr, "BPF prog initially not loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(test_ctx->baseline_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable baseline values");
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	/* Load the BPF skeleton */
+	test_ctx->skel = minimal__open();
+	if (!test_ctx->skel) {
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	SCX_ENUM_INIT(test_ctx->skel);
+	if (minimal__load(test_ctx->skel)) {
+		minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*ctx = test_ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+	struct bpf_link *link;
+	long loaded_bw[MAX_CPUS];
+	long unloaded_bw[MAX_CPUS];
+	int i;
+
+	/* Test scenario 2: BPF program loaded */
+	link = bpf_map__attach_struct_ops(test_ctx->skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	fprintf(stderr, "BPF program loaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(loaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values with BPF loaded");
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	bpf_link__destroy(link);
+
+	/* Test scenario 3: BPF program unloaded */
+	fprintf(stderr, "BPF program unloaded, reading total_bw values\n");
+	if (fetch_verify_total_bw(unloaded_bw, test_ctx->nr_cpus) < 0) {
+		SCX_ERR("Failed to get stable values after BPF unload");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Verify all three scenarios have the same total_bw values */
+	for (i = 0; i < test_ctx->nr_cpus; i++) {
+		if (test_ctx->baseline_bw[i] != loaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != loaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], loaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+
+		if (test_ctx->baseline_bw[i] != unloaded_bw[i]) {
+			SCX_ERR("CPU%d: baseline_bw=%ld != unloaded_bw=%ld",
+				i, test_ctx->baseline_bw[i], unloaded_bw[i]);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	fprintf(stderr, "All total_bw values are consistent across all scenarios\n");
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct total_bw_ctx *test_ctx = ctx;
+
+	if (test_ctx) {
+		if (test_ctx->skel)
+			minimal__destroy(test_ctx->skel);
+		free(test_ctx);
+	}
+}
+
+struct scx_test total_bw = {
+	.name = "total_bw",
+	.description = "Verify total_bw consistency across BPF program states",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&total_bw)
-- 
2.34.1


