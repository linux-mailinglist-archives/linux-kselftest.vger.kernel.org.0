Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB756FEE81
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjEKJR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjEKJRV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 05:17:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4525AA5F7;
        Thu, 11 May 2023 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683796599; x=1715332599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n3XwJXO5FdIVuPB1WqckwaILsrCamFfH7Cyu/4AMII0=;
  b=OCxstCiYFYXfqDhWUGpbqENIUn7xZsanH+ZHRdW3YyiGMk6FzztNoDE3
   DUhmjo3S0jx+bXYHvvpLWG9F0g/upihjyu8aXtb9jztPgQP9hmaqF9sTY
   4tdirOJS9SRBu1ubGaMh2iH4uotB/XT6dkMCq6WJUXgEpjW7tuUvpRfKP
   y8EXkX3Re3v/D8NWVDt8OITeCWwNLgdNKZ114br4d8itnFAewXzVtCy2h
   T6gnH9REDdigQjkam/8q6QI/1emNVpMz45K+euoLYLS/cPfazKRswq+Q6
   5yy3aJX5L/c/2E1TmCctmQW94WKXjGBjP1zUH80oUJoLMyYFJzmujUqGL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="416040303"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="416040303"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="789316811"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="789316811"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 02:16:34 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, ajones@ventanamicro.com,
        Haibo Xu <haibo1.xu@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] RISCV: Add KVM_GET_REG_LIST API
Date:   Thu, 11 May 2023 17:22:47 +0800
Message-Id: <cover.1683791148.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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

Patch 1 enabled the KVM_GET_REG_LIST API in riscv and patch 2 added
the corresponding kselftest for checking possible register regressions.

Both patches were ported from arm64 and tested with Linux 6.4-rc1 on a
Qemu riscv virt machine.

Haibo Xu (2):
  riscv: kvm: Add KVM_GET_REG_LIST API support
  KVM: selftests: Add riscv get-reg-list test

 Documentation/virt/kvm/api.rst                |   2 +-
 arch/riscv/kvm/vcpu.c                         | 346 +++++++
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/include/riscv/processor.h   |   3 +
 .../selftests/kvm/riscv/get-reg-list.c        | 869 ++++++++++++++++++
 5 files changed, 1222 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c

-- 
2.34.1

