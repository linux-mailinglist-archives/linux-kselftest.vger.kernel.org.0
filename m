Return-Path: <linux-kselftest+bounces-1248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172C80698B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC2281D8E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13818E32;
	Wed,  6 Dec 2023 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiGsp8di"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637C8D3
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:23:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5404fdfb2so594052276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 00:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701850981; x=1702455781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCRvn/sz9XVm96oNWnMxAn3yHnXhHkzRkqQQYNeebWk=;
        b=jiGsp8diuKYRABNDXqse482cb3kDzJNtGOGQmKQLRwZX0M9iKg33lE5nOkx+81RRxh
         k4L+STcB6cReRyQhyWS1gVj41qUOwnnO0eXGf+hn0DvEKsJyX6bu/2U3xvVCvxg2LtUh
         1sxXmYpBy2Cnr0LureaNj2RMAtSz5uUWdjoqHUjUZbDYTGBGQmHSOlt3FTH/NAoY01jf
         4GzIvMqPomPERtafBTbSGh4jyTPxVRnllPQjKIQk1ZgEfOLxKsODzTR3UdJUI0Q0q/CP
         87TSOZjMaJUxkEDOw/YesztP3lIkZD11stD+b7a6LbvOPqfQtWTNk9b1z900TXeEXSjl
         BTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850981; x=1702455781;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCRvn/sz9XVm96oNWnMxAn3yHnXhHkzRkqQQYNeebWk=;
        b=VxjK3mDcN0ukJLsqgLyDv/FcJj3J6Xdo6JlFBWyRsqO0lKDeprg/YzE7/yooAg0ZFT
         zRIaO2KaQdxpAFh1XtWI9hdRJAmRYgJCfRXdKvUpxkpzuQeelu0m857btCbAii0fWupl
         57cPd7keEeKphF/K2Z0O+ubTCtGAC1hU0/aUknjzP6aplPrsKCZEndhgvnPD202tt5Zs
         C3tREaXguwv65lVYEwv9HsArq4+xLLyL5VJvdaIAVXXYet3aTGjl8OP9vB4eGu3ye7nf
         iNUr3K0UDhS0YxY4KWqjq5qIWty8Vy3fI2cap+4ffTKnpKjc0IbQHiQHh1nP4IS1hJXu
         +y3Q==
X-Gm-Message-State: AOJu0Yxuynr6tXAw6fZLlRB2eGQ34qrjsnJVIXUZNtixxdtQx7zQd/Ez
	4DtYmm299mLG2uO8Kc9nKXXV2P/38y//aA==
X-Google-Smtp-Source: AGHT+IHgN9snu5a/ppS7OlD3/ljvTemeLfF2mtBrbyVREwmLrAUt0HI19V0c0cnISxARtPjazI9Qq2Ace2v1QQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:51:b0:da3:b467:af07 with SMTP id
 m17-20020a056902005100b00da3b467af07mr82068ybh.2.1701850981627; Wed, 06 Dec
 2023 00:23:01 -0800 (PST)
Date: Wed,  6 Dec 2023 16:22:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206082251.586204-1-davidgow@google.com>
Subject: [PATCH] kunit: test: Use an action wrapper instead of a cast
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We missed one of the casts of kfree() to kunit_action_t in kunit-test,
which was only enabled when debugfs was in use. This could potentially
break CFI.

Use the existing wrapper function instead.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 3e9c5192d095..ee6927c60979 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -559,7 +559,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, test->log->append_newlines);
 
 	full_log = string_stream_get_string(test->log);
-	kunit_add_action(test, (kunit_action_t *)kfree, full_log);
+	kunit_add_action(test, kfree_wrapper, full_log);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(full_log, "put this in log."));
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
-- 
2.43.0.rc2.451.g8631bc7472-goog


