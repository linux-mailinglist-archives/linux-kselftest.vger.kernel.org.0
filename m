Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639D26D39B1
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjDBSEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjDBSEq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 14:04:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D1526C;
        Sun,  2 Apr 2023 11:04:45 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680458683;
        bh=pHLKhMFkF7gynF7dKsz0mx/ghrke0CAkg+O7mwjoO8c=;
        h=From:Subject:Date:To:Cc:From;
        b=oMOT6TZyAHkzrZo1VxtS/bIthJsYW8wUkJUp9ULS2iPukfQicfnOtZU9Zs9jxO4Zv
         lhELqsolT8rtnDbD4rOOXgfSmB3t35Irb50XRwczV8sZ+nH5AaPA2mtBxaqLd9/uv5
         VwXQX+gtvLDvW3qOjGXqjKcQxwvYWXmlWvAZUnaI=
Subject: [PATCH v3 0/4] tools/nolibc: add testcases for vfprintf
Date:   Sun, 02 Apr 2023 18:04:33 +0000
Message-Id: <20230328-nolibc-printf-test-v3-0-ddc79f92efd5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALLDKWQC/32NQQ6CMBAAv0J6dk1ZQkRP/sNwaMvWbkIK6RbUE
 P5u5QEeZ5LJbEooMYm6VZtKtLLwFAs0p0q5YOKTgIfCCjU2usEO4jSydTAnjtlDJsmgWxxaYx3
 WdadKaI0Q2GSiCyWNyzgWOSfy/D5Oj75wYMlT+hzjFX/272NF0OAvaAePta6v+v4iFhEXlnCOl
 FW/7/sXkAyHQc4AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680458682; l=1453;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pHLKhMFkF7gynF7dKsz0mx/ghrke0CAkg+O7mwjoO8c=;
 b=1EETe+2UjrvlGI1LlrXqhh1QmdJIW+3tsIwwwVP4B6VHuvNJfWnsUm+mVYUwrOs04R/Z6qfzX
 hYUI61l9STWAfQT6ifNUKMhJZC4HVGmZn9ONgRY6QIAUKR2Q4EkOV2Y
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vfprintf() is complex and so far did not have proper tests.

This series is based on the "dev" branch of the RCU tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- also provide and use fflush/fclose.
- reject fileno(NULL).
- provide compatability with buffered streams from glibc.
- Link to v2: https://lore.kernel.org/r/20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net

Changes in v2:
- Include <sys/mman.h> for tests.
- Implement FILE* in terms of integer pointers.
- Provide fdopen() and fileno().
- Link to v1: https://lore.kernel.org/lkml/20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net/

---
Thomas Weißschuh (4):
      tools/nolibc: add libc-test binary
      tools/nolibc: add wrapper for memfd_create
      tools/nolibc: implement fd-based FILE streams
      tools/nolibc: add testcases for vfprintf

 tools/include/nolibc/stdio.h                 | 95 ++++++++++++++++++++--------
 tools/include/nolibc/sys.h                   | 23 +++++++
 tools/testing/selftests/nolibc/.gitignore    |  1 +
 tools/testing/selftests/nolibc/Makefile      |  5 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 86 +++++++++++++++++++++++++
 5 files changed, 183 insertions(+), 27 deletions(-)
---
base-commit: a63baab5f60110f3631c98b55d59066f1c68c4f7
change-id: 20230328-nolibc-printf-test-052d5abc2118

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

