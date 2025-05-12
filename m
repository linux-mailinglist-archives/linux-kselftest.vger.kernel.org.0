Return-Path: <linux-kselftest+bounces-32847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941CAB3554
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8257819E1ABB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCA269AFD;
	Mon, 12 May 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AUWjwx8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EE26980D;
	Mon, 12 May 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047205; cv=fail; b=MEHf1ouJFagmJ/SEYvBK2xzqjJy0xDK1QK+EIpY7LQajTccimQ85gD6XDgQxwEhVxnZZ2xdBy9FwkrqpIOG/4Of82+zhNWDWJQHMpK8pT8NdnvZqxTh2rjL41OKu6uyzvYSYbhXaYKXW5L5d6BZBsSUYWEASkXZT/BhuxXjZAUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047205; c=relaxed/simple;
	bh=8pyN3xhUrgPbiNRBOsbz4VSme9JPlz89TfWNVXRK4qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGz1a2Y9vkqaozxjGxbrm8kH+4xIL4Gf0hAzUc50Ol8DqzIMtcPsaacNuZwqkdLj4D4Xc99cb8Cp6mAcCnMu8WJlqbcY20SFlHW3fNIpbfIqeTd1Kekqx+CaRKN4Zuzb9ghIlXIUggdm3YHlvRvFeGJ+Z7WpXroBTCcl/xf/VHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AUWjwx8y; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAe9WlWb9sEUd/6Ed6lsZFyp+Mp/K89Iwg8FKN09z9b/HGNT1el56vH349iNz1dHKDr74nE/YnglxVVCQf0ZMgXJRSPEjnVJyoYAOYpXL1sEYaCyH6G99u7FL1FdYErFC9uf2oNlrm+nVbQdZhyGPohn4QORLTCeQFH3q5Mtvd2+jdNrBO0lnfOV1/8YWlt3RmYItUj6JgNmPgGOReB50POERGgXoSjzo3yAegCd2pfFix+GKkLxev6/k/JDIzsxgVfHRKa5CD6ScPTvvGxUa59cxYeN3pbsExDCpfgROfZOMRv6VZPjjhEFlOm8txLf2e9koEnU/SZJWgvBGhlBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBGjDq+iTFpbCnHpzIR6cfAygnnj3gyIGicnsIkElF4=;
 b=tDKAPWDsn5im7YEA8fCKXM9PmsjiN7Gd7OxQNXDN2gkEVVFpYqTxYshvbVycfyyxuum4IxHyq8W+snftVFBY4PO/FNnj1Dy+pVrN226U7ioUnBgyQqtAzPLSX0Ngot5gBT3wKl+rzBGyCULPiRS59HUvjx5BxDFJ+DN23GQJ+nBmiT8sxLWvN15r1MEB7+vt5P3uw/rb3s8QcIoR0/Cb7e0JJWBwekHLSWeHKEXtzb5oOgn/dwCL7suCp2QjGl4oxY03E0Wgntfw9PInYbeHi1qbv4ASi7+tZbYUR8AiDsxhRe/OposVXSey0VS9SjNQloHcXKjNKzN6kjuDGQWhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBGjDq+iTFpbCnHpzIR6cfAygnnj3gyIGicnsIkElF4=;
 b=AUWjwx8yoxb+ECl80su506B/OU5H39Hs2QGJ5wVzRzH/+VQKYqql+O/zNx2PxBKN+gNcAY2RXqJoA4mzmx7T6m8AoJSMA7X2Zehs4vJKDSV3uOzNpzIoqUrIpsfQuekjmNUvDEn1cPUoJUsqvy2RFZMtzppalvjcHGDJYHrc/Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:15 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:15 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	seanjc@google.com,
	darren@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH v2 2/9] KVM: arm64: nv: selftests: Add simple test to run guest code in vEL2
