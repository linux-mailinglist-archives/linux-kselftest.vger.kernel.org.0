Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99073B55D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjFWKe0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFWKeZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 06:34:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B3E6D;
        Fri, 23 Jun 2023 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687516465; x=1719052465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ug0tb+KIthtcBNlWZulbUMsIP+un6qpERH8Wcsp0QfQ=;
  b=RMwaB1jYY1ppCly5Sx/9YiZAKiOLjNc0nwLw4vp/jJ+Ue3ugpXRPbI4I
   keWwNrVx60loOl4TWulSV88lfMOyT2iYDz9lhNbOQjdan4jiKSI5XtF+j
   VD92M4aJxVNBRLRFWo4hEJ/tOhTxOe02Ee39o4P3edGdfOllTqpJjLHZQ
   NRz4sWwOo4NjHRF9NR9j7gw9KRDICFOs8xQ3DZM3K38TsTGd5C2lvnFu2
   pkPnDrVKGZU2ICydfrBPznUfRUqgkKQE5HPyUEC8RoMEK7KppXljyPKY7
   EJkjo6tAdWOLj5spxND8BqXuvAoTrUCMfAccYTlJZ8x4fICzGveop4Aoy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447112225"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="447112225"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715275624"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="715275624"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:34:17 -0700
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
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v4 00/12] RISCV: Add KVM_GET_REG_LIST API
Date:   Fri, 23 Jun 2023 18:40:02 +0800
Message-Id: <cover.1687515463.git.haibo1.xu@intel.com>
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

Patch 8 move reject_set check logic to a function so as to check for
different errno for different registers.
Patch 9 change to do the get/set operation only on present-blessed list.
Patch 10 enabled the KVM_GET_REG_LIST API in riscv.
patch 11-12 added the corresponding kselftest for checking possible
register regressions.

The get-reg-list kvm selftest was ported from aarch64 and tested with
Linux 6.4-rc6 on a Qemu riscv64 virt machine.

---
Changed since v3:
  * Rebase to Linux 6.4-rc6
  * Address Andrew's suggestions and comments:
  *   Move reject_set check logic to a function 
  *   Only do get/set tests on present blessed list 
  *   Only enable ISA extension for the specified config
  *   For disable-not-allowed registers, move them to the filter-reg-list 

Andrew Jones (7):
  KVM: arm64: selftests: Replace str_with_index with strdup_printf
  KVM: arm64: selftests: Drop SVE cap check in print_reg
  KVM: arm64: selftests: Remove print_reg's dependency on vcpu_config
  KVM: arm64: selftests: Rename vcpu_config and add to kvm_util.h
  KVM: arm64: selftests: Delete core_reg_fixup
  KVM: arm64: selftests: Split get-reg-list test code
  KVM: arm64: selftests: Finish generalizing get-reg-list

Haibo Xu (5):
  KVM: arm64: selftests: Move reject_set check logic to a function
  KVM: selftests: Only do get/set tests on present blessed list
  KVM: riscv: Add KVM_GET_REG_LIST API support
  KVM: riscv: selftests: Add finalize_vcpu check in run_test
  KVM: riscv: selftests: Add get-reg-list test

 Documentation/virt/kvm/api.rst                |   2 +-
 arch/riscv/kvm/vcpu.c                         | 375 +++++++++
 tools/testing/selftests/kvm/Makefile          |  11 +-
 .../selftests/kvm/aarch64/get-reg-list.c      | 538 ++-----------
 tools/testing/selftests/kvm/get-reg-list.c    | 439 ++++++++++
 .../selftests/kvm/include/kvm_util_base.h     |  16 +
 .../selftests/kvm/include/riscv/processor.h   |   3 +
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/test_util.c   |  15 +
 .../selftests/kvm/riscv/get-reg-list.c        | 752 ++++++++++++++++++
 10 files changed, 1658 insertions(+), 495 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/get-reg-list.c
 create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c

-- 
2.34.1

