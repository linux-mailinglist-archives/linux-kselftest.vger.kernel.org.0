Return-Path: <linux-kselftest+bounces-35235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B285EADDCF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9F3BB63C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7002F0C7B;
	Tue, 17 Jun 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cWasrKB+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563512F31FC;
	Tue, 17 Jun 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190798; cv=fail; b=RYLxxjSiHjcR3Gh6bRyUoRTCvRFAtcTRghabfONLQ5MbKdaCoLXEQdUP0LG2nHvyFQQhmYYUEdI+6KueTIg8hYeR4Yckm5KqCoBi1oxHXpgKSQozeKzvp+zqBNrT48THjKPZZK4KgTroJX/sh3q9l48xfRrywB7I3JqecgxaGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190798; c=relaxed/simple;
	bh=XUaf8US8yp8yC16i8lwOhH493GDbhEg3+8gSn20+SF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCgimt5G7PmCXyg6wtGrfQB/BGLnRujtJg5PzHqrMWsl2KMeaxM1SKV1LcNa+y/MHfAthC4mkVjL6nnvwgDfO0+96ANYVnUgtQ/W7cZ/yBmFhkT5Wya/IZ/4bwKgin5DOJ5XzcIICbe/O8BIbSfOKs96pGPl+x0Z+5Ri0eyUeFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cWasrKB+; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJtVC0LZTYiKTO6Znq+MKcMa4oszcKKlggHqvjErMol0Xd8nTi3nbPcgQtFScUxgbdq/PIGoqGuVBKdOzgQPE5f8wFdUDxGpvkTWA+CWRDe485m/IaPQCLNyzV6vZgN6B/nGGSBBB+1RwYOcyjUQD8pxH8pVroGC+KnW3Ygf2j435WeozIKz3DKkRkONByCeCbI4QgT9uUJ5Fj3LmPGiWUOOHNXFEPMeKfDUUjK1N06PuMfV5l3rzGp2lI0FUX3zvShO3joTKK8Tx+fstdaLJHUVXXr7x6P2QMEkH/S+NRGHhL3V1MK7iMhzaTzuCj9Q6IW4f9l86RaiRrgz9ePcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eg2tUUcznvOF9ook20X/S8BCOmvAG8PrcpYtqjLMvk=;
 b=K/7lsoTnpqgMlDSf7/YxxeXaRVxea6qtP6DlKoS5FdY0iLonfXs40vdawu/kGRvBhlXTSnqRM3Yj5bqpY0UotgYwMnFWdLDXWZ0rjYVJvw5iYrqo1uw1p0Z2PG1Kgz4eblpYr88VsLUXz+R6KzMHOzEXpO5MGzl+0r16sItubKsrZeBQp/Z+YqCFg/YEB1WrNcXvVOGQ58gglPsZi/CCkoDI7JhZnEu8PB18lR5udhm/wJWWTQN7o5xvMnrXvkBK+oJXCYRsY+IYEIT/TbRmWz+Mq/ZTRKPwtBIugUMOY3cy2U+2mnHEarhb/6vP2OscHi5QsS8JT8BhhOVZG00OeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eg2tUUcznvOF9ook20X/S8BCOmvAG8PrcpYtqjLMvk=;
 b=cWasrKB+wu+sIfbyXmXGFWA6zoXOqEYYtMtK81D1OZSZcjb3oRNiGThQjx848zmoqWYQjsZzsPEVTofOBc+k6C6MUBF6mJpwuvogUWCl+ROIHyrbErJk+Cqh3i1G37ktP7sK4dtTkc20+n8zNqA4JGFFtOlAXs6oitUw/43KvvVP++vnFhy52hIU7tMdxb8qoOFlxmXxLPrSOu8pun0wWs0e7YTa1dWNi4cMEoEJSF8byL9r0F+YL+/yHaQkS9I//09BdNo2IWUaYLQmfQT1ahYCKt1xaD0jM8B9XM0sxwvq2ABkr4HSxGU+pB/1oJo6NZHuT2Mhd4UHbLT6rDY+tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 20:06:30 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 20:06:29 +0000
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
Subject: [PATCH v4 13/15] selftests/sched_ext: Add test for sched_ext dl_server
Date: Tue, 17 Jun 2025 16:05:16 -0400
Message-ID: <20250617200523.1261231-14-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617200523.1261231-1-joelagnelf@nvidia.com>
References: <20250617200523.1261231-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:408:143::31) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 28073066-2227-4c3e-a253-08ddadda72d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccCFONqHDDr0nuxqZFdMDeihfxeYIo8IOEfmXzuc92M8EtJ7rwG1nuHJX7WH?=
 =?us-ascii?Q?1UhcRkjrzzLON1X/Doj5nSIvxbgh9VbxDaUjJnp199fz8Fw/u6sMYYq16A3f?=
 =?us-ascii?Q?XaCqSdz+sapdrbtv8USBqu1Gh8wbqe8p1u0e7bcml+b5j/4rdqRCfx6tmJmp?=
 =?us-ascii?Q?/28WUCu7vSfz/kcnDHBNicMX2lRG6J4PNI0hFB3U/E7xjT5omgU2zNE0pZ75?=
 =?us-ascii?Q?iXQfZOA5tEgwjHFxQyqHWCMA/V84MRpMc7SjCStieLi381D4c7n2lhlqqbW4?=
 =?us-ascii?Q?c68O3CpAWJBXIgPhzGRKJ26rm6hyT18mmf6QFdlTmF3RJcxE+YjOBZOYP9Q/?=
 =?us-ascii?Q?ms6sXrj3CXcfUoArJXJ+V6E9/53lYTvEp3n288t/Ycn/fRVK+VvclQC/WCdd?=
 =?us-ascii?Q?UZameyFfeP0NB7zuwgxYfNAuTDEU1mrG1rr/5U8JppQaoWKq8As1qGpF7W/k?=
 =?us-ascii?Q?8Y8esLVqUEVZrDOZgW8JUz5vp3yx9nX9GwVkJpFmzZviquQN9vRLU5fL9HUE?=
 =?us-ascii?Q?mqzgIPdF9p6iFw0GRdzOOHcvey2gqcQn/kOGf+BAOlpM2RNwTq5LgFQ7lm/5?=
 =?us-ascii?Q?pZe9wfVo+yTYBY09Hl8pmC6bnAVz5xAw59HBRyaZK56aWRS5rPm6zjb58prD?=
 =?us-ascii?Q?3uOPSCHD04ltAOS0f4jbDdr56GNh0wktvLyv3aLVaqzM4lHOfrCVr4iKkULj?=
 =?us-ascii?Q?lgYydrX4XuNFjsKwkjZw380FPdulqB6Ubvnd9xfzcRAU5UN53KtIr/vLPJpR?=
 =?us-ascii?Q?82tbsGYFjgiBF2sDJBlxsSVp5sbydH5KKCBOAdonJnsIDrL0/wOyXjB+gDgK?=
 =?us-ascii?Q?5N7CO9fa0xEYrspnD3GGm6b95c4u9dHF/snXYCcf6hWvPp6Hr0HDUIAVOVoP?=
 =?us-ascii?Q?YaNB9u6c1CxP2pQftTP6Ldh0pkhf5EWQG9xRnFMlwvFgcc7Um+LQgU6mSlM0?=
 =?us-ascii?Q?ggMJGcuXi/VuF/foADRiIAs3J2d19PHxoNn1pHLcE5byCp0hVuMom0ATpMuf?=
 =?us-ascii?Q?emvBBfRAUZGfG/ZFvW6DLIGJDqFJ2o1NQ2PiSdYPxesgK7iAFOYFwD4OG2Gm?=
 =?us-ascii?Q?HLM9sz/oC9dSybs5gt0EIpzxr6A6ydUzpEXQfy0tV3qShEr46MZ+sW0+c7LU?=
 =?us-ascii?Q?JorXAjWVfFPMFGtkHsuFPuHhmvIg7wo4ZDXLn13rMt5apmYJy7zv4pK8g7f4?=
 =?us-ascii?Q?i4FoquwnkS5xQOGQdB1Gxax6zHPRius3mjpSX92Dn1V4XKFDmWoMjFVMPdHa?=
 =?us-ascii?Q?md0OXiKbH9jXKmXvLYy09JDZvylQRmnHt0pTUbanl5+6Sr72kYciQke/lGEW?=
 =?us-ascii?Q?s4n3qgfr7TsPM3GOn4EfVMWmNV36emkOTapg4TIe1sp+fdSxu1n8dTN1LyA1?=
 =?us-ascii?Q?HyjRUGNLYn4qVcybGpvN8KnuQ1KDWL8VBoWq2zU9NaMHUd4QcTFSnlkLHwl/?=
 =?us-ascii?Q?6P5IDslHzZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhvcZYEO4PkXRGrr//lUTb502ipSSS6zC8XONP6/HPuft96iwAm7YfNqD0h1?=
 =?us-ascii?Q?y+3QifoLbsKwSq9+azSorFpZdca0Ggp9Xm+vkLaNqX+jU4YjtVpPvOFjX/VM?=
 =?us-ascii?Q?fI2djsF7jxHIpNlHaxsNfBAkQhyQhhYtwgOvz2K63n9d7q90uHy+i7decrIy?=
 =?us-ascii?Q?d0HQkAqJjBc0jd7RLWi5kWaWy5pU+xELkUjlGtAxikbP29rb2yoSYCUobnqX?=
 =?us-ascii?Q?1C9nb9pl5eokHLqD/b8Fqxf6x+ax/NIdmHTqt0piE3Ax0Z2oVGSp4OSrVAV5?=
 =?us-ascii?Q?4lkAIlNfZr2MmH7oIVqekiVciD7yzsaZAQcR9eT+c7M1TlfaE9x9RiFtbdn1?=
 =?us-ascii?Q?B+LvWBwe/9EVFs5oRZmS5bhNQNHyu4lCH4Tgpry0bXYLyBzcy6hZxKafKkMf?=
 =?us-ascii?Q?TPDQ+Dl3FK3Udm/lXaM2WOMImT0R5cNd0gb6M/A4FrT8SOqwKsOeAdgwXoYo?=
 =?us-ascii?Q?JWrj+WkAVSuOzdrssp3/FUNO8/BWyCllKMcUpxQvgHyTegeRWFXjm0kn2QAz?=
 =?us-ascii?Q?ojdfHNh6ipevex/4Var7rm1p0pGhjal6f3ovGqrn1jEwl0YKTcJxeVk8VGnA?=
 =?us-ascii?Q?UwjFzn3ILnIDBIv4nQyHDGIqCgIvPriBiCWYM32eOpZtTj7QvLpqq0z99qZF?=
 =?us-ascii?Q?XORiC9QQAvX7vtJsZHuonuUbM6qnVSWwoZh1fqUy0aqhDE0DatZ1Q56hSEqS?=
 =?us-ascii?Q?UNkhP6F3FlUAFz5xZanXf2Z729FjFVzFnuk6Zwty6nC6CTo0KnbO8RlUM8B3?=
 =?us-ascii?Q?rlbR065XmNAWM4oudZBWyZEpHtNNFaPo1HOuLvEnpf5EXocReKhb5I/w845t?=
 =?us-ascii?Q?sCrnqJ7oelW3OTqDPxpSNdjOjUHTrD0VjH02HTUw0Ru+UbwaUJlQ2eXV3To3?=
 =?us-ascii?Q?ZsDoJntR3sj9Wry3Ai2TrY1XG7TkqgYdwIK0lxvS+4dJbmhIPfXviNydL0Vw?=
 =?us-ascii?Q?AIds8DQA9PXsO0cVJNtUTqcXY9BamZWYfDHUq9C0zs/zQChEq8tTTP9TXnwJ?=
 =?us-ascii?Q?kFd87+0U5B1ygog+H7t26I0UXF7X1q/xQ5yovrhefi6mXmwiHINPvvaCXtGT?=
 =?us-ascii?Q?uC5Rf9mW+Fy2DXB7NrZIDFVfXssiU2tyrIpCK6v54ahCPSipSdliHBl43DBY?=
 =?us-ascii?Q?BFqrhi7FgULCtx+AY7asloyaw7lGrA0zacn6+wkY8ITscRbvSICkN6NrgpNr?=
 =?us-ascii?Q?zWQgzx/jPmImLgOtUtCo6GDqTDNnOod1TWV4fLWWKXBoNWc6zC4Q4q9zNC2D?=
 =?us-ascii?Q?Z7A4Fo3D4kwpxNzLF4KfL6FwJxtkh6faCPG4OG2TaBSUptgRZNDC3gFmvPaJ?=
 =?us-ascii?Q?Jr7w4c24YGNfakvzxsFnMpUpVz0boDop66gZPrxY7Q7Msu0gsRKfqw+69p8w?=
 =?us-ascii?Q?5+Y91LpkbOvAPyHSVsr4X3O9kExwM3gObu+HRQ2SRh2GMHbB89G+6RBY0l1j?=
 =?us-ascii?Q?heeekpdaIW0oInrz8jeVssXKvfjXCwlq6m95e1l2+LPDJn35ypmigIoVMIyR?=
 =?us-ascii?Q?RmpcDk29JLxv+TcAhOkFYIIFGskoY/eh1nXDhyMMk9SM7r8So78kZQx9XzPp?=
 =?us-ascii?Q?MvyKmaA4F0PC0QCbq5kTJukb5rzb8BNKc+MJApai?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28073066-2227-4c3e-a253-08ddadda72d5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 20:06:29.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfJihvDOG+EwrlAMxa1s034d+jN0YWnW3TZH8D0VEtTmJUilNSHzIQSjcz3zJLRZtf9nr14QAwPnwh87LLfmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

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
2.43.0


