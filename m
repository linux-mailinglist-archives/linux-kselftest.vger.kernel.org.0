Return-Path: <linux-kselftest+bounces-38631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FEB1F5EB
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B46F625473
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5F2D0C7D;
	Sat,  9 Aug 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zh+Nga31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF452D0C68;
	Sat,  9 Aug 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765336; cv=fail; b=hNaWC/YS9V4qBPukeUb/L4rDH00Wlr8XAAUuTLBL+B1SUXx2mNellIcnPbNbj7kVJAhnBJkTghrqDiKQVQA4YFx2uINPzHQaTPNMwzKHQ/1h1VVRgF/q+3sXYh/hpNqf0F2IIx7zP9p3LL1yR67o2vcMCSr/5Hjmbj+L68yHPiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765336; c=relaxed/simple;
	bh=Ebev+Z60KYQfu49sWa+QTYaf7qEFeHBbLA8GNlPJ1g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KLv7dPewVSHwk4cKAUso0Dxt6CvJAIbDedzvRzC4g4o0faKik/nbsT9pyUVJ5nDpbSqdCnqBGA855mFmTRyNJdyRB+TJ4L6tMQPb5Zs5cou1cmIaxkXQ4J3I2Y86ZnrjfymZyvLkX8NC30S/hYDLcz5GtngrKTE++LXdQcE7skQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zh+Nga31; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwf8eJVcNFZ5Or6lrEjPB0/+WEdmmFxSvDadQHT6GaJdVTbOH5usP7pCV8WtDgbBUPhKnTcmeAQrFhqjTczbU0EGkx0I0WyYYmoBnrY6g1KTHmkpYp3l1pyub4tUPyc0wbd6Nq9cUNTeAKwCwphgTzQLmLg8XFKmhykQHaIyuwuRlCq3tmSWU+eXhK29iyY2SL4Ho/cpQ72iM3Ev72tRVer7yrYp8sj1U+N9z4EFW5uly98FUZDctIKyDu00vZkvZgusv7V28eBmSkpMxn7ppkT2fapBq9NCyVX0XD6/I1qWplUoBE7zRw0ryTjCmCdK1/cfbcNS9O1/WOp068d1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5WUGDKZ/pwPNdpsepCF7GR1khVjxjyfRTqSzHam+eA=;
 b=sUlvFoEs6jMMA/OebZuoKEHKrPFLjtOVHrutcSmpKcMxHAAwW3rPf9Q6LjeMdRU6wP18NWqr5abPSuSv/8r3bOczPZCB/JKKofhRz2xNyq19yMBrwaMJCnE7PZnJSGtMih/4T2m82WY2yGigKRaj+NVw0YJ0lpO8X4gopfKKdktJU5j+5u1/0Lszjiqkn4MDz7u5T3QDsMtxOiDpQVFSfxV3qZVtXuo5D4pb3I0lQzziBWKH2sgWJWV3W4g10CQ0X9RSV0Wtrew8pNs2bVBvNGxQBFO1eQ6Zv6nF8FOlEEs+7SWWesTBv7pueYuP21YUQAmMerDHoGvL9l5KNz5Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5WUGDKZ/pwPNdpsepCF7GR1khVjxjyfRTqSzHam+eA=;
 b=Zh+Nga31Gt2lDgRx/vjeFKL5GM8R3kXnme3K9kSEg7YGGFjcasIf3mbatte1BNzlHtKpU8xpTmrqdclZTY3MsnVzu0RXe3g9ZSGjr3QDjeRfkSxkjGqSIRzdhG4mEsCeBy9rCsEL45W+cLQOiDesJ+9yQ2vnDci2lf8bLl8R2j64b8FssvNKEBm/PHSKyD9sm/xQIc7UWkthBS0e8dALd21BykyY1H09+52yLLBrmU/zN01guQD0WZExEoPhag1sx06rL0M0FuIC6/TMNfR3vhLu92FB7R2Opgf56XPjf/p0bBUCTOl8CMpOrwoLPhQyOftmgCT1DGsN64IEVJSk2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:51 +0000
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
Subject: [PATCH -rebased 14/15] selftests/sched_ext: Add test for sched_ext dl_server
Date: Sat,  9 Aug 2025 14:47:59 -0400
Message-Id: <20250809184800.129831-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0233.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 508eec35-919a-4b2a-0ce1-08ddd7756240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKdqxuRvnWg6C9e4J1LiQcpmchorlbqHTsB35iT5mWbSNRqncfTdLU2RlE2W?=
 =?us-ascii?Q?rl3eTJSrcf+wnMvfmSHNlQdAmhAQ5odCztywyafyi7itlEoAcEs/4TnGW3tF?=
 =?us-ascii?Q?a8Kj2igq1H/rBI87K2Ps6ot/OXqc6grHVJMVQPcD0xLUZod8gbMtoEp7vjA0?=
 =?us-ascii?Q?DMtp41ZfTDLmQfR16b8Yhb2jyBK/D+whwnuCJJXTGYx/fbAIQ48YKAiPijTB?=
 =?us-ascii?Q?jRdGlicgsM4eSj33cMNaD2OrSs3x/N0xWcP8ujnyAIuoRsIYFjCNCMczQTje?=
 =?us-ascii?Q?KtffQBeYze0o3VvT8kWzfEwHV3XgSFJ/PlsUagsoCl+ea/KD3tvxCN4/HDKD?=
 =?us-ascii?Q?372wLPwirkvaBuqCYzR3YwtjUijlvsuiY9QBNOst3oiVFbjiOu+gTSPorXse?=
 =?us-ascii?Q?GOBi5qmVLxll0oE8/V1A9CJbC4m7rFFETMUgWwsmQOuS5bG/k8kwDNcSZxhb?=
 =?us-ascii?Q?jQOXV9jdpokWpapfcU5k9it3RhHCZfJTlMtBT8iAcLHGMukJsLvL8/u1emTe?=
 =?us-ascii?Q?dfzUXZmdIuu7OCsfSx6/VBILFLDyRtcy1PiC4GtMtjKt9+Qzw2eyB0WV6k/e?=
 =?us-ascii?Q?MykX2ZuAWlm9ZbP+f3pFxbZreeSq62dGpvJ+jS0N95/uW1876njdSZ2RGlkB?=
 =?us-ascii?Q?+x7T31W38vYtiMyRP1g46O2VEorYyXBbJF/nUD3yA+d9MySWN3OhjIr9lTVB?=
 =?us-ascii?Q?+elSzgK+ZoUB72uvEH7qzS7gLQa3tfFjghkw0AawKY4S1g0nxpz7uJwG6e2L?=
 =?us-ascii?Q?GBVSUUHA5j+ICHdWi2mFfuumFNb3pGxehFcD2poh1KtUnkxNVzjtC/sTh6ZC?=
 =?us-ascii?Q?56eK0hh9C1NNMEMGF3df/Ffa6D4DpmMfu6hvynwu7CKvFwgQyFMJpHK/T9Xe?=
 =?us-ascii?Q?j5m3UUgguQe5Zv0I9VaFP5Vqe9mPR4Cv2sTmF12iD7kgS6JBLAopJyDdPLJM?=
 =?us-ascii?Q?UnFdyc3sfEXbn0z61LMBRG2P9XF/FeqJAr50VLRctaZ8p0X9s4i8IUf+LGRr?=
 =?us-ascii?Q?9G2VOHfH00n3KjLWjwhKg24CVSNrtSoDJpzVBQ4J8FavcZs378wGpsTbETq7?=
 =?us-ascii?Q?5CKbQNsnp+B5/qiMutq+q57cDV6Vjb49+CVRqPT9LgNA773YcALITnwXrLec?=
 =?us-ascii?Q?UD02smRRW+w6vajeQppLyLIG59Ln3ezX+sMaty6KR0rOjWDNfB+jIdYkvTmZ?=
 =?us-ascii?Q?iY77yLiawHgcVzgaVzw6fE5Tb6njDTWy72eKtCiQ7kvOjuSJM5wexvAVz5EA?=
 =?us-ascii?Q?eHOE6SntF9DUx7us42jq0vAyFFbmNWyQlI0RvCnUGdAg8E2CUB7i/Zf4Xxpm?=
 =?us-ascii?Q?88sJuv8hjpTR4C3xXWoOphUYOdwElLwJC4OmtrNsbciVEmc/G6RFSbFDHEZS?=
 =?us-ascii?Q?eu0RCYx/OGzIvO9yremltFNJQS6slgWtYNj1BrxKoD+1jKhkcCDnVLfZC+P7?=
 =?us-ascii?Q?klx9ECQZ4Zw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGJjaUUUkjzJ92f4NpCPGI4VU45AY9AfLPObdevypWqKhEYgXdYMCElpJIyi?=
 =?us-ascii?Q?jmcvjI38nc1JVh8RT/9a3L9yWwnZ0Gk6hi5orD3UE08baemIIvNct5du3dkZ?=
 =?us-ascii?Q?OpIXtsYILX0AYB8x8K9lmlU9TaQnA5WRhoTMZB4jtIzvp9ozxoFyBmpIWOiS?=
 =?us-ascii?Q?l4NxtVPdJK70M6sCJToOhL5PaBlS4Bj7768L1SFDC4rTXAexIxvTdM8S4OjV?=
 =?us-ascii?Q?+VtJRpTu16KfuBCge/r5EqPTcIGn6fOKHkBNMKF4fQAPcUdfoo4KwlUmLdp3?=
 =?us-ascii?Q?tGq59RqN+5Kwn1+DJTPbgp3/A2eUnRdG+Bp+uEQCMzjCvWw1LXtx2XZAc5Vj?=
 =?us-ascii?Q?JEeZ/EzjEbhdJdPsypDSpblFxDSnjoPUhFaHgExO/dAIvVq3kbt+00ts9jC4?=
 =?us-ascii?Q?/erk4BqVSYLFvM1GNg3unzPzrNCva9OQmBuNmjxFTXZDLAOyqU9jv14vwAEv?=
 =?us-ascii?Q?IvdpIAq4TQgbNI3EB8orinHSedgYut6LdDXE84fqiLhkiyJl2sWjQxzsx178?=
 =?us-ascii?Q?TipBhdvPh/gHh5+o8B5DfvIZXt4bNkk3uoreO6ALRxY9Dh9pKvZWF0Issnlr?=
 =?us-ascii?Q?CNjinfeSBVLCHKbA20xiB0ygK7zfcdD6DxlUPLJPkEjnB8TOGfQZ5ytorBgl?=
 =?us-ascii?Q?kFBn6bYvHxRzID39jnIoYPGfSUdwQKVNtC75HsuVkbjZ9gfCA5NmSWCRdFC+?=
 =?us-ascii?Q?JHhyrHu/zLWMtxsruK0vkYuuRFGJt8LwFKSDFafHqcTEDKyR4/NuxaWivSs6?=
 =?us-ascii?Q?6cmqXVsYBFUxF84mmwbIAJ9E/wpNwkmUKr1h5/kAEpQFgaO5vGhF1jiAOFnD?=
 =?us-ascii?Q?G5YIdelhxZvG7KyygiYZBvoyTslZs/mU0CzHajMisyi1N2GibCcuJrhCpSqt?=
 =?us-ascii?Q?KEM4pDFH4wp63WDT/OicPGMYcCxbk/64YyBNYfzemawNaqKmLHZPa1mUm8WM?=
 =?us-ascii?Q?DYpciv8mvHEfqDuxrPWe3vFNzR3gHhLlduVt59iW3cxWqQwwnGjp8y1pUz1U?=
 =?us-ascii?Q?1dptdhJg9xnpwz1rDyLO9FTMVpf0ZdG2ib/eJczM9f+I9MAdPKjhE/A6RNSj?=
 =?us-ascii?Q?ZtFkeof2kJANwQXvVqWNXyFoNR7jrpRetKLh0VrdgFEXuySDAGJFaaPSHs2B?=
 =?us-ascii?Q?KHtRNB2VootE7s2HRtc0v6RAqJXa1pZYeSDahOuU2Fl5iemIMqG0u8Vq4cDg?=
 =?us-ascii?Q?0B8T4IonK5nVFxgTtGIVTwmz637RPQ1yRRizrpWm0Q4sVnLC1IMW3rcYmyTH?=
 =?us-ascii?Q?pgi6VgVB00NhT/YGIVd25yxzZT/U27aX4rV4ihvBiDsL3CVRWquYc0+cRTr5?=
 =?us-ascii?Q?U5i1mBcKAOz6is0wDraNyL3MYJ3s+ya9TbwGyhRi764eYROC+9M/60A7IGrr?=
 =?us-ascii?Q?BTknIxZUCXIUpgGL8iJfJrfZW1/SktqAXGBLWI87K2h5UTWs1ACtGWqsErvr?=
 =?us-ascii?Q?lPCEu8ihZdasJdcja1AbEgex1oO7C9a3BSod0iaMqyXdxrNkWB/Rr2RYKror?=
 =?us-ascii?Q?O5mjK4TmDgVC+SFqvlw2omrAZl72dc15vFtcPtxY1Fky09sHk4uCWv/Frtjk?=
 =?us-ascii?Q?PKsVs+IoyosFZhsQx5haK6c98DJmUhx7D9sLqZYS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508eec35-919a-4b2a-0ce1-08ddd7756240
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:51.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKjC8oco1fGvPdvIFShZPWU08PKYHQExPuRVNj+YcyTBU373AYTch4TwY6LUVUrA9WLuUyh4n689uUWAMhQkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

From: Andrea Righi <arighi@nvidia.com>

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

[ Joel: Replaced occurences of CFS in the test with EXT. ]

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9d9d6b4c38b0..f0a8cba3a99f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -182,6 +182,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 000000000000..80086779dd1e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 000000000000..d4cb545ebfd8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++);
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	float cfs_runtime, rt_runtime;
+	int cfs_pid, rt_pid;
+	float expected_min_ratio = 0.04; /* 4% */
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	cfs_pid = fork();
+	if (cfs_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (cfs_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	cfs_runtime = get_process_runtime(cfs_pid);
+	if (cfs_runtime != -1)
+		ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n", cfs_pid, cfs_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", cfs_pid);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime != -1)
+		ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+	else
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+
+	/* Kill the processes */
+	kill(cfs_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(cfs_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	float actual_ratio = cfs_runtime / (cfs_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	} else {
+		ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return false;
+	}
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.34.1


