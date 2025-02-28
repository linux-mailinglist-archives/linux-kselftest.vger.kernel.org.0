Return-Path: <linux-kselftest+bounces-27852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92FA4959E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0EC1895379
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D0257453;
	Fri, 28 Feb 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NT/4PDzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1AC1E492;
	Fri, 28 Feb 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735927; cv=fail; b=CB4QuwIw1RlqWrN02Uy3PlJUQ5aUk81YLjWUavCxiQBm/dxV0vfGqz/larU4COyPO62AErkzw2iqo77AYZ18soImijRmFHG2koalP12t75UDwgVBLzzu7+qmcoTXhSCzhfhFLVX1PmAAU6HVUSijToKi3BLPCU5nL91ajf1s7dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735927; c=relaxed/simple;
	bh=Z5WdLbt7XycPv+uzfajCcIOl9dKJoZisAV4ANBbgHdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXah7l6W0Gm/Zkj2Y5nFG0gWX3SWg8zM6OZNSdxTG2YW3NJT7GNzXpVqJ2JVmf+Yf7kvShuNzLEqb7i3MkH0fgiHdLUGdzA7ye7W1mRfyvGUEsQowuyuVATxtrPg4gdFO76WAyYfe++x/FDu/yVy51T3+v8oVTanGTZD7adEIzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NT/4PDzf; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHDL0psPlKRGAbgIFKY2UdAFlcLWVYiw8XkCVut6HUnXBNJ2K83u9aqck8ulLCPRQpHPCt/Tc3TNIQx9R1QL+H4RZa3BMaShIpZROG23sV+Ve33/7ZXwiyBJevDc4IyD1Y8pUZm+cjkHlXPrG9L9ESGFJt9S1yuRWvGNGSs3XswMp+UehxTOfFcN0V/kVNdl+YYyZcQvLxwlizXuHuhwu7U2vjrQFINrf+HSgPQAPmt3yRf+MktIuD2ost1FhjSQvQAmmFg2uW2sWqn/KlrMbNjguEYlu/Ly+mqvfds9na4tUUM2aPIGWb1liFYxClgRSKWeB2+8aCCe6MxfDZi6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnUNhU/+noMk0ff0i8Mqt5w/V4bpDcGrA3VGqDA/NYY=;
 b=vkAhAxShRxaI/3NdCfk6fswJYPKlZhW9rnCfiFpKJ5FDBc97z1lvKmsivvKqi4YrCXh5KlBtmAyz2D1hwN0v+OmP8w6kAmcN7WlunaY4pb1bF6tBBspHOB1M1pTj3DDscA1DHOA560sA8X1Jg61wxZ1ZjjSQ+ylJ13RQMbWJbT6OkJR2GHlJFI/4uJyiMyLJfUXvlRVYFweCy7GLGkTXOfxV2hxFCTSSKXebBt+i6u9SNyGCHPpHFotFP4/dUDjhUhIsfhdPaBYJLN6kN4znnXXqEaQvxo1GnlaaL+ERSTh7c4aC8aI73dN+osxWOA7QryznkNhkD7vDmMP3jQujMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnUNhU/+noMk0ff0i8Mqt5w/V4bpDcGrA3VGqDA/NYY=;
 b=NT/4PDzfsoPgUNITy8K1XusK+eiFnjGpi7V7FGaja4KGVp8yYrYc5QAUGpJunrZBVohwdGCGP+x7SL8+caFGWCAgTgeNLm3qORc0JUTVYwl7OHw9yjdMlLHd1ZddidDI/F5isy8r7BPdHWrG205FaiiE46wSJvXSHofFH9w84oQ=
Received: from CY5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:930:a::23)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 09:45:23 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::5a) by CY5PR13CA0061.outlook.office365.com
 (2603:10b6:930:a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 09:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:45:22 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:43:28 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 10/31] KVM: selftests: Add MSR VC handling support for SEV-ES VMs
