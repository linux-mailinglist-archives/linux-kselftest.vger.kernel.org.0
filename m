Return-Path: <linux-kselftest+bounces-8247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260398A7D28
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3991B1C211FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743D6F072;
	Wed, 17 Apr 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmvVx0ZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A186E616;
	Wed, 17 Apr 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339279; cv=none; b=rPuwBURweuBx7Q3POjunels34a/E9kZIsMNUBxW8XuFnwRjYiZU/v+2ckT6/gWCHfsI8SYFRMyFrvCf1i/w+PJJdgeh5RHq11tkbVVA/vUyzOsz6tvSnLrXeJsswBShs3b7IaBR1djauAQaOowtMJalb4ChmaorVlpj3XR4DPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339279; c=relaxed/simple;
	bh=TSbOVFiFLZWCXwYugO2FU/IRct1/VyAQo4tDv3bJTd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxkDfFHHw2ktzRr6OeN8yx+467QYDmr/sGU7cYjb0gJDPeRI/jcqGRW0sG4UtWwL0sJpkJ1wKeN4Adt5DwJW0Sd70yEhAdq5NjIlcwlRmzAvm4s+3H0Xqk3xJsm6oTMg5me3K62f4+4mAiHSPExAMVfM+q3D12lsUL2f9PgvaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmvVx0ZN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713339279; x=1744875279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TSbOVFiFLZWCXwYugO2FU/IRct1/VyAQo4tDv3bJTd0=;
  b=TmvVx0ZN6bct+VSm6yE7Sd3yjxYHfS1TjV785ACS1ZkFqATLTEy97xZh
   G/CkyhHhG0bEdZndbPTCKOf7HVcBpiVSg0UJzgAws20isddB1wYH2Cvlr
   qAKaDX17C9cvVX4xVoMAQ4/1bONBAKq6C30DaTAjyFoVlVhRgLb9MS/h6
   GS5gXdkaeUC6mU3X1+nY5M5o1sqDWqROnbwHbF5BnzqpozY96ydm636sb
   A715PukSvWyztzxTleDccRKu9sSNTya7XFwCLKyGqpYYT3WMAg5vQdr7C
   w3fjRTpinW1tTFJxFnGRKg/3acHbViGvas2iGLKjwf/l+6J53ffH0oDYg
   A==;
X-CSE-ConnectionGUID: EsM6pM42SQmrwLIEDsddKQ==
X-CSE-MsgGUID: +dXVNzcdSQ2Kg+Qsl+2Dqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20236854"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="20236854"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 00:34:38 -0700
X-CSE-ConnectionGUID: AIHGA92dR2+JRFIHooY0Kg==
X-CSE-MsgGUID: cwPquw+USl+YrotQUtS/MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="23135785"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 00:34:36 -0700
From: Yujie Liu <yujie.liu@intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests/intel_pstate: Add validity check for cpu min/max frequency
Date: Wed, 17 Apr 2024 15:28:05 +0800
Message-Id: <20240417072805.1168550-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If libcpupower is not properly installed somehow, the cpupower tool
cannot work, and cpu min_freq and max_freq are not correctly assigned,
but the code can still keep going and gives an "ok" result at last,
which seems not to be the expected behavior of this test.

    tools/testing/selftests/intel_pstate# make run_tests
    TAP version 13
    1..1
    # selftests: intel_pstate: run.sh
    # cpupower: error while loading shared libraries: libcpupower.so.1: cannot open shared object file: No such file or directory
    # ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
    # cpupower: error while loading shared libraries: libcpupower.so.1: cannot open shared object file: No such file or directory
    # ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
    # ========================================================================
    # The marketing frequency of the cpu is 3400 MHz
    # The maximum frequency of the cpu is  MHz
    # The minimum frequency of the cpu is  MHz
    # Target	      Actual	    Difference	  MSR(0x199)	max_perf_pct
    ok 1 selftests: intel_pstate: run.sh

Fix this by adding null checks as well as [ $var -eq $var ] checks to
confirm that both min_freq and max_freq are valid integers. The fixed
result will have a "# SKIP" suffix and looks like:

    tools/testing/selftests/intel_pstate# make run_tests
    TAP version 13
    1..1
    # selftests: intel_pstate: run.sh
    # cpupower: error while loading shared libraries: libcpupower.so.1: cannot open shared object file: No such file or directory
    # ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
    # cpupower: error while loading shared libraries: libcpupower.so.1: cannot open shared object file: No such file or directory
    # ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
    # Cannot get cpu frequency info
    ok 1 selftests: intel_pstate: run.sh # SKIP

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index e7008f614ad7..e81758cd1fb5 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -91,6 +91,11 @@ min_freq=$(($_min_freq / 1000))
 _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
 max_freq=$(($_max_freq / 1000))
 
+{ [ $min_freq ] && [ $min_freq -eq $min_freq ] &&
+  [ $max_freq ] && [ $max_freq -eq $max_freq ]; } || {
+        echo "Cannot get cpu frequency info"
+        exit $ksft_skip
+}
 
 [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
 do
-- 
2.34.1


