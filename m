Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7C44C69D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhKJSHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKJSHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 13:07:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7EBC061764
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 10:04:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id y26so7918111lfa.11
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Nov 2021 10:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhaYpGZE0UbJvh6Nn3mP+o6sCA1NJHCl7ZX/I6n4rjw=;
        b=y9IC1G868iVb+OHqDVfF2LTsG3gKZU6xHEChe8Z+2oWK8hUnasf7SIsinMOv/h5tgI
         TsXk8W4ydBqn/W6pjBnQPpcViFhJZ996Dnprf/PDBPbpFU5/YjJJp+3JW8ZqJI6fd5T6
         5XgAeELA/04uVUtsecW0lh94hmTOsBHWaFWXVnCnszBCU1+T+JKVc+TsCcpWCbPI5Gmi
         JZ8IDKypGtAMT3iwwSBJnJ2ABOHRcqG+4q5MMKjDo54it1V3gVH9UaaadQJ9ppC6CtpV
         UjnpRiPzoNH9Crh6vZGJVTf3vstfk1Id8DGccONhrw/Y26w4sJgEoj+mLGlPOgFWLeGR
         j4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhaYpGZE0UbJvh6Nn3mP+o6sCA1NJHCl7ZX/I6n4rjw=;
        b=E9EZFHhxxEZoCODsfGk/EQu90CCHgpjZgbWbX8za2+Ji48MqlgrSFbuOM/MnZvwUNG
         oGNg/s464/JofU9hulbIEm5U+SW2pqmACupgj7yb3WKiNjCqk5JyS7mSuQZ724uFjS7x
         0eUtlf6dU0Ut247o/ZLsY9FAfeUlgJT/PkjO4iDbGFLuUzn92nNYz+F5jOmEiIgjxRnL
         L10UlYzkmtiJS/z1+2r1mkFYF6Sd4uwZ7GIGbT2ZGwemeVKWs3NVMJXVueIvzGxPiW1Q
         iBil2wQTTZdUZr9Pr8zCxIuDD/+iBET8hU5uwqbopGQdvhbh8hcwOw3siVL9zIhmu1yo
         2I9Q==
X-Gm-Message-State: AOAM532HNy25ahws6WzK1ZYaSv+BZeiYK0viQLB9iO70n50h6lzrNxbR
        4nyowzraXxL0FzpOByCEkUBxAQ==
X-Google-Smtp-Source: ABdhPJxt6kFT7aaYzV2PxgSdguip72HDGxZwRYc1vD3JI8NzgMHgfVJWRaY7qs1AECSc9RTpJWT+dg==
X-Received: by 2002:a05:6512:3b2a:: with SMTP id f42mr938801lfv.282.1636567459495;
        Wed, 10 Nov 2021 10:04:19 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id h7sm53110lfu.253.2021.11.10.10.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:04:19 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCHv2] selftests: timens: exec: use 'labs()' over 'abs()'
Date:   Wed, 10 Nov 2021 19:03:59 +0100
Message-Id: <20211110180359.2338349-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
References: <CAK8P3a3ZuL9TQbj+tGkdvRRmEv_jT3OvzmaoFKHwdw=5J1w_SA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/timens with clang, the compiler warn about the
function abs() see below:

exec.c:33:8: error: absolute value function 'abs' given an argument of type 'long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
                        if (abs(tst.tv_sec - now.tv_sec) > 5)
                            ^
exec.c:33:8: note: use function 'labs' instead
                        if (abs(tst.tv_sec - now.tv_sec) > 5)
                            ^~~
                            labs

Rework to store the time difference in a 'long long' and pass that to
llabs(), since the variable can be an 'int', 'long' or 'long long'
depending on the architecture and C library.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/timens/exec.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..04439e6ac8a2 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -21,6 +21,7 @@
 int main(int argc, char *argv[])
 {
 	struct timespec now, tst;
+	long long timediff;
 	int status, i;
 	pid_t pid;
 
@@ -30,7 +31,8 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			timediff = tst.tv_sec - now.tv_sec;
+			if (llabs(timediff) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +52,8 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		timediff = tst.tv_sec - now.tv_sec;
+		if (llabs(timediff) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +73,8 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			timediff = tst.tv_sec - now.tv_sec - OFFSET;
+			if (llabs(timediff) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
-- 
2.33.0

