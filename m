Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D2752A9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGMS46 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjGMS45 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 14:56:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FD106
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 11:56:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so10401415e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274615; x=1691866615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4/bIWsye08CVfitEtquZgW3u9vyoK7UTHEBm6IUm74=;
        b=NaUfFufg2wboQQirLgEou9URcoLte0ALFAEjP9//G3UQwHlL4Yg+DUbwS8cFwMv8LM
         4grsVdNmG0hypwJSf5O1/z3zBUg9kzX6bS7obiYtyKsumYjDMG4KHgMCRgakxiGo+AyN
         Ynjf0CN+RZ8Qv0WqNg3CR2s2Vv7opiuh1W6GPV0G46YCGpANuMGdg+0L4Iw5B+hyLIxO
         PK/+ER8W3ReqTGRN6QGIOSUAAlhwg1l61u9LmcpsPqfDl3+7QtxMTajStxMdXb72FNyS
         YoKfMoPlcti4MXfUzljFtrAcHAbFimxOXSQDOPQ4g76gQNW5s2YXLsRXneUUe8jEEKfN
         IFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274615; x=1691866615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4/bIWsye08CVfitEtquZgW3u9vyoK7UTHEBm6IUm74=;
        b=EoyvSIRazLN9wqbBEiF9ElpKwLi44cyJsxqSbn/JgWEeMxyBvYG+WDix2VoywcuL45
         Vu+j7faI1WHQaS32e7QQ4cycoenFd5I6J/jjj+NxjgtgVepkx0rtK9HMRrnwEpW2lV3T
         BrDqUPkfAPnWiSnld81T6RittA71zwlOgy0u/Np3EiR8uA3Ub88oxiLI721KqjoByRBn
         zG8nvEaDNDSXG1/wmwtLU6ECJLzwKCQO+JXky81FKWdfNSB8Ms8VpPt40orkJEdoZ4n0
         zbDSPvg0YlPKHBOFEtR6CoqsuoWIamssDNDhzRbDPaEO/O8YYiaznv9pKLylEEZ916Kh
         A3IA==
X-Gm-Message-State: ABy/qLYacQf7c06YQfjk3Qg+YYVfU7+VgWW3wEU1qRMxYmjyMnniYD9t
        GWaXwhB1VV8qUCdmfE2oYPI=
X-Google-Smtp-Source: APBJJlHcgHsMCMuQqFLp4qbdIZM1XeDfby13QINX0aLJFmm7uGWKQwZL+9++QnvCVmnl8B56TVkk1g==
X-Received: by 2002:a7b:c41a:0:b0:3fb:fef1:68b7 with SMTP id k26-20020a7bc41a000000b003fbfef168b7mr2607613wmi.27.1689274614654;
        Thu, 13 Jul 2023 11:56:54 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:952:d673:8e4a:6288])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18971601wmc.10.2023.07.13.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:56:54 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v0] selftests/net: replace manual array size calc with ARRAYSIZE macro.
Date:   Thu, 13 Jul 2023 22:56:44 +0400
Message-Id: <20230713185644.1728127-1-mahmoudmatook.mm@gmail.com>
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
 tools/testing/selftests/net/csum.c            |  8 ++++++--
 tools/testing/selftests/net/hwtstamp_config.c | 18 ++++++++++--------
 tools/testing/selftests/net/psock_lib.h       |  6 +++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index 82a1c1839da6..702f34a9d506 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -123,6 +123,10 @@ static struct sockaddr_in6 cfg_saddr6 = {.sin6_family = AF_INET6};
 #define MAX_HEADER_LEN	(sizeof(struct ipv6hdr) + ENC_HEADER_LEN + sizeof(struct tcphdr))
 #define MAX_PAYLOAD_LEN 1024
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#endif
+
 /* Trivial demo encap. Stand-in for transport layer protocols like ESP or PSP */
 struct udp_encap_hdr {
 	uint8_t nexthdr;
@@ -450,7 +454,7 @@ static void send_packet(int fd, const char *buf, int len)
 	iov[2].iov_len = len;
 
 	msg.msg_iov = iov;
-	msg.msg_iovlen = sizeof(iov) / sizeof(iov[0]);
+	msg.msg_iovlen = ARRAY_SIZE(iov);
 
 	msg.msg_name = &addr;
 	msg.msg_namelen = sizeof(addr);
@@ -505,7 +509,7 @@ static void __recv_prepare_packet_filter(int fd, int off_nexthdr, int off_dport)
 	struct sock_fprog prog = {};
 
 	prog.filter = filter;
-	prog.len = sizeof(filter) / sizeof(struct sock_filter);
+	prog.len = ARRAY_SIZE(filter);
 	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &prog, sizeof(prog)))
 		error(1, errno, "setsockopt filter");
 }
