Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C190C7DF7C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbjKBQeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347656AbjKBQeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 12:34:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC013D;
        Thu,  2 Nov 2023 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698942839; x=1730478839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8b2lW3eo74qPEH0+9VzElndbmy1zGlp6Ujy7Gd2vHyU=;
  b=AmaOE2qtMikWedmjeBqGgVzNTdBFuLxpQy3Z+vKKxz3rPsIqsd1ttYZD
   PONBMZx6TwYQKPs5CSptGksGlzVgCMXrGu/7Dm7Zb4KsjQ0yhliHDvWsm
   Mc0zjo/PkDyNLe1LXFy+Igetso837e6ZIWBNonnwX80fyVch16q13pWzf
   eVur08M1fYy2OH82ZrLDeVSOAMdFHxpwsHtjYdT2IS3ZbBK68Fk5P9/L1
   +Xs2m1aQVRt3Yr3dpaiSF5zNsE0nsADM71EcKq/bLp8tezuAlHC4UTqwe
   T598HG2GRO6FJKidRpuXkiwmCsTvUZjG0aRsDax4YdfPPFvdGhe2yhkgH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388571110"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388571110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9448535"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:34 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, Zeng Guang <guang.zeng@intel.com>
Subject: [RFC PATCH v1 7/8] KVM: selftests: x86: Support vcpu run in user mode
Date:   Thu,  2 Nov 2023 23:51:10 +0800
Message-Id: <20231102155111.28821-8-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102155111.28821-1-guang.zeng@intel.com>
References: <20231102155111.28821-1-guang.zeng@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce vcpu_setup_user_mode() to support vcpu run in user mode.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/lib/x86_64/processor.c      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 9c8224c80664..2534bdf8aa71 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -800,6 +800,7 @@ static inline void cpu_relax(void)
 struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
 void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state);
 void kvm_x86_state_cleanup(struct kvm_x86_state *state);
+void vcpu_setup_user_mode(struct kvm_vcpu *vcpu, void *guest_code);
 
 const struct kvm_msr_list *kvm_get_msr_index_list(void);
 const struct kvm_msr_list *kvm_get_feature_msr_index_list(void);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 7647c3755ca2..c84292b35f2d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1071,6 +1071,25 @@ void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state)
 		vcpu_nested_state_set(vcpu, &state->nested);
 }
 
+void vcpu_setup_user_mode(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_vm *vm = vcpu->vm;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	kvm_seg_set_code_64bit(vm, USER_CODE_SELECTOR, &sregs.cs);
+	kvm_seg_set_data_64bit(vm, USER_DATA_SELECTOR, &sregs.ds);
+	kvm_seg_set_data_64bit(vm, USER_DATA_SELECTOR, &sregs.es);
+	kvm_seg_set_data_64bit(vm, USER_DATA_SELECTOR, &sregs.ss);
+	vcpu_sregs_set(vcpu, &sregs);
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.rsp = vcpu->stack_vaddr - (DEFAULT_STACK_PGS >> 1) * getpagesize();
+	regs.rip = (unsigned long) guest_code;
+	vcpu_regs_set(vcpu, &regs);
+}
+
 void kvm_x86_state_cleanup(struct kvm_x86_state *state)
 {
 	free(state->xsave);
-- 
2.21.3

