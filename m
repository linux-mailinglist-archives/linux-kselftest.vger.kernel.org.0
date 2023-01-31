Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8F683833
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjAaVBP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 16:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjAaVBO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 16:01:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA330E7
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:01:13 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3365944304
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675198872;
        bh=etom2qVxb9kUkl83UlutiswUofv0UufWb2skcOFCPPw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=OYIRDBX40LZv2AyQXVZxynP7XXUNxBfKEFrL6a2GJwdUztOOTivJrTP5mCHo3xUeF
         96HsTPbZ7ABSeZHDfMe5k0S3Hd+V6YseyFXF0lAjNS+suzXwbjNK88JtYfrrdTWpmq
         wpB4Sm8mE2aVfdHoaKuROUIzRPB7mSqPBealMqlttVp95Gwq2oi/SRNVohr8EndGbl
         yqiKdzPDgWr+bnPiCpsjXumD7hkzQBxPhTI9onLP76VERGvVcgAfs7tqXOaY/8yRjc
         cnjNLRhpmFPBwAIkO4YqEjdYYGLby0hgBy8ofB2lq3Y52jZFMwLoq17HlnJ8+7WiQ/
         UVAG5OS/ZoXDA==
Received: by mail-wr1-f69.google.com with SMTP id j25-20020adfd219000000b002bfd1484f9bso2147776wrh.2
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etom2qVxb9kUkl83UlutiswUofv0UufWb2skcOFCPPw=;
        b=iNvzFC21ebrzxn2j0aGj4VjsWkbLsj0r+g7uQsPb1rZsR+Yapc+arB9vHF/rK+dGIW
         puSPrQVUspVbjn8QHczRe1plBnu+W59syBe+qpAwZGHRuDC/h9r31sWLGNVU9rFuGKwd
         5ZhQ7vnl2ELpZQ3i+c8yfxNWE7dw2+1uXQDRCU9+JIgag60qUMBYyM0u0Z2+Xc4voeZ7
         Ob8WfAP28Vw9401thr70MbehDTtobKpfssxVosuTLf1D2msyP08MFj5ZOzCSa0KGZlHF
         GxokAk90XuN/7FxKqMlDicFP/lYWsdVTQElsysY8q9Y+6FQn2DAxmw8AVQuF58x5QSlj
         XSIg==
X-Gm-Message-State: AO0yUKVnq/Ad/jEfiocF70IyJFY3KInlI8vawc8YW1ayyhc42ZHGBNrI
        50/+NYdp7FvSHxkctq1F9RWsdPtLWemEhfwpYZ0kTUXoAilcKHNTSo+cyaDs0N2wfcp+YaEKH61
        +YC+mFRpkMpDbGV0GyoYaMisNnto5cVsvogAXV94/owzxcA==
X-Received: by 2002:a5d:5092:0:b0:2bf:ee58:72b1 with SMTP id a18-20020a5d5092000000b002bfee5872b1mr325274wrt.23.1675198871632;
        Tue, 31 Jan 2023 13:01:11 -0800 (PST)
X-Google-Smtp-Source: AK7set8tasggKf/Rx9l1go+kcn/gV3gCYWXptSmptiXfMWE21yhGCKkWfePVwItC66FiAsdLnfbQow==
X-Received: by 2002:a5d:5092:0:b0:2bf:ee58:72b1 with SMTP id a18-20020a5d5092000000b002bfee5872b1mr325240wrt.23.1675198871377;
        Tue, 31 Jan 2023 13:01:11 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id t27-20020adfa2db000000b002366553eca7sm15530408wra.83.2023.01.31.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:01:10 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Fred Klassen <fklassen@appneta.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] selftests: net: udpgso_bench_tx: Cater for pending datagrams zerocopy benchmarking
Date:   Tue, 31 Jan 2023 21:00:51 +0000
Message-Id: <20230131210051.475983-4-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test tool can check that the zerocopy number of completions value is
valid taking into consideration the number of datagram send calls. This can
catch the system into a state where the datagrams are still in the system
(for example in a qdisk, waiting for the network interface to return a
completion notification, etc).

