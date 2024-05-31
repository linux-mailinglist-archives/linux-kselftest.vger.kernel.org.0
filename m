Return-Path: <linux-kselftest+bounces-10989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F118D5C1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A8F28A9EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A956380BEC;
	Fri, 31 May 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSelCeBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CA7B3EB;
	Fri, 31 May 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142018; cv=none; b=ivLAe9ZNedx+muqMFoVrNbkit2ovc3DUq37mKsOt+w/cq1UXjUcQFBU99R0jk/jojbaIiLiEHIYvECJ76izBNxMw5Sfua1fTbGgXIo56K3ooD+mIIym4s6obzMCoYDub0qq6QcpIzYC/BOS2NiNDZ5jhKUhNeQ1RGy+1rzCkwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142018; c=relaxed/simple;
	bh=ZnELZO/KlIAqu27St8QzH8oaCR6e6BrBe8FF/NLKmuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k71KfOZOct0i/ep/5X4HoslrR07mafwE00d79eu4dmMB+GIsRsZ6twy3fKHslelyAlg98Diq1xYHQjywBcaOmGtaNLJgq/KWxdrj8dNl31McpLS92BWdn/Y5K1d6qGu5A+fbKP3WxeNZzrEOI5/BcOXdDjtvg4Sa9v6b7CgVhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSelCeBU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717142018; x=1748678018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnELZO/KlIAqu27St8QzH8oaCR6e6BrBe8FF/NLKmuY=;
  b=cSelCeBUAfzKl6UX0JGPlfkn4Iv76ZrRUCL00MjDG7aAYABkY/d3TD8b
   Nlj5VXjONsu+31u1WTYqBLQ6UgaCrnj/kDgxxzMO+wY/JGCkDFl0norOW
   HNH+RKiPmjKmzmkYalTv20HBCZOxUuVQjh+PS2T14vSpEmeYCT6/Q+Zkx
   4MY4ybCdjN8j9rrjJRcwCCnGBDHgJeJIGPQkyPDbJQYJPRSNp2+h8I2ZL
   1ZHPAN65JTBT/bx63RA3BXdFlcxfYrCFn8M4ZJRf6rvG+DzUrsJUdt+mV
   8igOywujhutcqhfEgkmHcICMquzEYbicgf2AHUDLob7dUyEJnV9G0/e/D
   Q==;
X-CSE-ConnectionGUID: 3AGRNwYuS2CdOatxSxq9XA==
X-CSE-MsgGUID: Xbx/ck8zRjW6Q424AkklPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24336943"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24336943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:53:37 -0700
X-CSE-ConnectionGUID: TsdvSXMYTzqF3xyw0kj5tQ==
X-CSE-MsgGUID: IuvCCeT3Qa2J8VH03V62nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36081111"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2024 00:53:34 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v2 4/4] selftests: ifs: verify IFS ARRAY BIST functionality
Date: Fri, 31 May 2024 15:53:50 +0800
Message-ID: <c85338d1d7e9069192a57ae903944deda797b321.1717137348.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717137348.git.pengfei.xu@intel.com>
References: <cover.1717137348.git.pengfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two selftest scenarios for ARRAY BIST(Board Integrated System
Test) tests:

1. Perform IFS ARRAY BIST tests once on each CPU.
2. Perform IFS ARRAY BIST tests on a random CPU with 3 rounds.

These are not meant to be exhaustive, but are some minimal tests for
for checking IFS ARRAY BIST.

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../selftests/drivers/platform/x86/intel/ifs/test_ifs.sh  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
index 82fc5a461b12..8b68964b29f4 100755
--- a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -17,6 +17,7 @@ readonly IFS_SCAN_MODE="0"
 readonly IFS_ARRAY_BIST_SCAN_MODE="1"
 readonly IFS_PATH="/sys/devices/virtual/misc/intel_ifs"
 readonly IFS_SCAN_SYSFS_PATH="${IFS_PATH}_${IFS_SCAN_MODE}"
+readonly IFS_ARRAY_BIST_SYSFS_PATH="${IFS_PATH}_${IFS_ARRAY_BIST_SCAN_MODE}"
 readonly RUN_TEST="run_test"
 readonly STATUS="status"
 readonly DETAILS="details"
@@ -479,6 +480,13 @@ test_ifs()
 		test_ifs_scan_available_imgs
 		test_ifs_same_cpu_loop "$IFS_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
 	fi
+
+	if [[ -d "$IFS_ARRAY_BIST_SYSFS_PATH" ]]; then
+		ifs_test_cpus "$SIBLINGS" "$IFS_ARRAY_BIST_SCAN_MODE"
+		test_ifs_same_cpu_loop "$IFS_ARRAY_BIST_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
+	else
+		append_log "[$SKIP] No $IFS_ARRAY_BIST_SYSFS_PATH, skip IFS ARRAY BIST scan"
+	fi
 }
 
 trap ifs_cleanup SIGTERM SIGINT
-- 
2.43.0


