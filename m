Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143866DA4F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjDFVy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDFVy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1330DA5FF;
        Thu,  6 Apr 2023 14:54:54 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818092;
        bh=vTkw79wXmjqLnNQjs+gxqaE5Rm4KsNN2M5mSIaE9oJQ=;
        h=From:Subject:Date:To:Cc:From;
        b=Mm0s0hRgTzcaYnyrDom104CHBUL+Fjqf1lvCK9FOVsjcwpenNmlo/+HpFDmDRnxah
         82mKImdlWW7q9TNn15zik+TGvhLcTy8Y7stViTUx4aZ+m5dscpTsOhM8lLMAKBAZxQ
         6tDXoOFESU81HAtoirFavLl/u6s+zdBBjf3q3uTQ=
Subject: [PATCH v2 00/11] tools/nolibc: -std=c89 compatibility
Date:   Thu, 06 Apr 2023 21:54:46 +0000
Message-Id: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKY/L2QC/22NQQ6CMBBFr0JmbQ1tgVBX3sOwaOvUTkKK6QBqC
 He3snb5XvL/24AxEzJcqg0yrsQ0pQLqVIGPNj1Q0L0wqFrpWqtepGkk54U3RrQmNA3apu10B2X
 gLKNw2SYfyyQt41jkM2Og91G4DYUj8TzlzxFc5c/+/V6lkML2ulbBSROkub6QmNnHJZ4TzjDs+
 /4FrdzMCL4AAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=2524;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vTkw79wXmjqLnNQjs+gxqaE5Rm4KsNN2M5mSIaE9oJQ=;
 b=u8ffBBBHpKO4SHr4y2hSWddmtXo0ReO8KKTrSymF304NsOzmHrbKVqYAYkSMTc6v29MXR7vsg
 YhPYYU897SxBe+QxpBaPoOxMAwc9F7wDlTVpKWqCrNbmrAd3tgdrmBH
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

This series replaces the C99 compatibility patch. (See v1 link below).
After the discussion about support C99 and/or GNU89 I came to the
conclusion supporting straight C89 is not very hard.

Instead of validating both C99 and GNU89 in some awkward way only for
somebody requesting true C89 support let's just do it this way.

Feel free to squash all the comment syntax patches together if you
prefer.

All changes in this series are cosmetic only.

To: Willy Tarreau <w@1wt.eu>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

This series is based on the "dev" branch of the RCU tree.

---
Changes in v2:
- Target C89 instead of C99
- Link to v1: https://lore.kernel.org/r/20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net

---
Thomas Weißschuh (11):
      tools/nolibc: use standard __asm__ statements
      tools/nolibc: use __inline__ syntax
      tools/nolibc: i386: use C89 comment syntax
      tools/nolibc: x86_64: use C89 comment syntax
      tools/nolibc: riscv: use C89 comment syntax
      tools/nolibc: aarch64: use C89 comment syntax
      tools/nolibc: arm: use C89 comment syntax
      tools/nolibc: mips: use C89 comment syntax
      tools/nolibc: loongarch: use C89 comment syntax
      tools/nolibc: use C89 comment syntax
      tools/nolibc: validate C89 compatibility

 tools/include/nolibc/arch-aarch64.h          | 32 ++++++++--------
 tools/include/nolibc/arch-arm.h              | 42 ++++++++++-----------
 tools/include/nolibc/arch-i386.h             | 40 ++++++++++----------
 tools/include/nolibc/arch-loongarch.h        | 38 +++++++++----------
 tools/include/nolibc/arch-mips.h             | 56 ++++++++++++++--------------
 tools/include/nolibc/arch-riscv.h            | 40 ++++++++++----------
 tools/include/nolibc/arch-x86_64.h           | 34 ++++++++---------
 tools/include/nolibc/stackprotector.h        |  4 +-
 tools/include/nolibc/stdlib.h                | 18 ++++-----
 tools/include/nolibc/string.h                |  4 +-
 tools/include/nolibc/sys.h                   |  8 ++--
 tools/testing/selftests/nolibc/Makefile      |  2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++----
 13 files changed, 166 insertions(+), 166 deletions(-)
---
base-commit: bd5b341f0f69eb4c958ffd48699213c5b9af8145
change-id: 20230328-nolibc-c99-59f44ea45636

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

