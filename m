Return-Path: <linux-kselftest+bounces-20100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA689A32CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7192C282CD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366018A92F;
	Fri, 18 Oct 2024 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5m/kEn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72C188A3A;
	Fri, 18 Oct 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218170; cv=none; b=cKowjsNuZTAeBRLcFZzqBJcAh52iDMv+/rwUZSjGuGXpS6/omVCCaqr9L7PuSNdYuEYOf1+CVwcUAAA+QbqrvdJHtjeKmi8QuTeVU98Hz+1afkOaj8+rAv6tiEuRh9wpEhEYG68Jbz+akwJLAMcXMPNNPuB0HpGuixpSaNA8+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218170; c=relaxed/simple;
	bh=tI6VohGtESZrrT4HRmtXRzYBMdb1L8lF9wfiL0/qAqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n54ULumjBNuHVjE6JBF31b4+aVK5jT+7zDhRPRSPM9iAiTOl/JXJ2ZGftYRIWFXKg8BQxyCTOB1nt4Y63owt5e3gSRY9PD5Ee5vZtVB1J6P6Dp64VcZXWier808xheGsDcvI4Z8mSkeYB60kb9Y8K9RPSDConekjAh+Z/eRVjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5m/kEn+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218168; x=1760754168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tI6VohGtESZrrT4HRmtXRzYBMdb1L8lF9wfiL0/qAqs=;
  b=I5m/kEn+YKUi7HDpEf8nHLXmqThrNhzVG3V7XdhkYjznuNycsnk/nyTk
   g1iJNfjZFK5klg76Krsa24ZHYQrmuI9BA3eQpX8ImYS0Dxrw+hHYAaNcE
   e1aoN4qtfc11a0MSn9Jj5Nu7NdLhoTQCG23zJ/uJxEfxySPqigtzJ/coq
   vyq11M5W1ZXJ22KuFqBb46cvV0zvPWyoor6e5OJPeRXape4FG7eWyrTbX
   UTD2vCEA/yvYR7/wcDWghsyEQx1L4ldRCQ3pbHJE5q7AD0FTS6wu8P7lf
   Oh+bivJWyC13Y7N23aslh70trjw+F4kkqkkghVsD5gRIi9cXKJ+iSPqXE
   Q==;
X-CSE-ConnectionGUID: jC8tIDWGSTaJCWf0TGfBLQ==
X-CSE-MsgGUID: 6XWkp42QRWWrvxgEXM4Pig==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149722"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:38 -0700
X-CSE-ConnectionGUID: GrBDgQ+GRG6SZMN4ZY7MLQ==
X-CSE-MsgGUID: gJquDY6pSuixK+ky74CPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697744"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
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
Subject: [PATCH V3 15/15] selftests/resctrl: Replace magic constants used as array size
Date: Thu, 17 Oct 2024 19:33:30 -0700
Message-ID: <4d4887b0359bfd4094871f34aa8b06e2efee6043.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
---
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
2.46.2


