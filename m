Return-Path: <linux-kselftest+bounces-6200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D587810D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3205B1C2276E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E33E49B;
	Mon, 11 Mar 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZI+rwOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58C446AE;
	Mon, 11 Mar 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165277; cv=none; b=RkSFjqnECmXFF9h9wIP61E+r0648gO84t2vUGNFpMhQRPDc0p23Ejb3oW+dWr9YP9/V8ZAjzObm4PFRTb0ZY10bQ15TZt1+SbFhiTEQqOhiJ7EfPYeK/TZxQfFmZsLz/vGuUcLHjcdRL4BG61LQyUcH5T90NoiYIQnTiXtC4h34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165277; c=relaxed/simple;
	bh=mcF/oOZCuYZck6jzS/HrVV81jGUzLr+iH551WCD2YyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhk2G/Edrv0CQgdMQUPhyrxZA1+AEkt57zDFEKjOWMvyM+dKZ6DRdIgMMLT/pki97qaTJiRoOLYVfKGTZVCWt8g7dY+t8izZ4Q+hQOjjmNhH5KCFmw/6FLFvJFfxyuv9xoQCAFHp2XGagajkb+GBAipGiN4Hi734NopFb/35+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZI+rwOH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165275; x=1741701275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mcF/oOZCuYZck6jzS/HrVV81jGUzLr+iH551WCD2YyI=;
  b=dZI+rwOHERwcSedGECI6H6I0wGP8cGvMMmHme42WtoJCdoSJN7qGNcjc
   K0TYx9FGpLdaq+O9W6aQou8wyQSHuxtxfGsoPBkxhWrs5A6bXZUB7I3Qv
   r5Dltzg4IXC7kRcFq93oGX6YLGGmj2LIj/Ef1tRo5my+4SOD8tqDtlIh0
   MQGAfHeopU8eD3wQqX6Ke5GGugTdJXv4Z+romcqSfL5irjgUCKFhZ7XR0
   1+MedqHNzHYDFjuHoYEsgfv3efEYu66oHlPy14BnZn6BrCmkHFq/tFtk1
   4s0Mz2neGBeHm+9W2i17hfSNO950JF/4DzzTVe/SfKLZns/KS8aIxeh6U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4705367"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4705367"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11243480"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:54:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 12/13] selftests/resctrl: Remove mongrp from MBA test
Date: Mon, 11 Mar 2024 15:52:29 +0200
Message-Id: <20240311135230.7007-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
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
index 89ad7f2cdd65..5bb73e6cabc3 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -174,7 +174,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.init		= set_mba_path,
 		.setup		= mba_setup,
-- 
2.39.2


