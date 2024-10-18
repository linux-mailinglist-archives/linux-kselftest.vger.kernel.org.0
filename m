Return-Path: <linux-kselftest+bounces-20091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E209A32B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987F61C2381B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386318132F;
	Fri, 18 Oct 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzN6YK2f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726F17C21C;
	Fri, 18 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218162; cv=none; b=KQUyW1tNdNuIpHQOpVRTYHh1cbnkwS02DwFCZvkCLYWfnNnn4KQUfPswGrbXpybo0qRflAu/wbOyMwlbXAaHww7dVBL5909MZlgqfg1leTiBBsvA61tVu2SIxkGv0ga8sjuWXCJzbyT5032TTst81KRL/5i1bmcrx05GEW0eZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218162; c=relaxed/simple;
	bh=cwi+GNrykzBZWK3vNEOThjGdwWrEwDOu0Vqo1PrdesE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOBHnxYdBo3Fx8A7TZm8Y2whlJ+x0R03l5CKf+B2s6T+GDdzOdfX19XKQmp4PzYvX8WaHUV0pYexESTjBd9bz1cpuQ7FDLXsrU/KIToGq39kYZD5SKDXQBW5xrtMKUygJkrOxr++OttkOEEYrb1v07CKcA5ORsXxk2rCBBZE0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzN6YK2f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218161; x=1760754161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwi+GNrykzBZWK3vNEOThjGdwWrEwDOu0Vqo1PrdesE=;
  b=SzN6YK2fdXzbe4i3ME19hPLCkwx8E/pBAiv7JAApWrV83/Mj1Ov6OYCj
   kZ5s/VHKy7AqZgXFp06MiXrpFkmyuu+DVClMUvw2c+wfVzzkmDffg68my
   ox2IAkGnqzRb8ztQtKYucKn3zKYPjAhwO10MJOxFE+/LHng4eUIHdtEIN
   FyGnW5X8GjW22saLXYgSHXNJYDAEeHRPRvhlQl3YF26IFkxQzeTemCwg9
   9m2HWWQyMl/TZQhi+YXH2wlr1iDxzNO5oV+ZftK5UnnmikbSJs6hr31RU
   /crl/oCWwz8xPdrUqfjFExK5P724NzTb63cQHqNLviSPgH+Zw4dt7eraq
   w==;
X-CSE-ConnectionGUID: 9nj3zLboQ8+LigpJGcbzPQ==
X-CSE-MsgGUID: rfJlyb+LTOa0g93RF+Xbcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149695"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149695"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: SdtlWhQlRLuka4srtVWbjA==
X-CSE-MsgGUID: Fc/YGfGdRPCg4lu9BTXX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697711"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 05/15] selftests/resctrl: Protect against array overflow when reading strings
Date: Thu, 17 Oct 2024 19:33:20 -0700
Message-ID: <4adf01b3ee7019163ea4fc00b5d03d514d41b4b7.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
This makes the code robust against any changes in information read
from sysfs. The existing sysfs content fit well into the arrays, thus
this is not considered a bugfix.

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
2.46.2