Date: Fri, 28 Feb 2025 15:00:03 +0530
Message-ID: <20250228093024.114983-11-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
References: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 84573893-577c-41f9-cb46-08dd57dc9f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TV6J5tIIULGmfqtu4ejc0VFOhzM4jY7YdrxlzTPDFm/KT7sZYCXucQYf3KND?=
 =?us-ascii?Q?mcljf5Ek8luAltweLLdr8Wt9QO66JLOg/AUz81B1peFSoqCrDJ7ylBXTavBX?=
 =?us-ascii?Q?R2Ftdb+VxVXdKilmSPhN6n+zP2uAM343NScxd5Mj4s1NKmSWG2tJ68VePCfh?=
 =?us-ascii?Q?8+LH0gNnUmRBEOLHGWrYTDP/GD6Xo2GD3GjUlWvXFAXhTedsgXelfBCifC49?=
 =?us-ascii?Q?767TQqH2kKLzZF0mA2+O+zxvfe+iXJhQvk/ZTXahL50njLUSN1DH21yNRNXo?=
 =?us-ascii?Q?0SjrN59JoiLyArF47P168lgOyBT9qm0alNGgDFKUW7jWj9xScSDVMQIW8yYa?=
 =?us-ascii?Q?wmDeTMddE0FHHhZutcZ/EZkHRTDb5vYV7voV5uRtSXC5ki0hikuudNRAGFqb?=
 =?us-ascii?Q?OKOY5RLroVkz0sCmMzAvjW5jOA4T7MXFtnQRKtlCsA5iUyCwEiQuuatwdLV8?=
 =?us-ascii?Q?QUYLx3FXdTaZGAdDnwX65VUcWozPFC9U4wf19c1jclBY3TVP6DFl8fgTOQNB?=
 =?us-ascii?Q?RVz4wrfAGbp7sQqG2OzsocqL7WG4y1J1vovyJYdIV0WLo35VydhETQG1KvZ5?=
 =?us-ascii?Q?nxQo+oiZPbSUZa4jGtx2TRaXME21FaezUC60kFlrscrbbjvbsUir0Y2GebDF?=
 =?us-ascii?Q?SF2NxmHcwaW9w8Xmr/nx4GBeY6pF2Csma0dw9Ic/TK5TxXUCyUunvYd0d5fY?=
 =?us-ascii?Q?0KgpFdacgEN2bNlAvDFByicfvnvyBlYvs0IbD1GlRL9OjQs7Xegc/H6rLH7n?=
 =?us-ascii?Q?7+dI8CI53rIjJstDGuBWcVQ26xtJM7HU0MKsJKCzmhot3pwCPsN9z2IAkgyw?=
 =?us-ascii?Q?CJ3hOVO10q9gAgq65gvdvvtSQeEnWP+A1eHvXUTUVJDJP7PjekaP11QDnJpw?=
 =?us-ascii?Q?FIE3mYx0KZV4lLp+x+O1Rfe7obIH1TKFZcPubpPRNvwJtnHb1vxClaV+l2Wy?=
 =?us-ascii?Q?i0wl9d60Kqa7B4+XwAy6W8ko8USmE7WZkrwnciRXe4nxrWlCGDECOjeWf5Zq?=
 =?us-ascii?Q?9nRmXnO2APdmnuk7pUGtzLMHPOsxBiL9JaIHdhSC5ZQ0gVnxReOd/ITBuU1u?=
 =?us-ascii?Q?4sgoOlo0xIOS9RYedkgJSoMj7UjXaI+6zS8q5lQMLONzXq5w05RThufQGRHO?=
 =?us-ascii?Q?wv1paKfGWmMLByTfqTW+HMM1V73ZxXJPYkNLFFHW+9DrUff37N/PY2ke69UK?=
 =?us-ascii?Q?4Pshd83r+o3wcDuKYOKXrVWcDRkQRerOQr5EsAwrpJ1Xq7hLhdWAUbYWwBKq?=
 =?us-ascii?Q?qRIy477y47ll/nT1rJJvJUduaOPAkSV5ZQVLN6HvIfaQBALUM96aJ/eGBSOv?=
 =?us-ascii?Q?i0nU6h6hAkCCVlD8mXqmglf2QfbJ1g5hFjzYcWzokbvCeLdhI12Mb3bnfJPF?=
 =?us-ascii?Q?wwVncdcxn7NDskYJA310I18t1CTBaM4KvwNZo8YTm9ytYiw2/7NoYvLdxePd?=
 =?us-ascii?Q?s1f/N6FNglGvQ5mGrN7nk+PUQMsMfCi5NjQcXdYjs3djZ+KozJ7eP8cQvcQh?=
 =?us-ascii?Q?BXRNt6kbw6KMrqU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:45:22.9457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84573893-577c-41f9-cb46-08dd57dc9f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

