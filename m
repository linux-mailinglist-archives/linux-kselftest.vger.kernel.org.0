Return-Path: <linux-kselftest+bounces-10437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E758C9D6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3091A1C234D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50A6CDCC;
	Mon, 20 May 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMhHm0mu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2595674A;
	Mon, 20 May 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208358; cv=none; b=Hi+K1hICKNWorDLDuaBSNhlBPqhRrChblGMSD7kqNCBzfsWkIoHwP3z7rQlgkxm55UWD2ZCj7UAHj7hpspDr4cx8vkAw5SEG6BPJJr/GL3Q2pfYf/u+rQHaO2gYxtKaabRYRcu80waDSQ7vj+3Q/ScseHtirSgyJ4TLiSoVLghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208358; c=relaxed/simple;
	bh=Iy0JjcLUSebL6oRihQ/kvCDMmxysZknFiWvlqSKnjQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtgI4N0Bvp+epgeChFN5P6R+aB7luq85gmXNrN3gCd4vRJRTYedZThn5urmf0J8UCw0dWHhhb5e1pehPzViNT+UN3mP3OCxMe91BQcGIbGf4RBlVwn+H5+TRUJMUoEHKOEXZEVb8tNCAWfhY7t3Ui4ie4jQfhRuLsQwfWidZFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMhHm0mu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208357; x=1747744357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iy0JjcLUSebL6oRihQ/kvCDMmxysZknFiWvlqSKnjQo=;
  b=fMhHm0mui5i0QVv2wH2bBO1Z6bIVXpHLzzDv/8+P5ZxLalUgRiGcuCb8
   3zf4lEco9ok5Iw+FwzXvaiCCFJ/No0yEhFpK3B5NNRlUn0BayztLXPWt5
   NCFP29MvY2A/a8Nu8TK3lHM6DAcTPDoGzoZrAoXIE8knhP7AoaV7h4qBG
   FGgICKcl/JEclF8SVbUjG/68s4a1VxPgK2COpq4aCLgt0vDp5ddIwSsKz
   Sp4HYr1JK32r6qEG769/EaM55glaSi9CeAjWoHU8KVEGKyqKSxQFhPMUI
   gMgZ9MV0LG7pVWKAtBurJcFocDkK7sOzd5DhJwepZaaRJs1dsKXEEmSoU
   Q==;
X-CSE-ConnectionGUID: Bl0zeG1xTVOnx2COdL2oOA==
X-CSE-MsgGUID: glKVYXP5QG6Q3jRQ8au0MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23475470"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="23475470"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:37 -0700
X-CSE-ConnectionGUID: H7OGw2arSrG0XJUYeXXLOg==
X-CSE-MsgGUID: 03vx+tvXS+eYCiFm5yQAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="63747804"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:33 -0700
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
Subject: [PATCH v4 14/16] selftests/resctrl: Remove mongrp from MBA test
Date: Mon, 20 May 2024 15:30:18 +0300
Message-Id: <20240520123020.18938-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
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


