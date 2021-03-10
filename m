Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3D333276
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 01:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCJAbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 19:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhCJAar (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 19:30:47 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3CC061761
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Mar 2021 16:30:47 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u15so11489306qvo.13
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Mar 2021 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DHxB02lHBuSNm1Tq7ppWLhclQ6LGjD2vwbT8+0hyBYQ=;
        b=i9nnGI1yJf5zkDtvuzAcFHkNKf3iYy4fMgWPsn0CUr62qyKKEML7n/XqRiL4DuhrVD
         lOYIjYImLQHRMCLtPvlKUFDxo1P7/lsLESUmJw0tVdAgsA54KJz5QlWXoqESVY0fXkYS
         KJ+M9fOfot6eeFDCrwoGSqeBqbJGQEoxwG3zMnPXqpV5ZMbroRPNsnIYd1I9SoaLcNfV
         2Ehb5DHXA9zswPk9gJK87g+ScrbL46n7nqhZIrrsCH9ySbP5XLo+k2xO9bYMaYPpHUpH
         b8ohv5kWZiy5uVMb+jik0GkoEQUvObXLnigZ2hmjx/h3f8OYWB2BIEzR/TH2cjB1N4wS
         TlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DHxB02lHBuSNm1Tq7ppWLhclQ6LGjD2vwbT8+0hyBYQ=;
        b=A2vrvbqYbtIiaXt9iFlIJ0mDEWicBsFSAFQ/ihKti35FafuLHtUMBljyKGoCTf5va2
         nh3iThgQvwRKgD7uwfSGwljI7K3Wv/WEvGV3cPizMsReecpaTOQ6FkTLJZMewSuNQkkY
         QzLTCoqa5Nn0E0DUDwoFXxuhodHfG9poAdCUgAnd6Wnfnw75VVgxSAEs9vesMJp9pEZm
         n/EA7ZQHrMkPIRGtPKgnAGQiJZVsHUti2ZIvsMSUpTy6SR1QJ3bYvSaubB4sa3MCXQuM
         lTHqWo5S7HbVz6TYcAxzu8pdKGQt3hTR8puDJTgtWfXTJSegpND/mqBITqmfkNc3GKX/
         /84Q==
X-Gm-Message-State: AOAM531ZjKXnF8QB/+rJm7eBzka4sdsQYkIS+J7hu2cv1xS8rLyp5uJS
        lqAdPnZwPbi89UpfkP1Kq/xEuLHdjlKU5A9oeA==
X-Google-Smtp-Source: ABdhPJyUNUM/sAdenGIGgvVPCloQCo5gPdn0LHQMLGSw3kNLQg8mscQ8MFWXB1+jfVgEjigVvGqt7memgn4xEsF28w==
X-Received: from jingzhangos.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:513])
 (user=jingzhangos job=sendgmr) by 2002:a0c:9e15:: with SMTP id
 p21mr678608qve.53.1615336246323; Tue, 09 Mar 2021 16:30:46 -0800 (PST)
Date:   Wed, 10 Mar 2021 00:30:24 +0000
In-Reply-To: <20210310003024.2026253-1-jingzhangos@google.com>
Message-Id: <20210310003024.2026253-5-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RFC PATCH 4/4] KVM: selftests: Add selftest for KVM binary form
 statistics interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check if the KVM binary form statistics works correctly and whether the
statistics name strings are synced correctly with KVM internal stats
data.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 89 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 32b87cc77c8e..0c8241bd9a17 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -38,3 +38,4 @@
 /memslot_modification_stress_test
 /set_memory_region_test
 /steal_time
+/kvm_bin_form_stats
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a6d61f451f88..5cdd52ccedf2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
+TEST_GEN_PROGS_x86_64 += kvm_bin_form_stats
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
@@ -81,6 +82,7 @@ TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
+TEST_GEN_PROGS_aarch64 += kvm_bin_form_stats
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/resets
@@ -89,6 +91,7 @@ TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += set_memory_region_test
+TEST_GEN_PROGS_s390x += kvm_bin_form_stats
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/kvm_bin_form_stats.c b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
new file mode 100644
index 000000000000..36cf206470b1
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kvm_bin_form_stats
+ *
+ * Copyright (C) 2021, Google LLC.
+ *
+ * Test for fd-based IOCTL commands for retrieving KVM statistics data in
+ * binary form. KVM_CAP_STATS_BINARY_FORM, KVM_STATS_GET_INFO,
+ * KVM_STATS_GET_NAMES and KVM_STATS_GET_DATA are checked.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+
+int main(int argc, char *argv[])
+{
+	struct kvm_stats_info stats_info = {0};
+	struct kvm_stats_names *stats_names;
+	struct kvm_stats_data *stats_data;
+	struct kvm_vm *kvm;
+	int i, ret;
+
+	kvm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+
+	ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FORM);
+	if (ret < 0) {
+		pr_info("Binary form statistics interface is not supported!\n");
+		goto out_free_kvm;
+	}
+
+	ret = -1;
+	vm_ioctl(kvm, KVM_STATS_GET_INFO, &stats_info);
+	if (stats_info.num_stats == 0) {
+		pr_info("KVM_STATS_GET_INFO failed!\n");
+		pr_info("Or the number of stistics data is zero.\n");
+		goto out_free_kvm;
+	}
+
+	/* Allocate memory for stats name strings and value */
+	stats_names = malloc(sizeof(*stats_names) +
+			stats_info.num_stats * KVM_STATS_NAME_LEN);
+	if (!stats_names) {
+		pr_info("Memory allocation failed!\n");
+		goto out_free_kvm;
+	}
+
+	stats_data = malloc(sizeof(*stats_data) +
+				stats_info.num_stats * sizeof(__u64));
+	if (!stats_data) {
+		pr_info("Memory allocation failed!\n");
+		goto out_free_names;
+	}
+
+	/* Retrieve the name strings and data */
+	stats_names->size = stats_info.num_stats * KVM_STATS_NAME_LEN;
+	vm_ioctl(kvm, KVM_STATS_GET_NAMES, stats_names);
+
+	stats_data->size = stats_info.num_stats * sizeof(__u64);
+	vm_ioctl(kvm, KVM_STATS_GET_DATA, stats_data);
+
+	/* Display supported statistics names */
+	for (i = 0; i < (int)stats_info.num_stats; i++) {
+		char *name = (char *)stats_names->names + i * KVM_STATS_NAME_LEN;
+
+		if (strnlen(name, KVM_STATS_NAME_LEN) == 0) {
+			pr_info("Empty stats name at offset %d!\n", i);
+			goto out_free_data;
+		}
+		pr_info("%s\n", name);
+	}
+
+	ret = 0;
+out_free_data:
+	free(stats_data);
+out_free_names:
+	free(stats_names);
+out_free_kvm:
+	kvm_vm_free(kvm);
+	return ret;
+}
-- 
2.30.1.766.gb4fecdf3b7-goog

