Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34024A725
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 21:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHSTqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHSTqj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 15:46:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC73C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 12:46:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i20so8516415qkk.8
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwdlULMTaTE30yELl6QtQGZwxv6wjr+YnW2F2X4a+zg=;
        b=c/WAoo8K/Yqw75x+/yTAPBMGd8P18fZS2iAYS5ipm3w9Ruq3JxzeY1uwAFab9Luan/
         q1Fke9T39saOlrB5er41jfEkGH7Oa8bzUUqQI99WQkWv5uIRX8Bp1nMKYey3cKqqe5Qg
         pT3TD8hxoFTgm6BkOdgWgE5+XQjB37NDanXj5Wd3Q5D+i/0ndalNkrkIYN6pVMhaeBjI
         LJ5bAt1W8x6IESQXPWp/1EJEdl/L1kkbBgyhYoptE07q6EhGOblUKFDCMbtnIfJUVeIU
         5KCHiHL6FiVDBhBtcAjx91kT1gnPB3n2RMJq4eCFM0tKusGe3od9t9WITGeWrhv4jUkE
         EMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwdlULMTaTE30yELl6QtQGZwxv6wjr+YnW2F2X4a+zg=;
        b=PVo0OlVsRynwwKIIbNLdUFIGge7WV0ml+bEGLApZGTPtm91k7xCnR8ULV/z8OtvTiz
         O0G9m8MSExFxUYC4OmHT1v5irkAQ2F30W3+NViu9F27r+qoWhoVzp4aZrj/NIJFs9MsF
         M+vxwlkqmEWfBcxUiKEq7PLTmJeOJOKa66+uGRHuyKJXxhtQ/bdG6V+wMcA06kO1UK7D
         YAfdYLFI0du2inyc8/KwlZqBGhLhePQlOpqbjlfwYww2BY8sRv2ONdN3Eizzm6rT0OCI
         d/++J5zAxGssAt9i6sUKDodhwhmVqWVLBU9i9eypIKNpZUYUUHhTPZLTVQaSXYkE+owJ
         /+uA==
X-Gm-Message-State: AOAM532X9iyzuzR+8ltbYrDT88GuTEQyqogFqIC40QheySkTLtn8N5G+
        C92VQfYgkSbK+86gce+PH/dL+w==
X-Google-Smtp-Source: ABdhPJyKX/MDCHQWdQ7HhGON2G6xeCj2o3kWMNc+YE32/pZH7fM1NWt9kefHSiCJXUl04z31vwRgZA==
X-Received: by 2002:a37:a64a:: with SMTP id p71mr23616034qke.296.1597866398525;
        Wed, 19 Aug 2020 12:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4a5:288::1001])
        by smtp.gmail.com with ESMTPSA id x28sm25448344qki.55.2020.08.19.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:46:38 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: fix: kunit_binary_assert_format() only prints signed int
Date:   Wed, 19 Aug 2020 16:46:34 -0300
Message-Id: <20200819194634.68976-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some tests, such as overflow_kunit(), uses unsigned int,
But kunit_binary_assert_format() only prints signed int,
this commit also deals with the unsigned int print.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 lib/kunit/assert.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 202f9fdeed0e..3ae90c09986a 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -104,12 +104,23 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 				  binary_assert->left_text,
 				  binary_assert->operation,
 				  binary_assert->right_text);
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+
+		if (binary_assert->left_value - 1 < 0) {
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
+		}
+		else {
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu\n",
 				  binary_assert->left_text,
 				  binary_assert->left_value);
-		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+			string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %llu",
 				  binary_assert->right_text,
 				  binary_assert->right_value);
+		}
 	}
 	kunit_assert_print_msg(assert, stream);
 }

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
prerequisite-patch-id: bf4b0962b0b955e4e45f5d25fece889562118158
-- 
2.26.2

