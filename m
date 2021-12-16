Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08FC477A4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhLPRQU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:16:20 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:52736
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233283AbhLPRQT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obggnHIhebieTxF2mUnBso+GCpRAbTpgctpwiaXWN2uBI7jZND99KGb4X3OqJjgtPtn9qtIbTuvjkD1K3BrYOWboKDxKMFvdKXw0ZzsWZyy+yD24nQKeGcFXCGaebz9f3Hb2+i0jwh/tJ8ShW30Jo+NxoGl7AZKnRKEp/5Wy8XxCdmAfv/cRacwPt7lPoJZXGFBW5K6dhDtG+xTafPR2qXT4D7VLnvDstOFBT4H0pvp4hxefL+JV/s3xuAz93CZpIrRIBkm0+XjHPmtCnell6MGuA3R8KZuMl87zcXbOU1Fr5b83qcWsjyK2TloPdldZfodELWMxvLsKkFxRRR/wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7IwfmF6j7lQ5dhDs/7vSnzQXC+YLYmxazWjCC/ZqA4=;
 b=gw39GLmvLD5g7Ql/pkZdfHo6CQ2itl/kkCD1vdubz5c+nD2tZ8L37+W4KkSxgAIdCpuC70kwXI8W1mW8MaHkA1fAdOhShgkc+u6kHOGyOl2E4+STdGJeK1Izn9XJwbIF04zc+tedkUz8pJlxEC/A4O3jKQ8L5vFaUF07ymf3qoJJLPEdZdrXU7lWf8uEK0bgkqyagIzOanZSyNHLInp76p2t1mJsf/fRyKR35kmdvat3/WUGiZyA+23WFlmQ8bKrmkeJ3V5meTx5T1/hpeE+O73n0zbJNSr3pxi20xyP+2SD3NbJsWCc7A/emgddKDyDBrxnk5KPZPoQQRrsC4dfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7IwfmF6j7lQ5dhDs/7vSnzQXC+YLYmxazWjCC/ZqA4=;
 b=h9BKUpYuZQnG2Y2m+yO7kQjqCnhztb/YOuFkZVDkf7ZaiWdWXt5o81ybyClj562SYpVY2p+I8pCX/7RjCeVQ6BJzpZ938u5jC/Unzq1DRo1t0cgPNMTCTzIcSXp0AWU1+99XgmyR5Y4hOKRW7+5bJulDIfhpOcgQpRfNBUItWhc=
