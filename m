Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9272576E15B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjHCH24 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjHCH2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBCB273A;
        Thu,  3 Aug 2023 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047728;
        bh=yUN4esrnjSf2QnQqSCJ5RZKfG0ro2Q4ZXEhcrqDqpVQ=;
        h=From:Subject:Date:To:Cc:From;
        b=Rt7/42HbfJMXfH0q+rozysM+jqki+XD/tikWspdFlmN7e3zS736J9KKR/p+da3LN9
         ESudZ4J4W6iDOoWCeWITo3FiZWL6K10Uxf3Ll1LkIfv1BdL3vYILDRAYLtGnufzMZb
         6ezKVKeuo3THIwXhdR+gKxVvDBNFwR3Fpf7ukb8Q=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 00/14] tools/nolibc: enable compiler warnings
Date:   Thu, 03 Aug 2023 09:28:44 +0200
Message-Id: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACxXy2QC/3XNyw6CMBCF4VchXVvTC1hw5XsYF71JJzHFdLBoC
 O9uYeNCXf4nmW9mgj6BR3KsZpJ8BoQhlpC7itigY+8puNJEMCGZkpzG4QbG0kmnCLFHag++VqK
 ttWWSlKt78ld4buL5UjoAjkN6bQ8yX9f/VuaUUVV3SjqhG+HUafKAiDY8wj76kaxgFh+kZT8QU
 RBudGN1o4zrzBeyLMsb6xL6BPgAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=2437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yUN4esrnjSf2QnQqSCJ5RZKfG0ro2Q4ZXEhcrqDqpVQ=;
 b=TG485rZisHA4z6ZfIV+sunCuM4M9eteDd86I4C44cBu2QqtI+gX7t2nXHVhuEBmrQRw+4CMYU
 s5iSqLSTuOaDGVfVGddW9zXyZjfLJCHrmhduqepHMgYyVp9zfAu52DB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To help the developers to avoid mistakes and keep the code smaller let's
enable compiler warnings.

I stuck with __attribute__((unused)) over __maybe_unused in
nolibc-test.c for consistency with nolibc proper.
If we want to add a define it needs to be added twice once for nolibc
proper and once for nolibc-test otherwise libc-test wouldn't build
anymore.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Make getpagesize() return "int"
- Simplify validation of read() return value
- Don't make functions static that are to be used as breakpoints
- Drop -s from LDFLAGS
- Use proper types for read()/write() return values
- Fix unused parameter warnings in new setvbuf()
- Link to v2: https://lore.kernel.org/r/20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net

Changes in v2:
- Don't drop unused test helpers, mark them as __attribute__((unused))
- Make some function in nolibc-test static
- Also handle -W and -Wextra
- Link to v1: https://lore.kernel.org/r/20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net

---
Thomas Weißschuh (14):
      tools/nolibc: drop unused variables
      tools/nolibc: fix return type of getpagesize()
      tools/nolibc: setvbuf: avoid unused parameter warnings
      tools/nolibc: sys: avoid implicit sign cast
      tools/nolibc: stdint: use int for size_t on 32bit
      selftests/nolibc: drop unused variables
      selftests/nolibc: mark test helpers as potentially unused
      selftests/nolibc: make functions static if possible
      selftests/nolibc: avoid unused parameter warnings
      selftests/nolibc: avoid sign-compare warnings
      selftests/nolibc: use correct return type for read() and write()
      selftests/nolibc: prevent out of bounds access in expect_vfprintf
      selftests/nolibc: don't strip nolibc-test
      selftests/nolibc: enable compiler warnings

 tools/include/nolibc/stdint.h                |   4 +
 tools/include/nolibc/stdio.h                 |   5 +-
 tools/include/nolibc/sys.h                   |   7 +-
 tools/testing/selftests/nolibc/Makefile      |   4 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 111 ++++++++++++++++-----------
 5 files changed, 80 insertions(+), 51 deletions(-)
---
base-commit: bc87f9562af7b2b4cb07dcaceccfafcf05edaff8
change-id: 20230731-nolibc-warnings-c6e47284ac03

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

