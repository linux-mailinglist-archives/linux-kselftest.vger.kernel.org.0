Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D207A3666
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjIQPgd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjIQPg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5663FA;
        Sun, 17 Sep 2023 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694964978;
        bh=QYp1kQc8N8Jo6r2r7V5ChIUb67vWKSQCfxIebMcHTzM=;
        h=From:Subject:Date:To:Cc:From;
        b=Nv/p2LKt6eDABN8iI6EHm8oFLoLEjaicYtUJxMBopAuLPe01M845NIlCVq+LgZJme
         1pnyH1nQl5TtZbasgO80ZOSqoH6MHxzk7u0Mr5RlJe0QztyVTptEm5RxubNNvojcLn
         1jykhwy6Mq3tC86lXk2Qdrunhw/0n9bCqKYQ/KEw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/4] tools/nolibc: cleanups for syscall fallbacks
Date:   Sun, 17 Sep 2023 17:36:15 +0200
Message-Id: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPAcB2UC/32NQQrCMBBFr1Jm7UgSU7CuvId0EdOpGSiJZGq0l
 N7d2AO4fA/++ysIZSaBS7NCpsLCKVYwhwZ8cPFByENlMMqcVKctxjTx3aMs4t00YczYuXZsrfV
 n21mou2emkT9789ZXDixzyst+UfTP/qsVjQqpVcNotRqc1tc3sYj48ArHSDP027Z9AdDA1U+3A
 AAA
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964977; l=1049;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QYp1kQc8N8Jo6r2r7V5ChIUb67vWKSQCfxIebMcHTzM=;
 b=KtgHX5jQwe8n9MP2CPv9wq5NxMPUMisGTWElmuZY5m6r7CHIKyWQqL/+xc+B9VHnBleufJJnt
 ZjZm4+aGSYICgZCu+glc2zlAWqjK1RYtt4XubmN1DLKS/uTfnaEvGYd
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Replace manual casts to (void) with __nolibc_enosys helpers
- Link to v1: https://lore.kernel.org/r/20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net

---
Thomas Weißschuh (4):
      selftests/nolibc: allow building i386 with multiarch compiler
      tools/nolibc: avoid unused parameter warnings for ENOSYS fallbacks
      tools/nolibc: don't define new syscall number
      tools/nolibc: automatically detect necessity to use pselect6

 tools/include/nolibc/arch-aarch64.h     |  3 --
 tools/include/nolibc/arch-loongarch.h   |  4 +--
 tools/include/nolibc/arch-riscv.h       |  3 --
 tools/include/nolibc/sys.h              | 55 +++++++++++++++++++--------------
 tools/testing/selftests/nolibc/Makefile |  1 +
 5 files changed, 34 insertions(+), 32 deletions(-)
---
base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
change-id: 20230914-nolibc-syscall-nr-9a5f544c8494

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

