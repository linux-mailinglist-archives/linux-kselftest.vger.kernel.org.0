Return-Path: <linux-kselftest+bounces-42110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FAB94582
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7771188C82C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE530DEB7;
	Tue, 23 Sep 2025 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNnKANXv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469830DD29;
	Tue, 23 Sep 2025 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604537; cv=fail; b=F+b1RFR96vRYzQ0TxazAmOePDGSHpy+tw7Ib5KU5410/Y5eH4kL6yN5hAZVE6kguGJCfutdwkw+ikrdkyZq8kllvOHZcYW7yU9h6BdNtS+7nK55GvIUSVLvSFgAd0ePR6895472gNk5Fy28Fg/8zBKA8F+lTln/LTAzhogWmg4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604537; c=relaxed/simple;
	bh=UqaM+07P9YA7Tw08pAd/2XhNDqvDAIq2I6A1sDazCVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3YUg+v2piaW7+feYFi85+au/8YdWVqvIX8YhHENzheD7mOeM4VP1VKmezlu+VPTG5RinSbLcySVQ486W/jSocTId5989QHyeHJh7StyhCxCLZ32fN2aFHccYdXuGQy3QwG3jN5kxnF83x03YlHmDL7Yn9zdrlU5Ck7cgCVTFJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNnKANXv; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH7+/JSd7ePwhf9uLTv0QQYQPciBVZOSuW5y3JElxX01JPPzY1yzz/AgvuM96RYreWCP4PJG+BXafuz/EWFQ0zgFDsRPLjbbWSALLulWceBXTINM+5RnDgbu6ls/LuTTa4MU2Dc+smtnXcwO772/uxv6gLzfWGh8vIhOgTmvLts9sgwjhDe+jBYC3FgyrVScvvfcFaE66gn9pMPDZZubgSCuigrISAOsEGJREr4MyrZUOpluWrOcsMYmjeu7yyRc2icR8cNhnGRJmeHzYoxBb/MZqOGwqG9vwx46qNh8uwwj1jUqHop1/np21972ItXnuSWoJBS9jhig3Xq2nz0HCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJs8HpH6e9P6rVzxnitZJxaWNtdX80r5jwo2//Luo8M=;
 b=XICxiB8PXQBlExPzf2s58tfN3Svs6zFF0530O8C77OAg7vLyiSmzvNTmiox9jQwXAwZeDMt3iScJQSpAxrFFQVCQvLFFhUPMZmd2sGby9yKX0QP7KXXE3sjcI30cKKJ4lyOBKhCHPbu5AAXAVKSBTrrCXtooMGufqNpZns0yeLa/gTwobE2LMiEY/alM2ptqjiXCjvGdaPXCSUIQdTPhvfmWdco1rFTW9an8D6C132VSFCMlRRqrWjGp4Up1nmleGE5u1Jhv4IQmeF9zI6VwTWw4vYfHEom0ogPWonJCjiWhLOVpoUB1h45OOqOUHYuSC545OfRXdI17flQXdhm2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJs8HpH6e9P6rVzxnitZJxaWNtdX80r5jwo2//Luo8M=;
 b=iNnKANXv7+NETcGf7MPY7afPB25EICtmmLLGZ3e+Rd/9uZtOYg7FIF8KUTW0HlAfXB8uZruKKt6S20GnqPrL6TEzH5L8n7J5VwQ3cb12RneEuut2BIEmN+iP3Ox/KJPZlI0b9zWVKXi/hiJN3gvG9A3mBpwrxUzDtOCq8e0KMaU=
Received: from CH2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:610:50::30)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:15:33 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::a7) by CH2PR16CA0020.outlook.office365.com
 (2603:10b6:610:50::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:15:33 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:15:28 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 19/35] KVM: selftests: Add MMIO #VC exception handling for SEV-ES guests
