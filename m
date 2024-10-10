Return-Path: <linux-kselftest+bounces-19454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E969998AEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9866CB2CF99
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA1201110;
	Thu, 10 Oct 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGQQe313"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E231CCEC5;
	Thu, 10 Oct 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570850; cv=none; b=Xh5LGNwOrH+0NLueJx6t4+IepkrD+pO0yN5ruh2QiUsiRGxq0DApi48HnV56QFhZL9dsYsy3MDhaPFrNkZqV9aMEWAUTLtMsBdmzZEsqWHIBjaLxse/f4M8sh0sfVgumqHkDip3yxDVXSY4y8PiFyzQjZSd+7IrxGFtKr5uauaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570850; c=relaxed/simple;
	bh=a/UvzQtgEWPo+ao9zDxvcnVa9mPHvKs06Lk+aQALKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArV5Pf20GvlHt3BCxvAV9CJRsdEPLaWUYlgMClo5YJ25FhdDpy3hXs8D1DDQMkSc6Myk+i51EQesVfuCh9QkVXVWidAQVgADPPRCbnI916vRPokyCgUGKaCfhtHbcmQJPUkGab1tpyubwtWOc+6LoCYZQCh4sJ5jihmjN29wBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGQQe313; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570848; x=1760106848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/UvzQtgEWPo+ao9zDxvcnVa9mPHvKs06Lk+aQALKv0=;
  b=FGQQe313XnoEhoqCJn+MUGuhWUp40zJemO2VE+1PmvgiFawe5w6U1i0B
   pyEuLoe+H0M7WGZ6uoLo5ULXWNL/Qogr6RDawSbzx16o1WDlIcSfFy98T
   FlFmJNFE9wYNOPaL9WUWlnawzGI22077A4ZlU7l4utGDxV7XJMbVMsnj7
   GVui0bg69OaS57oIcWOzba/LifoKD7tQ960/tbFUxBiA2mBXdoqiGIH0Q
   tGXI9FYGYJEuBzxWzJ7y8ZCsH04j1REhSjmDh3a8PC0YJQ+pmFUngco63
   KUVlDxePzx2YrB2J/2fWXsGz+s7D663WAQoVzmXtalRGHM+LrOLOllkvP
   Q==;
X-CSE-ConnectionGUID: V9/k+gGSRNSkDdih7pD3Lw==
X-CSE-MsgGUID: 7KghW0e/Sb+RnNXI6CV1fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28064435"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28064435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:34:07 -0700
X-CSE-ConnectionGUID: SkUwUOwTSVeuN4itHHVEQg==
X-CSE-MsgGUID: 5ljRSWJdRb6pxUwE4DxhYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81189536"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.16.81])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:33:58 -0700
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
Subject: [PATCH V12 12/14] perf intel-pt: Improve man page format
Date: Thu, 10 Oct 2024 17:31:49 +0300
Message-ID: <20241010143152.19071-13-adrian.hunter@intel.com>
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

Improve format of config terms and section references.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 486 +++++++++++----------
 1 file changed, 267 insertions(+), 219 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 59ab1ff9d75f..ad39bf20f862 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -151,7 +151,7 @@ displayed as follows:
 There are two ways that instructions-per-cycle (IPC) can be calculated depending
 on the recording.
 
-If the 'cyc' config term (see config terms section below) was used, then IPC
+If the 'cyc' config term (see <<_config_terms,config terms>> section below) was used, then IPC
 and cycle events are calculated using the cycle count from CYC packets, otherwise
 MTC packets are used - refer to the 'mtc' config term.  When MTC is used, however,
 the values are less accurate because the timing is less accurate.
@@ -239,7 +239,7 @@ which is the same as
 
 	-e intel_pt/tsc=1,noretcomp=0/
 
-Note there are now new config terms - see section 'config terms' further below.
+Note there are other config terms - see section <<_config_terms,config terms>> further below.
 
 The config terms are listed in /sys/devices/intel_pt/format.  They are bit
 fields within the config member of the struct perf_event_attr which is
@@ -311,217 +311,264 @@ perf_event_attr is displayed if the -vv option is used e.g.
 config terms
 ~~~~~~~~~~~~
 
