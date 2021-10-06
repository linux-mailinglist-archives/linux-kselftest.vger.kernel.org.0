Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA99242481D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJFUmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:42:04 -0400
Received: from mail-mw2nam10hn2246.outbound.protection.outlook.com ([52.100.157.246]:7296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232177AbhJFUmD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeyHF++J3jkTuLEsoNcx/8/jlpkBmo8hhtda+NeMRzEytQpzddewD8PHsMh7rvjhIEuVLp/NKpijZI9rKfxSYgJD8MDaAxi3mBUfvTIIwB+q/2fbzxDIFS0KQ2yMn07wfnWgslQak6zh2H0W4dTeCGZlBvx9ePWUK9txW+qmPRoiZIGjIqqhKb9Bnvad4EpyDOyoabJqgXeV18RhhjLKxSmuH18qi7pGaFz+Z3gIu4KBUv1Wg//lhvwC2CmJfpEFtQPS6FC52iCsdLwdM+9cwaEXbGaQBIfcbgjZHnDq9b4tAOmLUeXNT0qL2MhIwbEfwMmKjgrICzJ3aNG2WmHVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH8ZyUqkE6HSTsXLAWoLuO1ZFIK4Gg3ENC40S6E3hw4=;
 b=C5NXrbI6++f/eufrl5FxKtgoie6eZVqJsUU62trtgL8mJaf0UhbG06gedZbXVt0YzlyKbzD1lNfuy7AnD0nV13VqMcdHuM4YrMpaysxEXtSji+nksCq4commt2XpXhB/081N5UwOZZ0ahkFzvYZS3GCyAjNONrQXhQfxTDnxRwaFnYFAKuYzKterqD/MiRdnVKJ8/4ccevxOh+vz5cKM5leoWKhvRFhdDkoT/hfZIWUYJfHcXikt2N+rgVuhegptPoGC93y9dhYqUAxitFBLBnMsLaE2cYmYM+GQLFoMG30hl3VeIxtxF15RDz0befjMhY+YhzQ1BC/2YbjvFw7y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH8ZyUqkE6HSTsXLAWoLuO1ZFIK4Gg3ENC40S6E3hw4=;
 b=YdfHG7yUNGLr4zP6D8nGfI4rbmMW5Bz3FTRBSFzIvGHvbqq8vD/nQJMWGFmJ0OmlLoDlWsCl3I8AXVV5phcqIHCqAjitnJPLOfeARIQeND3hD/8l58MRlR6XgjFTZRYXUDYszxJ0FWPHyQH6Mpm6gGe+VqCCgWPyeXHUl8BdIHo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 20:40:07 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:40:07 +0000
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
Subject: [RFC 06/16] KVM: selftests: add library for creating/interacting with SEV guests
Date:   Wed,  6 Oct 2021 15:37:10 -0500
Message-Id: <20211006203710.13326-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0088.namprd05.prod.outlook.com
 (2603:10b6:803:22::26) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN4PR0501CA0088.namprd05.prod.outlook.com (2603:10b6:803:22::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 20:40:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9ea238-7a50-4d3b-931b-08d989097b70
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848404911E1D02A4032A18495B09@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RxmNApO17ZhCSbXvVWtYLd/FrcWK756MRFEDH4CgsGCE+JyKeqCbvewjCOv9?=
 =?us-ascii?Q?bGcsN/XIVjVsfEqUewQbFlrmYwlp1LYdpD1ZD4lWTb1PCJVHZeVxtn5J0/QP?=
 =?us-ascii?Q?lvPtprvNX4cR38tbiuh0wa3svaRrUlP4Em9aNO4o2CKH9GSMwGgK45z+0fPO?=
 =?us-ascii?Q?JQL7c2+mlSK4FpNwHyWW7uY+I8iec5HjIbmNa7M9lKkDY2vWzHRB3E8zILN9?=
 =?us-ascii?Q?dfOpm8A5FLsq/OA211RK8aeGLq0YIgz6gUFQ1eKUyIO22GUq+ItVqYvuXLIW?=
 =?us-ascii?Q?5XMKDTIgfAA/6B0yVUyQvwLZ+F+xIdiUgv+Yv881IZPW/IzQ9ewek3qqZ3Wa?=
 =?us-ascii?Q?JVcNhuSiPf0rMcN1AwB9Ak4QvPzX0hFGowT5J5OuwNprlFefYj7vNsyyq7TF?=
 =?us-ascii?Q?ie8WXzfqCHGFHy9+hTbtpodR4T03jzuYJAMbNCr+Gp4j8z3Ob87CxrDwwNgl?=
 =?us-ascii?Q?SksPwGxF+V0UoTzxrfv+RekIag+p1buQQ5Lp5nwH+uFwHdxO75RGwhU5eHg1?=
 =?us-ascii?Q?qxyd2e/QWt7moHgTBIZzwhVZfoemCpKfDpSeZaSIKhq2/rF0qWgxlpZaBifN?=
 =?us-ascii?Q?RCz0aamzU/p7JYqX6xYAOxoBq9rpmm/NHTZ0EQoez+nl5kNO2Cvii1dOTq16?=
 =?us-ascii?Q?LwQHGWiQ+IpK5OfsqDQylsMJTXRxu0Cv2m+deF52QmNYpP8jiAolsLeH5gDG?=
 =?us-ascii?Q?NlOs22rtJ/1aVhtw7J86Sx5OoEKOFrtkE911eRzq6/sl4P7Aaoz6ut4gSTbA?=
 =?us-ascii?Q?P8lIhHAqvr4bT+YYmrXI6q4xOuTrEZeDP8HSE6S8ZmURmEe/J6gxG2HTcRQe?=
 =?us-ascii?Q?RIfnqo+jdFAiMx4SQZYUOsJIruaIfxj4+pqZsoggNDl8Rh4+6gquu1b7Wfbi?=
 =?us-ascii?Q?h+OGHS27x7r9n4QphqFr0YfpBiLFgr9MKzcL986fWW9Kvk8R5vj0SL3tcA+y?=
 =?us-ascii?Q?w4cDeBvx6kC20vp4lvNvt/99JShKWhoS2TxleaIPUOz5ACCeGAL2IM+tcPx9?=
 =?us-ascii?Q?Hogyj1QPPil8h5gcLuLW50NKsgKz9eKBu/tenmgEWFt1S6k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(38100700002)(38350700002)(44832011)(2616005)(956004)(508600001)(5660300002)(30864003)(6916009)(186003)(36756003)(26005)(7416002)(2906002)(4326008)(8936002)(316002)(52116002)(66946007)(66556008)(6666004)(8676002)(54906003)(6486002)(83380400001)(86362001)(6496006)(66476007)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?069Vsug/GicUJ318PBh1TMNgEE2NmIXI0dU5mLXR+QZXZgfBsd93+lbztl1F?=
 =?us-ascii?Q?rIaCzaaITKATQPhKL6LLrBvUnFn/LrnEbVSzD8+DBkYs3LAMarR5uNNzk1pM?=
 =?us-ascii?Q?FrJfIG7haF8Zsy/LTmmoWLEvdxsr48xBHu+1tsyoP5f+JwuX6YVwNWLBP3i7?=
 =?us-ascii?Q?0D3/qEJbhxGBLPVEl22R18Ft/xUp+/7CSUKwmUIr2VJ7crj9As9JA0fEzfm7?=
 =?us-ascii?Q?sz2TRCw4sLNCmb4GWn6mo+bkYRGmWoP7DVOP9qaklMoDZwzOEw+LlU9/UWWX?=
 =?us-ascii?Q?LMJ5hjHhrRtwBIQsnBhhbYn3E3v5VMBXtE4VYUT4iPXUgmBkLblxq+pZMJup?=
 =?us-ascii?Q?K2Sd+vNv1hNV3velmjeGVYPlBTBDl9Y+2YnmjVmtY8Svg/mPpg94toWh91MN?=
 =?us-ascii?Q?snV7clw63V7/zNjyzV+UCSEsCxUbOlevgMsrK1fIGDY6OwBgVYIWDfGtJk4Q?=
 =?us-ascii?Q?Ey7/0Gv3xxObN5y5DhJ23uBp/JIQ1nIxiPwFiEtkgtnRtEGhuik8gznoek9g?=
 =?us-ascii?Q?Da69HeH7Jq6TTJnQKWLyv2Shp1M+pVMlpUiNl38IP6k9RZU8j2taJmNTkDki?=
 =?us-ascii?Q?IW8fSHxuL/Za96QA/+yu+G0J0wDYtn8Ql9iJDYtzeNuqvYgRufuyKGtvteIe?=
 =?us-ascii?Q?c8Mc2HXT7aYGZnc00zozA9mF7Ax1pXNwZfx3BTI7dZ+3+/gAe+dTN9EWCiMK?=
 =?us-ascii?Q?fXu7PyBjOT44tpX43Z/s6rLVxasaVjZOBpbu+9one/XNeI9R9KIwBVH0OAAu?=
 =?us-ascii?Q?QZgxC/l3OQzFTe+HnyLK/pENBW24fBiGP4nIALuwtKYTnXE/NRjqm9ngcena?=
 =?us-ascii?Q?GWfKwD2l4Wy2aJ5NZS7XhZgr2rw+dbkvf/g5rxSmyziEF1a3KK+JLI42Dvrd?=
 =?us-ascii?Q?s9m23NmbKLQttzBklOBuLjxmA9ByIuAGDouyw/nTFRowuJ50pDqGJ4IFEsCj?=
 =?us-ascii?Q?Fcdr2GQVFNiJfrNbKPGdWSuRePV/Sik0aNIGmQ/8joglBa7Wuft1RUg80pjz?=
 =?us-ascii?Q?+fZfj/t0CL/yBgKCVO3T4LlPE6DT7GsmbqpVUu9lV3kz8XRIEEMYJb1wbfZv?=
 =?us-ascii?Q?74dUUcS0+lEVx0qbLL7D2MC1JNW3S57IQ+wo2czrrwriTN96YAfoKzQRLyrt?=
 =?us-ascii?Q?lT61oZZCXsvH4uh2VARQqKfbwaUoc9MtvIUaPFVjJUjeved8pM0lVqKusp/W?=
 =?us-ascii?Q?FKi6RIMhEKkVoZtIwZBO+vdKorlF/n9SRHtV8hqigJyW5N/aHQlidlENh4Vg?=
 =?us-ascii?Q?7kGqCTTt0Lxp5kU1jyTbV1q9GxQrfvX6b3D/+Ul9pnCxX/ht45M7WYd5JRxh?=
 =?us-ascii?Q?NgcsX9VMgXeQlO7vUPJQcaSb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9ea238-7a50-4d3b-931b-08d989097b70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:40:07.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzbABcXwYnkPuge+uMy1eyBxfXCkIK1fn+Et8LKTBJp25Qdw8A4UDEAbbK02e74AdMtaesqVeuqC4PsuWUgghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add interfaces to allow tests to create/manage SEV guests. The
additional state associated with these guests is encapsulated in a new
struct sev_vm, which is a light wrapper around struct kvm_vm. These
VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
under the covers to configure and sync up with the core kvm_util
library on what should/shouldn't be treated as encrypted memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  62 ++++
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 303 ++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..c7a5e1c69e0c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,6 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
+LIBKVM_x86_64 += lib/x86_64/sev.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
new file mode 100644
index 000000000000..d2f41b131ecc
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers used for SEV guests
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+#ifndef SELFTEST_KVM_SEV_H
+#define SELFTEST_KVM_SEV_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include "kvm_util.h"
+
+#define SEV_DEV_PATH		"/dev/sev"
+#define SEV_FW_REQ_VER_MAJOR	1
+#define SEV_FW_REQ_VER_MINOR	30
+
+#define SEV_POLICY_NO_DBG	(1UL << 0)
+#define SEV_POLICY_ES		(1UL << 2)
+
+#define SEV_GUEST_ASSERT(sync, token, _cond) do {	\
+	if (!(_cond))					\
+		sev_guest_abort(sync, token, 0);	\
+} while (0)
+
+enum {
+	SEV_GSTATE_UNINIT = 0,
+	SEV_GSTATE_LUPDATE,
+	SEV_GSTATE_LSECRET,
+	SEV_GSTATE_RUNNING,
+};
+
+struct sev_sync_data {
+	uint32_t token;
+	bool pending;
+	bool done;
+	bool aborted;
+	uint64_t info;
+};
+
+struct sev_vm;
+
+void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info);
+void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info);
+void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info);
+
+void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
+			  uint32_t token);
+void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
+			  uint32_t token);
+
+void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
+struct kvm_vm *sev_get_vm(struct sev_vm *sev);
+uint8_t sev_get_enc_bit(struct sev_vm *sev);
+
+struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
+void sev_vm_free(struct sev_vm *sev);
+void sev_vm_launch(struct sev_vm *sev);
+void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement);
+void sev_vm_launch_finish(struct sev_vm *sev);
+
+#endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
new file mode 100644
index 000000000000..adda3b396566
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers used for SEV guests
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+#include "kvm_util.h"
+#include "linux/psp-sev.h"
+#include "processor.h"
+#include "sev.h"
+
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(1UL << PAGE_SHIFT)
+
+struct sev_vm {
+	struct kvm_vm *vm;
+	int fd;
+	int enc_bit;
+	uint32_t sev_policy;
+};
+
+/* Helpers for coordinating between guests and test harness. */
+
+void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info)
+{
+	sync->token = token;
+	sync->info = info;
+	sync->pending = true;
+
+	asm volatile("hlt" : : : "memory");
+}
+
+void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info)
+{
+	while (true) {
+		sync->done = true;
+		sev_guest_sync(sync, token, info);
+	}
+}
+
+void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info)
+{
+	while (true) {
+		sync->aborted = true;
+		sev_guest_sync(sync, token, info);
+	}
+}
+
+void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
+			  uint32_t token)
+{
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
+		    "unexpected exit reason: %u (%s)",
+		    run->exit_reason, exit_reason_str(run->exit_reason));
+	TEST_ASSERT(sync->token == token,
+		    "unexpected guest token, expected %d, got: %d", token,
+		    sync->token);
+	TEST_ASSERT(!sync->done, "unexpected guest state");
+	TEST_ASSERT(!sync->aborted, "unexpected guest state");
+	sync->pending = false;
+}
+
+void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
+			  uint32_t token)
+{
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
+		    "unexpected exit reason: %u (%s)",
+		    run->exit_reason, exit_reason_str(run->exit_reason));
+	TEST_ASSERT(sync->token == token,
+		    "unexpected guest token, expected %d, got: %d", token,
+		    sync->token);
+	TEST_ASSERT(sync->done, "unexpected guest state");
+	TEST_ASSERT(!sync->aborted, "unexpected guest state");
+	sync->pending = false;
+}
+
+/* Common SEV helpers/accessors. */
+
+struct kvm_vm *sev_get_vm(struct sev_vm *sev)
+{
+	return sev->vm;
+}
+
+uint8_t sev_get_enc_bit(struct sev_vm *sev)
+{
+	return sev->enc_bit;
+}
+
+void sev_ioctl(int sev_fd, int cmd, void *data)
+{
+	int ret;
+	struct sev_issue_cmd arg;
+
+	arg.cmd = cmd;
+	arg.data = (unsigned long)data;
+	ret = ioctl(sev_fd, SEV_ISSUE_CMD, &arg);
+	TEST_ASSERT(ret == 0,
+		    "SEV ioctl %d failed, error: %d, fw_error: %d",
+		    cmd, ret, arg.error);
+}
+
+void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
+{
+	struct kvm_sev_cmd arg = {0};
+	int ret;
+
+	arg.id = cmd;
+	arg.sev_fd = sev->fd;
+	arg.data = (__u64)data;
+
+	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_OP, &arg);
+	TEST_ASSERT(ret == 0,
+		    "SEV KVM ioctl %d failed, rc: %i errno: %i (%s), fw_error: %d",
+		    cmd, ret, errno, strerror(errno), arg.error);
+}
+
+/* Local helpers. */
+
+static void
+sev_register_user_range(struct sev_vm *sev, void *hva, uint64_t size)
+{
+	struct kvm_enc_region range = {0};
+	int ret;
+
+	pr_debug("register_user_range: hva: %p, size: %lu\n", hva, size);
+
+	range.addr = (__u64)hva;
+	range.size = size;
+
+	ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+	TEST_ASSERT(ret == 0, "failed to register user range, errno: %i\n", errno);
+}
+
+static void
+sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
+{
+	struct kvm_sev_launch_update_data ksev_update_data = {0};
+
+	pr_debug("encrypt_phy_range: addr: 0x%lx, size: %lu\n", gpa, size);
+
+	ksev_update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
+	ksev_update_data.len = size;
+
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
+}
+
+static void sev_encrypt(struct sev_vm *sev)
+{
+	struct sparsebit *enc_phy_pages;
+	struct kvm_vm *vm = sev->vm;
+	sparsebit_idx_t pg = 0;
+	vm_paddr_t gpa_start;
+	uint64_t memory_size;
+
+	/* Only memslot 0 supported for now. */
+	enc_phy_pages = vm_get_encrypted_phy_pages(sev->vm, 0, &gpa_start, &memory_size);
+	TEST_ASSERT(enc_phy_pages, "Unable to retrieve encrypted pages bitmap");
+	while (pg < (memory_size / vm_get_page_size(vm))) {
+		sparsebit_idx_t pg_cnt;
+
+		if (sparsebit_is_clear(enc_phy_pages, pg)) {
+			pg = sparsebit_next_set(enc_phy_pages, pg);
+			if (!pg)
+				break;
+		}
+
+		pg_cnt = sparsebit_next_clear(enc_phy_pages, pg) - pg;
+		if (pg_cnt <= 0)
+			pg_cnt = 1;
+
+		sev_encrypt_phy_range(sev,
+				      gpa_start + pg * vm_get_page_size(vm),
+				      pg_cnt * vm_get_page_size(vm));
+		pg += pg_cnt;
+	}
+
+	sparsebit_free(&enc_phy_pages);
+}
+
+/* SEV VM implementation. */
+
+static struct sev_vm *sev_common_create(struct kvm_vm *vm)
+{
+	struct sev_user_data_status sev_status = {0};
+	uint32_t eax, ebx, ecx, edx;
+	struct sev_vm *sev;
+	int sev_fd;
+
+	sev_fd = open(SEV_DEV_PATH, O_RDWR);
+	if (sev_fd < 0) {
+		pr_info("Failed to open SEV device, path: %s, error: %d, skipping test.\n",
+			SEV_DEV_PATH, sev_fd);
+		return NULL;
+	}
+
+	sev_ioctl(sev_fd, SEV_PLATFORM_STATUS, &sev_status);
+
+	if (!(sev_status.api_major > SEV_FW_REQ_VER_MAJOR ||
+	      (sev_status.api_major == SEV_FW_REQ_VER_MAJOR &&
+	       sev_status.api_minor >= SEV_FW_REQ_VER_MINOR))) {
+		pr_info("SEV FW version too old. Have API %d.%d (build: %d), need %d.%d, skipping test.\n",
+			sev_status.api_major, sev_status.api_minor, sev_status.build,
+			SEV_FW_REQ_VER_MAJOR, SEV_FW_REQ_VER_MINOR);
+		return NULL;
+	}
+
+	sev = calloc(1, sizeof(*sev));
+	sev->fd = sev_fd;
+	sev->vm = vm;
+
+	/* Get encryption bit via CPUID. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	sev->enc_bit = ebx & 0x3F;
+
+	return sev;
+}
+
+static void sev_common_free(struct sev_vm *sev)
+{
+	close(sev->fd);
+	free(sev);
+}
+
+struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
+{
+	struct sev_vm *sev;
+	struct kvm_vm *vm;
+
+	/* Need to handle memslots after init, and after setting memcrypt. */
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	sev = sev_common_create(vm);
+	if (!sev)
+		return NULL;
+	sev->sev_policy = policy;
+
+	kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
+
+	vm_set_memory_encryption(vm, true, true, sev->enc_bit);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
+	sev_register_user_range(sev, addr_gpa2hva(vm, 0), npages * vm_get_page_size(vm));
+
+	pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
+		sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
+
+	return sev;
+}
+
+void sev_vm_free(struct sev_vm *sev)
+{
+	kvm_vm_free(sev->vm);
+	sev_common_free(sev);
+}
+
+void sev_vm_launch(struct sev_vm *sev)
+{
+	struct kvm_sev_launch_start ksev_launch_start = {0};
+	struct kvm_sev_guest_status ksev_status = {0};
+
+	ksev_launch_start.policy = sev->sev_policy;
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_START, &ksev_launch_start);
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.policy == sev->sev_policy, "Incorrect guest policy.");
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
+		    "Unexpected guest state: %d", ksev_status.state);
+
+	sev_encrypt(sev);
+}
+
+void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement)
+{
+	struct kvm_sev_launch_measure ksev_launch_measure = {0};
+	struct kvm_sev_guest_status ksev_guest_status = {0};
+
+	ksev_launch_measure.len = 256;
+	ksev_launch_measure.uaddr = (__u64)measurement;
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_MEASURE, &ksev_launch_measure);
+
+	/* Measurement causes a state transition, check that. */
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_guest_status);
+	TEST_ASSERT(ksev_guest_status.state == SEV_GSTATE_LSECRET,
+		    "Unexpected guest state: %d", ksev_guest_status.state);
+}
+
+void sev_vm_launch_finish(struct sev_vm *sev)
+{
+	struct kvm_sev_guest_status ksev_status = {0};
+
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE ||
+		    ksev_status.state == SEV_GSTATE_LSECRET,
+		    "Unexpected guest state: %d", ksev_status.state);
+
+	kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_FINISH, NULL);
+
+	kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
+	TEST_ASSERT(ksev_status.state == SEV_GSTATE_RUNNING,
+		    "Unexpected guest state: %d", ksev_status.state);
+}
-- 
2.25.1

