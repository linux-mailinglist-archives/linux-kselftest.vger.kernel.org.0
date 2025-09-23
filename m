Return-Path: <linux-kselftest+bounces-42101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10391B94539
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED167AE394
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381330DEA6;
	Tue, 23 Sep 2025 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I1uGiCU9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9630DD00;
	Tue, 23 Sep 2025 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604381; cv=fail; b=HpaclQDxRCxR4KybVsBvMD17Rw/e8iJyyL6nI1BjQUEr/B8Eq5TJhgTuLcXMq/an+pyc+Il1g/JEgwz2sNkyEpS2d189tqzcn1ELg5Eq95QE9PLRqn8MWcSsmyFLYbGMn7KzTRjeWZw04K8R6OughOuocEITCoIL2k5S6ufc0cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604381; c=relaxed/simple;
	bh=sZPjDcNkA0p8ZkxVxn/kTkO38bmXO0bTLo8NGaCd3WQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVCIptG1bd/lklS4mjS85DrbazZKnWFxJir4giWSSnwXNMS91cXG+UqgvRrdtDdzBmubLAnz8jcf7gs6LXy5LulIgXiTL6AhnPjt0vau9bE6Sl+Cb5MHfYjz8bcX+zE4DXP23UzmlQw+B9pkKHCu/z+ZL8Q1TAfCY8Di1WiDOs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I1uGiCU9; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSDgydmSBeb5/WvaNxuHc8PDlY/YMcLwBRyE6QomoknC76XbuUChP29rD8jn/5sxDsDJWb7qnvivbqmcYWQzniuB4P0H0mTx13Fhjp/IB8wPvOrlxv1+mXZfxqSv9HSlSrlsHZhMDX0Re7wQJ1nqvlUINKdsk2KfFOD1pYIductZS22CodOKSmxPuGIAP50LDIX9r6nnV8a6D209SZKBjo3s3bGI1w7D+MjVeiR0GkgeOzvE0/OoEZPrSpat+DAICv3enQGOFfFQ5FO/QLHZkWkqLDPM4uzgVbYvTlHjk1LFEhgaWRUUgYxFSg8vQ0XAQ/xoSPvNOc2wXXR2WV3N2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOf6g/hXe+0hyzhPHeC2OmeYnmX/FyghyZyaK8CJLtg=;
 b=khqXST0lds7+iT09mBIYlDkk2qbCmydFnvA5Oio8+HAUxWtYLxtQjQcxDkR/y8X27/qm9A1MiC3rR+cs/PM/MXpabpi15oPQFUJu5YaEG/qwtKp4lNNQa1VsRtB3kiMUQeTGriDMjsidLCsWpcAXNhkGjgEIIB4Tj8WyHwHFFXe8pPotMCAAHoM+1hsuEBuvhzx9TvQa9o5rq+7vIVKElyzWuTm5WvXriPeH6DWhOyW5jYveDYborgNYIxW6zz6z8P+XhIwfuygXPim01zyNykgg8A8Uf7vUkOBDGwraWmpooJtWwQ62nli4rq4dg6Iv01jAxge/Zi+ZDY+dQNCtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOf6g/hXe+0hyzhPHeC2OmeYnmX/FyghyZyaK8CJLtg=;
 b=I1uGiCU9Qnz/fi0Wvr6UxX4Qd00SgB4mfGCt+RcawnzZAJ30PqBctaFv2E5i/CjDtAOCEOi8Ogq88iD4Ixa5Lp8sHzaaNPYJQeQg9dXvY69ZsYTEFdkT3D276IPQ3B2Zh0gr8+Plv1feW3NsqdnHsI3TN7ty+UkjP4rWbnRXbo0=
Received: from CH0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:610:11a::9)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:12:54 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::7e) by CH0PR03CA0332.outlook.office365.com
 (2603:10b6:610:11a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:12:54 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:12:47 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 10/35] KVM: selftests: Add MSR access support for SEV-ES guests
