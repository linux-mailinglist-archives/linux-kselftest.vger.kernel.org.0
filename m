Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3D685C0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBAASA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 19:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjBAAR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 19:17:56 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC9B4C15
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 16:17:54 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB26B41AB7
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675210670;
        bh=B79xjy+K/93G68irDU5evQCBz5+5dY2qXWejhUcP4yM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=m+1y+onjX/EUquwYiuZZ+SEzCTHRzjrQyFwEWryiOYk7E3PQ5rKHh9I+CNLtMTb/h
         WmT1bdHD4rvq3HSWcLVW+li/nBu4Y5xcgVCIU4i4GPk40HOssEgZaPEUf/HcWFF0xi
         yMuxbI1qvmNbPCKJEBtZDkuewFj2akwmgAh/GGULbMDzLh1hIGuuWMHNLcpVAbaVmR
         6Oh1Rnoo5tQJfgnJlCcM2g7CJnvn/UvaFNcMiFWRQt9AInYdySvajMeqH9B5NGUBBN
         AHTR8Yl9NhkMh+OdcEnz79DizuJkn1tIjtNK3cLW8qdLzGslvRB9NNAY7+gEFP1tkP
         FZbVFib5zb1Ww==
Received: by mail-wm1-f71.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso9613772wmb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 16:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B79xjy+K/93G68irDU5evQCBz5+5dY2qXWejhUcP4yM=;
        b=sXJt4rfuRk89C6uJ+Ycpgn/BGrCKxTBey0Fez5Zv6Mn+h3R0A2ZqZGse0/WsRwgmw3
         TAmDYfKgRXo3cIPkKet4oeaGj8MsrPXJr/eEfU74veNCh6SAZonXgokDdA1quspp9VgF
         CZ7ZPXqkCDbRWzUoHo8Xx2orCU7MWcRlkgHgMjtEziApv+bDK7Xp8AHFKXae+1/UPPRJ
         FrDYw/OExqLzxiflBk0YMZmd6cF6B2XJuTCmrptx/+9PCcPD3jmVLitaDBFcbuP4+JZ2
         or7xxoDnnXoVlS99sQMigfsKqXEBGxhas5QrkgZEeZqKl2CoYCmx5/1r3TaSfnwiAK74
         XDgA==
X-Gm-Message-State: AO0yUKXlLHSqdnVVhz9WUiBR0yDXw2Uq/ZYnN4EmdlmM1eXbf/Ap3CP2
        JshhESElVHjT8C7xz5AxTHzXiaDOVQdoeBkurSRVYMJUwnL8blONhCtTzPk0f7sn0u2y+O8q4lo
        aqtcVoTa2RIv6Ex6Lv+G/TiTxUafgr1n/tpyHSkt4tr3R3g==
X-Received: by 2002:a05:600c:3c9b:b0:3dc:46e8:982 with SMTP id bg27-20020a05600c3c9b00b003dc46e80982mr117940wmb.19.1675210667585;
        Tue, 31 Jan 2023 16:17:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8m3rFOUfn/2s9rRm1ZfRJ7ufmOaC/r+T7Sr9ucuwaqVN8rvqtqmrDhvLO6w1KBkptDz3dggA==
X-Received: by 2002:a05:600c:3c9b:b0:3dc:46e8:982 with SMTP id bg27-20020a05600c3c9b00b003dc46e80982mr117926wmb.19.1675210667336;
        Tue, 31 Jan 2023 16:17:47 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003d237d60318sm108925wmi.2.2023.01.31.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 16:17:46 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/4] selftests: net: udpgso_bench_rx: Fix 'used uninitialized' compiler warning
Date:   Wed,  1 Feb 2023 00:16:10 +0000
Message-Id: <20230201001612.515730-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change fixes the following compiler warning:

/usr/include/x86_64-linux-gnu/bits/error.h:40:5: warning: ‘gso_size’ may
be used uninitialized [-Wmaybe-uninitialized]
   40 |     __error_noreturn (__status, __errnum, __format,
   __va_arg_pack ());
         |
	 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 udpgso_bench_rx.c: In function ‘main’:
	 udpgso_bench_rx.c:253:23: note: ‘gso_size’ was declared here
	   253 |         int ret, len, gso_size, budget = 256;

Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgso_bench_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index 6a193425c367..d0895bd1933f 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -250,7 +250,7 @@ static int recv_msg(int fd, char *buf, int len, int *gso_size)
 static void do_flush_udp(int fd)
 {
 	static char rbuf[ETH_MAX_MTU];
-	int ret, len, gso_size, budget = 256;
+	int ret, len, gso_size = 0, budget = 256;
 
 	len = cfg_read_all ? sizeof(rbuf) : 0;
 	while (budget--) {
-- 
2.34.1

