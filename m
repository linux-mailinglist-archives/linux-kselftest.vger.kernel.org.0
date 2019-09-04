Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB8A8D3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfIDQlI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 12:41:08 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:49736 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfIDQlH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 12:41:07 -0400
Received: by mail-yw1-f74.google.com with SMTP id d132so10029159ywh.16
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2019 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R8s/mQuDt3czxphpJ1IOQV2hi08A6wKIrzyNkbM/SsQ=;
        b=sRY+hyU06eTXBM6iBLr3RXE26ciCgVXQhArqt2r3BnX58d/v7yEodvfwqLF194qAaK
         2y2ClIlPS7pC6hOp8/mVfi47uEwEhU8iPF8m0ua076ifWaQ118oKfRMA4bfit5jr/osx
         YYAJnEsCbXgtJkenXRHqHC8lSHZYbKzDaE22/L9ecUW9TfARG6hAugYIwzUwL7B3OXlG
         EmRfQP7qb7YANin7iMgF3pGJx+4odTEWqnfKchn5aEfgFCpZEL0Dui6ZPHzNrx9Kh0D4
         Lwpc47miT41I6kV7KjKvreSPExoSurFp+H6ccaG780izjm5w6gK3srOfrPZZhCLx0Q7n
         cqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R8s/mQuDt3czxphpJ1IOQV2hi08A6wKIrzyNkbM/SsQ=;
        b=nCPpIBd/xYVUHM/H/MOIumj9g6QEmMGN494F7Ph3g9lCse3yAUzgL1vmZF0y/RhCl3
         BznChAUPwuvh1AaAo+xuvm/PsbqSvUriwx5tgyOhD1mGLRzha1z/Gjk+o5R6MW0REjTP
         GRMG/LQERvDysM40UF7NDR3dxBToxNmKftRCI2aFMW1DK3vocF0t5JRBZqSIH/zV2HEP
         3nT7wpuDPVmorKPPs8D1uTYnqFDRrlYKI5fQjOXeyNWbuIXAaQ2GS+Ve3Qo/iEGTa7+Q
         n6LjFYWQNtyww5NvbMxW+alCUunXbU/Zt7EGfC/MHTmc4e94NAE4JShb9vkcNkV7LYg7
         t8KQ==
X-Gm-Message-State: APjAAAXHBIFoZPFmJ+AzEhgSXidITFdOEIYuj0ZdMA9nngZFcszj4RdG
        T/zZxpFShLr7YrzI6gpmheAjDNAqEqKSCh5w
X-Google-Smtp-Source: APXvYqxzNr/i+tgw6CmrAR/6JQkqHrAV0NHOGj24YLgU72jAjdnlgCUSFpi5cASY7Xpkf2HXokV3Z2/BO781tEdZ
X-Received: by 2002:a81:1090:: with SMTP id 138mr30179873ywq.179.1567615266845;
 Wed, 04 Sep 2019 09:41:06 -0700 (PDT)
Date:   Wed,  4 Sep 2019 18:41:00 +0200
Message-Id: <c28135c82eaf6d6e2c7e02c1ebc2b99a607d8116.1567615235.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH ARM64] selftests, arm64: add kernel headers path for tags_test
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tags_test.c relies on PR_SET_TAGGED_ADDR_CTRL/PR_TAGGED_ADDR_ENABLE being
present in system headers. When this is not the case the build of this
test fails with undeclared identifier errors.

Fix by providing the path to the KSFT installed kernel headers in CFLAGS.

Reported-by: Cristian Marussi <cristian.marussi@arm.com>
Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index a61b2e743e99..f9f79fb272f0 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,6 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
+CFLAGS += -I../../../../usr/include/
 TEST_GEN_PROGS := tags_test
 TEST_PROGS := run_tags_test.sh
 endif
-- 
2.23.0.187.g17f5b7556c-goog

