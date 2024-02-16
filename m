Return-Path: <linux-kselftest+bounces-4842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F288577BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 09:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BE12852B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1318EBF;
	Fri, 16 Feb 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0ULAI6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF01AAAE;
	Fri, 16 Feb 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072544; cv=none; b=HIxlHNa8/1kSSpt3Y5+KmOUDeZDmyyeyrri5+N//GsGvKRjwPoq9rKAlgbdQlnTXmSn6h+i4ttMQSDLy/so4F7Xm/0soNmedFR46SU8oy3H7KK396Z5ATqEV9V3PTt6hhdthKeQcRADje7HiOZNDuhVAl+AEKFCjD06R3DbSdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072544; c=relaxed/simple;
	bh=eb6oMWxovdClVKcP/LZ6mujjnKJLR61wsG0L6yxfoq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2ouTrx5bDdTuc7Ix1UtMcu+qef6t0G//izPiVUFzjyNxESnIrQ1pnbBkbYj+tpfxszT1mEOMJ5VSOoC7DBXMrQil9MUhXcE/NKUSK3CW1+xlJTjsnhw75w/zRSiA4BjCYGyW4wd1G1xOeOlKKSjc8GmyS2uzhI/5pbDibrpmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0ULAI6r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708072542; x=1739608542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eb6oMWxovdClVKcP/LZ6mujjnKJLR61wsG0L6yxfoq8=;
  b=U0ULAI6rq+rZopWz/hOVXC3vqQPU/tLaFQPsbkX0Qqx27HbrG2UbpBJQ
   p8plyzPyICUwiRfmDY9Bex25PCt87CdWK27M4uja+CR7oTtJiadu/cFx9
   SiKwGWEu9rJiJhXJ92Ygzj9APGQ2eKNJ0EuT3Qy83GcOjeySvbyb9vfM8
   ZuNHoLVMlZPTlOdIsSqpgTU44RjQfUrowhjrwAKMu773acn6ISf+VGm7J
   ZSYD7Ae9UPS18Ko4LMUFoWViUm4V/UR7p/5jHZ0JcVCU43K4VPU+PGlwi
   XQpDobONaSPqUF/1v1m7Xv+6wWLIZggrqtZoE7PghdZIJea5PvD62rIpe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="24659507"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="24659507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912327300"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912327300"
Received: from zprzybys-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:35:25 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 2/5] selftests/resctrl: Add a helper for the non-contiguous test
Date: Fri, 16 Feb 2024 09:35:15 +0100
Message-ID: <e5e4d0acdf42b6652266c9f245cf749c69a9f4ca.1708072203.git.maciej.wieczor-retman@intel.com>
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

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in kernel (resctrl). Then the
test compares if that information matches what is reported by CPUID
output.

Add a generic helper function to read an unsigned number from
/sys/fs/resctrl/info/<RESOURCE>/<FILE>.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v6:
- Add Reinette's reviewed-by tag.

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


