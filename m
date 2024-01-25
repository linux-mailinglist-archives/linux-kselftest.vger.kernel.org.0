Return-Path: <linux-kselftest+bounces-3558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D353483C092
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125481C21088
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CB405F9;
	Thu, 25 Jan 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkoI9W8M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DF51C20;
	Thu, 25 Jan 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181075; cv=none; b=ftXSwv2feydq3QG2go/H/0QdeDi/bhxTgMjxRRm26unpin85tr8zmxlKmRaMFuOZ/848pn1kL4XLGYPAiRwi2FvK918Tpo/ICzcaDHHaCpIDDg3m+1RZApKjY+27y/4gd8tgpnma06UJs3RyzeM7eujWTwlEx9LZkLbU98Wq0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181075; c=relaxed/simple;
	bh=33NHf8hKMsj/l+cEJaT9H1sPZXBn7CyH0lKsCXmRwnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBiiepnmm8KvuzurBWcvCORJyf63cyDSGj/YXT9o5dAgGxsCqLLAdkRshTuAeyJnsOX2kqWxxAZFX+CVWdNGt52nnDsH45GsWniAGQadAl8sg3T9p2PVffFiooJOgNMa8lzjEgMB1+lvvvH0oa4eKs5JhkNktuVJeFxClnKEceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkoI9W8M; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706181074; x=1737717074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=33NHf8hKMsj/l+cEJaT9H1sPZXBn7CyH0lKsCXmRwnY=;
  b=RkoI9W8Mz63QrjvG0brad1lZBbN6GfOeMDx/c0mMn40K0aeDT6FPfhKX
   BNkMAuK86Rp76B6PSrKSQ+ABUrblXjHHsOQGUZM0FtXKtO6CGXt4QJH5Q
   yCNflk1ywWurGCDcQUdxWZXUxZobJhQOmBlKuF9ohSx3mqVFrbkH0C4MO
   7lPg8bO0X88L0pwfHr3AkSXVFrCyf9E+DuHf9ItRkStgYRzbLPxlQbgI6
   bLF+Be1HV3wvEOt+Ds04jRuFs6vPuQBhA6IWh9BTMxCj4gI1vJm4NbzA+
   HzN14ptn+VOj9tnPPf+Xy5kN6eoGpKPUJOumnWPjhtJawvvUDUb267wym
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="433286699"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433286699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736286620"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736286620"
Received: from apejovix-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:11:10 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 2/5] selftests/resctrl: Add helpers for the non-contiguous test
Date: Thu, 25 Jan 2024 12:10:55 +0100
Message-ID: <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
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

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in kernel (resctrl). Then the
test compares if that information matches what is reported by CPUID
output.

Add a generic helper function to read an unsigned number from a file in
/sys/fs/resctrl/info/<RESOURCE>/<FILE>.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- Rewrite patch message.
- Add documentation and rewrote the function. (Reinette)

Changelog v2:
- Add this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 39 +++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index 5750662cce57..cb5147c5f9a9 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -249,6 +249,45 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+/*
+ * resource_info_unsigned_get - Read an unsigned value from a file in
+ * /sys/fs/resctrl/info/RESOURCE/FILENAME
+ * @resource:	Resource name that matches directory names in
+ *		/sys/fs/resctrl/info
+ * @filename:	Filename of a file located in a directory specified with the
+ *		'resource' variable.
+ * @val:	Variable where the read value is saved on success.
+ *
+ * Return: = 0 on success, < 0 on failure. On success the read value is saved into the 'val'
+ * variable.
+ */
+int resource_info_unsigned_get(const char *resource, const char *filename,
+			       unsigned int *val)
+{
+	char reason[128], file_path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
+		 filename);
+
+	fp = fopen(file_path, "r");
+	if (!fp) {
+		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);
+		ksft_perror(reason);
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", val) <= 0) {
+		snprintf(reason, sizeof(reason), "Could not get %s's contents\n", filename);
+		ksft_perror(reason);
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


