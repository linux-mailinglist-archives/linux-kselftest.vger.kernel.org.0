Return-Path: <linux-kselftest+bounces-7426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5589C9C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 18:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083BE1C24440
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3EE146A9B;
	Mon,  8 Apr 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn3Kt9d5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E0142651;
	Mon,  8 Apr 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594119; cv=none; b=tJcJYnX2Trl9iIyeHwPyIxeP8RWKprBCdJsikgTRdUVjfB1zfIQG0Qu0Ai2jIUNmFtQ1vjdiQmWlAzSp/qGS6hjDgLk9R5/0UNwhVClg1BUW17TDvhxeGAIYyPOzO/UlS22RJtNnSygE5qhgT6PNcgtMatZwtJNoecW6UV2X2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594119; c=relaxed/simple;
	bh=Iy0JjcLUSebL6oRihQ/kvCDMmxysZknFiWvlqSKnjQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihPgF7FKqlfRKidjLUTHf7zS/q1YO1KT+7lv0wN5ioufRex4qcOn38gr0IEo6r+sP5rooLpdFZe+ET8HfbnQ31tm6Bw7APmm8mCCFjqV71T3CJGDuHB5oLd1NZi/mDPUSSpFNplBxIMsQCfiRai6HA8pJCdnAwEABVBwf5CUKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn3Kt9d5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712594118; x=1744130118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iy0JjcLUSebL6oRihQ/kvCDMmxysZknFiWvlqSKnjQo=;
  b=mn3Kt9d5KLeWM03M4pHem8A5kxopO3Z9Pi80gZ2FWQLzhGLshQLKb6YR
   qc4jsV2/3G1ModW00qqFcrpwqoN4aCahy+KPcvcAisvlCR9U/mGr8lafu
   2w+VpOZAr/UR5NA5Z3xvCpopC9MuALVLYSO8C3xTfYSlLKyxUmaBhNkew
   F9VFmWte87ZPD5w7vKvJcksNpkjuHzJe/7+5FviBJZe+tMHMEu5emfaGI
   GJtvcncxAXMTrwE6FOaaZrcrbfUqPy4fxNUESebenvxfB8yv8YEemVasb
   orSngunce+LgguAITGAp0nEd/9XieMP4JJDxfAXOl7mx7D+E21kPQKRfS
   A==;
X-CSE-ConnectionGUID: fAXFECH9TbySQrF+evDj7A==
X-CSE-MsgGUID: LacixLC7QAu7IPcHZBXkNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18492271"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18492271"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:17 -0700
X-CSE-ConnectionGUID: WL63UZH8SMmsGGf7Omzw+A==
X-CSE-MsgGUID: htVhNVgVSp+7wvLH4OV0zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20376626"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 09:35:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 15/16] selftests/resctrl: Remove mongrp from MBA test
Date: Mon,  8 Apr 2024 19:32:46 +0300
Message-Id: <20240408163247.3224-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Nothing during MBA test uses mongrp even if it has been defined ever
since the introduction of the MBA test in the commit 01fee6b4d1f9
("selftests/resctrl: Add MBA test").

Remove the mongrp from MBA test.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 9c9a4f22e529..5e0b1e794295 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -166,7 +166,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.init		= mba_init,
 		.setup		= mba_setup,
-- 
2.39.2


