Return-Path: <linux-kselftest+bounces-19637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBE99C7BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B132B27DB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C51A071C;
	Mon, 14 Oct 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaFqD4R6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FE19DF45;
	Mon, 14 Oct 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903258; cv=none; b=ExlDOTPnKA87o9+kUR9TTGS6hlvMXVBDfcaQdVL5C7dRuhddbnw6484Esu6Ex5KnX0nyVzAwy2W8STkSHCXbtgwIlBQme6Y16d9FWoCm/PLy7ffqWO2JvsWOEPC0WpFvMq4oPdfJcyJvmIkRURUWbKFaH49NTDztCPXUxI5lwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903258; c=relaxed/simple;
	bh=F6eTrN/gp7G7YKPqRXWeb3wd7Rb9UIpk0XhBK01kcM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfCvm2egEWhDtaL8Mkr3jMF5205AewNx2R1XoEXd1kHGZ7/BsjTqIxvRMDB8555EsqM9fzCEMM5/9M9jmNyPC5zAtb74j8iFvs8DCDlLBZA2vHgazYLiiXGiQJE7JfxJx4rayf60fAbUvLFCkEYPvXOUuOO4TzRlT4sVmD/6Nyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaFqD4R6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728903257; x=1760439257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6eTrN/gp7G7YKPqRXWeb3wd7Rb9UIpk0XhBK01kcM0=;
  b=aaFqD4R6gKNZ4+KIFYpMrO6oHz2PfO2rKpV51ZhptissL6Z4hpldK06L
   plbS5nTfANHize5MpLQYltjH1FQsBRmGptBlpbvWKnG/rUorWka5brd+e
   wJ9gx9V4eiv4Wfg647ZzQ3FCNfEeEbWCk9d2gOKdoMxHxVNtkw9cEFAXo
   ddDnxo7NAsCjxu9GPDpcZxPeSkrGdDW1q/jKYipKYYLOLDHK+rIfGxOna
   BXiR/prDK9imk/NEIoBbNbVenWg79XT98sJwoxGiWrVx1qWeNN5d9UGim
   kxbm+t58LzEcTODG90T8Ebb9sqvJwCGXXFLNU4nYN52hv13DkNxZ83soJ
   A==;
X-CSE-ConnectionGUID: 3GgqfxyUTxa4y2cLUMlIOQ==
X-CSE-MsgGUID: mHpsH5e5RDSSbnEaL4XqJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39366490"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39366490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:54:16 -0700
X-CSE-ConnectionGUID: aJPfyMk1TIOzN4x4e5imFg==
X-CSE-MsgGUID: IEqUleN2QkuvKAx1v6x0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77727556"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.115.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:54:05 -0700
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
Subject: [PATCH V13 14/14] perf intel-pt: Add a test for pause / resume
Date: Mon, 14 Oct 2024 13:51:24 +0300
Message-ID: <20241014105124.24473-15-adrian.hunter@intel.com>
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

Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
check pause / resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99a..e359db0d0ff2 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -644,6 +644,33 @@ test_pipe()
 	return 0
 }
 
+test_pause_resume()
+{
+	echo "--- Test with pause / resume ---"
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
+		echo "SKIP: pause / resume is not supported"
+		return 2
+	fi
+	if ! perf_record_no_bpf -o "${perfdatafile}" \
+			-e intel_pt/aux-action=start-paused/u \
+			-e instructions/period=50000,aux-action=resume,name=Resume/u \
+			-e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
+			awk 'BEGIN {paused=1;branches=0}
+			     /Resume/ {paused=0}
+			     /branches/ {if (paused) exit 1;branches=1}
+			     /Pause/ {paused=1}
+			     END {if (!branches) exit 1}' ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -672,6 +699,7 @@ test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 test_pipe				|| ret=$? ; count_result $ret ; ret=0
+test_pause_resume			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.43.0