Received: from MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) by
 BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 17:16:17 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::fd) by MWHPR10CA0017.outlook.office365.com
 (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:16:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:16:15 -0600
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
Subject: [PATCH v2 13/13] KVM: selftests: add SEV-ES boot tests
Date:   Thu, 16 Dec 2021 11:13:58 -0600
Message-ID: <20211216171358.61140-14-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 30dd5f56-8945-4d35-2419-08d9c0b7c548
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB355580D845CBDBAB4C4985DF95779@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBHPrwZ0a85m+nRpLntjWt3ab3GjharpkPmv2m0eoMzi72MDNYKFsxEyYxZPyWhQBBHs82nn/69PRFpbosAUkz/1GDC7eLOK7Lwr/FoF3gyVqGmOLAyly7SXKkZdCPzZH/At3nnWzHkQ9DnabO39GHq4SxCmNguTyMXI1SbhbGfNhS8aftnyKCUSzjcieTqBDTrqCj6Lm6pTn0ZFe6Z0LudAL+USKrX1pAmZq24rFmMn27sGuHzPNNsg0Lv50YYtg8MtEVEJ9PF9uGNF0ZaHEXwfzqcTpxQbGQo2A8o76mOEN+X43w/SK9qUZBDl9ti75cDfjiKTTWhMZZjgIISB2Ki8NJ8rwYdtAx+1AZ32yaHwOmVvDYn9PKHJJbqLjEkjuT2dFqKPfm6GBOwtjiBv8KJTjPN2iVbv7kQkIU97ReDYp4QstPkkePe1Efnl1KZOuSJ/f7OQtgV/n9fxVer6UknQLUH02X9e6MXqD0E4tnyazHUYC/vzHO/ZtbLopF1RAQx4jypVUILFJy7hixZQLe99la1MhDo9XM7tgUq14zILaya4Kw7wcLO0cowZaDTD1eqO9n9vHMFBrRe6RclJl1/anyR3cgRKGVhWHaj53XYO827fO6/BfZW3TULYN4m4RYsPMWBQy1SINzp1yGV8usc/vHoQTQ3HcdBkR4ew3VYU9G4nFH+j4K3HfuS//OmfJT4YnAhCV+lM7cx+2t5sZg106xhCy0NzfrafoHe+nqzhuFTwtyceyowrlMI8tAcgy3D7p22558m5DXbj+mVg+FPhxBu4zYtUF1cgvhjpevk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(36756003)(2906002)(83380400001)(356005)(36860700001)(70586007)(336012)(7416002)(1076003)(86362001)(4326008)(2616005)(6666004)(70206006)(6916009)(316002)(82310400004)(8936002)(81166007)(44832011)(5660300002)(426003)(16526019)(40460700001)(26005)(508600001)(186003)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:16:16.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dd5f56-8945-4d35-2419-08d9c0b7c548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the existing SEV boot tests to also cover SEV-ES guests. Also
add some tests for handling #VC exceptions for cpuid instructions using
both MSR-based and GHCB-based vmgexits.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
index 329a740a7cb2..63c26bf4ecb6 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -18,6 +18,7 @@
 #include "svm_util.h"
 #include "linux/psp-sev.h"
 #include "sev.h"
+#include "sev_exitlib.h"
 
 #define VCPU_ID			2
 #define PAGE_SIZE		4096
@@ -31,6 +32,10 @@
 
 #define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
 
+/* Globals for use by #VC handler. */
+static void *ghcb0_gva;
+static vm_paddr_t ghcb0_gpa;
+
 static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
 {
 	int i, j;
@@ -165,6 +170,47 @@ guest_sev_code(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
 	guest_test_done(uc);
 }
 
+static void vc_handler(struct ex_regs *regs)
+{
+	sev_es_handle_vc(ghcb0_gva, ghcb0_gpa, regs);
+}
+
+static void __attribute__((__flatten__))
+guest_sev_es_code(struct ucall *uc, uint8_t *shared_buf,
+		  uint8_t *private_buf, uint64_t ghcb_gpa, void *ghcb_gva)
+{
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t sev_status;
+
+	guest_test_start(uc);
+
+again:
+	/* Check CPUID values via GHCB MSR protocol. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Check SEV bit. */
+	GUEST_SHARED_ASSERT(uc, eax & (1 << 1));
+	/* Check SEV-ES bit. */
+	GUEST_SHARED_ASSERT(uc, eax & (1 << 3));
+
+	if (!ghcb0_gva) {
+		ghcb0_gva = ghcb_gva;
+		ghcb0_gpa = ghcb_gpa;
+		/* Check CPUID bits again using GHCB-based protocol. */
+		goto again;
+	}
+
+	/* Check SEV and SEV-ES enabled bits (bits 0 and 1, respectively). */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	GUEST_SHARED_ASSERT(uc, (sev_status & 0x3) == 3);
+
+	guest_test_common(uc, shared_buf, private_buf);
+
+	guest_test_done(uc);
+}
+
 static struct sev_vm *
 setup_test_common(void *guest_code, uint64_t policy, struct ucall **uc,
 		  uint8_t **shared_buf, uint8_t **private_buf)
@@ -200,7 +246,18 @@ setup_test_common(void *guest_code, uint64_t policy, struct ucall **uc,
 	fill_buf(*private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
 
 	/* Set up guest params. */
-	vcpu_args_set(vm, VCPU_ID, 4, uc_vaddr, shared_vaddr, private_vaddr);
+	if (policy & SEV_POLICY_ES) {
+		vm_vaddr_t ghcb_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, PAGE_SIZE);
+
+		vcpu_args_set(vm, VCPU_ID, 6, uc_vaddr, shared_vaddr, private_vaddr,
+			      addr_gva2gpa(vm, ghcb_vaddr), ghcb_vaddr);
+		/* Set up VC handler. */
+		vm_init_descriptor_tables(vm);
+		vm_install_exception_handler(vm, 29, vc_handler);
+		vcpu_init_descriptor_tables(vm, VCPU_ID);
+	} else {
+		vcpu_args_set(vm, VCPU_ID, 4, uc_vaddr, shared_vaddr, private_vaddr);
+	}
 
 	/*
 	 * Hand these back to test harness, translation is needed now since page
@@ -251,5 +308,9 @@ int main(int argc, char *argv[])
 	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
 	test_sev(guest_sev_code, 0);
 
+	/* SEV-ES tests */
+	test_sev(guest_sev_es_code, SEV_POLICY_ES | SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_es_code, SEV_POLICY_ES);
+
 	return 0;
 }
-- 
2.25.1

