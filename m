Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECA48133F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbhL2NOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:14:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:28053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240166AbhL2NNp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783624; x=1672319624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BxyXCBlIcIydxNO0bBASe3mjemnMtb6BK5l0RjDi1bY=;
  b=H+MMRCVkrK0WOOfK5pnPfP8boh+xua/4ZHh6o3EGF+gzTaijsnKXsYK4
   /Ap1fHUSyR+Ycskbin2rZDQ9NzaH+ILm7Ngp/VL12PIlRGFUDrYmoHc9d
   vYnR2jEQbUjWtDpMq10xQwhMdCuXHJlcXvGkcgqc256zeQD0DbBlVnigv
   zcEYjK4nFIWm6CXGRucP768Zh3zfLbwsNfJF0PwfSfLPqLpbB70AmusjJ
   k45moCUKTTpvxJt34gW3HQxPjqoT4TZ+gCFAcvn8BWQjZXyzINC7oZ9gl
   GVnBgmKbQLlUKx9dsJmiiQmJ8KRO+M66ItF+tz6esImhqsAVmxE9uKPK6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876130"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876130"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281187"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:37 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 11/21] x86/fpu: Prepare xfd_err in struct fpu_guest
Date:   Wed, 29 Dec 2021 05:13:18 -0800
Message-Id: <20211229131328.12283-12-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

When XFD causes an instruction to generate #NM, IA32_XFD_ERR
contains information about which disabled state components are
being accessed. The #NM handler is expected to check this
information and then enable the state components by clearing
IA32_XFD for the faulting task (if having permission).

If the XFD_ERR value generated in guest is consumed/clobbered
by the host before the guest itself doing so. This may lead to
non-XFD-related #NM treated as XFD #NM in host (due to non-zero
value in XFD_ERR), or XFD-related #NM treated as non-XFD #NM in
guest (XFD_ERR cleared by the host #NM handler).

Introduce a new field in fpu_guest to save the guest xfd_err value.
KVM is expected to save guest xfd_err before preemption is enabled
and restore it right before entering the guest (with preemption
disabled).

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c752d0aa23a4..3795d0573773 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -517,6 +517,11 @@ struct fpu_guest {
 	 */
 	u64				perm;
 
+	/*
+	 * @xfd_err:			Save the guest value.
+	 */
+	u64				xfd_err;
+
 	/*
 	 * @fpstate:			Pointer to the allocated guest fpstate
 	 */
