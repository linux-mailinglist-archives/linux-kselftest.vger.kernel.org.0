Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105007BB4CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJFKIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjJFKIQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:08:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CF9FA;
        Fri,  6 Oct 2023 03:08:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0AA96612212;
        Fri,  6 Oct 2023 11:08:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586891;
        bh=d3OOu4X1+6LdLbtOeqh4zt3O5EoMiW32b7riykuvMiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJpMoqgARKxlrxvE+GxBvcWAtc7MbgXZS71nppsrKEBpUPlc0R5bdKyRHV/l501fg
         P83sEu77FZ15rDbNb/9cXn8isvhZiqqFHXaSIL9DK/VEOsCtDYdGzQAUK+CimYP/5J
         meytARV872FUCZVx2xt6bHcUdeiFiPogWMEuI763LFoTOJySY1oyy/GJvO7zMDejuC
         nBHAFTLJfPLSVKUstw039itQgjks6Y8tMU++eAQ0zZSLigkh3KVxIq0zbOhC/0fBuS
         VnBbT2XKN/QAQs9tojmzw9MFRbr81Z1YwlrCrgzGplOxrJhiOWa8Z2BZqanh0UBmnC
         1JunAiyfke/kA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] selftests: firmware: remove duplicate unneeded defines
Date:   Fri,  6 Oct 2023 15:07:38 +0500
Message-Id: <20231006100743.1631334-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006100743.1631334-1-usama.anjum@collabora.com>
References: <20231006100743.1631334-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These duplicate defines should automatically be picked up from kernel
headers.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Make the patch explanation better
---
 tools/testing/selftests/firmware/fw_namespace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 4c6f0cd83c5b0..04757dc7e5467 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -17,10 +17,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-#ifndef CLONE_NEWNS
-# define CLONE_NEWNS 0x00020000
-#endif
-
 static char *fw_path = NULL;
 
 static void die(char *fmt, ...)
-- 
2.40.1

