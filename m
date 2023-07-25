Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDD762576
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGYWDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGYWCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC4271B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:18 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563bcd2cb78so1654253a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322519; x=1690927319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRhczmdPScKo2vay9vryElFC45oKYBjwBdCY5Tc9Lgg=;
        b=57SgSzMp2WcSUTopm7St4O8LEi1JlQxQS++YhZNvtD6C5IPezdoXNsSva7qcRa95TH
         CuUzrQcHvY2onxeJvA2c1bhB2gmiizkKLmn71GwMJyy3Hm2FFxnbIkFRLtYPl15/fo9H
         02GG7Tsax5yc8MIT2D1lYjGlaRLIHJ0s3htuvNEhBkQ6qyxxZOh9DecsR5BCJh481R47
         QE24yQWSrz0i7Qr01PYsyE8EAvWp2QToSs5YSSaj0k7hyjBM7QlaAlbgMqBEg/C6txYK
         8vkMXlPgR6yg2+Ln7bRWtGYMUz1nk5ZPBWIzK47oHMtaDqPcHTzzYVVv9dVdYSXbDfSQ
         iQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322519; x=1690927319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRhczmdPScKo2vay9vryElFC45oKYBjwBdCY5Tc9Lgg=;
        b=kbkqVl3nVEkDhZTjVTk4d0p9zZnphdVlUwt93dfaEhcaDllwmS5VRMctgBGJXVdEJL
         mFeac2OEtQ68CB/EZ3VG+iwtZ61H9Mnvjg1NDm/NgiDlabQUERL58JPa8PLDoBGNcrQe
         UViEx/huhouozGuF1ReNuDCV6qLl5/CDJPIjGFKluMIXxsyDtF8w+FPFFrm8AUlXamWA
         2BJhm3bZbQLSYkNAIlVqp7fBo6ZiporkNNYuhAuJ7MzLTkny8T7dk/q9vi3WRA0iGk6L
         EcWFAoNppZS3Z1bk1HibGXAhweUxn+5P4+XDvsLwHu+2l2mT7QWonmOAJ9t64HL+wxaC
         XDHQ==
X-Gm-Message-State: ABy/qLYnsCD5/LN8+wmbNNx7onK9KhmwLEQjZgdy74L3hLtSEEp10PBP
        ASOhCp5CbBFPdRlFQlgpi3I4/6PJQjiZVm72Rm9UCcz3y48kKV0YeSIuIxDjE24mvioHP7xSFGZ
        iD28iMfM6NngS+2X+CKs34ewptx8Wba4L3KlgBZP0+mJ1Lii7BazBf5Tg/pzt7roaaB8S8mC9md
        Uq
X-Google-Smtp-Source: APBJJlEe5oavYCB7A8L9kHsW/kzX5OqKPCp/uwzdu8psKVDAKzfjm3W9XVbOMyl6YzfDsrCNp+NlbhZgOFQu
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:3344:0:b0:563:e1ff:aeb0 with SMTP id
 z65-20020a633344000000b00563e1ffaeb0mr1300pgz.3.1690322518353; Tue, 25 Jul
 2023 15:01:58 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:59 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-7-afranji@google.com>
Subject: [PATCH v4 06/28] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
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

From: Ackerley Tng <ackerleytng@google.com>

This also exercises the KVM_TDX_CAPABILITIES ioctl.

Suggested-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I967f7b613cd38469379fbbe297725d46b4e3ae4f
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 69 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index c90ad29f7733..95c6fb263583 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -27,10 +27,9 @@ static char *tdx_cmd_str[] = {
 };
 #define TDX_MAX_CMD_STR (ARRAY_SIZE(tdx_cmd_str))
 
