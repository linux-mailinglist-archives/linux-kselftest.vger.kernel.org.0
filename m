Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB06379E836
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjIMMmK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIMMmJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 08:42:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DC19B1;
        Wed, 13 Sep 2023 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608925; x=1726144925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IvFLjYsEpiHrR+BQ0j+mSxRo0C5kF8/dWX+/TG66kjI=;
  b=flu41bUCRPBzBG45zGVW6uuxROm9dYbNiAYir9Za81esHg2vkvIlvy0B
   MRjMbSHEd1lRzOJwLT9ukXANDnqxckjaYGbHoYbGty8zDUPdExZb9ihMg
   IfpnvoBfjTbvbAl+F7LF46k7JFAOZOISUDWsXes1k+TszwebSFxkCc6o3
   3qwZ50X9aNZDFGwmrX7ZEuPhuCikCJ2+PKFJ1GH4aZ2Fu4mK3FA0Bq5mM
   9XfZj9zcAbgfFTcmoC23rqJH5OXK90s6z+YBmoDgV3mE3JKxQkGGi1CGz
   B8KfyrYVmao/2joAPe77I1XZDdf9c+aDlmxfXtuJ7LzQpyHFHSWkYLH5u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="358918745"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358918745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="867775703"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="867775703"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:42:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] selftests/resctrl: Move _GNU_SOURCE define into Makefile
Date:   Wed, 13 Sep 2023 15:41:53 +0300
Message-Id: <20230913124153.32077-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, _GNU_SOURCE is defined in resctrl.h. Defining _GNU_SOURCE
has a large impact on what gets defined when including headers either
before or after it. This can result in compile failures if .c file
decides to include a standard header file before resctrl.h.

It is safer to define _GNU_SOURCE in Makefile so it is always defined
regardless of in which order includes are done.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/Makefile  | 2 +-
 tools/testing/selftests/resctrl/resctrl.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 5073dbc96125..2deac2031de9 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 838d1a438f33..eff178befe4a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
-- 
2.30.2