Add #VC exception handling on rdmsr/wrmsr accesses for SEV-ES
guests. In addition, add PV interface for direct msr read/write
from SEV-ES guests without going through #VC exception path.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |  2 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 83 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index bd6ab3f38679..5556ee891260 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -153,4 +153,6 @@ bool is_sev_snp_enabled(void);
 
 void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 
+void sev_es_vc_handler(struct ex_regs *regs);
+void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 38813f60c252..ff8f02b83871 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -12,7 +12,8 @@
 #define IOIO_DATA_8 (1 << 4)
 #define IOIO_REP (1 << 3)
 
-#define SW_EXIT_CODE_IOIO 0x7b
+#define SW_EXIT_CODE_IOIO	0x7b
+#define SW_EXIT_CODE_MSR	0x7c
 
 struct ghcb_entry {
 	struct ghcb ghcb;
@@ -404,3 +405,83 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data)
 
 	ghcb_free(entry);
 }
+
+static void __sev_es_msr_rw(struct ghcb_entry *entry, uint64_t msr,
+		uint32_t *low, uint32_t *high, bool write)
+{
+	uint64_t exitinfo1 = write ? 1 : 0;
+	struct ghcb *ghcb = &entry->ghcb;
+	uint32_t ret;
+
+	ghcb_set_sw_exit_code(ghcb, SW_EXIT_CODE_MSR);
+	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	ghcb_set_rcx(ghcb, msr);
+	if (write) {
+		ghcb_set_rax(ghcb, *low);
+		ghcb_set_rdx(ghcb, *high);
+	}
+
+	do_vmg_exit(entry->gpa);
+
+	ret = ghcb->save.sw_exit_info_1 & 0xffffffff;
+	__GUEST_ASSERT(!ret, "%smsr failed, ret: %u", write ? "wr" : "rd", ret);
+
+	if (!write) {
+		*low = ghcb->save.rax;
+		*high = ghcb->save.rdx;
+	}
+}
+
+void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write)
+{
+	struct ghcb_entry *entry;
+	uint32_t low, high;
+
+	entry = ghcb_alloc();
+	register_ghcb_page(entry->gpa);
+
+	if (write) {
+		low = *data & ((1ULL << 32) - 1);
+		high = *data >> 32;
+	}
+	__sev_es_msr_rw(entry, msr, &low, &high, write);
+
+	if (!write)
+		*data = low | (uint64_t)high << 32;
+
+	ghcb_free(entry);
+}
+
+static void sev_es_vc_msr_handler(struct ex_regs *regs)
+{
+	struct ghcb_entry *entry;
+	bool write;
+
+	/* wrmsr encoding has second byte = 0x30 */
+	write = (*((char *)regs->rip + 1) == 0x30);
+
+	entry = ghcb_alloc();
+	register_ghcb_page(entry->gpa);
+
+	__sev_es_msr_rw(entry, regs->rcx, (uint32_t *)&regs->rax,
+			(uint32_t *)&regs->rdx, write);
+
+	ghcb_free(entry);
+}
+
+void sev_es_vc_handler(struct ex_regs *regs)
+{
+	uint64_t exit_code = regs->error_code;
+
+	switch (exit_code) {
+	case SVM_EXIT_MSR:
+		sev_es_vc_msr_handler(regs);
+		/* rdmsr/wrmsr instruction size = 2 */
+		regs->rip += 2;
+		break;
+	default:
+		__GUEST_ASSERT(0, "No VC handler\n");
+	}
+}
-- 
2.34.1


