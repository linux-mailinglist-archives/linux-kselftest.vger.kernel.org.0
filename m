Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDE424820
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhJFUme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:42:34 -0400
Received: from mail-dm6nam10hn2213.outbound.protection.outlook.com ([52.100.156.213]:10241
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232147AbhJFUmd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:42:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdHSeHBmcLx/La4QAybFyYu/Ygkh95IRaJYf5uqBAmIM3tyeTCdYJP0aUZOdUOeCSNz5JaVCupwQodtMm8pY6u2EI4MYt/SDhm+fjXks+2s7qUyskJ2hifiUghi2Y1vZOs2pU8E1f8d1QS8ZmJHjk9n21bHgGmT2poBhuRWHX9Yo0OQtk3NxBLHn2GPGt1eUZYNF4v8Ya6wOS9gRWa0SLhUgY48Hx5NcJAciWN9X13dksICmZ0MtgA2o4HESm0Z4kzqqThNLjuIHZ7OD0FJIA9e96mpbyatCbQH66uv0BI/Tj8Gybe7axuyVaeF8m/qdyXZT5rtSNc5e5QeKBkEs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ren96GO9wngZmjxYyjT/gv27SJ8sMV65hEgBq1k8JcA=;
 b=BUmPqqVNv0iqvn4IFNTn693Vxorks7N2eBdzLTUYVf9spAgv9cIIwvB9icZSoYEnelhlZL2g5Ci5NR4QNXIhupn5R3pi6IjralKJqcGYQpRKT79fhBTp11+qOCmXxUKQSHsbnwPPF0PA4jgilh4TzljGhG2ByI5xSSPz13koL3O+C/BqkNrl3ihswEaSeJW0u32xy5wKGw/LCrqKdWzCbwJjIxW2XVB4Ru9n94V662mzC7AYfht/zgBT2VeWJW1X3b+mc9bJC1AqwIgzeQlU2yVcmqLrn8nEdCXeRAMzORPMEDFrXTtH7f8QE3MRTZvZ2FMIVDGw36BaavWROyv4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ren96GO9wngZmjxYyjT/gv27SJ8sMV65hEgBq1k8JcA=;
 b=McgPK76RA2McAWt8eLfKsH6AJi0oR9cEzwLih69V7NS+y3jEX+OfsKWJ/bG3lWWFoq0nSwFkawc+hrxRl+tmrwmOHHOctUY4XrMWKddxk8ssf3a0uyQSBGp39ZIO4ifC2ZoiOrQghSejujUK3QILUq1pNeOlMwwrtaQgpANhfZk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Wed, 6 Oct
 2021 20:40:39 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:40:38 +0000
From:   Michael Roth <michael.roth@amd.com>
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [RFC 07/16] KVM: selftests: add SEV boot tests
Date:   Wed,  6 Oct 2021 15:37:26 -0500
Message-Id: <20211006203726.13402-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:803:2e::34) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN4PR0201CA0048.namprd02.prod.outlook.com (2603:10b6:803:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 20:40:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9dc4685-8d82-488a-03d3-08d989098e66
X-MS-TrafficTypeDiagnostic: CH2PR12MB4264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4264D14534C36DCE5468616995B09@CH2PR12MB4264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vjwPOLOjAcz4Ze3wdYJwJSeM7U0HXTt6WZzteHw6qpWHJf0FrRy3AVpiJF2H?=
 =?us-ascii?Q?Sg1opkD8WBbcvGU4vobsfTSGZtc433Gc5kyR4Ru0RNR+jenfTEzNgQEBHLOx?=
 =?us-ascii?Q?j0CEn7ffTjma15loCHaLAYCyzApPr3h1eNpcoSR4ouLDDO/nw6KYLl3T/+7t?=
 =?us-ascii?Q?r9S4ZVzbwmXz5tQOcfDIS6F966uQ/ttCkcUz0JXSghTlzIqSKNdVRCxG7/T1?=
 =?us-ascii?Q?gQYLgDbt7fmZBkAcIXFMCsCBZUcRsinxmM0TfLqHoxz89k/bdUmnIj/sXsXq?=
 =?us-ascii?Q?WCcTRHJPDU3pVWTz/EemR1mH0mRcKFdcMsKeuwzqo0T/RINYxWhjFhUrFdYg?=
 =?us-ascii?Q?0RIwjysQ/i++gedrlbHXD6k9El/Dcvy64UeBi6gU2h3MsZy/hRzL988S1hat?=
 =?us-ascii?Q?qA2Odbl6ikhIU4y/KWieOz/bSbQ+9SlAUvl/RsU9IKsKLwDb+Nb7YsOpzR/8?=
 =?us-ascii?Q?6IR9+rVdnIWemyWahgeRvJdRvgrV2SsHF1hU5xRAvBOYN31tvQxmtSRsTIcv?=
 =?us-ascii?Q?1pDfOlLI9PwiNZVHVM0z7fn2aFIFtuNJ0/eYYzm2Dc/qGxj+4M+CxfGZina8?=
 =?us-ascii?Q?T9GCC3hK1qSO2DMXPiOIvNs1ZnwGDDsHh2fFaMJfIo8JBqpkELzC8ujn3mjb?=
 =?us-ascii?Q?MHWMrdjqd3EK6RwO9w82N2K1J8Wl9kBh2J2TdlKkAklPWk8bC4ArHGb9KqR2?=
 =?us-ascii?Q?i99T7oaLrw2fbHt4rSnIPlBuDKnKVUd6HHWVAZJUOY5S2KjAc4LCF9TGaep4?=
 =?us-ascii?Q?eu3aP37G4mBHCMJMQbc4mcOcmwePWRNhe7H2PvmB3Uw/wIFH4X3lXjKgfQUL?=
 =?us-ascii?Q?3NWjF+vrk25QSBufZyUPiW0OL8++uW+CIwGEDYcKRPOjQUboVVUBx4NQ28kc?=
 =?us-ascii?Q?eoaLNbqM96saAwnWm/TeXU4LdL9Qiu3dVIdnmVPfTYoTdEL4SowMAX3Bri2V?=
 =?us-ascii?Q?NnbkTSqorb967ZhWmOFtl41IfycIUXeLMLkCr0puCMINsdejzsRc7Q1Iyhct?=
 =?us-ascii?Q?lriXro/TTu9wjm6FPzCwFHgpF21YD+8ubX2lEC4iANcGF2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(86362001)(7416002)(36756003)(6916009)(1076003)(316002)(66946007)(66556008)(26005)(8676002)(956004)(44832011)(186003)(66476007)(4326008)(6496006)(52116002)(508600001)(83380400001)(2906002)(6486002)(38100700002)(8936002)(2616005)(38350700002)(6666004)(54906003)(5660300002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8hvlq0AgQMnRHIY3tKoIPX5nxhIpTioUMYMMbNfzThGlBbKRY7H0DM57Nvm?=
 =?us-ascii?Q?oJIxkCsbKSb8uBdGPjc7pXM29HUj8wpiQEhdzmiRXBJ8dp9QZ5XqHo8q936C?=
 =?us-ascii?Q?sWinXjUqaKclaz342MzyXDc+6DqZbtQTLmf+AOJLirK/eEBDAoPT23aZWHBh?=
 =?us-ascii?Q?+cVKYBKoAWLRXZYX6+uHg6XQ8mTWrfsZ/psqKSK7szU3QrOQXyb1tbN6O9dw?=
 =?us-ascii?Q?JdWtWAbWj68FBFwlG2q2jVFZhMcZ6o2tvrxL4LURQoHj8Pol8cELMOa/l7bi?=
 =?us-ascii?Q?PKjqDbQP6y/kfDLHhpDaqMZMF1JvchZAG4ZdkFy1eoRFHYeQjwCZiToGofXm?=
 =?us-ascii?Q?cY5PTmFnFRU23AQueMwzE44zRvRR5CPjMQUDVsYrwINdcpggUhOtlVR4yidK?=
 =?us-ascii?Q?gYSO7iLkcDUuN1spm/By6McLflhrKIBCQPxBpm8VmqAJFIuNvB7Nw5Y/vytI?=
 =?us-ascii?Q?bCWWv5Fp+Reb2mETzdkSRV1ZoszXq0Tgekfd6oLNHrwBBCylITVQU38tM/Ry?=
 =?us-ascii?Q?/jQjrD7CzuVe/rIwppF0iVTkL8Waj+V+7mo8Jq64ygapPQ/wL5OnTFeza0vI?=
 =?us-ascii?Q?/qWxQIuOnN0KkoqH56nnxsLQIZ4cF1s5Xs8j+fQPlvNYISsYpCYLQeP7in67?=
 =?us-ascii?Q?zBGt7eV14sofV7JmvqEL50I9LU7fZXsxBFMVkqNzakGPsqHU/rpFiAJGgkEJ?=
 =?us-ascii?Q?9C8qY4IwDG0AYRnIBEimFt3MPkEAVIyafE00hB5lm1MswlCcm8ErIH6kAKAT?=
 =?us-ascii?Q?uUexcZ55hsTSR6ByPG9SaZkSS8Y/F5lg9aCnb85OkIANRvYZQaFYYAt4O8M7?=
 =?us-ascii?Q?wR7+6vqNkQbmo4epP2hQoJSK/ErVMsBOg6Ns37Su4ffsuu+Dqj4osRWsZaYG?=
 =?us-ascii?Q?IBRaobMn7mYow1afNkJigF4TtKfOcIaEzfqTrmxMiPQrxcf8SMNKaf5yJW+m?=
 =?us-ascii?Q?hFGusZ4g1P6cL4vdATHzawSynWSul/GfdUbcuRwuyM5Ikndf0sEfY0MQr2Iz?=
 =?us-ascii?Q?x6KyhUkq2SA5uCGokS2n6tem9bIoTitrHcGxnnXBRhAYlF0svhqkgbuVo9Or?=
 =?us-ascii?Q?DvmCV/fahZqRNYvlwvMAuZxogbyk7zMWG2mRh6K+gDZcmz8egjBcNcIvPM8a?=
 =?us-ascii?Q?wAC2MZS8yH9VjWy918Sn8KGsCh3kIctNyMokcuNCULLdKMNnID5vpl6WEtFI?=
 =?us-ascii?Q?qB7V7vuuIS02aKaBjXvCtP25xI04KLSH7Bf45z8jGFttGt9eTxirpaZ0nxqs?=
 =?us-ascii?Q?r3pzkM/3iejEN1bXiFoteySKJ2ukKCA60OlOJnSWNqkegWBXUqarh+YU5mg+?=
 =?us-ascii?Q?qqK2H+eMo0HpurfniHACjXNs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dc4685-8d82-488a-03d3-08d989098e66
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:40:38.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuZ0gJUmNEPxI539TbEukI3f4qvkMwfe7IP5CwV1EmdgV5A30nRxW0QFQ506MzxZ2mNuDFJqAwRrbzj4KuWAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A common aspect of booting SEV guests is checking related CPUID/MSR
bits and accessing shared/private memory. Add a basic test to cover
this.

This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
subsequent patches.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 252 ++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 0709af0144c8..824f100bec2a 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -38,6 +38,7 @@
 /x86_64/xen_vmcall_test
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_msrs_test
+/x86_64/sev_all_boot_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c7a5e1c69e0c..aa8901bdbd22 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
new file mode 100644
index 000000000000..8df7143ac17d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Basic SEV boot tests.
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "linux/psp-sev.h"
+#include "sev.h"
+
+#define VCPU_ID			2
+#define PAGE_SIZE		4096
+#define PAGE_STRIDE		32
+
+#define SHARED_PAGES		8192
+#define SHARED_VADDR_MIN	0x1000000
+
+#define PRIVATE_PAGES		2048
+#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
+
+#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
+
+static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
+{
+	int i, j;
+
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < PAGE_SIZE; j += stride)
+			buf[i * PAGE_SIZE + j] = val;
+}
+
+static bool check_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
+{
+	int i, j;
+
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < PAGE_SIZE; j += stride)
+			if (buf[i * PAGE_SIZE + j] != val)
+				return false;
+
+	return true;
+}
+
+static void guest_test_start(struct sev_sync_data *sync)
+{
+	/* Initial guest check-in. */
+	sev_guest_sync(sync, 1, 0);
+}
+
+static void check_test_start(struct kvm_vm *vm, struct sev_sync_data *sync)
+{
+	struct kvm_run *run;
+
+	run = vcpu_state(vm, VCPU_ID);
+	vcpu_run(vm, VCPU_ID);
+
+	/* Initial guest check-in. */
+	sev_check_guest_sync(run, sync, 1);
+}
+
+static void
+guest_test_common(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
+{
+	bool success;
+
+	/* Initial check-in for common. */
+	sev_guest_sync(sync, 100, 0);
+
+	/* Ensure initial shared pages are intact. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
+	SEV_GUEST_ASSERT(sync, 103, success);
+
+	/* Ensure initial private pages are intact/encrypted. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+	SEV_GUEST_ASSERT(sync, 104, success);
+
+	/* Ensure host userspace can't read newly-written encrypted data. */
+	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
+
+	sev_guest_sync(sync, 200, 0);
+
+	/* Ensure guest can read newly-written shared data from host. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
+	SEV_GUEST_ASSERT(sync, 201, success);
+
+	/* Ensure host can read newly-written shared data from guest. */
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
+
+	sev_guest_sync(sync, 300, 0);
+}
+
+static void
+check_test_common(struct kvm_vm *vm, struct sev_sync_data *sync,
+		  uint8_t *shared_buf, uint8_t *private_buf)
+{
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	bool success;
+
+	/* Initial guest check-in. */
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 100);
+
+	/* Ensure initial private pages are intact/encrypted. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 200);
+
+	/* Ensure host userspace can't read newly-written encrypted data. */
+	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
+	TEST_ASSERT(!success, "Modified guest memory not encrypted!");
+
+	/* Ensure guest can read newly-written shared data from host. */
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 300);
+
+	/* Ensure host can read newly-written shared data from guest. */
+	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
+	TEST_ASSERT(success, "Host can't read shared guest memory!");
+}
+
+static void
+guest_test_done(struct sev_sync_data *sync)
+{
+	sev_guest_done(sync, 10000, 0);
+}
+
+static void
+check_test_done(struct kvm_vm *vm, struct sev_sync_data *sync)
+{
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_done(run, sync, 10000);
+}
+
+static void __attribute__((__flatten__))
+guest_sev_code(struct sev_sync_data *sync, uint8_t *shared_buf, uint8_t *private_buf)
+{
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t sev_status;
+
+	guest_test_start(sync);
+
+	/* Check SEV CPUID bit. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	SEV_GUEST_ASSERT(sync, 2, eax & (1 << 1));
+
+	/* Check SEV MSR bit. */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	SEV_GUEST_ASSERT(sync, 3, (sev_status & 0x1) == 1);
+
+	guest_test_common(sync, shared_buf, private_buf);
+
+	guest_test_done(sync);
+}
+
+static void
+setup_test_common(struct sev_vm *sev, void *guest_code, vm_vaddr_t *sync_vaddr,
+		  vm_vaddr_t *shared_vaddr, vm_vaddr_t *private_vaddr)
+{
+	struct kvm_vm *vm = sev_get_vm(sev);
+	uint8_t *shared_buf, *private_buf;
+
+	/* Set up VCPU and initial guest kernel. */
+	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	/* Set up shared sync buffer. */
+	*sync_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
+
+	/* Set up buffer for reserved shared memory. */
+	*shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
+					      SHARED_VADDR_MIN);
+	shared_buf = addr_gva2hva(vm, *shared_vaddr);
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
+
+	/* Set up buffer for reserved private memory. */
+	*private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
+					PRIVATE_VADDR_MIN);
+	private_buf = addr_gva2hva(vm, *private_vaddr);
+	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
+}
+
+static void test_sev(void *guest_code, uint64_t policy)
+{
+	vm_vaddr_t sync_vaddr, shared_vaddr, private_vaddr;
+	uint8_t *shared_buf, *private_buf;
+	struct sev_sync_data *sync;
+	uint8_t measurement[512];
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+	int i;
+
+	sev = sev_vm_create(policy, TOTAL_PAGES);
+	if (!sev)
+		return;
+	vm = sev_get_vm(sev);
+
+	setup_test_common(sev, guest_code, &sync_vaddr, &shared_vaddr, &private_vaddr);
+
+	/* Set up guest params. */
+	vcpu_args_set(vm, VCPU_ID, 4, sync_vaddr, shared_vaddr, private_vaddr);
+
+	sync = addr_gva2hva(vm, sync_vaddr);
+	shared_buf = addr_gva2hva(vm, shared_vaddr);
+	private_buf = addr_gva2hva(vm, private_vaddr);
+
+	/* Allocations/setup done. Encrypt initial guest payload. */
+	sev_vm_launch(sev);
+
+	/* Dump the initial measurement. A test to actually verify it would be nice. */
+	sev_vm_measure(sev, measurement);
+	pr_info("guest measurement: ");
+	for (i = 0; i < 32; ++i)
+		pr_info("%02x", measurement[i]);
+	pr_info("\n");
+
+	sev_vm_launch_finish(sev);
+
+	/* Guest is ready to run. Do the tests. */
+	check_test_start(vm, sync);
+	check_test_common(vm, sync, shared_buf, private_buf);
+	check_test_done(vm, sync);
+
+	sev_vm_free(sev);
+}
+
+int main(int argc, char *argv[])
+{
+	/* SEV tests */
+	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_code, 0);
+
+	return 0;
+}
-- 
2.25.1

