Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C97DD71F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjJaUhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJaUhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 16:37:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA72F5;
        Tue, 31 Oct 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698784621;
        bh=jlAbfNYACjNJjKtpx27+AybaIT1vLObKwRQCYdPObvM=;
        h=From:Subject:Date:To:Cc:From;
        b=hNWbXGf5HtjYYV+0IjPNEgLqRpHSl9Dq9AJ1js9ZF8ziFGmwgYpABdF/nQTpRvKcw
         2bLFuZQAdVJuKaATCkOskOPNK1Rs5i0Gp9Gz2/LfaZriwtmZrQHwrgr9OMLTqQsS2F
         lFStoFFVCnTGcyjt1PZM45ZLoIuK4hi2EFLu5HyE=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] selftests/nolibc: various build improvements
Date:   Tue, 31 Oct 2023 21:36:57 +0100
Message-Id: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGllQWUC/x3MQQqAIBBA0avErBvQDImuEi1qGmsgNLQiCO+et
 HyL/19IHIUT9NULkW9JEnyBriugbfIroyzF0KjGaKUV+rDLTBiuE4PDMzLjbG3XkiWn2EAJj8h
 Onn86jDl/NR3GN2QAAAA=
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698784620; l=1914;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jlAbfNYACjNJjKtpx27+AybaIT1vLObKwRQCYdPObvM=;
 b=39z+cJviAk93z1WR2YzBPJR6rzhr9MZIud9TBlyeTMawOGUrta8txC71uaEvxzf3aXef1AnSO
 dMLBlwcnhNHBf2cdpFaKzfGfDeidtx0+sQJQqfd8mPdKGx68QMDUrFy
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

With the out-of-tree builds it's possible do incremental tests fairly fast:

time ./run-tests.sh 
i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning

real	1m56.226s
user	2m42.457s
sys	0m57.979s

This is with an incremental kernel rebuild and testrun inside qemu.

---
Changes in v2:
- Drop already applied qemu-system-ppc64le patch
- Drop config generation patch
- Add Co-developed-by for out-of-tree patch
- Link to v1: https://lore.kernel.org/lkml/20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net/

---
Thomas Weißschuh (3):
      selftests/nolibc: use EFI -bios for LoongArch qemu
      selftests/nolibc: anchor paths in $(srcdir) if possible
      selftests/nolibc: support out-of-tree builds

 tools/testing/selftests/nolibc/Makefile | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 5a6a09e97199d6600d31383055f9d43fbbcbe86f
change-id: 20231010-nolibc-out-of-tree-b6684c6cf0e3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