diff --git a/tools/testing/selftests/net/hwtstamp_config.c b/tools/testing/selftests/net/hwtstamp_config.c
index e1fdee841021..263cc1c34165 100644
--- a/tools/testing/selftests/net/hwtstamp_config.c
+++ b/tools/testing/selftests/net/hwtstamp_config.c
@@ -16,6 +16,10 @@
 #include <linux/net_tstamp.h>
 #include <linux/sockios.h>
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#endif
+
 static int
 lookup_value(const char **names, int size, const char *name)
 {
@@ -50,7 +54,6 @@ static const char *tx_types[] = {
 	TX_TYPE(ONESTEP_SYNC)
 #undef TX_TYPE
 };
-#define N_TX_TYPES ((int)(sizeof(tx_types) / sizeof(tx_types[0])))
 
 static const char *rx_filters[] = {
 #define RX_FILTER(name) [HWTSTAMP_FILTER_ ## name] = #name
@@ -71,16 +74,15 @@ static const char *rx_filters[] = {
 	RX_FILTER(PTP_V2_DELAY_REQ),
 #undef RX_FILTER
 };
-#define N_RX_FILTERS ((int)(sizeof(rx_filters) / sizeof(rx_filters[0])))
 
 static void usage(void)
 {
 	fputs("Usage: hwtstamp_config if_name [tx_type rx_filter]\n"
 	      "tx_type is any of (case-insensitive):\n",
 	      stderr);
-	list_names(stderr, tx_types, N_TX_TYPES);
+	list_names(stderr, tx_types, ARRAY_SIZE(tx_types));
 	fputs("rx_filter is any of (case-insensitive):\n", stderr);
-	list_names(stderr, rx_filters, N_RX_FILTERS);
+	list_names(stderr, rx_filters, ARRAY_SIZE(rx_filters));
 }
 
 int main(int argc, char **argv)
@@ -97,8 +99,8 @@ int main(int argc, char **argv)
 
 	if (argc == 4) {
 		config.flags = 0;
-		config.tx_type = lookup_value(tx_types, N_TX_TYPES, argv[2]);
-		config.rx_filter = lookup_value(rx_filters, N_RX_FILTERS, argv[3]);
+		config.tx_type = lookup_value(tx_types, ARRAY_SIZE(tx_types), argv[2]);
+		config.rx_filter = lookup_value(rx_filters, ARRAY_SIZE(rx_filters), argv[3]);
 		if (config.tx_type < 0 || config.rx_filter < 0) {
 			usage();
 			return 2;
@@ -120,12 +122,12 @@ int main(int argc, char **argv)
 	}
 
 	printf("flags = %#x\n", config.flags);
-	name = lookup_name(tx_types, N_TX_TYPES, config.tx_type);
+	name = lookup_name(tx_types, ARRAY_SIZE(tx_types), config.tx_type);
 	if (name)
 		printf("tx_type = %s\n", name);
 	else
 		printf("tx_type = %d\n", config.tx_type);
-	name = lookup_name(rx_filters, N_RX_FILTERS, config.rx_filter);
+	name = lookup_name(rx_filters, ARRAY_SIZE(rx_filters), config.rx_filter);
 	if (name)
 		printf("rx_filter = %s\n", name);
 	else
diff --git a/tools/testing/selftests/net/psock_lib.h b/tools/testing/selftests/net/psock_lib.h
index faa884385c45..72078d46864d 100644
--- a/tools/testing/selftests/net/psock_lib.h
+++ b/tools/testing/selftests/net/psock_lib.h
@@ -24,6 +24,10 @@
 # define __maybe_unused		__attribute__ ((__unused__))
 #endif
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#endif
+
 static __maybe_unused void pair_udp_setfilter(int fd)
 {
 	/* the filter below checks for all of the following conditions that
@@ -63,7 +67,7 @@ static __maybe_unused void pair_udp_setfilter(int fd)
 	struct sock_fprog bpf_prog;
 
 	bpf_prog.filter = bpf_filter;
-	bpf_prog.len = sizeof(bpf_filter) / sizeof(struct sock_filter);
+	bpf_prog.len = ARRAY_SIZE(bpf_filter);
 
 	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &bpf_prog,
 		       sizeof(bpf_prog))) {
-- 
2.34.1

