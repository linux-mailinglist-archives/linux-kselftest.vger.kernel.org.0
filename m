Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672147073A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbhLJRhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbhLJRhF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:05 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C531C0617A2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:30 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso10311765ots.6
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDgcHDpgiGWK9Ew3NHUhEO9yqNh1ILLLayqUXO2p75w=;
        b=RBvRuhdbY7g+jhhycOa6s6AnQRPB9u+jMTQAdWAGcbZry4Gs71DzkZXrtyFNlzrjYb
         t6cYRkjUJNJA0VqVa9VD5NUujJb9jkn5OXNmdw0ZBi1zYANnBFWUCoJvVfZtk5h4sJn1
         eqbzyIxoNgJ2evkyeFqyx5i3WODR+TVyV1f2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDgcHDpgiGWK9Ew3NHUhEO9yqNh1ILLLayqUXO2p75w=;
        b=S3ctX08+2fyeppiBMsZCdjnElUZYAPQfTtMKpGhPH0a7uOhKtExBjLzT8AiPLM4oKe
         ZXmfa1zY5RLKdC6cuQgcNVp6ICdhaspXfi0DkDm/o9NhBLCMc61S2YEwRzZLSunO/ZiK
         /C2BaJtgPNoVy4On+Q1x62KDS10LRAoNhxG/hKopIaNte0af8ltASnPaTZ5NTOKn9/R0
         Je27I9I7F1IUFse3ERD2jHDeLYHliWPe6AHHZf6zkYcC8KQmkUSkfRopoKI5jU1Ho0D2
         84x6OEImLTElQtlI2syT+zOnHYVEKDgPY5M5xtxWSCT5+u64zNcbB1c2GftZ5ztK8LYM
         VFOg==
X-Gm-Message-State: AOAM530cbku9/K275hVsh5M618crsOrVrDl5Fw1GNWOhY6BMH2fQAQGw
        VLKE2ktJo8tbJTZdzeUOYcxkTQ==
X-Google-Smtp-Source: ABdhPJyA4yaTBTIyZO1xnTM+/bAUFXSJizFV+09oAtmwLgPNp33uTLG6kCjRdELfrCYBpviWIZftqA==
X-Received: by 2002:a05:6830:118a:: with SMTP id u10mr11939448otq.194.1639157609588;
        Fri, 10 Dec 2021 09:33:29 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:29 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 04/12] selftests/core: remove ARRAY_SIZE define from close_range_test.c
Date:   Fri, 10 Dec 2021 10:33:14 -0700
Message-Id: <0b20692e28c83822bb6b56518791371120582d0e.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from close_range_test.c and pickup the one defined
in kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/core/close_range_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index aa7d13d91963..749239930ca8 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -50,10 +50,6 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 	return syscall(__NR_close_range, fd, max_fd, flags);
 }
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 TEST(core_close_range)
 {
 	int i, ret;
-- 
2.32.0

