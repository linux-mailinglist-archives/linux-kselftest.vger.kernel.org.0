Return-Path: <linux-kselftest+bounces-19625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79599C78C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C6E2867FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBD197A7F;
	Mon, 14 Oct 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRQ6Rt8k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB614F117;
	Mon, 14 Oct 2024 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903132; cv=none; b=hBeE4gf94suYh3BYQc90OX7aWV5Wgc4PDDiu1IyKNvR0NHicEwgEKULHbd73djFD9nRXlvetS7QTPop5swbEoha28XlkGCpsBNMxRnPHpJxiXBK9M6upZaPidYLcFVNfJdq0nCU3T17b524jgwxFKrynsV2ZywHTiKIJl5raSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903132; c=relaxed/simple;
	bh=NF3SWiWc6dI2FV3WgDiuj4mVl+ymLqKeoOTcA5Qp884=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUzrE7AK4jaxIvMN/0bRP5TufU0mzMj6bZ8krVatLwR2M1bUpfmhjRcyNgETy5p+cpZWZYCpK1uNA6V3PelZ7A8m1FKY78l9318esphaPeYhTmIF14mBCKYXeSoJ2LPkMCkboFVzGIeMm3VtwNHQZsKJYfyOSf2sYBGkl1zojD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRQ6Rt8k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728903131; x=1760439131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NF3SWiWc6dI2FV3WgDiuj4mVl+ymLqKeoOTcA5Qp884=;
  b=SRQ6Rt8kApOjnVHCg4cnxEIZHKBAeAqDSGRBL2kV6uHsEh4cS+IsdBN5
   pxcNqd0sFaGawXmYNiPbMo9EiLPcmrbSF2u6G3ZGZtizusQGk6Id1Ucwz
   R7aT1+w/RpXbyypqBLqanaC9D0Kf/ud8GMDZjnmFH1tPBUVsgz1MSt3Dr
   KiEYh7bkbfQqV48VSaBq5UgI6NP4C+WGDy1994wzMPabcL84pEdmdgfoo
   MYuBEeByRNPe1tEeJQMorHpIKdyjP+4NlGW2Iy5+R7gdPyOKqZ1MX6R+t
   1tFUmsFEhYMlwDDn4tBBJeGAe/u1QFMnyNXuoWbbbwRwo8xTV7VeWpRXy
   A==;
X-CSE-ConnectionGUID: EYJIctwlQ+aZoWtvRPpfzw==
X-CSE-MsgGUID: tFYkoQFpQRWi5kkyBtJCoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39366042"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39366042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:52:09 -0700
X-CSE-ConnectionGUID: KUnehGpBTBmPV9AdOAViGA==
X-CSE-MsgGUID: SPh3VvcQST6bPQMQBOqyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77727380"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:51:59 -0700
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
	mizhang@google.com,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V13 02/14] KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
Date: Mon, 14 Oct 2024 13:51:12 +0300
Message-ID: <20241014105124.24473-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105124.24473-1-adrian.hunter@intel.com>
References: <20241014105124.24473-1-adrian.hunter@intel.com>
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


