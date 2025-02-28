Return-Path: <linux-kselftest+bounces-27859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E0A495E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824D916AB35
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA692594B7;
	Fri, 28 Feb 2025 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aw1q50wh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54796258CE0;
	Fri, 28 Feb 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736266; cv=fail; b=e6wU1sYJGBHpWDuu6xiM0tiF/hPI6K0IJitka1AgdEEJ8GVExdvuEVaX17ch0IKa3qQu9uUa7GK0nl+IlVTPuDVU3WrKRTqv5sQkj7pH+deRuHsiQSvMYM5fDOPSL976GM8WF9ytxVFYqvmoFtZlDwShOhlkDs/gVvmzurUShfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736266; c=relaxed/simple;
	bh=QBtNHo/AJUxZvu70ioVNSxJDjpRuUCJ/omCnFfV4XBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH6NQ64ABzseAa7uiYHE4/vHWGLoipEuP518XHJRpGx6mjeYJZSw0ZY44148WFxtim9BokLvkPSPDAmUiOQUl92nP7qscoGDccx/ckVs4sTvHnfMt27FKRhhcQoATAV+/LQxfzitYHcteBbQ8JLQcL5fpQoDDWWj8aY/6oKLeYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aw1q50wh; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2v4VFxwwnaDxgu08q1+cTIJuoXjdPS+bwha1z3cuGRUdk8wUEsknHdpOl9uuyGLDuKSi/mTryqWpLktXNtjmyQvoyj9oxQM0fXw+5XVWSVDdllA9WCq9T+uBznhCJTdcDDDqxmyB1KaJZI6Oq6qNWvb0ocXrdouZ38ay2GDP2dH7pSp8wFfECQyXNiwyDIzbpOrHX537fBoMtEFIhT7z5dqUw4Uv2sjHbCkkqh0nnT961Lz/eO2+cIKNAjUTYB4xI2l4aXT5dUjKBqmG0Z3xI2qBMGH+OgWHM4ExwoxCscT+OyCfn2u1hANXzDLqApAbHK4lkqD7F82LnyPm8EERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ovrz/Y1TMf2j7ub+EyEFa8yzDBCM7g7YBp4FOMhr/4=;
 b=Edrjo/65H3ShV3y10iEoczKkEinCx7BsOWN51oFUQNkSbyzfiqt/juve+TD0PsbBLcVaP9FdoAsSDTTzxe0DKXiwlQ/knFDZIpH4m6I1nQ8ZTm9eBRFanqZQrpjZd0MnlrxcjcC+QbCJnCAG4/dUJ2KK/Pj0v519H2fRmnKkOZg0/XINsf5/OuG5INc/SwMjvhiR/Le2NUBw5pmADAbYN1QizbPwkzjY6rgYby5Od2Bz1RpLZpYMeBdtVmuAz5Rax9/o48kFLU3pbIFdYGzJ4xInilHAoanoWsckjDBZXHf1A4zX/FJbptN/X9SkZup//wcHgRQRa8sD1wp1ZIFjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ovrz/Y1TMf2j7ub+EyEFa8yzDBCM7g7YBp4FOMhr/4=;
 b=aw1q50whlt6pRsj2N/yM/de7zKhqVAAN2UZswb8a7roYVVBIyYBcNxJgfyppCm53mSSn2/Qk+bdxpYxlUG/X2J4bNHIMSr7B9YovapE/2ALqHkIxEW918CjIApY3b+ZS4Pvs7cfk2IjDGqu89MZLONbT+DPv3IlNUuWslVF/Ifg=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 09:51:01 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9b) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 09:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:51:01 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:50:56 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 17/31] KVM: selftests: Add x2apic mode testing in xapic_ipi_test
