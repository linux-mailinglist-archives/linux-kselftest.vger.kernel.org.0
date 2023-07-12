Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98475131E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjGLWBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGLWBC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 18:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373381FCC;
        Wed, 12 Jul 2023 15:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC676196B;
        Wed, 12 Jul 2023 22:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065F3C43395;
        Wed, 12 Jul 2023 22:00:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qJhtJ-000QiI-0H;
        Wed, 12 Jul 2023 18:00:57 -0400
Message-ID: <20230712220056.899064942@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jul 2023 17:50:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 1/5] selftests/user_events: Test struct size match cases
References: <20230712215044.496021196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

The self tests for user_events currently does not ensure that the edge
case for struct types work properly with size differences.

Add cases for mis-matching struct names and sizes to ensure they work
properly.

Link: https://lkml.kernel.org/r/20230629235049.581-3-beaub@linux.microsoft.com

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/dyn_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6979a48478f..91a4444ad42b 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -217,6 +217,18 @@ TEST_F(user, matching) {
 	/* Types don't match */
 	TEST_NMATCH("__test_event u64 a; u64 b",
 		    "__test_event u32 a; u32 b");
+
+	/* Struct name and size matches */
+	TEST_MATCH("__test_event struct my_struct a 20",
+		   "__test_event struct my_struct a 20");
+
+	/* Struct name don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct b 20");
+
+	/* Struct size don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct a 21");
 }
 
 int main(int argc, char **argv)
-- 
2.40.1
