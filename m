Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0DA760D47
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGYIlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGYIk5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:40:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADAF19BF;
        Tue, 25 Jul 2023 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274424; x=1721810424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqDvxDhtOrH/ZxpWvBX+hbQeY8ju0wv1s0jCmUcL6Vs=;
  b=QZwwKP87ITiNibz8Sk5TecERte4wy7AGNVcafevwN2WhYGf32TOyoJ2n
   GQUVVImYoNPZRnaxgTvHpEMwbFE1IxbIDmUOjCEFkKpsOhVhH81hDfVtl
   1xiBvvbg4viq+DxoISqg+Er63XQws2p+D/T3r039cyaxM5g5E5z3D4Ej/
   w4mOc2diIWzz9x3Qwq2pcAtuKjQkLbzEbt8k4QNM36xxcQiNkcXIk7gYV
   duezITDm671oYwtP7anHwSbUQj46y0TGKgV+5xYLuH8MXS3C47R/+vEwl
   DRCl2/Rmt7rmYtl0tmo/3ZbgklSr4R33L9AUs7lUU6sVwQfnUHUUKSTPS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371265078"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371265078"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761131217"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761131217"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:38:39 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        maz@kernel.org, oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 11/13] KVM: selftests: Add skip_set facility to get_reg_list test
Date:   Tue, 25 Jul 2023 16:41:37 +0800
Message-Id: <04cecbc3169d93d7501885a205851f4e8b0a935b.1690273969.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690273969.git.haibo1.xu@intel.com>
References: <cover.1690273969.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new skips_set members to vcpu_reg_sublist so as to skip
set operation on some registers.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/get-reg-list.c    | 20 +++++++++++++------
 .../selftests/kvm/include/kvm_util_base.h     |  2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index 2232620fb797..be7bf5224434 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -163,6 +163,7 @@ static void run_test(struct vcpu_reg_list *c)
 {
 	int new_regs = 0, missing_regs = 0, i, n;
 	int failed_get = 0, failed_set = 0, failed_reject = 0;
+	int skipped_set = 0;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct vcpu_reg_sublist *s;
@@ -216,7 +217,7 @@ static void run_test(struct vcpu_reg_list *c)
 			.id = reg_list->reg[i],
 			.addr = (__u64)&addr,
 		};
-		bool reject_reg = false;
+		bool reject_reg = false, skip_reg = false;
 		int ret;
 
 		ret = __vcpu_get_reg(vcpu, reg_list->reg[i], &addr);
@@ -227,8 +228,8 @@ static void run_test(struct vcpu_reg_list *c)
 			++failed_get;
 		}
 
-		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
 		for_each_sublist(c, s) {
+			/* rejects_set registers are rejected for set operation */
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
 				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
@@ -240,9 +241,16 @@ static void run_test(struct vcpu_reg_list *c)
 				}
 				break;
 			}
+
+			/* skips_set registers are skipped for set operation */
+			if (s->skips_set && find_reg(s->skips_set, s->skips_set_n, reg.id)) {
+				skip_reg = true;
+				++skipped_set;
+				break;
+			}
 		}
 
-		if (!reject_reg) {
+		if (!reject_reg && !skip_reg) {
 			ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
 			if (ret) {
 				printf("%s: Failed to set ", config_name(c));
@@ -287,9 +295,9 @@ static void run_test(struct vcpu_reg_list *c)
 	}
 
 	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
-		    "%s: There are %d missing registers; "
-		    "%d registers failed get; %d registers failed set; %d registers failed reject",
-		    config_name(c), missing_regs, failed_get, failed_set, failed_reject);
+		    "%s: There are %d missing registers; %d registers failed get; "
+		    "%d registers failed set; %d registers failed reject; %d registers skipped set",
+		    config_name(c), missing_regs, failed_get, failed_set, failed_reject, skipped_set);
 
 	pr_info("%s: PASS\n", config_name(c));
 	blessed_n = 0;
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index ec65c292b5fd..a2623aaf3a55 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -134,6 +134,8 @@ struct vcpu_reg_sublist {
 	__u64 regs_n;
 	__u64 *rejects_set;
 	__u64 rejects_set_n;
+	__u64 *skips_set;
+	__u64 skips_set_n;
 };
 
 struct vcpu_reg_list {
-- 
2.34.1

