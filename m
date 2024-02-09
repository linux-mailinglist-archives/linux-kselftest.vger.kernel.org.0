Return-Path: <linux-kselftest+bounces-4427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB084F662
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D4BB24CBA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0674EB23;
	Fri,  9 Feb 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcKI7y/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9E37147;
	Fri,  9 Feb 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487304; cv=none; b=bqf+LbBxRcLVK4eRP638kNETL3d0ImPRKYNA/76Xc8Wo7NblKqRjqDjj5wH2F1ahoSBJzLdYvd4H7GLJpfxXYhhtSR4QajBeL/hDZXhAR0ATF1KAMNuX6WLxQMxZn5sihVfbTvRTcY2KQ/c5wejO9SDKJkRvfv91kPx1L/P1czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487304; c=relaxed/simple;
	bh=x/Q+b8kyrZMmm2Xl3T6auY682+KEi1Ln5OJwND+72Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWKpELbwoOLfHL/YSzpN81pi2YbpXVOHeLFZplz3gEvzgEleYUWWWnfYZgPBnHrskDq71y1bGOcPhA29hHoLQwPi+8naSQKzU63j0vs9AD8CQ24U9dQQlqZPVmbpwXkh0LVh2iVjVfeFq62lWYAUidpgFARmehxLOjWy+t/YZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcKI7y/r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487303; x=1739023303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/Q+b8kyrZMmm2Xl3T6auY682+KEi1Ln5OJwND+72Ks=;
  b=CcKI7y/rwqgyy0qvH2kRwv3QS30ArJyZtHFQgwneYgnt4qr/j0NSaa2S
   Ta+41YXdkPkwq3a89FNmutVSM8+zaGrOblTPLqrnQ143ofKn7ZM6lyH95
   TH1GSMOA2dk0WUrXabQHKmbVfIt8KxtgqH4j8IchhDluDbW1fel6aAYw+
   v90aB7IRpwO17X8r+FZ4cKUwmK+7tpprEV7YXH5xlPS1S1szoGXAibk4q
   ZLHnpkMN13MIcHHEsa5zSNT2O8DXJfuAE1wU95HVB0SsYOxpqIn+2dgU4
   0GZZsS9b2uG2qnq2EQJQHr1Ksc/XivQntvTeu+0ZMHeEFeH8rKLdCn3I5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12801861"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12801861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2284446"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:39 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 2/5] selftests/resctrl: Add a helper for the non-contiguous test
Date: Fri,  9 Feb 2024 15:01:26 +0100
Message-ID: <42246fb33f396267431e8b5432554647179acc27.1707487039.git.maciej.wieczor-retman@intel.com>
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

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in kernel (resctrl). Then the
test compares if that information matches what is reported by CPUID
output.

Add a generic helper function to read an unsigned number from
/sys/fs/resctrl/info/<RESOURCE>/<FILE>.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changelog v5:
- Remove '\n' from ksft_print_msg() calls. (Ilpo)
- Add Ilpo's reviewed-by tag.
- Change 'helpers' -> 'a helper' in the subject.
- Change 'a file in' -> '' in patch message.
- Remove '*' from resource_info_file_exists()'s comment.
- 'saved into the @val' -> 'saved into @val'
- 'Error in opening' -> 'Error opening'
- Redo path in function comment.

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
index 5750662cce57..8a183c73bc23 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -249,6 +249,42 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * resource_info_unsigned_get - Read an unsigned value from
+ * /sys/fs/resctrl/info/@resource/@filename
+ * @resource:	Resource name that matches directory name in
+ *		/sys/fs/resctrl/info
+ * @filename:	File in /sys/fs/resctrl/info/@resource
+ * @val:	Contains read value on success.
+ *
+ * Return: = 0 on success, < 0 on failure. On success the read
+ * value is saved into @val.
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
+		ksft_print_msg("Error opening %s: %m\n", file_path);
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", val) <= 0) {
+		ksft_print_msg("Could not get contents of %s: %m\n", file_path);
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


