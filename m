Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD958DA3B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiHIOWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiHIOWr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 10:22:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20AA12ACB;
        Tue,  9 Aug 2022 07:22:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:861:4a40:8620:d901:c525:a85f:2da3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C02386601C58;
        Tue,  9 Aug 2022 15:22:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660054964;
        bh=gSV06NTaRpUmL9YRF3a9un69uLMMf03b1tlnBMPp1P8=;
        h=From:To:Cc:Subject:Date:From;
        b=bM5jkN0fB5HfUfZrXt8kTjWBBcmk57uKV5TBx6hvTR7ifCrdnWSDvqjm5hI4VM1kM
         /bRDvA2+NapTqX/Tyl7RPTAy1h1RxUNbL7zLo6THhLZU25ru8Om1k60pBMlAXnKQng
         DHGZ5i41tTLOlJlrXYqScDHGB1/ZXmaJBHYf/pwr4KZ1dNaMpKBlGYciEcFQXY9Hyb
         GxHEKDEzYetTQrzuaXTsuNw1zPPGlV0IvbR3mkFc5sVtjAB4DFTM7GMLn+vtc+82ez
         CBCgkoh1tQjcYtMkNnQ0TZQSSr05E/6cwzLgi/pm2ibNbCD88M3vqUTEg6sTCbUifQ
         kV5AaTv1Zmfaw==
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] selftests: fix LLVM build for i386 and x86_64
Date:   Tue,  9 Aug 2022 16:22:31 +0200
Message-Id: <20220809142231.2419274-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add missing cases for the i386 and x86_64 architectures when
determining the LLVM target for building kselftest.

Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 tools/testing/selftests/lib.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b1c62914366b..cc4c443d5b14 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -10,12 +10,14 @@ endif
 CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
 CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_i386         := i386-linux-gnu
 CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
 CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
 CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
 CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.30.2