Date: Tue, 23 Sep 2025 10:39:17 +0530
Message-ID: <20250923050942.206116-11-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9d28ac-c2ec-4d62-88a4-08ddfa5fd9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+b6ujaDrtRzSJ2FB7Y1wDrduPi1vfQwVoyc/6l4XFuX52iu/lH/bto1hMn4?=
 =?us-ascii?Q?MbPMqi6RXnLoYw+deZhL7KWMDJZr3RqhC0xokHtwaE0bdkbnDjnwZkwGu0B4?=
 =?us-ascii?Q?MD2avnWWo2yz0KWS3qblfKsr66RlqrZn2BaZTbcYz1eLG4mW4Nzs66qtsnjU?=
 =?us-ascii?Q?/4w1MVWdNYTdLxhEfXMVvlNlH22LDNLSgBo4qKMIaa5aGvrCBBT2HH1e5SKK?=
 =?us-ascii?Q?5BiL1endwghdDwJDN4+o+84XP10xWaIYO2GxWmlrEwr1i77ntVaDjGEpNkiv?=
 =?us-ascii?Q?cADolodcsS7IOB5cyloUlScJSI8mfi2t7XToFB1yRLAxPWK3N69ia+Q7Onut?=
 =?us-ascii?Q?sjKveeUJqCoGviGmiaHBT33+LPJwQ0gDMSTQMLcFdu0nvaaDKe0S9pSgUygF?=
 =?us-ascii?Q?DJluBRQOEGRtNJgCyPZz0cJ7SJqt7Jxx5t/gJw7YxsZk5Mytw458TQfdonVl?=
 =?us-ascii?Q?6se7QjT9UES56ezphsHTFxeZjs4g+O8WuMr2iS0WUdkRkQpxI6+mAROZBM+0?=
 =?us-ascii?Q?+6O1cRjTHPxk9I10AbpK2t1UcyugtB7zf8hOzhQY/dUAoymg6aUmo84Xa6dH?=
 =?us-ascii?Q?NKPfJrKdGYduqYwD3atmsSjv6VAUxy3Pu5OSnrRZiJuFA2Xn9mWtASjwZb65?=
 =?us-ascii?Q?Noy5/1yIlDq9cON4HKzwemMzHe65+N2Zq2AQnvdKTqaPlO9RWKyRp5ZBvAW1?=
 =?us-ascii?Q?3RblhgOuAtcFXczbeVWh4Cz24J2XKzde54rWaPNIVL3LgD7BvwE9iRDqr56s?=
 =?us-ascii?Q?2FrqEwp7Fr9SBPatAdHsdF4oqtV2/SCUqVp54ozF9j6gl8Dpe41ZhjegZAyG?=
 =?us-ascii?Q?N/js+MkusS0wAhPwfEELJbCOLKT/pt6TtImf/PLtZGs7sZwQ65hU6uz0/HKd?=
 =?us-ascii?Q?+loJjdXJoNsCSO3cwjkBESjnxtZ/AP1vTSCqQ2krb9BEAcKXLE+OGOji+aMa?=
 =?us-ascii?Q?iSwAytggQ1sNrLLalRj4XfG6OtO3l8Rk9i3YJZ6JPasokbdYg/vL4wtYSrwP?=
 =?us-ascii?Q?aFdIpNlUy72fc6dlx4CZjMLyhh8hxQutGNpz2FsMNe4AaSV5lQ+1pvXp2IfA?=
 =?us-ascii?Q?GX75XfkRzSw7+DiRnBIQZ8rCNQj9CGSgHDpHr/vK72IDMhN3355M4LVGl2pQ?=
 =?us-ascii?Q?byh2H7+wmMuoc43KGqvKV3eI2ITh8LUnLwKbgMs+KVOpheeYziw4fHk9hjCq?=
 =?us-ascii?Q?YKJjYcn7+sY1ZgN09FBE7jhE5Kk0di9OFNvq5jdXXxqtUDTwDpdW0peuOdB4?=
 =?us-ascii?Q?H/Z4wYM1dzEuUJ0sbfeQUPl97v90CfxGHzdCpUHD2cVkhaZx6GK7AHT5B1vD?=
 =?us-ascii?Q?DwsJyeA9/Cxo/3EcrwfvESP/fHlfrq8I9dBLTuq5lbiis9xlZDzY3oaVzGlB?=
 =?us-ascii?Q?jQWkJsrHBAtDn5gXO76uVc3ZNKVB7S8x/5pPCS6aJhik60AHrP3OAZEUdQPu?=
 =?us-ascii?Q?7h28m/x5LbhV8Tkryqnl03qZVlZBQPSWxvxz7AWfiEi40v68huZqwvcqj6kQ?=
 =?us-ascii?Q?z8cO9P9+8KiAEhH7iqXWQ85uHqi8bnKUkNKp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:12:54.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d28ac-c2ec-4d62-88a4-08ddfa5fd9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310

For SEV-ES guests, RDMSR/WRMSR of the intercepted MSRs trap and
generate a #VC (VMM Communication) exception. The guest must then
handle this exception and communicate the desired MSR operation to the
hypervisor using the GHCB protocol.

Add the necessary selftest infrastructure to support this flow, enabling
tests to correctly perform MSR operations from within an SEV-ES guest.

Two mechanisms are introduced:

1.  #VC Exception Handling: Provide a #VC handler, which inspects the
    trapping instruction and the register state and does a GHCB
    request to forward the MSR operation to the host .

2.  Paravirtual Interface: Provide a direct, "paravirtual" way to test
    the MSR GHCB protocol. This allows test code to request an MSR read
    or write without needing to execute a trapping instruction,
    simplifying certain test scenarios.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h |  2 +
 tools/testing/selftests/kvm/lib/x86/sev.c     | 83 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index a4fbea0d3562..9c1fe6be5e68 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -165,4 +165,6 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
 
 void sev_es_ucall_port_write(uint32_t port, uint64_t data);
 
+void sev_es_vc_handler(struct ex_regs *regs);
+void sev_es_pv_msr_rw(uint64_t msr, uint64_t *data, bool write);
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index edefba7f49ce..57ae5a388b8c 100644
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
@@ -356,3 +357,83 @@ void sev_es_ucall_port_write(uint32_t port, uint64_t data)
 
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


