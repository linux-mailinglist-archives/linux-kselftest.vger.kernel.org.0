Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF7710652
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEYHfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEYHfL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 03:35:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AE189;
        Thu, 25 May 2023 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685000109; x=1716536109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jLH4kQk6zi0cVy2k1sUXs4W9z4mmK4Cl2bsLik9SWEQ=;
  b=HipcddXa7Jt81SyYQ8jLSo5vDuWBZonYE1RqYCs9Eqfwt11G1Ugg1Hap
   WFdcBwD6E1dyUFfaHnqrr+Fe7ODaEPDtaVzTdfs1JZeciOFb1qwn4Q3Ph
   pXP60uMhtv0xVdRQujbJKM3oSA5oNLnwX1+o8xNvv2e+0uQ59L19af4+H
   3qpj+464UbTEu9CQeTGH1Yt4RtgyfRwxrsSU+ar/a2kIL+rV35+RB70KR
   KKGjItzfAm8ExkbILlqsyWty2q+iffmrDOGFVglz9pH2MQpJl/RoAIRY3
   +Q9Y9ILgIqpePhclHfOOYijsS8poRs8teKJyW/7IBiz1g5DAnXh61hnSZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="417280815"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="417280815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769774564"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="769774564"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 00:32:32 -0700
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
Subject: [PATCH v2 00/11] RISCV: Add KVM_GET_REG_LIST API
Date:   Thu, 25 May 2023 15:38:24 +0800
Message-Id: <cover.1684999824.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GET_REG_LIST will dump all register IDs that are available to
KVM_GET/SET_ONE_REG and It's very useful to identify some platform
regression issue during VM migration.

Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
of the code as common test framework that can be shared by riscv.

Patch 8 enabled the KVM_GET_REG_LIST API in riscv and patch 9-11 added
the corresponding kselftest for checking possible register regressions.

The get-reg-list kvm selftest was ported from aarch64 and tested with
Linux 6.4-rc1 on a Qemu riscv virt machine.

---
Changed since v1:
  * rebase to Andrew's changes
  * fix coding style

Andrew Jones (7):
  KVM: arm64: selftests: Replace str_with_index with strdup_printf
  KVM: arm64: selftests: Drop SVE cap check in print_reg
  KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
  KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
  KVM: arm64: selftests: Delete core_reg_fixup
  KVM: arm64: selftests: Split get-reg-list test code
  KVM: arm64: selftests: Finish generalizing get-reg-list

Haibo Xu (4):
  KVM: riscv: Add KVM_GET_REG_LIST API support
  KVM: riscv: selftests: Make check_supported arch specific
  KVM: riscv: selftests: Skip some registers set operation
  KVM: riscv: selftests: Add get-reg-list test

 Documentation/virt/kvm/api.rst                |   2 +-
 arch/riscv/kvm/vcpu.c                         | 372 ++++++++++++
 tools/testing/selftests/kvm/Makefile          |  13 +-
 .../selftests/kvm/aarch64/get-reg-list.c      | 540 ++----------------
 tools/testing/selftests/kvm/get-reg-list.c    | 426 ++++++++++++++
 .../selftests/kvm/include/kvm_util_base.h     |  16 +
 .../selftests/kvm/include/riscv/processor.h   |   3 +
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/test_util.c   |  15 +
 .../selftests/kvm/riscv/get-reg-list.c        | 539 +++++++++++++++++
 10 files changed, 1428 insertions(+), 500 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
 create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c

-- 
2.34.1

