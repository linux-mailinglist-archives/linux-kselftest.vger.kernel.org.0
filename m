Return-Path: <linux-kselftest+bounces-192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF67ED9F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D226D281048
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0816AA0;
	Thu, 16 Nov 2023 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SkxewIy1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2042.outbound.protection.outlook.com [40.92.91.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2C199;
	Wed, 15 Nov 2023 19:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9W+jeQbkHyVsB2lgGfYAdO+1fqcEGAqZep5Db8FdtcQDNS8qZYnxYFIo1SpcjT8xTuzB7FgVCtAbyoXdS7xqjQKdEcKDr7pLqkpGnafuq/6IWsTbca3NgeoFNXkqjq1kfzdXsl8Z+sx0DG2mnduCs6f84Lyi9zUScjMPqw28Mis8i2H/wKrAUt1qQaeMUsEWkt5TFsm/LwWHwhmQJTgDYvGsHeEHVBKv1OlWQo6Fy4UfByt9bCnDdV2oW8lFjyCCDtiuHYqPrYTfGJDseVCX3jv/FFijVdjfJUMEc/By7CSoVaTJwUC5iUYcIB/1q8tUQlk0RnfRTSRvInxemWYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=QTlUvxyoMtl1yM2dm0mESKckDqxYuRKWKsDLMvPFgYf28zXeHoSMyRCYB2bUoutvkAtGWIPktV2FQU3CY8asqIRTlT4zuPIETwQv9KlqKh+QeQGL56ZkbtM3Mi65lAfy8c/8aea1Zzqw35ohkyT/nQk7XInMUvXE+AyKQr8zwtjkhtddZZv0WfjpfHOerIxkwvu966N37kJziA1i6N77kxe0lmwna/KPPI+8+vWJU8SKxuxRPNLrs3VFXBg+ZkZTvcNjc8LCiCE+3pQA3NoRsDYXwUTi2g1re9udwIQY2Ek7tSQNjBw3kIolW3JYlmCTaM2DKshItvwRwW/Nmhn0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=SkxewIy1rpxNIbm/zhZQOWzBhG1tL7wOcoS5ZVWhMEbvJ3ys+ytIStNR+ofeGxErMNew+ij8VOFXrK1jR3C0L0Vt7kzSGEaV+neWavLpZvlgJUROIms6cI3szKJ5X40I+tp3S78GX3nF7KAYZq3jKUhAyVbb/bd4i+PBl01R/Tpxb/hcFUelADSjVpWEfH6Q7LRmjaSCedvNWerP0pzdx6Mqr3aPzUsvL+/88bb3S6qIxvYeIVBS2gFJaMVcTRBW/vKnXIQ+dBGQZvi4oVcXWo8YOJ0VRgTlagL2VqOsks7aiVw2IJ8teNWiWDrp3kpk1z18sAVK2fB37uM27MiKHw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:609::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 03:19:25 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:19:25 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next 2/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
Date: Thu, 16 Nov 2023 08:49:00 +0530
Message-ID:
 <GV1PR10MB6563BC7E775BD36D088AC37CE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QXnX9bdXqmjE9YvU8a0s2RgB13x7S5CL]
