Return-Path: <linux-kselftest+bounces-1683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBD80EF5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 15:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7361F2150F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA93745DD;
	Tue, 12 Dec 2023 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APKBhwtq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3784EB;
	Tue, 12 Dec 2023 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702392803; x=1733928803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qo202yzdW9FjkslWfPMmIkndsLvL+V5BLV3JStn7eyw=;
  b=APKBhwtqjI+K6C+Q6mkeiVnM/jaC47UDxSp3G/yoQe73ubc26YAjLRuT
   az7ZQTqaa9MP8EwdDtWKMssKBWT00ghyXzrbAWXnMDePFOY1gd4VUF/IW
   wyhLRVmQJ+plx2NFoX2DQsqkdlsdv83jhlREFAda9mZlsxv59zA5P4v8n
   EoTfv/Ab2BDC8F+dIIo6E7PDeU9AdYGgHxDJel7Pk6gJBiDUl2kVwxZaw
   Ny5XQh9qn4DAE/Wq0oqCc8g1OvE8MJ//wfLZWR9EKeOz+zxQGrioRJure
   oaJSehEYVZU+V+JOAEr4QNhhK/yUEHprsobLoUbev4oDn0p54AzAVvseL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481014340"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481014340"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="15023957"
Received: from mdabrows-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.5.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:21 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/resctrl: Add helpers for the non-contiguous test
Date: Tue, 12 Dec 2023 15:52:52 +0100
Message-ID: <c7b66a4682829894ec72d8a1f78e324233ef0535.1702392177.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in Intel CAT. Then the test
compares if that information matches what is reported by CPUID output.

Add a generic helper function to read a chosen functionality support
information.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 739e16d08a7b..8f72d94b9cbe 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -161,6 +161,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
+int read_info_res_file(const char *resource, const char *filename);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 0e97036a64b8..70333440ff2f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -249,6 +249,31 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+int read_info_res_file(const char *resource, const char *filename)
+{
+	char file_path[PATH_MAX];
+	FILE *fp;
+	int ret;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
+		 filename);
+
+	fp = fopen(file_path, "r");
+	if (!fp) {
+		perror("Error in opening sparse_masks file\n");
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", &ret) <= 0) {
+		perror("Could not get sparse_masks contents\n");
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+	return ret;
+}
+
 /*
  * create_bit_mask- Create bit mask from start, len pair
  * @start:	LSB of the mask
-- 
2.43.0


