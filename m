Return-Path: <linux-kselftest+bounces-11014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138E48D62A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11091F27970
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD3158D66;
	Fri, 31 May 2024 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6KbIi5p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2273158A1B;
	Fri, 31 May 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161255; cv=none; b=ZjR422d3H9cY5K4FXRZZ+cgKPQaojPDzqeA7Zr2supC7XHb9I7HhR0JTy1eKjV0vwxReM5pzKkdoqpDJprDMya/GayospY0b2IfrW/ivMGjXNISqlfgYOqCzA90S5ySQUBJG8BGPNL1zsdQykqGG2zCi0ZpU3tmPmfqRuTpnjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161255; c=relaxed/simple;
	bh=gEdB0ql+iXyQKgfAS8X+Gy4guSIHDeUO8eOjHZ1F3U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cI3nW0jC8gEebuzaEMKg3xx1mONbQ5mV60gChwUgHWDT/PbEYYNbMSqDkFSwkMzXkpQZQhT2030RH/9UGezIkwKtvvu50qFfe3QLdwR5Dk3ztimR2aKSR2j+iO1vChiwTdwG5ScAzuw2gr+SGVikceTyOB/Es7C87OM/BdjNIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6KbIi5p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161254; x=1748697254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gEdB0ql+iXyQKgfAS8X+Gy4guSIHDeUO8eOjHZ1F3U8=;
  b=e6KbIi5p7raMM2ksS5IEZfeN/xhChSJ5gyMsKDRcuDiQ1qg18IY1+2Pt
   5jbDsI5rpVTAmFxqTcoGJyIUvM+IqNuQHV/otuuxyTduhIQvnWJubp3GU
   1StHhXoUfjbFO4f0EtkqP2FZ8GmXvq5EipUKF0l8IZ9JSbQ0JuhzfLUQB
   3yvI5cGei24lUPoFdt1/UpYw7hNvIKPESXuCASxI86Xzrj5H3wtFBg+Tv
   PWa0XFI2cJmThs0fsvlnxbEwUZPQKh8PDNZI08emKq/UmYiNPtPjmdPVL
   jvls0ipq3O0WGqA597c+Hxy3AGPqJFWJ5QifY6vuKfXtFQNehi6S0opel
   g==;
X-CSE-ConnectionGUID: Gvtc6LeiTSaFgVicbDX9TQ==
X-CSE-MsgGUID: bgqgkP6BQQyyYv3JZHx3iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25103339"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25103339"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:14:14 -0700
X-CSE-ConnectionGUID: /jPvPeo2THigHTycFu4FPQ==
X-CSE-MsgGUID: snFfrxzdS7mWIRJWwA4QtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="41078021"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:14:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 14/16] selftests/resctrl: Remove mongrp from MBA test
Date: Fri, 31 May 2024 16:11:40 +0300
Message-Id: <20240531131142.1716-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
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


