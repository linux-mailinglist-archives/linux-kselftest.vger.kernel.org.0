Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8953F470640
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhLJQwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:52:15 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:13537
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244163AbhLJQwL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeTDvnJf5rHc/4ItMhnNN8vN8HPRN4U5oIkUfZDjcNa/i3Fhhk2zVFHR3PgC/QQTtQMAgd5uessvjd63XyFGyVVbtKcCFcPz7j5B2GBFGRSxy0MwWIBs7MANbeJPfmmG4VCZ6xHUuASvI6uHaIFlPl3vBePNzJZvsRxkr5qytkW7+HmDTTquSDOj5zaDUsXBM1am+FJdt4PgVOWaCFb4ZhinvmQOymorKuaZZDXsFVPqwxgwV9+mx84X5qreEub5tC3KqqI22ZLHBaTFthxOPGxwJCm3HUbblQZ/FSoyJZvtkEj2o9Puy2O16jg3jbxjeh+gENYWdN914HwII9Sd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuXkIj6tZLmVl1zci4j02/2OeVXLKmCINcM5BeeJbho=;
 b=L82vrwLecNFgmhMKwBSziXSDj6mzDRvdihMtdAFwSQ7xO1TcS4NoOnyakBsiRiDGieRhFVyw9oMEKbgCbk5TMGPVpBTiF9ZH37FuTUkczM49pvZgJ1mqhbg/hm7YmHMK6oIssvzavkYOMWP6ZOtsVzbhH/3TK4x+oNq4w9L7UTu2l8pWFk9luHXaEthG1PbL6iLYuTccm8AweQK7R9dSU/ddY6HBtbWNyW+ndbkZ4JpkvJB843S1LrVK7RRhy+iMbsgW1kBXukbClWGK00jxyF3bz6+nSRuub78qCUx2VTzxd9Bg6eCmD1+MkLswsfj1QgvULJCmzxkmWf71XN/mTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuXkIj6tZLmVl1zci4j02/2OeVXLKmCINcM5BeeJbho=;
 b=dO1eQVsKX2hgqcLvHn/0OBGkPE4rN7OKayf84PFVhyqJ9y1He8rQuFnQycP1HxxCaqY8FFmX9DNSxWZZ33pF/6nEcA+UmeEdXD8CjraCRbJ0uXEpN5gEaL7xUB6t1dpbBotjq+gOflZR4SNzBOEkjE8QrtQqqivhs5rgqZrRR8w=
Received: from DM5PR19CA0006.namprd19.prod.outlook.com (2603:10b6:3:151::16)
 by BN6PR12MB1601.namprd12.prod.outlook.com (2603:10b6:405:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 16:48:32 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::aa) by DM5PR19CA0006.outlook.office365.com
 (2603:10b6:3:151::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 16:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:48:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:48:31 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH RFC 02/10] kvm: selftests: move ucall declarations into ucall_common.h
