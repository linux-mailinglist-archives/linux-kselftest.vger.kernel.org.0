Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9449E79D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiA0Qeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiA0Qef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:34:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02EC06173B;
        Thu, 27 Jan 2022 08:34:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id DDBDA1F456FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643301274;
        bh=V2GLUi717w2Dlg/kVKUyboqPFORMhSh1EGPbc48EV4E=;
        h=From:To:Cc:Subject:Date:From;
        b=SUBNK8pnwILM1K0Csj0Uus7FV5e1yygSIKkvQ64ze9ZjgP5pqpZ5x0JI+hj1I+wAV
         1hnSQn8V+p41ovDO3d8Ylhd3qp/8/NExRE81pjqoUwD2WHgDomJ/xKfsFF58M0uXN+
         9E4PZgJC/Rsx831eGf/7NI5LrSiIy9skoH9RFQkDXpyvvmEMZxKhjz7WtMXfcQOxRl
         m4dbY8zJV9u0TkUYtc0bkIO5eLuVCCy7vMCFXX0ix+wPvYmbB101BS9zyCWDta4WSi
         qTlDFN7s3ApZb8V9l8Kya9OllGJhYggt16MKnNigi07/IIqBDEIMKs1YbJyzXCUk2c
         IjOOGRo16lTmw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/exec: Remove pipe from TEST_GEN_FILES
Date:   Thu, 27 Jan 2022 21:33:45 +0500
Message-Id: <20220127163346.653546-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

pipe named FIFO special file is being created in execveat.c to perform
some tests. Makefile doesn't need to do anything with the pipe. When it
isn't found, Makefile generates the following build error:

make: *** No rule to make target '/linux_mainline/tools/testing/selftests/exec/pipe', needed by 'all'.  Stop.

Fixes: 61016db15b8e ("selftests/exec: Verify execve of non-regular files fail")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66ed..12c5e27d32c16 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -5,7 +5,7 @@ CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script non-regular
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
-TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
+TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
-- 
2.30.2