Date: Fri, 28 Feb 2025 15:00:10 +0530
Message-ID: <20250228093024.114983-18-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: df880718-8102-435a-c28c-08dd57dd68af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scH60mIGFPrD4X08jGOlLGTxrotIbrpQ3VLdCB6gxSk+6JYiQiPeHSnS9LYI?=
 =?us-ascii?Q?7+XzR+1G/mY8ul/Tk1mElJPsOgiT1w4VULq3g3fT6wqKLXqwmgzo4aN7hafN?=
 =?us-ascii?Q?gx61OKA3GR0XYrQheztijyOav+ZhjFNraOt79IoNUUdCSDWHaXYUXdgx7QVU?=
 =?us-ascii?Q?8bgGtdbwloIvQM+axmC+ZJrOzCFc0nLX0oBiyhgKucY5tTI09E0xqMoIOtNk?=
 =?us-ascii?Q?JGHylbiatc11efIDeGc2wMxLBHv1knmsD2CN7hwcPJkdZqrNnV9CsKY2PjSO?=
 =?us-ascii?Q?xH6t8ku5g0yGBb17hhWdWmFh9yhDceYB6dMacbl27Se3esR6vPWVqRPmxERm?=
 =?us-ascii?Q?hxKaAHNF1aug9d49/tSNTJoNH5ThRUqfPimkm3hw7DbtcDqW0EDn8k05m073?=
 =?us-ascii?Q?Syrd7ARW3PLwRZJvPo+xZ/hXJky9EJLSZmmU5hXL3voCKNQNZGtVmhtyr2y1?=
 =?us-ascii?Q?SRpX1ic0iw0zca7q103Msx/3d1xR7OnX/O5L+jrpRtAQtreSyNTdeGDT1vFh?=
 =?us-ascii?Q?0tXdSzPyeeHnij5m0LBuFeDiVdSymikgOZ6ElwahK5asMqNbCJT3WxCif4GP?=
 =?us-ascii?Q?IaYXrf3F4qBUUkXm3qjk/P1YMytEWbaqjiIY1LKZQHm83MWpRLOqb/AQVcZq?=
 =?us-ascii?Q?SYszMyeO/XIu2brsc8X+J8rpqq8G/IAzb76scoA7bvrnYdEKWVjq55Pot0pc?=
 =?us-ascii?Q?q4A7BsI09fhK+D+WjzPIPChJUJXOLjYVrQ+x/DVFZ3/4P+JB7xIYVTRtmIf6?=
 =?us-ascii?Q?kCW5Zc5cdSahB0TABDIh0uXZYnB2d3hV6BDhYlu6S05urcNlXltAjMNHisKi?=
 =?us-ascii?Q?PUOR0iQScL7bXdzBItueVmJRPPXDKoLnFfhaIAIxOPVJNG4+RVXyQ3kc2BbC?=
 =?us-ascii?Q?rmtD1n1h2r82Zi4qntNiBuKARMWIgRPTOiQyXwVBKw52ArVnFSmoAvFmxWHY?=
 =?us-ascii?Q?1eCCAWBG8sXLs9J5An/xSBTBNx7qoqGyDF4ZybMm08ntzfyWJao0Fr7xv/ve?=
 =?us-ascii?Q?FrmKnwO2uUZ9QQsFCaR/swqqOKhfyktZVNIn1ScMzvlxcWMZQbB2bRxHWjvq?=
 =?us-ascii?Q?zIthUzzLkdv0qyGspujTsKbKHaOJjrKX6m+HTBhvtMbDe3sE7bMaJ3L66jyN?=
 =?us-ascii?Q?uCi6SX51AbCz8g/VmzNVl4eYrOQWAshA70K/8ITihHNgCOItkU5UL53hJONS?=
 =?us-ascii?Q?qactY2aSBb3Va1oQB0XqhBvavvetsdbvkNPp9aRFnLaQrGo3XmK/AjY1OrmG?=
 =?us-ascii?Q?t4a4fPlZL6ec9VgG1lBNSGpoB4b+cu6Jr99+DQNTIFVTf+tZI/BQR8B0omLj?=
 =?us-ascii?Q?E4t0aUcN7s1u4Im8rKRAGdtaVImT+1Jo3nxFcguV1YxeAkjPZpmzSClJpI3U?=
 =?us-ascii?Q?hxCNMRo9l9aZZEsC+Z8VS6jC+CtOvG8E/MNKdDeqc0INQ5F4B/1+ZM9iSE3M?=
 =?us-ascii?Q?sgZWwhlbQbG4gvVXdh1HoU2ZfLinJjQKf9xdP/PY8Z9fob1Cx6q1Q23ejVOh?=
 =?us-ascii?Q?GBkfvIUz306a/e4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:51:01.0497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df880718-8102-435a-c28c-08dd57dd68af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Add support for testing x2apic mode in xapic_ipi_test. This
allows extending the test in future to support VMs which
only work in x2apic mode such as Secure AVIC enabled VMs.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 .../selftests/kvm/x86/xapic_ipi_test.c        | 65 +++++++++++++++----
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index a76078a08ff8..024514089766 100644
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
 		asm volatile("sti; hlt; cli");
 		data->wake_count++;
@@ -119,7 +142,7 @@ static void halter_guest_code(struct test_data_page *data)
 static void guest_ipi_handler(struct ex_regs *regs)
 {
 	ipis_rcvd++;
-	xapic_write_reg(APIC_EOI, 77);
+	apic_write_reg(APIC_EOI, 77);
 }
 
 static void sender_guest_code(struct test_data_page *data)
@@ -132,7 +155,7 @@ static void sender_guest_code(struct test_data_page *data)
 	uint64_t tsc_start;
 
 	verify_apic_base_addr();
-	xapic_enable();
+	apic_enable();
 
 	/*
 	 * Init interrupt command register for sending IPIs
@@ -159,8 +182,12 @@ static void sender_guest_code(struct test_data_page *data)
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
@@ -356,10 +383,10 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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
@@ -373,13 +400,18 @@ void get_cmdline_args(int argc, char *argv[], int *run_secs,
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
@@ -400,7 +432,10 @@ int main(int argc, char *argv[])
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
@@ -410,7 +445,9 @@ int main(int argc, char *argv[])
 
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
 
-	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+	sync_global_to_guest(vm, x2apic);
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
 
 	params[1].vcpu = vm_vcpu_add(vm, 1, sender_guest_code);
 
-- 
2.34.1


