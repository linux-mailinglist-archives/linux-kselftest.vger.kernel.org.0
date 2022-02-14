Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C764B55A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiBNQIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 11:08:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbiBNQIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 11:08:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B349F97;
        Mon, 14 Feb 2022 08:08:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id D303C1F43DBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644854905;
        bh=aJsSEXf1LJvbiDXIpOJk5PLiUdc/g9YrvOrNGjI88oo=;
        h=From:To:Cc:Subject:Date:From;
        b=U+cM9tRoLy6qCMzSaQWPpmBDcHcYKhrWG1v0A85bD5Zm8cc+ytYZvtImj3axC+m1e
         veew8NkjIDmonpu7Dn92nl1J9Bqw84+6MVhVnSh1WIrIj3DF1pBW2StU+W5k7MtLyg
         usRG+e+t7rH7vlC8Ves0nswrY5bFVWjckrc3SVrzmKrjT129wNU4W1edIqIPYJSYdo
         W07xl5/Fdtxd3Y9Sm4D0nLyssLbdFzK2zTPFn5tq3NxUKABZKwmYMxS6RFuktlyncp
         EujRRhoeQU2ZWyfrya8Ha7lbNkNV7iY3mE8nL7jLld6ilYOY+HGiwpQEZE8AjdlMXB
         JqD9sKh+vZiMw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, sherry.yang@oracle.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] selftests: Use -isystem instead of -I to include headers
Date:   Mon, 14 Feb 2022 21:07:56 +0500
Message-Id: <20220214160756.3543590-1-usama.anjum@collabora.com>
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

Selftests need kernel headers and glibc for compilation. In compilation
of selftests, uapi headers from kernel source are used instead of
default ones while glibc has already been compiled with different header
files installed in the operating system. So there can be redefination
warnings from compiler. These warnings can be suppressed by using
-isystem to include the uapi headers.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V2:
Remove debug code
---
 tools/testing/selftests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4eda7c7c15694..06cc683f81b1a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,11 +130,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -I${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -I${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
-- 
2.30.2

