Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9678823A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbjHYIhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbjHYIgt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D219AC;
        Fri, 25 Aug 2023 01:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2CB64175;
        Fri, 25 Aug 2023 08:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD12C433CB;
        Fri, 25 Aug 2023 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692952606;
        bh=Q2ZIsubew9vjZV4NTRllMB9+S/zfEbLIL8U7zfyp2fY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FiXrbbU5wd2YWWfvKxQ75kgpXUZ1r3EYDKBbLz7Cc4qCwJu2Aj+m3kPleLC4c1T2E
         S3u3gGOobarm37fRQ1HmNC/5NPC5HiD+zipKXOH09PHF6hZGu3+enfScnlSWOrKYGx
         rhaX00Z3kSROX9T9rWTPbl8Tf3B6VV9VjfgzzAXVdffwAmwMITeNfWQxXTSGUnuhaR
         K1mEyvvNAVu9icopvEcu7rNNhyl0LBfKgqKsUNbD0WsYDiF+6kFrGidojzCTlIGy4l
         wkvNVUqYdmDjoHk3/gdp4ooid83dacxscm0M+ZXb0WhKwyymDfvM022TPYlV68T5sp
         Pl4MLUa8Az1yQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Fri, 25 Aug 2023 10:36:33 +0200
Subject: [PATCH 3/3] selftests/hid: force using our compiled libbpf headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-3-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=798;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Q2ZIsubew9vjZV4NTRllMB9+S/zfEbLIL8U7zfyp2fY=;
 b=+lEQzv9hCNetlUBhrOIu51yeljnR3xW75p6UxKDfmNdvqNMzDHmzekZqiMA0UasGLiQCQRFbD
 N9XPa2ae5U2CkFGO2TpI4jmOLXbF9q9HMMUenMC8C9aCkZAk/9Grarn
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index c5522088ece4..b01c14077c5d 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -22,6 +22,8 @@ CXX ?= $(CROSS_COMPILE)g++
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang

-- 
2.39.1

