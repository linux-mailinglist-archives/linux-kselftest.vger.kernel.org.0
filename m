Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2D760D12
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGYIf7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGYIf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:35:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4919C;
        Tue, 25 Jul 2023 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274156; x=1721810156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oi5o0PQk3nmBZgGrsnz6JWHqLdL0Xutih7n1mhmf6sQ=;
  b=RZL65WFyvfiOHJ0apQgV9QtLBlxh76m1BkpmlvHgzpeI0SFWokWh/BHA
   qxc6gnDE/M6FF5wox1pi261Dg1ZYB77VAUgsXiO3Ud5UsX1rFc5OOLDph
   Jb4KG9U12j20/sJEjGOHsZQVkEYAeo2yp0N4YKVfbEUqA9Ufkzxotv+Ak
   R2kp3v5lQs1x9ZbQrxTOQ18JM8LTF5h/cJAIfjM90xHpJPaPvFcqa2QbQ
   fnm4D5K8OAuDd9disW469guxi74//Bk2FfwcaEjXgvGRA3PejZJSbNAn+
   UxXMfRvQsDAeLar+6V3B4Nx98IzQ0cCmwloLejDBS7DhxAPElrBmoOg1E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371264137"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371264137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761129972"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761129972"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:35:45 -0700
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
        Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 00/13] RISCV: Add KVM_GET_REG_LIST API
Date:   Tue, 25 Jul 2023 16:41:26 +0800
Message-Id: <cover.1690273969.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
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

KVM_GET_REG_LIST will dump all register IDs that are available to
KVM_GET/SET_ONE_REG and It's very useful to identify some platform
regression issue during VM migration.

Patch 1-7 re-structured the get-reg-list test in aarch64 to make some
of the code as common test framework that can be shared by riscv.

Patch 8 move reject_set check logic to a function so as to check for
different errno for different registers.
Patch 9 move finalize_vcpu back to run_test so that riscv can implement
its specific operation.
Patch 10 change to do the get/set operation only on present-blessed list.
Patch 11 add the skip_set facilities so that riscv can skip set operation
on some registers.
Patch 12 enabled the KVM_GET_REG_LIST API in riscv.
patch 13 added the corresponding kselftest for checking possible
register regressions.

The get-reg-list kvm selftest was ported from aarch64 and tested with
Linux v6.5-rc3 on a Qemu riscv64 virt machine.

---
Changed since v5:
  * Rebase to v6.5-rc3
  * Minor fix for Andrew's comments

Andrew Jones (7):
  KVM: arm64: selftests: Replace str_with_index with strdup_printf
  KVM: arm64: selftests: Drop SVE cap check in print_reg
  KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
  KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
  KVM: arm64: selftests: Delete core_reg_fixup
  KVM: arm64: selftests: Split get-reg-list test code
  KVM: arm64: selftests: Finish generalizing get-reg-list

Haibo Xu (6):
  KVM: arm64: selftests: Move reject_set check logic to a function
  KVM: arm64: selftests: Move finalize_vcpu back to run_test
  KVM: selftests: Only do get/set tests on present blessed list
  KVM: selftests: Add skip_set facility to get_reg_list test
  KVM: riscv: Add KVM_GET_REG_LIST API support
  KVM: riscv: selftests: Add get-reg-list test

 Documentation/virt/kvm/api.rst                |   2 +-
 arch/riscv/kvm/vcpu.c                         | 375 +++++++++
 tools/testing/selftests/kvm/Makefile          |  13 +-
 .../selftests/kvm/aarch64/get-reg-list.c      | 554 ++-----------
 tools/testing/selftests/kvm/get-reg-list.c    | 401 +++++++++
 .../selftests/kvm/include/kvm_util_base.h     |  21 +
 .../selftests/kvm/include/riscv/processor.h   |   3 +
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/test_util.c   |  15 +
 .../selftests/kvm/riscv/get-reg-list.c        | 780 ++++++++++++++++++
 10 files changed, 1670 insertions(+), 496 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
 create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c

-- 
2.34.1

