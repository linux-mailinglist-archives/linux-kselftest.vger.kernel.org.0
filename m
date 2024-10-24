Return-Path: <linux-kselftest+bounces-20577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBA79AF44E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28171F21E5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885CD21730E;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpFoeMjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A82178F4;
	Thu, 24 Oct 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804086; cv=none; b=E6QVtjBlTo7YzzGA8dOLWr2+PfCgtf6eu7vGLXhdERJoaSwrjL1JU/OvQKE2K6BF46Ln2wfZlJFLJWTqHLa9i8dEyTqI8jZmeHh3KHBpyWbL0DM0wHI8BiyUvvL1/7Zx6XUP+4thnYYENu2wxCKsAhiTU5b18CEu04GI2z1xvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804086; c=relaxed/simple;
	bh=8igkGI9MOLwE1u4y4oKvZ2ckKq/pi4qsR/V3GdFGBdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/0v3cAXHghpSeV+6SblOKCuR0TLAsdw0xiyLwmXNd0TYJxznocGY7drhKx8KUZwYpYgNXmXq8+4NI8HuydJ4yhyaa6yyvJvbgl8CvH8iT2HqIkgUFRN8wCF2e2z3HgHiBcb0xwfmlAMynns0Jk3zXq0IvohYuOai0OLPGPBUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpFoeMjb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804084; x=1761340084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8igkGI9MOLwE1u4y4oKvZ2ckKq/pi4qsR/V3GdFGBdM=;
  b=FpFoeMjbjI4pj9wZYOIdnZO1c9helsSH75YllEDZYZAmMny26Zp1KE2l
   yh01vaf0hU+fzjqVtk4vCw2ffzrndyIUwlBExkb8ohKwhBVlK41pgSl6V
   j3yEcR1LX61WCaMgD90EnSkU7bUJcDT/UUV6UjmrQxiAT+yAavgfwrS5I
   0h8/qe3W0jzPatf1B6xWim1veCEEIUAN7u04EuYub+BsQ/0v5OTGLfITD
   REmqqehERFVFYB4fkhTrHbVZJNorGBJiQ7sjEgxyL5HcpoGxaHHKMSbnC
   C2baEe0gNLXGFmpthozQkbUzOwt3wZVyLu7ZKsxWhwnSAbLywRzsFZwN5
   w==;
X-CSE-ConnectionGUID: kUn6JhIfRqW8dHXwPbqMbw==
X-CSE-MsgGUID: cxq3mvxKRtiNLm4kocCkow==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090892"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: eB/4x2gRShSQmgSSkulvyw==
X-CSE-MsgGUID: OPEcho7IQ0SrduZcKQWWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488029"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
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
Subject: [PATCH V4 04/15] selftests/resctrl: Protect against array overrun during iMC config parsing
Date: Thu, 24 Oct 2024 14:18:41 -0700
Message-ID: <cb96fb9ac4dd8b5235f05fc1ef5706bf78e95096.1729804024.git.reinette.chatre@intel.com>
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

The MBM and MBA tests need to discover the event and umask with which to
configure the performance event used to measure read memory bandwidth.
This is done by parsing the
/sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_read
file for each iMC instance that contains the formatted
output: "event=<event>,umask=<umask>"

Parsing of cas_count_read contents is done by initializing an array of
MAX_TOKENS elements with tokens (deliminated by "=,") from this file.
Remove the unnecessary append of a delimiter to the string needing to be
parsed. Per the strtok() man page: "delimiter bytes at the start or end of
the string are ignored". This has no impact on the token placement within
the array.

After initialization, the actual event and umask is determined by
parsing the tokens directly following the "event" and "umask" tokens
respectively.

Iterating through the array up to index "i < MAX_TOKENS" but then
accessing index "i + 1" risks array overrun during the final iteration.
Avoid array overrun by ensuring that the index used within for
loop will always be valid.

Fixes: 1d3f08687d76 ("selftests/resctrl: Read memory bandwidth from perf IMC counter and from resctrl file system")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Rephrase changelog. (Ilpo)
- Add Ilpo's Reviewed-by tag.

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/resctrl_val.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 70e8e31f5d1a..e88d5ca30517 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -83,13 +83,12 @@ static void get_event_and_umask(char *cas_count_cfg, int count, bool op)
 	char *token[MAX_TOKENS];
 	int i = 0;
 
-	strcat(cas_count_cfg, ",");
 	token[0] = strtok(cas_count_cfg, "=,");
 
 	for (i = 1; i < MAX_TOKENS; i++)
 		token[i] = strtok(NULL, "=,");
 
-	for (i = 0; i < MAX_TOKENS; i++) {
+	for (i = 0; i < MAX_TOKENS - 1; i++) {
 		if (!token[i])
 			break;
 		if (strcmp(token[i], "event") == 0) {
-- 
2.47.0


