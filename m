Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F97907E9
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352223AbjIBMws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352206AbjIBMwq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:52:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF49E1702;
        Sat,  2 Sep 2023 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659162; x=1725195162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nK8zunl6sSytTPWcLV67OItdVTMIy0Fmekb7+APwIxA=;
  b=ifZPalusNqL/vcwItmTGZAMUq1DYL2rdaduGPOCZOtsf9vunpjHtHiBO
   aQE9Mqm8rwJGDb/DJWQZkahrFKHBq+o5ciwMmSFIIpQvQ+Vgh7hqopI1k
   DJ2Cytc72aQdeMIo0mHE8yfALLe12P7+K+ko7hGxypGTqRS7tiBNSXZ56
   7ytgWFe9hd/rkdOA2s0ooE2TmiaZudEkfANctj4jBnv9V8jqxwq9dd2KZ
   2cNxHV6tEEK3T3Jcei2+/4JxlNdMWzuBKqV3aA8DkUBhzp19F+JpDqHxn
   BmfyNKts2wY2ENcTAn1/NBYEWvrPwGcn+utj47V+k+oQ38fkXX++CYL+f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599316"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855022099"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855022099"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:52:33 -0700
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
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>, Like Xu <likexu@tencent.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 4/8] KVM: riscv: selftests: Switch to use macro from csr.h
Date:   Sat,  2 Sep 2023 20:59:26 +0800
Message-Id: <ee4e518cbed9ff4210b74a22c5af21c410fab85d.1693659382.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693659382.git.haibo1.xu@intel.com>
References: <cover.1693659382.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5b62a3d2aa9b..6810c887fadc 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -8,6 +8,7 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include "kvm_util.h"
+#include <asm/csr.h>
 #include <linux/stringify.h>
 
 static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
@@ -95,12 +96,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
 #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
 
-#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39				_AC(0x8000000000000000, UL)
 #define SATP_MODE_48				_AC(0x9000000000000000, UL)
-#define SATP_ASID_BITS				16
-#define SATP_ASID_SHIFT				44
-#define SATP_ASID_MASK				_AC(0xFFFF, UL)
 
 #define SBI_EXT_EXPERIMENTAL_START		0x08000000
 #define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
-- 
2.34.1