-The June 2015 version of Intel 64 and IA-32 Architectures Software Developer
-Manuals, Chapter 36 Intel Processor Trace, defined new Intel PT features.
-Some of the features are reflect in new config terms.  All the config terms are
-described below.
-
-tsc		Always supported.  Produces TSC timestamp packets to provide
-		timing information.  In some cases it is possible to decode
-		without timing information, for example a per-thread context
-		that does not overlap executable memory maps.
-
-		The default config selects tsc (i.e. tsc=1).
-
-noretcomp	Always supported.  Disables "return compression" so a TIP packet
-		is produced when a function returns.  Causes more packets to be
-		produced but might make decoding more reliable.
-
-		The default config does not select noretcomp (i.e. noretcomp=0).
-
-psb_period	Allows the frequency of PSB packets to be specified.
-
-		The PSB packet is a synchronization packet that provides a
-		starting point for decoding or recovery from errors.
-
-		Support for psb_period is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/psb_cyc
-
-		which contains "1" if the feature is supported and "0"
-		otherwise.
-
-		Valid values are given by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/psb_periods
-
-		which contains a hexadecimal value, the bits of which represent
-		valid values e.g. bit 2 set means value 2 is valid.
-
-		The psb_period value is converted to the approximate number of
-		trace bytes between PSB packets as:
-
-			2 ^ (value + 11)
-
-		e.g. value 3 means 16KiB bytes between PSBs
-
-		If an invalid value is entered, the error message
-		will give a list of valid values e.g.
-
-			$ perf record -e intel_pt/psb_period=15/u uname
-			Invalid psb_period for intel_pt. Valid values are: 0-5
-
-		If MTC packets are selected, the default config selects a value
-		of 3 (i.e. psb_period=3) or the nearest lower value that is
-		supported (0 is always supported).  Otherwise the default is 0.
-
-		If decoding is expected to be reliable and the buffer is large
-		then a large PSB period can be used.
-
-		Because a TSC packet is produced with PSB, the PSB period can
-		also affect the granularity to timing information in the absence
-		of MTC or CYC.
-
-mtc		Produces MTC timing packets.
-
-		MTC packets provide finer grain timestamp information than TSC
-		packets.  MTC packets record time using the hardware crystal
-		clock (CTC) which is related to TSC packets using a TMA packet.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/mtc
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
-
-		The frequency of MTC packets can also be specified - see
-		mtc_period below.
-
-mtc_period	Specifies how frequently MTC packets are produced - see mtc
-		above for how to determine if MTC packets are supported.
-
-		Valid values are given by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/mtc_periods
-
-		which contains a hexadecimal value, the bits of which represent
-		valid values e.g. bit 2 set means value 2 is valid.
-
-		The mtc_period value is converted to the MTC frequency as:
-
-			CTC-frequency / (2 ^ value)
-
-		e.g. value 3 means one eighth of CTC-frequency
-
-		Where CTC is the hardware crystal clock, the frequency of which
-		can be related to TSC via values provided in cpuid leaf 0x15.
-
-		If an invalid value is entered, the error message
-		will give a list of valid values e.g.
-
-			$ perf record -e intel_pt/mtc_period=15/u uname
-			Invalid mtc_period for intel_pt. Valid values are: 0,3,6,9
-
-		The default value is 3 or the nearest lower value
-		that is supported (0 is always supported).
-
-cyc		Produces CYC timing packets.
-
-		CYC packets provide even finer grain timestamp information than
-		MTC and TSC packets.  A CYC packet contains the number of CPU
-		cycles since the last CYC packet. Unlike MTC and TSC packets,
-		CYC packets are only sent when another packet is also sent.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/psb_cyc
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
-
-		The number of CYC packets produced can be reduced by specifying
-		a threshold - see cyc_thresh below.
-
-cyc_thresh	Specifies how frequently CYC packets are produced - see cyc
-		above for how to determine if CYC packets are supported.
-
-		Valid cyc_thresh values are given by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/cycle_thresholds
-
-		which contains a hexadecimal value, the bits of which represent
-		valid values e.g. bit 2 set means value 2 is valid.
-
-		The cyc_thresh value represents the minimum number of CPU cycles
-		that must have passed before a CYC packet can be sent.  The
-		number of CPU cycles is:
-
-			2 ^ (value - 1)
-
-		e.g. value 4 means 8 CPU cycles must pass before a CYC packet
-		can be sent.  Note a CYC packet is still only sent when another
-		packet is sent, not at, e.g. every 8 CPU cycles.
-
-		If an invalid value is entered, the error message
-		will give a list of valid values e.g.
-
-			$ perf record -e intel_pt/cyc,cyc_thresh=15/u uname
-			Invalid cyc_thresh for intel_pt. Valid values are: 0-12
-
-		CYC packets are not requested by default.
-
-pt		Specifies pass-through which enables the 'branch' config term.
-
-		The default config selects 'pt' if it is available, so a user will
-		never need to specify this term.
-
-branch		Enable branch tracing.  Branch tracing is enabled by default so to
-		disable branch tracing use 'branch=0'.
-
-		The default config selects 'branch' if it is available.
-
-ptw		Enable PTWRITE packets which are produced when a ptwrite instruction
-		is executed.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/ptwrite
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
-
-		As an alternative, refer to "Emulated PTWRITE" further below.
-
-fup_on_ptw	Enable a FUP packet to follow the PTWRITE packet.  The FUP packet
-		provides the address of the ptwrite instruction.  In the absence of
-		fup_on_ptw, the decoder will use the address of the previous branch
-		if branch tracing is enabled, otherwise the address will be zero.
-		Note that fup_on_ptw will work even when branch tracing is disabled.
-
-pwr_evt		Enable power events.  The power events provide information about
-		changes to the CPU C-state.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/power_event_trace
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
-
-event		Enable Event Trace.  The events provide information about asynchronous
-		events.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/event_trace
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
-
-notnt		Disable TNT packets.  Without TNT packets, it is not possible to walk
-		executable code to reconstruct control flow, however FUP, TIP, TIP.PGE
-		and TIP.PGD packets still indicate asynchronous control flow, and (if
-		return compression is disabled - see noretcomp) return statements.
-		The advantage of eliminating TNT packets is reducing the size of the
-		trace and corresponding tracing overhead.
-
-		Support for this feature is indicated by:
-
-			/sys/bus/event_source/devices/intel_pt/caps/tnt_disable
-
-		which contains "1" if the feature is supported and
-		"0" otherwise.
+Config terms are parameters specified with the -e intel_pt// event option,
+for example:
+
+	-e intel_pt/cyc/
+
+which selects cycle accurate mode. Each config term can have a value which
+defaults to 1, so the above is the same as:
+
+	-e intel_pt/cyc=1/
+
+Some terms are set by default, so must be set to 0 to turn them off. For
+example, to turn off branch tracing:
+
+	-e intel_pt/branch=0/
+
+Multiple config terms are separated by commas, for example:
+
+	-e intel_pt/cyc,mtc_period=9/
+
+There are also common config terms, see linkperf:perf-record[1] documentation.
+
+Intel PT config terms are described below.
+
+*tsc*::
+Always supported.  Produces TSC timestamp packets to provide
+timing information.  In some cases it is possible to decode
+without timing information, for example a per-thread context
+that does not overlap executable memory maps.
++
+The default config selects tsc (i.e. tsc=1).
+
+*noretcomp*::
+Always supported.  Disables "return compression" so a TIP packet
+is produced when a function returns.  Causes more packets to be
+produced but might make decoding more reliable.
++
+The default config does not select noretcomp (i.e. noretcomp=0).
+
+*psb_period*::
+Allows the frequency of PSB packets to be specified.
++
+The PSB packet is a synchronization packet that provides a
+starting point for decoding or recovery from errors.
++
+Support for psb_period is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/psb_cyc
++
+which contains "1" if the feature is supported and "0"
+otherwise.
++
+Valid values are given by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/psb_periods
++
+which contains a hexadecimal value, the bits of which represent
+valid values e.g. bit 2 set means value 2 is valid.
++
+The psb_period value is converted to the approximate number of
+trace bytes between PSB packets as:
++
+	2 ^ (value + 11)
++
+e.g. value 3 means 16KiB bytes between PSBs
++
+If an invalid value is entered, the error message
+will give a list of valid values e.g.
++
+	$ perf record -e intel_pt/psb_period=15/u uname
+	Invalid psb_period for intel_pt. Valid values are: 0-5
++
+If MTC packets are selected, the default config selects a value
+of 3 (i.e. psb_period=3) or the nearest lower value that is
+supported (0 is always supported).  Otherwise the default is 0.
++
+If decoding is expected to be reliable and the buffer is large
+then a large PSB period can be used.
++
+Because a TSC packet is produced with PSB, the PSB period can
+also affect the granularity to timing information in the absence
+of MTC or CYC.
+
+*mtc*::
+Produces MTC timing packets.
++
+MTC packets provide finer grain timestamp information than TSC
+packets.  MTC packets record time using the hardware crystal
+clock (CTC) which is related to TSC packets using a TMA packet.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/mtc
++
+which contains "1" if the feature is supported and
+"0" otherwise.
++
+The frequency of MTC packets can also be specified - see
+mtc_period below.
+
+*mtc_period*::
+Specifies how frequently MTC packets are produced - see mtc
+above for how to determine if MTC packets are supported.
++
+Valid values are given by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/mtc_periods
++
+which contains a hexadecimal value, the bits of which represent
+valid values e.g. bit 2 set means value 2 is valid.
++
+The mtc_period value is converted to the MTC frequency as:
+
+	CTC-frequency / (2 ^ value)
++
+e.g. value 3 means one eighth of CTC-frequency
++
+Where CTC is the hardware crystal clock, the frequency of which
+can be related to TSC via values provided in cpuid leaf 0x15.
++
+If an invalid value is entered, the error message
+will give a list of valid values e.g.
++
+	$ perf record -e intel_pt/mtc_period=15/u uname
+	Invalid mtc_period for intel_pt. Valid values are: 0,3,6,9
++
+The default value is 3 or the nearest lower value
+that is supported (0 is always supported).
+
+*cyc*::
+Produces CYC timing packets.
++
+CYC packets provide even finer grain timestamp information than
+MTC and TSC packets.  A CYC packet contains the number of CPU
+cycles since the last CYC packet. Unlike MTC and TSC packets,
+CYC packets are only sent when another packet is also sent.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/psb_cyc
++
+which contains "1" if the feature is supported and
+"0" otherwise.
++
+The number of CYC packets produced can be reduced by specifying
+a threshold - see cyc_thresh below.
+
+*cyc_thresh*::
+Specifies how frequently CYC packets are produced - see cyc
+above for how to determine if CYC packets are supported.
++
+Valid cyc_thresh values are given by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/cycle_thresholds
++
+which contains a hexadecimal value, the bits of which represent
+valid values e.g. bit 2 set means value 2 is valid.
++
+The cyc_thresh value represents the minimum number of CPU cycles
+that must have passed before a CYC packet can be sent.  The
+number of CPU cycles is:
++
+	2 ^ (value - 1)
++
+e.g. value 4 means 8 CPU cycles must pass before a CYC packet
+can be sent.  Note a CYC packet is still only sent when another
+packet is sent, not at, e.g. every 8 CPU cycles.
++
+If an invalid value is entered, the error message
+will give a list of valid values e.g.
++
+	$ perf record -e intel_pt/cyc,cyc_thresh=15/u uname
+	Invalid cyc_thresh for intel_pt. Valid values are: 0-12
++
+CYC packets are not requested by default.
+
+*pt*::
+Specifies pass-through which enables the 'branch' config term.
++
+The default config selects 'pt' if it is available, so a user will
+never need to specify this term.
+
+*branch*::
+Enable branch tracing.  Branch tracing is enabled by default so to
+disable branch tracing use 'branch=0'.
++
+The default config selects 'branch' if it is available.
+
+*ptw*::
+Enable PTWRITE packets which are produced when a ptwrite instruction
+is executed.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/ptwrite
++
+which contains "1" if the feature is supported and
+"0" otherwise.
++
+As an alternative, refer to "Emulated PTWRITE" further below.
+
+*fup_on_ptw*::
+Enable a FUP packet to follow the PTWRITE packet.  The FUP packet
+provides the address of the ptwrite instruction.  In the absence of
+fup_on_ptw, the decoder will use the address of the previous branch
+if branch tracing is enabled, otherwise the address will be zero.
+Note that fup_on_ptw will work even when branch tracing is disabled.
+
+*pwr_evt*::
+Enable power events.  The power events provide information about
+changes to the CPU C-state.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/power_event_trace
++
+which contains "1" if the feature is supported and
+"0" otherwise.
+
+*event*::
+Enable Event Trace.  The events provide information about asynchronous
+events.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/event_trace
++
+which contains "1" if the feature is supported and
+"0" otherwise.
+
+*notnt*::
+Disable TNT packets.  Without TNT packets, it is not possible to walk
+executable code to reconstruct control flow, however FUP, TIP, TIP.PGE
+and TIP.PGD packets still indicate asynchronous control flow, and (if
+return compression is disabled - see noretcomp) return statements.
+The advantage of eliminating TNT packets is reducing the size of the
+trace and corresponding tracing overhead.
++
+Support for this feature is indicated by:
++
+	/sys/bus/event_source/devices/intel_pt/caps/tnt_disable
++
+which contains "1" if the feature is supported and
+"0" otherwise.
+
+
+config terms on other events
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some Intel PT features work with other events, features such as AUX area sampling
+and PEBS-via-PT.  In those cases, the other events can have config terms below:
+
+*aux-sample-size*::
+		Used to set the AUX area sample size, refer to the section
+		<<_aux_area_sampling_option,AUX area sampling option>>
+
+*aux-output*::
+		Used to select PEBS-via-PT, refer to the
+		section <<_pebs_via_intel_pt,PEBS via Intel PT>>
 
 
 AUX area sampling option
