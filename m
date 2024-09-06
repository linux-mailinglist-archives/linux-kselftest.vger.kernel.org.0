Return-Path: <linux-kselftest+bounces-17393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DD96F4EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9320F1F25691
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F51CDA1B;
	Fri,  6 Sep 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daFy0NXb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314371CB330;
	Fri,  6 Sep 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627659; cv=none; b=C7Q0TAFziUekEesJaGHpbUqWmX+LY15rV34nArmq3Ks3rI9FVxNbiGiutJLkDm3Z60y89Kb6NtU+98gdmtLxYfPuXP5LHDSL+FHCfuf3mokgi9j9kABTRfnpYk9Uitqde9rU2e+3MmH9bm0gQ33KdY9cnl02G8CSymTRN9n31cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627659; c=relaxed/simple;
	bh=0aPtJsZGoyi0V8bp0v8TcVsiOyuNP6y2QAnWrUzyu4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0viWB9CYIV6ze29Ij2eIwBqmcQK5e04skk30RRqNHcd4vaWECW+FsiTK4MHe3hqZ4lRk/2KyPY6WVZvo2CTa+kUQD+vH8XRzetXa/4E0/SyNdtGsGAA8JUIxyqOSzyBguesZP9hgOQXwRZBRy7zkdSxn4QP6dWalXP0gJLHjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daFy0NXb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725627658; x=1757163658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aPtJsZGoyi0V8bp0v8TcVsiOyuNP6y2QAnWrUzyu4M=;
  b=daFy0NXbunzQyhBMFKtiMhi7CUPtoNnXLuUdJAYvn2sC/REnPNxjv9+c
   /4LWHHs977uhoZp24b/NbJlB6DvXHIBo6EbBqnbNZLoDXT0IojVAi0DoU
   diAXdG0rJdaG6JkTQdEUF6GM5w3pjsiavlQ4XSefqod4wsFQMmJs109lK
   D1NqL9ntCR0kvBV4v9PH9bZjNenBJVubKkJrsw6bwy7chJE/O18IzAEC9
   L7N/yOsN0RlYtpQdyjcvNcjuj+Y34anYTnA5GazpCK5zXDHHkgCn/JT89
   n+wXHysBR5BUXXtVe+LkefLM6X7JSEJ1Xtzz5eI80d3pwb3Kmmsaeq3vj
   Q==;
X-CSE-ConnectionGUID: NaX1uVYhTjCsorY1lKqEbw==
X-CSE-MsgGUID: lZnn0ueCTNK438TPqbBrow==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="34959919"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34959919"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:53 -0700
X-CSE-ConnectionGUID: 01hPq7+9Rka+lhDAdoukOQ==
X-CSE-MsgGUID: /1YR9z+1RDurnSV5vShe8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="65929522"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 06:00:46 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>,
	kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
Date: Fri,  6 Sep 2024 16:00:24 +0300
Message-ID: <20240906130026.10705-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906130026.10705-1-adrian.hunter@intel.com>
References: <20240906130026.10705-1-adrian.hunter@intel.com>
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
index f18c2d8c7476..3f1e3be552c0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1639,7 +1639,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
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


