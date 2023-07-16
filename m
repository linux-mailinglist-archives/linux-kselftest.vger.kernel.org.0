Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCF754DEF
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGPJCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPJCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 05:02:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FADF;
        Sun, 16 Jul 2023 02:02:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-314417861b9so3160930f8f.0;
        Sun, 16 Jul 2023 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689498151; x=1692090151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrdUA5P1+t589TrebUiC2lW0ShZ+14JLZPgMTM8GsxI=;
        b=ng97L1ohCssjPItL/rKiYp78ZqIw9DjJ1sdRnkJTHr2reexTr8D1dHEe9W20BQFud7
         uxBSdNQza/+6TrQNphfP33jMKfXs/yc9X5D1KaVfnPKXQGii4NE/iLzpWnHxdCxg+PfR
         kcfqmrEmge7McjzQcnJCoNKYm/SCKiSs0l4h4zR2QrYn8IfMMmZ+/Zzc3J8tMmcy8/R2
         FHRVsOoTHPioaC9+y8VDxI/vV5NKQazeQYrwd+kdIHGMEMBjO9GKILfMlmzjmvRIelR6
         cmtOlbHqfkGwBtYu+u4HsWpM9MakVVGg0eLTnnrfmlVKyP15PQj7CWqwL4TRetqGWGB7
         TOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689498151; x=1692090151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrdUA5P1+t589TrebUiC2lW0ShZ+14JLZPgMTM8GsxI=;
        b=KmXN/BxticgMVkdnHC815VyJ352ajLn2O4txtr7cu7QQcJz/cFm047uua8mPj6ke3e
         p/papOJBtZy61zAiGpJxN07cab3QR8uDrOztOFhNQfLXcALlgxKYUIWijkGUqXZv1DmY
         aDq6B+SWQOgFc8ejuAljNgvuLsolK5uDPUeUZs4XWEc1ElA5mCmzKCXU3tANqEo8U5mW
         M8w209tXOCnjGfSuNcPgkD4oKJJLx64Lofmd5Y+p9m0o9gfY5WX0SgLy46L5YG6jmYpO
         toDfqNggQgQQqiyLEY7z2jBTgKiv8Dzpd2XMlWuRxrFeX99r8gDz7s409BV4xfO1lF8r
         5PtQ==
X-Gm-Message-State: ABy/qLZGP5qtfpoVC8Ab/OupeaDh2Ht0J77hpq6NTx0HEEGwAXDXMJid
        Tz8bEoIpqI1SWuJifQTc4OU=
X-Google-Smtp-Source: APBJJlH61HQQgQ7O2iGO+dkeIj69YMi8lsSkjoffaLhYC9aeEgCD+XO9MLow3vD3oPbNJr1ENrgrnQ==
X-Received: by 2002:a5d:4d8c:0:b0:314:91d:58b5 with SMTP id b12-20020a5d4d8c000000b00314091d58b5mr7858184wru.65.1689498150405;
        Sun, 16 Jul 2023 02:02:30 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:e1af:2d96:1960:a57d])
        by smtp.gmail.com with ESMTPSA id y3-20020a056000108300b003141f96ed36sm15935903wrw.0.2023.07.16.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 02:02:29 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v2] selftests/net: replace manual array size calc with ARRAYSIZE macro.
Date:   Sun, 16 Jul 2023 13:02:00 +0400
Message-Id: <20230716090200.1947107-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fixes coccinelle WARNING: Use ARRAY_SIZE

changelog since v1:
 - remove unnecessary extra new line

changelog since v0:
 - update net/Makefile to include kselftest.h
 - remove redefinition of ARRAYSIZE.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 tools/testing/selftests/net/Makefile          | 2 ++
 tools/testing/selftests/net/csum.c            | 6 ++----
 tools/testing/selftests/net/hwtstamp_config.c | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7f3ab2a93ed6..a06cc25489f9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -3,6 +3,8 @@
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
+# Additional include paths needed by kselftest.h
+CFLAGS += -I../
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index 702f34a9d506..90eb06fefa59 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -91,6 +91,8 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "kselftest.h"
+
 static bool cfg_bad_csum;
 static int cfg_family = PF_INET6;
 static int cfg_num_pkt = 4;
@@ -123,10 +125,6 @@ static struct sockaddr_in6 cfg_saddr6 = {.sin6_family = AF_INET6};
 #define MAX_HEADER_LEN	(sizeof(struct ipv6hdr) + ENC_HEADER_LEN + sizeof(struct tcphdr))
 #define MAX_PAYLOAD_LEN 1024
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
-#endif
-
 /* Trivial demo encap. Stand-in for transport layer protocols like ESP or PSP */
 struct udp_encap_hdr {
 	uint8_t nexthdr;
diff --git a/tools/testing/selftests/net/hwtstamp_config.c b/tools/testing/selftests/net/hwtstamp_config.c
index 263cc1c34165..60970d98eb9b 100644
--- a/tools/testing/selftests/net/hwtstamp_config.c
+++ b/tools/testing/selftests/net/hwtstamp_config.c
@@ -16,9 +16,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/sockios.h>
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
-#endif
+#include "kselftest.h"
 
 static int
 lookup_value(const char **names, int size, const char *name)
-- 
2.34.1

