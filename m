Return-Path: <linux-kselftest+bounces-4430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA3784F668
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE22CB245C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADC657B5;
	Fri,  9 Feb 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbgpae4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76157326;
	Fri,  9 Feb 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487353; cv=none; b=HZnw6IXNq6HWXINtrd9OQYTIcJ40VA9XStC/6/2f4C9ozw1VhFEpdXO8dWJ++AW2V3rtycbZc8AnyOM6+CZA6CcP3PwzViAQIXZiCRRmU1TIhks7S19kOMa+ImD3inCnI8AL7khFLGYjaNyCRBEj4nO6Pd5LrXIJGk3FdwfpTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487353; c=relaxed/simple;
	bh=K6rMMQZvXeXM/c2DLOoBYHOlEwO+LI0vLpSgjCF0MuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGLC3ReKZyoCafNFDO/mdBcuetAgQI3p96kX522K5nHZ6R1FlOqtCL8/34T+R6x7CTgRMI/OFCuZuKY04Krw5PQM4V/iMSMWeCDF7DyHboC1abDc0c23CZkW245Bn6F7aIFeBuam/Xp9RhcVe+YyfF9GGSj7WNDYirpvh9ywOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbgpae4/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487352; x=1739023352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6rMMQZvXeXM/c2DLOoBYHOlEwO+LI0vLpSgjCF0MuA=;
  b=lbgpae4/7ZA3SRc0b7PMn5ohVWISk5IOQiN1ftIPZ5PoEOpLIfmZFUSH
   1jvWDPG9Cj2EUQwiJGxWfwR+1SSWmIrgVQ0RNU1+/SLmci1OPxyd1/hUc
   bQuKJIgMW+y+1iR6bclVu5wOib0FZ/DBLk3oJ/AKbWMUZszEJ/36nKJxL
   +7Ou45VCOKsicrnT8jV0gP6xriYd98bP42CzUEC95o/NrRUTkA1KFcF5f
   FlkmnzbMbHtL/OWsR0pkJ5NbV2CD+vNVbwp2lsB6iYWIO2+1UEd24Jtut
   HjJ86QM/CWLxHuguQ+SVP3GfcaAzfbf+AchMe+3LdyCtIvx6KwhxYI6X9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1328896"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1328896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6596724"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:02:29 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 5/5] selftests/resctrl: Add non-contiguous CBMs CAT test
Date: Fri,  9 Feb 2024 15:02:18 +0100
Message-ID: <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for both L2 and L3 CAT to verify the return values
generated by writing non-contiguous CBMs don't contradict the
reported non-contiguous support information.

Use a logical XOR to confirm return value of write_schemata() and
non-contiguous CBMs support information match.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v5:
- Add Reinette's reviewed-by tag.
- Make 0xf UL in case the CBMs get bigger in the future. (Ilpo)

Changelog v4:
- Return failure instead of error on check of cpuid against sparse_masks
  and on contiguous write_schemata fail. (Reinette)

Changelog v3:
- Roll back __cpuid_count part. (Reinette)
- Update function name to read sparse_masks file.
- Roll back get_cache_level() changes.
- Add ksft_print_msg() to contiguous schemata write error handling
  (Reinette).

Changelog v2:
- Redo the patch message. (Ilpo)
- Tidy up __cpuid_count calls. (Ilpo)
- Remove redundant AND in noncont_mask calculations (Ilpo)
- Fix bit_center offset.
- Add newline before function return. (Ilpo)
- Group non-contiguous tests with CAT tests. (Ilpo)
- Use a helper for reading sparse_masks file. (Ilpo)
- Make get_cache_level() available in other source files. (Ilpo)

 tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  2 +
 3 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 39fc9303b8e8..d4b7bf8a6780 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 	return ret;
 }
 
+static int noncont_cat_run_test(const struct resctrl_test *test,
+				const struct user_params *uparams)
+{
+	unsigned long full_cache_mask, cont_mask, noncont_mask;
+	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
+	char schemata[64];
+	int bit_center;
+
+	/* Check to compare sparse_masks content to CPUID output. */
+	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
+	if (ret)
+		return ret;
+
+	if (!strcmp(test->resource, "L3"))
+		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
+	else if (!strcmp(test->resource, "L2"))
+		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
+	else
+		return -EINVAL;
+
+	if (sparse_masks != ((ecx >> 3) & 1)) {
+		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
+		return 1;
+	}
+
+	/* Write checks initialization. */
+	ret = get_full_cbm(test->resource, &full_cache_mask);
+	if (ret < 0)
+		return ret;
+	bit_center = count_bits(full_cache_mask) / 2;
+	cont_mask = full_cache_mask >> bit_center;
+
+	/* Contiguous mask write check. */
+	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
+	ret = write_schemata("", schemata, uparams->cpu, test->resource);
+	if (ret) {
+		ksft_print_msg("Write of contiguous CBM failed\n");
+		return 1;
+	}
+
+	/*
+	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
+	 * Output is compared with support information to catch any edge case errors.
+	 */
+	noncont_mask = ~(0xfUL << (bit_center - 2)) & full_cache_mask;
+	snprintf(schemata, sizeof(schemata), "%lx", noncont_mask);
+	ret = write_schemata("", schemata, uparams->cpu, test->resource);
+	if (ret && sparse_masks)
+		ksft_print_msg("Non-contiguous CBMs supported but write of non-contiguous CBM failed\n");
+	else if (ret && !sparse_masks)
+		ksft_print_msg("Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected\n");
+	else if (!ret && !sparse_masks)
+		ksft_print_msg("Non-contiguous CBMs not supported but write of non-contiguous CBM succeeded\n");
+
+	return !ret == !sparse_masks;
+}
+
+static bool noncont_cat_feature_check(const struct resctrl_test *test)
+{
+	if (!resctrl_resource_exists(test->resource))
+		return false;
+
+	return resource_info_file_exists(test->resource, "sparse_masks");
+}
+
 struct resctrl_test l3_cat_test = {
 	.name = "L3_CAT",
 	.group = "CAT",
@@ -301,3 +366,19 @@ struct resctrl_test l3_cat_test = {
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
 };
+
+struct resctrl_test l3_noncont_cat_test = {
+	.name = "L3_NONCONT_CAT",
+	.group = "CAT",
+	.resource = "L3",
+	.feature_check = noncont_cat_feature_check,
+	.run_test = noncont_cat_run_test,
+};
+
+struct resctrl_test l2_noncont_cat_test = {
+	.name = "L2_NONCONT_CAT",
+	.group = "CAT",
+	.resource = "L2",
+	.feature_check = noncont_cat_feature_check,
+	.run_test = noncont_cat_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f434a6543b4f..2051bd135e0d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -209,5 +209,7 @@ extern struct resctrl_test mbm_test;
 extern struct resctrl_test mba_test;
 extern struct resctrl_test cmt_test;
 extern struct resctrl_test l3_cat_test;
+extern struct resctrl_test l3_noncont_cat_test;
+extern struct resctrl_test l2_noncont_cat_test;
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3044179ee6e9..f3dc1b9696e7 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -19,6 +19,8 @@ static struct resctrl_test *resctrl_tests[] = {
 	&mba_test,
 	&cmt_test,
 	&l3_cat_test,
+	&l3_noncont_cat_test,
+	&l2_noncont_cat_test,
 };
 
 static int detect_vendor(void)
-- 
2.43.0


