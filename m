Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597E286EBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgJHGfx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgJHGfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 02:35:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B03C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Oct 2020 23:35:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so3436500pgi.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Oct 2020 23:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbaNvx8QMtWg3za2H7iH9GYCzRfxH6zcnuISvGg+XeU=;
        b=PvFOUfKpwTkkttuc0UuH40VJRjGMtFUo0s9nzqSwtKTVNDV7+a8Qj8SIoWfqRdVVEK
         qvStvS5KcbxvetLadB8/dD5fdGfEgVkbR382sFX1F65iH8zfQySnAFxLoAI22tYAcYqS
         KV0YBYps6GF0Ym/6vGYjZCotrZTHuPVM/snDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XbaNvx8QMtWg3za2H7iH9GYCzRfxH6zcnuISvGg+XeU=;
        b=WOvGNL7RQzz2sRrvv7FC+HJWSYcDoNMvpZ8TZpp8lRTVFuncGQSBuyfdRT8aRkaqB3
         hzDRDyOYTcDFs8wlF3pIOoCg2rB4OsqPLA9cUi9ws0U9goy2OWSw9Yc7dNuCggqh7PqH
         VY+kVRT9XQHaEtDPCQNUCxDHSE45V0ETR+B1l7s1lbNqMMf0/KWnWMkZa48EMOkr/sRZ
         rIMctZSSgQ/Z+Lh5ES8oUZMEsgpZjjcNnSfuWzBk0yqptYx5r1d2uSRpjInWuqIvdt7o
         m0ayL9UZbDmbTA+kdrJErXqNzKDve/M/f/D58mqSCmXMoQss5FrkZh4tvDZm74zNQ8+u
         1gFA==
X-Gm-Message-State: AOAM533CypjLyFhy2eNLdwdAKZYf8Yh5mBpiRR5d1m81GwpVMsV0YEtF
        TDmvKaRfZDExjx4Y+kaWYbLuhQ==
X-Google-Smtp-Source: ABdhPJzaPRd4BZhVFf754oZWqu/vMZPxZT4nHf8CIUX9/7WzPQYkvjMDXUtE316B/fh5cU3Tah5CPw==
X-Received: by 2002:a17:90a:ee97:: with SMTP id i23mr6406516pjz.161.1602138952511;
        Wed, 07 Oct 2020 23:35:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2sm5075485pjw.13.2020.10.07.23.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 23:35:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Watson <davejwatson@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/tls: Add {} to avoid static checker warning
Date:   Wed,  7 Oct 2020 23:35:48 -0700
Message-Id: <20201008063548.2561803-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This silences a static checker warning due to the unusual macro
construction of EXPECT_*() by adding explicit {}s around the enclosing
while loop.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: rebase to v5.9-rc2; oops, I lost this patch and just found it again
v1: https://lore.kernel.org/lkml/20190108214159.GA33292@beast/
---
 tools/testing/selftests/net/tls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index b599f1fa99b5..44984741bd41 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -387,8 +387,9 @@ TEST_F(tls, sendmsg_large)
 		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
+	while (recvs++ < sends) {
 		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
-- 
2.25.1

