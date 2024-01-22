Return-Path: <linux-kselftest+bounces-3350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A472F836E40
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E681C27CD1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A54CB56;
	Mon, 22 Jan 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhIFD7OI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAF4CB47;
	Mon, 22 Jan 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943664; cv=none; b=LAjE762TUIvFfRuXM/2ll6rVajRzHcUDFuuzW0VqzQE1a3kaKXwdMy9vNPednB3Repv3+qAswWax/wthtEA2PXLZd80Skvu3MyVGySqekabKsPazSla5b2VPXfsitjpFO8gWoyi4hBlxKIV8hRnRtyt/twDEEs56Z+paVzv+tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943664; c=relaxed/simple;
	bh=QzD4pwvbiYZ9itdJVQhid9o2mLBqbUNnCZYBsNS9LKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kfdxj2cuETX2FBX5fxfLAZQeIGi2QT4uW0VagsWltQEflNICX3AX2fTP5RSgtgnc5gU80N8b9gnloPjws4FzLADEiMuV7Jkzjk/0ojUTvHZgTUZM0bVbVaPVM6u5kzYiHl06OoRgLX3qsGYe9tLXPz6fSr5zFOADffM+qp62je4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhIFD7OI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705943663; x=1737479663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QzD4pwvbiYZ9itdJVQhid9o2mLBqbUNnCZYBsNS9LKg=;
  b=jhIFD7OIN2p7EndLpaeFtoLulbLkfBLPjhpddSstnXK7j/8HA/iQG9bn
   H3oa2UF3Ef7eookiQCPq1TAYTBxjgnJSaiXyRDs9zWkKVMEY5ipmbuFc6
   xghY2XR/8QiySIT9wArQtJnWSh0TXpY31AIAJSo7bk4ZKC3kN81Qoo9tm
   TG8gDTpVbxMR4/4M72tdRg5Xi9mujHVKdcBZwY5P1VYc+DUINFIefKZD8
   f5xofdrDhpjjolG2v2mRqH0oeob1Wcu4Jp25j54LIUEbbM1UTCVa2D5JX
   c0HSgBNs3pHLagf6R4UxBnoCF8gZnUG7/cJaB0u+U2Sz/2diEkS7NZMwu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8023203"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8023203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735233041"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="735233041"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:14:21 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	"Krzysztofik, Janusz" <janusz.krzysztofik@intel.com>,
	Rae Moar <rmoar@google.com>,
	"David Gow" <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: [PATCH v2] kunit: Mark filter* params as rw
Date: Mon, 22 Jan 2024 09:14:08 -0800
Message-Id: <20240122171408.3328510-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By allowing the filter_glob parameter to be written to, it's possible to
tweak the testsuites that will be executed on new module loads. This
makes it easier to run specific tests without having to reload kunit and
provides a way to filter tests on real HW even if kunit is builtin.
Example for xe driver:

1) Run just 1 test
	# echo -n xe_bo > /sys/module/kunit/parameters/filter_glob
	# modprobe -r xe_live_test
	# modprobe xe_live_test
	# ls /sys/kernel/debug/kunit/
	xe_bo

2) Run all tests
	# echo \* > /sys/module/kunit/parameters/filter_glob
	# modprobe -r xe_live_test
	# modprobe xe_live_test
	# ls /sys/kernel/debug/kunit/
	xe_bo  xe_dma_buf  xe_migrate  xe_mocs

For completeness and to cover other use cases, also change filter and
filter_action to rw.

Link: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcbne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

Rae, I kept your r-b from v1 since the additions are just what we talked
about.

v2: also change filter_action and filter to rw, testing with the xe
    module to see if filter=module=none filter_action=skip produces
    the result expected by igt

 lib/kunit/executor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1236b3cd2fbb..371ddcee7fb5 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -31,13 +31,13 @@ static char *filter_glob_param;
 static char *filter_param;
 static char *filter_action_param;
 
-module_param_named(filter_glob, filter_glob_param, charp, 0400);
+module_param_named(filter_glob, filter_glob_param, charp, 0600);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
-module_param_named(filter, filter_param, charp, 0400);
+module_param_named(filter, filter_param, charp, 0600);
 MODULE_PARM_DESC(filter,
 		"Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
-module_param_named(filter_action, filter_action_param, charp, 0400);
+module_param_named(filter_action, filter_action_param, charp, 0600);
 MODULE_PARM_DESC(filter_action,
 		"Changes behavior of filtered tests using attributes, valid values are:\n"
 		"<none>: do not run filtered tests as normal\n"
-- 
2.40.1


