Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2605000D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiDMVNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbiDMVNH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C23A5C1;
        Wed, 13 Apr 2022 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884245; x=1681420245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXPfbaFXmvgsbCmIRR+xO9GdT1TQ8nzKB+sNNYKHV9E=;
  b=a5zWOEDR0z44UJzkwK/MVrXm5DIP1IJDzeXEfvlqpKm9I5ihkvCpg/6C
   AKBJrT0Fgd6dJLXROqtbEtpGafrjTni4NB0rxUY/VqArgYUgiQX5lCzg3
   jZlLSsbzJ4jQelOgO+QgZ3vPdG48l2E9NTFFlfgw0wYxDwqZiv6tgg1tN
   HJETOmJu+tHkm53yREA/YuC/8osfpn+0z2+eiYJO45hlqHJ9ffywFJe0/
   68skNgb0f7J1YR0HbTXL06MuIADaogQ7JmEfIRatazNQQzOzTg/szNmQo
   AZbJqcsoH3wbGTGu0YfGsjy7sW7dozGHt3VBVOuVzDP9378GsTjMHNCBS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219017"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054262"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:42 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 09/31] x86/sgx: Make sgx_ipi_cb() available internally
Date:   Wed, 13 Apr 2022 14:10:09 -0700
Message-Id: <41e34a579bd81ea4085e27ae4bf16c73914340ca.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ETRACK function followed by an IPI to all CPUs within an enclave
is a common pattern with more frequent use in support of SGX2.

Make the (empty) IPI callback function available internally in
preparation for usage by SGX2.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Replace "for more usages" by "for usage by SGX2" (Jarkko)

 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ce9e87d5f8ec..6e2cb7564080 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -172,7 +172,7 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	return ret;
 }
 
-static void sgx_ipi_cb(void *info)
+void sgx_ipi_cb(void *info)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f17def9fe6f..b30cee4de903 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -90,6 +90,8 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
+void sgx_ipi_cb(void *info);
+
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
 #else
-- 
2.25.1

