Return-Path: <linux-kselftest+bounces-17047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7D96A0FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269511C23B9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B793F14A4E0;
	Tue,  3 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huAjjvLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA115443F;
	Tue,  3 Sep 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374759; cv=none; b=IOcZfw28XHB8I3f7NuxZHkm+PBIYQWHc/W52TRDO7Iszf1cFmTh/+5ZTfaGKqysWcN8XNcTCxYD5VA1mV+it1ohVafMlLde995p6hlCsJWApCqah9Eilq6dFLVK2XFlgC1AeACT/N2yeHM+/5+YDXy6sMknSE/Bcl5s5ZpLkuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374759; c=relaxed/simple;
	bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuaGHaOHd2//NltP5D9G+eUrm35O1szOWX6WYCFqx0Xw1F0urB7jQfYTRc7Tc6WTtFOTv0+bkltnOVopZoHCyzUlN0pR7+3w28lPELPqW1rgCkJSmlAA3W2qKqlh5CDaH4s5G2jw0BK6coqhcViWz7tYCxHQd89v4JbM5L9i0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huAjjvLo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374758; x=1756910758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
  b=huAjjvLoOEdttytR46+Jv0Fq7tktu1KkndFj5MgDrlzagyxRbjXmn5tB
   R5qaRqoUqbIgHbhQwMQ56tlUvEbd46mB32xyl7QIMeKgzTig/1vfaqsZs
   8JF+kImu/bb4ZMEt1Utd25R/iE0/Cg5IjgnDefnBmAXP6BbUUI8XwEIm5
   scxKQTcVpIw+rI5rgztOmDSgokZyPi16B19GNB/j8pwk+BA33B5BdMTlR
   guQwOZojssQjojleoWH13/R3KFfQm5blCCDILAyVFlrvdud/d8RcvGwCM
   gp3/ZIDWsQmDzVuVZkynEXA6neb3DsIUDGALnUGY6ViUCvmHeLufurUwm
   g==;
X-CSE-ConnectionGUID: uSxjkH6JTOeaYgj3iNZcfA==
X-CSE-MsgGUID: uO4dyCMhQ1Opbq5/14pzZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24145250"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24145250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:58 -0700
X-CSE-ConnectionGUID: 0okE6BdUSYWzl3ZNIaxSRA==
X-CSE-MsgGUID: XsGT0v20QliuVcplGZQ7qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64577448"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:45:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/4] selftests/resctrl: Always initialize ecx to avoid build warnings
Date: Tue,  3 Sep 2024 17:45:26 +0300
Message-Id: <20240903144528.46811-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To avoid warnings when __cpuid_count() is an empty stub, always
initialize ecx because it is used in the return statement.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 51a1cb6aac34..9882c5d19408 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -290,7 +290,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, ebx, ecx = 0, edx;
 
 	switch (get_vendor()) {
 	case ARCH_AMD:
-- 
2.39.2


