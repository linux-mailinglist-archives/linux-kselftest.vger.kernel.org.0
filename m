Return-Path: <linux-kselftest+bounces-35462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9AAE23A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324EA1C2258D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E982EFD9F;
	Fri, 20 Jun 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RXgcWbn8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A22EFD82;
	Fri, 20 Jun 2025 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451599; cv=fail; b=XijYdeCSWMTF/1QVrnFN37qr2pGgfdqPkTaGpVkGfjy2VtCs+f+hqgNaRukjv90GDPvMhHhldysCbPfjNSZkGdF38l9hhimGrHqE70AGBfJqGGGeU5tXWkY1uieuf+l092CEsRKd0QqsprMGd/kFeNQpXe51vuNRM2DLSjncrMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451599; c=relaxed/simple;
	bh=zj5Kyj8hoRKXaAFxKw3Go3XlUKs3LRo0gPxsuUq45jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgpU1uXoCUg/E1rZdfa22lwQoBaU6mmQrFA8EOYB7BhjsVSej+qIB3cGGoset65D1k8eAhUSKUaV+0ph9Ku0h8eXwyqh3Y5aOCZLBQ93IGqmNWDTxbvIhAKv+FhF/hTJq+tb+cLYSzUrdBMtUpMp+Gri8elDV+HIsEPhx3SNgvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RXgcWbn8; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1D1b6oZ1Tl/o7/wXSM16Wmd2vSI8OE6lFUJOb7IZecsBbCdv8Q5A+vxrnDksizcT2Qg4Iivj4WjoHwr1nRURQOAzzw+0fAH/X9mcDgbp5vL7jWAN6eBJH2vuW4SFizZyRh+pW69FPViU8vEFFK/j8uXCj69mUt8zcxASaEw3cUikERoYCgi58KR6sZo9QV+HYEE4OWuRXsQi0Q+KZevB4LHWnsN2sJi3tvMrlJpCQHBzkKXUgKLY6v3sWuyHQzbh7oaMQm5DHfq9D0VYCbt6BtjEz+t7O6Bv/WQVoNp0aPkfl+6K1tt95VvBeg9CRsyU4e5/1tpdcqq325uJiIXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L9GIwdch7G4iBT/656UDFomP990dddGVMaPvKzxQTw=;
 b=Q4pe+5cactUEw4HaXEeQKVmtPO/P6MawMFlUwIvVMMfMPOLCxbokA1dMoEBQK5r8afDjfFd50r4sUXm4btxTqos+0+g0PX62RAbO2XUJMNS9pbI7f+jIETOO/OkxM2uqvPvFFVewgKx684HploNK0BsUm7q+032gDlitOmrall/Oe4HEcUz5sqEa5RGH8+Nk+4kYyMKS51hxI1rb5f76r+oisj7vzTAphUMYE1ZKl30VEzWezhB65JQZUtAH/o35AP8K6vbIwj2zSgXx9ZY7jq4s83zeKCuHLqfHDHKiMMlcseYzWL8dwahRt/18tBiazbtv3A2Mof6aE2gTT2N21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L9GIwdch7G4iBT/656UDFomP990dddGVMaPvKzxQTw=;
 b=RXgcWbn8UGVpU/XxpWHa3wqq8CGrIKcJEKwtuXvKDyLmNqRMXSaFp4X16temL74OD2DgN0KncX7O2JbHBp1XZkzzXnUOGP9T7Hv50FDyMb0zd9SCsOF/+WVJiqs7Oipeb/EbUOpQLhYc49RoJk6l8ud8xA5U38HJR26RhdKadv2wZ6fmAbrnD33C8eCha2isbiY3kMw4J255mxA7qFblJ0oMfcNm9kU0X8M8nqUkgHIdz2Gsp21Hv/XekiHjpXX+/fpXMV0vQnXAXvZf3fiS+YSngSVgflqnZhFGZ+dsAgD+q7B/n1PqGd2Fzf1IGL1Fu/bOaAyVjp8KfxEE3fAsxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 20 Jun
 2025 20:33:09 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 20:33:09 +0000
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
Subject: [PATCH v5 14/14] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Fri, 20 Jun 2025 16:32:29 -0400
Message-ID: <20250620203234.3349930-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN7PR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:408:34::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 342e0568-d2ad-494e-2378-08ddb039ab92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pkmhAwTuJlT334d4KITqNowxKgvc0+/2sgdUFnFeWK+z0BHVUcCdI6Zb+qok?=
 =?us-ascii?Q?t/e8YN8VkzXvZKhuSZYqlKzikjPQjQhK69crRUhi2Nie/a0ehrcL7UD27vs5?=
 =?us-ascii?Q?1vzf1PSm1iAujJL/xXaaP8Ur07U0EXQAPfGrs5G/jt8DRU9m+EUMMd7zk54k?=
 =?us-ascii?Q?yItwY+sd6Jr0cnO6umo7hjfG4cqGZPpK553CSwn1KStr7frPmzOQYuKPEb4X?=
 =?us-ascii?Q?2nTtKUmgYhKVOaiQwf5SKZKAI74rpZJWJCM298533jMorTCT0juXmjuyGIz0?=
 =?us-ascii?Q?wH1ZlzDh0ky5BqiUY5dtevEIXvRKxIAG/kS3MhlyO+NnPp87dRNHxbb6AsbD?=
 =?us-ascii?Q?zbDnKSKMkBxt/r9HNpjSgMdToJ+Fk/ECgLLSMdm6gCq75ORbsiRap6CeHt9W?=
 =?us-ascii?Q?8AHyu1kAiBWh2UKNw60F2DL4AaBNw/jVAvzoLXFJwPhcFfUt6WIYmSN05tHx?=
 =?us-ascii?Q?QkazlXDHrHOMRZnlGhjpB/I/POtP4WunvIe99I1VU6/3W7pBc65lWTuG4ClW?=
 =?us-ascii?Q?onzooeXKK8olJH311vORC7xw9wCwTgew0WyJARo5hOMTJLqpS6b2ZwsT3VKd?=
 =?us-ascii?Q?iMDt0sXTuh8yDZRKMH++MZ7fLsWLHqcXZ+MEW3xRz1MLzjbbwutix5Dx3sQS?=
 =?us-ascii?Q?dEOgEZ9TjJtJtFm6/JY/WskF4ii1SP5hZ3bK6GZWh8vwqvFD+8e1WTdrJY7f?=
 =?us-ascii?Q?XMT+yAFHaDaEtHLx+rvE5akuMfek9VbAKgsnlM3mhhWl91nUbhjnN4/4359n?=
 =?us-ascii?Q?3dcU8BACxBsPj8qknmZcOn6WCQqQheG2zsBtwItTujOUG/bSNHKpuE8E2IUf?=
 =?us-ascii?Q?bDr32bIQaTTY55ejpEL1NNbrPgbbIiKN50bF7K7P9eJVP4RZ6eep4cIdRGC5?=
 =?us-ascii?Q?55vVtQDmiXjBFhPg6PmFphuxCPYI0Y3sw0Dbf2ADXW20ekszSZ6qcMXc7Zon?=
 =?us-ascii?Q?ghqvcVVFJ8/3vuD9oJ8oQYUCmnAMsVbXpQllOHoOVcl2dBqvUv23I38AcDX3?=
 =?us-ascii?Q?zS8oEtDzmn/u1bvMd4myZFjcTXowpNVuyAZch7W7FyEYvpHRgcs3FTw9eG+J?=
 =?us-ascii?Q?/4ODRbul7LJs+3QMfYS6H4r8nbqQLkw/hHO/dnaBxQKvhnyrPob1VQHNoAaZ?=
 =?us-ascii?Q?P09SL03/ijy/Yy2r1/+C73OQ+0/xMoWwVYVu93FNxVtK3SN0WSwUo7JMs0Mh?=
 =?us-ascii?Q?o36I9Mtiv/K+ZS5AXNEiydJ6Tptmw7OoWCn6HRc+ptioNiqDrQrCrm4W9VGY?=
 =?us-ascii?Q?VR/ramNFGGeX0zJ4J0wallMVo2xqLrAn/Kum1UUrZJCLrv2VcmaFlRe0zCA2?=
 =?us-ascii?Q?PwOFzf5eos5a3ToubaeioeQ9mIXHH3C4z12GassIKkSaZFvkkNfU6eJYQVwM?=
 =?us-ascii?Q?Qi//rO1UQbFQgQ50O9F3yXtP7GJqfk27Dnc2thjvZMTRHt1e3RfrcCkaq9Bq?=
 =?us-ascii?Q?KTW7SGG0G4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMHn48k+cmzegkJtDlI1JljfjVEtB7nTQW4FSCZu1s5mWDnYFqnGeBlgvmI7?=
 =?us-ascii?Q?y8WaZQA9VjwQqHnDAEKmzw8eNpirGwrDkhRHx3dt3YLJzZrJi1wm7eiZPGXm?=
 =?us-ascii?Q?obd6SK1kMDmMjCKZGahi9n6YrIbkQRJIh5K8brv91rRgPu/0vTSC8bNA5riM?=
 =?us-ascii?Q?S8w7MEOV81Mokqxjl3+t6zTqQ65ZPcBQJdIKzUVzH3cMwA/kiqFWetchbzFH?=
 =?us-ascii?Q?Xl0IgyxuMRk3VNY55lH2T29qQmaPDUAR6tRGxcVUuufRu1i/ukQixlZIug0q?=
 =?us-ascii?Q?zaliYOn/aQTQv58Ds1wpgmJba+Wz050B9I6PdZIG3plikWPbXR7kxCE+O38y?=
 =?us-ascii?Q?ZOwpLYSUmhx8B3TQtE8wSS3UWO6+VVWhq3vzm643ud/mIVm34nD5Q8xkRh/O?=
 =?us-ascii?Q?vY8vxzSgdPJiqcZM7v0bFoa2ixe5rQ1PmodfQPBdyLTOXBLynVileyoFRBrR?=
 =?us-ascii?Q?mZAI8bxpZ6uX3Dwv44D58BaauWdQgCZEij30ntVK7S1CdeDt5YGqNma05nZP?=
 =?us-ascii?Q?w/cowxJa9nNpvLipePe4Ld2eGS5Fwzsr1zeIKQvc0oVuDNUUVB1I3yJOXrYs?=
 =?us-ascii?Q?6NaWy1nTemZUw9d3IVm7SkcPWn9q2rXe1X3F0mx4DY20VYm7u5nAt3SRacMt?=
 =?us-ascii?Q?xP/y5RbI5RwtZqlozyKVuszCxZPkLfOziF741Cx3+7KyhgBF0j+JbCk4XhX2?=
 =?us-ascii?Q?1/lzVDZlxsQliZvYxddD2VZszWdRsbQC/z/U2aE93xxZbxqNEPIeYLQs0/NJ?=
 =?us-ascii?Q?75p5j541xzqcaBqqABBMsePogAxEI+PAbSH69Qg2HxndretgFgWm0y3Dn99i?=
 =?us-ascii?Q?bhd3zCmdzob13PoBbD2m4L2KgoadHdCWmlHkIX/Zt+63nnh8yQXx+pfrZi87?=
 =?us-ascii?Q?6IfDZyuVNm0WFWxZwNfh+U7GoVw19ozZOkkhBRXunVDWOHcjrL3J4dmNDN45?=
 =?us-ascii?Q?JsJlJRnRBPLhB5BIlNQnNDOKD7BYnEfdx+eDOKgdRYFnfR92o6c9kJ7XwMtu?=
 =?us-ascii?Q?K6S7OpOmyneUxREamswNnzn8DYE2Ms5+qRxht+SG15tJwkOAu4nNXrMyl34l?=
 =?us-ascii?Q?Qju/3rbyDtK4EgdYfLR7JwHLgj//dwFiTbDWt4pyRiP+Vvkh5p+0DCYR77mJ?=
 =?us-ascii?Q?W6wccKN++qEMqrKDR+dFZ+QYmikfHi+cWqhm0wJZo2x7+XMvTFFRb5kJc439?=
 =?us-ascii?Q?UHK+GeDBFgmGuLUWIrfwqeyGVviA36o/GdF4KIGaKfXZy+dVc+v7jBAjIFIi?=
 =?us-ascii?Q?voGQW5QyyHoSsUEx4C/FRaYpOJTpMoOqhFz3445Xvu2QLwXrqmaiOhHCoShd?=
 =?us-ascii?Q?OfGIuRykxfc/GJKJTk3AdjHCqJRMcRmKUcHMJTds3UjHzglUiJVFFx0mGHdJ?=
 =?us-ascii?Q?DhKEgFUcyMIzgsNMbljn62powzBuqpCFlXG+Hzzlj93dDcGDcsYfVaRiKko3?=
 =?us-ascii?Q?wvxTfjl8PeRo7Ik1zTUXS/TeXbwaGujRFC7Xw9RiCTY89TdSZICFIUue1YOP?=
 =?us-ascii?Q?zN+gptjuEuYIbpPKdNvCSCXnf2+jZ3DHI1I7fL/Z2uCbN09ukAaX/GsJsJdd?=
 =?us-ascii?Q?h4BX/nmj474aaabd9M1OGvte0VCdy2gaCFmjpTu4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342e0568-d2ad-494e-2378-08ddb039ab92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:33:09.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXagUXwQqBckzsFWpFqJWz7louyfazQ7cPxQyPNFODZgV2qswbUV+2ufaVDWEH2I102kJNN0SXYSgsE8RMjE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

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
2.43.0


