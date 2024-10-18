Return-Path: <linux-kselftest+bounces-20089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688659A32B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23729282D92
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AF142E86;
	Fri, 18 Oct 2024 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcVabV6h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1A17B505;
	Fri, 18 Oct 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218161; cv=none; b=kq6nMSi+fZr8iBeFhqJT/MVmjRFsQ7h4+4yiKLPNg4haYfWUTQSErw3CwpL9uhckDgTKamZr78P2mndxxYJ1wty1O0nivs6p5cBfmTjspCj4vfN3xKMqEoognTzd13sRa5Aa8X5kfIJhWM0+Pre7y0luOg2Q57RoNUBmQk6exS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218161; c=relaxed/simple;
	bh=grJ4cRTsHWngr55kCknBb9PxXbOJjDYnItK5kuxBfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X24dyMDQPou9zCpqCFOHWH6mUXee9ZGK2rYZ/fEIyidPPkLEO7LWSUUCa5XiXyuJOKE0aRVCmmaCPL+tcJbSsWiRw0EtVFSBzgmvsODxS+DVkKoaNFgFoKR3X1L/pDr2G+pMUaon9Z0lD/VE5Svncv5tuFvTCvoLrbRLJ44ULQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcVabV6h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218160; x=1760754160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grJ4cRTsHWngr55kCknBb9PxXbOJjDYnItK5kuxBfjY=;
  b=dcVabV6hzQGdDxxEQjuzYBLE9NtUvmMk41nyfCsLuEyMJu+/IZsqj01Q
   E00+KbTqMPAGwkrMQ7qqtzNOWV2ohHiemeAYhNIBplziwF2Pz9vHmx2MS
   3qDqcDKE6o1FTMiFnDIf67xool9UZqDdWxcFEiyrAO4WpX2ap6bxJInrN
   2frI0eAtz0YwoOWuiFsGpODtYkjw27PZl/BXB1pvRRvDeb9Tt3bypPBHC
   kgMJuCgmpTGkaVkDtYep/T6udvUS30NnxGV4ahRsRPNPxKYvFx4kYf+D1
   ZqUQp/m2TGIgjzWmDHogz/y4uRa/4Nz7kGT58L/9gZ5S3/ASdALHV40B7
   Q==;
X-CSE-ConnectionGUID: YAqdUpf9Rm2bmIwWN9UbUA==
X-CSE-MsgGUID: LVr6YLvkSzK1QrzaxFIiSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149688"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149688"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: i6obbGvASnKAf/vjFOjfuQ==
X-CSE-MsgGUID: 7l+1HKJBSHu7Sa2cyq6XpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697708"
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
Subject: [PATCH V3 04/15] selftests/resctrl: Protect against array overrun during iMC config parsing
Date: Thu, 17 Oct 2024 19:33:19 -0700
Message-ID: <ff4b8631bc2a8c091f469b37c0b502fdd6bef476.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
2.46.2


