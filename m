Return-Path: <linux-kselftest+bounces-20233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A49A5A42
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FDF1C20F8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71AC1CFED1;
	Mon, 21 Oct 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JWWROcCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0EBA27;
	Mon, 21 Oct 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491878; cv=fail; b=D75MICN0zxNUW5yjsmKmSSviecIVZSf2NG7/X5w4r/Z3pjR+Udo7Y0s4UtJs1UnEycaZOKww2NP7hiQaTXGIDCaMBzpNoNzwJNvhYOBbJHnfOB9tVOsgr4U2umjhm8s8K8v+EFnPPOmz7tC5xjGe+jT3+UVGIFs6jg78z14a0Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491878; c=relaxed/simple;
	bh=JA4rZrHAdDI6B9C4XI7I4TI5z7jmh9LATs4CwTYF52s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ+u/4WYoO0bXERLEPRTajFoILIiFhOgBSRa70vbfEqCwhFH3KHN46mZvU8WL3h2z9nGeOQWtYXgRI+gRvtpB8XvYlTXb5TTV8IWzfo3HmDaxYF01Tfi0A86xdj+vSOOnzULDKULhrHUJBrMUjct3N5KwbJmaJCSc2qFJCv/GKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JWWROcCT; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBYmfmvqWSYBYD6vMXku9CZOmUnq4zk+7eicOFSQcWrMcB9R9p8h+K0u2dfvASJQK/PTAOnLPEQCEoA5eCtXKBcQO6k0ZCp2E4mz1fXJLnh5nRqXKr4Psxpy++pnlxhUZamAY/hIHSLl3+Ep+icVK2ySStikxzrlk+2K4yrXaDAVFP4qngnWxsrqAtkW4YCAXg7T+EjoswCGRsk2eNgMpjUgi0sp+FzPYW/UvulyFiOActgEvl77Ezb3+6MVRKY2/9Pn09PM4EHlycG9agy5M9++rKghzOY183BIoWrJhMnyKLlNKFSJO37bgBgVcJHFLvzgPRVz3ieG3dF1DXX0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szStCUFv/aYYwCvuT3Xvfxk5fSKxke5/5su9L/eNTNo=;
 b=euQhBQzsEYrqcqzMH6I4GukGoWHJ1zYfbJj71HLbBdC4Fkuv6rQahSXIyS+ksDW6ourcv8pcDM1Kwe0rSUZEiNQSHqgoGqB2M2Qtl3OC0bAossNzipn3U4Ym7S/uq3JR30uWacEvcOyCGtnVFXfAmEnX6qsqatFRCnu9rgHVqKOMgihvV/ROxmBBpx0qsWnmDj6l8VxJxFnKEzDiKmjlPhCPvU2KpcvQniW2fG/9ss9oLaH7nEZmU3NQuw6j7yG5hWCrjhQSiukVrkzCjxI0+WezBOzsjgEiCZh6ug9FlYUbkoiPDh3NGLofoZ1dl6uJN8FGtEh2IuGlGdlYpmVgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szStCUFv/aYYwCvuT3Xvfxk5fSKxke5/5su9L/eNTNo=;
 b=JWWROcCTkbniFY0/MWhV4G2PPUK3NZwFYQjRK4I/Oq0+xpEkSm1EEHHWajcntyD+T9rJb8Q+tP8p4Nk2nM3OPMlI9ACHL6xXxSmz3o9jpmFE0bGEIm0lJXH+D4Bfm5cK1lTdHr2/y+HVi9KZQO82BnkI28qd15KLmy1DCRbIrWA=
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 06:24:32 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::7c) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 06:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 06:24:32 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 01:23:43 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <manali.shukla@amd.com>
Subject: [PATCH v1 2/4] KVM: selftests: Add an interface to read the data of named vcpu stat
Date: Mon, 21 Oct 2024 06:22:24 +0000
Message-ID: <20241021062226.108657-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
References: <20241021062226.108657-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd1e347-5826-435b-415e-08dcf19906c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2+r7DS/VU7Nmo0u9N/WxwdouDrxwqiEysimSl2ZSCqbEvwyJs1oNcEX9PQAo?=
 =?us-ascii?Q?uPuHIO0TlpWK3QqvcN2bJ3khVyVZJZF7KUfWN7A714lh9Ug4u6plpRbRXFBL?=
 =?us-ascii?Q?YtBAuqF3HdaRT56lJtyRRS/uOsb/XfW4hsuCosy8p3vQaZTV6j2bHzgN8DXG?=
 =?us-ascii?Q?8WiB4V2v43fvMjkThJiXdln2FZ+R5VxT/Hne5TD2wC5lduK7/RdUOfS2Xup1?=
 =?us-ascii?Q?zKmXmINbNS7Vgihfj0ovbKLj4tMhJxZ/PR8ceXA0hcEjVw5HHv+0Mb9fGSmG?=
 =?us-ascii?Q?F2u3uxSfAQdabSzh9crzD2GSFs7qvID84DtNtOk6bEBAWXzNDeJESmPYQUSp?=
 =?us-ascii?Q?ox/a+pgg3i1G27/U/cJQ/Q5dfh28K2vYCFerBMI4eEKLmfXF+u8/z2+L2IuD?=
 =?us-ascii?Q?c5A3S+SiEdj7mSyFFaPf6M5p79PIa5atl+BJMtoQPDqkJUr1vqw+TNYZeukX?=
 =?us-ascii?Q?DJlSdltHv5qPVvNhik8UgzDr1LTX4OihLOjQcI56cEL1Z5mV1HzNLi1Cjlr9?=
 =?us-ascii?Q?UP8zXgQYAG1ySiTStcYVlCplngMshrFMD5Jt2xauY5Z84wXRfm2O+HnbazTU?=
 =?us-ascii?Q?KeM9xYVkmgGQ0ffbON5yJcC0swKJQi/3P+XCEOT8eacLpCje+FuaVlzUMw0q?=
 =?us-ascii?Q?jVIPhdKZtOkUH+5wsrBIxdPnpFhb96sP2kH4VJ0C8PTaMleK1PX+6DdUiW5P?=
 =?us-ascii?Q?xx+CJX6WJZgEaWWoCcBS6sMa+ppku2t0K4bSQbwc9tZqUop28NRcqBomiXcQ?=
 =?us-ascii?Q?K+1PNMBEFe4nv/mC8R5kO56lXV+1TDYYGv2sv7UILbEh4rSnWeac+j0E+ACd?=
 =?us-ascii?Q?4YQxdhy5TR7F2ruoTuwsD5bEXbFmCxA6lG60zc9gh3pq23H7JLsQe/iv5fO3?=
 =?us-ascii?Q?K+ifhJtAJgCLoYdFPHcuBHZxvR+X3rILgcA77LhMRFmcMLDwaXVF8f6SXG4N?=
 =?us-ascii?Q?LV9gC22W7LOFMsesE+p63Z5CcyC1Mb966DbHNPhrtic6lRqHWSpweH1qqmfL?=
 =?us-ascii?Q?eNA+8T1VQeE7xAjJOJyVVxQWon1dM7yF1ZHVA/wc0qZO4ZlwpRNgdOocgNbd?=
 =?us-ascii?Q?qeODkAdvBmMGFKQhQ7rUyjB63uLX9FocdVDYlVx6qcop0anHYknKI8auFdb1?=
 =?us-ascii?Q?hsDPh9aFb6fBivwCoqLgm4v2U9t07ECG3hATAOOwxiZmqYf8dZlg4zZHfdn9?=
 =?us-ascii?Q?wqne8bMu8dBZ6Sa/Rsx9f5O0vidfGx1ItPBQyQKIGysz9hYI/PURs76lov4c?=
 =?us-ascii?Q?5Tu6Ogw6+oCrBlDlYZmb+aWePJ0xxvL+YgRiisdAhtWsb+u607N9stniAh7e?=
 =?us-ascii?Q?iPFBMJC0aAI2Vznh5LT+TubhPzBNMCK9/ZiCN5GO6j0gzNACQDoouFXr5AMg?=
 =?us-ascii?Q?6bVqHDWf5ooHXYYE+hp8msQcRWet6VeWOnjnWYyYdJ8siyah9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:24:32.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd1e347-5826-435b-415e-08dcf19906c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

