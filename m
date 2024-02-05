Return-Path: <linux-kselftest+bounces-4134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABA8499CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC72831C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011F1CABB;
	Mon,  5 Feb 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7mTtuZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1361CD2E;
	Mon,  5 Feb 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134927; cv=none; b=ZbdyP7Tl5vhfLBl5ff1yOTZsdDdTkb7W2bvclGSuP2dtSr18pUOfBWTdJ8Ey3ai9HIOZGDI7H7YO1NJRAnw5AQ+CpXDtMHIPs5dizNkAcU4btNkv2qYdXrN9wUoOJwFJ7evGzwWCNo6LFegT8zfbgZf9iHFuUylX6eROll1FAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134927; c=relaxed/simple;
	bh=cQXt66XNAxdPbuQ3HHleM5aXlSZ96lSuJgWfQYcNYtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc//MgJ3WrdaclgsCkpczJf0CXSA7lhTimHvAncX6bvBs5lRHgp1KtoqiCN9jw3cIaBZalPmQXlTa0ZBPXBeSPXuMHRT1vJFRglyvn/JQJu6GmXGangBaSgIwXZouYyvPcpxz9Fo8c9xs9/OeWJv5L0yMUa8XCeUN5dVdr0LcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7mTtuZC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134926; x=1738670926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQXt66XNAxdPbuQ3HHleM5aXlSZ96lSuJgWfQYcNYtk=;
  b=P7mTtuZCC5CkGcsyw3boOXRKBhDh6Y/xpWe1s98j+ab87HXMRdDvVSJi
   eVpWJ81X8+O1n9xnko5yICOzAxl8+C9tv58146CpJOA4+5WrvLXJa1ALv
   S6S2xmgDPSDgEibjTiErTl5L8NkC1imJtBRad9OzIZw7nGoBJbEggizTO
   YdY/RJxM8POWKNdrlFkgHRkZdWLkLE4L2bnYQ1o4OewGNDwgm4lgyzJIK
   e9CTvLE7oHJfu4NsvHikB2bKqtk+Kj11VMS0mEwise8cOzrD53QjYmzh9
   oclICfrIMq2nzJNozvgzq2IRz1dykT5c+xJfXTArEaG0grC0jcQJPf3xn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="4303552"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4303552"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5445990"
Received: from snestero-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.21.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:41 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 4/5] selftests/resctrl: Add resource_info_file_exists()
Date: Mon,  5 Feb 2024 13:08:31 +0100
Message-ID: <9c38bb317d4246182f87e376926b61adbb7e20fd.1707130307.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
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
index 4603b215b97e..2b9a3d0570c7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -138,6 +138,7 @@ int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool resctrl_resource_exists(const char *resource);
 bool resctrl_mon_feature_exists(const char *feature);
+bool resource_info_file_exists(const char *resource, const char *feature);
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 0cfec8bb23fd..6a3082ca58b5 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -760,6 +760,31 @@ bool resctrl_mon_feature_exists(const char *feature)
 	return !!res;
 }
 
+/*
+ * resource_info_file_exists - Check if a file is present inside
+ * /sys/fs/resctrl/info/RESOURCE.
+ * @resource:	Required resource (Eg: MB, L3, L2, etc.)
+ * @file:	Required file.
+ *
+ * Return: True if the file exists, else false.
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


