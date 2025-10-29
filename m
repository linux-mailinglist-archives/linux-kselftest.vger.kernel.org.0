Return-Path: <linux-kselftest+bounces-44353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8AEC1CF2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF03E188AD4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1335A92A;
	Wed, 29 Oct 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l8ad9QmK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A235A921;
	Wed, 29 Oct 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765185; cv=fail; b=O955BxpDeQQumjYqcL5DKxMZA2gUvyLA5ivtr6a/1E2RUjW21TS+dAwR3jN6dnBOs7QYxvQ+jpEaYdMWLjWddkM3Om6r/YDNR3+SEvOJzlqpAcbSjf3yw43d2bgSs3/vFaXcH1WpKE5CSBxwuSSQXzZUF5DemnUmZme/xErEA7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765185; c=relaxed/simple;
	bh=KOCRbjKJ6cK5AmMFv8iDOQQB5PhofCzphLsGvobXcac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JeF1k5WOq0SPqtVRtNIS8GrZwu3i8vmO7ut7OLqLgj88eqsSJ/6Pryt8qj4mA6bxm4pjGPWzZavm2daMsQLhjqqeDMV4usxxCS6yrS6+jecgbNCsHxu3XGudu43Fuc6k3q6EexwuXUwq5JZtEe9HfhGjaU4QbjQq8HNnDRo1g40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8ad9QmK; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN8UXS5ELvoT9PFA6gpkEmq75i13xcklaFU+hE/Gq09H01Pn4cFsZxtPj6TJRgnobzw71xnJy0wOlWOoo2koPKkzoBJ+3xJnUGQOI1pCAjy3FnbsEgH3c59hAh1HmmbrOn7x5o18YHH65o+2/qt81gsKWtCPyUmp+PXxzQwVx1EgD/gTZQvWpJqXXCGdJ1OSDYSlvj42fuHmgatzav9Z1uXwatolmXz2HKQBnknb3BP34hGEqcmcUvCO4xReeCfQunb+9Tb9I+GydyHrxi+me0Jpr05WhOfhEdjOziEs0JQYUeCxFlOiO5cr0A/o05yJyfsNjERmuXUsbiufI1RIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa5czhnF/cLOgBoPbtiXM4QfFu4Aad2RzEWRnMFyg5Q=;
 b=U0Ki/aNu6XQK+3WAw7J0R4ZoTjsEmrgTpEWOIrVKCbuxUSHyxoQgdwIJBH34mjqaJ1dWFyBQ/Xye2GX2Cff7dY/ahwGYWnm/hHKUEbGoU1mk6sSVHmCcFXYHHxINJN3jpXtP/gJjfAmtGYGxZM4H3HGvsqnHo8Jj9VT14VxntShOm31hLeZOnuzz3QBx461qyj1MefiOLlkrYkEH+6aa6W1LF5We0/tsW/OOx6p8dbood4U21YtlskC9D1/bcdFSEgXPuPBDldMiGBns5HShWa4/aCExVE9D+Iy/quV8S30YQAgjhUnRdK+USKMNELKliT6sdLEHDNAB25pLZlkXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa5czhnF/cLOgBoPbtiXM4QfFu4Aad2RzEWRnMFyg5Q=;
 b=l8ad9QmK7LUoKc1X6P9S2Zo1YP96T8dWhWQ7HoTvfB7v5Su5qJR2H1ACdUXntkpUfVEw3ewPIKYP+CEpaDO2BYaKTlcS3dcM0xKmXGGlAvKCNlihL4pfDC0TjxlMGOoCZkBT2zTbeJ4ZCVSaXW5WX39OvBKNekrrozr+ZXBn9ZjLQeZPwjpAuWLfnJDMkkTfqoSYeUgHCsQ685cEJn86rcugbfoB3f0BJGMvahePJasdn3Zt9gECUG7cEGRAxn+pKzyjPxZGWTWpZ/MGINxGUF5A7TndKmdJlrdbClV18+OVqph759ZCPHr6I0X3xnP85O+dRRWHLOQaJWuqDXo4aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:59 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] selftests/sched_ext: Add test for DL server total_bw consistency
