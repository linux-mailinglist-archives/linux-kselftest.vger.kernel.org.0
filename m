Return-Path: <linux-kselftest+bounces-4268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DEE84D0AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75401C20B1E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB9136668;
	Wed,  7 Feb 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAQGWwPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259A13541B;
	Wed,  7 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328763; cv=none; b=DyHcAdKbVnFLldBVf+0MtoE1sGE4N8O/IaPCKeacKMGUusKK2qpewEmSYIFXTNECJbqUJuMLPnt8FH6FxURsidL54y6N3FIEConjL8pdYk35QGfVHjBfkIcIQs4NwELLt4LnUpsHSbdkr0Q80LHwa3dwWaK0YHuI5JWLmUjilu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328763; c=relaxed/simple;
	bh=gY2JzDeF5jrwJMCmaKGSaYZDR3/rk8mwy1w2IX+fWds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rp2+JRlbNEEaTgj2PxYDudUrHFLcf43WF10aev62ndxWtZfjmsyYJ0cMSVqlMaiSdEalx131b92PpmvWBDUuynKpcDnLgvtd4DJt31RR6KUkfAtNZqUyaEg1CNRKeShJwaldoW/jN9bZ9m4XfCpFJeVLzwc2Db2Kp/PREXJZM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAQGWwPc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328762; x=1738864762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gY2JzDeF5jrwJMCmaKGSaYZDR3/rk8mwy1w2IX+fWds=;
  b=hAQGWwPce/F3knbJgkrpM+1aBaOvcVsWOrHp24cc1F9iW2UNacHs3o5K
   opVvsjAstIjkqh/cZuz+Aroz/4ES7DsAp78ZOcyIfI6ul9O5uFcJ6MGTN
   jrzsrtIfU2moUTHpqBfEqQ4AN4X5KLOmIIGOakHdje37lv3I/fvEF8/5p
   WQrz3bfs+mhXQzcRx1tbCN9oqRdSLhW41PlesapGxNK3irVn+oSEbD89l
   ZjZ8coCqYq7/P/ircZaTWx40uFkPxEhCxc91EQCVqzQnH0dxuOq7PzjmX
   kaYnd7YDwWoKdsME1EkApPYF11Tvh1EZvsJboupjIYmeP4tbtXl6yrugl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622679"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622679"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020765"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:59 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 22/25] KVM: x86: Allow FRED/LKGS/WRMSRNS to be exposed to guests
Date: Wed,  7 Feb 2024 09:26:42 -0800
Message-ID: <20240207172646.3981-23-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow FRED/LKGS/WRMSRNS to be exposed to guests, thus a guest OS could see
these features when the guest is configured with FRED/LKGS/WRMSRNS in Qemu.

A qemu patch is required to expose FRED/LKGS/WRMSRNS to KVM guests.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adba49afb5fe..afc1316d78ad 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -676,8 +676,8 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_7_1_EAX,
 		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) |
-		F(FZRM) | F(FSRS) | F(FSRC) |
-		F(AMX_FP16) | F(AVX_IFMA) | F(LAM)
+		F(FZRM) | F(FSRS) | F(FSRC) | F(FRED) | F(LKGS) |
+		F(WRMSRNS) | F(AMX_FP16) | F(AVX_IFMA) | F(LAM)
 	);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_7_1_EDX,
-- 
2.43.0