@@ -596,7 +643,8 @@ The default snapshot size is the auxtrace mmap size.  If neither auxtrace mmap s
 nor snapshot size is specified, then the default is 4MiB for privileged users
 (or if /proc/sys/kernel/perf_event_paranoid < 0), 128KiB for unprivileged users.
 If an unprivileged user does not specify mmap pages, the mmap pages will be
-reduced as described in the 'new auxtrace mmap size option' section below.
+reduced as described in the <<_new_auxtrace_mmap_size_option,new auxtrace mmap size option>>
+section below.
 
 The snapshot size is displayed if the option -vv is used e.g.
 
@@ -952,11 +1000,11 @@ transaction start, commit or abort.
 
 Note that "instructions", "cycles", "branches" and "transactions" events
 depend on code flow packets which can be disabled by using the config term
-"branch=0".  Refer to the config terms section above.
+"branch=0".  Refer to the <<_config_terms,config terms>> section above.
 
 "ptwrite" events record the payload of the ptwrite instruction and whether
 "fup_on_ptw" was used.  "ptwrite" events depend on PTWRITE packets which are
-recorded only if the "ptw" config term was used.  Refer to the config terms
+recorded only if the "ptw" config term was used.  Refer to the <<_config_terms,config terms>>
 section above.  perf script "synth" field displays "ptwrite" information like
 this: "ip: 0 payload: 0x123456789abcdef0"  where "ip" is 1 if "fup_on_ptw" was
 used.
