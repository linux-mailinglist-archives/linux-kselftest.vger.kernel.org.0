Return-Path: <linux-kselftest+bounces-4132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728F8499C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9D3284AB9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623AB1CAB5;
	Mon,  5 Feb 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGoVe3yL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D51CA80;
	Mon,  5 Feb 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134899; cv=none; b=CsGjBdPST871O11yhpJV+kq88y0mYl3Z/d5hjxAc7R/ssxFemayTS+iJqOG2D+O27ucW0kMrne4mpo4+waOPqZGXvBS+AXYsPV6A5EssMuOonAIyXC6wOFzByixrM8b5LENDhWxbc3HljklLcelKrb4MCaTnjVMUSJUaqV/MSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134899; c=relaxed/simple;
	bh=7r1XFDaCnI9MkS8JseK//5PXg1aXB5L85EJYF7/bgVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P13FcJ7l0bm/dgvbpAk5aWbQYRT9cYeCKNK3MPmO0OMjAOYM2hM8kVs0EmgtlLvsm2oAaDM4l8rEG1+bRDKQlNCNxvAyYn2/QGojtRDDXJWmuRz5dPtKKQpL0mwTmEL4Nz40MgNvQq34spS5bpNq3lgPpzqeDfjQebloXecjou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGoVe3yL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134897; x=1738670897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7r1XFDaCnI9MkS8JseK//5PXg1aXB5L85EJYF7/bgVc=;
  b=FGoVe3yLHUvPND94Ngs2s2VsL6YbWKZqptBokczhUofLCdRX/5MhU0Ui
   50PjPqpMVeWJjvVS8bC0CwoU6aVhXpE/mn5E5/y82MKEb9AtQ7eXaGzpb
   IbcWJUVfId+FNP7k5PKuOiUfMcJp6QjBcy/yv4KAbY3QhSzA0Qfn7FWwK
   dU2cYKpdCgj63FBT17Hanm6beDPMkhiJkKhH31Tz8s4fL9zMS6FC1IGJW
   tx2C/0RWOUqXRxyRZXZ0zWlhFuYzcm8p1LhnsaE9CeUXZN5y0DmLJR9Ow
   PNptOTIlYzjZ7sZ4ujjnwiPAbFEKZ2oIYEm2DjwhTu9MgPQuWDZ9WJS2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25954444"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25954444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="908485"
Received: from snestero-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.21.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:08:13 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	reinette.chatre@intel.com,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 2/5] selftests/resctrl: Add helpers for the non-contiguous test
Date: Mon,  5 Feb 2024 13:08:03 +0100
Message-ID: <89b8965d563e4e61b95b20be55c26475d830b245.1707130307.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in kernel (resctrl). Then the
test compares if that information matches what is reported by CPUID
output.

Add a generic helper function to read an unsigned number from a file in
/sys/fs/resctrl/info/<RESOURCE>/<FILE>.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v4:
- Rewrite function comment.
- Redo ksft_perror() as ksft_print_msg(). (Reinette)

Changelog v3:
- Rewrite patch message.
- Add documentation and rewrote the function. (Reinette)

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index a1462029998e..5116ea082d03 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
+int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5750662cce57..e0fbc46a917a 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -249,6 +249,42 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+/**
+ * resource_info_unsigned_get - Read an unsigned value from
+ * /sys/fs/resctrl/info/RESOURCE/FILENAME
+ * @resource:	Resource name that matches directory name in
+ *		/sys/fs/resctrl/info
+ * @filename:	File in /sys/fs/resctrl/info/@resource
+ * @val:	Contains read value on success.
+ *
+ * Return: = 0 on success, < 0 on failure. On success the read
+ * value is saved into the @val.
+ */
+int resource_info_unsigned_get(const char *resource, const char *filename,
+			       unsigned int *val)
+{
+	char file_path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
+		 filename);
+
+	fp = fopen(file_path, "r");
+	if (!fp) {
+		ksft_print_msg("Error in opening %s\n: %m\n", file_path);
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", val) <= 0) {
+		ksft_print_msg("Could not get contents of %s\n: %m\n", file_path);
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+	return 0;
+}
+
 /*
  * create_bit_mask- Create bit mask from start, len pair
  * @start:	LSB of the mask
-- 
2.43.0


