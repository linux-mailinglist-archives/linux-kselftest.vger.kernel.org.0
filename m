Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A733E768BFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGaG1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGaG1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:27:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B74E40;
        Sun, 30 Jul 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690784818;
        bh=4w2nINR/K2xvwLfxuKBUzbOaWRSRya4sRMSwVWQU2Io=;
        h=From:Subject:Date:To:Cc:From;
        b=cdQ3TjA782AVzFjUCU6aXgX0KnvkzowiP74CqFJV3WQODhs/bwjLcYn964JDLkw+y
         Tk4jXqxQ4S561fjVrtOChB3gm7PCbxHz9RjNCVRpckzio5lRritTk1SxsFJ53CtUtp
         UScXZA4XYPGqU7QWnciswi9Xj0PV07RZ/JbJIxB4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] tools/nolibc: enable compiler warnings
Date:   Mon, 31 Jul 2023 08:26:55 +0200
Message-Id: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC9Ux2QC/x3MSwqAMAwA0atI1hb6ERWvIi5qjRqQVBpQQXp3i
 8u3mHlBMBEKDNULCS8Silxg6grC7nlDRUsxWG2d7pxRHA+ag7p9YuJNVGix6Wzf+KAdlOpMuNL
 zH8cp5w+dv4tEYQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690784818; l=805;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4w2nINR/K2xvwLfxuKBUzbOaWRSRya4sRMSwVWQU2Io=;
 b=Q7VfJ6b1xEUwhtQb6Ewpwi4/cl9YK3gaFVrCi2EYIhdSv28HaFiTbpqtKBoPSWmtfBspjqzC0
 upIs9s84qkTCkbLBuEGHDaWgQMm5cZlj1spcXvXx8eDnFLqHwhEQprJ
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

To help the developers to avoid mistakes and keep the code smaller let's
enable compiler warnings.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      selftests/nolibc: drop unused test helpers
      selftests/nolibc: drop unused variables
      tools/nolibc: drop unused variables
      selftests/nolibc: enable -Wall compiler warnings

 tools/include/nolibc/sys.h                   |   1 -
 tools/testing/selftests/nolibc/Makefile      |   2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 103 ---------------------------
 3 files changed, 1 insertion(+), 105 deletions(-)
---
base-commit: dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf
change-id: 20230731-nolibc-warnings-c6e47284ac03

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

