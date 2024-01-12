Return-Path: <linux-kselftest+bounces-2880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F982B883
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 01:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93457B223E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF89361;
	Fri, 12 Jan 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPrprL4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DF562A;
	Fri, 12 Jan 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705018398; x=1736554398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AAr1jyF5ycUc3fnsLZxVVxgsc9+kH7u4LIsdUC1Iv88=;
  b=CPrprL4RslQDBzP9Wkh9a1me/QYZkRnhRHgHzsZqzOakB5P5qgSHSb8i
   EBX3Cm3pd4tO1ZLC5TNF27m2K+pEIwy821Wz1C9dzu6d3My8QN6CXdpW5
   9nFZs65aXwt+EDbiRlUjXfZIultIqaueQwcCYF8Jq/lL/sxniI0C09dX6
   5nGBDDRWl7lBaCeZiH9Scnit/Jzz9gr3EYdvbjpw3Lt1FpwOfzXjmGbda
   XgGqJO6xS6sgeIQ5VZrFfWQ1M4+VeegsyA2yJ8ULBXPcdrZOAJ1j2EyIx
   GGaD1x/hk+Nu1WcRD6U0gdT1rAKfh/Jur57RT9F77I/NCYVO1v1K+Z3Jg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397915559"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="397915559"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="853120102"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="853120102"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:13:16 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	<intel-xe@lists.freedesktop.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] kunit: Mark filter_glob param as rw
Date: Thu, 11 Jan 2024 16:12:40 -0800
Message-Id: <20240112001240.1710962-1-lucas.demarchi@intel.com>
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

References: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcbne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 lib/kunit/executor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1236b3cd2fbb..30ed9d321c19 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -31,7 +31,7 @@ static char *filter_glob_param;
 static char *filter_param;
 static char *filter_action_param;
 
-module_param_named(filter_glob, filter_glob_param, charp, 0400);
+module_param_named(filter_glob, filter_glob_param, charp, 0600);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
 module_param_named(filter, filter_param, charp, 0400);
-- 
2.40.1


