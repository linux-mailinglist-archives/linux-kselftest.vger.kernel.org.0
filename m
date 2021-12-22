Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F447D1FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbhLVMlW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:11440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245036AbhLVMlH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176867; x=1671712867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXq6/YEFmL7fuafodWXOL+G8jefqhvh1JXMT3eAUNEI=;
  b=fOiqHG8PZRDT6TpSeRFg9DtuGVi9sUSceFhgd80SSBHHzfN5fIEr5dZB
   ZPynlJ7qIoZKWwKHWsWkhngeLwLtrLqbksvBui88OsKLPtFh/PLRsLS5U
   aDx+GZdpBIBnMK9XIqkQHZAa6FKypwNH2Kxd+gxINH8fS3vPtl8ZNMhxr
   8pl2dnG+0LPAfw4QxwzqACfM+S+Pq06LhmbjByaRBGjfzvyZfofocXrf9
   z/HKCpHAtWZ1NZuuh0ne4YBzN0nUHQTa+co9EZtUvA33cscNVlX5dK95S
   VGP0p2wFNpXTNDeFKwZ5b7Q0MY0PKw+YlUOlxC8wfvB7DTeFTSMfMwGyr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833421"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833421"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002748"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:02 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 12/22] x86/fpu: Prepare xfd_err in struct fpu_guest
Date:   Wed, 22 Dec 2021 04:40:42 -0800
Message-Id: <20211222124052.644626-13-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
-- 
2.27.0