-static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+static int _tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 {
 	struct kvm_tdx_cmd tdx_cmd;
-	int r;
 
 	TEST_ASSERT(ioctl_no < TDX_MAX_CMD_STR, "Unknown TDX CMD : %d\n",
 		    ioctl_no);
@@ -40,11 +39,58 @@ static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
 	tdx_cmd.flags = flags;
 	tdx_cmd.data = (uint64_t)data;
 
-	r = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+	return ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+}
+
+static void tdx_ioctl(int fd, int ioctl_no, uint32_t flags, void *data)
+{
+	int r;
+
+	r = _tdx_ioctl(fd, ioctl_no, flags, data);
 	TEST_ASSERT(r == 0, "%s failed: %d  %d", tdx_cmd_str[ioctl_no], r,
 		    errno);
 }
 
+static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
+{
+	int i;
+	int rc = -1;
+	int nr_cpuid_configs = 4;
+	struct kvm_tdx_capabilities *tdx_cap = NULL;
+
+	do {
+		nr_cpuid_configs *= 2;
+
+		tdx_cap = realloc(
+			tdx_cap, sizeof(*tdx_cap) +
+			nr_cpuid_configs * sizeof(*tdx_cap->cpuid_configs));
+		TEST_ASSERT(tdx_cap != NULL,
+			    "Could not allocate memory for tdx capability nr_cpuid_configs %d\n",
+			    nr_cpuid_configs);
+
+		tdx_cap->nr_cpuid_configs = nr_cpuid_configs;
+		rc = _tdx_ioctl(vm->fd, KVM_TDX_CAPABILITIES, 0, tdx_cap);
+	} while (rc < 0 && errno == E2BIG);
+
+	TEST_ASSERT(rc == 0, "KVM_TDX_CAPABILITIES failed: %d %d",
+		    rc, errno);
+
+	pr_debug("tdx_cap: attrs: fixed0 0x%016llx fixed1 0x%016llx\n"
+		 "tdx_cap: xfam fixed0 0x%016llx fixed1 0x%016llx\n",
+		 tdx_cap->attrs_fixed0, tdx_cap->attrs_fixed1,
+		 tdx_cap->xfam_fixed0, tdx_cap->xfam_fixed1);
+
+	for (i = 0; i < tdx_cap->nr_cpuid_configs; i++) {
+		const struct kvm_tdx_cpuid_config *config =
+			&tdx_cap->cpuid_configs[i];
+		pr_debug("cpuid config[%d]: leaf 0x%x sub_leaf 0x%x eax 0x%08x ebx 0x%08x ecx 0x%08x edx 0x%08x\n",
+			 i, config->leaf, config->sub_leaf,
+			 config->eax, config->ebx, config->ecx, config->edx);
+	}
+
+	return tdx_cap;
+}
+
 #define XFEATURE_LBR 15
 #define XFEATURE_CET_U 11
 #define XFEATURE_CET_S 12
@@ -85,6 +131,21 @@ static void tdx_apply_cpuid_restrictions(struct kvm_cpuid2 *cpuid_data)
 	}
 }
 
+static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attributes)
+{
+	struct kvm_tdx_capabilities *tdx_cap;
+
+	tdx_cap = tdx_read_capabilities(vm);
+
+	/* TDX spec: any bits 0 in attrs_fixed0 must be 0 in attributes */
+	ASSERT_EQ(attributes & ~tdx_cap->attrs_fixed0, 0);
+
+	/* TDX spec: any bits 1 in attrs_fixed1 must be 1 in attributes */
+	ASSERT_EQ(attributes & tdx_cap->attrs_fixed1, tdx_cap->attrs_fixed1);
+
+	free(tdx_cap);
+}
+
 static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 {
 	const struct kvm_cpuid2 *cpuid;
@@ -98,6 +159,8 @@ static void tdx_td_init(struct kvm_vm *vm, uint64_t attributes)
 	memset(init_vm, 0, sizeof(*init_vm));
 	memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
 
+	tdx_check_attributes(vm, attributes);
+
 	init_vm->attributes = attributes;
 
 	tdx_apply_cpuid_restrictions(&init_vm->cpuid);
-- 
2.41.0.487.g6d72f3e995-goog

