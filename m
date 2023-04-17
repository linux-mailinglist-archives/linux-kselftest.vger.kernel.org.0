Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C56E4DE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDQQB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjDQQBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF9B471;
        Mon, 17 Apr 2023 09:01:43 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681747301;
        bh=XQlx2gfhYVYTVTKE2b7b3AkIPTy7p0etRMsaAd4EBhM=;
        h=From:Subject:Date:To:Cc:From;
        b=Cb0GIsGN0XJa5vKhJMhBxir7d1dKu2zsQPf6QrSBCGDI4aLn186iwcl/Sf8uj7WBX
         fDHEgpOCRzXd2cf/234vZjJFzdBdjWcyhBJC9vOyNa4zLJS7IcnKCEwsJ27SF5y8K6
         P9jgckvnSIu+CXtUEvAqhzLbecdKebbmQDdnIkO0=
Subject: [PATCH 0/6] tools/nolibc: add stackprotector support for more
 architectures
Date:   Mon, 17 Apr 2023 18:01:30 +0200
Message-Id: <20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFptPWQC/x2NQQoCMQwAv7LkbKBbSxW/Ih7aGG2wtEuyirDs3
 y0eZw4zGxirsMFl2kD5Iya9DZgPE1BJ7cko98HgnT+64M7YepVMaGui16J9ZVq7YlIqhsH7EOI
 pxDkyjEJOxpg1NSqj0d61DrkoP+T7X15v+/4DzKE0OIIAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681747300; l=1475;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XQlx2gfhYVYTVTKE2b7b3AkIPTy7p0etRMsaAd4EBhM=;
 b=qK6Yh6oq3WNWYvM3oZZoIsRVkSBvRo/oCtXhrNZBjBIHVbnEv1fFIukoadOuBKL1w+ghsru+S
 07bK6zvGgJjD9Jj5LTB2BU3yF9h4RBjWCTtzz804+1JZ2354S8F+FgP
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

Add stackprotector support for all remaining architectures, except s390.

On s390 the stackprotectors are not supported in "global" mode; only
"sysreg" mode which is not suppored in nolibc.

The series also contains a small optimization to strace output during
execution of nolibc-test.

This series is based on the 20230415-nolibc-updates-4a branch of the
nolibc tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (6):
      selftests/nolibc: reduce syscalls during space padding
      tools/nolibc: riscv: add stackprotector support
      tools/nolibc: aarch64: add stackprotector support
      tools/nolibc: arm: add stackprotector support
      tools/nolibc: loongarch: add stackprotector support
      tools/nolibc: mips: add stackprotector support

 tools/include/nolibc/arch-aarch64.h          |  7 ++++++-
 tools/include/nolibc/arch-arm.h              |  7 ++++++-
 tools/include/nolibc/arch-loongarch.h        |  7 ++++++-
 tools/include/nolibc/arch-mips.h             |  8 +++++++-
 tools/include/nolibc/arch-riscv.h            |  7 ++++++-
 tools/testing/selftests/nolibc/Makefile      |  5 +++++
 tools/testing/selftests/nolibc/nolibc-test.c | 15 +++++++++++----
 7 files changed, 47 insertions(+), 9 deletions(-)
---
base-commit: e35214ea9db7477a02e67a8b412e8046534bb97c
change-id: 20230408-nolibc-stackprotector-archs-42244674616e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

