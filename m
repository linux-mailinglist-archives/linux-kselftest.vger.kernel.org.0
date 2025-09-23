Return-Path: <linux-kselftest+bounces-42113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A6B9459A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37633B466E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9130CB49;
	Tue, 23 Sep 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nUo2DnrE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964D1D8E01;
	Tue, 23 Sep 2025 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604594; cv=fail; b=iRMLplGpxUtD40q8EHpj4W75UVSvsGDO0Ve7lddXAN4ZYugP/RI0FWmYDf5GCRaMsPNR2yj4v2awUz/FruUP82SdYcxpvoNbReZg6X67UNqG1nWajGb6xLyzj4nB4gTuiOc2QAwclEiZS3j+B4a6WUEUlOgDGuWGYbJMSp2/dR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604594; c=relaxed/simple;
	bh=SPOV2738h+huzkxdbPfj6U9cGd1pJacWr7fy37l26GM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOHRiJ7Cy/5M6CtYv8RdfOqVRybxHU728e3LOJthtKCgl/GN3bFHFhpAOpn7PvoixU+ou9+WREfeF9T7u+9dh7vJO/36ECJRgB4ScnFhr/n4U09C48JhoiaYfN3lJ148V3CfElEB1kOTg4hMjwDPN/gxEX+VrjALyJO4I0pFjs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nUo2DnrE; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJP8OO9JxhUHhH+knBAgcZTPNo9tKtkGUm2kUnyeBLwkN+YiGryKctN/gOuvsXwBf+98aQ9Ix3L7XlLxGBMYK893U2uoB3ByiJb/1s1/2RKYsq/YOkt2sKRcsTYfBM1Ploj1pBgNE4Bts9GOVnYQzlynizb/8PPo1ES2eSEWtj6yc0XPwNCpZA7dongOm2jUJkeME5UoAgXDqWO4840e7/MksMAgPd+Qg1wyze8Hk6shlNEIk9EjigBH89bx46f/x19omF7eyx/Ec07zdCxaG7SQDO2zA2rOdYdrzj0+A3wk4cOOHiJeAVrcBo2uIQHoMBm4SlAcPEI5MrLePIVZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPvZPMBj5ao4HEPY/P+r4JPDDKL8uWF0MPsBYf4YOBM=;
 b=QbvB2VWC0Ns521epUO1XwB0IR4HJMrcwEZjiKMV2JMGtMkNhUETWxFvVJ7etDabEoEz1/02fIaimrRTu92DZygHHGSkd1azTyzEsOI38g9pyCgdP5JsYr8kPpnuouUdSy2fbKWclTniBEt+a0NfZ1KPQhZ+HuJtlvA8BLkd47kM6wXJX2vElfU4eXBcGD3y3NBd3xr7AsqXykVQRoyiSmQte7oAIrfHc4Npf3+XCTpsilKLsyBtEogwSKQr9AtS4gkmF3b3Fema4KEQuKaH76tRczKkZZBeBdjPp8y4QM5jWnctOMlf6XFQ8W7LnpX3PBZ6TG7bW5CZGsGkwaCotzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPvZPMBj5ao4HEPY/P+r4JPDDKL8uWF0MPsBYf4YOBM=;
 b=nUo2DnrEHSBVhnpBdrFy8sYsGL+H2JE4DK14h5FlIdbifNzwEdwgGIdLcFW8zv0hESszT7B6U22bnoY6YiQGZtZHks3goJ920W3P2J3YhIEUrRlZbWuXyA5G8E9qwDbq64K3lo5APLu7i5dQ9Yzh6fFKpWZW9ST3l7s6qHjKd1g=
Received: from CH2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:610:50::13)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:16:26 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::c5) by CH2PR16CA0003.outlook.office365.com
 (2603:10b6:610:50::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:16:26 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:16:21 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 22/35] KVM: selftests: Add x2apic mode testing in xapic_ipi_test
