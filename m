Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF15A710B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiH3WoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiH3Wnq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CB85F98
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q7-20020a63e947000000b004297f1e1f86so6131234pgj.12
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=SZFI/BD05xGXUwWRf10O9GR3zZEiAgwS8+s9rPD1nCs=;
        b=Vwrj9vaDWiIAREcxlkWs0glRtmYa/bvTrp9YFdAUMOToYQ/jD2vTpSo+mv1IBBtwAG
         M3ITYnVQRBUdmQYzzVVPX5vdP3ZMEurc/94khBlubV3HgdL5stp2v+lPFcvf9TBd8NgN
         xrlHIl4wkwnMzqTR9T5+bZ+udASe8M2Mz6OczwNLYyAxwvJiP7tElKXOYpxDndH1/+4X
         C7mgUnfvokFFAgzbzf31jhSdVRLUPR45TOj74L+KgoouNHqAepXGu2HpOnETpOcMzmzd
         W1x9DMjSjl6xxJDaJ1ZdHTDS43ilcCt9EqAsOZZORWSW2z1WYj3tfon8hUDPGIDoyq3c
         kpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=SZFI/BD05xGXUwWRf10O9GR3zZEiAgwS8+s9rPD1nCs=;
        b=hf/9liffhJPj7JMfhTAgoPFzY86Ycn+1e/Hym31Z8agwcvHj7vBh2kDb27TQETBp6E
         yS5qU8uMeBV0MMqIfGCILPK/nc5mne8MDFCSiGF3hay4CM1o3ASPe+HxkS5LPDFb1qVw
         /yvMdwyHU5QDe9YeodBcYmDs0FbBnIqzfBa0P+sscuWqCC8uEyxqudTNobMGXh7gNezl
         RkD5gNa18IZPDwpWFKpAkpfhM9ZkuygRztDnr3/1mQUZVxgZiSi1swUVH61lCUfDzWyS
         uRmwHWl/pFhN6DWpDc5CgkEQGzczpnBrQo2V1AEBEr9BaPcA3PzFTVRWd6V1Hk9ULx/n
         Q0Iw==
X-Gm-Message-State: ACgBeo3BDqqxRSOFe8BJcI81yMv1uIe+qwS0XxRw6huyM47kp6cpdNru
        TIU7Wy8A49KnUYD1nA8sfqxzEipWea21YfKn
X-Google-Smtp-Source: AA6agR5w/7GSSIl/Y9SPf0ncYlhNdf+tjVar8dIyS0KvqIeS5dpzuysMFBeXdDbt8wMm5SsXSQ2EpS1h7NawurFS
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:1b0f:b0:1fd:e29c:d8e1 with SMTP
 id nu15-20020a17090b1b0f00b001fde29cd8e1mr255751pjb.118.1661899416074; Tue,
 30 Aug 2022 15:43:36 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:59 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-9-vannapurve@google.com>
Subject: [RFC V2 PATCH 8/8] selftests: kvm: Add private memory test for SEV VMs
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
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a selftest placeholder for executing private memory
conversion tests with SEV VMs.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../kvm/x86_64/sev_private_mem_test.c         | 21 +++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 095b67dc632e..757d4cac19b4 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -37,6 +37,7 @@
 /x86_64/set_sregs_test
 /x86_64/sev_all_boot_test
 /x86_64/sev_migrate_tests
+/x86_64/sev_private_mem_test
 /x86_64/smm_test
 /x86_64/state_test
 /x86_64/svm_vmcall_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 36874fedff4a..3f8030c46b72 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -98,6 +98,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/pmu_event_filter_test
 TEST_GEN_PROGS_x86_64 += x86_64/private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/set_sregs_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_private_mem_test
 TEST_GEN_PROGS_x86_64 += x86_64/smm_test
 TEST_GEN_PROGS_x86_64 += x86_64/state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c b/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c
new file mode 100644
index 000000000000..2c8edbaef627
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_private_mem_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022, Google LLC.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <private_mem_test_helper.h>
+
+int main(int argc, char *argv[])
+{
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	execute_sev_memory_conversion_tests();
+	return 0;
+}
-- 
2.37.2.672.g94769d06f0-goog

