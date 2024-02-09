Return-Path: <linux-kselftest+bounces-4429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95884F666
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503221C248FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8525730A;
	Fri,  9 Feb 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZuqxKSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D444F896;
	Fri,  9 Feb 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487339; cv=none; b=r+NBoeYIDdHuZOR38UPmxZk5TI2fB2FiFgytxthJVwGLqaIexQwqxaiXTgZfp2eiefFnTW9XfubMFGqgK0toJ7T/3/K7sYUA9irh800XfyL5ab0u3oAZBH7GUw/E6teyi0UIVp7iqRjvojEnUQ9fL3ynUaxAdfP40O0Lx3G6PoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487339; c=relaxed/simple;
	bh=fDcuvxUGfdeYto3CEUVfGG+0DKqciD1V5YbuX8YWUjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJsvzg//xmVWst/qRyow7J9ucxYtZ555XIjXhGdqnW3EAFrvGScLoGe8McAYofX7Ju4CzzKVOmzl+5ag9f3FuWR5k5YHfzFuww7PBhhJKqiNxD6SWrqAh982PuGee97JB8f8KUIqEzvdVIEkp6zePSWOq2Ym9SJXCnDrAt+kvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZuqxKSc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487338; x=1739023338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDcuvxUGfdeYto3CEUVfGG+0DKqciD1V5YbuX8YWUjE=;
  b=nZuqxKScB5bf6KleCa7uSN6598gmriC6BpOyUUCQof7Fyy7TLficAOA4
   oNYSjLynEV0Z8LWDgpQmR5gVCIQ1P7bTyKBBIfbiju06QeqbSjQP/2rDI
   bCf5ERch+5yW5CmcZoYM5ixQQOisDiwDsLpS5nzAr3+wYV6nqXeD3Xex9
   55whI6KUe9MtprbbaY/V67N7kko6TeC3WSUQQYP585FdymF18dYPUTPxx
   CieOSZggbPTx2p+/LVBq4NvX+T/YYVBZmmXf/iTo12QH/BrqlLR0AO2Nx
   H0ZBXRiYuJNLFvktGzDvqByvEb4hjXRhAQiyJVu5hNlONTLK1gEdAc9Hq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1744520"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1744520"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2245130"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:02:15 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 4/5] selftests/resctrl: Add resource_info_file_exists()
Date: Fri,  9 Feb 2024 15:02:01 +0100
Message-ID: <a2cc9ebaa216f7cc0782c2f112ce79bdd5ba2205.1707487039.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
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

 tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index af4f800ab23d..0e930fc06ab5 100644
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


