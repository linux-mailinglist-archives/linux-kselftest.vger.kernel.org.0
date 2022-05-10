Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22052237A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348625AbiEJSNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348574AbiEJSNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530F2DD42;
        Tue, 10 May 2022 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206165; x=1683742165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFTHhq4woqpSkhGf11yNqzK7nbv+PvESVq4jqtacO5M=;
  b=N48/j/qGBM/QL2slb6USqtPU7jsxwts10eZh7kRLBwNQhs9mbSyd4wOE
   XHEalLpyJe/VtP2QR5cJ4gMO94D/0GU4KQ7U0PhWfZt3MxzG5q8q++OV4
   zkefhwhwkLZl6YgHpFxh1ekgAUH7YK0R8d1ICATb/0BPrdmEUlptfLioh
   XxyX984ixUk2Ebem8klr9ak3qYRWMsqelz37FoptOcZl5/qSZpmilQ8+V
   FOmUnVrSFhhcIgTelwfM8r5QmVlLmFqpBlDK41oC78CD6tBQKsD2XgMrW
   eRLldX+rDzvHl/bR6OrfrqOMs61+o1QqwKuCECHHdHWx30II6eCU/orje
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057534"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908799"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 17/31] x86/sgx: Tighten accessible memory range after enclave initialization
Date:   Tue, 10 May 2022 11:08:53 -0700
Message-Id: <6391460d75ae79cea2e81eef0f6ffc03c6e9cfe7.1652137848.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652137848.git.reinette.chatre@intel.com>
References: <cover.1652137848.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Add comment (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 1b9086648b2e..fcc145068498 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -498,6 +498,11 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
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