Date: Mon, 12 May 2025 03:52:44 -0700
Message-ID: <20250512105251.577874-3-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:930:6::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb7d663-64c5-48de-8595-08dd91433257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ErjqQ1saAwv+XUqHv89U3dM4BeU04XS+/gY0TPUK6q5Ryh0A7tXG15YdJ8mt?=
 =?us-ascii?Q?HhXywutdV2Qt3qQrfntRNVhOG/GRmw61syjc0jV0U7WojT6VAa3pPyU/LKfB?=
 =?us-ascii?Q?eLA6xGufrKsgFKjSmope62x3lFiG4/VJs7k6vm6UclU2g06U3QPLBOstqQff?=
 =?us-ascii?Q?0eizfzkMQEPWXnMAqbJG3EcP6+GUfQ5QbhiFxH0BWi2/50n7o02ukAnogIsI?=
 =?us-ascii?Q?FtQ6LWr5m18PYkeZaqo48NiBwBSN8R23j4w/2zs2AWEaB+BoCyXAiuQsRwbt?=
 =?us-ascii?Q?6yNK/MFRX7hxGDlIKNMz+CuAsRwhmgLkdJZk//r5x/is8q9SPUkAuRUk0wDq?=
 =?us-ascii?Q?RCx5sMYhueVaCdAFEJzJO0DzcaXljYghsEZLMgAPYLmKydMKrRW2WfuwIEC9?=
 =?us-ascii?Q?pbHp1xmNKe6IHWB02NDwLWgqPPyUHs57J0nKb1BapO1BlcQX5u0b673nW2ff?=
 =?us-ascii?Q?y0XurRgzuiPZrRYPl4OQCtQHdCoJrpbtEBZc/H2eOBya7ZDpuQXUrq7D+OCg?=
 =?us-ascii?Q?0p4BJWhp2vfV+rye9a4dEYPNeXlbaDB7SFi7b1tOxQNNwKzam45iKVb9JubQ?=
 =?us-ascii?Q?m+FRmWdFrwbGWArnlNSkcDCZaXgrofcuLpKttQXZ9r8nVZ/92T1rcbj9VJUT?=
 =?us-ascii?Q?26rEyX1hxyxBFZJy/Ixuu43DEXhJHt+WP1AMdX2pFMmDwrdW4ojrxSxgvcCt?=
 =?us-ascii?Q?EwnDIKim6n/5w6WOI9CA91TaF+VRqYYCEe9JdNA+wGna2iCbLYQSO4vTG4WJ?=
 =?us-ascii?Q?KqO4ZE14PTxXZZ1XD22tGCFVjxCe6eEz6lkMd4Ra1rczwJEcnJPdIiRVpYDd?=
 =?us-ascii?Q?/LlJ9kr/SdWnpqf0NCyAJXBaf+yzjiNba4uHMNRzlUSnymoBHstLUf+vHwcf?=
 =?us-ascii?Q?4NOqM3QPMYW8w5B+u765plKHasXyqgAam1BUy4rlOcvs1+dHNxFLtaBz62u+?=
 =?us-ascii?Q?1gmjvFh10n85fTG599u7d8UnDmmAJJ0YqOUF+HiNAC3LcxNla2AigSBxKYhr?=
 =?us-ascii?Q?4gvuEYfEiIldmbzDbEQSbzqS4LZjcr+WMITqxJvWBO6MIBANQjTDMnxcgjwY?=
 =?us-ascii?Q?NzY/PmGvG/Tm1fEkO3Jm4DFMS9oMdiaMu1dIq3/5QhTGCtLUrkQLIApr7izZ?=
 =?us-ascii?Q?/NN5JyAcDz0Vc6dMLcfzJy+CWamRp49QvkEiPP4T/lMTNKCbtxZiOQceFJuZ?=
 =?us-ascii?Q?EvkGo6iG7D9GBVxyAs6d8W98Iu3nDANOf/QfLhA+eDbBpsXYZEASLYvqTPes?=
 =?us-ascii?Q?e0ctw/LTJqau88/r0OKUsYTn92giXmi1j6D2NFMmHZpZQiPAb+Y+kpHByw+A?=
 =?us-ascii?Q?BNyJQPdIAPFycJIz2e0a4OPPOvsYM0/WPsNZuPZ69vgyjYWa/Vder84EC6zs?=
 =?us-ascii?Q?j5rAGv4RjCkPvM6dnapvNbQTyOKy07997/RT78qwYNB4hUpJp/xfbhCtMPOB?=
 =?us-ascii?Q?qZm5D9cgsacuqUaOggocoPBL3TjIjCmfp0zR7fdWNiwJ5g94dmZ3BQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LT0ocTRzX9Z4dIMu0B7Tz1Blpi8WMeVDHgRcLs5j2yAWBOYantVnqmIL+iur?=
 =?us-ascii?Q?FkR/kbZ+Zi48hHkIy+ASX+J6bDaAxgvEbfoEQP9TGU8nemwhnj5AyBxBiujz?=
 =?us-ascii?Q?KqIcaM9nM3Or6FjYxKwAWulbSHGnaIrT8nVvOIGxUzRWxKj03tm63EjQwAAb?=
 =?us-ascii?Q?Vg3saMP3JVpI81EP0hj4uty9xGSZujxntY630qwJQCDjGoXrBcmk/NfTImP0?=
 =?us-ascii?Q?bVxpPF97inNJtQcuLhuCWDhjhNUS4XsTWSlt+tdA5e6K4GBhVQ7+QS3ipN2E?=
 =?us-ascii?Q?YLJEwezGbL7ch4E1/6H+Gw+Wfq1qeEwUA+/OMHwPQrZEIYWEEmApJ6AnvVeb?=
 =?us-ascii?Q?Fl8eJU449QPRyoHColbYeIK8hYpWivyxfyiz8XTutQoobirepwTM2MY5XTL5?=
 =?us-ascii?Q?3H2LCKP4PCPFh012vaNy/vFP6Je+LoXwa7+HF4aT37HRD6Uveif5YPkfNBgW?=
 =?us-ascii?Q?AnC7l2Ffc2ghF0n2VjmUgm/mC/s/KAgCiKx37HoeBK7VYW4JQs7kFDoLRweC?=
 =?us-ascii?Q?exH+Xy2oXoQWMO19V3by0cCnVWSh2No20VwrG9Zf1/OrYbBodvW0zKySrD6N?=
 =?us-ascii?Q?Xa/1/KR5+M8Bn25iuU82MFO7FAo8VlS7ZupYXm2NuRNe1fdesX/XSe+aeIU3?=
 =?us-ascii?Q?WsQ0roZnXJdyNctDzI/OBPHOMx3Mjaiy8bAlVHDXYVEcb/jOnIdYY39aaPze?=
 =?us-ascii?Q?YxZkcqZTHDI9uzZZDpRvYPN2dK+/sVcjFpJRC1vaKgGVENhA4JcpxBXamrKV?=
 =?us-ascii?Q?OxxeX5gzbepKcTqpswe3HaniHkmBqxNUNwnFb9pRyOQsmuWjpKHIK+93zn5H?=
 =?us-ascii?Q?GqTOa5d9Ohuhr+kPFoQX7vW8J+KjYzQC5QnZK6wx8otsrGh2c8WWDlm7VNLP?=
 =?us-ascii?Q?neUj3e0OSEplMH41sQFZ9bLEdyeL+xeIkGDVgwWKaFY+moC21ZpKTdc8WSzv?=
 =?us-ascii?Q?yIt/DZn15WY9QaF59iuzDWv3qLTzEIOuvx18HuUvwv5P4E4a2L21LIoZdLni?=
 =?us-ascii?Q?XK59KWhBsipDld3ekz8ucA61Pli/adQwFVOqDTQiPsx5CB0BaIiqQdqt+4Ry?=
 =?us-ascii?Q?4so99EJwW9Qwai2U4UIDBuvJyttJiNuWTTrt0KjME49QAgeImj1+mL/N+fa9?=
 =?us-ascii?Q?8neHyK80ZjYLnSUoVPi4CNxpUJnvib1BybPXRFby0hORstHjVZK1UNH9zoeP?=
 =?us-ascii?Q?0LXXc6QiLpyFandlCpt2Ms/ukZfb+ek7FNZdSk0/+ggD41y05n0H5RZSeEza?=
 =?us-ascii?Q?N6dDslBniTdWdxP9Dl8CKyeJrjAY4NoP+jX2w9uboT7w161cPIWmsDpNAIOa?=
 =?us-ascii?Q?LKWeZRQstLjeAXNErvKGVDJ8h2YSecoJklPJ75Qi0P38sWfPDhaCGkuM8r17?=
 =?us-ascii?Q?xwey02HMVwxRDY+x31gK6x2wcc/0ROOm3+N1J27CNU8y3ytK/H0j1jDNIvX1?=
 =?us-ascii?Q?u10bL0YhFUM6MOJFYfKIjzlQtrA8BvSD6bbSvmw0ndS/kYh2i5rpSJyPEIG6?=
 =?us-ascii?Q?6NRLv6/LJi9b/kuM5QbF1yrQF5Os9Kmoii4lfoNm5rEMmLcP09Il3qgXzsHT?=
 =?us-ascii?Q?Rj5j8joxSWckdNs0DZwTbzK/ULG74/Vsh3CAecafqIP2ZEfdjJ3mVFyDhlkY?=
 =?us-ascii?Q?nJLEH++J/NFcfsJY4SCCSeROCSkAWdL9G3OcA6TG8pUm?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb7d663-64c5-48de-8595-08dd91433257
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:15.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxA61k21+1gHv27fnq74mcSM8bYUcwBdSa5ewiHvwBW9HCkFsTPQHDeyxaBpAvp14CwAA1nK8BtqDgR6UEG5HAoVk1AYANRVVqR2cDXdj6FuXsViCLhC9CYi7NtrvWAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Add simple test to run guest code with NV enabled. With NV enabled,
guest code runs in vEL2 context.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../selftests/kvm/arm64/nv_guest_hypervisor.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c

