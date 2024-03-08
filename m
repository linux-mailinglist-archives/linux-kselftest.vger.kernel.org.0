Return-Path: <linux-kselftest+bounces-6105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B0876541
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC41F243BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A423FBA9;
	Fri,  8 Mar 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzMKS+pv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2097381AD;
	Fri,  8 Mar 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904310; cv=none; b=PVjoytbCQGP1cd+yRk5Pd/qRhualFceSyxIBiUqM2Zp3udO17AC4Mev7H1aK/IGac/QhEiJNg5zcpBxRQCeSHOYBm4KA2Zg8v7SJe1Jo+QltokENVJDZZb/fJUtUUOgn6pft7QgBGoj4gUbEDhmde0x4uPTjg6gx0sPHMoehPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904310; c=relaxed/simple;
	bh=QABV4KwIXB/01KtAqTeTOsyRjq1X1PQG9cF1D4CCei4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1MLesj9mZzVw9rmoFP+gf6ZDwFtRtIlJric5fc/mEitnGirFSKSbduPvA29EiRmH9r6LyBGuOBRGd0V4Cs1o3ahNSQkLeIfepNEkS0QBiU83+FVSsFIM+7ZOGZHlINQsy8+gFUoXt47nds4NSrWgFgjTrr/dX2+U2k2b+Je7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzMKS+pv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904309; x=1741440309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QABV4KwIXB/01KtAqTeTOsyRjq1X1PQG9cF1D4CCei4=;
  b=LzMKS+pvQIGrpP6DEVUoO+XqLbgY6E6BQE/hNXWHHEtjbUxOtgUUAVPz
   O1dkue3c+f9F+Ex1d9ka0OjOg2+CkUKeSdm9a6A6yh0/pqlruQ+RpKnZI
   jUXyL5tdDJEFLLZkM3cJYA2veMKJUoYgMQzN8JtzVbUFzm+VOGaan7BhH
   YMv8ySD68OJJ4TtkrS4VTXF/7GoE6gDIPO6JMvu2j7gBkikUQevATkBoY
   A3YY7VMxcOpxG+O0UKNtaX21uWW5gWB2UHjVJHCcNg38l74gP/0NDyn7U
   flCkd91yG4/vUZn+BXIk5swGHXW6Pu4Umfd86APsol7JfVZrGiy47b5yo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8375250"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="8375250"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="41394728"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:25:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/13] selftests/resctrl: Remove mongrp from MBA test
Date: Fri,  8 Mar 2024 15:22:54 +0200
Message-Id: <20240308132255.14442-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
References: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
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
index b5f76aa192eb..ea024bf8088d 100644
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


