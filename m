Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074351E44B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 07:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445583AbiEGFaY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 May 2022 01:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445546AbiEGF35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 May 2022 01:29:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F7968306;
        Fri,  6 May 2022 22:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80A5CB80688;
        Sat,  7 May 2022 05:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E092EC385A5;
        Sat,  7 May 2022 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901169;
        bh=nQe0p43j/Mw8whyp4ledlH+zcvMZWDU55dgzK2n5vvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OF1dtvrqgh7JV7TBLY6pybQPVbAGzqyyK0gC4hORuHRVXcGG/GFx3WtF0/Ws6vc85
         HUcSlDjMLz+tkfcWz1rigww7UKkefowTZ6a62Y2GLkOV07IpJ048r7tF//37RsOO43
         btltTV42NcWL8zQlbF0hOYuTPCQENZ9Npb6sH0vM6XA0hJAx+S1LLxIYnhat+90VOf
         OSPK9urQLUl2rXgrj68qsYnFMb+RFK7N9NA4oolCGaD+l02BJkUtKsnWC7hw0knKkY
         Al+Ua+bRCtx3ifvdHy6kAXhcGAZrTkGYtFxr+ZFoTXPTZWyJaH+ofzqKXYGzfkoZT+
         9qe3yxEvxkXew==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v6 04/23] kunit: take `kunit_assert` as `const`
Date:   Sat,  7 May 2022 07:24:02 +0200
Message-Id: <20220507052451.12890-5-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
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
2.35.3

