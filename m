Return-Path: <linux-kselftest+bounces-20589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF39AF46C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2341F21AEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956921C18A;
	Thu, 24 Oct 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCASzi6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106B21B42C;
	Thu, 24 Oct 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804099; cv=none; b=aheLkq5iiP7DahzlCEpgB7P43HWvx8Izz+m5iZr0ni0fdW2wYoM7WRS1PDuhVjshhiLLj6jxcKFOxdVyTDrPP5PqO1cq8TIYS3y6jGAL+q5UEjmHMcxNSQ0fyHZElOW4HxKekoMuLVzlu5lurIz6wryYqgT7i+wxSf69RkMkSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804099; c=relaxed/simple;
	bh=hxxhPlp3/W6zJ7QsCgtx7RPiium1wTI6Fd1gqm40yoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXhbXszenYCXlV8eJOmuqSipIoPqbunrvalc8XuhVHG7/lgavA6f1sKs5YoQde8nsU170V/R6GgjMInwxPGaNoVreHGokQAqtFMSVtiHkK624XmlJE7mePHayS4MlMj277aJMtmGjLQbWL9bNFragtT5qoNRG3a3qoyJ4VaLK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCASzi6a; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804097; x=1761340097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxxhPlp3/W6zJ7QsCgtx7RPiium1wTI6Fd1gqm40yoM=;
  b=WCASzi6aWqgVOJByT+ZvJ3JaGqL8ARFdMlzHgfPHBtK6xVlQSPHDUxQW
   P3+sa2pLoP/ZB5DMHU6C9FR1VpzWYJgINTeru7o2AycN2JX9/fTDTLOWK
   5xUog4iUyG09HfIClmQFLpgBS6JJfwruZSrrdK4MDDEFZytF3o1asNzMT
   MSNzZ71PdF/D3biLhejF3f6qIBqGu9hrFaHIVc1o+4C+7ER2DeklWk0Ao
   U9tXCJZOWm9hbIWnD3pk2QlIBI2/bmkxm4O9VXzGnw9xNV9jHjeqZcPyw
   BUFvXRMcQa8rOFIoGJth9HnCn002cBWOli+kPZfBmL21Ica6UZV97QvhF
   g==;
X-CSE-ConnectionGUID: tvUcaWIZTTSdQ+YaaX9kgA==
X-CSE-MsgGUID: B8cDwODFR5SfmfNUdyR85g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090925"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:02 -0700
X-CSE-ConnectionGUID: 5QLbLdw6Q8ayvGyLN2bxgA==
X-CSE-MsgGUID: IpZb9Ps/S3i8yateJGlgTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488066"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 15/15] selftests/resctrl: Replace magic constants used as array size
Date: Thu, 24 Oct 2024 14:18:52 -0700
Message-ID: <a1f4676c2db14841c3ffd9e575a41dc2bb8e77d7.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Memory Bandwidth Allocation (MBA) test iterates through all possible
MBA allocations, from 10% (ALLOCATION_MIN) to 100% (ALLOCATION_MAX) with
increments of 10% (ALLOCATION_STEP) at each iteration. During each
iteration the test measures the actual memory bandwidth NUM_OF_RUNS times
to determine the impact of MBA on actual memory bandwidth.

After the MBA test completes all the memory bandwidth measurements are
parsed into an array. One array for resctrl Memory Bandwidth Monitoring
(MBM) measurements and one array for the Integrated Memory Controller
(iMC) measurements. Each array has a hardcoded size of 1024 that is
large enough to hold the current test data, but this hardcoded value makes
the implementation difficult to understand. It will not be clear that this
array needs to be reconsidered if any of the test parameters are changed.

Replace the magic constant as array size with the test parameters the
array size depends on.

Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Closes: https://lore.kernel.org/all/45af2a8c-517d-8f0d-137d-ad0f3f6a3c68@linux.intel.com/
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V3:
- Add Ilpo's Reviewed-by tag.

Changes since V2:
- New patch.
---
 tools/testing/selftests/resctrl/mba_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 4e6645b172e3..536d9089d2f6 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -127,8 +127,9 @@ static bool show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 static int check_results(void)
 {
+	unsigned long bw_resc[NUM_OF_RUNS * ALLOCATION_MAX / ALLOCATION_STEP];
+	unsigned long bw_imc[NUM_OF_RUNS * ALLOCATION_MAX / ALLOCATION_STEP];
 	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
-	unsigned long bw_imc[1024], bw_resc[1024];
 	int runs;
 	FILE *fp;
 
-- 
2.47.0