Date:   Fri, 10 Dec 2021 10:46:12 -0600
Message-ID: <20211210164620.11636-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210164620.11636-1-michael.roth@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f40fb92f-fe2a-4dd5-b0f4-08d9bbfce699
X-MS-TrafficTypeDiagnostic: BN6PR12MB1601:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1601E452A1B533D28287E0D895719@BN6PR12MB1601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwVQ6uDO5TyNh+t23kxyZ47zxIwp7yS3ZViNYc/T0PfQ/i/ZO/91Di6i66QHxDp8L2dMwdrPnDCvKcDyKWS4I8lGh8/fYJ+LBIXeUnH9ZBAQP00z96l78786Ut5UzrII37nko7C29MRnHvWlyH+cTEjtlmqbX2ymS1DUyyHc4QVp05sgxn9spn+NXkpIyPsti4sJjTsRDFMI0U1ak0uvc+pDzDI0dMrtb8WE8TGFQfXIrgCMxnsiewN1B+4tgJEFS3bd1MWo8sFUMc0Ta8onSUJkEN5OcAQnB8ECWlGgdOGyr9dzOltui5sFsfCNqRGArhSNNbpMZ3CCnrjSS12RSSltJ0IIp/tAt+xzksclBrXUUNGH2TZww2qDlRJ1tYRzJ0YMXkfgHBm7tuktunBZz/CeLC+J4F1iuEA+GNq0ZCbr2Iidt9Iz8WIB9WTx4tDwLVMP74n/VZ+o0U4peHAdOzbwQqzztMU4T1l4axTKPts/px1n2mXYOEfe2+4hfBOdcKILNvjsNZxiwc4EQjgj6WsAia9WMlg4gTTsfij8Xl21xp6SzAol7n15yjLA/POKA22FYNt/soVv1ZPRiABkKuzwraIFz2hz3iYujeJ7BLhEjTi85mkrzFz4YRYuk3sU3UPR7Ptw+xkV8U78V5shq24wdihaYyAbQl1CCBj+WFP2PtbtVqb6/vJzTo5JPdITnzhWNUAN2TaDoCXP5FI7CrTSGek8oNArtYTvANDPd9PvfYPlSGyYDHcOq6ts5tHZ1166iOHphVUG/Nx2mlSTOq0x3wcQ+lZdlDZgvwga/E8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(81166007)(26005)(44832011)(5660300002)(47076005)(83380400001)(1076003)(316002)(40460700001)(36860700001)(508600001)(7416002)(82310400004)(36756003)(6916009)(186003)(86362001)(336012)(426003)(2906002)(8936002)(16526019)(8676002)(6666004)(70586007)(70206006)(54906003)(2616005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:48:32.3214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40fb92f-fe2a-4dd5-b0f4-08d9bbfce699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1601
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that core kvm_util declarations have special home in
kvm_util_base.h, move ucall-related declarations out into a separate
header.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 .../selftests/kvm/include/kvm_util_base.h     | 49 ---------------
 .../selftests/kvm/include/ucall_common.h      | 59 +++++++++++++++++++
 3 files changed, 60 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/ucall_common.h

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c860ced3888d..c9286811a4cb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -8,5 +8,6 @@
 #define SELFTEST_KVM_UTIL_H
 
 #include "kvm_util_base.h"
+#include "ucall_common.h"
 
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 8fb6aeff5469..4e2946ba3ff7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -360,55 +360,6 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
 
-/* Common ucalls */
-enum {
-	UCALL_NONE,
-	UCALL_SYNC,
-	UCALL_ABORT,
-	UCALL_DONE,
-	UCALL_UNHANDLED,
-};
-
-#define UCALL_MAX_ARGS 6
-
-struct ucall {
-	uint64_t cmd;
-	uint64_t args[UCALL_MAX_ARGS];
-};
-
-void ucall_init(struct kvm_vm *vm, void *arg);
-void ucall_uninit(struct kvm_vm *vm);
-void ucall(uint64_t cmd, int nargs, ...);
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
-
-#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
-				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
-#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
-#define GUEST_DONE()		ucall(UCALL_DONE, 0)
-#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
-	if (!(_condition))                                              \
-		ucall(UCALL_ABORT, 2 + _nargs,                          \
-			"Failed guest assert: "                         \
-			_condstr, __LINE__, _args);                     \
-} while (0)
-
-#define GUEST_ASSERT(_condition) \
-	__GUEST_ASSERT(_condition, #_condition, 0, 0)
-
-#define GUEST_ASSERT_1(_condition, arg1) \
-	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
-
-#define GUEST_ASSERT_2(_condition, arg1, arg2) \
-	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
-
-#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
-	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
-
-#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
-	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
-
-#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
-
 int vm_get_stats_fd(struct kvm_vm *vm);
 int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
 
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
new file mode 100644
index 000000000000..9eecc9d40b79
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tools/testing/selftests/kvm/include/kvm_util.h
+ *
+ * Copyright (C) 2018, Google LLC.
+ */
+#ifndef SELFTEST_KVM_UCALL_COMMON_H
+#define SELFTEST_KVM_UCALL_COMMON_H
+
+/* Common ucalls */
+enum {
+	UCALL_NONE,
+	UCALL_SYNC,
+	UCALL_ABORT,
+	UCALL_DONE,
+	UCALL_UNHANDLED,
+};
+
+#define UCALL_MAX_ARGS 6
+
+struct ucall {
+	uint64_t cmd;
+	uint64_t args[UCALL_MAX_ARGS];
+};
+
+void ucall_init(struct kvm_vm *vm, void *arg);
+void ucall_uninit(struct kvm_vm *vm);
+void ucall(uint64_t cmd, int nargs, ...);
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+
+#define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
+				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
+#define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
+#define GUEST_DONE()		ucall(UCALL_DONE, 0)
+#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
+	if (!(_condition))                                              \
+		ucall(UCALL_ABORT, 2 + _nargs,                          \
+			"Failed guest assert: "                         \
+			_condstr, __LINE__, _args);                     \
+} while (0)
+
+#define GUEST_ASSERT(_condition) \
+	__GUEST_ASSERT(_condition, #_condition, 0, 0)
+
+#define GUEST_ASSERT_1(_condition, arg1) \
+	__GUEST_ASSERT(_condition, #_condition, 1, (arg1))
+
+#define GUEST_ASSERT_2(_condition, arg1, arg2) \
+	__GUEST_ASSERT(_condition, #_condition, 2, (arg1), (arg2))
+
+#define GUEST_ASSERT_3(_condition, arg1, arg2, arg3) \
+	__GUEST_ASSERT(_condition, #_condition, 3, (arg1), (arg2), (arg3))
+
+#define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
+	__GUEST_ASSERT(_condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
+
+#define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
+
+#endif /* SELFTEST_KVM_UCALL_COMMON_H */
-- 
2.25.1

