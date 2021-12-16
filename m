Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9936477A64
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLPRS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:18:27 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:60128
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232003AbhLPRS1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:18:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSLXm4KZqVWfvAB5q/GphqA3FHV8JY1O4evpUm18iNfsh43dxvqoZyJa7quFuhra6l9R8f1KN4mQ/paN+EjCDUBaCf1/A4JnfxeF99xUtsek5eTXEO3G8csN0rCP5ekFnW1+UbgHZKqIP6TYW66Wrm8IVYZDA4MBSQHSGG2gS5dFK2Hf+qBCq7nL6P4gFGv720V9SJcnTIxDtPi577Fr+LuwCo3COTX1ySWLp7CDoYz5Gt08Nk1KNCDo/i1q8GGW2wpRkfEwhIOTyQsKjwyBg1qwMGWGomNrSm6zF/JVtyjeJOKm3NJcVgtX4KdmEvm11IluOmi4iM5+awFpAf7X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxu8ovrayTImOrZwVNQUxYOhg50GDaSc/rK9FwX6rnA=;
 b=LjbDCKEGog4eHBCVWjYjdt+1X9Mrl5BceFefYwrOxC2Hd/lwqdkGrtc9nO+NEPJQETfbEnmWidCR5g3jCCcb+z67QeUgUHGLi7G+hjWYr7JRygm0ebLvxeGVZQ3eGRgh84mykhVyayh6jFwkBi6aqFEAcGaBFVOMbZ9GPuUoDYbP5Lcm4sjtqB7hf8XrHRj5Of6pyJ7psyuSC4GWQ6ev/CMF0SUaL5nxIc0bfK626npf/wmscGxBtHywY0Xy5h6lmjjQM6cNZDRE2it5bv6vHoJoiRhI82vJ71pM04dUXJ3/FF/VYXUMw86UFzd3xelVBjphpLfa8DIdQkblcnNaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxu8ovrayTImOrZwVNQUxYOhg50GDaSc/rK9FwX6rnA=;
 b=d6ielv9RQU4xLhupOffz2Zh56ZCd0iQXZojZAhQ3xf78zNKmGWaHinl8Eqp2sJLHR8VgZfh6SmoTgYyl8g+54I18+KVzDtWgPjRf2pKP3mCZVZ8RxOhLANzp9MPydJLL1UJJbS+Z1KKofAn2ii56+DEANXMFz3Pezc6gNZMm3aE=
Received: from MWHPR08CA0038.namprd08.prod.outlook.com (2603:10b6:300:c0::12)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 17:18:24 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::72) by MWHPR08CA0038.outlook.office365.com
 (2603:10b6:300:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:18:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:18:23 -0600
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 06/13] KVM: selftests: ensure ucall_shared_alloc() allocates shared memory
Date:   Thu, 16 Dec 2021 11:13:51 -0600
Message-ID: <20211216171358.61140-7-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8eb254-5d27-4b14-9242-08d9c0b81164
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470AC27C1C03C2222089D1195779@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQnJi++cO4zAEhi2SFFrMyXsWdDgPGT2ySh2WyE1Z21u8ToHqp9+ENNLNh7i0qX5wEtnSyLHyo3kiFS6uf0EWpUybMCeURA+ghoLmVV9zMh3tLUaydESoC7efnz3lKQlfSB7PGKYmZ2i9TD8i1rFsldzsessp6mAwTwPan4WTrqF9Lqa9syWAfsMTCSWQZm65udtha1aMaJJdz/qxFCpC4yKkK++epc+vPRpFNG+xbEkul7evuwxW/Fj/nm1fEExUjUbMw3KZFqQHDvklv5nPUeM0wkkMr+4YMWBVMh7rr/pEWRJpoEnvJQ4HwBVlLFin6CrTp0hmLgnHwV8kaiHuxRDvaQVRzhCsIZzU4ANElsiRyvTheplBMITkXKZfxnqWlqUFr58B+cFvKBfPuhdsblKcVjYuIr3QlaAt/hIq/kBZRh0wptU6Sd0esfGWLFAQ1ejuNlROVpgVllaNZhqy6GjnV4ZpOkgdG0fFqxIX+Ctka/OSImCbalWGi5QSu9/cAtfebX9o6gV47QjkzDQj098yBdvy+r+/4Nago1UTujYBn0eutXSlOo2LM+JtdSXPNR/Ook3Qu/acgkrf9AJDTfU7/N6vbu4Qd4EKtHLgtJQ8WQfaR2+xNmWQblxRPZpjMnQymu6rQVj1mH/MODnGcEgWGDNBQlK08AJ7tSuVT9jZbBWJNXT981fyhjeVBp6fQ9vkSm0lVWDb7KxPaiu7FasQfNcTaxRsG5tMfoGVx6nmaFkDThd+A2yfGE11lQyMUjcSvlcrujqWq4df2IfF1kLmncfjaqq+R6LybJXEOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(36756003)(186003)(2616005)(8676002)(47076005)(6666004)(44832011)(54906003)(16526019)(2906002)(316002)(4326008)(36860700001)(7416002)(5660300002)(6916009)(508600001)(1076003)(70206006)(26005)(86362001)(356005)(81166007)(82310400004)(40460700001)(426003)(336012)(8936002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:18:24.6358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8eb254-5d27-4b14-9242-08d9c0b81164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that vm_vaddr_alloc() allocates encrypted/private guest memory by
default for confidential guests, ucall_shared_alloc() needs to be
switched over to using the new vm_vaddr_alloc_shared() function to
ensure that shared memory is used for the allocation.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 8e5738241a7c..54c6c159dcd5 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -97,8 +97,8 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 /* Allocate shared memory within a guest to for a shared ucall buffer. */
 vm_vaddr_t ucall_shared_alloc(struct kvm_vm *vm, int count)
 {
-	return vm_vaddr_alloc(vm, count * sizeof(struct ucall),
-			      vm_get_page_size(vm));
+	return vm_vaddr_alloc_shared(vm, count * sizeof(struct ucall),
+				     vm_get_page_size(vm));
 }
 
 /*
-- 
2.25.1

