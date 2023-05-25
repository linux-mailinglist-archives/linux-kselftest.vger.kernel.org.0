Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0254710678
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjEYHgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjEYHfr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 03:35:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5AE5D;
        Thu, 25 May 2023 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685000137; x=1716536137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+u1HJaFTXrPVFD+3NbnmJ/AGWJcDm8pIPpTYzo4Zo5U=;
  b=Bkp5PEyInb678hmkrwtWbI30yRf5zJepIUrUlS8sd8LuIjCGC5dkVFrs
   VoOgJy4561daLXNDUnaJsdzm8Az1KkntxTC4gNtcsC7zJn++pCjiwe2+9
   9oaI7/upetz5i5JjqAqAMm/m6PwfGXt0y7bBO19ZS65PUSv564fVOM4mn
   YJF6DANeUdUP7/2qf6FlSFFpRGfLeunUe7cZQ+/d6ErqeLAjYrRZ4oJd3
   HYO1k9dR2+Gysx7oQ+E0Bjd0Kq81zBUbv7Z2DK//u7mShicUEtpFY7FNu
   Eot7+r/tShfvhiPs71Cd18c8LPATq6NZ9ipUk8j5ipPhFITn+Q6arOYpq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="356164562"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="356164562"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769776197"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="769776197"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:34:48 -0700
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
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v2 10/11] KVM: riscv: selftests: Skip some registers set operation
Date:   Thu, 25 May 2023 15:38:34 +0800
Message-Id: <a10cd1ff57e07e408d08eca7e6a4557217ca0af3.1684999824.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684999824.git.haibo1.xu@intel.com>
References: <cover.1684999824.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Set operation on some riscv registers(mostly pesudo ones) was not
supported and should be skipped in the get-reg-list test. Just
reuse the rejects_set utilities to handle it in riscv.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/get-reg-list.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
index f1fc113e9719..ebd6b580b33b 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -211,16 +211,22 @@ static void run_test(struct vcpu_reg_list *c)
 			++failed_get;
 		}
 
-		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
+		/*
+		 * rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE on aarch64,
+		 * or registers that should skip set operation on riscv.
+		 */
 		for_each_sublist(c, s) {
 			if (s->rejects_set && find_reg(s->rejects_set, s->rejects_set_n, reg.id)) {
 				reject_reg = true;
-				ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
-				if (ret != -1 || errno != EPERM) {
-					printf("%s: Failed to reject (ret=%d, errno=%d) ", config_name(c), ret, errno);
-					print_reg(config_name(c), reg.id);
-					putchar('\n');
-					++failed_reject;
+				if ((reg.id & KVM_REG_ARCH_MASK) == KVM_REG_ARM64) {
+					ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+					if (ret != -1 || errno != EPERM) {
+						printf("%s: Failed to reject (ret=%d, errno=%d) ",
+								config_name(c), ret, errno);
+						print_reg(config_name(c), reg.id);
+						putchar('\n');
+						++failed_reject;
+					}
 				}
 				break;
 			}
-- 
2.34.1

