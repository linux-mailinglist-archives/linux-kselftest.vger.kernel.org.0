Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570F37BFB8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjJJMeT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJJMeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8824116;
        Tue, 10 Oct 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941245;
        bh=xz9AlPCf/z9+9TDfxkF37vrowjGHyQ40QbM+LPmN6os=;
        h=From:Subject:Date:To:Cc:From;
        b=oXUzPnSAYh2LiwGrAzzO0xJa6M9hD8I9THxfvMpWrJGPknP/aLt40dBsAJu2op+cV
         k4p1p3ZJpmaNKZFmNvDTyl8Sp8xL8z5T6MlYpCQPzlrGDj3k7y2TOi7RvewJkBPzz0
         BjpB20L/cDI85LTB8JHTFOJYP625B5uM9AyQInQg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] selftests/nolibc: various build improvements
Date:   Tue, 10 Oct 2023 14:33:55 +0200
Message-Id: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALNEJWUC/x3MQQqAIBBA0avErBvQDImuEi1qGmsgNLQiCO+et
 HyL/19IHIUT9NULkW9JEnyBriugbfIroyzF0KjGaKUV+rDLTBiuE4PDMzLjbG3XkiWn2EAJj8h
 Onn86jDl/NR3GN2QAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=2014;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xz9AlPCf/z9+9TDfxkF37vrowjGHyQ40QbM+LPmN6os=;
 b=CrPfvVlqiWfhjmAup1YvUArcIdL1+aNanpjgYlEzkGRyXr2XiDKZOwWKIrC1g30WkaYlTUNUI
 4wl7NN/QdAoDzxQK+h6kJvWHLvhU4G6w4xAl16iiJF3/AY2Mc6QtcPG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the out-of-tree builds it's possible do incremental tests fairly fast:

$ time ./run-tests.sh
i386:          160 test(s): 160 passed,   0 skipped,   0 failed => status: success
x86_64:        160 test(s): 160 passed,   0 skipped,   0 failed => status: success
arm64:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
arm:           160 test(s): 160 passed,   0 skipped,   0 failed => status: success
mips:          160 test(s): 159 passed,   1 skipped,   0 failed => status: warning
ppc:           160 test(s): 160 passed,   0 skipped,   0 failed => status: success
ppc64:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
ppc64le:       160 test(s): 160 passed,   0 skipped,   0 failed => status: success
riscv:         160 test(s): 160 passed,   0 skipped,   0 failed => status: success
s390:          160 test(s): 159 passed,   1 skipped,   0 failed => status: warning
loongarch:     160 test(s): 159 passed,   1 skipped,   0 failed => status: warning

real    3m11.735s
user    4m20.354s
sys     1m11.880s

This is with an incremental kernel rebuild and testrun inside qemu.

Note:

"selftests/nolibc: use qemu-system-ppc64 also for ppc64le" was already
submitted standalone but I included it here again for easier testing and
review.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      selftests/nolibc: use qemu-system-ppc64 also for ppc64le
      selftests/nolibc: use EFI -bios for LoongArch qemu
      selftests/nolibc: anchor paths in $(srcdir) if possible
      selftests/nolibc: support out-of-tree builds
      selftests/nolibc: generate config automatically

 tools/testing/selftests/nolibc/Makefile | 36 +++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)
---
base-commit: d423dcd4ac21041618ab83455c09440d76dbc099
change-id: 20231010-nolibc-out-of-tree-b6684c6cf0e3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

