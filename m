Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCB47065C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbhLJQyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:54:18 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:5313
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234977AbhLJQyR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:54:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcc0qPPnFHNYGo0RFNpPROJ9c59/biHwO2CgTKLr/6NWofnq/jAbLK860zckQUCNggaxk1cUkHBaD7qqi3neLE0VwPxvnnxkbevaEUpBIjyDzTNrS1WgKvjzVeVD5DIODMtOPtECBAeoMXw9tXz6NKB5c9vDRv/6IILO8KlGHOB+88SSDQ7+IkZK2hER68dutVPGtN92zfDBUnwtauzOBikD0ESnD5sEm3LyYkeUKuAUIFClTd4O41GyWv24QwcgHsljQ7uv2ySTXMqAQVW2lhEgaaJQo+RwjlCFPGe9el69OOyI3kx0HKPooPHW9PEGIkJGvLDo0l839iZNJ8Zqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rggfAyljN28bFCpAoefDdna3xuZYIfL7ltTJS7WGYQE=;
 b=NCKd8pBCDQL/XrBLoyWnUUAhw6JTXJX0+a/Ct177NSpjBKdmdqiUYxq75kDZk6XCh7SkimQ5xqh6uxRxPy2wDIzPJhsK+vEjs2AQYT9qf2XfOd3bVXCXK9+v2ILk4h0bE5856OQP9TnD+Z3qFPzLwibJYQQOcnKbC2W/CDEx5QA46PnZm5nav7ovC/0LEiqdkFIDKv4z5Q4PFEYATzzBYwr+gsSwNrHKKN6kMyxBhG81Xnr7EfN096cXy4/fE3keY/M8Wtc0rYZaU5uxL5hFX9C/BTCrIzHZW5oc447r/dIe9ej2P0wiTAo0nRl2aMduBAMA1yDg7z4AlSYyRk5ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rggfAyljN28bFCpAoefDdna3xuZYIfL7ltTJS7WGYQE=;
 b=UJgC6JypO8/erQKlpJJA8xCGENbSlNE7gKjFYTuyWsM1WBPyu77DGn8HkAb7MEKS0LRZF93JY1Lt6W2NGLTRKREOdM7gjgnkpFBFLz/EHokcarW073g6QyjOrob3VyGItIPZCO01jxlLpaHNYOBP4psvQTDeEtb+q3TZd8EymLQ=
Received: from DM5PR21CA0007.namprd21.prod.outlook.com (2603:10b6:3:ac::17) by
 MWHPR12MB1485.namprd12.prod.outlook.com (2603:10b6:301:4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Fri, 10 Dec 2021 16:50:38 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::c0) by DM5PR21CA0007.outlook.office365.com
 (2603:10b6:3:ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Fri, 10 Dec 2021 16:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:50:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:50:37 -0600
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
Subject: [PATCH RFC 08/10] kvm: selftests: introduce ucall implementation based on halt instructions
Date:   Fri, 10 Dec 2021 10:46:18 -0600
Message-ID: <20211210164620.11636-9-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b3f90c2-7619-47a2-1dc0-08d9bbfd31ac
X-MS-TrafficTypeDiagnostic: MWHPR12MB1485:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB148551B1EAA6684F3451E4EA95719@MWHPR12MB1485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNYjccCML4ZqmPid9lPWaSyu1GJ6fxsD+/5Eh3WZpWCuPzTOsh4Ulj9KaLRc8HkYAdyFKl/oAxi/TeNiBv6XafX8WsCjX4U0XWd0q0baPskPFzJDlqvr7rxgvFLJU+DvGkf0jRbobH01dT6S84yGbghfBLX7FVk+Ts9LAC8Z6BkbtqItZX8EuhtGJ/MVJvMPTP720KyXEJBuZuRfKqYavv65l/bxeZV+7jersnmJKwcYf7sLcmAhIcz6yZ/SQ7NX6yXC9X4NQbpisV8I/7brEpRwo+ru/2Y+SgdI+9tYzfF2R0y6F0NoIrtjTn70rfQmdCDIogqFBCAX4L5oE+SNLBdESMfkqs9C/96iyugOI6w5jWH2FnQMAJVeifwTFVQtXxuSAjlvf15zOWWhlCshvtIQjaBR0bRiEjEVHCBoQq7zLN+Q9bRYq9kY/zfoFC3pCMsm6FMfYAhNzQ0x2AujdStP2Of8cvegL5G5XvFvVrgVi6gxZ2gJUuXeoU6TOkBNW0BCGWxewdUAPR1lzeqEm+xWRnh8SRkaQ9cXWrOF1+LBx1DSpeCD1NmUivw4wTyvnZgRdl2NSAMuWmSrOFEJf8anD1mLgjP1+bbbllcSiEH9qis23vTlCvaYTIj4JdiWZOMA6SHRn5s1epz6tJPipakaTj/up1K7uRiFTkh/7Nkjglfn0pRgDAQdihOHd458r28FuAXvx11K69pW2/dtMX5MNjhiSVh2xpvhSNm1gQ+ub4Un/W3YlD/91+pfaUW0mscjxmfP6yJVdDzIRkfqhK2EPML2KmUFqMtR3YqBlZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(44832011)(86362001)(26005)(2616005)(8676002)(16526019)(316002)(186003)(5660300002)(1076003)(508600001)(54906003)(6666004)(336012)(426003)(4326008)(356005)(70586007)(70206006)(2906002)(47076005)(81166007)(36860700001)(36756003)(7416002)(82310400004)(6916009)(40460700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:50:38.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3f90c2-7619-47a2-1dc0-08d9bbfd31ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1485
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the shared ucall interfaces the only thing the ucall
implementation really needs to do is generate an exit to host userspace
so that the shared ucall struct can be examined. This implementation
uses a 'halt' instruction to generate such an exit, and is suitable for
use with SEV guests, and potentially other confidential guest
implementations.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/include/x86_64/ucall.h      |  1 +
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/ucall.h b/tools/testing/selftests/kvm/include/x86_64/ucall.h
index 8366bdc9c04e..457fc1406746 100644
--- a/tools/testing/selftests/kvm/include/x86_64/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/ucall.h
@@ -12,6 +12,7 @@
 #include "ucall_common.h"
 
 extern const struct ucall_ops ucall_ops_pio;
+extern const struct ucall_ops ucall_ops_halt;
 
 extern const struct ucall_ops ucall_ops_default;
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index 157d2a102547..4dfb12881434 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -57,4 +57,27 @@ const struct ucall_ops ucall_ops_pio = {
 	.recv_cmd_shared = ucall_ops_pio_recv_cmd_shared,
 };
 
+static void ucall_ops_halt_send_cmd_shared(struct ucall *uc)
+{
+	asm volatile("hlt" : : : "memory");
+}
+
+static uint64_t ucall_ops_halt_recv_cmd_shared(struct kvm_vm *vm, uint32_t vcpu_id,
+					       struct ucall *uc)
+{
+	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
+		    "unexpected exit reason: %u (%s)",
+		    run->exit_reason, exit_reason_str(run->exit_reason));
+
+	return uc->cmd;
+}
+
+const struct ucall_ops ucall_ops_halt = {
+	.name = "halt",
+	.send_cmd_shared = ucall_ops_halt_send_cmd_shared,
+	.recv_cmd_shared = ucall_ops_halt_recv_cmd_shared,
+};
+
 const struct ucall_ops ucall_ops_default = ucall_ops_pio;
-- 
2.25.1

