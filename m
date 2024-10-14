Return-Path: <linux-kselftest+bounces-19630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D283399C79F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626421F22D28
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72319E7D1;
	Mon, 14 Oct 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXzeLSXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE87170A15;
	Mon, 14 Oct 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903183; cv=none; b=EG91Od962wx0IgZ2sg/zxA1tw1rKU22S7YI/WGhWLJSrYrtpRKA62/cxG1oNRRBZQ5gtvjShbHFqQyU83YG1ykHYlUYfOkSn7pEQH9NUKTi65a79WITpmTVBFDtPGzgUpa4dZBu0TU/sXwVV3Aq8uMZX05272P6VH4OLCXZTFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903183; c=relaxed/simple;
	bh=QStAwdkye38HLwLvAfPzq8FmSRXF3FozST6s+/YdPUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhSfsaRcp6w+fDfcca8lZJ2/WAfaq7uU5oh6k+YbuS4Xpmru/PAPJ9NkuIw1EvzO63MG2UdMtfn0HQB180DZblKI22MBHxbAOiHIJQhGwAHVWSWPxK8YchSC8uTu0a/Q8RnlcN2RTC7PVbfu/E+tGLqdEmMU/yZH83Ak/rYmaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXzeLSXm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728903182; x=1760439182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QStAwdkye38HLwLvAfPzq8FmSRXF3FozST6s+/YdPUQ=;
  b=mXzeLSXmWU9CotgUYUHZHtQWRV/9bsaQqbT8Al+tdQnI1ReboWjeNwI4
   tUe7wOyk1GrYCxTPm3/gIaPWCyuZOOIr90pmaThluyGq08occmZqhE6F6
   cXdhaxCVxG76KmY6hc1MtY39x72s5DU0aZM5KquWRfolLEixUG9O+VppW
   ncODu85QHp3ZqwOImXLO4/IfYOHdLbrGsMFKDWsL44ZYSuFkFmQCzYiI4
   uQKWnugOlZPNG6TChwZ7BcDelGKlvaDtmQOMB2iGQi3z78EZE4t78gEr1
   NHPco6ujeVMYo3L+j7N8o70ATd78p7qXpVmONqOeJqPC5zGelmX7QM2Y7
   w==;
X-CSE-ConnectionGUID: TBZ0EzwETeCOsF8CUt9Qlw==
X-CSE-MsgGUID: 1tmrqEFtS6qjRFOeqlkzlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39366226"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39366226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:53:01 -0700
X-CSE-ConnectionGUID: KXz7A1ouSc6LG5Lp7VI4Nw==
X-CSE-MsgGUID: yFL5uGHATLa793YCFFJskw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77727459"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:52:51 -0700
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
Subject: [PATCH V13 07/14] perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
Date: Mon, 14 Oct 2024 13:51:17 +0300
Message-ID: <20241014105124.24473-8-adrian.hunter@intel.com>
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

Events with aux actions or aux sampling expect the PMI to coincide with the
event, which does not happen for large PEBS, so do not enable large PEBS in
that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V11:
	Remove definition of has_aux_action() because it has
	already been added as an inline function.


 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7ca40002a19b..bb284aff7bfd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3962,8 +3962,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
-			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event))) {
+			if (!(event->attr.sample_type & ~intel_pmu_large_pebs_flags(event)) &&
+			    !has_aux_action(event)) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 				event->attach_state |= PERF_ATTACH_SCHED_CB;
 			}
-- 
2.43.0


