Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFC6549B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiLWAO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiLWAOe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:34 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8022EFA9
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:14 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n5-20020a170902d2c500b00189e5b86fe2so2324246plc.16
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXjvTaFGl0oQkWFtQLkmlcU0BiyCn63t9cGXi+l6V/w=;
        b=acLkEOZ4nvyQu2uxwn2hL7G9VDeqPcNGplhMBS2a+Yx+2SNZIeWbRIHKUjv160NG0L
         m4d1KpHGQ2RR4P8vLlHgq6jgo7zEUuXsmdGzHVhSiFQvET6Dn4GkihmCSrLavj+zpSes
         8CGusZoJ/ApV1KTPj7x4yLhN9l2mKIEZY9i00cpn307Av1luAJreVNajomg2aj1GLaH5
         BjUxMIfDWuKDDZfHZN4igce+Jgfx/dOsevMY+0KgQPEcSG5w3V7gSDyz9iQ8s6oGsVO6
         51pr/aXD8Jb0W+dVj27LxZ94KU0+dCZsk08OInfH1quXH3A4uj+O+BM3KnT33TzIPjoq
         dv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXjvTaFGl0oQkWFtQLkmlcU0BiyCn63t9cGXi+l6V/w=;
        b=ZRDGaEbYJyr97msPd53rzJJQRfALXXAlQ1e7t1JsmVbXQ7R+/sixS4KTaBAjaNvDwi
         6Kbd7DGaug0tg6hVWWjMRanFRXR0ptofW7dwUajwKmEnVX8au7OBHtJGCKfbq5QQeyrp
         zDrnRpFUW+CQufI1z0YZRpSWEeiS10AYDf3WsI54iINQSob4U2kcGJjvA/3R9itg5s8R
         jV21wiYdz2Rs1IBBX1K70mFd+6dFAi51xefz1tSZp0LQfKSgTD4ThCFW/w1+kQdXUIEK
         arNC4kOvQbACPMjMM/FgbWjOCWoRFW0IjXDjWmOa6KKjsL2lcw3sGZclv10cO3Xg3AsW
         04+Q==
X-Gm-Message-State: AFqh2kpmEbspm9drxFI+Bq8kIxauqs6gpmylukn5fD6f1tvBjQx14NQy
        iZwtbqwfFKd4UPCWvtnDmpj2Bo0/ZupzMRdg
X-Google-Smtp-Source: AMrXdXvICP9uAMh9F1qCb0MWER00sCMo/yyKBdu7ShrN3F6Pwkbk7bfoFJbU6crsZgKj54Km5Tgzn7z2dXwHkz4z
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a63:530a:0:b0:46f:1e8d:d6a8 with SMTP
 id h10-20020a63530a000000b0046f1e8dd6a8mr592287pgb.248.1671754454109; Thu, 22
 Dec 2022 16:14:14 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:52 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-9-vannapurve@google.com>
Subject: [V3 PATCH 8/8] KVM: selftests: Add private mem test for SEV VMs
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add SEV VM specific private mem test to invoke selftest logic similar
to the one executed for non-confidential VMs.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/sev_private_mem_test.c         | 26 +++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index f73639dcbebb..e5c82a1cd733 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -40,6 +40,7 @@
 /x86_64/set_sregs_test
 /x86_64/sev_all_boot_test
 /x86_64/sev_migrate_tests
+/x86_64/sev_private_mem_test
 /x86_64/smaller_maxphyaddr_emulation_test
 /x86_64/smm_test
 /x86_64/state_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 83c649c9de23..a8ee7c473644 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -104,6 +104,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c b/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c
new file mode 100644
index 000000000000..943fdfbe41d9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <private_mem_test_helper.h>
+
+int main(int argc, char *argv[])
+{
+	execute_sev_vm_with_private_test_mem(
+				VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD);
+
+	/* Needs 2MB Hugepages */
+	if (get_free_huge_2mb_pages() >= 1) {
+		printf("Running SEV VM private mem test with 2M pages\n");
+		execute_sev_vm_with_private_test_mem(
+				VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD);
+	} else
+		printf("Skipping SEV VM private mem test with 2M pages\n");
+
+	return 0;
+}
-- 
2.39.0.314.g84b9a713c41-goog

