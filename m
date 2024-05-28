Return-Path: <linux-kselftest+bounces-10756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0828D1343
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 06:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7981C20E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 04:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4511D68F;
	Tue, 28 May 2024 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YU2KtLMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F199B9;
	Tue, 28 May 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869987; cv=fail; b=IKt1v2wktjRkv+1Rmxx1Tt+mrD4yovFJZcQVsNbaFN/heYsZN9PfMHDvUc6SPkWIWBifEHTh7v4etl6tIZ+mjFNARXPB0K2OjmEw+Y6g3B4Gzn4MILIS9aHaxmJwwE91K560nk7SJnyqDhhfk02C6BU7S4HMIVFS6g6KaeGQWs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869987; c=relaxed/simple;
	bh=vdWv85wKkf5qMxZI2VPjUaqBY/Rnfh+MkH1wqv6bfyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBcQQQokzNM82cO+Fs3DfOVq6vJwm/6YXz4ievfd3DxD1uEfMQ8ObhKzVwdWOjmPsupoEMuTNUdmlNuSrhQm5EFNh4x4D73zLAL7dQcj/OW+D7kwI9/X3V6ucvX1EqXQGi1nzUpaommAdXiS8qL4UfeR0OJ0jjnLdDDleZqs5Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YU2KtLMl; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxzWLLiw5e2PAee6z5DgIGJHmGfC1fhlPKNn9fxtW933HINFyUsvO28LdyBRWohRcC7jcY6GURi2JrJcfR9IOgNOIYDXQMW2QwSqAlY9fLwcx3zVtHrknHJZILXXQoIkEzAJgQr+jq688JKopVC8wWgyq41Uua0c/yeARlicaGz6/Gd+s24THsPdeoib7z9dpleTkaokRnodIW4fUtN/QAwd2IRahCSYHkHfM6xnQFgg8DKxVPOz8hmGRD4sfHknDVw9UnA85Iv6ZLj3yYbitbZdeToNONQbd7dql1tKjLfm+EoIe43OtoUMCmIts2Wbs+RBd4tvzZCcfPNTlrJySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fRdkaASirapCelzeWYERjJ5QmVerDinpGOSsFFnlww=;
 b=PjdV/zeEglp2Dev8fowxM8qQxWAEx1QKrDDwOXGXWSgPmZmHwgKRXtUH2ztb+5lMn+WkK7nOjXtIc5bz/61su+EI1mK2msXukH2rhTPK01vvq1l10pDGsvl3JJnJLRUe5qpMoyjMzOYxBshfERTZ7gKPbBhomfqQCzdGggDDGJb/uyB2J66lIi3yEGtgn4NVvAcqYhVlVyBNv2NBCpcBDMAbl1fDoBT8xn6dYp+bP9ppuQqdbl/6Cs3/Fe5QIyGrjUIqQgllnmsVxwYg6S8B2S0jsvlazHOzj4P9I35fqDy4FRA1x9nu9xEsCblx3l8aU9hCFT4yAv3msbqtFIh5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fRdkaASirapCelzeWYERjJ5QmVerDinpGOSsFFnlww=;
 b=YU2KtLMlnW3be2IujUxhJ0I2oryd/0I/2m5/+N4fy8/b98TGX9N+Oy+J7JVFbrLYy9kRLuAUfgy3Msm3hEYYEZ7HDBJ9gQ9Jz+QubGFwt5cAASUzszc93ABx2J1N28VuIOYpQ0mNBhV44nDQxk1aYMi30QHNiwct41kPHJaxCHI=
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 28 May
 2024 04:19:43 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::8e) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Tue, 28 May 2024 04:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 04:19:43 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 23:19:42 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <ajones@ventanamicro.com>
