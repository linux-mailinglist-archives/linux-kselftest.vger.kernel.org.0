Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5D6C1A46
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCTPu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjCTPtp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B94484;
        Mon, 20 Mar 2023 08:41:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326880;
        bh=HEy3v+RR70w+a7+c3eh2YZR6p30gJnTpTFORFe8VIEI=;
        h=From:Subject:Date:To:Cc:From;
        b=nGNOK8CeDsVx2fMzR+QypyAeX6isAJW7ZjyX3OWtR6Zt0CXKLgYQNvKucKvm1gZM8
         7pdBSFp7MfsmKZe8XqBhT86Npi4pleyFjS04hbfsmfQe1z8yQD6knjz+yw3tpoTbe0
         mnWZAcanh6CsnlytO3h++ZCBkz5lRREs06ZdAAqw=
Subject: [PATCH v2 0/8] tools/nolibc: add support for stack protector
Date:   Mon, 20 Mar 2023 15:41:00 +0000
Message-Id: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI1+GGQC/4WNSwrCMBQAr1KyNtIklRZX3kO6yOfFPCxJyUurU
 np3Yy/gcgaG2RhBRiB2bTaWYUXCFCvIU8Ns0PEBHF1lJlupWikVj2lCYzkVbZ9zTgVsSZm7zl1
 8N3jf94LV1mgCbrKONtQ6LtNU5ZzB4/uY3cfKAam2n+O9ip/9t1kFb7mCvnODMMpLcXsBEpENS
 zhHKGzc9/0LwWy0GNQAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326877; l=2615;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HEy3v+RR70w+a7+c3eh2YZR6p30gJnTpTFORFe8VIEI=;
 b=C7AOi+lgXBPeINSgzKlo1KMxZgZHKMecHalkVsYS98wdSkCFiyVkexc3v2Acluzpa/vAC5tIq
 +ptBs7+Jz4RC+4+wrSW4he5ZEMh9+hmR4fArciX6Xb53Yi2hp3VegHk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful when using nolibc for security-critical tools.
Using nolibc has the advantage that the code is easily auditable and
sandboxable with seccomp as no unexpected syscalls are used.
Using compiler-assistent stack protection provides another security
mechanism.

For this to work the compiler and libc have to collaborate.

This patch adds the following parts to nolibc that are required by the
compiler:

* __stack_chk_guard: random sentinel value
* __stack_chk_fail: handler for detected stack smashes

In addition an initialization function is added that randomizes the
sentinel value.

Only support for global guards is implemented.
Register guards are useful in multi-threaded context which nolibc does
not provide support for.

Link: https://lwn.net/Articles/584225/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Code and comments style fixes
- Only use raw syscalls in stackprotector functions
- Remove need for dedicated entrypoint and exec() during tests
- Add more rationale
- Shuffle some code around between commits
- Provide compatibility with the -fno-stack-protector patch
- Remove RFC status
- Link to v1: https://lore.kernel.org/r/20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net

This series is based on the current rcu/dev branch of Pauls rcu tree.

---
Thomas Weißschuh (8):
      tools/nolibc: add definitions for standard fds
      tools/nolibc: add helpers for wait() signal exits
      tools/nolibc: tests: constify test_names
      tools/nolibc: add support for stack protector
      tools/nolibc: tests: fold in no-stack-protector cflags
      tools/nolibc: tests: add test for -fstack-protector
      tools/nolibc: i386: add stackprotector support
      tools/nolibc: x86_64: add stackprotector support

 tools/include/nolibc/Makefile                |  4 +-
 tools/include/nolibc/arch-i386.h             |  7 ++-
 tools/include/nolibc/arch-x86_64.h           |  5 +++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/stackprotector.h        | 53 +++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  2 +
 tools/include/nolibc/unistd.h                |  5 +++
 tools/testing/selftests/nolibc/Makefile      | 11 ++++-
 tools/testing/selftests/nolibc/nolibc-test.c | 64 ++++++++++++++++++++++++++--
 9 files changed, 144 insertions(+), 8 deletions(-)
---
base-commit: a9b8406e51603238941dbc6fa1437f8915254ebb
change-id: 20230223-nolibc-stackprotector-d4d5f48ff771

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