Date: Wed, 29 Oct 2025 20:08:48 +0100
Message-ID: <20251029191111.167537-12-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: c67b226f-f271-4ad3-c752-08de171f2c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+2yLX8NMoiWps3U1FfSt2UrIdweCW6MXqPmvNh4jxn+ktTLuWvyWvGOWGjFu?=
 =?us-ascii?Q?e4bDiuqZzbkxncmHXu+cglnxc1ATpx6WRr0j/+eVNK/pRS8rlNxMpLZVgaJr?=
 =?us-ascii?Q?e0GWjSBf9NaaigdfyYYLPsTzXXY+c7bGo/uOzAgFyAotRo4wIbC66BT9c7Tk?=
 =?us-ascii?Q?TAW6kF4MK058rnlEYYbkVTHapFx+IMRhWd9cDNxhCtAXvkBg6JwrFkVzHZKW?=
 =?us-ascii?Q?uhxGOJudq3Y2oHxmBFms4V16whfyP3RXjYMLEBpq6P2iU/aA3d4Gb31nqDyT?=
 =?us-ascii?Q?D/F9fyjPBOshtulJyvM8ZhUnWz2oF2D9GJDIM0ZBTfKDT69zHVByCMz1d0Bv?=
 =?us-ascii?Q?+Cs3UD2aONt5Be/G9pg03/mEKOpSgpoh/snBLlmFooou+46LXO1U3ASnRmJ6?=
 =?us-ascii?Q?PnLV1roBkeNcbyOt2fYyNkGkESS0Xu6tkRra8WGY5/cByuzzNvHwyLi7Rg+4?=
 =?us-ascii?Q?Coy9wMbuTinNC/yUElGdgDnsFOxDLNrNBS44JjgfVvaTavbaxUGJvwlQtvio?=
 =?us-ascii?Q?7TwOHSfZJ8vLiesjYw03+Jqid1+Zp7boyxqsxQd4xMbMBmSHo7Jt8GDWuwjU?=
 =?us-ascii?Q?8qJKSfVnZFQu9+p7tasPlbMVntHynmYf3N9kXpn7Xi3lhlHMVT6taOQGCsBi?=
 =?us-ascii?Q?o/4pPV2OsxNtK3oYGJGdySupXtexgRQr4AwQjKqWR8BfG5zDJfYMdG71rWmd?=
 =?us-ascii?Q?4v08omKPBO57+GfrDRORAYxgeGbIWLsjeEfxVNnmFRJWHNJpF63bkCloUiLG?=
 =?us-ascii?Q?7rOz6qLVVOYcP9m3O5CiQUbu0s9KRdmKVNNiJCSjk3Za7DUIVRtyNVvUyb4J?=
 =?us-ascii?Q?42DwxacGwwySb3yl1wn71YzDBOAg/yW6MEG+9DKDlVzXRnXqmbpYBxFRLVsz?=
 =?us-ascii?Q?k4hyNMX+Wx6prq547xLXTKupWG8lIC/DYMOnSGzWoie7ua/F1rgoEYip0qZy?=
 =?us-ascii?Q?UOLE6+TkVaaQNKbk6kYAPtmb5hImm8OjADtBa0FahTYblAKu/s6Ffd0kDQnl?=
 =?us-ascii?Q?Dqot91PBHj+RhdM2bgq3f5uNEV5kUriCLZWa+E7TFlvDCVp8bp/GUcq/iz92?=
 =?us-ascii?Q?r5UWoYKnxK2XWmTec0PttwQZYPvmaiLQBG5InIOe78gLyXGerYVMAjffR8uc?=
 =?us-ascii?Q?6HcpAAmB3VQ6Au9YGqsyevTq5uB7oL8C4D5Bf32ktxVrARyyizuYiqMy7Ma3?=
 =?us-ascii?Q?5N5qgOhce2TbrWtADbRP3JN1TwndeyG5Te7xPF/icQcQqJecKNjCpl49HCZ2?=
 =?us-ascii?Q?DgNkZWIKnlqhzPFilH/xtilUbmnOT48KbJVRMVX9rLmqOUHUp2BNGgiHhdtp?=
 =?us-ascii?Q?DCUIul9JaqTSMkT3xF9PW+xXHKrcmRnU5MHFTsBEAlf4JWtCMJBn02MaT1UH?=
 =?us-ascii?Q?1EQicOwtAm4Ct840btfkn2J7ssifjFSQxm8NxGu0bO/xWRAwdw1QLAbGMuas?=
 =?us-ascii?Q?3UL3w8chreFjE9jl0hBSTjm10wuwEiXU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEPv3PuKZzN/UyBCjQKFz0Pyqyjds+E2MR4H6XBjubA1y2fhL6fSzp4T8Ivd?=
 =?us-ascii?Q?ppSyXRU6K5gGlHQ8FtAl/W5eizeGXWO7K9ZKB5gmYtTHEd5ba+RJjbz4qci/?=
 =?us-ascii?Q?PVAjtlR/rC/GGmxzbO6A06Vu+2CDQTTcDIlZksw57Ejkig9VnZ4d5kif31lL?=
 =?us-ascii?Q?GWtEakRRFsHwwon5YhELhkBVuKOumprF0k8rXBhCIAko4ReqwIzYAlx8z2ad?=
 =?us-ascii?Q?/DdHC1LxD2VjZ4uM2IjGIFghA4zwu9yhfkKb1rpLnclI7mygCPNO6SKU/Wx0?=
 =?us-ascii?Q?8jpgJsLs7lPH+jEEB+Zz0AJIkELXO8hTQxDU8BT3RcB1c1DQTG6Ss8pPYJ0W?=
 =?us-ascii?Q?c1YsUdBZZkGzyh8VskWHOE/07CcD3vwIyez56ruplO3FFnYISTAMZy6Mq+cQ?=
 =?us-ascii?Q?s5DuCM5ZABdDntt3cLUt1XArxrO8su11xWoq5A9EodtXhSqpu9rz2Jq+hJSi?=
 =?us-ascii?Q?VkAva/+B3CkJfFpU8ZvtsZb+1FjzApO69e775x5dMo+UQ3BEpdwrC/SQaYjM?=
 =?us-ascii?Q?DV61YPrGzeWcXn+FyWTM1Kqfe8+iFwC6XnUOIZZFI1WR5ZTPKPbYvivljvcc?=
 =?us-ascii?Q?LvkRuZA4agJT0WGeCT7GGDKe5BVqZ5jnZU6RSq0dhG64Y+cOOvrdUX3z3aig?=
 =?us-ascii?Q?j5aaQ78p3FMUm3JCSVtg/EaJPk4ErSK3i0SI9+tiEpEGGezGNlJiV1r0mexR?=
 =?us-ascii?Q?vPTu/ECFkPAjp5fZX26ZdBOB0UEn+ZM7C/NLmJfhT/r474B3bp1huPVJqmh7?=
 =?us-ascii?Q?ndu4IV5eEuP+HKJ65tacECFR3QlyL19EOJniTwxbOB5SW+nbWEPBaDsnIhmf?=
 =?us-ascii?Q?vrRtj2rUXngLpEuY6Nmabp+rb5GYafesN48jw+YnSm+t5IcZubhQoGnJaDjW?=
 =?us-ascii?Q?SlxPWQ1qNkBD1ouu8rSYbIwLGvZMYPWSy4S2bzF9B761Je43aSZrmgPCQx3b?=
 =?us-ascii?Q?1AYXq+6zR0dvhmMx54EU4TgHSMHv6FEM4o5EiEKGcq6cWmeJBe5dUyacumvu?=
 =?us-ascii?Q?2kXbvOY+fLUqGM/gQO0VTuRmpGhQKryVfgfVtchkdZQgCdhzb2wKEWzXQ5XC?=
 =?us-ascii?Q?Ua2IIHQBX//xlG6hDNVAJ3FaOilocep3p42oPd9ZDN9gDqfUIGNHDArqEokh?=
 =?us-ascii?Q?xWNGxQd44NhO6FoYqxkST+t78meLc2rLFvX3IFypWG4REcnz/A7Sl62o27Ud?=
 =?us-ascii?Q?M1WHzVAFo5NZJn5LdVFV1YXCT8JB3zyFn7I0RihJC7S22PhX0iCj7fKIri4+?=
 =?us-ascii?Q?cKWgf41sTlH/Ey9C9mplwJlUWMitNQ68RHcSgYKS3n1sMuM+sGkIXpOtc/Ch?=
 =?us-ascii?Q?y9qQmgoLP2G5P8ZZBK+lEiq3iTXnO4CzRHIdz6OKAF2vyVKFOGs9KSNwANqq?=
 =?us-ascii?Q?hH2d1caf3dnUf/c7sq0bIVBhrTLbssy1SgLYS3b3bMap0KnUJLXOvp7XtVFI?=
 =?us-ascii?Q?HWZ5QOjY08GS6WNzCZpsqno8vt9d/1OI/3PB2KX6irg+3/ZpJXnsGxdLlMbY?=
 =?us-ascii?Q?d2lUy6gapCub2bRt3eaRkXSljPQu+dA9oTq0Nq81yEQkRwRBCTDlytOehuw4?=
 =?us-ascii?Q?MYHQoXgA3rdqKGZZSB9EQHee1Dly4zZLrdhgM8yL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67b226f-f271-4ad3-c752-08de171f2c4b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:58.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AeszGqSXucyKPtizFMt11IS/Nkz4R6Zj6U2nOnntEgfyCwWp615/2rxBfVpEjhJdIGnl9880tDjNDwutBA7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

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

v2: - small coding style fixes (Andrea Righi)

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/total_bw.c | 281 +++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c9255d1499b6e..2c601a7eaff5f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -185,6 +185,7 @@ auto-test-targets :=			\
 	select_cpu_vtime		\
 	rt_stall			\
 	test_example			\
+	total_bw			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/total_bw.c b/tools/testing/selftests/sched_ext/total_bw.c
new file mode 100644
index 0000000000000..5b0a619bab86e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/total_bw.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test to verify that total_bw value remains consistent across all CPUs
+ * in different BPF program states.
+ *
+ * Copyright (C) 2025 NVIDIA Corporation.
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
+	while (time(NULL) < end_time)
+		for (i = 0; i < 1000000; i++)
+			;
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
+
+		if (bw_str) {
+			bw_str = strchr(bw_str, ':');
+			if (bw_str) {
+				/* Only store up to max_cpus values */
+				if (cpu_count < max_cpus)
+					bw_values[cpu_count] = atol(bw_str + 1);
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
+	if (test_ctx->nr_cpus > MAX_CPUS)
+		test_ctx->nr_cpus = MAX_CPUS;
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
2.51.2