Subject: [PATCH v3 4/5] KVM: selftests: Add an interface to read the data of named vcpu stat
Date: Tue, 28 May 2024 04:19:25 +0000
Message-ID: <20240528041926.3989-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528041926.3989-1-manali.shukla@amd.com>
References: <20240528041926.3989-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 365663d0-da46-4e52-7f20-08dc7ecd669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3QcCaMpfvMosn7Qaj0pMqVW4I1ixqveJdE4MpxoJIeVPcaLrmNIZCyP1Eul?=
 =?us-ascii?Q?8K8VFEtZptb9k3y1pG7xYR0XVM+90DAAWVZXs8SIG3JGPScFjmuge6Jz4afb?=
 =?us-ascii?Q?iv5zzOnbjlgDlPMhVQLBp9pedgElNTSiThR7uuulp88UVVWJxs+N8qx1Kf9V?=
 =?us-ascii?Q?lZDGjnmzy1nXvMYrKBXpjeSGgy+VSsRnPnG4g7wiRsK8nl0YZDtd/uqCjdHU?=
 =?us-ascii?Q?voaewbHilH4Wa1DAwTDtNdBsQm7+RcS4mTMWqcsX2omY0mOMiVtTR4VdHEvw?=
 =?us-ascii?Q?ioPFle2yOj2Drbq7ImtqT77gJRbiOmk2vDxsilFGxTW2HKsCcP+CR7eVH7Gy?=
 =?us-ascii?Q?8IsxRME9eLRZmMAg+Ik546kwKsWu37JskXN4etcq9eoVw1MuSx5v+BLtVCtE?=
 =?us-ascii?Q?GU/Nyph6/nFNTFTahyOFZX+NbVN/Tugh2o+yojghYWpYxMs/F27kHxP4iRFo?=
 =?us-ascii?Q?nvlpIyXQfKSy0LZEWxgCACezZMbdKC/0wkUvfSZq9HRnr2uDgnWnjOJqVkzZ?=
 =?us-ascii?Q?eAjfDwJ3XV0Y0vrK97dPfVlPVO4mRKqFdpXGek3wo44pzw8CL1KL21V5Pyt0?=
 =?us-ascii?Q?df+mwBCdLpFJO9hbdvMk8TFHG9QZzTX6gieOyvwQucakp6yTNYpAO3XrUBQm?=
 =?us-ascii?Q?bNIjlmt3lecx0lziG0y8d2j6Z0yAoQEhuyeqe0A/V3xyOAjWzXM6PGfBpwVG?=
 =?us-ascii?Q?f5J4TM7UzrMpiOYbxHSscTUad3x/Y7ukKK+KVgJRuhKkjx3bKCX4IBvGQ1Zp?=
 =?us-ascii?Q?1gnYuzRHMR/0v6HjUSudo92HtLeCdsgZcV3oShhoWrdv9NntFV4XLd5KQR3Q?=
 =?us-ascii?Q?+4A1n3OaUkkys7ngXQ8WtI/wg+WwbOz+1AZofKeExlaLAbc1xqKuoAm2jdYY?=
 =?us-ascii?Q?xQIw87gX1H2BLulzk2yMot1j8O68sHwrFSjFFZ5y04XjBJAfa1aUQjGJpYqk?=
 =?us-ascii?Q?bfzdtAtrqzLO9oQNCs5vSdrAd0BZ/L4HEo6vcI49U0rb/Egc58q2fJ4rMIVw?=
 =?us-ascii?Q?7zbomY1ms0/msW5MWQr2YPT7Z3wQZKzBDsuQoJEOxxWzw6oc/LKIO82sRGCu?=
 =?us-ascii?Q?0JPWnnbvoapcPLLmZHsTvl2TZ+M3nQ0HgoI8GDWF/Yzot/lxQauwN5Ex5toa?=
 =?us-ascii?Q?QfZ6N4SZztkyu3Zgdbw/I2y29s5l/9OrgBuOdUHvVLNgZEAIceFbYfk9YUL2?=
 =?us-ascii?Q?85ykgbidbOSKYTpsNMj4x9Ay66JhxSp3FFq5/d/t6VBu0bQuPw+N9zLi0cV/?=
 =?us-ascii?Q?0PQ9xPK8V1XUmr778dqQEf8YMS9trd02cXeElFkHYSqMtoIPB1rE9dxWz2Zf?=
 =?us-ascii?Q?VELT6tcnz+ismHcGS5LxhqdtWvZYa7IfKD8YjdFz3oWlBYUHINysnAdEEo1F?=
 =?us-ascii?Q?P6nK10M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 04:19:43.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365663d0-da46-4e52-7f20-08dc7ecd669a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

From: Manali Shukla <Manali.Shukla@amd.com>

The interface is used to read the data values of a specified vcpu stat
from the currenly available binary stats interface.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 .../kvm/include/kvm_arch_vcpu_states.h        | 49 +++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  | 34 +++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 ++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h

