Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08895000D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiDMVNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbiDMVNK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82344A33;
        Wed, 13 Apr 2022 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884247; x=1681420247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TtQBkc71W/eE9bza27771JItHGMI7ZHCR/obhz2nAK0=;
  b=Cr7xtMr76CVXDf1v69X7XjR6DImUkVj1yV16N+OC13sYeUcE08xgZ1ND
   MdNrAPPUyVNd6bPrj9wlt4CCrGr3DBEgIN1JhT/2e99JJy9Q09dhURNZp
   YRybhxJLwHkdAVK9T8xHMOxKqHyfTwbyWrpaDwNH5JpS8SiNWeeAnjPXN
   ff7fPlR8X4t+O7o7rAcSW9VNUMBotB1M39jkeK6yvclzLi9WkskQ8xAE7
   60THUbJq2fMu6qqr4XfExlbwnaGB8JvUIwCy02jYz++vCx6OlmY0o0+QJ
   dyruq7/XDPlaPQHvlXilpDWRMSqeKV0sPEuFba+m+KaRKVWXa6SMlSnCf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219039"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219039"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054290"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:44 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 17/31] x86/sgx: Tighten accessible memory range after enclave initialization
Date:   Wed, 13 Apr 2022 14:10:17 -0700
Message-Id: <1eaa05cc46a09728036060b209deb2cf0351eb62.1649878359.git.reinette.chatre@intel.com>
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

Before an enclave is initialized the enclave's memory range is unknown.
The enclave's memory range is learned at the time it is created via the
SGX_IOC_ENCLAVE_CREATE ioctl() where the provided memory range is
obtained from an earlier mmap() of /dev/sgx_enclave. After an enclave
is initialized its memory can be mapped into user space (mmap()) from
where it can be entered at its defined entry points.

With the enclave's memory range known after it is initialized there is
no reason why it should be possible to map memory outside this range.

Lock down access to the initialized enclave's memory range by denying
any attempt to map memory outside its memory range.

Locking down the memory range also makes adding pages to an initialized
enclave more efficient. Pages are added to an initialized enclave by
accessing memory that belongs to the enclave's memory range but not yet
backed by an enclave page. If it is possible for user space to map
memory that does not form part of the enclave then an access to this
memory would eventually fail. Failures range from a prompt general
protection fault if the access was an ENCLU[EACCEPT] from within the
enclave, or a page fault via the vDSO if it was another access from
within the enclave, or a SIGBUS (also resulting from a page fault) if
the access was from outside the enclave.

Disallowing invalid memory to be mapped in the first place avoids
preventable failures.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Add comment (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7ccda6fe1f8f..11f97fdcac1e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -402,6 +402,11 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
 
+	/* Disallow mapping outside enclave's address range. */
+	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
+	    (start < encl->base || end > encl->base + encl->size))
+		return -EACCES;
+
 	/*
 	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
 	 * conflict with the enclave page permissions.
-- 
2.25.1