From: Manali Shukla <Manali.Shukla@amd.com>

The interface is used to read the data values of a specified vcpu stat
from the currenly available binary stats interface.

Add a concatenation trickery to trigger compiler error if the stat
doesn't exist, so that it is not possible to pass a per-VM stat into
vcpu_get_stat().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 52 +++++++++++++++++++
 .../kvm/include/x86_64/kvm_util_arch.h        | 36 +++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 40 ++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bc7c242480d6..5dd3acf174f8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -531,6 +531,14 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
 		    struct kvm_stats_desc *desc, uint64_t *data,
 		    size_t max_elements);
 
+#define DEFINE_CHECK_STAT(type, stat)			\
+static inline int check_##type##_##stat##_exists(void)	\
+{							\
+	return 1;					\
+}							\
+
+#define STAT_EXISTS(type, stat) (check_##type##_##stat##_exists())
+
 void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 		   size_t max_elements);
 
@@ -542,6 +550,50 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 	return data;
 }
 
+#define DEFINE_GENERIC_VCPU_STAT				\
+	DEFINE_CHECK_STAT(vcpu, halt_successfull_poll)		\
+	DEFINE_CHECK_STAT(vcpu, halt_attempted_poll)		\
+	DEFINE_CHECK_STAT(vcpu, halt_poll_invalid)		\
+	DEFINE_CHECK_STAT(vcpu, halt_wakeup)			\
+	DEFINE_CHECK_STAT(vcpu, halt_poll_success_ns)		\
+	DEFINE_CHECK_STAT(vcpu, halt_poll_fail_ns)		\
+	DEFINE_CHECK_STAT(vcpu, halt_wait_ns)			\
+	DEFINE_CHECK_STAT(vcpu, halt_poll_success_hist)		\
+	DEFINE_CHECK_STAT(vcpu, halt_poll_fail_hist)		\
+	DEFINE_CHECK_STAT(vcpu, halt_wait_hist)			\
+	DEFINE_CHECK_STAT(vcpu, blocking)			\
+
+/*
+ * Define a default empty macro for architectures which do not specify
+ * arch specific vcpu stats
+ */
+
+#ifndef DEFINE_ARCH_VCPU_STAT
+#define DEFINE_ARCH_VCPU_STAT
+#endif
+
+DEFINE_GENERIC_VCPU_STAT
+DEFINE_ARCH_VCPU_STAT
+
+#undef DEFINE_CHECK_STAT
+#undef DEFINE_GENERIC_VCPU_STAT
+#undef DEFINE_ARCH_VCPU_STAT
+
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
+		   size_t max_elements);
+
+#define vcpu_get_stat(vcpu, stat_name)				\
+({								\
+	uint64_t data;						\
+								\
+	STAT_EXISTS(vcpu, stat_name);				\
+	__vcpu_get_stat(vcpu, #stat_name, &data, 1);		\
+	data;							\
+})								\
+
+#undef DEFINE_CHECK_STAT
+#undef DEFINE_GENERIC_VCPU_STAT
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
diff --git a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
index 972bb1c4ab4c..3cdc3c856ed2 100644
--- a/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
+++ b/tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
@@ -48,4 +48,40 @@ do {											\
 	}										\
 } while (0)
 
