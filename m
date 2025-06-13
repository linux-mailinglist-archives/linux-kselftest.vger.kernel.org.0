Return-Path: <linux-kselftest+bounces-34866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6BAD8267
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C1B1899132
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896625C6EE;
	Fri, 13 Jun 2025 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NznxSKKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93D25BEE3;
	Fri, 13 Jun 2025 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749791904; cv=fail; b=TzaDbbNroT1TBy5vCriEW87V4JXgu7TjHfgSdlQc2wWJf/unjPRcSgQz+siSD/IzSfHCmpYLBDjgODHmBt4/mRWzCVrYGtDR3i6+8bdZznC1Z0N9swxn4EwpYtpcOqmzbXVJF5jdplTlA/xNPkeUzBLYGanVT+eykk736ajTe7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749791904; c=relaxed/simple;
	bh=exkumhOdiw8oCUesu0VJD1IP/BQ70lXXxX8BzKUffWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkCfJxElc91BteZVnkZHjPQMhrJs2hwZq6mfhUU7Yz/aXyCCwE13aXx7jD43YUtZslCFWqR0LECMuFj2wIv40IiY3PobEpuJnEdcjFjlvYotVMNIpnanbDEwtLRcoPl/VMkBQ4xWbEvAY8kBcmTYiXBpnu6uTgja7A34ESLvGyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NznxSKKQ; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asAQinyi4PufG/Wkx8ecOCKueVIrNY7gN9v1oolbE96XYAqJlJTrjyzC8DPYQh6LSJwa5XWEb4cL4dFKCemakbsncU4mQxDQvRNGyMEMfW9Zdv5r5JWR+LaonzxSGOGM4Q+jZZM1TfmaadNeCy1k40HLN1vlaJ6wUefoGZLq2A9NoATuOBuos9/VKLE+6aa+9DuTStkuUrZEdmHRmLqc69Q5kq/16J3Fo8jfHvvwO09xHtmTnpt9ZcuJKJcUyItyYSxt3RNLRyOTFiMGX/puDsLZzcbjP90yJm7o7kxWK3fgldGcjeWqBNQCOqj+xN/8tQCESzZdqLomoujED1IHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQDALDMbn5MR/+nWBcS7NuCJZiB121+OKagfgAC3C4=;
 b=EMsOi4nhTebCkLNxjyx0dvJHOhPOSJW26ZalXSutrQickuRid+8ZoGTYn/06R3pPFemiSjH+OspK0X1AtRSktgzsXKOhv/mA2c1YcwoCs97szio6cZbb3tZodlXkEXw1PnlNhiAVHwBH1THzYWpQo4bgqM6kRvErsSFi4zwyDIPv4ctif55KBT9GzqlvMcNhhvmYfEOBGq/CSwZv681qCFTfb6Gp89Hgciq2KGZhnZXzyymQktD2YOg2T3PDIuiQNnKqsnnIpCqCjZA/Y4gdGiFSCTw8z9aYlZwwyJqMVIiNqADlgBld8Grx34pwfJ48DJFDJy3kVvTScE5if7cukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQDALDMbn5MR/+nWBcS7NuCJZiB121+OKagfgAC3C4=;
 b=NznxSKKQdTRF0o08RVQW9sZsr/2bWF7w6Z/wWyOdWY6UX0YUGOFmeTD7BTQdxv0JCWS9nDFBafrHnlN/zv4+ZtNPuA3Wd9URRgt8jlyYjlpvP3FKF49UWjNTl3GFZuVey5N8AB/7AmmdpmI62VcAh/J2lJYSqvpTYN5fOpzKOPU0iPnEb6wY7zgwxB449qeIW4ajttfv7qzY+Bjq14nLYUt2l7wxQ81aKrLkXoWVHLApGLJK0Moc7HAx6XgEEQdEruKUE5spKqdIhcRFO8OR7awMkaTcf5DUuopIh4Bl3GNmvzG0wOGquC72VNTquNcPo+wZGuO/Xa04CHrJWyT1ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 05:18:17 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 05:18:17 +0000
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
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 10/10] selftests/sched_ext: Add test for sched_ext dl_server
Date: Fri, 13 Jun 2025 01:17:30 -0400
Message-ID: <20250613051734.4023260-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613051734.4023260-1-joelagnelf@nvidia.com>
References: <20250613051734.4023260-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b29f82d-4c67-4b4b-302d-08ddaa39b3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/fQHJJFakCVwKTDXyEQJ++01eOvJNWWKv3Sv99498Au2OVJqRmKKwtbZnx7U?=
 =?us-ascii?Q?ufLrlWK8s+Wljfv/hzcmdj814QtHlt+hAVW1h2hyP9YTQGYRTERh7LEAfano?=
 =?us-ascii?Q?974Ux74bhDCQ4RjlXoSs2Wk4jpWj+NAClFGlAJmgMSrZ7qxVlzyXpTxnbOJv?=
 =?us-ascii?Q?lRNwlnWxmRdYoR4g45f/2kVdh3+GyRDz2xaiNxDbH5b1ZG+VMHsC8pVf4R2z?=
 =?us-ascii?Q?Rc0r7O/+FhcqRDwqBNvGm22hAwVVD9WF5/CLJmKDoJum/OY+UtZdtwFqXJCk?=
 =?us-ascii?Q?VsdFaHukDaURgR7+1oyYogFSUnffJjFUM/732NRv+27bH4+W9w9GhjCj96sn?=
 =?us-ascii?Q?WruqreCix5qSouRz+4C9Dsg94vpl0zaIjuMOqMasr3EUnxozUwsIREoSUFVh?=
 =?us-ascii?Q?g/SGy+I+V0hR47w51vqcoknNBm3FDsH1kLwc8HkxkKeS4dyDDYfk8+rbNL20?=
 =?us-ascii?Q?mSEXrM3EU6o20/1N+SpTaz8y4xPByzEr3r4jIFc7uF7aHjXchYoNgQTKRVL5?=
 =?us-ascii?Q?7oEBaLcmsaFPGgWZdlbc6coN2sr4FzSFHjLrlVJlkdU97CslEMwewwM02Gs0?=
 =?us-ascii?Q?HXPjacDhqrePk+WTRiBZAU7l8PF2mgkeh9GTi/XLpCi1JtuUZrcnXo94Q5Wp?=
 =?us-ascii?Q?A5FbTon5dhi96rqETmrgaePXoj1LuDJ6EBOoCtkeTJB4Rz9Gqe4s9rNW8XNI?=
 =?us-ascii?Q?LQnQcvlILo8tUUJKHpAMTqPGa8yw+IKNHPXXV4ZqyQOxd0EpDTFU9alY08da?=
 =?us-ascii?Q?+nssLiosvfQxpK3nTVKHMjB9liPFgGHZh9hTPLfrh8zfWlWZGPLxo5/9o5Lb?=
 =?us-ascii?Q?2zwCF8l/AQ5dywpoW+sjF/Z6hnZekEggHXoQx3xOsv7t22IsFKQy2HV+hf6b?=
 =?us-ascii?Q?beJ+RFdfbHmU/Pd99YFSFy0aKrNjcVOz55cBENZ8wnEW4P4cyOQ3Y1p5+Otd?=
 =?us-ascii?Q?EFEMSMsTANtJ4sbGsr54mXq3L5FHrBwHoz1em8TnlcRpO5XxIc7x7qdiA1i6?=
 =?us-ascii?Q?9Aj2wpg9lvuCe0Im7ofQHvw1Gp+3q1EVypK1GrcY/cVvL8nUpZojhEu3Ip6d?=
 =?us-ascii?Q?DAE800iyljzXCo0DQX3SUgoWiCYT7kmixLRnFYUAWwWWpYFSLwI1Gnj9JmHX?=
 =?us-ascii?Q?w3F9WvnSZguk3SIPyHV/qxDBySbBuQDAE0R86fJqSsO0Eb7AIdK8iaHIcH0z?=
 =?us-ascii?Q?i6lRxngwxUWWZ0Brydm0zVl5O9DF2n0ds9166Za03BdNqY9wxh7oAu6A1P+q?=
 =?us-ascii?Q?a5Wn1Lnf/cisRUEaWckLf15UVPcmrKgEc4E69NyREQNGJy+3+7I/1lDNn0Pj?=
 =?us-ascii?Q?F8XqajYEo5f1+dSo86XMWYM90+o1cllyuFtPX4VnFhk4O+K7NoDN3CB2iCQt?=
 =?us-ascii?Q?IGwPSZL7n10JmJ8zDkYCvZbb2Xs+gs7n7FZOwYwrQN7vUekzriCnut1EAudY?=
 =?us-ascii?Q?XagNyz4lk6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZuYrps4PW/WJmd1pS8uv+Ud8nvp81zBl+jfMI/ccY5S+Y4J6ErET6iH7tZ5?=
 =?us-ascii?Q?rEipKo73eDhUZio2JPPh9a7vd/yakvrBfUm28pEzr5ttlqPL24hRYgGpSuHT?=
 =?us-ascii?Q?RqvWbmbYTDOvKYZBEl2le9lJVIEusPDf2zl1KuvVNWR449vP4z6Jst6YGrQ2?=
 =?us-ascii?Q?n2Ra9QAhOrhnCb7A1f4YSybXf1tua4DgtsRvdGS5wEvVoxL6sDIIIxQ11Iil?=
 =?us-ascii?Q?s1V35ElUkkWIp5Ee+Cqmp8BsGbo3ENftKcubZhY526yPto7SRnSlEPqOvtvl?=
 =?us-ascii?Q?6Pau8hM+7Dtd23qhqWhtWPA1Y9feqrmG86XxIA0OS9mSsstj3NKYlbvVVu8u?=
 =?us-ascii?Q?K3aKkfX9NWcs99qWuF20oog2VyW8ZabWtHt4UtdjhwNkVqjSdrRJrl7GGCeg?=
 =?us-ascii?Q?R+1n3HTGAzgvcZWeSSub8ULZwessn7XUDuKG+C5+sI08jvPqS3K1FuEcI+op?=
 =?us-ascii?Q?NV+P2na46jxPurwcW6YYUg4rVGuN91ESHDjDWase7fJgZ1YkZSsvUarEZH2B?=
 =?us-ascii?Q?rh64yVJAd2qM6wnREsH1Skcfm++nqm2xo8qoUUl3exB+rZ0WbhvzHvnLNUzT?=
 =?us-ascii?Q?sXC+B31cY0+RAB9mQe7bOdlmmKcJn6no59Q15/rNRNHEHI5NsqcDy4Hs3Yjp?=
 =?us-ascii?Q?cL/T0c0LAnrZHwtZhxxBDH2ByoGDVxBz8mJjfIUOgmMbv4BSfOVs7DrS1P+0?=
 =?us-ascii?Q?bNQbRl7yXW7OUEQ1ZPMPtlfR95M9P7Brt+mmfvEFpPpBlQPY+D/Vrv2DQ3RC?=
 =?us-ascii?Q?pEHjKV3VEIfY8fOLhIcYqDjIx6vYpAbSyvZMpghQDJtX3h46w87uyznpjF6o?=
 =?us-ascii?Q?Q/2ZKhz6leSXEcyi+/c/cw9Z0TYLxSUCgNibEx3lrzjKKqrry4ySNJZZpF3E?=
 =?us-ascii?Q?xTlcUUaEFbFnO8g/Q2W30s/T8/z94mR26WNC6JxOGXGWc88NS2UaCbdKY/Mq?=
 =?us-ascii?Q?pSFYymDoS3iAV6Dj1qoCtDBcEB84dkTHf+2yBugmsHED1Tvj03dC60HC9TYq?=
 =?us-ascii?Q?jUmmXEgG2fUGKtl3Vj7yyVpZ4C15T6G5uIcxrJMJqwWYe7ysxqDQOtQfFQkT?=
 =?us-ascii?Q?ga1N2l5MjTk0Z/7RNCsxuWTDX1gXr6SKQsmJwr45h388VXPlrZcbsLbSQC/1?=
 =?us-ascii?Q?XQKBcobRAR9lL+j4PVAcf/uMN73wQbQO8qfwAPy//IhExsL1nH9i1UWABm5s?=
 =?us-ascii?Q?I9/2CLDGkAu393DXroRFZYfUgp2StETbnIZqXk8weKKzSsro7I1xxkwOUXu+?=
 =?us-ascii?Q?CI0BILviZNXE5Ob8L4TBXcW2E0N6pbegkh1G6Pf4/k1FHrg2CW9I1Vr4asbw?=
 =?us-ascii?Q?KQ45M5drOS/ZMPxyLw0Ih2uF893DRlOiU2AxY9//1gJL3FfLnoK4t7rvCmhW?=
 =?us-ascii?Q?rkizNZ9IJosAVMz808zzW2g9V/L85qRE/mCyeEcu3uTlj1Dn4jyphbxkwXNC?=
 =?us-ascii?Q?Fl4mO6St/sMFPJHu02FCPCWYAqMNkho9IEft6Sv4LnWMt3OnUdqakXacXsQC?=
 =?us-ascii?Q?TL8edyQlRpGE1Bvq4zfUibqJFxld/lnhQOExTK8tp926diJQwk17UEsDsXqz?=
 =?us-ascii?Q?TvGFRjGu40IWqMUW0jU9A/Ky5q9Sw6tJIz67aFH3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b29f82d-4c67-4b4b-302d-08ddaa39b3e0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 05:18:16.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRq+UDYv6s4bjHs3bAjGBXVudF9De6X5aX1k43Ad+I1Ua3MhuZxLoHHUYLh3qjoMAEqzFAYOuUFjrOTsltCp+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

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
index f4531327b8e7..dcc803eeab39 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -181,6 +181,7 @@ auto-test-targets :=			\
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


