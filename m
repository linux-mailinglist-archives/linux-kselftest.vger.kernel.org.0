Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C041D6FF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 May 2020 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgERErq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 00:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERErq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 00:47:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B77C05BD09
        for <linux-kselftest@vger.kernel.org>; Sun, 17 May 2020 21:47:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so4373895pfw.13
        for <linux-kselftest@vger.kernel.org>; Sun, 17 May 2020 21:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=X/lhy2lqdLYOlnTnlwuNEX14NtdAXY44agjxDbsMHek=;
        b=avL6pZkUlCn+t3YkdiJMlLLxbozudebElBmHL2Tw6SfB9qnfnHabcBO154nR7cq50E
         nyJh5pPe9UlSBBXP2RjzipcR34z0Chi/1QkLlSg+oujwfALZuxmQbaWSHWomveBF/nPJ
         xM1LKug4z3C9em40JlstY1lONBmER/sBp3iFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=X/lhy2lqdLYOlnTnlwuNEX14NtdAXY44agjxDbsMHek=;
        b=kQMnNDZId26UB731cMPleSiJJeyDF3TT95mr5s+YM3p0t87AAjnSjC+JcUbGOy9DaV
         zLQPDKkufwtViAlG7S+dAuB7vEYSltCcn26INHWE7zDLzyPVDzee301i6Rw4zl8Y5L5f
         Dx6sx80jpzwi7+Amj88rNzfILbLhC45putwgwsVF865tbkGpTGDgv1Gaf4GSI/jVOFWZ
         NLDmAJ48mGMmhO6dxVbHNR9wVE9UYZm1JLUGDdAO4wM/SEOlgJ4jfuf69buJ6+abF+8+
         l1MrjDnA4ljdQVLakWHB2X7bVv8Mqr/oWePwbT0Frc4RgrQreZxF0rZ68HH5kAbz3axY
         zxaw==
X-Gm-Message-State: AOAM533SGLHIRYPuTFYd1Ew2PgjhLAS5Hf4otywOkZzoSTuZHgJ/ADPJ
        2p0gz/0Q8k47qTeuFBmLzhX2gw==
X-Google-Smtp-Source: ABdhPJyC+IQcZZeglGPmJ9VEQKllWJvgBjA2CQs/cdQJaDsi3Z/YHvSXoNagRTwXLs2GUZqe6cjPeA==
X-Received: by 2002:a63:df4f:: with SMTP id h15mr13604951pgj.30.1589777265568;
        Sun, 17 May 2020 21:47:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6sm7259713pjx.48.2020.05.17.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 21:47:44 -0700 (PDT)
Date:   Sun, 17 May 2020 21:47:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        David Drysdale <drysdale@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/exec: Verify execve of non-regular files fail
Message-ID: <202005172143.D25AC29@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a named pipe as an exec target to make sure that non-regular
files are rejected by execve() with EACCES. This can help verify
commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
during execve()").

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/exec/.gitignore | 1 +
 tools/testing/selftests/exec/Makefile   | 2 +-
 tools/testing/selftests/exec/execveat.c | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index c078ece12ff0..94b02a18f230 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,3 +9,4 @@ execveat.ephemeral
 execveat.denatured
 /recursion-depth
 xxxxxxxx*
+pipe
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 33339e31e365..cfafa1f8a2fa 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS := execveat
-TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
+TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index cbb6efbdb786..67bf7254a48f 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -5,7 +5,9 @@
  * Selftests for execveat(2).
  */
 
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE  /* to get O_PATH, AT_EMPTY_PATH */
+#endif
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -311,6 +313,10 @@ static int run_tests(void)
 	fail += check_execveat_fail(AT_FDCWD, fullname_symlink,
 				    AT_SYMLINK_NOFOLLOW, ELOOP);
 
+	/*  Non-regular file failure */
+	fail += check_execveat_fail(dot_dfd, "pipe", 0, EACCES);
+	unlink("pipe");
+
 	/* Shell script wrapping executable file: */
 	/*   dfd + path */
 	fail += check_execveat(subdir_dfd, "../script", 0);
@@ -384,6 +390,8 @@ static void prerequisites(void)
 	fd = open("subdir.ephemeral/script", O_RDWR|O_CREAT|O_TRUNC, 0755);
 	write(fd, script, strlen(script));
 	close(fd);
+
+	mkfifo("pipe", 0755);
 }
 
 int main(int argc, char **argv)
-- 
2.20.1


-- 
Kees Cook
