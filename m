Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF746AF889
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGWXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCGWW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:22:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC24A4B2D;
        Tue,  7 Mar 2023 14:22:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227762;
        bh=kgcKp/6qGiFaqBrzwsbN0tNUCKiKFuSQnGedC4rFcio=;
        h=From:Subject:Date:To:Cc:From;
        b=naW7o5lCeB/nUleImnp+h+9gLyPBxPTao9FDtTbr/86omhIELCgYKidsfqduXQWLO
         33V8jHAzuTvCfGz+sU2CPYnjN8CeERJkBukYdjfAYfIdDgbDeoQq4Dfe08l72qiY0F
         kVjyLBf1isto0e1OdQIGZWt8zrE8O6pAGuMiHNvk=
Subject: [PATCH RFC 0/5] tools/nolibc: add support for stack protector
Date:   Tue, 07 Mar 2023 22:22:29 +0000
Message-Id: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACW5B2QC/x2NywrCMBAAf6Xs2UCbVipeBT/Aq3jIY2MXw6Zso
 gil/+7icQaG2aCiEFY4dxsIfqhSYYXh0EFYHD/RUFQG29uxt3Y0XDL5YGpz4bVKaRhaEROneEz
 TKaV5HkBb7yoaL47DojW/c1a5Cib6/md3uF0v8Nj3H9Cwt9GBAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=1747;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kgcKp/6qGiFaqBrzwsbN0tNUCKiKFuSQnGedC4rFcio=;
 b=HtG6zEnZMq7VZz5FJquxBBgSKoVo0gRsHMBytoj17uzdaG0886ia0VLA4zZnAEvxC+fz3l7Gf
 Lm0Ir34BdYUAbVku8YsBaxrOn1Aj5WflVv3/6LKjy5i5swV5+GOw8kY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stack protection is a feature to detect and handle stack buffer
overflows at runtime.
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
Thomas Weißschuh (5):
      tools/nolibc: add definitions for standard fds
      tools/nolibc: add helpers for wait() signal exits
      tools/nolibc: tests: constify test_names
      tools/nolibc: add support for stack protector
      tools/nolibc: tests: add test for -fstack-protector

 tools/include/nolibc/Makefile                |  4 +-
 tools/include/nolibc/arch-i386.h             |  8 ++-
 tools/include/nolibc/arch-x86_64.h           |  5 ++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/stackprotector.h        | 48 ++++++++++++++++++
 tools/include/nolibc/types.h                 |  2 +
 tools/include/nolibc/unistd.h                |  5 ++
 tools/testing/selftests/nolibc/Makefile      | 12 +++++
 tools/testing/selftests/nolibc/nolibc-test.c | 76 ++++++++++++++++++++++++++--
 9 files changed, 155 insertions(+), 6 deletions(-)
---
base-commit: b7453ccfdbe0b9e95b488814c53e8cbf8966aae4
change-id: 20230223-nolibc-stackprotector-d4d5f48ff771

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

