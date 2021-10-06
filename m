Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7BB4247F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhJFUbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:31:17 -0400
Received: from mail-sn1anam02hn2240.outbound.protection.outlook.com ([52.100.159.240]:11651
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239459AbhJFUbQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmxuz6foczMQ/ViRxlSvaXD9lzzFhK5t86EYBRmz6ftSe78mO60aWualmymPg7EWohBgEXS8uO5Jv+4TMr+TFzjxv59dBgxPpYQI0LLyCPdfNDQ4btWj6M2Cl7y4Kk3zj9lxPUJg9/y1IzQqXcuRAuYcP5i8DhI5vK4MSx2O350L/BP930pKZCzyo8ZELZI66mS+5iobisrslcnlTb9H9cyyn7cgLeXsV1omUGDpHzXiAyF3IM+0/a59S9UKeRssEfogGSQsnZ9aVtZ/DplkvBPUdebPtTkEl4mi/zA1Yd1Y+aXpg1pWnbhuL0X7er4iGBLpI9GUc5GzC2f5PGupgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH8ZyUqkE6HSTsXLAWoLuO1ZFIK4Gg3ENC40S6E3hw4=;
 b=XrvFVPZQIvV9Wr0rAatwq+QAaKVxuJjn9ucUUg0UQhBlFlCEgIDOgLw67T/vPY7BoHv2EW8g/Oaao9Hg8YGDaD//RilwUAax4UKmP8A0aPJZ2sNw+N2SokE0k7FLrAv1tnYuXOFQK16935Co/3+ueiQ/pHzap6R5toow/HdMR1OY5H1ImlsWc1bSzgGBWpTE31aeGsoWgUGAALAPd+KlPPSgt+SIq9weJnGeoCD/DyYtoqRecYRzfNON8ujxI5+hdwSvhFiz/jx9bxnZbJHxnT62jPcwIkSHeJPHnTd6FTSx2zwmplR5829A51jAegwAxFcEqgBzoMpEczjMmy71lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH8ZyUqkE6HSTsXLAWoLuO1ZFIK4Gg3ENC40S6E3hw4=;
 b=0eXR9cyZDrNqNLW2/IvCvopc8DShJSKJymeORwzlOaoqOhxIAAFEEUopCc15AZDqfKddZ7/aKgUqAfwsk1fa7qdpIzSpVRYLK2Ievua7YKznRr2z0fBE9YeAifVj7Xb12J1JhSbY9r1kKMZcKhog1RqxTpCswgfAZSFEypVU7AM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 20:29:21 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 20:29:21 +0000
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
Subject: [RFC 04/16] KVM: selftests: add library for creating/interacting with SEV guests
Date:   Wed,  6 Oct 2021 15:28:05 -0500
Message-Id: <20211006202805.12360-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 20:29:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf4e968a-1481-4bce-216f-08d98907fa39
X-MS-TrafficTypeDiagnostic: CH2PR12MB4103:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4103F201AB9B67EDE8375DCC95B09@CH2PR12MB4103.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aoXt9Ibc5jVNr6RAR7oZY9P0N5pHcuBFWwh9ptnklYhSpSOqtB/l/vMIdr3s?=
 =?us-ascii?Q?dTDMBfLjfycge+xrEErbv/b3R+VoG6a2z1qnLtp4MvGkX0cAaFn6aOviDZcU?=
 =?us-ascii?Q?AXpklat7oFXLh0eJFsM7o3I0vbg2uYNd8WsTKizNCmjfyY6nR582qN4f5apa?=
 =?us-ascii?Q?R+I9lmp8shc8J/aJ6TEIIlo9qmL9GXiPIOt3Wfq12GJ8oxatgV/0ioR12rSy?=
 =?us-ascii?Q?zCB4pphFLXohfXwxnqia5q6FdWWrLlZ1lUa2hWjELf53CfdHF4aDlJXxaLwg?=
 =?us-ascii?Q?mcN3OO/GmtpYqyYic8g5Q0Yj/9XIw/Jqvk35kJjO7rl0sWN0U9/MeehzlBnk?=
 =?us-ascii?Q?mzZhpP5jsQuMfxtV/v8PkJGh2TGO0yY41cLcOnTR0sLBolkwbE1nq8gDziHv?=
 =?us-ascii?Q?StpSif+tuAzG2PNNl7Wnn+NX/cyMBHJFRf1v9/mLi/eeFo9uawkUJ6o8cv6w?=
 =?us-ascii?Q?mH8s7aWwZmOooXkQE0ycvG2HLbMs9Cm1f5JN24HUboQo4Aciv8u6QL6CksNc?=
 =?us-ascii?Q?tnTNUfhjYkZbM1fua7MRk4DxaP5xgo6RZ9jCp9mfHpFtQEHxIXObjrg2eWw3?=
 =?us-ascii?Q?UO43zsAcRBlzQQlEsO5O1d9wtSWa0AhZ38UwxWSlpz7uZfO0R/jYyvt09bbJ?=
 =?us-ascii?Q?E9ebkDvGxPPChFyafFX+S5nUiGRYlkUjCFblGHahesno9IoB8PbpZaeh1fJ4?=
 =?us-ascii?Q?plXhwtdJp39v3A5DYw9LR1hrgEOEhnFtGlN2lB4ekH4oiorLcmbtfCidRrLo?=
 =?us-ascii?Q?OPgDBuN+W1/lBoi3/cehAHa40ORLtzDgswh+ON70w/vafQ6FXeIG01MRMBg6?=
 =?us-ascii?Q?THqTj9nt97730IwdqQn8OrE1dI6++ZSS7MWeBrXap3s15ANYfb+fnUcKgS2p?=
 =?us-ascii?Q?ADfiePnroYBx1vThAVZ7Onj87MpRUQ2itor452tEaoRcXnJMFWW74SCamuuD?=
 =?us-ascii?Q?6aKI6qhn7zNuhHCrUglnxiuCosM2BYG7tBo/rKOOI8/Cu4azHoSB+zn0e/7I?=
 =?us-ascii?Q?VHuaduL79Jy7Qh8j+uM1uf2Yp0s1eTwyHXFPAHRKpOq0ORE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(508600001)(6666004)(2906002)(44832011)(86362001)(54906003)(316002)(186003)(5660300002)(4326008)(52116002)(6496006)(6916009)(26005)(8936002)(66476007)(38350700002)(66556008)(66946007)(7416002)(2616005)(956004)(1076003)(83380400001)(6486002)(38100700002)(36756003)(8676002)(30864003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WLYYuoj1wS8Gg0u9TVrFbUNPkLKBVohKmK9BsZiKBJY1wCyFn+7teX4HdVfk?=
 =?us-ascii?Q?KBFBtXn1PM/MaqsEq+0JYQg8z+i2NjywKVtHh3+jabfCMv2KZW0XCZ4lJfUq?=
 =?us-ascii?Q?u+o3UJFXZx0r1alOEnDSVu1vTHVPrPfpPuOjEJrYnIY8u0a3o9eBfoSLCcMV?=
 =?us-ascii?Q?K6jkX+SBdSzTTEw5Je1sBW0CRLAVGfAC2azjFVOFPaBQaF4OCWCEhXdJdRNr?=
 =?us-ascii?Q?q8q9KEeeO9YLGgfB8CHQyweyOIU6+VFRrJh8X72ZF4Xk3Rzt41Q36QWG3GLP?=
 =?us-ascii?Q?PAApMHtWsH6U3Cdatp4vC/A+4SMXwMtVujMpoeE53idRnjrcl6F2NQMh3nvH?=
 =?us-ascii?Q?eFxRvizoOAFPq9QCjZJNZnQia3K0ejp/pTJXknci9J5ETErxZhgu0wcWv4gw?=
 =?us-ascii?Q?PG0aHoJGOfMi+ui18YF1pChuNL7hxMDjKY5Sho5QTbsjOcckijv7XLkXbCN4?=
 =?us-ascii?Q?a+ipwpii3XfMiikQDxoQh/FVw5kQG+9K6k2VSRhr3cXn6asVFTESO5/oAXmr?=
 =?us-ascii?Q?SUa2bRvsJEJHwHguAzDVWP9LL1BbDkc8a0Cm9cijCdd++5L+ci85PdQHA6IS?=
 =?us-ascii?Q?0UR3VFBjcdXaAGI4NeZJASrovn9cWtox3sfuppZoD+fu+jeEWD5IQlw7T3nc?=
 =?us-ascii?Q?aZUnvuWK2xYjHXvY2kbNSdD+DbALg5D+Q8rhA21ovZuXhtx20qyh7ZROM+TY?=
 =?us-ascii?Q?m3vySauyPoAkD3iEPp1KKdOmn0JJCLqzPTV0oO9t5lY2ECfT0Spk/u8D06w6?=
 =?us-ascii?Q?xIuTItgalYTNlzhNnttwTS14G3hS5NYMsY+7nsZIZJMMt6+7vlitf8uZsTKd?=
 =?us-ascii?Q?smzDcCe8omvrk9Kuwb8YGD0earlCG5ymyRuckqmoetANqWBb5bNwTodSyHYw?=
 =?us-ascii?Q?Cjy7Y509IY9+21YfpGP7IUAWVnbCMJo4gx3VBt5eJ0FahvwogsLA8HOoruiB?=
 =?us-ascii?Q?z46xP3MOUeyyXIZUrZF20nwa9mwwX2eeAJdo9KeulGeVj8fOdprgpNH1Xa9N?=
 =?us-ascii?Q?4XqEKcWdU2+EnR98kqgOWQbUJNt2dvYHmKioYSDkVLzwDq2hriXj4Ngm57Fh?=
 =?us-ascii?Q?Fj8+HT9Zr6XW9OZ4KJy6BqtxkTIjbFsbIAnK+ukjmdKTTLnBlZuWESlwX1Jj?=
 =?us-ascii?Q?eDbot+JO1SggrsJ6vdTozsue2IBWlbnnUJBmQ4vu0An2cQgp2zq6uNqQEISw?=
 =?us-ascii?Q?neiauwQiQQ5k/rofomjTE4PBTdgiSaKt5kbInp4s70y+V1u35e90stoktLLL?=
 =?us-ascii?Q?eqpLaXe+vUUJgt4Py1Gkx7GjwSMBbgMGLczS+2oPEWzkEJ4uys7je6n8gDnf?=
 =?us-ascii?Q?BzesLa0dyEXTpoqsWBDvSJLa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4e968a-1481-4bce-216f-08d98907fa39
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:29:20.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCS49Tm0uI6ubLHOQNXDEqtFqL77zV3jy1hISPSB2519jBlYpF7NAAIBNs6S88pD8u3m4O41fAshaDyvbCxgpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

