Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B37E080A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 19:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjKCSYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKCSYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 14:24:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33BD4B;
        Fri,  3 Nov 2023 11:24:14 -0700 (PDT)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B42766073FA;
        Fri,  3 Nov 2023 18:24:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699035853;
        bh=zZ6D4S//ld77lgzABD77wPrEQjiD6EF4YGN4GV6oW3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK+rwuDoLmLNFBxK4lEbQO01Bq3NHepvIVRwzLmuijGgo4M8iwfsElqUx9DMG3HHd
         h6FB5QUSjyVBUJy373ftc4aYNJESqrnQg8iQuq74rbJPWbFmbKx1GTtcLz2rM+NkRo
         PIatxO/V1jTO8bngRtJSU1gZlXiB12rV44xmI32EkUbcFLuUINcxjZVxvUhLCOiIOk
         6nDMmd4Cq0W6mz75AQxv3775F5C/xIueom1Hl72Y9KYzQT5eeVfvhJWxWEoe1AS1O5
         sWwSl1sjk6up9is9zekIvWxNDipaK7E2Vqu99lJ/xMWHhs2Ju68v8Up8cpWYy2J/ch
         DTkI6KAaclD4g==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: mm: fix some build warnings
Date:   Fri,  3 Nov 2023 23:23:42 +0500
Message-ID: <20231103182343.2874015-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103182343.2874015-1-usama.anjum@collabora.com>
References: <20231103182343.2874015-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix build warnings:
pagemap_ioctl.c:1154:38: warning: format ‘%s’ expects a matching ‘char *’ argument [-Wformat=]
pagemap_ioctl.c:1162:51: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Wformat=]
pagemap_ioctl.c:1192:51: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Wformat=]
pagemap_ioctl.c:1600:51: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Wformat=]
pagemap_ioctl.c:1628:51: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Wformat=]

Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index f8685a2ea07e6..befab43719bad 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1151,7 +1151,7 @@ int sanity_tests(void)
 	/* 9. Memory mapped file */
 	fd = open(__FILE__, O_RDONLY);
 	if (fd < 0)
-		ksft_exit_fail_msg("%s Memory mapped file\n");
+		ksft_exit_fail_msg("%s Memory mapped file\n", __func__);
 
 	ret = stat(__FILE__, &sbuf);
 	if (ret < 0)
@@ -1159,7 +1159,7 @@ int sanity_tests(void)
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %ld %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
 	tmp_buf = malloc(sbuf.st_size);
 	memcpy(tmp_buf, fmem, sbuf.st_size);
@@ -1189,7 +1189,7 @@ int sanity_tests(void)
 
 	fmem = mmap(NULL, buf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %ld %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, buf_size);
 	wp_addr_range(fmem, buf_size);
@@ -1596,7 +1596,7 @@ int main(void)
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %ld %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, sbuf.st_size);
 	wp_addr_range(fmem, sbuf.st_size);
@@ -1624,7 +1624,7 @@ int main(void)
 
 	fmem = mmap(NULL, buf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-		ksft_exit_fail_msg("error nomem %ld %s\n", errno, strerror(errno));
+		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
 	wp_init(fmem, buf_size);
 	wp_addr_range(fmem, buf_size);
-- 
2.42.0

