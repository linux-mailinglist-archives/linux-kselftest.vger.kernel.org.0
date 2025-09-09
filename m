Return-Path: <linux-kselftest+bounces-41029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFFEB4A536
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1001888D4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3A24BBFD;
	Tue,  9 Sep 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3kWIpz6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D51248166;
	Tue,  9 Sep 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406387; cv=none; b=Sp2VmHeO6lbhVW3Mrra4SYIKuPuDcoaLQOKT8oJAOJbJwj61OfZ/AgMs4pjgWdvSu2RaHbQnlOdAeJxGlt9JFbZailv4+1nM0mJhPuVVIPIyVnj7lwPw344Gnxi4jhmC/6q2WCQVZCjN502yrsLPeUHvAbN+UqgK0cMbgeFJOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406387; c=relaxed/simple;
	bh=bGw+Gl+LG/VTCxvGByFWG4Be1WYL4Tqk53Oe97m+lOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TYOFKndRioMOg4dz9KyIMLvQqMa7oaA1XZ7T3Wu6k85yx81rUEac2C0TKImVFU+qRxFfTo7Ngg23n6FPZq5mfpuDQJgZt/wjbwd6CgFxF0opwvVypcqj6Ijma5r4xwIqJASdcJXZyIg/+uiEojYwnxPtXWNz84TeKh0kn+pESAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3kWIpz6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757406385; x=1788942385;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bGw+Gl+LG/VTCxvGByFWG4Be1WYL4Tqk53Oe97m+lOY=;
  b=M3kWIpz6EYIotTR+5UlfmkGjiploWLbGR6s+kwrryXHcH1oSlaPHsYk4
   UAFRFOXHEnae7dfehsmhVsZoM6EAeqBjHkFELAvDL6enrwhpaHRrqLzEE
   ldxi3S4W/Ml59E70jHY9WKiGF4mVG5nyeQkUR23vhD5fb6WKV0KEzsMKc
   iyZ/ool0Vz50L8Egh2mMReM+MkayMDtAe8ArIbgPhrBcEZ2oOls1NxyFw
   2txC9eOR8yVp2NtXTQGUjqGCt4nj64z01rJnqGE1NtdaMYA8ePow/xL54
   /ePKfmZDjvmB6TeauDtnd/sfdy0EMtGVr0NWsGfGagwiZtjTImbkgc41Q
   A==;
X-CSE-ConnectionGUID: V/Kz+VHTQrOvffTISHF6IQ==
X-CSE-MsgGUID: 4cQsyZ2ZTPiUzqQmBB6YoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59790209"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="59790209"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 01:26:25 -0700
X-CSE-ConnectionGUID: zQ+l+FxjR2SUZU/GP/iDLw==
X-CSE-MsgGUID: PYXZzisJTK2bbr4bNhx2Vg==
X-ExtLoop1: 1
Received: from ly-workstation.sh.intel.com ([10.239.182.53])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2025 01:26:23 -0700
From: Yi Lai <yi1.lai@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	wad@chromium.org,
	luto@amacapital.net,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	yi1.lai@intel.com
Subject: [PATCH v2] selftests/kselftest_harness: Add harness-selftest.expected to TEST_FILES
Date: Tue,  9 Sep 2025 16:26:19 +0800
Message-ID: <20250909082619.584470-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The harness-selftest.expected is not installed in INSTALL_PATH.
Attempting to execute harness-selftest.sh shows warning:

diff: ./kselftest_harness/harness-selftest.expected: No such file or
directory

Add harness-selftest.expected to TEST_FILES.

Fixes: df82ffc5a3c1 ("selftests: harness: Add kselftest harness selftest")
Signed-off-by: Yi Lai <yi1.lai@intel.com>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
index 0617535a6ce4..d2369c01701a 100644
--- a/tools/testing/selftests/kselftest_harness/Makefile
+++ b/tools/testing/selftests/kselftest_harness/Makefile
@@ -2,6 +2,7 @@
 
 TEST_GEN_PROGS_EXTENDED := harness-selftest
 TEST_PROGS := harness-selftest.sh
+TEST_FILES := harness-selftest.expected
 EXTRA_CLEAN := harness-selftest.seen
 
 include ../lib.mk
-- 
2.43.0


