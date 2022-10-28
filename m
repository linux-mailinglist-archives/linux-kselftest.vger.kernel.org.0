Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441C8610A58
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 08:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ1GbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 02:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJ1GbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 02:31:16 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FBA10C4E8;
        Thu, 27 Oct 2022 23:31:12 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id WGH00009;
        Fri, 28 Oct 2022 14:31:09 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 28 Oct 2022 14:31:08 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] kunit: Include missing header
Date:   Fri, 28 Oct 2022 02:30:55 -0400
Message-ID: <20221028063055.2817-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221028143109f24a302985491c280d98218309c435e6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The file debugfs.c missed the header debugfs.h, which
resulted on the following warning:

lib/kunit/debugfs.c:28:6: warning: no previous prototype for 'kunit_debugfs_cleanup' [-Wmissing-prototypes]
 void kunit_debugfs_cleanup(void)
      ^~~~~~~~~~~~~~~~~~~~~
lib/kunit/debugfs.c:33:6: warning: no previous prototype for 'kunit_debugfs_init' [-Wmissing-prototypes]
 void kunit_debugfs_init(void)
      ^~~~~~~~~~~~~~~~~~
lib/kunit/debugfs.c:92:6: warning: no previous prototype for 'kunit_debugfs_create_suite' [-Wmissing-prototypes]
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/kunit/debugfs.c:108:6: warning: no previous prototype for 'kunit_debugfs_destroy_suite' [-Wmissing-prototypes]
 void kunit_debugfs_destroy_suite(struct kunit_suite *suite)

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 lib/kunit/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 1048ef1b8d6e..83411075f614 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 
 #include "string-stream.h"
+#include "debugfs.h"
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
-- 
2.27.0

