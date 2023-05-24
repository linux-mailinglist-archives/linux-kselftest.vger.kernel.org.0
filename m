Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D8870EE67
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbjEXGqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 02:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbjEXGpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 02:45:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3BBE5F;
        Tue, 23 May 2023 23:44:51 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684910689;
        bh=ltUWovv/Cloe2VwkyJxIkMFPVm8q3r16lGT1SpqtO9o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XKSWBleHdczxPIHT1qS9qFNggj1aG99TQKokUYEnIsINd+LgZvYZdclj2d7m5lSFI
         yI+xr4VfqI0GaALYF0Y0eefzepSp+Kp2cx0f+rgQrxcR/15MTOFh68ERVqi/jDoDRM
         4Q3WtCwbxMCkk57dcGcQdLgfLKa0bMHipGQfKEpA=
Date:   Wed, 24 May 2023 08:44:43 +0200
Subject: [PATCH 2/3] selftests/nolibc: allow disabling of stackprotector
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230523-nolibc-stackprotector-gcc9-v1-2-3e4804235d50@weissschuh.net>
References: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
In-Reply-To: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684910688; l=1069;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ltUWovv/Cloe2VwkyJxIkMFPVm8q3r16lGT1SpqtO9o=;
 b=nvt1qAl5Y2PbRAMHGV/qN2KRXxo/ezTCPrjm6v9w+nlC3vlHJDXssdjP6Pro9wLL4naPfgOMU
 WzKGOvag+SjBayWwHR9zL5e6m6jrjiWTnW0iWZRCNiHkdc854PJWblk
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

This allows users to override the autodetected and enabled-by default
compiler support for stackprotectors.

It can be used with "make CFLAGS_STACKPROTECTOR= nolibc-test".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 882ba6a33dbb..47c3c89092e4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -77,10 +77,10 @@ Q=@
 endif
 
 CFLAGS_s390 = -m64
+CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
-		$(CFLAGS_$(ARCH))
+		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
 help:

-- 
2.40.1

