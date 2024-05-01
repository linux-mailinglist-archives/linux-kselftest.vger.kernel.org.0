Return-Path: <linux-kselftest+bounces-9213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A08B8C36
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923321C210AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5812F59D;
	Wed,  1 May 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EH98ngP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43112EBDB;
	Wed,  1 May 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575326; cv=fail; b=jkWIlgAzJqcP/QcIZ5xoLVr6NbVNTDNWv8DPvOsQQgVn1A0ravxmKDP//98k8PHn2LpfrrkWC/wqc5unuCHfXH62bmDX5LxxwR/M4OtwXeF2TrmDhKJ3LF+rn44HQLV2kMA77rwL9LPVKWVCmu/MOg16nV7FM9tYfdSlbz5uG5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575326; c=relaxed/simple;
	bh=OIRk0hD5CPFkm9poMTyIyD+t489GGjZfQk3Lh0eCPcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeT1HJZom2258on/9nRueDBOYK1EkzsKifmgVET61mOglIXgWL1IeuBiEMfRhYjd2E40a2m8LKEI6vbvlcTKrGXv42RwmWlfm83YJZqYiKGsKRjAMouv4N/Sqhg3KEzj0Y4Kouhpc+hxWGQVLGgBPr4rhuIGEpyUwZAT5m8eKBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EH98ngP6; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYU3Vsx1g+5SjKFYOJ16ioG5nYIZT+1ROh/RwphdKgT7Xwq9Jplq37HxeYqQ6G3aNFWbIa+IDVZ54o73h+fZwiBGVup37uinTY8d8MwFR0+bdcVWe4JLX9GVTpnNsScnkhdNdfHndqOdqOlmASnTayeY7tS4/kMGZ6rmFZ7YB8lyIBgyFCv/PxLKOpEADwb1DaPUejYXPV+KvqYsAOkE4oM/U+yu5Nlz0ENBY3lmC1EhRhSOKcbvvsVFZiOOE1/NEnc0CCzyUrS3AAPWWu6mmofFbjb5zWmRp6rr08u0gYaKj1C5Y5pgWbd8mqetese7OwpMBjzC0RlyJo3aCj0wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uixHsE91hXyDexiFCZ883Ml19yfeOsfqf764919pxd8=;
 b=O6o+spZwZ95A3U5U91SmVMB3ZgQGq9TIi8iDiLOZOPGOhydVyeNjWSzJMc3EfIuurgVoXErtFHJ77EHEv9NgM4QedwDMwD+dvHP34gttWS9oiAH/VS2mr270yzO4R4cky68+czTJ7B51dmJxwx+By2/9AQlBbdvXFOVd48EkwBV9YchFqqoMUaBvhKLDTWeW5Z94qHjTSiFrG3u+YkjfvJHL76yOXmJKKWNaeRQ2IBYxs+gluLAJMajj4cK5PefixREq7aOJvCOtJVmwe6scKsjQp9hZaWaXyGsnUB7wBxTB/zVBcGCvhZYRkoIcUR4NGjFAqmcGaCX7SaTf2D9KEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uixHsE91hXyDexiFCZ883Ml19yfeOsfqf764919pxd8=;
 b=EH98ngP6qGKAjiSgO/OyG8FDjAgvYUVeyi4JxGWaIkY0Vyz3tsfAOn1ZSghszjvB+A6ETBEo5rfAKqRRAq91Ln6vh+KmNqeScT779sU7sc0pIw2Y7zZke9KnFiaxgb/2/w1ztXDdp5MLi4b43Qz/+RMdVFJpVsfGT/Mvm9BQUX8=
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 14:55:21 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::31) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.27 via Frontend
 Transport; Wed, 1 May 2024 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:18 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:17 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 4/5] KVM: selftests: Add an interface to read the data of named vcpu stat
