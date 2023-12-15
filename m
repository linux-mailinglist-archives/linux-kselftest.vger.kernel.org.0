Return-Path: <linux-kselftest+bounces-2042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA63814B2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B161F24BC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0633715F;
	Fri, 15 Dec 2023 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCsckUSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF435F03;
	Fri, 15 Dec 2023 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652764; x=1734188764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4CfsvVmXuEt7o9BsBWAlVT1iOHdDJykjEbaX1Jbwtjg=;
  b=KCsckUSFl4eoPxnqOdqPQQuptUsCtBCwVOp/LA73wc9QCotVdGqMPMFY
   KQKgtr99xEdpB5GtaAnbchRwYMCRAav4DjP+pjo7YiEJ0yJLS2ZlfqUUU
   NfdGuA+4RKDY9d/xcSFxsKAkarKr/Q2Mk0QTx06csW+c02/jqg0QHfoWV
   Xp7tVTasxqlGcJIWYdsDrdxwPfG8zJubiIgzFnVmg3Igml+4sapU03JSP
   8EFqOPbs19k69RD/VP9fzBxM07zQqXE5zIL/XAiSjDFRlQT/T9JK7MU4N
   6wpjDsHuhkGcnEWREU2nOgKaRqVvktxIZ4e9hdgLBigAXBfZrlti0BK7W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392461478"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="392461478"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106150924"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106150924"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:05:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 03/29] selftests/resctrl: Don't use ctrlc_handler() outside signal handling
Date: Fri, 15 Dec 2023 17:04:49 +0200
Message-Id: <20231215150515.36983-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

perf_event_open_llc_miss() calls ctrlc_handler() to cleanup if
perf_event_open() returns an error. Those cleanups, however, are not
the responsibility of perf_event_open_llc_miss() and it thus interferes
unnecessarily with the usual cleanup pattern. Worse yet,
ctrlc_handler() calls exit() in the end preventing the ordinary cleanup
done in the calling function from executing.

ctrlc_handler() should only be used as a signal handler, not during
normal error handling.

Remove call to ctrlc_handler() from perf_event_open_llc_miss(). As
unmounting resctrlfs and test cleanup are already handled properly
by error rollbacks in the calling functions, no other changes are
necessary.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Corrected typo in the changelog
---
 tools/testing/selftests/resctrl/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 1fa4b86e1459..6d60a2f1b3aa 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -41,7 +41,6 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 				PERF_FLAG_FD_CLOEXEC);
 	if (fd_lm == -1) {
 		ksft_perror("Error opening leader");
-		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
 
-- 
2.30.2


