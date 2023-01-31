Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AF682D48
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjAaNF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 08:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjAaNFx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 08:05:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D784E520
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:05:42 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B10C340793
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675170335;
        bh=k4C10jaPX9SATgjkcJPgwiqnKoKJu0rj0Lx0+VxMFbA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=OTcC8sDKIc1YQANEGakG5cBF5JY4WsfSv9i8IUGxHIy0lfVk0SlyeZeZpzAVGPs0X
         HeHJ/5caZyacGyHKJskvVonsGh+1a5K3VUFVrMUpgrGVtcuc55QO7o8G7NoqnI5QO+
         Ou0eTl9fc00OZmZRJp+M3Pe47P0pAqS0SKBYnFnpeR4vDYlkY5PLN1OEH8wlYICK0n
         9YkeAjQ7nSIwQ3e21yhk/xmM4fJVOtdiB+2rAlBdksYRXd6c1XcneNEt1+Lxb5KvAP
         XBIzY8ws18NFS76wSE2/6+yeTUZuRJ9ldPlPpfr/ZQkuovdWKtWNigcD0Il/zSDMza
         TnKrgnDQV0s1g==
Received: by mail-wm1-f70.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso6532112wmp.6
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4C10jaPX9SATgjkcJPgwiqnKoKJu0rj0Lx0+VxMFbA=;
        b=0dZq6hsYabajY/qT6pM2WydTsW1V8WFOdGi/LJUrztx9OBrYudgNscIREQQJr26Pro
         URtKYYdCkPZ0cm2M1v0FUEyTBqb7Sv6gYN2WJQFHHLcfgUYzvVhjvjboHDDDo8oOQWuy
         8x6rOnfS/MRLflItl1qj3rxWlZ1vsiY6SueG4xm6LEsrR0T4gdZ++59JHAlY8cddjflv
         ckSmXwrPK6Dz5RPQxIZIJqPnvkzDhvREB5Q4B4pxg5i+geoypBgArVP2tlh8yvXlUW/E
         FzaLhkRKr8cgQsklvnsCgvDkQHxJLq/gq02YJqWetrt8SzGwszB9py/TggKG3hw+Eg5R
         bKqg==
X-Gm-Message-State: AO0yUKXSaBWKG3W0lDuT3PsbJhUtOpuWLi228xKQi/RWXtAT8yXRWI3l
        E5rh6yTf2GlvsWbSplE8gODZ9doRdCbySQEWVN2cDL/DWszYDA+fOn3uHK2Byi9YbglL/lJ8a9U
        JW4JrH4Q81Oamn3RiWnpdrGeJnz+cwoD2WjO2dEI1NpGTmQ==
X-Received: by 2002:adf:c68a:0:b0:2bf:f2f2:7d64 with SMTP id j10-20020adfc68a000000b002bff2f27d64mr5125348wrg.33.1675170335364;
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/JKOWFouqXY4USuDFfFzUbfIHyMBzspi6+XkMA9ckLWmUhedeQ3yyjl+8b9xB/uwlPFXvVZA==
X-Received: by 2002:adf:c68a:0:b0:2bf:f2f2:7d64 with SMTP id j10-20020adfc68a000000b002bff2f27d64mr5125324wrg.33.1675170335068;
        Tue, 31 Jan 2023 05:05:35 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14741436wrt.78.2023.01.31.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:05:34 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] selftests: net: udpgso_bench_rx: Fix 'used uninitialized' compiler warning
Date:   Tue, 31 Jan 2023 13:04:09 +0000
Message-Id: <20230131130412.432549-1-andrei.gherzan@canonical.com>
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

