Return-Path: <linux-kselftest+bounces-11373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29990043C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B571C226C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1D194125;
	Fri,  7 Jun 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMDj+yeg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664A19408C;
	Fri,  7 Jun 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764932; cv=none; b=lPqADRQyAa+il9ge45DGzFRn7+JCox31opo7Y2XqDcwMK0UmYkXfbCKxukyEcNtBBo8Hh9J/1b/jmpEm0hYeDJ1Nyo5/BcZorUxmPM51ZSEetIYPAmdv6dVgJQ53JsXiRUyb13jr5yXck+DvGaU4MJWL/yWW4CBZPEIBaPJEX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764932; c=relaxed/simple;
	bh=S9cfMwZg/9eewZmsG7lugvWNIjZBo1dQ6QGf+nuEZ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpMmhhXx+IFNu8zOvmuSF/pAuS489cQ/f35RLJs5SV/CQg+IlMSwRrgxIbNlrYoo425iEzj0NBno6DJ8LqVdVZFVluDhEjxX3GI6prwf1i2v1zhiC3EI3dQeCZmqnh0OK7QXzs5gba1VaaUB/ckYs/7dzkC5whdQz2F4rWmhf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMDj+yeg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764932; x=1749300932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9cfMwZg/9eewZmsG7lugvWNIjZBo1dQ6QGf+nuEZ0c=;
  b=PMDj+yegJho4tEaKsK1ghSBu7FepzEko88UOB2LHodhu83NcAH4LQtZ2
   ZzgXQtgp83tTfIzDpMk928N/IdA7OMsJOuZ76vrQnWav6+g6JalYXN2Ao
   TCI6wuglb6B1Lv/hg99S0w0cbs/9GXjaEQvhGgPECuoqQ8eeSJqy3Mxr0
   L7SLIiUfetACmxekHFhFtUn7/lMvMpqyZb5rphYALMLWLNul3858x/+E4
   QQ0zV3yqRee6boBeyNQdWubDLDUITrYnS3KS8dICCFf4vQGq/R08clpdB
   dPhl+1/6bmQDngz9iRSGWm+2h0OctTgrbJBrv5c+zHqH4UQmcMjbDDtN0
   w==;
X-CSE-ConnectionGUID: mGDgSB7jTYGiVth7bLKWBA==
X-CSE-MsgGUID: WCTAvFYxQnaWqwBHjbYnDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25055984"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25055984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:31 -0700
X-CSE-ConnectionGUID: AxeQqm7BTRWz2i/p2lVnsA==
X-CSE-MsgGUID: TdCLkyQcQmqDZ8kHsF9mAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69484094"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 14/16] selftests/resctrl: Remove mongrp from MBA test
Date: Fri,  7 Jun 2024 15:53:14 +0300
Message-Id: <20240607125316.7089-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


