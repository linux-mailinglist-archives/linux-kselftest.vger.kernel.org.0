Return-Path: <linux-kselftest+bounces-296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9477F1171
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A422C281887
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929CB134B3;
	Mon, 20 Nov 2023 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggdidZGC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053BEB;
	Mon, 20 Nov 2023 03:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700478842; x=1732014842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzPsjJjcfyDfgR8LTQ4WEtUUvgvOSZlRwS0QORtco8Y=;
  b=ggdidZGCs8fcKCH6HV//1Z8wKabJBRM8JOKusu6CQlg8ELJOVmE+Gcu8
   ao2hZjNDcQX2H9uH+KWVGZ46Wn3yGeczmyHVritUwMCeorUOcl26YFMH2
   Dq9QY+iXwsePJSHPgYCNva8cHmROU7P5HpafgFhP1T3vAmlIwvJo0lY95
   7FtZWe5xiIFbSeCwBbPTKxyQPBPojyRie8kh4pyPzJH8XxrOO7AeJIE+I
   oHiPHmrBcblM7OrSNBf9cK9Crn6iL7S+fBtaSr3FfJOAT3Y6pEGZoshXC
   KN27SOrKR6K3LGbSh2wmwaBVSgATYnUf8cCQWbyntkjILmH/j8TmPD4LY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390457334"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="390457334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="801126899"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="801126899"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:13:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 01/26] selftests/resctrl: Don't use ctrlc_handler() outside signal handling
Date: Mon, 20 Nov 2023 13:13:15 +0200
Message-Id: <20231120111340.7805-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
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
the responsability of perf_event_open_llc_miss() and it thus interferes
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
---
 tools/testing/selftests/resctrl/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index bcbca356d56a..8aa6d67db978 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -41,7 +41,6 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
 				PERF_FLAG_FD_CLOEXEC);
 	if (fd_lm == -1) {
 		perror("Error opening leader");
-		ctrlc_handler(0, NULL, NULL);
 		return -1;
 	}
 
-- 
2.30.2


