Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019454AAC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiFNHkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiFNHkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 03:40:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F82F652;
        Tue, 14 Jun 2022 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192407; x=1686728407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hqgb9+9/76MlkiEINqaaPHa0H8cwPqTYlC9k5aVSHkY=;
  b=BCj+sGx/n3Za90fpmZNSgFSBdiqGgQbBiF7C4bXPcn1tuUp8d+9Ti1Mf
   Jy1QLkMn2YWVIVzThVB/puW91KUCuuDXUPIUkvDCNdfgObULe29My5N91
   InZazYb+TTk12Jw+/vmo5evgeKDlLOVJZu7Is5blDvs5mChMinLvMDcZN
   dBAPv5e+wZncMGZ3SD5ND6fRaR9qRCnefuBOsws/b7iKSELku3DH5nKmj
   sdcl4FjnlI/EE7cayxozsV/tWTmKBmllS4rA2mAHijpigm1IA3Pne4LRB
   iFzipkWqswLilOJQVHUHSeFjXVEOPDjlFKE3j75vDKR3jro7umWv8J5d2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364875044"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364875044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="651887988"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2022 00:40:03 -0700
From:   shaoqin.huang@intel.com
To:     pbonzini@redhat.com
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Peter Gonda <pgonda@google.com>,
        David Dunn <daviddunn@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Remove the mismatched parameter comments
Date:   Tue, 14 Jun 2022 16:41:19 -0600
Message-Id: <20220614224126.211054-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

There are some parameter being removed in function but the parameter
comments still exist, so remove them.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1665a220abcb..58fdc82b20f4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1336,8 +1336,6 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
- *   data_memslot - Memory region slot for data pages
- *   pgd_memslot - Memory region slot for new virtual translation tables
  *
  * Output Args: None
  *
@@ -1423,7 +1421,6 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
  *   vaddr - Virtuall address to map
  *   paddr - VM Physical Address
  *   npages - The number of pages to map
- *   pgd_memslot - Memory region slot for new virtual translation tables
  *
  * Output Args: None
  *
-- 
2.30.2