+#define DEFINE_ARCH_VCPU_STAT					\
+	DEFINE_CHECK_STAT(vcpu, pf_taken)			\
+	DEFINE_CHECK_STAT(vcpu, pf_fixed)			\
+	DEFINE_CHECK_STAT(vcpu, pf_emulate)			\
+	DEFINE_CHECK_STAT(vcpu, pf_spurious)			\
+	DEFINE_CHECK_STAT(vcpu, pf_fast)			\
+	DEFINE_CHECK_STAT(vcpu, pf_mmio_spte_created)		\
+	DEFINE_CHECK_STAT(vcpu, pf_guest)			\
+	DEFINE_CHECK_STAT(vcpu, tlb_flush)			\
+	DEFINE_CHECK_STAT(vcpu, invlpg)				\
+	DEFINE_CHECK_STAT(vcpu, exits)				\
+	DEFINE_CHECK_STAT(vcpu, io_exits)			\
+	DEFINE_CHECK_STAT(vcpu, mmio_exits)			\
+	DEFINE_CHECK_STAT(vcpu, signal_exits)			\
+	DEFINE_CHECK_STAT(vcpu, irq_window_exits)		\
+	DEFINE_CHECK_STAT(vcpu, nmi_window_exits)		\
+	DEFINE_CHECK_STAT(vcpu, l1d_flush)			\
+	DEFINE_CHECK_STAT(vcpu, halt_exits)			\
+	DEFINE_CHECK_STAT(vcpu, request_irq_exits)		\
+	DEFINE_CHECK_STAT(vcpu, irq_exits)			\
+	DEFINE_CHECK_STAT(vcpu, host_state_reload)		\
+	DEFINE_CHECK_STAT(vcpu, fpu_reload)			\
+	DEFINE_CHECK_STAT(vcpu, insn_emulation)			\
+	DEFINE_CHECK_STAT(vcpu, insn_emulation_fail)		\
+	DEFINE_CHECK_STAT(vcpu, hypercalls)			\
+	DEFINE_CHECK_STAT(vcpu, irq_injections)			\
+	DEFINE_CHECK_STAT(vcpu, nmi_injections)			\
+	DEFINE_CHECK_STAT(vcpu, req_event)			\
+	DEFINE_CHECK_STAT(vcpu, nested_run)			\
+	DEFINE_CHECK_STAT(vcpu, directed_yield_attempted)	\
+	DEFINE_CHECK_STAT(vcpu, directed_yield_successful)	\
+	DEFINE_CHECK_STAT(vcpu, preemption_reported)		\
+	DEFINE_CHECK_STAT(vcpu, preemption_other)		\
+	DEFINE_CHECK_STAT(vcpu, guest_mode)			\
+	DEFINE_CHECK_STAT(vcpu, notify_window_exits)		\
+
 #endif  // SELFTEST_KVM_UTIL_ARCH_H
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a2b7df5f1d39..3ee84e117a04 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2195,6 +2195,46 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
 		    desc->name, size, ret);
 }
 
+/*
+ * Read the data of the named vcpu stat
+ *
+ * Input Args:
+ *   vcpu - the vcpu for which the stat should be read
+ *   stat_name - the name of the stat to read
+ *   max_elements - the maximum number of 8-byte values to read into data
+ *
+ * Output Args:
+ *   data - the buffer into which stat data should be read
+ *
+ * Read the data values of a specified stat from the binary stats interface.
+ */
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, const char *stat_name, uint64_t *data,
+		   size_t max_elements)
+{
+	int vcpu_stats_fd;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *desc, *t_desc;
+	size_t size_desc;
+	int i;
+
+	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
+	read_stats_header(vcpu_stats_fd, &header);
+
+	desc = read_stats_descriptors(vcpu_stats_fd, &header);
+	size_desc = get_stats_descriptor_size(&header);
+
+	for (i = 0; i < header.num_desc; ++i) {
+		t_desc = (void *)desc + (i * size_desc);
+
+		if (strcmp(t_desc->name, stat_name))
+			continue;
+
+		read_stat_data(vcpu_stats_fd, &header, t_desc,
+			       data, max_elements);
+		break;
+	}
+}
+
 /*
  * Read the data of the named stat
  *
-- 
2.34.1


