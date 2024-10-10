Return-Path: <linux-kselftest+bounces-19451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7C7998A3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADABC1C22462
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB61FF7A7;
	Thu, 10 Oct 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RO4NKK9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35B1CC8A8;
	Thu, 10 Oct 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570821; cv=none; b=f7loWr/DcfV8cRCNgtlR6P2XEGX6ydR4uwDPy011Zrcnu8lLgDulMyC70w//O9LbxPbFITgGIss+cGRJrqbs7R7j7TSYCRzf7Fc6V37szazNARV8IagXnko026id/Bk/yfLlRE9CmDc+OLpa2yY/Ea1FhUwDtEaGisTQCSJaf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570821; c=relaxed/simple;
	bh=8Dz9ZBQ8KVb+g2025vnYrziobUu1HOW4dJzL4s7qHcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buDklWqWsg9MNwJ2Z+pjrfx+MN+4VF171zb2sr1O8Qi5ar8JHG+rjDRY3VpIZYgXGHuahZTWcfzTzil5z/vYKHzT1i1Mv8xJen8J7Gg/Cbrc5mn0pySlxUV+7N+lZ7ME8QqfZq7S0BZoLSl8oPBxFp2qPUhVyJtS5p5RClVjhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RO4NKK9I; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570819; x=1760106819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Dz9ZBQ8KVb+g2025vnYrziobUu1HOW4dJzL4s7qHcg=;
  b=RO4NKK9IuJNGt9hLdu2WXSFY+UnSGhKr0ABREQiqLZdpSMdWVITV2RMM
   1Wb4Sq3V5nITI0jQZ/w5FgszTvWFVGRHVMQ3QLSDiUwpY1cZKWirZ5D+i
   JI36GxW+bU5GsyNJE9zQx9qa7+VR2DtLVRVyC8bYJE6//P8lXTrI+HANB
   POQVd/qUF6ETMjEARYrj6Q0CkWHle1AeGZM4SzJVu+jOt8IAo5Hr1zur3
   zBAjbgJMdpE6L2xv3GlEe9Nr6qP053QEEw1f4fQ90dPWhL2mfUS4UUXdh
   zyioVDEjx1bZRpRiwU39kC2E2qd2APiMnIu6lNWODuzhA0STh0FzqhhZN
   A==;
X-CSE-ConnectionGUID: fcQKJmLHSj6NTI5eHPnO0w==
X-CSE-MsgGUID: S/rhvML2SV6LP7jpIFho5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064306"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:39 -0700
X-CSE-ConnectionGUID: pYWMIG5SQQyhMRG/K83n4g==
X-CSE-MsgGUID: k7hh+e3nSmyg2t2rVv74+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81189425"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:29 -0700
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
Subject: [PATCH V12 09/14] perf tools: Add aux-action config term
Date: Thu, 10 Oct 2024 17:31:46 +0300
Message-ID: <20241010143152.19071-10-adrian.hunter@intel.com>
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

Add a new common config term "aux-action" to use for configuring AUX area
trace pause / resume. The value is a string that will be parsed in a
subsequent patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V7:

	Add aux-action to perf_pmu__for_each_format


 tools/perf/util/evsel.c        |  2 ++
 tools/perf/util/evsel_config.h |  1 +
 tools/perf/util/parse-events.c | 10 ++++++++++
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.l |  1 +
 tools/perf/util/pmu.c          |  1 +
 6 files changed, 16 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..6aff26636152 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1017,6 +1017,8 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 		case EVSEL__CONFIG_TERM_AUX_OUTPUT:
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
+		case EVSEL__CONFIG_TERM_AUX_ACTION:
+			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
 			break;
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index aee6f808b512..af52a1516d0b 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -25,6 +25,7 @@ enum evsel_term_type {
 	EVSEL__CONFIG_TERM_BRANCH,
 	EVSEL__CONFIG_TERM_PERCORE,
 	EVSEL__CONFIG_TERM_AUX_OUTPUT,
+	EVSEL__CONFIG_TERM_AUX_ACTION,
 	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
 	EVSEL__CONFIG_TERM_CFG_CHG,
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9a8be1e46d67..31705b6a41b9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -821,6 +821,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 		[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 		[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+		[PARSE_EVENTS__TERM_TYPE_AUX_ACTION]		= "aux-action",
 		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
@@ -870,6 +871,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -989,6 +991,9 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+		CHECK_TYPE_VAL(STR);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > UINT_MAX) {
@@ -1106,6 +1111,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -1241,6 +1247,9 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
 					    term->val.num ? 1 : 0, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
+			ADD_CONFIG_TERM_STR(AUX_ACTION, term->val.str, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
@@ -1303,6 +1312,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		case PARSE_EVENTS__TERM_TYPE_AUX_ACTION:
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..ac3f5acbf0ab 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -74,6 +74,7 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
+	PARSE_EVENTS__TERM_TYPE_AUX_ACTION,
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5a0bcd7f166a..6fa4b74fe0c3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -329,6 +329,7 @@ overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..dee39d53bab4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1737,6 +1737,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"no-overwrite",
 		"percore",
 		"aux-output",
+		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
 	};
 	struct perf_pmu_format *format;
-- 
2.43.0


