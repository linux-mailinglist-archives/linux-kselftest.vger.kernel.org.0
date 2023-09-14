Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60679F655
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjINB3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjINB3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 21:29:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409D1BE4;
        Wed, 13 Sep 2023 18:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694654950; x=1726190950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HECq7ZimFQCzoaZmWYi01Qtb1SUQg3CL84moiHOKq74=;
  b=n7GC/auuc+/yvIFgoHDSBiwTV6O2wRq6ByP97cti2XeceP+9UTQt+Jw5
   xwxY01BeTzB1VnO26uvEMmgCFyI3QyznECE1Bo/ZgLsco+SWTfZg/ksuO
   lMDtXDHIL+uk0nIdBTAnRQykqmKQbeUwsUpptF5rMJquS/3XxckqzfSt0
   S79XI3AsLrlm/NeD/5hpqwNILQ32+Ez4Cif7LRUJtDG5lHUJ9UTyXRrxm
   mF3OzvugZ5VMEePKcRQhJk2GqfsX+NTuAD63GZE3bqlN3JUjCDadqFjml
   uINx/hxdtXnTIXf9TWJfbtJJiLMOEZ7YYqG+v+GmC6oWIQ1+cQu5YploB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377734170"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377734170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694049382"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="694049382"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:29:02 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Peter Xu <peterx@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v3 5/9] KVM: riscv: selftests: Switch to use macro from csr.h
Date:   Thu, 14 Sep 2023 09:36:59 +0800
Message-Id: <6cdda82518977c67004ee01a767bc67962352c13.1694421911.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694421911.git.haibo1.xu@intel.com>
References: <cover.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5b62a3d2aa9b..67766baed4f7 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -8,6 +8,7 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include "kvm_util.h"
+#include <asm/csr.h>
 #include <linux/stringify.h>
 
 static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
@@ -95,13 +96,6 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
 #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
 
-#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
-#define SATP_MODE_39				_AC(0x8000000000000000, UL)
-#define SATP_MODE_48				_AC(0x9000000000000000, UL)
-#define SATP_ASID_BITS				16
-#define SATP_ASID_SHIFT				44
-#define SATP_ASID_MASK				_AC(0xFFFF, UL)
-
 #define SBI_EXT_EXPERIMENTAL_START		0x08000000
 #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
 
-- 
2.34.1

