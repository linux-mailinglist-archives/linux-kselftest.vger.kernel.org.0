Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2826D70AD45
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEUJhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D0119;
        Sun, 21 May 2023 02:36:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=IRUupTWokl6bSvN/Qk4Ov6+kUGTwoo0KFMWwChixIDM=;
        h=From:Subject:Date:To:Cc:From;
        b=cqxlSIQDXcaATq4ZkEomg3mY2IIrtqss61smptg9yb0lL1E7hdITHmKOiQkYwWMPr
         dSUmlXT3YXWXIAj6wIKV373n/HOdFYkU8neAUuRNG4U2Y55s6Mf3AQV4YgSKua8BCn
         gEy2ZeaIjLoDyfdEpiNxt0KJb6Awa7KExEknuKus=
Subject: [PATCH 0/7] tools/nolibc: autodetect stackprotector availability
 from compiler
Date:   Sun, 21 May 2023 11:36:28 +0200
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABzmaWQC/x2NQQrCMBAAv1L27EIbraJfkR4268YuxqRsUhFK/
 27wOHOY2aCIqRS4dRuYfLRoTg2GQwc8U3oK6qMxuN4d+9ENmHJUz0hrzW+qylgq8QsXy1W4ZkN
 /CpdA/ipnN0LLeCqC3ijx3EJpjbHJxSTo9/+9T/v+A6RUit+HAAAA
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=1743;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IRUupTWokl6bSvN/Qk4Ov6+kUGTwoo0KFMWwChixIDM=;
 b=+KCHXIX7ZFxeWvKYgiPiXSHck8c9OJAqiZ1m8d98eL9+rckJEWvb6uDCavW+0/kuvJ7Fdte+g
 m1VE13Y0y6WDZ5dPNcWR/VP/9J98CEzoH+Wt4RH1E7OYcJxR3RLRXIu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As suggested by Willy it is possible to detect the availability of
stackprotector via preprocessor defines.
Make use of that to simplify the code and interface of nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (7):
      tools/nolibc: fix typo pint -> point
      tools/nolibc: x86_64: disable stack protector for _start
      tools/nolibc: ensure stack protector guard is never zero
      tools/nolibc: add test for __stack_chk_guard initialization
      tools/nolibc: reformat list of headers to be installed
      tools/nolibc: add autodetection for stackprotector support
      tools/nolibc: simplify stackprotector compiler flags

 tools/include/nolibc/Makefile                | 19 +++++++++++++++++--
 tools/include/nolibc/arch-aarch64.h          |  6 +++---
 tools/include/nolibc/arch-arm.h              |  6 +++---
 tools/include/nolibc/arch-i386.h             |  6 +++---
 tools/include/nolibc/arch-loongarch.h        |  6 +++---
 tools/include/nolibc/arch-mips.h             |  6 +++---
 tools/include/nolibc/arch-riscv.h            |  6 +++---
 tools/include/nolibc/arch-x86_64.h           |  8 ++++----
 tools/include/nolibc/arch.h                  |  2 +-
 tools/include/nolibc/compiler.h              | 15 +++++++++++++++
 tools/include/nolibc/stackprotector.h        | 15 ++++++---------
 tools/testing/selftests/nolibc/Makefile      | 13 ++-----------
 tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++++-
 13 files changed, 72 insertions(+), 46 deletions(-)
---
base-commit: 606343b7478c319cb30291a39ecbceddb42229d6
change-id: 20230521-nolibc-automatic-stack-protector-b4f7fab9e625

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

