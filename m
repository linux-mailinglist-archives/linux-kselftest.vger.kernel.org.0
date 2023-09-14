Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE27A0A22
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjINQCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbjINQCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 12:02:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49014271E;
        Thu, 14 Sep 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694707293;
        bh=9Dr/Qlwz9Z5VVtmbM8JisJIKlg1q6mK4mMaDaT8aZHA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fQaMl0ZADkTcn1qLdesYc0JElUD9GU3vjgALM2c2J2mMVoWd0UxMkI4DTYNLV6u71
         N/euTGpE0aCdUp0gXHiuUqU+DXM1U0oq5wlWc4hq/C+9whepDaEWRX8wla4vJnezGV
         hLGAFnCFKk+1Kvk3qK+d/aFnNWNHlinSmp956LPU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 14 Sep 2023 18:01:17 +0200
Subject: [PATCH 1/4] selftests/nolibc: allow building i386 with multiarch
 compiler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230914-nolibc-syscall-nr-v1-1-e50df410da11@weissschuh.net>
References: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
In-Reply-To: <20230914-nolibc-syscall-nr-v1-0-e50df410da11@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707292; l=915;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9Dr/Qlwz9Z5VVtmbM8JisJIKlg1q6mK4mMaDaT8aZHA=;
 b=4hV3jmCa9Owq/qDwKo7tLD8BIPuEx78VNy7e+gUuEGgiBDFvmAUaNjzfTv12ywRmmXc39/n+P
 t1qzu7r4eSGA1L3Bu5s4gUucQV1Iy2C30Ct+vTxX9WnaFcRJ9QUf+Yd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building with a multiarch-capable compiler, like those provided by
common distributions the -m32 argument is required to build 32bit code.

Wrap it in cc-option in case the compiler is not multiarch-capable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 689658f81a19..19096a9ded55 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -113,6 +113,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = $(call cc-option,-m32)
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)

-- 
2.42.0

