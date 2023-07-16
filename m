Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C50754E6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGPLOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPLON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 07:14:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2810DC;
        Sun, 16 Jul 2023 04:14:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31297125334so2075422f8f.0;
        Sun, 16 Jul 2023 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689506051; x=1692098051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJQklSgRDtjW4Ode2wf7c9W28AbDdJShuTTGI9JAU1c=;
        b=UpZN0iccvhUd7rjms9gLP2XYOL5s4+cwGUDBk+LwLhrTSOKstpHjtnRcgRNJwvdlSV
         CQQNby0pCTD5sWkeN6vmCurMZaofunPd/NrhIX7gRHLyXNJVAx3kGtPUEHx9YLD8A4nK
         h1sXg4TAkC8+oSpAbi92LhD0Dp9E061EsD9HQJUORe1DDvBBriid48mE2C965g/ebQ5V
         RtPvvd7Fq/hLkLe5zpJDwVT3yrrhix1b7zQztvH0kwFNQwlU7c1Rf4wysl71ar5Y2Fqq
         ZRNtwFlg+gP9Bl7AF2V5CKwwMGxjVyGf1vxNpQ74o9R/oAXKYVTyHMhheZNmcDRMnHuB
         hxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689506051; x=1692098051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJQklSgRDtjW4Ode2wf7c9W28AbDdJShuTTGI9JAU1c=;
        b=id+GQXDnnKQcRNIAHw8oHPQ8awNvktF/zhuoWikAXrZvt1rUlKlvX160+V9uMAX6xg
         5YRZkbvqcqINIArtIf2IAXBuaqlh/bhXgd8aO7729D9e3BrBIsDJdmsXQGSHtffEj54k
         /fsffOYwKWBGAHPhicPxk6f4bLvs0ueyhWtiq3QeaNrp2AZs39Vuv5xXHdlLaCYd+XFf
         AIyGpzoA6SMFPmB8c6VO1CHAWnDdoFLg7i2hXHiAip3xb0BOLagqfmSSc+wscuuad+bX
         kWIBgKAlrTDd8hPkBJqi+XADDMrB7H/MG04LOhXFWTxL4cNw5w7jtO3oqhmGafUvlK1l
         uLJw==
X-Gm-Message-State: ABy/qLaiVOZM4Ij4nHdStzenJyi2Zv7ESKf0K58JTHwEcyitFjSI34Xg
        6A+vRxGLen7y6gCsu9FqG2Q=
X-Google-Smtp-Source: APBJJlH9e4hEEhLa09qFfmmnpo60zTix0naiAqzdGgAcqId8zWt2qeTcgtDRu/Kn/RCpSm9I2H/7Vg==
X-Received: by 2002:a5d:6505:0:b0:314:98f:2495 with SMTP id x5-20020a5d6505000000b00314098f2495mr6397493wru.12.1689506050569;
        Sun, 16 Jul 2023 04:14:10 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:e1af:2d96:1960:a57d])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm16028975wrv.108.2023.07.16.04.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 04:14:10 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v3] selftests/net: replace manual array size calc with ARRAYSIZE macro.
Date:   Sun, 16 Jul 2023 15:13:48 +0400
Message-Id: <20230716111348.2036930-1-mahmoudmatook.mm@gmail.com>
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

changelog since v2:
 - integrat a commit that contains actual replacement for ARRAY_SIZE.
 - use ARRAY_SIZE for net/psock_lib.h

changelog since v1:
 - remove unnecessary extra new line

changelog since v0:
 - update net/Makefile to include kselftest.h
 - remove redefinition of ARRAYSIZE.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
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