Date: Tue, 23 Sep 2025 10:39:26 +0530
Message-ID: <20250923050942.206116-20-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
References: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e41617b-94d1-4002-616b-08ddfa6038db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PpgIAaQb6g0OLiR/y5Wpd3E+6yNQj4fHNNIPnBhcC0/GFPNcfvLZsxiIsEc3?=
 =?us-ascii?Q?v8EYWjEZPInabKUaJVyWtOCyo43wdpDBaVZqtUWNicfTOU1rVAEKpJCNFIEc?=
 =?us-ascii?Q?y96Dblo03e9GgeBAByWhd+Ys1MTQe9d7WKQpPfAZVnGRZgqUKmsq+KKMM/bv?=
 =?us-ascii?Q?N7+BcDjQGWxwCeC94IV3UkO3KlPQEN4QREV+wOiR9eMer+Z49hoaaNQS1nXU?=
 =?us-ascii?Q?zavRdiWkVwoxETZ0vD/8bDltW7kEeK661qf+kv0LK+s/jtiFV5IVg+CF1M0t?=
 =?us-ascii?Q?Bf1DomLd7FqqaaQRnlxlitcBR0DXmOD2zWiuf4YoryoEK/7o+AGUK3Xycztd?=
 =?us-ascii?Q?dxMuTpAQbrlmBed5Fn7c1aZcjn5AR+j9h8RIeLv94S7PeirMoeV3OvMZiXFt?=
 =?us-ascii?Q?QUZlOdBVE7oZI+B/GI1Kh34gaLfQaiJjiJW4IFlxQfjE5pDxOEsDOJiLKOSL?=
 =?us-ascii?Q?FlZ3w/n5cZBPp+L21jXVQ2X5upTtZXtxx5UQ1fmaPP4pHjYyUCFbHjWfskjJ?=
 =?us-ascii?Q?IqCxY/oReNt7x56Ln3a8XwsWDVgDNA17Rwe2Im2hO1oHie52e6pSxvht+zmD?=
 =?us-ascii?Q?GfHh5Noqr2sqYbdREeuRc5ubZNsNpomTlKaStqy/mJWn3zf+DGicjIouootA?=
 =?us-ascii?Q?R0t27pjiXiL05Dz84mCMKckbbrLoiAPzBO9o3VMIqLEqH5oSmjydUUpep8a0?=
 =?us-ascii?Q?RXCbY4ZkhGreAyz+noPUxmjrUoGMl/2r/tSLFKmGu5e/FNO1KWOWBEiWgV82?=
 =?us-ascii?Q?7zDruUDTyW4SwqzHvus5CLPqWtfrViKNxm2ogNkTaMaoMzeu/PUpang7lMa5?=
 =?us-ascii?Q?HpTL/8Gq3/cnZXyfOG6ZZ3+f4YDKz78oOEX5YIzRb3D9C9z83/ruIuTF0Sp+?=
 =?us-ascii?Q?ZbnqG4TsGZJywfv+7ZbY7ECQJaK9vXPXRxeDW1M26khJ7aY/aS5ujmxp1ISY?=
 =?us-ascii?Q?2pY5o0XaYvPxnW0DYDT/wZHQgtvjijxoxvD5ndm+UiEryw8v5T9q4qBSk2cR?=
 =?us-ascii?Q?m6p2e4/isXvR4h0QDEvOjDFjhNqStkjsFadqVIPS6151s6yQFFF/MZhifF/Y?=
 =?us-ascii?Q?YCg/1asznqghGOMheKJSJODxbg0LX5tU3b0PZqMSAaVI3ZJJlb16gIYMQizf?=
 =?us-ascii?Q?mXRlYgfH0O4b/d6BxLHyN6FM9sqHpTOP1MIzw5JzQJWleA22an8qRR9cyhrY?=
 =?us-ascii?Q?xYUPLgT9fOZPbebqam66dtqz2XlZcvYMc93oOgGDSbxGqIa16YshVSYC4siX?=
 =?us-ascii?Q?wwPXflsrqHSzmESczzCPhCH+88gyeBvsOLTDzD3Zzjj0IWxuby3/OMAkDImJ?=
 =?us-ascii?Q?vpiNK9LSmxQF4+Rudl9WFHSyBwHwNlIbwfNSftDARVGQexBg1JoaHI5/DKNI?=
 =?us-ascii?Q?WLMlW+C7gBVgKdsamY+RbYWqVkfvCF9hYAsKf2lsRmWiibN3lzkCUJ1MiEvS?=
 =?us-ascii?Q?d4h2sIrxObb4CksJlzTFhLeznFLr4t2qjd5W5oobG3p+643TEdZu04hBmGjz?=
 =?us-ascii?Q?/dLi1UNeSbr5NSSKvac52/2uRt6HT82r/Z72?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:15:33.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e41617b-94d1-4002-616b-08ddfa6038db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

