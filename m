Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D21470655
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhLJQxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:53:35 -0500
Received: from mail-sn1anam02on2047.outbound.protection.outlook.com ([40.107.96.47]:3522
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233753AbhLJQxe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:53:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwZC4ZyghQfMnB+vIHQTPjXlGebjgwNT3dAqJju0LIFo3bOtZgHuabMhymfv+H1CKpWQcyjO5+xyBU3/4zGsKgCHU+2AnOcylJCzy4Gl9hVx04TwMzrJXCsek8khJohy1cgzvcW7levimqCEFquPCqqR8CS9zVTQP8w3PsL9ZT2K3QCb3UTsqwPtTfLgqHOsV0yzsmmdw/Ao6uMO3a1cw6KnT+hjeo7I9mkgmkpUbVAIts5H3aNEtGSdH8/TyZtwqclhicrnrafKb6qelzxqk55TP6UK4IEbExcfK8MUXmj4gRW185/2Lubhuako+W1svTQLN5R8TqkPW5Oww2gclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meSvBmDO/cMIhCV6ZtoghB6ppaUXrxPV/DFc5npjgD4=;
 b=BWhBU4h3JUs4TNyxREtieVaK3D8AJmZI5xlfUZtD5sHMZIoNGqBzME7D+K2gvJvs4Zr0TshKwHkyOOU5WiPOTFkU2c2yoWEmzlqxZgPdqG6n84ktnWkvkzhVyPW8lVLzFfGwY0oINb6gz3NPpJZkgALeZXTcSysGqTRXaSO/Z14h9oJXv5WzPnoOySOAoiIWyYMZg1bOa+ZDGzYGMtilqyAUqYz3MRgDU/hYcaSspGAGZwfXbEr1feyAnrMjX8tvVWQ0qzoJJSeSA9WpXV5FIOxlAV87AHkpAdFkldyrQjp5GTBxBkccDXg9Zdt2t2H0TrarbGmTn3DQx74FFdbVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meSvBmDO/cMIhCV6ZtoghB6ppaUXrxPV/DFc5npjgD4=;
 b=KKZgg/tbSbV5k0dlPIIZq+BLQfuzEBmjqTujIy2Cq2azx/EtrhvLC+j8j9+zd0INs1wVeY2LAffCImvBJTbYhuP6d8jr5PiYAxH9/0AFf8ThpVbwQkO5Vn5qbiu8Pb2Ybr9++waFsTZpZf0vEKXmc9BS0NsfbzxB02OKQcl4cmM=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by CY4PR12MB1877.namprd12.prod.outlook.com (2603:10b6:903:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 16:49:56 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::ae) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Fri, 10 Dec 2021 16:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:49:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:49:55 -0600
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
Subject: [PATCH RFC 06/10] kvm: selftests: add ucall interfaces based around shared memory
Date:   Fri, 10 Dec 2021 10:46:16 -0600
Message-ID: <20211210164620.11636-7-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5db43f4d-63ab-43e7-ee79-08d9bbfd18a1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1877:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1877E897C8BEAB1BF751499795719@CY4PR12MB1877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k575Uzq4pqvkXNUZZgcD5KX9WU8bmVFmdy44pVDXAL7wTCAtJk2sL9Ct5dh2FHnqcklXn4ZY0eOkrCe/R9V7aLo/k+L0fyGmmQgnNsoX5GNa4gWJqPLn/ND8atfNNON0TiJKuk9swtlDV/PLW8VEMYSUDB+t6OrMMRBdfNkFvN8Ac/04eh1N3GMkI2u6xBoKAzVQKxmZ2T7abDua/b29DPgNFu+iG8oLgXkcRq8hw0qOXh7JN8ppYbInARY3loGOwh7BEC6drUSoBie3dgyPY3+72Y7CHuEqpxI5eegVDFOcEhT4pukhC49rxm2Kka1PjyYi82iNnizoaDQl11pJOT3z1dWZP0/GtMt6hjCD08uvlSKsxp2MzGhzm/wvkYbyuJiyTgwOy4clgUgIl4vsHUVbL37wLVvFoWWcNhA+KPAhtjyFRRhIa8KgpT3zzCn9Oidk0icPuMjqCWvqbVxqcGXxe5HykJYCYZPIUnUCjbV/zOwLALNg0WvVZeo/a1mNHNk+IWr7j7iRjvoXSwE+Ske+OYZDcyhtbY4VxOCGYu+1cKIwW2/rJlJ/u+eH6o6FxtHPEXd7rrjhzzu6mPsmSyPLExX4g5svdqUDykdPsyo6iE+TcX7yxJpxQZeAkPU0i4dqEwbYNhanuAVctbEMyfyr8KNOmNogyqQ0MBR5JO75YoPOXgbgsUysgrR5WitAwDqx7BCrx6S89mWNhXvIXVl2YIqfFUpYNtAeGCsGp86y/obrY3A+ur1endP1RdqPYT5Hg3u5fnue9BU+YNVNGoMhi0uR+wjH/Op7/C/FdQY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(16526019)(70206006)(70586007)(8676002)(54906003)(6666004)(83380400001)(356005)(316002)(4326008)(26005)(81166007)(2906002)(5660300002)(86362001)(8936002)(6916009)(44832011)(7416002)(40460700001)(82310400004)(47076005)(36860700001)(36756003)(2616005)(336012)(426003)(1076003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:49:56.2927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db43f4d-63ab-43e7-ee79-08d9bbfd18a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1877
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One complication with SEV and likely other Confidential Computing
implementations is the fact that guest stacks might be encrypted, so
existing interfaces like ucall()/get_ucall() will not work as-is since
they allocate ucall structs on the guest stack dynamically.
Additionally, the basic task of communicating the location in guest
memory of these structs is complicated by the fact that guest register
state may also be also encrypted, so existing approaches like reading
vCPU register values to get these addresses would need to take this
into consideration.

One way to address both of these in a (hopefully) robust way is to
introduce a new set of ucall interfaces that rely on tests setting up
shared guest memory in advance so that these ucall struct addresses are
communicated between host/guest in advance, along with any work needed
to ensure the memory is shared/public. With that in place, a ucall
implementation only needs to trigger an exit back to host userspace to
allow for host/guest communication via this shared memory / ucall
struct.

Implement this approach by extending ucall_ops to allow for ucall
implementations based on shared memory, and introducing
ucall_shared()/get_ucall_shared() analogs to the existing
ucall()/get_ucall() interfaces.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/ucall_common.h      |  5 +++
 .../testing/selftests/kvm/lib/ucall_common.c  | 38 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index fcd32607dcff..ae0e8eec9734 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -34,6 +34,8 @@ struct ucall_ops {
 	void (*uninit)(struct kvm_vm *vm);
 	void (*send_cmd)(struct ucall *uc);
 	uint64_t (*recv_cmd)(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+	void (*send_cmd_shared)(struct ucall *uc);
+	uint64_t (*recv_cmd_shared)(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 };
 
 void ucall_init(struct kvm_vm *vm, void *arg);
@@ -42,6 +44,9 @@ void ucall_init_ops(struct kvm_vm *vm, void *arg, const struct ucall_ops *ops);
 void ucall_uninit_ops(struct kvm_vm *vm);
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+vm_vaddr_t ucall_shared_alloc(struct kvm_vm *vm, int count);
+void ucall_shared(struct ucall *uc, uint64_t cmd, int nargs, ...);
+uint64_t get_ucall_shared(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index db0129edcbc1..8e5738241a7c 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -93,3 +93,41 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 
 	return ucall_ops->recv_cmd(vm, vcpu_id, uc);
 }
+
+/* Allocate shared memory within a guest to for a shared ucall buffer. */
+vm_vaddr_t ucall_shared_alloc(struct kvm_vm *vm, int count)
+{
+	return vm_vaddr_alloc(vm, count * sizeof(struct ucall),
+			      vm_get_page_size(vm));
+}
+
+/*
+ * Populate a shared ucall buffer previously allocated by ucall_shared_alloc()
+ * and then generate an exit to host userspace.
+ */
+void ucall_shared(struct ucall *uc, uint64_t cmd, int nargs, ...)
+{
+	va_list va;
+
+	if (!ucall_ops->send_cmd_shared)
+		return;
+
+	va_start(va, nargs);
+	ucall_process_args(uc, cmd, nargs, va);
+	va_end(va);
+
+	ucall_ops->send_cmd_shared(uc);
+}
+
+/*
+ * Parse a ucall buffer that has been allocated by ucall_shared_alloc() and
+ * shared with the guest in advance to determine the ucall message/command that
+ * was sent by the guest.
+ */
+uint64_t get_ucall_shared(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+{
+	if (!ucall_ops->recv_cmd_shared)
+		return UCALL_NOT_IMPLEMENTED;
+
+	return ucall_ops->recv_cmd_shared(vm, vcpu_id, uc);
+}
-- 
2.25.1

