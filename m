Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BE516D75
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348295AbiEBJkW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384262AbiEBJkT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 05:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241645AF0;
        Mon,  2 May 2022 02:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2CA611D6;
        Mon,  2 May 2022 09:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDF1C385AC;
        Mon,  2 May 2022 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651484208;
        bh=9BAQqLLOLL2trD6C1GTCsmN5pgx0ztTic3hcYSWhX9A=;
        h=Date:From:To:Cc:Subject:From;
        b=oUxQcaHM94xydxjvrkgSw7NmKshl+4h5S4T5rb4cqqPnvNZKwuu5M2wMUBPZ47qTk
         3saZe7V6J5rhz5bzxG1j/TiorgbmXoq0b5oDsBcU/DL5EP3wntWBaaA4KovkksdWza
         7pUZVAvYBX/QCF2yXj/P3LEmzeg34mTDIf3H7fxKDELdw3aPpypuufSM4Es7rzKM7f
         llRT6M7wmTM5DFie+q/JrZEcn3bykvPHWpdV7DgTViKBRaEYp/UngYXtmi5SzOmAfq
         TGwKui26HxsYysoDnsFGpo8OfOK1Ye5RcZagalecH6Zm9vD7Yp31BFYHYNRawVaStF
         9pyiErpIANLqg==
Date:   Mon, 2 May 2022 11:36:25 +0200
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: take `kunit_assert` as `const`
Message-ID: <20220502093625.GA23225@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
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

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
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