In SEV-ES encrypted guests, access to memory-mapped I/O (MMIO) regions
like the local APIC triggers a #VC (Virtualization Exception) with a
nested page fault (SVM_EXIT_NPF) exit type. To emulate the MMIO, the
guest must provide a #VC handler to process these faults.

Implement MMIO handling for SEV-ES guests within the selftest
framework. Extend the #VC handler to catch SVM_EXIT_NPF exceptions.

Additionally, add a new paravirtualized (PV) interface . This function
allows guest code to request an MMIO operation directly via a VMGEXIT,
bypassing the more expensive #VC exception path. This is useful for
contexts outside the #VC handler where an MMIO access is known to be
required.

This functionality is a prerequisite for enabling local xAPIC access in
SEV-ES selftests, which is required for testing interrupts flow for
SEV-ES guests.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |   1 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 259 +++++++++++++++++-
 2 files changed, 256 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 9c1fe6be5e68..d9794f5c2c16 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -167,4 +167,5 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 
 void sev_es_vc_handler(struct ex_regs *regs);
 void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
+void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 57ae5a388b8c..610342b8e479 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <stdint.h>
 #include <stdbool.h>
+#include <asm/insn.h>
 
+#include "insn-eval.h"
 #include "sev.h"
 #include "linux/bitmap.h"
 #include "svm.h"
@@ -14,6 +16,8 @@
 
 #define SW_EXIT_CODE_IOIO	0x7b
 #define SW_EXIT_CODE_MSR	0x7c
+#define SVM_VMGEXIT_MMIO_READ		   0x80000001
+#define SVM_VMGEXIT_MMIO_WRITE		  0x80000002
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -314,10 +318,10 @@ static uint64_t setup_exitinfo1_portio(uint32_t port)
 
 #define GHCB_MSR_REG_GPA_REQ		0x012
 #define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