diff --git a/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
new file mode 100644
index 000000000000..7d7b3944e229
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Ampere Computing LLC
+ */
+#include <kvm_util.h>
+#include <nv_util.h>
+#include <processor.h>
+
+static void guest_code(void)
+{
+	if (read_sysreg(CurrentEL) == CurrentEL_EL2)
+		GUEST_PRINTF("Test PASS\n");
+	else
+		GUEST_FAIL("Fail to run in vEL2\n");
+
+	GUEST_DONE();
+}
+
+static void guest_undef_handler(struct ex_regs *regs)
+{
+	GUEST_FAIL("Unexpected exception far_el1 = 0x%lx", read_sysreg(far_el1));
+}
+
+static void test_run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	do {
+		vcpu_run(vcpu);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_PRINTF:
+			printf("%s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	} while (uc.cmd != UCALL_DONE);
+}
+
+static void test_nv_guest_hypervisor(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int gic_fd = -1;
+
+	vm = nv_vm_create_with_vcpus_gic(1, &vcpu, &gic_fd, guest_code);
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_ELx_EC_UNKNOWN, guest_undef_handler);
+
+	test_run_vcpu(vcpu);
+
+	vgic_v3_close(gic_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	test_nv_guest_hypervisor();
+	return 0;
+}
-- 
2.48.1


