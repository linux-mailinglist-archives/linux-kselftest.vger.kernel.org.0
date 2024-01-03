Return-Path: <linux-kselftest+bounces-2607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DF822A04
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D51F20FE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A86182B3;
	Wed,  3 Jan 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7lIBFb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373E18AE4;
	Wed,  3 Jan 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704273218; x=1735809218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cTwg2O0ziBhg+OL/NfG87tprFRUxjdv/1jQ57i90GUg=;
  b=H7lIBFb29p+Shbn5LxJwQYIVc3qoc/0JpNyGoSnAuy7/dx1E7amP2oWu
   xFQV+cfx30Q2BREM2n5VfKL7+nPYGU7FRhtRaYR0l8V2714hb5gY0cHuc
   J4rRxfcL63+a6J17tREBSjU0mtp8kjRtlBuc1/gHblNlF5ljjNu+Trlun
   uptXjwZ2+khPmFykgbXnE3Gp8aFa9dOWJpQaF+AZ7nwGnjcEV05pKs18j
   btPCtPyvUdVeVU8l2wsShJdzbZGI1PBzPGqo0tFn1SBejtUP+tdusiB/z
   y9oELmnHbDtb2R47O8L60LPLOljEwkkddSTBk079mIjdK33i0yej+SZIA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="400794941"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="400794941"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="814207245"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="814207245"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:13:35 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	shuah@kernel.org,
	stevensd@chromium.org,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH v2 1/3] KVM: allow mapping of compound tail pages for IO or PFNMAP mapping
Date: Wed,  3 Jan 2024 16:44:24 +0800
Message-Id: <20240103084424.20014-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240103084327.19955-1-yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Allow mapping of tail pages of compound pages for IO or PFNMAP mapping
by trying and getting ref count of its head page.

For IO or PFNMAP mapping, sometimes it's backed by compound pages.
KVM will just return error on mapping of tail pages of the compound pages,
as ref count of the tail pages are always 0.

So, rather than check and add ref count of a tail page, check and add ref
count of its folio (head page) to allow mapping of the compound tail pages.

This will not break the origial intention to disallow mapping of tail pages
of non-compound higher order allocations as the folio of a non-compound
tail page is the same as the page itself.

On the other side, put_page() has already converted page to folio before
putting page ref.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index acd67fb40183..f53b58446ac7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2892,7 +2892,7 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
 	if (!page)
 		return 1;
 
-	return get_page_unless_zero(page);
+	return folio_try_get(page_folio(page));
 }
 
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
-- 
2.17.1