Date: Tue, 23 Sep 2025 10:39:29 +0530
Message-ID: <20250923050942.206116-23-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 108caf4c-5597-4580-100b-08ddfa60586e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMFzzepVUk1820vZNvRHx52HQdzdrTDhibvsS2BfTCiczYmRP+AxU8Iwc5G7?=
 =?us-ascii?Q?/Ci/2hZ++3x/cFmM44XzetktLU//ghJ3jb1R6Zp6eS3JW6iidNzEzkmZXyB3?=
 =?us-ascii?Q?btPJhrPlYZpS/OEJpPG2J2DTNqfGqDZyvvQvy1FZx0Q9gm9kY4g5+JJYr+ZT?=
 =?us-ascii?Q?6pbEPthvvj86WUbAYqhIw6K+L9lq6bYAXmuUEwab3vLHs9qT7tS/ruhWjv43?=
 =?us-ascii?Q?iNmAwmJgWZXcoMMjD7DCHafda7rFDuQYz800ZBvk0ExqaHSXoLjsteY2eoIT?=
 =?us-ascii?Q?F+zZ1SNEvv5KEkODAolOhoJH5DUcW1w4HKu6FPVz2DErKaixx2wCsyyGFRuj?=
 =?us-ascii?Q?KHTUtTcaoJXer58gKxqTuj7jN2eV0BvKsErdc1re+l0YOn3M+C2Em6ATFKQL?=
 =?us-ascii?Q?cCsc/x3GjeD37aewGPOpYibGK7xJifid9YJE91phvYFTfQZN46Tpp+tyKwH1?=
 =?us-ascii?Q?+GnOGoJSuHt/7BAcXiAfGfZP/XNPFxRov9sZPZHOi1G8EebyI12HQXvOlElQ?=
 =?us-ascii?Q?hpoHSuUTO/MYdCZ/Qf3Qn8qnrjCZXJhQcd7kkh7jOa3qLZlsEGVCBbTDOm0y?=
 =?us-ascii?Q?ShLsQwKmvSB5zobJZaJtHEb2V7AWbGt/O/XDcwWtJu8jWAoXQOTjDzPDqseH?=
 =?us-ascii?Q?XKKk2rOZMPIaKdAfXqIMeHr7i0xORGwLdmpc3rjOSKanEN6AzhhQUp1va+Gg?=
 =?us-ascii?Q?ELWiZkT6if6Ku7lybvsBqmQ6phKYfMinjFB3il00xCXXjekkacEp8uUMsjum?=
 =?us-ascii?Q?QQSyaxO/sDs/IqweRa5S45f80ZzY2pm+jBNi5EvndhR554Q/AC8FI43jal58?=
 =?us-ascii?Q?zbkLavBcPf6tWs9gyfWDSCKO5u1L6brcvSbYbm+mDmmJ8wG1BOXkarBa7wCZ?=
 =?us-ascii?Q?y2NHe7UOeA/k4z5mQI6LnhYBggqIW61A12StokCpVNzuhHS/nRO9O7VEyZmO?=
 =?us-ascii?Q?rlyMW4AjRFpHp3jfwTVp2LaZC2+Z57nOWq5Fl3xVxodP7IEQBTHyXUipenav?=
 =?us-ascii?Q?cDzj0OaKIcGDYwdqKLtU1PGIzlav/8GZJxoYYOgx38ZvW25CTpqsXR9i58Hd?=
 =?us-ascii?Q?L0k8VFeGSFJxl9JWbE4qNw1Xeyawiw/uJMCYULqc+HBpjRqhbMXbTxqSpqyK?=
 =?us-ascii?Q?bSIuDEuLBvPGGPWFAxnrf68fNi5RosXmxRkgGvAyI2MU+Zvs22lTJ2XyYH95?=
 =?us-ascii?Q?XL+30VhLI/6VYtLruXXmDzEeF9NhuFklu7T7IAalrhDEU7GIwllvdejhBQlz?=
 =?us-ascii?Q?1mULERiGdE+AI5G/P7JoGHKyreAyFtQr82B6Z1ga1Tu37NifR58/cY7xaaJF?=
 =?us-ascii?Q?xuMVjH2l59IBCipzBmAY+HfqtaWCoQ2qiph0vIfSIr3jG689+gaPVQB7D7za?=
 =?us-ascii?Q?AXlCZR1DrtSDCauhQ7VoQWxHw63YC79fp2KZv2Qw325go0z5So1Pzz6CFTXg?=
 =?us-ascii?Q?yRNTOCRBTbkqC/vWrnnPc8ZV3GhVP/+Dkwx+2b888v1GcsNftAbRWo4GBiC5?=
 =?us-ascii?Q?hj1IgMGWQ0tTiEM69L5MoCslRDNLnOUu+Jxd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:16:26.3347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108caf4c-5597-4580-100b-08ddfa60586e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

Refactor the test to support both xAPIC and x2APIC modes.

The xapic_ipi_test selftest was hardcoded to use xAPIC mode, relying
exclusively on MMIO to access the local APIC registers. This limits
its ability to test IPI functionality in environments where x2APIC
mode is required or preferred, such as for guests with Secure AVIC
enabled.

This change makes the IPI test more versatile and prepares it for
future extensions to test features that depend on x2APIC.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/x86/xapic_ipi_test.c        | 65 +++++++++++++++----
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 35cb9de54a82..e7dcf4bc0350 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -50,6 +50,29 @@
  */
 static volatile uint64_t ipis_rcvd;
 
