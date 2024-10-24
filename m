Return-Path: <linux-kselftest+bounces-20579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF19AF455
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137711F22324
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134B218D79;
	Thu, 24 Oct 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOo4+yMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DA189F3E;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804088; cv=none; b=hxAdQ9KJ17AKd9e0uYhN6ee81chZG3bJLjw/CyvqbSo3ATUUzAMSk8SNW/lPrJUd3kil8byTKxOqBUTd52Nv4NC1eYS3KcGe0o5lqVS8tlT6FwTyjMnziLQ6UHZlZFU9bz0WlLtmBZWfrVy5kYEfcuyzZCkvL3cEIvjDGKI4vYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804088; c=relaxed/simple;
	bh=7BFETFF+Lrhf1bsYmQmPo4keg+4a9mpHorYCi83s0Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMuw4A71OqyoK1PjvqGNIZhwLwHNaNqRfMHeAyKhq6w32t1sr7dOzbFZOdRcH5Uq54QoVcjE3hQDB7KMSNAXtDIxQ9gX0sb/v+EHhGdAJt2fTzewUc7gV3RjubCPuzPecSePMrbQH3nNgo09aQpRZ3/aNty4W4kvrI3fMgjBiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOo4+yMn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804086; x=1761340086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BFETFF+Lrhf1bsYmQmPo4keg+4a9mpHorYCi83s0Ww=;
  b=IOo4+yMnhjQfHchi6ElN+dDW3Q6v6hEWz9gYSHqjOl2nNa2gy3NojCgm
   G/CAZUrFyYo7wFCcZNnVkVfMuMuTac4WEBsoGEJ+GAlwWEMNhOtJXkBqI
   38KWby8GbGZfKtJQk82eHLTT6Viqvfm6RVU4JemCFH5mW6RYpcsh0ubdi
   kd4cc6fhm3LC9eyVnzqkN/T6lUzvFGC8VpAWPJN2fq+qv0XNuSJQgQKQw
   RWTnI9ig7nvXsUxN0vg5qgYEVhhVLIm0zxPYvMfowq6SOhJMYS2LmCxSo
   yRipl38RhN1uRwo6Y2eXTbcdlo3Ds0FACTNIr7B6AYrfFhjkjBURjMbyS
   w==;
X-CSE-ConnectionGUID: 03BM610MRke62VyUUNTO3w==
X-CSE-MsgGUID: zRRxaJ0+S6afT5xuaxabEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090899"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: 8yXDKXrCQw+3P0eLxSdP4A==
X-CSE-MsgGUID: 3ujS6rGhRGqK3Sn3YBsZbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488033"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 05/15] selftests/resctrl: Protect against array overflow when reading strings
Date: Thu, 24 Oct 2024 14:18:42 -0700
Message-ID: <96c86bb56a520945eee493a938161f50549ce6a5.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

resctrl selftests discover system properties via a variety of sysfs files.
The MBM and MBA tests need to discover the event and umask with which to
configure the performance event used to measure read memory bandwidth.
This is done by parsing the contents of
/sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_read
Similarly, the resctrl selftests discover the cache size via
/sys/bus/cpu/devices/cpu<id>/cache/index<index>/size.

Take care to do bounds checking when using fscanf() to read the
contents of files into a string buffer because by default fscanf() assumes
arbitrarily long strings. If the file contains more bytes than the array
can accommodate then an overflow will occur.

Provide a maximum field width to the conversion specifier to protect
against array overflow. The maximum is one less than the array size because
string input stores a terminating null byte that is not covered by the
maximum field width.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
This makes the code robust against any changes in information read
from sysfs. The existing sysfs content fit well into the arrays, thus
this is not considered a bugfix.

Changes since V3:
- Add Ilpo's Reviewed-by tag.

Changes since V2:
- New patch
---
 tools/testing/selftests/resctrl/resctrl_val.c | 4 ++--
 tools/testing/selftests/resctrl/resctrlfs.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index e88d5ca30517..c9dd70ce3ea8 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -159,7 +159,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
 
 		return -1;
 	}
-	if (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+	if (fscanf(fp, "%1023s", cas_count_cfg) <= 0) {
 		ksft_perror("Could not get iMC cas count read");
 		fclose(fp);
 
@@ -177,7 +177,7 @@ static int read_from_imc_dir(char *imc_dir, int count)
 
 		return -1;
 	}
-	if  (fscanf(fp, "%s", cas_count_cfg) <= 0) {
+	if  (fscanf(fp, "%1023s", cas_count_cfg) <= 0) {
 		ksft_perror("Could not get iMC cas count write");
 		fclose(fp);
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 250c320349a7..a53cd1cb6e0c 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -182,7 +182,7 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 
 		return -1;
 	}
-	if (fscanf(fp, "%s", cache_str) <= 0) {
+	if (fscanf(fp, "%63s", cache_str) <= 0) {
 		ksft_perror("Could not get cache_size");
 		fclose(fp);
 
-- 
2.47.0


