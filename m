Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26094B13F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbiBJROM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:14:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245091AbiBJROM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:14:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C05BCD1;
        Thu, 10 Feb 2022 09:14:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 3755F1F46644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644513251;
        bh=7eKe9cr+drEikdGOCEKvZJjS+2opyiB5I/5QBobUyqg=;
        h=From:To:Cc:Subject:Date:From;
        b=Hu8sDjEJegZhxyoRsPrtPfobwZ0NYVhVnq6TxIfjDmkmW4PTxXJewDm8rBfrv4zsS
         Pb34c97Mkhl0YLVrK6Dp9+O6YQ58zqrWIqLWDPBiJIMMBgLPFs2NwKuZLnKXjLixM0
         ABIUbH9iR6p1fMgDtt2xIxHxGeJ9/F7qaLoQsD3Wgg+rEUFw8guhdRhF3sDTC93Eui
         uOyWEhw17vLUhOTCKyEEe8nNcw+nOWgIZrHnCwGYEc6VT+On17trV7bZwIN1DTHVj0
         qbFyDfjDsXyo32W7NtYyHLuVT/c0wO2yTZaq/l3evKwWX8ebHPyojAoAvvVgCngp3B
         AslsTHiY/74pQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/exec: Add non-regular to TEST_GEN_PROGS
Date:   Thu, 10 Feb 2022 22:13:23 +0500
Message-Id: <20220210171323.1304501-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

non-regular file needs to be compiled and then copied to the output
directory. Remove it from TEST_PROGS and add it to TEST_GEN_PROGS. This
removes error thrown by rsync when non-regular object isn't found:

rsync: [sender] link_stat "/linux/tools/testing/selftests/exec/non-regular" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]

Fixes: 0f71241a8e32 ("selftests/exec: add file type errno tests")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 551affb437fe1..a89ba6de79870 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,8 +3,8 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script non-regular
-TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
+TEST_PROGS := binfmt_script
+TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
-- 
2.30.2

