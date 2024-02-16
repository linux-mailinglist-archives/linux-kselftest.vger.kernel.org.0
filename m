Return-Path: <linux-kselftest+bounces-4843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E78577C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309B8B20BC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BA15E97;
	Fri, 16 Feb 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIrubDwB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8731B94D;
	Fri, 16 Feb 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072554; cv=none; b=LFgSjRgAhts54wEQ9emmjnVAywT1o6FlNX2DlvIJbU4d1RmCEl0s7JvJrwhbWiojTMQAAns9KSVDIpA30xJtYvNoadkhejQ10t/Q0C9aB6socEbeRrolnKmipuEXZXmJsCRkSKh91T52fn7c3jRZBtdXsGYsmXXQaXR8M5NyZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072554; c=relaxed/simple;
	bh=W0vo/v6Uk1nQ4rBgma0PVflw0bD5UeCWw/hfYrDFu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FERr9oGQ382n88JLvrV9OTaiNn2M02GTwniZ91HS/nOR5QC0Lww+PJjiqZv8SRRYvC+M/QovOetCtDXc+83DmBcxIxFh7aZmp8EHDdYtw34UpqKgkHy1VlydgH5bKE8tBs+Rhv0YyFB8gd9/V5i0KmnvFNx5R92bS7VLdbOsMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIrubDwB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072553; x=1739608553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W0vo/v6Uk1nQ4rBgma0PVflw0bD5UeCWw/hfYrDFu/Y=;
  b=MIrubDwBF38oIbSoyPtcOTIoFFyJTn3SLwtdf2yRvGLfX3d8s500q91x
   Vw+7xXTw5ZGcHfKcDmt7OV7MWDnBY1HZeqZZTw50RsPB02jO8CG6XjILP
   hGFLb4BG+Uc7XTs0nPLvfjuqM7B3aIaOxsCc+Sv79khWjwWelLblVrVq0
   9p82s+xc7O6zrdbj2Ax9HNu62ghQdpN952oreovl5l+V+npmVBcAnPwgp
   js5SjziztzKen4OE94Do5WGEmbmNFE7zszLz5kRBukYFMTZT7GewbhyMJ
   YT2Ot1rSyZZsh2yvtiXNK4E8UaUUqDCz3Yb6kCm8ECozca0zkzhYxQT4V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="24659570"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="24659570"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912327335"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912327335"
Received: from zprzybys-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:48 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 4/5] selftests/resctrl: Add resource_info_file_exists()
Date: Fri, 16 Feb 2024 09:35:41 +0100
Message-ID: <c32b59c8826216a0841d8499038fcc2e965927be.1708072203.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v6:
- Re-add function header to this patch.

Changelog v5:
- feature -> file. (Reinette)
- Redo return description and path in the comment. (Reinette)

Changelog v4:
- Remove unnecessary new lines.
- Change 'feature' -> 'file' to keep things generic. (Reinette)
- Add Ilpo's reviewed-by tag.

Changelog v3:
- Split off the new function into this patch. (Reinette)

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 6d99ed44ec60..f434a6543b4f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -138,6 +138,7 @@ int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *resource, const char *feature);
+bool resource_info_file_exists(const char *resource, const char *file);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1273e55c4a9d..1cade75176eb 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -764,6 +764,31 @@ bool resctrl_mon_feature_exists(const char *resource, const char *feature)
 	return !!res;
 }
 
+/*
+ * resource_info_file_exists - Check if a file is present inside
+ * /sys/fs/resctrl/info/@resource.
+ * @resource:	Required resource (Eg: MB, L3, L2, etc.)
+ * @file:	Required file.
+ *
+ * Return: True if the /sys/fs/resctrl/info/@resource/@file exists, else false.
+ */
+bool resource_info_file_exists(const char *resource, const char *file)
+{
+	char res_path[PATH_MAX];
+	struct stat statbuf;
+
+	if (!file || !resource)
+		return false;
+
+	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
+		 file);
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


