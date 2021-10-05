Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E94234A4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhJEXsb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:48:31 -0400
Received: from mail-bn8nam11hn2217.outbound.protection.outlook.com ([52.100.171.217]:8641
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237240AbhJEXsH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:48:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAE1+BeUwCym5tr3UcdT9gvtJN/cbxZuvReH0Uk334mYWa+izijZ2LsrQeree/suomH0PWw3h3u/37QmCIqkcKGB6mhHAm7TuVP0I/LH13Ju35eeo3Lwglkvws47xLgabFXE8T0Be051YaYjni/TowcukQslBbOyT5WYrDH/h0EbOnMGIVOdnuqC6NX2NjJd9Pq5aKCk029ZsYko0yYe9hQ7+badPgjYuzyYJeIm0qJ0Zp5Oh6ZO8BLrNtNln5h8auOJQ8sL/CLEUDqVBvGVj28uCdpw5HANCDL55DW7NNwHXGz6xaa5OuhivwAuGmD1BVi7m9d74lWpzU9+wCSA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBVg4Filp1xn8ZowPTaMrMyh17Zi4wOJlTQEV8OVZZ0=;
 b=mxewDvH3zXqfVY71valu68jrkWMh9+WFv01ripMccv8ExK9NjBwMKpjbyFsj+fDwnq0K+BeagWlrlNLU51GJ0uK8THLg/QAPz2tcMXM3v5j41MEgxX1H6zAWSrGoKk5pzRc0+RDTwbCsgx1RP6msFilIMrfhIffUa6tromsbyKf24As+aJY/cOPLBI8cwfeUJSwEdYM86lU6oqzCmDm+u2hE5rS3VH+RMoNdWgwkhEJmG4bpQbCL0uZjPnyTzo//I7KsA40TX+8JAWC0lDgFF5Ocj0gXeGMBBtEKgpgiHhRefVMB8JRhNdg4HOy+Ru3LN445bAlTL/IMT06PVqXMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBVg4Filp1xn8ZowPTaMrMyh17Zi4wOJlTQEV8OVZZ0=;
 b=rChr1hSg8AYXNsRKKRLaLIvaIyuI1l059CI8pOb+xjanhUSzrSE2oAvH0YZggnDO2kYvvTAhkhcVWvgxDxfOLiqf66NX30oerCtmN1zo0kDftlOH5NZ564FKqp568Ti+LELRq90rjun1KEToyU9XHWfjIS06ZzPWxYEhHoSWF8o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:58 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:58 +0000
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
Subject: [RFC 16/16] KVM: selftests: add SEV-SNP tests for page-state changes
Date:   Tue,  5 Oct 2021 18:44:59 -0500
Message-Id: <20211005234459.430873-17-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:806:6f::12) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA0PR12CA0007.namprd12.prod.outlook.com (2603:10b6:806:6f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 23:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff2a08d-5bd3-4bb3-539f-08d9885a4793
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925F4702C5B86D11AF5050795AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HC2nK3t+jm2U4hd++jGfU5QJdAzuyq91n7TVZGGeP2cXxxoUqDiokbI9Z4yd?=
 =?us-ascii?Q?rmma0pn5UVnu3TOb9gWDPtZzc3zCAoC0RGTE/wqNB44UoF/FPlbOdu5lEeD8?=
 =?us-ascii?Q?tqSPrtiZ9JenIIoOlQdP7OwisIpzLr+1fdbSH1Mwp+99Vn496iQv55DB1iHo?=
 =?us-ascii?Q?fNga+dTEQkI52OA/wcg6JQAvu6PMcoycdKdwfLhj/9ceKavWSriLiQk0ti+V?=
 =?us-ascii?Q?cC+v2gr7hroYKo3VTAXhso+Mm+Kg3HAcg3RtTf3/vYFpdFp6jz3AQVp+dfxS?=
 =?us-ascii?Q?v2JO6RPqrvV+wvzzPsYx1VqDENeySD4TMxHFDWmnt4MBNxHA3v24f/ez1M9N?=
 =?us-ascii?Q?bIcBQ4KfHgguGWnsDjaIW2eO/gE5W/dDPZ0786FKAh/gstlZb4j2kTeK9M7f?=
 =?us-ascii?Q?I4ZQlaAtHZ/oZ5K30fz9nIqk148Wq6tZ1sgOmOZEhXya1Zg1dYDaR3fRSonU?=
 =?us-ascii?Q?ia1d+TL4M9aF6rWKjjiODXI0b5fcUKapDwFkDsVa3NS/KpNKTpolv4xL/BZ9?=
 =?us-ascii?Q?v+hOmmBMebDO86Fk46vy67vEwr82bzQN+6BGXwda53GFehpY3q9OktGBLmm8?=
 =?us-ascii?Q?lq2P9H04umwj8FvI2Oqt/tUMIcGN+U+m4gV2UJZxP76eAJh9fGI9RqbdME/Y?=
 =?us-ascii?Q?sEWe6LyjgE9VDmgfwx1A7HxMjeAgKCMpup6HsspjGwjLS+d062+Cw9pGm9n+?=
 =?us-ascii?Q?oLyNyvkDOkev/S/nYv8xg+E7OmMEErdSUvv22BUTUKF8YT0wENVLiZcLjDSo?=
 =?us-ascii?Q?330ZW/ASSH1n6c5Mc0mRBxzD5UnIdDJRn4D6089h3LuNc5BLieE/jBby9mmn?=
 =?us-ascii?Q?Xk6ozLqnOhMKN2GarO1itXnuf19vQpPvty6PFMpRVBPzXkGQnpZgfOdomqjc?=
 =?us-ascii?Q?E/xeomtDmYU8JvCuVLyNskh1eunI7/ylfAAIBd+NjcDCnB5IWa7M8B7OdRWw?=
 =?us-ascii?Q?SF2Sp6RZgJNdBrG5XQmwdhyCrPtemzWa971/4vqeZxukNhONCCeZgvUwl/s+?=
 =?us-ascii?Q?PPAfmkAzjeQalsQMqBox9TqU7qGAYJoJy4l6owlXyU/zCpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(30864003)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRjvnVX3M6YQOWgo9bvXAOdWPj/DT+0cgvEgX2WQcTv79GuUmkssymMNta/t?=
 =?us-ascii?Q?tdCY/9zTDM37HYaOobnDikerJCkqxooz3x7pvsYOAxk3HBZk1u+FBUq0k0DA?=
 =?us-ascii?Q?nW59a9XR0FoRcOCdiM8lna5OfsjPOqrlkwftbBI1GwXPXyBFXyQtncmo4yys?=
 =?us-ascii?Q?dUMnU6U9SEXXKyJSPjqE+D5eO5zh0/R12jJqRd3LBdAwWHY5E2Y2ksUAdtLZ?=
 =?us-ascii?Q?qgUIYeq3mpeC0iZGzjHadFmvBnWLBGYWNcOnmK2cPsL4feG3r1JnTf+Heihq?=
 =?us-ascii?Q?l9QlUq6S9kmuP6ffWPP3IUajKRUIMYCFcI4qYXIkv0UPBYdknYYtaZH6bmNd?=
 =?us-ascii?Q?FqDO/u9Uu32kZg2anRDAfXdPO4YVmXCGmnyvNPbt9xf1oD3p8MU/pILRGmxz?=
 =?us-ascii?Q?uF1xFMQtIxKXLn3A1SwA9VtKWDsX+DRkQ7JRTs1+R1Gx+IDFnqW1qO5Ahije?=
 =?us-ascii?Q?hyJxnbx6DG0lYdvt755C9dbJDGVyUuDPHj3AVpyOHdwW+16uaOg92eqksTXb?=
 =?us-ascii?Q?ybPKTq8NoUocYQJ5YEvd0WpsxAkhIsSwnoiIRuErHY3InNvZlvvqWIxfuURK?=
 =?us-ascii?Q?V9RbPsgyOlxmGb8aYqm8l+4Z1uEP+Haimdu0Yh5sjKJkMTE47fFGbnMS+xVc?=
 =?us-ascii?Q?wYfk0nd2smqKblyN1Z7HIWO6r5KHlbihdL7ho+RNmhpxlie+G3jALjecF3lu?=
 =?us-ascii?Q?6sDK+5DKBKOkL5bMBm+DrAniwYa3CLyU5GyHDDfgsAK3wQnfxeuQXzErtlOo?=
 =?us-ascii?Q?LMsodcrnrc8M95DuqqMQa4ncMpRxm52ZSs/keKJ246H7KEfRXvMP4xX4niMZ?=
 =?us-ascii?Q?r0fgkb6SqEU+euXR0Fbzr/uuvCUM2098y8B8WYtdCR8bxLLkXg2r53Ibp7lC?=
 =?us-ascii?Q?Kw5/dDS2P3AusVYM6KO2WaBuclv61qdiCBrBzgq4ha1Q/ZqSe7t3jw8NHWGz?=
 =?us-ascii?Q?kM+H3mEgqRY+n41aw+rSaUGShfWNU9XjXOWdyYy9+YzGlnTjsyMB3kNOFiff?=
 =?us-ascii?Q?2bsOcxtTI2BsOCHf7KEyl0BPWRAqi7Y+nOeHt/QaF8x4JRQcdOyA20R+h7Pm?=
 =?us-ascii?Q?bgHgp/fTtmMiQOaaU6S0VCiuWsaAQZdZXZALq1h9o6b0zbCSncu5abA6uJBP?=
 =?us-ascii?Q?ZrSr0yMdohUE8Ky8r81MOBo0S2+l5hgtdUV051QYAo8VsYoVTmLRyeY6LhJ2?=
 =?us-ascii?Q?WxIj/c+0uhWfnTMPSjwqzSlQjuPxuFm6K2MfSz2/iytvLVmgjrDvARExuixR?=
 =?us-ascii?Q?B3ShJFCS5cKBukTpwJrIWW39+KLKl5dzmvF8rQhCHOtYwBe9JcwDCb2Zy05p?=
 =?us-ascii?Q?53nM6pujaqHvxRYNoOuH6BE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2a08d-5bd3-4bb3-539f-08d9885a4793
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:58.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H4GIFWkK6mn9BvIJnp/L8/GjJJtWZrVysc1amD0Tuuv+H+KEp5wFdvYLEwDoxpzaXzEdlLhzwRdyX2mo2aC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With SEV-SNP guests memory is marked as private/shared or
validated/un-validated in the RMP table. Transitioning memory between
these states can be done within a guest via pvalidate instructions and
the page-state changes via GHCB protocol. Add a number of tests to
cover various permutations of the operations across shared/private
guest memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/sev_snp_psc_test.c   | 378 ++++++++++++++++++
 3 files changed, 380 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 824f100bec2a..cad9ebe7728d 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -39,6 +39,7 @@
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_msrs_test
 /x86_64/sev_all_boot_test
+/x86_64/sev_snp_psc_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 7b3261cc60a3..b95fb86f12aa 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -73,6 +73,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_snp_psc_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c b/tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c
new file mode 100644
index 000000000000..695abcd14792
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SEV-SNP tests for pvalidate and page-state changes.
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
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "linux/psp-sev.h"
+#include "sev.h"
+#include "sev_exitlib.h"
+
+#define VCPU_ID			0
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(1UL << PAGE_SHIFT)
+#define PAGE_STRIDE		64
+
+/* NOTE: private/shared pages must each number at least 4 and be power of 2. */
+
+#define SHARED_PAGES		512
+#define SHARED_VADDR_MIN	0x1000000
+
+#define PRIVATE_PAGES		512
+#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
+
+#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
+#define LINEAR_MAP_GVA		(PRIVATE_VADDR_MIN + PRIVATE_PAGES * PAGE_SIZE)
+
+struct pageTableEntry {
+	uint64_t present:1;
+	uint64_t ignored_11_01:11;
+	uint64_t pfn:40;
+	uint64_t ignored_63_52:12;
+};
+
+/* Globals for use by #VC handler and helpers. */
+static int page_not_validated_count;
+static struct sev_sync_data *guest_sync;
+static uint8_t enc_bit;
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
+static bool check_buf_nostop(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
+{
+	bool matches = true;
+	int i, j;
+
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < PAGE_SIZE; j += stride)
+			if (buf[i * PAGE_SIZE + j] != val)
+				matches = false;
+	return matches;
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
+static void vc_handler(struct ex_regs *regs)
+{
+	int ret;
+
+	if (regs->error_code == SVM_EXIT_NOT_VALIDATED) {
+		unsigned long gva;
+
+		page_not_validated_count++;
+
+		asm volatile("mov %%cr2,%0" : "=r" (gva));
+		ret = snp_pvalidate((void *)gva, 0, true);
+		SEV_GUEST_ASSERT(guest_sync, 9001, !ret);
+
+		return;
+	}
+
+	ret = sev_es_handle_vc(NULL, 0, regs);
+	SEV_GUEST_ASSERT(guest_sync, 20000 + regs->error_code, !ret);
+}
+
+#define gpa_mask(gpa) (gpa & ~(1ULL << enc_bit))
+#define gfn_mask(gfn) (gfn & ~((1ULL << enc_bit) >> PAGE_SHIFT))
+#define va(gpa) ((void *)(LINEAR_MAP_GVA + (gpa & ~(1ULL << enc_bit))))
+#define gfn2va(gfn) va(gfn_mask(gfn) * PAGE_SIZE)
+
+static void set_pte_bit(void *ptr, uint8_t pos, bool enable)
+{
+	struct pageTableEntry *pml4e, *pdpe, *pde, *pte;
+	uint16_t index[4];
+	uint64_t *pte_val;
+	uint64_t gva = (uint64_t)ptr;
+
+	index[0] = (gva >> 12) & 0x1FFU;
+	index[1] = (gva >> 21) & 0x1FFU;
+	index[2] = (gva >> 30) & 0x1FFU;
+	index[3] = (gva >> 39) & 0x1FFU;
+
+	pml4e = (struct pageTableEntry *)va(gpa_mask(get_cr3()));
+	SEV_GUEST_ASSERT(guest_sync, 1001, pml4e[index[3]].present);
+
+	pdpe = (struct pageTableEntry *)gfn2va(pml4e[index[3]].pfn);
+	SEV_GUEST_ASSERT(guest_sync, 1002, pdpe[index[2]].present);
+
+	pde = (struct pageTableEntry *)gfn2va(pdpe[index[2]].pfn);
+	SEV_GUEST_ASSERT(guest_sync, 1003, pde[index[1]].present);
+
+	pte = (struct pageTableEntry *)gfn2va(pde[index[1]].pfn);
+	SEV_GUEST_ASSERT(guest_sync, 1004, pte[index[0]].present);
+
+	pte_val = (uint64_t *)&pte[index[0]];
+	if (enable)
+		*pte_val |= (1UL << pos);
+	else
+		*pte_val &= ~(1UL << pos);
+
+	asm volatile("invlpg (%0)" ::"r" (gva) : "memory");
+}
+
+static void guest_test_psc(uint64_t shared_buf_gpa, uint8_t *shared_buf,
+			   uint64_t private_buf_gpa, uint8_t *private_buf)
+{
+	bool success;
+	int rc, i;
+
+	sev_guest_sync(guest_sync, 100, 0);
+
+	/* Flip 1st half of private pages to shared and verify VMM can read them. */
+	for (i = 0; i < (PRIVATE_PAGES / 2); i++) {
+		rc = snp_pvalidate(&private_buf[i * PAGE_SIZE], 0, false);
+		SEV_GUEST_ASSERT(guest_sync, 101, !rc);
+		snp_psc_set_shared(private_buf_gpa + i * PAGE_SIZE);
+		set_pte_bit(&private_buf[i * PAGE_SIZE], enc_bit, false);
+	}
+	fill_buf(private_buf, PRIVATE_PAGES / 2, PAGE_STRIDE, 0x43);
+
+	sev_guest_sync(guest_sync, 200, 0);
+
+	/*
+	 * Flip 2nd half of private pages to shared and hand them to the VMM.
+	 *
+	 * This time leave the C-bit set, which should cause a 0x404
+	 * (PAGE_NOT_VALIDATED) #VC when guest later attempts to access each
+	 * page.
+	 */
+	for (i = PRIVATE_PAGES / 2; i < PRIVATE_PAGES; i++) {
+		rc = snp_pvalidate(&private_buf[i * PAGE_SIZE], 0, false);
+		if (rc)
+			sev_guest_abort(guest_sync, rc, 0);
+		snp_psc_set_shared(private_buf_gpa + i * PAGE_SIZE);
+	}
+
+	sev_guest_sync(guest_sync, 300, 0);
+
+	/*
+	 * VMM has filled up the newly-shared pages, but C-bit is still set, so
+	 * verify the contents still show up as encrypted, and make sure to
+	 * access each to verify #VC records the PAGE_NOT_VALIDATED exceptions.
+	 */
+	WRITE_ONCE(page_not_validated_count, 0);
+	success = check_buf_nostop(&private_buf[(PRIVATE_PAGES / 2) * PAGE_SIZE],
+				   PRIVATE_PAGES / 2, PAGE_STRIDE, 0x44);
+	SEV_GUEST_ASSERT(guest_sync, 301, !success);
+	SEV_GUEST_ASSERT(guest_sync, 302,
+			 READ_ONCE(page_not_validated_count) == (PRIVATE_PAGES / 2));
+
+	/* Now flip the C-bit off and verify the VMM-provided values are intact. */
+	for (i = PRIVATE_PAGES / 2; i < PRIVATE_PAGES; i++)
+		set_pte_bit(&private_buf[i * PAGE_SIZE], enc_bit, false);
+	success = check_buf(&private_buf[(PRIVATE_PAGES / 2) * PAGE_SIZE],
+			    PRIVATE_PAGES / 2, PAGE_STRIDE, 0x44);
+	SEV_GUEST_ASSERT(guest_sync, 303, success);
+
+	/* Flip the 1st half back to private pages. */
+	for (i = 0; i < (PRIVATE_PAGES / 2); i++) {
+		snp_psc_set_private(private_buf_gpa + i * PAGE_SIZE);
+		set_pte_bit(&private_buf[i * PAGE_SIZE], enc_bit, true);
+		rc = snp_pvalidate(&private_buf[i * PAGE_SIZE], 0, true);
+		SEV_GUEST_ASSERT(guest_sync, 304, !rc);
+	}
+	/* Pages are private again, write over them with new encrypted data. */
+	fill_buf(private_buf, PRIVATE_PAGES / 2, PAGE_STRIDE, 0x45);
+
+	sev_guest_sync(guest_sync, 400, 0);
+
+	/*
+	 * Take some private pages and flip the C-bit off. Subsequent access
+	 * should cause an RMP fault, which should lead to the VMM doing a
+	 * PSC to shared on our behalf.
+	 */
+	for (i = 0; i < (PRIVATE_PAGES / 4); i++)
+		set_pte_bit(&private_buf[i * PAGE_SIZE], enc_bit, false);
+	fill_buf(private_buf, PRIVATE_PAGES / 4, PAGE_STRIDE, 0x46);
+
+	sev_guest_sync(guest_sync, 500, 0);
+
+	/* Flip all even-numbered shared pages to private. */
+	for (i = 0; i < SHARED_PAGES; i++) {
+		if ((i % 2) != 0)
+			continue;
+
+		snp_psc_set_private(shared_buf_gpa + i * PAGE_SIZE);
+		set_pte_bit(&shared_buf[i * PAGE_SIZE], enc_bit, true);
+		rc = snp_pvalidate(&shared_buf[i * PAGE_SIZE], 0, true);
+		SEV_GUEST_ASSERT(guest_sync, 501, !rc);
+	}
+
+	/* Write across the entire range and hand it back to VMM to verify. */
+	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x47);
+
+	sev_guest_sync(guest_sync, 600, 0);
+}
+
+static void check_test_psc(struct kvm_vm *vm, struct sev_sync_data *sync,
+			   uint8_t *shared_buf, uint8_t *private_buf)
+{
+	struct kvm_run *run = vcpu_state(vm, VCPU_ID);
+	bool success;
+	int i;
+
+	/* Initial check-in for PSC tests. */
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 100);
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 200);
+
+	/* 1st half of private buffer should be shared now, check contents. */
+	success = check_buf(private_buf, PRIVATE_PAGES / 2, PAGE_STRIDE, 0x43);
+	TEST_ASSERT(success, "Unexpected contents in newly-shared buffer.");
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 300);
+
+	/* 2nd half of private buffer should be shared now, write to it. */
+	fill_buf(&private_buf[(PRIVATE_PAGES / 2) * PAGE_SIZE],
+		 PRIVATE_PAGES / 2, PAGE_STRIDE, 0x44);
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 400);
+
+	/* 1st half of private buffer should no longer be shared. Verify. */
+	success = check_buf(private_buf, PRIVATE_PAGES / 2, PAGE_STRIDE, 0x45);
+	TEST_ASSERT(!success, "Unexpected contents in newly-private buffer.");
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 500);
+
+	/* 1st quarter of private buffer should be shared again. Verify. */
+	success = check_buf(private_buf, PRIVATE_PAGES / 4, PAGE_STRIDE, 0x46);
+	TEST_ASSERT(success, "Unexpected contents in newly-shared buffer.");
+
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 600);
+
+	/* Verify even-numbered pages in shared_buf are now private. */
+	for (i = 0; i < SHARED_PAGES; i++) {
+		success = check_buf(&shared_buf[i * PAGE_SIZE], 1, PAGE_STRIDE, 0x47);
+		if ((i % 2) == 0)
+			TEST_ASSERT(!success, "Private buffer contains plain-text.");
+		else
+			TEST_ASSERT(success, "Shared buffer contains cipher-text.");
+	}
+}
+
+static void __attribute__((__flatten__))
+guest_code(struct sev_sync_data *sync, uint64_t shared_buf_gpa, uint8_t *shared_buf,
+	   uint64_t private_buf_gpa, uint8_t *private_buf)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	/* Initial check-in. */
+	guest_sync = sync;
+	sev_guest_sync(guest_sync, 1, 0);
+
+	/* Get encryption bit via CPUID. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	enc_bit = ebx & 0x3F;
+
+	/* Do the tests. */
+	guest_test_psc(shared_buf_gpa, shared_buf, private_buf_gpa, private_buf);
+
+	sev_guest_done(guest_sync, 10000, 0);
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t shared_vaddr, private_vaddr, sync_vaddr;
+	uint8_t *shared_buf, *private_buf;
+	struct sev_sync_data *sync;
+	struct kvm_run *run;
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+
+	/* Create VM and main memslot/region. */
+	sev = sev_snp_vm_create(SNP_POLICY_SMT, TOTAL_PAGES);
+	if (!sev)
+		exit(KSFT_SKIP);
+	vm = sev_get_vm(sev);
+
+	/* Set up VCPU and #VC handler. */
+	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
+	kvm_vm_elf_load(vm, program_invocation_name);
+	vm_init_descriptor_tables(vm);
+	vm_install_exception_handler(vm, 29, vc_handler);
+	vcpu_init_descriptor_tables(vm, VCPU_ID);
+
+	/* Set up shared page for sync buffer. */
+	sync_vaddr = vm_vaddr_alloc_shared(vm, PAGE_SIZE, 0);
+	sync = addr_gva2hva(vm, sync_vaddr);
+
+	/* Set up additional buffer for reserved shared memory. */
+	shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
+					     SHARED_VADDR_MIN);
+	shared_buf = addr_gva2hva(vm, shared_vaddr);
+	memset(shared_buf, 0, SHARED_PAGES * PAGE_SIZE);
+
+	/* Set up additional buffer for reserved private memory. */
+	private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
+				       PRIVATE_VADDR_MIN);
+	private_buf = addr_gva2hva(vm, private_vaddr);
+	memset(private_buf, 0, PRIVATE_PAGES * PAGE_SIZE);
+
+	/*
+	 * Create a linear mapping of all guest memory. This will map all pages
+	 * as encrypted, which is okay in this case, because the linear mapping
+	 * will only be used to access page tables, which are always treated
+	 * as encrypted.
+	 */
+	virt_map(vm, LINEAR_MAP_GVA, 1UL << sev_get_enc_bit(sev), TOTAL_PAGES);
+
+	/* Set up guest params. */
+	vcpu_args_set(vm, VCPU_ID, 5, sync_vaddr,
+		      addr_gva2gpa(vm, shared_vaddr), shared_vaddr,
+		      addr_gva2gpa(vm, private_vaddr), private_vaddr);
+
+	/* Encrypt initial guest payload and prepare to run it. */
+	sev_snp_vm_launch(sev);
+
+	/* Initial guest check-in. */
+	run = vcpu_state(vm, VCPU_ID);
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_sync(run, sync, 1);
+
+	/* Do the tests. */
+	check_test_psc(vm, sync, shared_buf, private_buf);
+
+	/* Wait for guest to finish up. */
+	vcpu_run(vm, VCPU_ID);
+	sev_check_guest_done(run, sync, 10000);
+
+	sev_snp_vm_free(sev);
+
+	return 0;
+}
-- 
2.25.1

