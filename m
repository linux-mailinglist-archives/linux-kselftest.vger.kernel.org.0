Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1B764885
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjG0HZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjG0HYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:24:13 -0400
Received: from mgamail.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E336591;
        Thu, 27 Jul 2023 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690442122; x=1721978122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BAACILCTxyqMs2Tae391dkKNJN/XDjDizeOYFsgg42A=;
  b=Q8zGkq7PeQe9jti7KiHDsDYNAF+jBh6svKrMNGuu0AM2TlHU682TY/Qz
   Buc61xQWaMJzC3fez9Wvk9wI7rLcMeRogtuoRyvoj8G539E7nsSIdMlKU
   SMEBX6TW5XFVJdImSu6ln15HZ9wqi14NuKqPvk1J7KpL6QtuNmgoTZP/E
   Sz5Vel6uXnFGu2u99ikIhqGWfmSPiO3bLOjmejo7/hw75YVdhXXf26fw9
   nc9aXrAJAdG5VY7pfIm0k2srzdKumSSkGRFKJmfqavsHKoEJwS9x5qJTp
   36lNyizwrVAjOUGypbAt1cdFqCIoxXpTHNFN4J/HmHWeft+Q3/iv1GdoR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367102049"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367102049"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720785797"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="720785797"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 00:14:08 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 0/4] RISCV: Add kvm Sstc timer selftest
Date:   Thu, 27 Jul 2023 15:20:04 +0800
Message-Id: <cover.1690364259.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sstc_timer selftest is used to validate Sstc timer functionality
in a guest, which sets up periodic timer interrupts and check the
basic interrupt status upon its receipt.

This KVM selftest was ported from aarch64 arch_timer and tested
with Linux v6.5-rc3 on a Qemu riscv64 virt machine.

Haibo Xu (4):
  tools: riscv: Add header file csr.h
  KVM: riscv: selftests: Add exception handling support
  KVM: riscv: selftests: Add guest helper to get vcpu id
  KVM: riscv: selftests: Add sstc_timer test

 tools/arch/riscv/include/asm/csr.h            | 127 ++++++
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/riscv/processor.h   |  76 ++++
 .../selftests/kvm/include/riscv/sstc_timer.h  |  70 ++++
 .../selftests/kvm/lib/riscv/handlers.S        | 101 +++++
 .../selftests/kvm/lib/riscv/processor.c       |  74 ++++
 .../testing/selftests/kvm/riscv/sstc_timer.c  | 382 ++++++++++++++++++
 7 files changed, 832 insertions(+)
 create mode 100644 tools/arch/riscv/include/asm/csr.h
 create mode 100644 tools/testing/selftests/kvm/include/riscv/sstc_timer.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
 create mode 100644 tools/testing/selftests/kvm/riscv/sstc_timer.c

-- 
2.34.1