-        /* GHCBData[63:12] */				\
-        (((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
-        /* GHCBData[11:0] */				\
-        GHCB_MSR_REG_GPA_REQ)
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
 
 static void register_ghcb_page(uint64_t ghcb_gpa)
 {
@@ -423,6 +427,250 @@ static void sev_es_vc_msr_handler(struct ex_regs *regs)
 	ghcb_free(entry);
 }
 
+static void __sev_es_hv_mmio_rw(struct ghcb_entry *entry, uint32_t *reg_gpa,
+				unsigned int bytes, bool write)
+{
+	uint64_t exitinfo1 = (uint64_t)reg_gpa;
+	struct ghcb *ghcb = &entry->ghcb;
+	int ret;
+
+	if (write)
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_MMIO_WRITE);
+	else
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_MMIO_READ);
+	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
+	ghcb_set_sw_exit_info_2(ghcb, bytes);
+	ghcb_set_sw_scratch(ghcb, entry->gpa + offsetof(struct ghcb, shared_buffer));
+	do_vmg_exit(entry->gpa);
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "mmio %s failed, ret: %d",
+			write ? "write" : "read", ret);
+}
+
+void sev_es_pv_mmio_rw(uint32_t *reg_gpa, uint32_t *data, bool write)
+{
+	struct ghcb_entry *entry;
+	struct ghcb *ghcb;
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	register_ghcb_page(entry->gpa);
+
+	if (write)
+		memcpy(&ghcb->shared_buffer, data, sizeof(*data));
+
+	__sev_es_hv_mmio_rw(entry, reg_gpa, sizeof(*data), write);
+
+	if (!write)
+		memcpy(data, &ghcb->shared_buffer, sizeof(*data));
+
+	ghcb_free(entry);
+}
+
+static void do_mmio(struct ghcb_entry *entry, struct ex_regs *regs,
+		struct insn *insn, unsigned int bytes, bool read)
+{
+	void *ref = insn_get_addr_ref(insn, regs);
+
+	register_ghcb_page(entry->gpa);
+	__sev_es_hv_mmio_rw(entry, ref, bytes, !read);
+}
+
+static int vc_write_mem(struct ex_regs *regs, struct insn *insn,
+			unsigned char *dst, unsigned char *buf, size_t size)
+{
+	uint8_t *buffer = (uint8_t *)buf;
+
+	switch (size) {
+	case 1: {
+		uint8_t *target = (uint8_t *)dst;
+
+		memcpy(target, buffer, 1);
+		break;
+	}
+	case 2: {
+		uint16_t *target = (uint16_t *)dst;
+
+		memcpy(target, buffer, 2);
+		break;
+	}
+	case 4: {
+		uint32_t *target = (uint32_t *)dst;
+
+		memcpy(target, buffer, 4);
+		break;
+	}
+	case 8: {
+		uint64_t *target = (uint64_t *)dst;
+
+		memcpy(target, buffer, 8);
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+static int vc_read_mem(struct ex_regs *regs, struct insn *insn,
+		       unsigned char *src, unsigned char *buf, size_t size)
+{
+	switch (size) {
+	case 1: {
+		uint8_t *s = (uint8_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 2: {
+		uint16_t *s = (uint16_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 4: {
+		uint32_t *s = (uint32_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	case 8: {
+		uint64_t *s = (uint64_t  *)src;
+
+		memcpy(buf, s, 1);
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+
+static int vc_handle_mmio_movs(struct ex_regs *regs, struct insn *insn, unsigned int bytes)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	int ret;
+	bool rep;
+	int off;
+
+	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L)
+		return -1;
+
+	src = ds_base + (unsigned char *)regs->rsi;
+	dst = es_base + (unsigned char *)regs->rdi;
+
+	ret = vc_read_mem(regs, insn, src, buffer, bytes);
+	if (ret != 0)
+		return ret;
+
+	ret = vc_write_mem(regs, insn, dst, buffer, bytes);
+	if (ret != 0)
+		return ret;
+
+#define X86_EFLAGS_DF   (1UL << 10)
+	if (regs->rflags & X86_EFLAGS_DF)
+		off = -bytes;
+	else
+		off =  bytes;
+
+	regs->rsi += off;
+	regs->rdi += off;
+
+	rep = insn_has_rep_prefix(insn);
+	if (rep)
+		regs->rcx -= 1;
+
+	if (!rep || regs->rcx == 0)
+		return 0;
+	else
+		return 1;
+}
+
+static void sev_es_vc_mmio_handler(struct ex_regs *regs)
+{
+	char buffer[MAX_INSN_SIZE];
+	struct ghcb_entry *entry;
+	enum insn_mmio_type mmio;
+	unsigned long *reg_data;
+	unsigned int bytes;
+	struct ghcb *ghcb;
+	uint8_t sign_byte;
+	struct insn insn;
+	int ret;
+
+	memcpy(buffer, (uint8_t *)regs->rip, MAX_INSN_SIZE);
+	ret = insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+
+	if (ret < 0)
+		__GUEST_ASSERT(0, "Instruction decode failed, ret: %d\n", ret);
+
+	mmio = insn_decode_mmio(&insn, (int *)&bytes);
+	__GUEST_ASSERT(!(mmio == INSN_MMIO_DECODE_FAILED), " MMIO decode failed\n");
+
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(&insn, regs);
+		__GUEST_ASSERT(reg_data, "insn_get_modrm_reg_ptr failed\n");
+	}
+
+	entry = ghcb_alloc();
+	ghcb = &entry->ghcb;
+
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+		do_mmio(entry, regs, &insn, bytes, false);
+		break;
+	case INSN_MMIO_WRITE_IMM:
+		memcpy(ghcb->shared_buffer, insn.immediate1.bytes, bytes);
+		do_mmio(entry, regs, &insn, bytes, false);
+		break;
+	case INSN_MMIO_READ:
+		do_mmio(entry, regs, &insn, bytes, true);
+		if (bytes == 4)
+			*reg_data = 0;
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_ZERO_EXTEND:
+		do_mmio(entry, regs, &insn, bytes, true);
+		memset(reg_data, 0, insn.opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		do_mmio(entry, regs, &insn, bytes, true);
+		if (bytes == 1) {
+			uint8_t *val = (uint8_t *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			uint16_t *val = (uint16_t *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn.opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_MOVS:
+		ret = vc_handle_mmio_movs(regs, &insn, bytes);
+		break;
+	default:
+		break;
+	}
+
+	ghcb_free(entry);
+	regs->rip += insn.length;
+}
+
 void sev_es_vc_handler(struct ex_regs *regs)
 {
 	uint64_t exit_code = regs->error_code;
@@ -433,6 +681,9 @@ void sev_es_vc_handler(struct ex_regs *regs)
 		/* rdmsr/wrmsr instruction size = 2 */
 		regs->rip += 2;
 		break;
+	case SVM_EXIT_NPF:
+		sev_es_vc_mmio_handler(regs);
+		break;
 	default:
 		__GUEST_ASSERT(0, "No VC handler\n");
 	}
-- 
2.34.1


