Return-Path: <linux-kselftest+bounces-19444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363C998A25
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D7728987B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7FE1FAC38;
	Thu, 10 Oct 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7gZj/lz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D61FAC33;
	Thu, 10 Oct 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570756; cv=none; b=Uih2jc/dRu3PaBrrhCP9o6Yl7tAX1jQdpqvqvCi+fCY7ewJ4TsAEXUAdxHMjiYZ9npabmfFlbUDuhvV+UQHdNC8i0s2G+lhEjo2OTly5/PdijsWbV5mvTvLB0DAu0vZzN/NGlwst3s5cASoZQWDULY34+Q40mZGzj8RpAwmvcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570756; c=relaxed/simple;
	bh=NF3SWiWc6dI2FV3WgDiuj4mVl+ymLqKeoOTcA5Qp884=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNnQnRtAt0T2eZFi14w8KM/7Z8UO5FtHUkIK3Y3lBZzQCW0A0EU0OjvgX8cdfHA7ALOD+qgCy90pjhI/aQU2+uL/KmpmTV5XXaNuXW1OQrll1/H0yf41iE+AgJ2uCi8GHa9DWExU9VmuGbZhOjCvCXlJQtKvjLdSTys3MyQWrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7gZj/lz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570755; x=1760106755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NF3SWiWc6dI2FV3WgDiuj4mVl+ymLqKeoOTcA5Qp884=;
  b=J7gZj/lzfcnyixt6bRcqKG6Z/FMM5H5iseba+dhp+ScnDM384+DeOM17
   0C7mLnsFsn6MR8L+iP+YFBgwPfyoGIEIQXERulg6XTkeR5nCvvLdxrIBh
   Vp9eA5i/Nw0r61YEFRd1P1w8/R9TcLzlXfGKY8pBNL1Kb5am85RQUr7FF
   6evNhTJWih7+A3+/wl/+1jgHlxGP/x1fteV821cUxd5vq/vsFbhLsUyse
   qBsMLqmKg/oc7N1YXw7D0EhZMLukON3cl9AOdNRtXMJHLW4VtWs1OMvD7
   J0iG6xF4p1ItMCHoHKxuqQo5GUPDSqBCPN7YGcaSgr/9OjBS4BLEUOR4r
   Q==;
X-CSE-ConnectionGUID: QKRDb6jNSAaK9QGcKr/TFA==
X-CSE-MsgGUID: SAmiNLLaQnulFwlLX3rCRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064086"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:34 -0700
X-CSE-ConnectionGUID: 6zbVZ9luSvOd1AZ21zpgmg==
X-CSE-MsgGUID: nB9pGqrHSM2z5rKEVbeBfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81189067"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:32:24 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V12 02/14] KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
Date: Thu, 10 Oct 2024 17:31:39 +0300
Message-ID: <20241010143152.19071-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010143152.19071-1-adrian.hunter@intel.com>
References: <20241010143152.19071-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Fix KVM IA32_RTIT_CTL MSR validation logic so that if RTIT_CTL_TRACEEN
bit is cleared, then other bits are allowed to change also. For example,
writing 0 to IA32_RTIT_CTL in order to stop tracing, is valid.

Fixes: bf8c55d8dc09 ("KVM: x86: Implement Intel PT MSRs read/write emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1a4438358c5e..eaf4965ac6df 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1635,7 +1635,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	 * result in a #GP unless the same write also clears TraceEn.
 	 */
 	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
-		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
+	    (data & RTIT_CTL_TRACEEN) &&
+	    data != vmx->pt_desc.guest.ctl)
 		return 1;
 
 	/*
-- 
2.43.0