Date: Wed, 1 May 2024 14:54:32 +0000
Message-ID: <20240501145433.4070-5-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501145433.4070-1-manali.shukla@amd.com>
References: <20240501145433.4070-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 135e8365-1a98-4b2b-cfc6-08dc69eeb7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?677r4TRiDcCp404V48Nrc5UsOeZxi00emaC7f4kTwe5PDmJ527K8i9SK/YmH?=
 =?us-ascii?Q?cRzBJzjv7PURytwZDid2Aa1hXaAOIdv7AmgYdwyqTTd+9Qpq5ENlsSqxPFKi?=
 =?us-ascii?Q?xJdDH1OGA+lBY+cPkuSraD06jLXM5AqLjtDpd6130pru5qQMbSOpVx3X5wrL?=
 =?us-ascii?Q?IE6RF8BShLK04mrIlddvs0AytFyHdfl40U9npwEvQ0UI9uES09zpmhdNNSTF?=
 =?us-ascii?Q?1TVXU6wk3JX4mbbLDYjRlTTwL576RTRrmjX5Cn+FDrPTRcAl/fDtM3QIfFsu?=
 =?us-ascii?Q?mvPcNmEdGyM1k4WPCwWrG1PwSND5Nb7StPRpGV8P+EazjalVdMLKeKdtIaVX?=
 =?us-ascii?Q?bzKEtgCMLmSay1WoS9mDENc1lAVp3c9DiRhtCP/9w5x/Ne1hbuIJ6O1Qacng?=
 =?us-ascii?Q?BPOmR2T/NkqCVsHZPvRFljN4DxNh65i1xW5w2/pNCc318FCjVGgTxaCBUlK+?=
 =?us-ascii?Q?q/kTvXs0rgbb1NzZv5qVDjzghtq5wT7HOt8Kja9SswCC+D4kiILJZjai6s4C?=
 =?us-ascii?Q?tkPQiU+f8HQRZKw5dUEKfRDLu3HtIjGlE7HuixpSauaOJtSA18kFhc5V4wEU?=
 =?us-ascii?Q?sohr+86IpteLco/dXnVsG/JYQxFviAB8KYLig5SUvpbsJynZ9dJ1EeQRN9mB?=
 =?us-ascii?Q?OsSdWpe6iIGI5j2hDT+G+P8czgBMk4s5O1xUyyVDNfIb0SIA38KiQVBaxjEg?=
 =?us-ascii?Q?rkYNHGliMJ/hfDBVt37FYaIyCKDI7YZ5/dXs+m4jNbQue51pXOklyjBALLxY?=
 =?us-ascii?Q?RXRfKntxH/DkKXcTu69OQ3Ok6irNqaOfZ+Xoy4+b9Je6bTw0uICasQNE7Pa3?=
 =?us-ascii?Q?PfVqnNG4NmCl28wXYel/EH5+F+2Fo0LpXbRdng8gp+2QHTWg6Jl0SkIvbAOD?=
 =?us-ascii?Q?RHxUezC9y1gAE6kSOdEqCWHnoBPOs+dl0MkcX9q8RTFYz4/19Tsi4tcaa/Iw?=
 =?us-ascii?Q?o5fh1PatY+r7ESbApCBB4r10iMqVtF9et/01ukXb62kHEKq6R785H9R0Kpur?=
 =?us-ascii?Q?PjHLlEbLZXjG8uTQU2SzWcLAInW7DCvBRBh9lKukhfMqx0kj+wJjoWmAUf5b?=
 =?us-ascii?Q?ZGpDQoeH5D5xAMeLUDvCRRDa7lF2skMHS1m1USALqnkedlLc6uMvEHyfrGnD?=
 =?us-ascii?Q?NsFyLDH2IfVub/OQtHFiNOgWK+BbYJhP9vtumonYhRonhIn9Zyetq9GER/lA?=
 =?us-ascii?Q?RmSEa7jodoZ/gZ7A6uEJjVyo3lCEZbBVc7dTqMPZfug9SLurU0fkQKkYd9AC?=
 =?us-ascii?Q?it+mereaQSMvkH4xA+3Un8NHwJxUxe4tKF+Peq9if5Hfaf1booHtTZaD+ZUT?=
 =?us-ascii?Q?NW0l9VLb6yZ1Ab1mbUWCtEKRjB41ie3gYlK+WWf52XsNsAjizZNL3bwmeTr2?=
 =?us-ascii?Q?XtlPidU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:18.3045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135e8365-1a98-4b2b-cfc6-08dc69eeb7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

From: Manali Shukla <Manali.Shukla@amd.com>

The interface is used to read the data values of a specified vcpu stat
from the currenly available binary stats interface.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 66 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++++
 2 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 63c2aaae51f3..7dad3275a4d3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -518,6 +518,72 @@ static inline uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
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
+	PF_TAKEN,
+	PF_FIXED,
+	PF_EMULATE,
+	PF_SPURIOUS,
+	PF_FAST,
+	PF_MMIO_SPTE_CREATED,
+	PF_GUEST,
+	TLB_FLUSH,
+	INVLPG,
+	EXITS,
+	IO_EXITS,
+	MMIO_EXITS,
+	SIGNAL_EXITS,
+	IRQ_WINDOW_EXITS,
+	NMI_WINDOW_EXITS,
+	LD_FLUSH,
+	HALT_EXITS,
+	REQUEST_IRQ_EXITS,
+	IRQ_EXITS,
+	HOST_STATE_RELOAD,
+	FPU_RELOAD,
+	INSN_EMULATION,
+	INSN_EMULATION_FAIL,
+	HYPERCALLS,
+	IRQ_INJECTIONS,
+	NMI_INJECTIONS,
+	REQ_EVENT,
+	NESTED_RUN,
+	DIRECTED_YIELD_ATTEMPTED,
+	DIRECTED_YIELD_SUCCESSFUL,
+	PREEMPTION_REPORTED,
+	PREEMPTION_OTHER,
+	GUEST_MODE,
+	NOTIFY_WINDOW_EXITS,
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
index 6b2158655baa..3de292ca9280 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2256,6 +2256,38 @@ void read_stat_data(int stats_fd, struct kvm_stats_header *header,
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


