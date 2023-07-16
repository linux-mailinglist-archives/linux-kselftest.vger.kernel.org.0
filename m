Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9555A755092
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGPSoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGPSoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 14:44:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF71B5;
        Sun, 16 Jul 2023 11:44:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso38690245e9.0;
        Sun, 16 Jul 2023 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689533050; x=1692125050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw9rxMmy489xUbQwxOXNVFRR34rAPTUVmC3dh4HsQWw=;
        b=HeTYsvujwYrQwwXDp0WMfX5PfsFlIaj6iOyQIXfhYDOXQFOXAymdjg45DuXKHpZVdJ
         T0aeNJd7Ukr89zC6YK00llwOXwwMwhYEvmhru6R/6shzkJ+Ukd7y+DIIZvnwnJX/J3I3
         lzlwAHp1rxIOasiaWGaNKZtkhzOFqAEO4USZ5UpVmpIrBKJ++StYna4dQjao6RT3DY3z
         jZ030yFpCTFSV/R5E2TwYhm4lrnd2utaZEcbhOPlI0c0I6IGQyGLT7QllT2zMfiqmACc
         W8IWNxCpZmfjezbzCziIQLwUl1CWTwNc0IUxRR7LEYPdb+MZJkH+B+Unu+t4e3s6mEOc
         FsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689533050; x=1692125050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw9rxMmy489xUbQwxOXNVFRR34rAPTUVmC3dh4HsQWw=;
        b=dYx3bkzh0He/Nt1xlb851vDcjmjD+2ibHbUYKtTTjT+OgDneBuyRS7b2oUvWqDSmuv
         X1t/8JvR6FwECphjfMwpdtnXlqfUcmBAULGD9MVvnLt8YR0RLAn8O9NilbFWUAj8A7fL
         BoKf8rAHdO0ioh/gg6k/PQInHcYCJqO+jWXz7HfLfohr5vgwo3pDs8qw6hDsaUDoM9P/
         tuKPyUvjm63kr/Qohf4zQ3nWnDNsBzBbFRjkHAXIoHbl9sby9JJuYHpx4bRgEkh/uQ/x
         h8yYyx9oOS6Key8BFLA+oVa4RtTw8Sje4AIQtSL/Ad/948ANRK2emKM7jfGMowu9Jq3v
         cCYQ==
X-Gm-Message-State: ABy/qLavzldO1bpCq1NIZa9Qm8K67pfU9NQzMox7pLNe8QbawMhZpfLN
        oN8Ay/wH9h6SAgQezPM6iy3oKoVGUJaJedrD
X-Google-Smtp-Source: APBJJlGqrk4/ImODOjlE2fM0n8aEqgTPPtq8oeBjobvCf+cVue7GW3rAT7MupfI6Rwb2vIto6QFSbw==
X-Received: by 2002:adf:ffd2:0:b0:313:eb81:d2f6 with SMTP id x18-20020adfffd2000000b00313eb81d2f6mr11309115wrs.4.1689533049498;
        Sun, 16 Jul 2023 11:44:09 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:e1af:2d96:1960:a57d])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003fbc681c8d1sm6212956wml.36.2023.07.16.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 11:44:08 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v4] selftests/net: replace manual array size calc with ARRAYSIZE macro.
Date:   Sun, 16 Jul 2023 22:43:49 +0400
Message-Id: <20230716184349.2124858-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fixes coccinelle WARNING: Use ARRAY_SIZE

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
changelog since v3:
 - move changelog outside commit message.

changelog since v2:
 - integrat a commit that contains actual replacement for ARRAY_SIZE.
 - use ARRAY_SIZE for net/psock_lib.h

changelog since v1:
 - remove unnecessary extra new line

changelog since v0:
 - update net/Makefile to include kselftest.h
 - remove redefinition of ARRAYSIZE.
---
 tools/testing/selftests/net/Makefile          | 2 ++
 tools/testing/selftests/net/csum.c            | 6 ++++--
 tools/testing/selftests/net/hwtstamp_config.c | 6 ++++--
 tools/testing/selftests/net/psock_lib.h       | 4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

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
index 82a1c1839da6..90eb06fefa59 100644
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
@@ -450,7 +452,7 @@ static void send_packet(int fd, const char *buf, int len)
 	iov[2].iov_len = len;
 
 	msg.msg_iov = iov;
-	msg.msg_iovlen = sizeof(iov) / sizeof(iov[0]);
+	msg.msg_iovlen = ARRAY_SIZE(iov);
 
 	msg.msg_name = &addr;
 	msg.msg_namelen = sizeof(addr);
@@ -505,7 +507,7 @@ static void __recv_prepare_packet_filter(int fd, int off_nexthdr, int off_dport)
 	struct sock_fprog prog = {};
 
 	prog.filter = filter;
-	prog.len = sizeof(filter) / sizeof(struct sock_filter);
+	prog.len = ARRAY_SIZE(filter);
 	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &prog, sizeof(prog)))
 		error(1, errno, "setsockopt filter");
 }
diff --git a/tools/testing/selftests/net/hwtstamp_config.c b/tools/testing/selftests/net/hwtstamp_config.c
index e1fdee841021..170728c96c46 100644
--- a/tools/testing/selftests/net/hwtstamp_config.c
+++ b/tools/testing/selftests/net/hwtstamp_config.c
@@ -16,6 +16,8 @@
 #include <linux/net_tstamp.h>
 #include <linux/sockios.h>
 
+#include "kselftest.h"
+
 static int
 lookup_value(const char **names, int size, const char *name)
 {
@@ -50,7 +52,7 @@ static const char *tx_types[] = {
 	TX_TYPE(ONESTEP_SYNC)
 #undef TX_TYPE
 };
-#define N_TX_TYPES ((int)(sizeof(tx_types) / sizeof(tx_types[0])))
+#define N_TX_TYPES ((int)(ARRAY_SIZE(tx_types)))
 
 static const char *rx_filters[] = {
 #define RX_FILTER(name) [HWTSTAMP_FILTER_ ## name] = #name
@@ -71,7 +73,7 @@ static const char *rx_filters[] = {
 	RX_FILTER(PTP_V2_DELAY_REQ),
 #undef RX_FILTER
 };
-#define N_RX_FILTERS ((int)(sizeof(rx_filters) / sizeof(rx_filters[0])))
+#define N_RX_FILTERS ((int)(ARRAY_SIZE(rx_filters)))
 
 static void usage(void)
 {
diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
index faa884385c45..6e4fef560873 100644
--- a/tools/testing/selftests/net/psock_lib.h
+++ b/tools/testing/selftests/net/psock_lib.h
@@ -14,6 +14,8 @@
 #include <arpa/inet.h>
 #include <unistd.h>
 
+#include "kselftest.h"
+
 #define DATA_LEN			100
 #define DATA_CHAR			'a'
 #define DATA_CHAR_1			'b'
@@ -63,7 +65,7 @@ static __maybe_unused void pair_udp_setfilter(int fd)
 	struct sock_fprog bpf_prog;
 
 	bpf_prog.filter = bpf_filter;
-	bpf_prog.len = sizeof(bpf_filter) / sizeof(struct sock_filter);
+	bpf_prog.len = ARRAY_SIZE(bpf_filter);
 
 	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &bpf_prog,
 		       sizeof(bpf_prog))) {
-- 
2.34.1