+static bool x2apic;
+
+static void apic_enable(void)
+{
+	if (x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
+}
+
+static uint32_t apic_read_reg(unsigned int reg)
+{
+	return x2apic ? x2apic_read_reg(reg) : xapic_read_reg(reg);
+}
+
+static void apic_write_reg(unsigned int reg, uint64_t val)
+{
+	if (x2apic)
+		x2apic_write_reg(reg, val);
+	else
+		xapic_write_reg(reg, (uint32_t)val);
+}
+
 /* Data struct shared between host main thread and vCPUs */
 struct test_data_page {
 	uint32_t halter_apic_id;
@@ -89,10 +112,10 @@ void verify_apic_base_addr(void)
 static void halter_guest_code(struct test_data_page *data)
 {
 	verify_apic_base_addr();
-	xapic_enable();
+	apic_enable();
 
-	data->halter_apic_id = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
-	data->halter_lvr = xapic_read_reg(APIC_LVR);
+	data->halter_apic_id = GET_APIC_ID_FIELD(apic_read_reg(APIC_ID));
+	data->halter_lvr = apic_read_reg(APIC_LVR);
 
 	/*
 	 * Loop forever HLTing and recording halts & wakes. Disable interrupts
@@ -103,8 +126,8 @@ static void halter_guest_code(struct test_data_page *data)
 	 * TPR and PPR for diagnostic purposes in case the test fails.
 	 */
 	for (;;) {
-		data->halter_tpr = xapic_read_reg(APIC_TASKPRI);
-		data->halter_ppr = xapic_read_reg(APIC_PROCPRI);
+		data->halter_tpr = apic_read_reg(APIC_TASKPRI);
+		data->halter_ppr = apic_read_reg(APIC_PROCPRI);
 		data->hlt_count++;
 		safe_halt();
 		cli();
@@ -120,7 +143,7 @@ static void halter_guest_code(struct test_data_page *data)
 static void guest_ipi_handler(struct ex_regs *regs)
 {
 	ipis_rcvd++;
-	xapic_write_reg(APIC_EOI, 77);
+	apic_write_reg(APIC_EOI, 77);
 }
 
 static void sender_guest_code(struct test_data_page *data)
@@ -133,7 +156,7 @@ static void sender_guest_code(struct test_data_page *data)
 	uint64_t tsc_start;
 
 	verify_apic_base_addr();
-	xapic_enable();
+	apic_enable();
 
 	/*
 	 * Init interrupt command register for sending IPIs
@@ -160,8 +183,12 @@ static void sender_guest_code(struct test_data_page *data)
 		 * First IPI can be sent unconditionally because halter vCPU
 		 * starts earlier.
 		 */
-		xapic_write_reg(APIC_ICR2, icr2_val);
-		xapic_write_reg(APIC_ICR, icr_val);
+		if (!x2apic) {
+			apic_write_reg(APIC_ICR2, icr2_val);
+			apic_write_reg(APIC_ICR, icr_val);
+		} else {
+			apic_write_reg(APIC_ICR, (uint64_t)icr2_val << 32 | icr_val);
+		}
 		data->ipis_sent++;
 
 		/*
@@ -357,10 +384,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 }
 
 void get_cmdline_args(int argc, char *argv[], int *run_secs,
-		      bool *migrate, int *delay_usecs)
+		      bool *migrate, int *delay_usecs, bool *x2apic)
 {
 	for (;;) {
-		int opt = getopt(argc, argv, "s:d:m");
+		int opt = getopt(argc, argv, "s:d:v:me:");
 
 		if (opt == -1)
 			break;
@@ -374,13 +401,18 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
 		case 'd':
 			*delay_usecs = parse_size(optarg);
 			break;
+		case 'e':
+			*x2apic = parse_size(optarg) == 1;
+			break;
 		default:
 			TEST_ASSERT(false,
 				    "Usage: -s <runtime seconds>. Default is %d seconds.\n"
 				    "-m adds calls to migrate_pages while vCPUs are running."
 				    " Default is no migrations.\n"
 				    "-d <delay microseconds> - delay between migrate_pages() calls."
-				    " Default is %d microseconds.",
+				    " Default is %d microseconds.\n"
+				    "-e <apic mode> - APIC mode 0 - xapic , 1 - x2apic"
+				    " Default is xAPIC.\n",
 				    DEFAULT_RUN_SECS, DEFAULT_DELAY_USECS);
 		}
 	}
@@ -401,7 +433,10 @@ int main(int argc, char *argv[])
 	struct kvm_vm *vm;
 	uint64_t *pipis_rcvd;
 
-	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs);
+	get_cmdline_args(argc, argv, &run_secs, &migrate, &delay_usecs, &x2apic);
+	if (x2apic)
+		migrate = 0;
+
 	if (run_secs <= 0)
 		run_secs = DEFAULT_RUN_SECS;
 	if (delay_usecs <= 0)
@@ -411,7 +446,9 @@ int main(int argc, char *argv[])
 
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
 
-	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	sync_global_to_guest(vm, x2apic);
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
 	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
 
-- 
2.34.1