This change adds a retry logic of computing the number of completions up to
a configurable (via CLI) timeout (default: 2 seconds).

Fixes: 79ebc3c26010 ("net/udpgso_bench_tx: options to exercise TX CMSG")
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/udpgso_bench_tx.c | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index b47b5c32039f..ef887842522a 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -62,6 +62,7 @@ static int	cfg_payload_len	= (1472 * 42);
 static int	cfg_port	= 8000;
 static int	cfg_runtime_ms	= -1;
 static bool	cfg_poll;
+static int	cfg_poll_loop_timeout_ms = 2000;
 static bool	cfg_segment;
 static bool	cfg_sendmmsg;
 static bool	cfg_tcp;
@@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
 	}
 }
 
-static void flush_errqueue(int fd, const bool do_poll)
+static void flush_errqueue(int fd, const bool do_poll,
+		unsigned long poll_timeout, const bool poll_err)
 {
 	if (do_poll) {
 		struct pollfd fds = {0};
 		int ret;
 
 		fds.fd = fd;
-		ret = poll(&fds, 1, 500);
+		ret = poll(&fds, 1, poll_timeout);
 		if (ret == 0) {
-			if (cfg_verbose)
+			if ((cfg_verbose) && (poll_err))
 				fprintf(stderr, "poll timeout\n");
 		} else if (ret < 0) {
 			error(1, errno, "poll");
@@ -254,6 +256,20 @@ static void flush_errqueue(int fd, const bool do_poll)
 	flush_errqueue_recv(fd);
 }
 
+static void flush_errqueue_retry(int fd, unsigned long num_sends)
+{
+	unsigned long tnow, tstop;
+	bool first_try = true;
+
+	tnow = gettimeofday_ms();
+	tstop = tnow + cfg_poll_loop_timeout_ms;
+	do {
+		flush_errqueue(fd, true, tstop - tnow, first_try);
+		first_try = false;
+		tnow = gettimeofday_ms();
+	} while ((stat_zcopies != num_sends) && (tnow < tstop));
+}
+
 static int send_tcp(int fd, char *data)
 {
 	int ret, done = 0, count = 0;
@@ -413,7 +429,8 @@ static int send_udp_segment(int fd, char *data)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
+	error(1, 0, "Usage: %s [-46acmHPtTuvz] [-C cpu] [-D dst ip] [-l secs] "
+		    "[-L secs] [-M messagenr] [-p port] [-s sendsize] [-S gsosize]",
 		    filepath);
 }
 
@@ -423,7 +440,7 @@ static void parse_opts(int argc, char **argv)
 	int max_len, hdrlen;
 	int c;
 
-	while ((c = getopt(argc, argv, "46acC:D:Hl:mM:p:s:PS:tTuvz")) != -1) {
+	while ((c = getopt(argc, argv, "46acC:D:Hl:L:mM:p:s:PS:tTuvz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -452,6 +469,9 @@ static void parse_opts(int argc, char **argv)
 		case 'l':
 			cfg_runtime_ms = strtoul(optarg, NULL, 10) * 1000;
 			break;
+		case 'L':
+			cfg_poll_loop_timeout_ms = strtoul(optarg, NULL, 10) * 1000;
+			break;
 		case 'm':
 			cfg_sendmmsg = true;
 			break;
@@ -679,7 +699,7 @@ int main(int argc, char **argv)
 			num_sends += send_udp(fd, buf[i]);
 		num_msgs++;
 		if ((cfg_zerocopy && ((num_msgs & 0xF) == 0)) || cfg_tx_tstamp)
-			flush_errqueue(fd, cfg_poll);
+			flush_errqueue(fd, cfg_poll, 500, true);
 
 		if (cfg_msg_nr && num_msgs >= cfg_msg_nr)
 			break;
@@ -698,7 +718,7 @@ int main(int argc, char **argv)
 	} while (!interrupted && (cfg_runtime_ms == -1 || tnow < tstop));
 
 	if (cfg_zerocopy || cfg_tx_tstamp)
-		flush_errqueue(fd, true);
+		flush_errqueue_retry(fd, num_sends);
 
 	if (close(fd))
 		error(1, errno, "close");
-- 
2.34.1

