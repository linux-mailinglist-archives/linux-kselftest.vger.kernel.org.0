Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C115E48131A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhL2NNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:13:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:28042 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239690AbhL2NNb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783611; x=1672319611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JgMD2asiRllhjWMoZTzNhD1SxeX3nBSDkeUc3hAzG4U=;
  b=TCPx/0RsGrs9hEd9B2mBkQO4HvQU3MWXDSmg5y/TqlsNRvt1eQVajwNM
   RwmbpumRBDfKkISl9ynhT3gUupmIvy8Gxc70iyOTH6zj/0qAUNxWISmf0
   4FaU5Zx3S30rMcV7zbC1iP25FRFJ56EI3+Y9osJkZ3WWQxXf7CI+ucwJm
   VUL51jSfeT2J2LaIb6l9fP8RbAqvPsbK5F7o0vT0cN/hesLx9yu+bFdPL
   e7rIH6hBlgp8ii/ky/IgJEZAzp5/014RhP1bWdQ4Y0UIVgv4G6cfHLYcO
   9sUvp8Zrlg9PWn6tTYx33BvNhQnGtgdMicfj5lIwNqYYdInkin3dRvwVz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876115"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281153"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:30 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 03/21] kvm: x86: Fix xstate_required_size() to follow XSTATE alignment rule
Date:   Wed, 29 Dec 2021 05:13:10 -0800
Message-Id: <20211229131328.12283-4-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

CPUID.0xD.1.EBX enumerates the size of the XSAVE area (in compacted
format) required by XSAVES. If CPUID.0xD.i.ECX[1] is set for a state
component (i), this state component should be located on the next
64-bytes boundary following the preceding state component in the
compacted layout.

Fix xstate_required_size() to follow the alignment rule. AMX is the
first state component with 64-bytes alignment to catch this bug.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 07e9215e911d..148003e26cbb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -42,7 +42,8 @@ static u32 xstate_required_size(u64 xstate_bv, bool compacted)
 		if (xstate_bv & 0x1) {
 		        u32 eax, ebx, ecx, edx, offset;
 		        cpuid_count(0xD, feature_bit, &eax, &ebx, &ecx, &edx);
-			offset = compacted ? ret : ebx;
+			/* ECX[1]: 64B alignment in compacted form */
+			offset = compacted ? ((ecx & 0x2) ? ALIGN(ret, 64) : ret) : ebx;
 			ret = max(ret, offset + eax);
 		}
 
