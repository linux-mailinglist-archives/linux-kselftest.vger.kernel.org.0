Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301D7770E84
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjHEHjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHEHix (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:38:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C14F5276;
        Sat,  5 Aug 2023 00:38:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1BD2866071AA;
        Sat,  5 Aug 2023 08:38:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221118;
        bh=g8H4oqxUVkWw6eZ06fZTPFUc0jYvLduZPUtX7s5Dac4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIRFNufk1KKzuIAX6Lefv4Jq+E4KIg5ZCK6YFLWzU9mQqSpYXkuvgoIpNkNy+jPyV
         qkMnqJWsV6AMFdvqfiXOuOXq08e6MFwPXlhVcvNjXS4RcDJQyyQrQh7OFNwZGCkKgi
         JQeKoe9xKavpMMgQ7XmmvyQlqXx+gszdQgrCK5x/FWtqbnu5wNysEVgmK6nRzo4/ac
         tCZV89fgSVLC3rg9wcBb3WHNUs8VY+fYJokurBxURk7TKfbPXuRRroOvhbdHhTexoI
         9GsErEsTvXfPoJf/bJ18K8a31NQP//62vsEVp3yKjlxtlSXanDzn1Uu+ucEob00eCh
         30jfNU7lQc4Dg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] selftests: firmware: remove duplicate unneeded defines
Date:   Sat,  5 Aug 2023 12:38:03 +0500
Message-Id: <20230805073809.1753462-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805073809.1753462-1-usama.anjum@collabora.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These duplicate defines should automatically picked up from kernel
headers.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
2.39.2