X-ClientProxiedBy: JN3P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::18)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231116031900.70828-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bd8b72-677d-417a-0370-08dbe652d59a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GvWOd1ojObUSt+UMOWva8cW0SATQ+da7iAIlGKD9I/6f+rPCilT0hRoXyFrofjJVbnKoyfeB031dgC06+jJSDPMBS0xsPeFlvvcvOGaoupz8d4EEjzwEPBYDaED0R3x6FQl70hufJTFgXaTJgox2XgdTWAHGMCRl2NpKYBLb7ulM/dqOrRrC+XtDVheEbp6fjRgYpPewROJr5EAffoLm3oyPHpDq3gPGXqAvB8jPVzjxDNiOmK7mMRkki0GRaEUJPduPHaMLiCR6GSUt4+otgetnL5e79/WFrzCGxu8aR54jazy2ZHB4jDtLviYg8pidF4cJOnLXBBrVtZ5HcTjWUOIsC55LIK2V4YJJ5692JxDu2jnahuEGlBdTEyVFCanTob6SPpOYkShWtWszsGHc9bUf6qweA1j/SkOz9fYtQyHubTqGyTRmuojoepx8KgJmvlDHPkb7QDcUB5cGrxja507xUd2ETLfTvLdZZTUtAhFu1V8aE5NeCiYH1RqvjpDAIYa+NrczwcapCDRKJ89xpRis/Syqi71lArDi8mNudpNlQ0x4P16c2Ip3iymvAhQIAF94FkLeIwhgCQDMQXFKSeJI4ibk4rWYumTzT80FKXwl9SQb2SmO4qopxcsOaTuw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIzjeBLJY60kBntQMvhxCDq1HdrstkKA0KcPo1q7ec79hb9xZtVOnYlf6zJe?=
 =?us-ascii?Q?71liaoxNNzqGGNoDZi5eJYvWVnEIlgdZkeH4uVeiKnXYE/KqtA10Y/bjtyC/?=
 =?us-ascii?Q?/ZRyTvFeUiqNh5H9PprGsV6hnFwel5ywuSrmRsA6Gwf1xnCFP4YHTs73lgtL?=
 =?us-ascii?Q?vILBPlBxdjCPD11eaf9NPvZPRQ8imO4bhXw94IXy2zu2eThdhTBLeBZ1Fy2S?=
 =?us-ascii?Q?dcHV85U1NgvfsGPQyi8B24MeM+TyDvcRrusutD+/VrOAvCyLww/F7LfpfooY?=
 =?us-ascii?Q?I1hVt5Dp2V41PCoqfuqBUpZvHw9RaUFlQdJwG/5xJ8SiY1SPz5p9/d3gmimC?=
 =?us-ascii?Q?MCOkQybxrtRzjGw8osDJMeXn0fveH1Jss2mZN6COog6PizfKWrSDzVbAGOWg?=
 =?us-ascii?Q?cWJAFMHoPiaC/6ROS3DI3x4wN9X496uM21M/S9IQ2KKZ60ZNWJroypNrUKJU?=
 =?us-ascii?Q?CEkN2WtM1QC4h+PM1QzKGVGbiXwYPYyyQEEAfAAls/E6y9bdFT60MfhAZEBC?=
 =?us-ascii?Q?+AL0QCgv18x2iB74rJfvlo+ucUlPn5+IGP3jxM+GhdguggslGRqcYKqwEgp5?=
 =?us-ascii?Q?h9P4SHS+AhySwHIPAhsmHAYyljfXWjevs4q87JPXYO2SOPcNaA1l/ovDcs/r?=
 =?us-ascii?Q?o4S3rqtRso2XDjxlyxSzvy8L+GeneEzS6pgmNDk01l0qX3n9dgvFgPsAEI1f?=
 =?us-ascii?Q?k1998Rpp6SZFWXm/ebIENJijRBpWFVHhoZ8M4Kp9POB9o/Nvg93j7o8KhEvm?=
 =?us-ascii?Q?BcLoEFM8+jq/CkURCqJwnjRWa83s5QLDVY4GOUHLn0K3AP130x8gbzcysfK7?=
 =?us-ascii?Q?DVfUVjH4u1ekeybKKoTQvxbJtFclcdARDwacxc+e8CnClbesZJuxIC6gAIlT?=
 =?us-ascii?Q?GVG3VpNo7ZNcQ6/zVsHEUAElek7MreXNF/1LKd6xdHNWsBMuxNZ68iMZ4ArP?=
 =?us-ascii?Q?/LB25Z6RInjPtGZsc+kqmu3WO8IMmw7UKZljO8r+bUD2vVmjbXVvBhHNYfva?=
 =?us-ascii?Q?A8WmbWypCNvmi6PifM9kkKoXUM6azlMemWf17v819DzbmPhgl5MFgJReOtrr?=
 =?us-ascii?Q?BOqD0/OpQ1vcm27fOcea+lnfDm9c5lE6S3wbGt9FNIXCFba+LUOTxrii6jNi?=
 =?us-ascii?Q?nICvVqFT69nD2uPIEOOgIjSqsP9Okw17TwHlK6FttO9ICMjMWy8ALY/OESXw?=
 =?us-ascii?Q?vCCEdNXCBy3AcziR9s2D7A9onctQmf4hqKs5xFU+/7PXUpDeSWWhxOi6hAQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bd8b72-677d-417a-0370-08dbe652d59a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:19:25.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7227

bind_perm uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bind_perm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index a1766a298bb7..f7cd129cb82b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -9,8 +9,6 @@
 #include "cap_helpers.h"
 #include "bind_perm.skel.h"
 
-static int duration;
-
 static int create_netns(void)
 {
 	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
@@ -27,7 +25,7 @@ void try_bind(int family, int port, int expected_errno)
 	int fd = -1;
 
 	fd = socket(family, SOCK_STREAM, 0);
-	if (CHECK(fd < 0, "fd", "errno %d", errno))
+	if (!ASSERT_GE(fd, 0, "socket"))
 		goto close_socket;
 
 	if (family == AF_INET) {
@@ -60,7 +58,7 @@ void test_bind_perm(void)
 		return;
 
 	cgroup_fd = test__join_cgroup("/bind_perm");
-	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
 	skel = bind_perm__open_and_load();
-- 
2.25.1


