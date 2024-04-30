Return-Path: <linux-kselftest+bounces-9108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D18B68CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8451C2175C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378F1863B;
	Tue, 30 Apr 2024 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG5KBgTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075D18637;
	Tue, 30 Apr 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447897; cv=none; b=ujsDwnBK7hyFOr28LKjY8o1JZmxzGoqcyoE+HoyYUjRSqOiPy2AKM+5RzA/rrnzKSE4IUWEzZ4uBbFEwigKM1lF79nLFnxRVyyn2AsSQr2+sSJJm/sI7QRrtRjQJOpnqePbbTS7DuIHD3ewjP8rSccrDg7ulSX6uS3xboA/dals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447897; c=relaxed/simple;
	bh=mq4Y8ibXMhwIIRyyDw1nn+vBWRQBohV8pJPSfectHRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLGYuipp+onB0IV+CJllfZBFHy0E9T4cNvyb6Tch3jn1F3S7dqEo9TppI0GmGoXmZQY/wcbzi22il8Y1QAk5/FRwinBgpclAKQNMbTgCesfLQlNkb+bD0ZlOBcg7dtE4hqwiMUDleeQUDDvcn4NHkvMuwugrxUoZNHU+13u7fDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG5KBgTK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714447896; x=1745983896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mq4Y8ibXMhwIIRyyDw1nn+vBWRQBohV8pJPSfectHRE=;
  b=bG5KBgTKXr7xdpaSSWoqyFugz31G5QKG1AoUtYxbPIIgmJLAzVDVJz4V
   y/RiAFA1QWKWR5PIIjw2idG9niy1UGs5IWLoyC/KEFUWfKj3Aua+ttnte
   /DZ4H8gE/DB77EfimuiRGLjhF3Ow1u+HstGsuYmAdq2EzorPW/BuZefFN
   Ub1oP8FD7UjVLH025wqIMG3WN5srE1iubxzwYgOYSLHSaBabWBAQJiKef
   Syx51wF/BfNtqoImX4Wxv7RIeFp7tBvoLnLm0/I+wKI1xCmeI191/8NO9
   Hp2xq5n8nBdELN8uuzQkEopn18qwuo0C8DOMuLusfbr707Vlr6k12DlO2
   A==;
X-CSE-ConnectionGUID: 3813MeObTyu6KIof7W4hoQ==
X-CSE-MsgGUID: 7EQo10CfTDylUig6sGl9DA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21284194"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21284194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:31:36 -0700
X-CSE-ConnectionGUID: v9O8VmDgQ2afC3JdwV0NkQ==
X-CSE-MsgGUID: 9BStZHmsSjeEOm7099Kf4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26820011"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 20:31:33 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v1 4/4] selftests: ifs: verify IFS ARRAY BIST functionality
Date: Tue, 30 Apr 2024 11:31:48 +0800
Message-ID: <ed40ce865415e98380278b5dec5b24ec50981077.1714447026.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
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
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../selftests/drivers/platform/x86/intel/ifs/test_ifs.sh  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
index 63d13400af4f..2ab310c4aaff 100755
--- a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -481,6 +481,14 @@ test_ifs()
 		test_ifs_scan_available_imgs
 		test_ifs_same_cpu_loop "$IFS_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
 	fi
+
+	# SAPPHIRERAPID CPU could not support IFS ARRAY BIST scan
+	if [[ "$MODEL" == "$SAPPHIRERAPIDS_X" ]]; then
+		append_log "[$SKIP] SAPPHIRERAPID CPU, skip IFS ARRAY BIST scan"
+	else
+		ifs_test_cpus "$SIBLINGS" "$IFS_ARRAY_BIST_SCAN_MODE"
+		test_ifs_same_cpu_loop "$IFS_ARRAY_BIST_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
+	fi
 }
 
 trap ifs_cleanup SIGTERM SIGINT
-- 
2.43.0


