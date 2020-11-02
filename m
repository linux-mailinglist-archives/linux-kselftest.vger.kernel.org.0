Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B02A3610
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 22:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBVhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgKBVhL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 16:37:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42124C061A04
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Nov 2020 13:37:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b189so15693760ybh.5
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6QhI3kHimGu8AWgc0fDAH50nxnuO9Boew+8qHoNE/Eo=;
        b=BApIjvn7QJ3hkYCJqm1ZEr4y5XnuniIqZJW0Q7lYJLi1jVypbSF5D90TrXEnym+bOJ
         B1ztMqsbPnPQ4SMdybfWkdITi8ZQnCByAMmpISsEN5Md1tcnwIPHvCjlZf4nQOh8T6u0
         4DkOL+GJcGN40B3SWlpoARtY0uHtr7jOW0uWxqlauUKzgwTxgifEGdFaTCPbvmXrtzm/
         YlScuqb6LpbvGxxN+mDRKPb/rNhwU2HDDl2vA6udlo9NabPcbA6aXok5sWeQVWsUf2zi
         uZrImi3XCItHlC/2uaWfp4x1ut/4y86g/1Gvqy8WsbtfV8a+m5Z1JOrEqHCJ45WBTVMt
         RDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6QhI3kHimGu8AWgc0fDAH50nxnuO9Boew+8qHoNE/Eo=;
        b=IEcEnpV61nVaL/VoAeAN6HawSK/KttZI+BCyyU+E8bJ3OQbJ9+seIWggDkW2vLWGmh
         kov/ASUyX0Jkhgtly/abikya1Y0Nm8ayYbaYgIkTjp1BybpyzfNspzX4haobmu25T2XM
         I9z4UdZ60P93+ds79uBIrGW9QKNA1+c2Mz4wSQcmRv+Dq7HiL476R+yrDy9+/XKkquPS
         BWdwup+aaIwIBnSc2jaP5OeG37AXv25Qu5joNi2UxQVy52a5DKAnAdp+B8a7ricjbWJX
         iTV4Nm2SlpFvVq6CVnSeVP+I947VF8GTpTt+QkMuLCb3N/0k4AXBtPIV7AlU941p3u2t
         9XIQ==
X-Gm-Message-State: AOAM530OdMQrn8KAvfqtayKlXPrqaStRdiRd8bM5hMwrqQlOshO5Sisn
        JGnn5LhD268sUoGjgjKUCkZpZLuBN/du9g==
X-Google-Smtp-Source: ABdhPJz4uKIj6Q4SL0hNCQEkGUOcERyuUqYeqLGnw1+q8cf714ZYJ06FmUwShvkid2AmogORNtzrpYJnXL77GA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:b68a:: with SMTP id
 s10mr22646893ybj.455.1604353030242; Mon, 02 Nov 2020 13:37:10 -0800 (PST)
Date:   Mon,  2 Nov 2020 13:36:56 -0800
Message-Id: <20201102213656.2700500-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] Documentation: kunit: provide guidance for testing many inputs
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, andriy.shevchenko@linux.intel.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

usage.rst goes into a detailed about faking out classes, but currently
lacks wording about how one might idiomatically test a range of inputs.

Give an example of how one might test a hash function via macros/helper
funcs and a table-driven test and very briefly discuss pros and cons.

Also highlight the KUNIT_EXPECT_*_MSG() variants (that aren't mentioned
elsewhere [1]) which are particularly useful in these situations.

It is also criminally underused at the moment, only appearing in 2
tests (both written by people involved in KUnit).

[1] not even on
https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 66 +++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 62142a47488c..317390df2b96 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -451,6 +451,72 @@ We can now use it to test ``struct eeprom_buffer``:
 		destroy_eeprom_buffer(ctx->eeprom_buffer);
 	}
 
+Testing various inputs
+----------------------
+
+Testing just a few inputs might not be enough to have confidence that the code
+works correctly, e.g. for a hash function.
+
+In such cases, it can be helpful to have a helper macro or function, e.g. this
+fictitious example for ``md5sum(1)``
+
+.. code-block:: c
+
+	/* Note: the cast is to satisfy overly strict type-checking. */
+	#define TEST_MD5(in, want) \
+		md5sum(in, out); \
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "md5sum(%s)", in);
+
+	char out[16];
+	TEST_MD5("hello world",   "5eb63bbbe01eeed093cb22bb8f5acdc3");
+	TEST_MD5("hello world!",  "fc3ff98e8c6a0d3087d515c0473f8677");
+
+Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
+and make it easier to track down. (Yes, in this example, ``want`` is likely
+going to be unique enough on its own).
+
+The ``_MSG`` variants are even more useful when the same expectation is called
+multiple times (in a loop or helper function) and thus the line number isn't
+enough to identify what failed, like below.
+
+In some cases, it can be helpful to write a *table-driven test* instead, e.g.
+
+.. code-block:: c
+
+	int i;
+	char out[16];
+
+	struct md5_test_case {
+		const char *str;
+		const char *md5;
+	};
+
+	struct md5_test_case cases[] = {
+		{
+			.str = "hello world",
+			.md5 = "5eb63bbbe01eeed093cb22bb8f5acdc3",
+		},
+		{
+			.str = "hello world!",
+			.md5 = "fc3ff98e8c6a0d3087d515c0473f8677",
+		},
+	};
+	for (i = 0; i < ARRAY_SIZE(cases); ++i) {
+		md5sum(cases[i].str, out);
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].md5,
+		                      "md5sum(%s)", cases[i].str);
+	}
+
+
+There's more boilerplate involved, but it can:
+
+* be more readable when there are multiple inputs/outputs thanks to field names,
+
+  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
+* reduce duplication if test cases can be shared across multiple tests.
+
+  * E.g. if we had a magical ``undo_md5sum`` function, we could reuse ``cases``.
+
 .. _kunit-on-non-uml:
 
 KUnit on non-UML architectures

base-commit: 77c8473edf7f7664137f555cfcdc8c460bbd947d
-- 
2.29.1.341.ge80a0c044ae-goog

