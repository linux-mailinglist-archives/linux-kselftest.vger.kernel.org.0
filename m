Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F26375FA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 07:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhEGFKc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 01:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhEGFKb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 01:10:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57988C061574
        for <linux-kselftest@vger.kernel.org>; Thu,  6 May 2021 22:09:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so8754560ybp.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 May 2021 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HRBAR21u7PRZM/8/eMSlewl7NCMmiIJxdjUH7mvZekY=;
        b=DhGNJidwdrI3KXAJXGCmwGs1p7rL6egOFnrxLtNMmdergPEvrfY5NzHibtJacZfh8c
         VdjMv+Gx6FvB0wDZfPIidP3RVhGOJgz87g/tHu4bf0CSo6lr9cuey2az4gb0JHDkIKTU
         Wuz5yC9bRlYmf4g+9ZReAKGIR6hIMyw7rD76FXyy8BuWJsz3Sk56KbXQtPdWruz+D2c1
         GbWPtcXtLzA5+iPIx5fu508twhW3F0oxlcXJDaMd2CDs68G9Db+u+XFFME6dK9rMhsQS
         v31gn4PQLWvAg7ecWh4KXdeWVDA4dTn4TJtd5IkFEs0WqTbhAdh5i3pDlqT9gnCItcwA
         7ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HRBAR21u7PRZM/8/eMSlewl7NCMmiIJxdjUH7mvZekY=;
        b=ID5obnqdoFXAv0IJbM+twWVXJs5lGt4R05dKhPMr4hmAfRzA1Ooly/TzTcfm0/Nvhu
         Jna5Dn3iMgcqeN7THHz0FmuNnL18nNy2IH94/Hq9iXGTfAJXXn88uDqnx8SVdM3V90j6
         5JFLWs7vnXpWGkyq+I+wFr5c5iHenGI5cSahEkk2FZ38aswuPjgUbt1ccCtjfJDuTXUi
         FTqi//U2+5lHU/rCp1ka6utDSlhXVN6+A6+bXuVcNP2f3JA5GQSmQvTzyoElHGXUpntT
         h/5n+qMPR2ABmX3BuiRpGxlgi+eHWoZbbVhRjR7XqiznIgjmSlqM8JOF4mbHgF/lJXEU
         ygmQ==
X-Gm-Message-State: AOAM531yIWKrdHmqYayw3RSuJMmaOCYSkPim4oxbW/6ff8u00lukMTBS
        gvAS1bIamqcePm8zxI5FR9sj8W7aSO1pzw==
X-Google-Smtp-Source: ABdhPJw+CbtEFdF9Vkfc06hXM/f6APOThaXd1KaFsU9TTsm45ExcEMGJ2t9r92IcHQyFQdvPpXwXO4kIrKKuhw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:7a7f:ce22:a6af:49e5])
 (user=davidgow job=sendgmr) by 2002:a25:bd50:: with SMTP id
 p16mr11249160ybm.290.1620364171642; Thu, 06 May 2021 22:09:31 -0700 (PDT)
Date:   Thu,  6 May 2021 22:09:08 -0700
In-Reply-To: <20210507050908.1008686-1-davidgow@google.com>
Message-Id: <20210507050908.1008686-2-davidgow@google.com>
Mime-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 2/2] kunit: Assign strings to 'const char*' in STREQ assertions
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the KUNIT_EXPECT_STREQ() and related macros assign both
string arguments to variables of their own type (via typeof()). This
seems to be to prevent the macro argument from being evaluated multiple
times.

However, yhis doesn't work if one of these is a fixed-length character
array, rather than a character pointer, as (for example) char[16] will
always allocate a new string.

By always using 'const char*' (the type strcmp expects), we're always
just taking a pointer to the string, which works even with character
arrays.

Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 4c56ffcb7403..b68c61348121 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1128,8 +1128,8 @@ do {									       \
 				   fmt,					       \
 				   ...)					       \
 do {									       \
-	typeof(left) __left = (left);					       \
-	typeof(right) __right = (right);				       \
+	const char *__left = (left);					       \
+	const char *__right = (right);				       \
 									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
-- 
2.31.1.607.g51e8a6a459-goog

