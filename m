Return-Path: <linux-kselftest+bounces-17857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0F976FFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01201C2341F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD001C0DC7;
	Thu, 12 Sep 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URR0smUo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6B1BF81D;
	Thu, 12 Sep 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164297; cv=none; b=WAGiieN9KdM6Tf+0Kmd0zQPn50cYu32vtgqaaJvonhmxQh3eHCsfPLnaFajPoh887AsKw/Oikd7El4JU+dq3O4wFr8kwdB86dBrM10jR02ZZ+xpFz4yjTZAKoC260H+GDJ0dA19Ls/LjQ8LCWtw2as/2wDfV2O8Rk1iRvim7rxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164297; c=relaxed/simple;
	bh=Vb6zyOzim1npQb7wI5cEfqF7g7w9rDJNBCyNthUbBX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttcU/HiHtwUA7W4vY19Dm3hEHBoew+ZZhVDw2LXnctRxpGIYFJHz7VQkN4KBJ6zojnsEOJXF7c9541brsErM7+0fQJrgLa/Udsf9fU58QI2y4EOYHOaIe3q8rSPNdg+lAmXrAtWEDTiz0RvwTEHKHdQLcuZwyOCCMgGENLqrogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URR0smUo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164296; x=1757700296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vb6zyOzim1npQb7wI5cEfqF7g7w9rDJNBCyNthUbBX4=;
  b=URR0smUoKRB0Mtqb3+xSpY5na+RF+P+nOxPcA1NHZdoar4d40Pl1lUt+
   mgLKxoLU2JVV/CMyT2JsfBrpybL9TTxD4uRyeZl70TEL3cenPOyvZfW4A
   s9ohgKOFbQJOyMCcT+aSM2tg80V1tvg1PUCi1HXpNQZ75cPPD49oGXYrK
   3mVy28b2lltkxhdSWu1b8yAImAT+V4quYFJIaLTdoD8mzYr2Qs4jr/XqZ
   qXIXf2Q0JdDKvVsKGi7yvd5psiWoipKmSDLqeIPZWLamJA9jbVRRWHc6F
   iqCCH1stLswsWD7pnXrfi2Lv/xM8Cb8hftd2gZrpSdiQmIOJlo6S7rrp7
   w==;
X-CSE-ConnectionGUID: cmuHY064Q4Onzkob1nZwlA==
X-CSE-MsgGUID: f1N+9KJ2T5qKYtov8cDa1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976586"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976586"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: e7E+PrSQQsWIYIOdCvR79w==
X-CSE-MsgGUID: pXvWAwzoSJi81N7XB4R7Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724609"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
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
Subject: [PATCH V2 04/13] selftests/resctrl: Protect against array overrun during iMC config parsing
Date: Thu, 12 Sep 2024 11:13:53 -0700
Message-ID: <c3ff2c7df3d10931087e25e5488eb1ab2f5fe13c.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MBM and MBA tests need to discover the event and umask with which to
configure the performance event used to measure read memory bandwidth.
This is done by parsing the
/sys/bus/event_source/devices/uncore_imc_<imc instance>/events/cas_count_read
file for each iMC instance that contains the formatted
output: "event=<event>,umask=<umask>"

Parsing of cas_count_read contents is done by initializing an array of
MAX_TOKENS elements with tokens (deliminated by "=,") from this file.
Start by removing the unnecessary append of a delimiter to the string
needing to be parsed. Per the strtok() man page: "delimiter bytes at
the start or end of the string are ignored". This has no impact on
the token placement within the array.

After initialization, the actual event and umask is determined by
parsing the tokens directly following the "event" and "umask" tokens
respectively.

Iterating through the array up to index "i < MAX_TOKENS" but then
accessing index "i + 1" risks array overrun during the final iteration.
Avoid array overrun by ensuring that the index used within for
loop will always be valid.

Fixes: 1d3f08687d76 ("selftests/resctrl: Read memory bandwidth from perf IMC counter and from resctrl file system")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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
2.46.0


