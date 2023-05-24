Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF270EE65
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbjEXGqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 02:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjEXGpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 02:45:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0C18D;
        Tue, 23 May 2023 23:44:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684910688;
        bh=O1oDBEfZrMirjlbecuPJrH574m6Ohdf1ItbhTKlrEjI=;
        h=From:Subject:Date:To:Cc:From;
        b=ht2yqTZeKv6LzUZha6EPeYtNgnQRnSMKkCA3G2s4yGzdGgvtCc3O+Wan3e1ulQ83c
         5hCznMkRAXJtg0maOrsfdhdZx0HByzK8GLS/YPQs1U7yI3vZkvH5po12GhNTTF+0ze
         hGWJUTVA8Iz2jNwZPB5fYSbOaIZl8uc9hZNbqPrQ=
Subject: [PATCH 0/3] tools/nolibc: stack protector compatibility fixes
Date:   Wed, 24 May 2023 08:44:41 +0200
Message-Id: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFmybWQC/x2NQQrCMBAAv1L27EKaorZ+RTwk27VdDEnZjSKU/
 t3gceYws4OxChvcuh2UP2JScoP+1AGtIS+MMjcG7/zgzn7AXJJEQquBXpuWylSL4kI04cgc596
 F63QZoQViMMaoIdPaEvmdUpOb8lO+/+P9cRw/ZUPgcoEAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684910688; l=1233;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=O1oDBEfZrMirjlbecuPJrH574m6Ohdf1ItbhTKlrEjI=;
 b=/4nb//vyfjDcXpmlXxL6cXxCgsjdFwq/fOL3SDCndBD3Ho39yWGtHbc5aYy8INfLQ+9gqYixE
 Xdusi0/HrzoBOe0uylH/Trhw7P0CNYYax0D1nidOclWIShxD6GWZrMp
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

Two fixes for nolibc to
* allow users to explicitly disable (or theoretically enable) when
  building the tests
* fix stackprotectors on GCC < 10.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      Revert "EXP: tools/nolibc: partially revert stackprotector compiler flags"
      selftests/nolibc: allow disabling of stackprotector support
      tools/nolibc: fix segfaults on compilers without attribute no_stack_protector

 tools/include/nolibc/arch-aarch64.h     |  2 +-
 tools/include/nolibc/arch-arm.h         |  2 +-
 tools/include/nolibc/arch-i386.h        |  2 +-
 tools/include/nolibc/arch-loongarch.h   |  2 +-
 tools/include/nolibc/arch-mips.h        |  2 +-
 tools/include/nolibc/arch-riscv.h       |  2 +-
 tools/include/nolibc/arch-x86_64.h      |  2 +-
 tools/include/nolibc/compiler.h         | 10 ++++++++++
 tools/include/nolibc/stackprotector.h   |  2 +-
 tools/testing/selftests/nolibc/Makefile | 13 ++-----------
 10 files changed, 20 insertions(+), 19 deletions(-)
---
base-commit: 8213b0cdb51d1f66af713e00fd0dff3c2eb47636
change-id: 20230523-nolibc-stackprotector-gcc9-8eebd10a7968

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

