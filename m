Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5A76A84B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHAFa3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHAFaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C31FC3;
        Mon, 31 Jul 2023 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867813;
        bh=+UidgUyTA/KFUXNdvZyyZmaUyZXJ9vuTjGYxg60wA00=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AVLr7ez6Xso9rIiCq4XROnDn87bAXg6Gu+TqqS5fJxVWzM+cEMh6v8CKhONkYrbVa
         kUH+qIh/OljtRxtQwTBEKzvhDh381ngp1ZSsnptM/xin7BOHEiFmb2Q3pCi3CP+fS5
         IVFICVId0E4ByCfMXC5uw5KQrwlA9d2ce4IUT18g=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:16 +0200
Subject: [PATCH v2 09/10] selftests/nolibc: test return value of read() in
 test_vfprintf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-9-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=826;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+UidgUyTA/KFUXNdvZyyZmaUyZXJ9vuTjGYxg60wA00=;
 b=1TjhwvvgPvP269jHQXdAQsLEjEYjifMWLDyOHpOqaW6hu+NWX+/3UwMD5u0Shu4CJ5pFD1VCA
 t/aAkmg/LRNBR4+1k4EukM6GFycmMc4SFbETt0POLETAe6YgDzd9VqM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If read() fails and returns -1 buf would be accessed out of bounds.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 82714051c72f..a334f8450a34 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1031,6 +1031,12 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
+	if (r == -1) {
+		llen += printf(" read() = %s", errorname(errno));
+		result(llen, FAIL);
+		return 1;
+	}
+
 	buf[r] = '\0';
 
 	fclose(memfile);

-- 
2.41.0

