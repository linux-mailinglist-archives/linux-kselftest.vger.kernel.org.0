Return-Path: <linux-kselftest+bounces-3560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057F83C098
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9433B1F23559
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7E45C04;
	Thu, 25 Jan 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vn3NfZf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594A54BC0;
	Thu, 25 Jan 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181182; cv=none; b=f5crJA5wJ+oiw+v6c5SImW3VCI0WpjswrEKT6j5BR5GFi89NAhHN/cdcgiNvxk2ZPbHknJYzKna1DcH0YFgjkDFlF4oc09GLawMhLWaeXasUveoB4OiYUuI/OuaxqTN0ioNv7WP9vayTC9O+dAnEnd9thm9MmOXVi26hlWzLp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181182; c=relaxed/simple;
	bh=SxRU7/I2LYttjmLWpA1g2TAp7MIA5p+HKBajTxhEzJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGBifd8nUus7qBZDhAxIQAPd5cxSG8HQreIQtbZtEnwt9ad7zY9IfUyXcJ0WIi4ninAcxzqjN21sGBusbnp4jpElowbWwmE9JOa/5wxrBFaLJpm0ovC2B+KosgMohuZAi84MQJF+Wl8LqaFmerIrSYXXAMAYjP+nZAlQoQUKP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vn3NfZf4; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706181180; x=1737717180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxRU7/I2LYttjmLWpA1g2TAp7MIA5p+HKBajTxhEzJs=;
  b=Vn3NfZf4itAM/jGnV5273rCZEb6G7jXlC2qR69Zwp8dd8LChKxkgVvom
   fIhwPdquFkGsTE0PFmFhe0U1LqNi2kfwU35kiQwymmWmROrnEJ8Oiw4ZA
   fLMzVflcPYFCwSy9bSM8T96wWbAxOCm4+4v1tc/apYmLZAj213X6WncrH
   dszCTcMD2gAfH/NMKC5P3JU7fgCdTNQ9m5kiSUBAiVoexXX8oWJlrjsIk
   JZY/wlTjAmZAnsj4EwICtkgw5Nogu/6KgUyTnGm+Ygf4+ggM6KkQkFxhM
   mXhjYGUykNnYBZzc9P8nlA5t/KAFc9kDzIFmfefn+rEWXlrSpPhpml3aZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400987627"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400987627"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909968606"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909968606"
Received: from apejovix-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:12:57 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 4/5] selftests/resctrl: Add resource_info_file_exists()
Date: Thu, 25 Jan 2024 12:12:44 +0100
Message-ID: <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Feature checking done by resctrl_mon_feature_exists() covers features
represented by the feature name presence inside the 'mon_features' file
in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
to represent feature support and that is by the presence of 0 or 1 in a
single file in the info/resource directory. In this case the filename
represents what feature support is being indicated.

Add a generic function to check file presence in the
/sys/fs/resctrl/info/<RESOURCE> directory.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Split off the new function into this patch. (Reinette)

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  2 ++
 tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4603b215b97e..c39105f46da9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -138,6 +138,8 @@ int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *feature);
+bool resource_info_file_exists(const char *resource,
+			       const char *feature);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e4ba8614fb7b..a6427732e0ad 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -763,6 +763,32 @@ bool resctrl_mon_feature_exists(const char *feature)
 	return !!res;
 }
 
+/*
+ * resource_info_file_exists - Check if a file is present inside
+ * /sys/fs/resctrl/info/RESOURCE.
+ * @resource:	Required resource (Eg: MB, L3, L2, etc.)
+ * @feature:	Required feature.
+ *
+ * Return: True if the file exists, else false.
+ */
+bool resource_info_file_exists(const char *resource,
+			       const char *feature)
+{
+	char res_path[PATH_MAX];
+	struct stat statbuf;
+
+	if (!feature || !resource)
+		return false;
+
+	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
+		 feature);
+
+	if (stat(res_path, &statbuf))
+		return false;
+
+	return true;
+}
+
 bool test_resource_feature_check(const struct resctrl_test *test)
 {
 	return resctrl_resource_exists(test->resource);
-- 
2.43.0


