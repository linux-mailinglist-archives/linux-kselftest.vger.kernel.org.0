Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB576A848
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHAFaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHAFaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69931FCE;
        Mon, 31 Jul 2023 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867812;
        bh=xnVP4gFdYdwiynw59j3RfiQh37cKUd6vWBUWUZdEilI=;
        h=From:Subject:Date:To:Cc:From;
        b=emNZ+57FbrOqft2YmdCG3vX/KXJvDNP0aiJ1oyRql8RmVFLnY6m0MzTcHpgQPXt9x
         w4qiBLlXJ4jOAw2g0knFb/CJcRCK/TFZXVgunmP/Gip73r00dqFNa3v3PwbIobPbra
         78HGoo1+noOLSqbijLWOf78aT42TAJve41mbI1i0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 00/10] tools/nolibc: enable compiler warnings
Date:   Tue, 01 Aug 2023 07:30:07 +0200
Message-Id: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGCYyGQC/3WNQQ7CIBBFr9LMWgwFFHXlPUwXSMcyiaENU6mm4
 e5i9y7fS/77KzAmQoZLs0LCTExjrKB2Dfjg4oCC+sqgpNLS6lbE8Ul3LxaXIsWBhT+isepknJc
 a6mpK+KD3Vrx1lQPxPKbPdpDbn/3fyq2Qwpqz1b1yB9Xb64LEzD68wj7iDF0p5QuyMRS0swAAA
 A==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=1750;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xnVP4gFdYdwiynw59j3RfiQh37cKUd6vWBUWUZdEilI=;
 b=weqVOfZlOxGeB+2n6r5XlXzHkkxGq23nu/WtQpGNpKprxfAL0USYwUXkfQvQ3ku81Bhjcw7uk
 AXeow8Ll2/0DJokl+xQg2GaMTOfV5qF+bfn7GVFjFIaxkUEeEt7ti6l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v2:
- Don't drop unused test helpers, mark them as __attribute__((unused))
- Make some function in nolibc-test static
- Also handle -W and -Wextra
- Link to v1: https://lore.kernel.org/r/20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net

---
Thomas Weißschuh (10):
      tools/nolibc: drop unused variables
      tools/nolibc: sys: avoid implicit sign cast
      tools/nolibc: stdint: use int for size_t on 32bit
      selftests/nolibc: drop unused variables
      selftests/nolibc: mark test helpers as potentially unused
      selftests/nolibc: make functions static if possible
      selftests/nolibc: avoid unused arguments warnings
      selftests/nolibc: avoid sign-compare warnings
      selftests/nolibc: test return value of read() in test_vfprintf
      selftests/nolibc: enable compiler warnings

 tools/include/nolibc/stdint.h                |   4 +
 tools/include/nolibc/sys.h                   |   3 +-
 tools/testing/selftests/nolibc/Makefile      |   2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 108 +++++++++++++++++----------
 4 files changed, 74 insertions(+), 43 deletions(-)
---
base-commit: dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf
change-id: 20230731-nolibc-warnings-c6e47284ac03

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

