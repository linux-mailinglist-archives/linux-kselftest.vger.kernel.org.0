Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88DF5000DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiDMVNi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiDMVNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57455403DD;
        Wed, 13 Apr 2022 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884249; x=1681420249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXCxTzS8QRMUlezOFvEemdragzbqEBeovAke5UNC638=;
  b=TJVYuMUUrMZVT6VPV+24wtOz06Wt/QZusfdRzhjam1H1Dg4icA/WkMkM
   6MKMsQ3X9E3DuUVQg1MPurhZBbEbib9cc74KEhHF17EvzB+0bbhJuQFBK
   LfKQIOU95+AjGe/RxXf881ikJL/wSkANuuFWNHDs71/4T886qL7jmXze+
   acwc5w1wxCe9AZjnGQTFMHCdqFQ9wM9UVQJdKN/ufS87NrPmOerpZ0V+h
   ADpJ20SgdPCtfe6kXalTLvUWbvWdYMd9yuycxvTK80klCaKPjZcHG7gsB
   RfgJVl0oS4s4aVsM53x6wdhgoad4I4IJbgxA6EQJfBVwjgjGTP0FV/15k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219049"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054299"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 20/31] x86/sgx: Free up EPC pages directly to support large page ranges
Date:   Wed, 13 Apr 2022 14:10:20 -0700
Message-Id: <0cf06e239fbc6e09b23936cf83a6c65271734d0b.1649878359.git.reinette.chatre@intel.com>
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

The page reclaimer ensures availability of EPC pages across all
enclaves. In support of this it runs independently from the
individual enclaves in order to take locks from the different
enclaves as it writes pages to swap.

When needing to load a page from swap an EPC page needs to be
available for its contents to be loaded into. Loading an existing
enclave page from swap does not reclaim EPC pages directly if
none are available, instead the reclaimer is woken when the
available EPC pages are found to be below a watermark.

When iterating over a large number of pages in an oversubscribed
environment there is a race between the reclaimer woken up and
EPC pages reclaimed fast enough for the page operations to proceed.

Ensure there are EPC pages available before attempting to load
a page that may potentially be pulled from swap into an available
EPC page.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.
- Rename sgx_direct_reclaim() to sgx_reclaim_direct(). (Jarkko)
- Add Dave's provided comments to sgx_reclaim_direct(). (Dave)

Changes since v1:
- Reword commit message.

 arch/x86/kernel/cpu/sgx/ioctl.c |  6 ++++++
 arch/x86/kernel/cpu/sgx/main.c  | 11 +++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h   |  1 +
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index f9a1654a49b7..83674d054c13 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -745,6 +745,8 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
 		addr = encl->base + modp->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -910,6 +912,8 @@ static long sgx_enclave_modify_type(struct sgx_encl *encl,
 	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
 		addr = encl->base + modt->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -1095,6 +1099,8 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
 		addr = encl->base + params->offset + c;
 
+		sgx_reclaim_direct();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6e2cb7564080..0e8741a80cf3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -370,6 +370,17 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_active_page_list);
 }
 
+/*
+ * sgx_reclaim_direct() should be called (without enclave's mutex held)
+ * in locations where SGX memory resources might be low and might be
+ * needed in order to make forward progress.
+ */
+void sgx_reclaim_direct(void)
+{
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages();
+}
+
 static int ksgxd(void *p)
 {
 	set_freezable();
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index b30cee4de903..0f2020653fba 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -86,6 +86,7 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
+void sgx_reclaim_direct(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-- 
2.25.1