@@ -964,7 +1012,7 @@ used.
 "Power" events correspond to power event packets and CBR (core-to-bus ratio)
 packets.  While CBR packets are always recorded when tracing is enabled, power
 event packets are recorded only if the "pwr_evt" config term was used.  Refer to
-the config terms section above.  The power events record information about
+the <<_config_terms,config terms>> section above.  The power events record information about
 C-state changes, whereas CBR is indicative of CPU frequency.  perf script
 "event,synth" fields display information like this:
 
@@ -1120,7 +1168,7 @@ What *will* be decoded with the (single) q option:
 	- asynchronous branches such as interrupts
 	- indirect branches
 	- function return target address *if* the noretcomp config term (refer
-	config terms section) was used
+	<<_config_terms,config terms>> section) was used
 	- start of (control-flow) tracing
 	- end of (control-flow) tracing, if it is not out of context
 	- power events, ptwrite, transaction start and abort
@@ -1133,7 +1181,7 @@ Repeating the q option (double-q i.e. qq) results in even faster decoding and ev
 less detail.  The decoder decodes only extended PSB (PSB+) packets, getting the
 instruction pointer if there is a FUP packet within PSB+ (i.e. between PSB and
 PSBEND).  Note PSB packets occur regularly in the trace based on the psb_period
-config term (refer config terms section).  There will be a FUP packet if the
+config term (refer <<_config_terms,config terms>> section).  There will be a FUP packet if the
 PSB+ occurs while control flow is being traced.
 
 What will *not* be decoded with the qq option:
-- 
2.43.0


