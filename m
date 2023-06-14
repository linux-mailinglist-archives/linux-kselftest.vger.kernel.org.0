Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F072FBAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjFNKuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbjFNKuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 06:50:51 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2231BF3;
        Wed, 14 Jun 2023 03:50:49 -0700 (PDT)
Received: from Thibf-fixed.fritz.box (unknown [45.83.232.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3BB0540269;
        Wed, 14 Jun 2023 10:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686739846;
        bh=eUY0/Bvf/dV+JXrlyqFmfN8YtkIS7qP5DzuIMO7NVls=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=FJFbaQ7iaItC1FdadVLPBPRJXijOtiyZhwSTd71P6xJ+tP6X+pTJbhNud9Y1wvgFJ
         zl/MxUBBeOqdFsbIGchizgV84xwSNTjhss4CvFAN9lru8fOpXEDs+NImUct64Gblce
         N8C/xBeCbxF92hcWXjeN6uIVde7OFdr4aMNhZPCWZD1+S6Cn/PF5vx20hlwXkigtXe
         z2v+liNI7X12Gz68JChLN2BOvugC7Cx7JVrtN3xNPhrASoivhLTfA/Z7Z6OIDjIoSN
         V465Z7mVbTIY2/VPDG6oyBhhCB077vfmzQ16rE9BD2aOxInOGzeziilgf4xeTIhzIs
         Y1HgljHRoYzEQ==
From:   Thibault Ferrante <thibault.ferrante@canonical.com>
To:     shuah@kernel.org, rostedt@goodmis.org
Cc:     thibault.ferrante@canonical.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Add test dependency
Date:   Wed, 14 Jun 2023 12:50:31 +0200
Message-Id: <20230614105031.13543-1-thibault.ferrante@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_duplicates miss a running dependency and leads to test failures
on kernel with specific configuration.

Signed-off-by: Thibault Ferrante <thibault.ferrante@canonical.com>
---
 .../testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
index d3a79da215c8..0b5e4543e70b 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - check if duplicate events are caught
-# requires: dynamic_events "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
+# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README
 
 echo 0 > events/enable
 
-- 
2.39.2

