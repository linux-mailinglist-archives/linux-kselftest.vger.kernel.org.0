Return-Path: <linux-kselftest+bounces-19453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6075E998A42
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DF31C20356
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211BF1CEACF;
	Thu, 10 Oct 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvt7ZFpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B061CCB4E;
	Thu, 10 Oct 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570840; cv=none; b=eLRbPQ6Vu+GYMEnQzYZ8UZyj1iIKpozIRD0pvbb6AokFLnU/7zA+lLnXHnHFjK4V9zWT4crwc8XtQnPazsZeC+hD5UGeBN7Zp/KQMlwpSGSecqm8QCdlelcJuBFecKKhlN8affSZfuV1C08n03jIzObDj4b4qoex+KVYlxtqPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570840; c=relaxed/simple;
	bh=e+48Ut8MyB4QjyHlcLA/pzs7EnBkLPei5N1nhqjrvYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEDzAsNZYJuDjEyo01lwkA91r88dpWQX/iphNozUOgBJjF1yUJ9dBeU1gpJrPbeNxQfWvUFN+T/ByI3To7UcQCyfq+jLbQ7is1NwPnZqzw8tqxHGR7KzT3srXxEq+ypbc9lc4VUUJh19GU+oSUmZNCRc5mwx5tcKvE6setDhZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvt7ZFpx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570839; x=1760106839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e+48Ut8MyB4QjyHlcLA/pzs7EnBkLPei5N1nhqjrvYM=;
  b=Dvt7ZFpxYpcqJWiDoXHiWTDLY9BNkIYk5OEyWD2Vqoif0Tiw/x6HCSkE
   0W49lvlqlHpHB8eTX2ceSch2iApA72AMclL+EaHtVdr/Rc+DX9sMzTS2n
   3glHGlSTeKYWwfhp6SSLhF6RNg2khZ33NF4RGwVvLxL+9p3gkORW/kczM
   PdZlvHCnRZ4Xjxn8dioMWcz89lN9sWBPU2UFKk/9fCVfTeLPa2cYI5D+B
   /iOupzpN0/84B8783YUpc7wAwKTI/iLfFoCUeALFXM2UleFoSaEStKj3a
   8g/hMdz0Uz9KoiGJxUafK112gbd7/XIxgB7VuUTAgEPFgJ6DC+h0lyVua
   g==;
X-CSE-ConnectionGUID: FBUkBBhSQVaL6ODgDRP/Hw==
X-CSE-MsgGUID: /j65oS9iTbaqa397U3DA2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064401"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:58 -0700
X-CSE-ConnectionGUID: zY2H3ocOQsK0SAlNfFqrIQ==
X-CSE-MsgGUID: W5PdynkwTVKSFLk7KFi4lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81189496"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:48 -0700
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
Subject: [PATCH V12 11/14] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Thu, 10 Oct 2024 17:31:48 +0300
Message-ID: <20241010143152.19071-12-adrian.hunter@intel.com>
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

Display "feature is not supported" error message if aux_start_paused,
aux_pause or aux_resume result in a perf_event_open() error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 10 +++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d34ceab9e454..927aa61e7b14 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2147,7 +2147,13 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.aux_pause_resume &&
+	    (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
+	     evsel->core.attr.aux_start_paused)) {
+		perf_missing_features.aux_pause_resume = true;
+		pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
@@ -3397,6 +3403,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_pause_resume)
+			return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15e745a9a798..778fcdb8261f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -221,6 +221,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_pause_resume;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.43.0


