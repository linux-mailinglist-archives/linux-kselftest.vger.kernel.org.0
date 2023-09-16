Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4D7A2E52
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjIPHNx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIPHNw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 03:13:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3060173C;
        Sat, 16 Sep 2023 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694848422;
        bh=iHI+Ng0xOmJAxN0+mPX7GStvN8y9ccAlkUVs7+5qX3I=;
        h=From:Subject:Date:To:Cc:From;
        b=hiQi+BpBnZ8kPBTlIqzCwZ3pmNBG8TIbXV1RBc4WCaFChP7NK0t0VmCWKVaGJh3ga
         bIeeKEVuEiOz+Zpk0w21o75bfdu4QdvOyedWgtIiZcqiSa3Q2dz1fqy+O3uOCRDepV
         xwkPMb/mcx/LdeJx9A0K1gM083TxT0lZNWGNx6iA=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 0/3] selftests/nolibc: avoid spurious kernel relinks
Date:   Sat, 16 Sep 2023 09:13:26 +0200
Message-Id: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJdVBWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Mz3bz8nMykZN3MvMySosTctGJdk7QUA4PUxGRjI1MzJaC2gqLUtMw
 KsJHRSkFuzkqxtbUAgu8RgmcAAAA=
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694848421; l=986;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iHI+Ng0xOmJAxN0+mPX7GStvN8y9ccAlkUVs7+5qX3I=;
 b=sUv4z12Dh7mUB7bLVdXUjCr2wq4+MyXq09xDjB9ezFZmrUf8ENrBTdXe4zwQBinS8U84CBbpo
 XzAnGLsItcXBtIDZNLeKhuZz7uIjGvvmwgirD83UirRykpF5S+6KQRd
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

Currently the nolibc testsuite embeds the test executable into a kernel
image with CONFIG_INITRAMFS_SOURCE.
This forces a full kernel relink everytime the test executable is
updated.

This relinking step dominates the test cycle.
It is slower than building and running the test in qemu together.

With a bit of Makefile-shuffling the relinking can be avoided.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      kbuild: add toplevel target for usr/gen_init_cpio
      selftests/nolibc: don't embed initramfs into kernel image
      selftests/nolibc: drop target "rerun"

 Makefile                                |  4 +++
 tools/testing/selftests/nolibc/Makefile | 50 +++++++++++++++------------------
 2 files changed, 27 insertions(+), 27 deletions(-)
---
base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
change-id: 20230916-nolibc-initramfs-4fd00eac3256

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