diff --git a/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
new file mode 100644
index 000000000000..755ff7de53d9
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Arch-specific stats are added to the kvm_arch_vcpu_states.h. Sequence
+ * of arch-specific vcpu_stat_type should be same as they are declared in
+ * arch-specific kvm_vcpu_stat.
+ */
+#ifdef __x86_64__
+#define KVM_X86_VCPU_STATE(x) KVM_VCPU_STATE(x)
+
+KVM_X86_VCPU_STATE(PF_TAKEN)
+KVM_X86_VCPU_STATE(PF_FIXED)
+KVM_X86_VCPU_STATE(PF_EMULATE)
+KVM_X86_VCPU_STATE(PF_SPURIOUS)
+KVM_X86_VCPU_STATE(PF_FAST)
+KVM_X86_VCPU_STATE(PF_MMIO_SPTE_CREATED)
+KVM_X86_VCPU_STATE(PF_GUEST)
+KVM_X86_VCPU_STATE(TLB_FLUSH)
+KVM_X86_VCPU_STATE(INVLPG)
+KVM_X86_VCPU_STATE(EXITS)
+KVM_X86_VCPU_STATE(IO_EXITS)
+KVM_X86_VCPU_STATE(MMIO_EXITS)
+KVM_X86_VCPU_STATE(SIGNAL_EXITS)
+KVM_X86_VCPU_STATE(IRQ_WINDOW_EXITS)
+KVM_X86_VCPU_STATE(NMI_WINDOW_EXITS)
+KVM_X86_VCPU_STATE(LD_FLUSH)
+KVM_X86_VCPU_STATE(HALT_EXITS)
+KVM_X86_VCPU_STATE(REQUEST_IRQ_EXITS)
+KVM_X86_VCPU_STATE(IRQ_EXITS)
+KVM_X86_VCPU_STATE(HOST_STATE_RELOAD)
+KVM_X86_VCPU_STATE(FPU_RELOAD)
+KVM_X86_VCPU_STATE(INSN_EMULATION)
+KVM_X86_VCPU_STATE(INSN_EMULATION_FAIL)
+KVM_X86_VCPU_STATE(HYPERCALLS)
+KVM_X86_VCPU_STATE(IRQ_INJECTIONS)
+KVM_X86_VCPU_STATE(NMI_INJECTIONS)
+KVM_X86_VCPU_STATE(REQ_EVENT)
+KVM_X86_VCPU_STATE(NESTED_RUN)
+KVM_X86_VCPU_STATE(DIRECTED_YIELD_ATTEMPTED)
+KVM_X86_VCPU_STATE(DIRECTED_YIELD_SUCCESSFUL)
+KVM_X86_VCPU_STATE(PREEMPTION_REPORTED)
+KVM_X86_VCPU_STATE(PREEMPTION_OTHER)
+KVM_X86_VCPU_STATE(GUEST_MODE)
+KVM_X86_VCPU_STATE(NOTIFY_WINDOW_EXITS)
+
+#undef KVM_X86_VCPU_STATE
+#undef KVM_VCPU_STATE
+#endif
+
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 63c2aaae51f3..fe66b1736060 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -518,6 +518,40 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 	return data;
 }
 
+/*
+ * Ensure that the sequence of the enum vcpu_stat_types matches the order of
+ * kvm_vcpu_stats_desc[].  Otherwise, vcpu_get_stat() may return incorrect data
+ * because __vcpu_get_stat() uses the enum type as an index to get the
+ * descriptor for a given stat and then uses read_stat_data() to get the stats
+ * from the descriptor.
+ */
+enum vcpu_stat_types {
+	HALT_SUCCESSFUL_POLL,
+	HALT_ATTEMPTED_POLL,
+	HALT_POLL_INVALID,
+	HALT_WAKEUP,
+	HALT_POLL_SUCCESS_NS,
+	HALT_POLL_FAIL_NS,
+	HALT_WAIT_NS,
+	HALT_POLL_SUCCESS_HIST,
+	HALT_POLL_FAIL_HIST,
+	HALT_WAIT_HIST,
+	BLOCKING,
+#define KVM_VCPU_STATE(x)  x,
+#include "kvm_arch_vcpu_states.h"
+};
+
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
+		   size_t max_elements);
+
+static inline uint64_t vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type)
+{
+	uint64_t data;
+
+	__vcpu_get_stat(vcpu, type, &data, 1);
+	return data;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ad00e4761886..d4b6a352c1ae 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2264,6 +2264,38 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
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
+void __vcpu_get_stat(struct kvm_vcpu *vcpu, enum vcpu_stat_types type, uint64_t *data,
+		   size_t max_elements)
+{
+	int vcpu_stats_fd;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *desc, *t_desc;
+	size_t size_desc;
+
+	vcpu_stats_fd = vcpu_get_stats_fd(vcpu);
+	read_stats_header(vcpu_stats_fd, &header);
+
+	desc = read_stats_descriptors(vcpu_stats_fd, &header);
+	size_desc = get_stats_descriptor_size(&header);
+
+	t_desc = (void *)desc + (type * size_desc);
+	read_stat_data(vcpu_stats_fd, &header, t_desc,
+			data, max_elements);
+}
+
 /*
  * Read the data of the named stat
  *
-- 
2.34.1


