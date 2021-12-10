Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26F247061A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhLJQur (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:50:47 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:4192
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243893AbhLJQuq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:50:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JarbS9qgcRge4szO27zP6B/HrlJ2ziphX4nJlfKbN+9sWqEv8rMa9K4OO66PrBjc2SJi7Ylq4BygYO07gSftFHA8J0xRxJhRhh0Xnm03yuRb+rFCT/a/cpVRs5P6RZG856cMpUD6G7XBUkqBF3yQxexQfZIQ2I++p45fB5x3djT614gi8nAFYeWRSigk15RnZ+IY31jtGZq3wKahLCS8JCLN/x9/B+tGMwDWgTlxTyoEfvMHy7QbKYl6OesgX2lVVA2eA03+ExvUL1NYr1mwSCmYeszga3zGzVFP/AzRFABpvhQ8VHYttmSrraXrlERh0v95gEat6NSX4LgzvjJeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFQMga+ozr4yriDnVn5+bwhC0iqbIN5kaimzahgvsgI=;
 b=YUd7Q1iROxpbZJz3HkemFNiNJq+xi8ByP/BDVleos7zjhWog2WzqIJpq0qvbvRgLLlu6+k6sdzN5Trw5a/5VL8Axgrs3/UG/xGlBkds0tDQSu66uVhN0Qvjc0iv06CpepxN1Z3oRK7nlr9kCTJMzBixWzEAfEaSBDmjyPitePVd3AqXYS6V4dh4bVIO26gE3uM6Ahina603g5lkFXFmg98zY/UhhtJ2+K3Z8FEZ5TREgJysHDB0b2RmlLCVyJrfSHzSpXOtPByAlmlU4aKVx1nqI8VjIubDg9oP54BrgNvFqRjBfl9qVBzAXFFeMHE6X1VXpdh/UV4hkMihOcwrYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFQMga+ozr4yriDnVn5+bwhC0iqbIN5kaimzahgvsgI=;
 b=ESBDpsfcNbOUM1BUKfniC5H6cJXBlPJH6y6LduJ0dQlFxzE4E3N/Z/bHe70ob2JsNEUkr87CALLc/Z90ziaa1ZLrizANzWfKrVbTyF9KARlV0sQpEfEQbZv4AIeBlMsfmy0wyLvpmqSGkwHErY07B0VlEkCFiZGs4E27eekmf94=
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 16:47:08 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::cc) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 16:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:47:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:47:07 -0600
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
Subject: [PATCH RFC 09/10] kvm: selftests: add GUEST_SHARED_* macros for shared ucall implementations
Date:   Fri, 10 Dec 2021 10:46:19 -0600
Message-ID: <20211210164620.11636-10-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b25bd00d-6fb9-44e6-01b0-08d9bbfcb45c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB235247FB7B6BD4293A8E004495719@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs8lobdZJsdc6++dNhKS9nUnDyFZtT2DMFyGh1C6hDj7Lc6MBJ07GELq+/2Ca4uLDZ35HkW90xIbK79KbLdEmvwxsBXTODwr4Jwa7cJ+wfyUW45bpjpDpwmahGwzw/qQUODc9m1dw+cHEGkkdAenSxheKxylgo9by1rQOQtNWhjR2Ulyv4VYbkzZ5I6gM3ULto0xuDkzP0jCxT9F3DTgHLWa36vihoNg8FUFQtARnveRyT2dsuwfVMErcUphE9aCWFQDVm5Q1jpKFUpAixQRAT9rASDiOxgNIBpbUUisohLD1YyBVPKTk/n+NSTPUnhvxa5mp7CzL4VWJyNzd0HpyIeinslxCWgiNQCAnNnxpFCzPHi651uDW8WmkMgSfQlELAjfSTk5uIf8T5Sf4pE8sZ3Pulv2cuYoOF8sY0EbjfSStqZwa1beOpJezF7n7/x1ajLom98CReFuZmHOU+ya7rebVBRuB9T8plfQgHPwvEtIRhRidxjFPJYIUfogutlLb1I66/344vhMosF9PEaohzHuHWeg7RQQVJipyHshjROOGvwTjzdk0GPk/1Jc3jABMQViiEtQcQS2uDJvdEgtxdlweJxceGSxLIxYSQlDfhppSoI1s+M3G68Ed/IPvepPu5zbyUIMPMN9t0aE7BR7CqIDkbRFA05Oj85LRt7KbMdWG0pGjqqqckw9b78/b9bk1oQDx2Tsy4PrsIvw5RdNB0Ew1MTCOvHevgwM8MLaePAoymZQbDhC0y0b4acmV2lgzwp9O0Wgha89lFki6FDNKFmeNBi140f5Z4ZijDpsaZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(54906003)(16526019)(316002)(6916009)(186003)(336012)(4326008)(47076005)(8676002)(26005)(7416002)(36860700001)(508600001)(8936002)(36756003)(44832011)(2616005)(86362001)(81166007)(356005)(40460700001)(70206006)(1076003)(5660300002)(426003)(82310400004)(70586007)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:47:08.0311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25bd00d-6fb9-44e6-01b0-08d9bbfcb45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce GUEST_SHARED_* macros, which are mostly analogous to existing
GUEST_SYNC/GUEST_ASSERT/etc macros used to simplify guest code that
uses ucall for host/guest synchronization.

