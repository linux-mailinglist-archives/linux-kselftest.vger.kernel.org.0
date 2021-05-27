Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91D392571
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 05:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhE0D31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhE0D30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 23:29:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DCC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:27:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp9-20020a17090b1909b029015fd1e3ad5aso1507474pjb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iIY2AmoL1fI/z+y4/7voTLOCpnfg6ZKfhY7uCtNjvc=;
        b=Kg4GWTLkBBps5G6bR0n4ebQeEh9+WvNCYTTCQNzG41dLYVWYNx/1FJcN5SRHgI3Y/C
         q1idzmhTak/iZ3eZrTrH8vSEHTvcFojoKU7pA8bbSeWRJT9Gh/HhWpf657JLKELdrtF5
         LNqdKM9kvQEr7jqD0mWl90kgVk+/PsCt3hElU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iIY2AmoL1fI/z+y4/7voTLOCpnfg6ZKfhY7uCtNjvc=;
        b=KlVVsdQSdRDWA1Sn9+SQsCqwFpi79DQXwG641YpNFEc/H86kikX4qjXqyhxH62z9Os
         YGuDL1If50CUpoztxaSRqHlFnLZEe1KkVbyKMxZgtjtnW5AshltVwbUfL1qgj5x5pj0h
         RY923hmvM7LuCkA8Yr86gpOMg9TrGbvuU3+u1+SBKMrl6iIv3Ezoz24ZhyBrWwdC7Orj
         XwhJFQ7OoYuvb+BaQ080y0UCCUZU2Qwg8Q+DmdsDWGwkIntu5wfJJZM1gyMF7cWSdj9L
         Ad7QsVOAfhjjGGIxUVcE1N/S4EoJqNiQBbT8u0WzQrQ1VTeGjU64AI8u8fBXz8Blqxh9
         Qtyg==
X-Gm-Message-State: AOAM5335iz7gvVNwxdUwXRQM/TCG7qDMGktkHEuBpKVXMKSA0t76DeFt
        hmomV98IG4HYx6+jMGROveIH7Q==
X-Google-Smtp-Source: ABdhPJx0meH7PdxyvJdbQ4WVLdv3fSefxDnXRVorUKxryS8UVtjk0BvP3Bz+eW5bNd5McGe/62OEvw==
X-Received: by 2002:a17:90a:fe84:: with SMTP id co4mr1507075pjb.0.1622086074311;
        Wed, 26 May 2021 20:27:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 205sm505164pfc.201.2021.05.26.20.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:27:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/tls: Add {} to avoid static checker warning
Date:   Wed, 26 May 2021 20:27:19 -0700
Message-Id: <20210527032718.3730773-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=55a6e0190540e99bd24e6e37a3059fcfb03cc6af; i=9D7yygF/mqcgTestzGh+o+ofEE1M2aPaUg2DixT/toQ=; m=NK5fCUp/eXAW69/kiM2eNaxWsnU23sqDL8tfrvePY7U=; p=K0shpnMJOgJ6g00JJraonfho1XighEro+JNuV5H9l78=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCvEZUACgkQiXL039xtwCZAvQ/9GNn uoezFqFo6SWBi1OIELtfMEPb0OSdudVfhQ48O1X49df5rsSRmu7C74niYTJKq7En26r+Rmg/ExX2J OnRt0dsSx1QDS0BIGxGzLYdjmbx7Dv379hmc1hkklZLpxvkNM7NTXQ7Y/d3KbOXii4eXWeKo4NF7K mrZVUGv+UnjoOW6wYiwo4RNb9bo4kWoy59+XZMHCaadpsjmWUzuNaSIt5/6NKLk7eKndtuwUrrzay /mU2Z0td/K3H3JxMYKQdgqJnAb2z1dZyHEHoBATst1Wr9ulLJgLxdEPWsHFv+Tl3gpPAT7Jh6FgZ9 550HPGZO50MYRj9TD+6S4+brLBOePWBWE++ARkGpoZt9AagjQy3gqb35e1pM5XZP866r2QwHMQ46F +kIsdXTHDOqtDlMkmwpACF47YKAUWLjBCI7Zxat6XQWHaORM5T7uMUEEvIAEUtwQbNCX7JtemQI9A CsosYskJdM12CCEmcM1E49MO0mhKRYmIpU9vmAc9oJgDIXWllGjXRb5BRCwKg1pTwWJdOzwqHQB+j S0Wrv8+ylUQCnkp+bWZRDoZr6578UvELuDEjoYJFZK7QmDic1KTcyJnxpMJz8dwr6sWwUArM3aVaW bBhlrWqCNVtXj1z2W6ZEfJFwWXF1kjfyks8KKxQi/3P64LRtFwZQ80qXbjqwkXlU=
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
 tools/testing/selftests/net/tls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 426d07875a48..7119f8eb823b 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -418,8 +418,9 @@ TEST_F(tls, sendmsg_large)
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

