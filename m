Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DE53076B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbiEWCDX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 May 2022 22:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352196AbiEWCDQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 May 2022 22:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F62393C9;
        Sun, 22 May 2022 19:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7890AB80EA5;
        Mon, 23 May 2022 02:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B4DC385AA;
        Mon, 23 May 2022 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653271388;
        bh=AYZdW7QGT+vcglt61tBtSgAZJpgEdOfaqi4lvzzFg4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2lp9M1XpMYOOkkkLujxcdWSGdzspCXeR4Jz8iCrZ6LO4wlYA3OOscwVqzDVBDxYl
         uxQIFzJ1Z/NHExB0XldPXVBc7HCN+Jr0/7tUJbHMs6JlQA0Gr2DoL3vmtrGNlLQGS1
         0ze8y76/WAfxhVoS3BcRtCEDnh+CecHBHPgEGaZms+PquIs9PujD0XU5sISndOQXd1
         8XPz0W5ylG5iMYh78prTQk5CmDDf5Vt7Grq4nQK11pM4HejfPsHahWWSJxI5w4k+ig
         QyZvn9pLg9BOPpk0OtYA2CZ5H2DBjJlWf2oJMXX750G+EnAurRwMzV5bOK7dSON9P9
         xTq4k6s0+1gUg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v7 04/25] kunit: take `kunit_assert` as `const`
Date:   Mon, 23 May 2022 04:01:17 +0200
Message-Id: <20220523020209.11810-5-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The `kunit_do_failed_assertion` function passes its
`struct kunit_assert` argument to `kunit_fail`. This one,
in turn, calls its `format` field passing the assert again
as a `const` pointer.

Therefore, the whole chain may be made `const`.

Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
This is a prerequisite patch, independently submitted at:

    https://lore.kernel.org/lkml/20220502093625.GA23225@kernel.org/

 include/kunit/test.h | 2 +-
 lib/kunit/test.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..2eff4f1beb42 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -774,7 +774,7 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
 void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
-			       struct kunit_assert *assert,
+			       const struct kunit_assert *assert,
 			       const char *fmt, ...);
 
 #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bca3bf5c15b..b84aed09a009 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -241,7 +241,7 @@ static void kunit_print_string_stream(struct kunit *test,
 }
 
 static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
-		       enum kunit_assert_type type, struct kunit_assert *assert,
+		       enum kunit_assert_type type, const struct kunit_assert *assert,
 		       const struct va_format *message)
 {
 	struct string_stream *stream;
@@ -281,7 +281,7 @@ static void __noreturn kunit_abort(struct kunit *test)
 void kunit_do_failed_assertion(struct kunit *test,
 			       const struct kunit_loc *loc,
 			       enum kunit_assert_type type,
-			       struct kunit_assert *assert,
+			       const struct kunit_assert *assert,
 			       const char *fmt, ...)
 {
 	va_list args;
-- 
2.36.1