There are also some new CHECK_GUEST_SHARED_* macros intended to provide
similar helpers in the host code that can pair directly with the guest
versions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/ucall_common.h      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index ae0e8eec9734..b9b220dbd6c3 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -48,6 +48,7 @@ vm_vaddr_t ucall_shared_alloc(struct kvm_vm *vm, int count);
 void ucall_shared(struct ucall *uc, uint64_t cmd, int nargs, ...);
 uint64_t get_ucall_shared(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 
+/* Helpers for host/guest synchronization using ucall_shared */
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
 #define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
@@ -76,4 +77,71 @@ uint64_t get_ucall_shared(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 
 #define GUEST_ASSERT_EQ(a, b) __GUEST_ASSERT((a) == (b), #a " == " #b, 2, a, b)
 
+/* Helper macros for ucall synchronization via shared memory/ucall struct. */
+#define GUEST_SHARED_SYNC_ARGS(uc, stage, arg1, arg2, arg3, arg4) \
+	ucall_shared(uc, UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
+#define GUEST_SHARED_SYNC(uc, stage) \
+	ucall_shared(uc, UCALL_SYNC, 2, "hello", stage)
+#define GUEST_SHARED_DONE(uc) \
+	ucall_shared(uc, UCALL_DONE, 0)
+#define __GUEST_SHARED_ASSERT(uc, _condition, _condstr, _nargs, _args...) do {    \
+	if (!(_condition))                                                        \
+		ucall_shared(uc, UCALL_ABORT, 2 + _nargs,                         \
+			"Failed guest assert: "                                   \
+			_condstr, __LINE__, _args);                               \
+} while (0)
+
+#define GUEST_SHARED_ASSERT(uc, _condition) \
+	__GUEST_SHARED_ASSERT(uc, _condition, #_condition, 0, 0)
+
+#define GUEST_SHARED_ASSERT_1(uc, _condition, arg1) \
+	__GUEST_SHARED_ASSERT(uc, _condition, #_condition, 1, (arg1))
+
+#define GUEST_SHARED_ASSERT_2(uc, _condition, arg1, arg2) \
+	__GUEST_SHARED_ASSERT(uc, _condition, #_condition, 2, (arg1), (arg2))
+
+#define GUEST_SHARED_ASSERT_3(uc, _condition, arg1, arg2, arg3) \
+	__GUEST_SHARED_ASSERT(uc, _condition, #_condition, 3, (arg1), (arg2), (arg3))
+
+#define GUEST_SHARED_ASSERT_4(uc, _condition, arg1, arg2, arg3, arg4) \
+	__GUEST_SHARED_ASSERT(uc, _condition, #_condition, 4, (arg1), (arg2), (arg3), (arg4))
+
+#define GUEST_SHARED_ASSERT_EQ(uc, a, b) \
+	__GUEST_SHARED_ASSERT(uc, (a) == (b), #a " == " #b, 2, a, b)
+
+#define __CHECK_SHARED_STATE(uc, uc_cmd, uc_cmd_expected) do {			\
+	if (uc_cmd != uc_cmd_expected) {					\
+		if (uc_cmd == UCALL_ABORT)					\
+			TEST_FAIL("Unexpected guest abort: \"%s\" at %s:%ld",	\
+				  (const char *)uc->args[0], __FILE__,		\
+				  uc->args[1]);					\
+		else								\
+		    TEST_FAIL("Unexpected ucall command/state: %" PRIu64,	\
+			      uc_cmd);						\
+	}									\
+} while (0)
+
+#define CHECK_SHARED_SYNC(vm, vcpu_id, uc, stage) do {				\
+	uint64_t uc_cmd = get_ucall_shared(vm, vcpu_id, uc);			\
+	TEST_ASSERT(uc_cmd == UCALL_SYNC,					\
+		    "Unexpected ucall command/state: %" PRIu64, uc_cmd);	\
+	TEST_ASSERT(!strcmp((char *)uc->args[0], "hello"),			\
+		    "Invalid ucall signature argument."); 			\
+	TEST_ASSERT(uc->args[1] == stage,					\
+		    "Invalid ucall sync stage: %" PRIu64, uc->args[1]);		\
+} while (0)
+
+#define CHECK_SHARED_DONE(vm, vcpu_id, uc) do {					\
+	uint64_t uc_cmd = get_ucall_shared(vm, vcpu_id, uc);			\
+	__CHECK_SHARED_STATE(uc, uc_cmd, UCALL_DONE);				\
+	TEST_ASSERT(uc_cmd == UCALL_DONE,					\
+		    "Unexpected ucall command/state: %" PRIu64, uc_cmd);	\
+} while (0)
+
+#define CHECK_SHARED_ABORT(vm, vcpu_id, uc) do {				\
+	uint64_t uc_cmd = get_ucall_shared(vm, vcpu_id, uc);			\
+	TEST_ASSERT(uc_cmd == UCALL_ABORT,					\
+		    "Unexpected ucall command/state: %" PRIu64, uc_cmd);	\
+} while (0)
+
 #endif /* SELFTEST_KVM_UCALL_COMMON_H */
-- 
2.25.1

