Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C573718F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjFTQan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjFTQak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3E171B
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso53719385e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278635; x=1689870635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fmVpb8BzbfYzQdlLQkxrXEElwIfZZy9IqLUavxxfBU=;
        b=H0yZh7yy/4ABJ1SFN9nMPbQPcuqnOJJO/wTCjbrJ8ETqgT9NKcFt8Vzp7PTf1nt8b6
         hsfwqnUrYqVtksZG6o3IxgyCvQolPdY4fw+O4GpXO8qjrCStpp1jiUs16YnbFT1ID9gA
         mT6j6IHuQyOh5atwvIZSR11OSAt6GYehfJ9uhxXFCKF47peT5jLV20BCl8WaC0yiymd8
         WFHCRRYY7I07KGI+Yu76H81P2F9uE9Og9YPH4GRrBjm0EknIkbnj1fo6F+1bK22YTjf2
         +yzRSg56VuYl2Rjgv2NmZHu/Nm+pq/KXJgLICpTp7dzMMqMh4Rb90hwscyq4DadtTp3G
         O/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278635; x=1689870635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fmVpb8BzbfYzQdlLQkxrXEElwIfZZy9IqLUavxxfBU=;
        b=CbcWFrb6rzJsuz7aBBpDKZa9aY4s6nLPsYm1eKi8BDADX0l4MtL5Adrlf+/J5oe3Hw
         aHgq5gV0tIhnklzkt2xVFIi/5fGfIZLwir5IlPoo+Z8m0JW7tsQjMlGZuRsMSlgHoxiE
         aLm4ixOBhsbfyvCr2eUMiKEyjKa9CY0KWCagm8WOuptFuclgWBEBt/RFVs8n7jCXbxCw
         jNb74EgOf6d8vyZHeYerCgw1znAvfLpc+nvR4EwrNSWVkPkAhpdLDDfbjshSGV4GKKjw
         fEPzm7SJ1jmUcsarVecYjX6/VEJF7GFp4Fbvsvpe2M5o0EnTLl/ChG2USs88GqIZLNSe
         7ZMQ==
X-Gm-Message-State: AC+VfDzbxEgDQez+4FowqwzJ3pRi8W2uToz2GtKu3UTT1jf6l4Hf8HWE
        oSh2PF+Vw1ZOKBn6PQBvI/p4rw==
X-Google-Smtp-Source: ACHHUZ5xiqs5iJvXsK7fm9K4BNO6GJgz6vT0F1C0kK/y8i8WQ3TmiRLcnBIDfEQ1nU203CGxkCz0DA==
X-Received: by 2002:a7b:c7cb:0:b0:3f9:b1e7:8a41 with SMTP id z11-20020a7bc7cb000000b003f9b1e78a41mr4968596wmk.35.1687278635403;
        Tue, 20 Jun 2023 09:30:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:35 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:19 +0200
Subject: [PATCH net-next 6/9] selftests: mptcp: add MPTCP_FULL_INFO
 testcase
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-6-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5444;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=fPcgPXKgB0XSCiVtuCn69Ip5uyFx/AYrTDDoOEtpepE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQk5qfh7vizDIl9NDeib76hhUzXq7yL/ll7m
 d1eSpN7hiqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c/XID/9OdVrvDIWALDSYmsVGY6D201QJrQO0ZKHq2PMJuYqbbRukKTjqyeMXH4JpLvz2NrH8p/O
 QqJaS/UKxiVBPKMr2VOr/XOLWp18OthSxfzNLVXeMLeqOntm+AziV4VeOlFDTEYvaAfgNQDc/XW
 Ia/WV6fR3ziT7QAbBGmKYZL6eZLuKnTINSiSb2caDS6EYTP/TlmVswS6VPEKysiyaaZzqzxJU07
 9NNsxMkhNEWLBa2jrHI7bKDZdomxEgcGYv6ScdCedkoKh14WzUI42QcIw8h0FfoseeO/iIS0o2z
 FsLhVXNqGdDCprnzlCgye4ZYFPT/TCozRLDQiMyb5eiyv0YDARkCgrrRYKlq1DzaDLXcDCK43Xe
 ilNSmfKDRN+jH01cqWcE8kQ8/vXxxC3AH1Ra5Le8bMsWC/NrCrE5y8quWrXlt1FqJo3C1qKDKSK
 RwYrdN35j4U44Ml5u5RfYua29tYrG7CJfpsFMZsfmDJBbQQs0z+BGxSyOzCUFMXTqayPnCknw3V
 FgfGdJaeCnF9G1jQD3q8kcg15LWNWUpiuAlyAhCxS4OJ5soNC9VBqxIwUamclCuKKtCIFFwSx9h
 71HttWNlVpCTxwUhdGy2igU0W1RUT1HM2essp7hr8N1LrzX88opmgNlbgw1JBDcMQNebCs8B4Jd
 k0qEon/jdgvsmMw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Add a testcase explicitly triggering the newly introduce
MPTCP_FULL_INFO getsockopt.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/388
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 93 ++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 5ee710b30f10..926b0be87c99 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -86,9 +86,38 @@ struct mptcp_subflow_addrs {
 #define MPTCP_SUBFLOW_ADDRS	3
 #endif
 
+#ifndef MPTCP_FULL_INFO
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_full_info {
+	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_tcpinfo_user;
+	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_sfinfo_user;
+	__u32		num_subflows;		/* must be 0, set by kernel (real subflow count) */
+	__u32		size_arrays_user;	/* max subflows that userspace is interested in;
+						 * the buffers at subflow_info/tcp_info
+						 * are respectively at least:
+						 *  size_arrays * size_sfinfo_user
+						 *  size_arrays * size_tcpinfo_user
+						 * bytes wide
+						 */
+	__aligned_u64		subflow_info;
+	__aligned_u64		tcp_info;
+	struct mptcp_info	mptcp_info;
+};
+
+#define MPTCP_FULL_INFO		4
+#endif
+
 struct so_state {
 	struct mptcp_info mi;
 	struct mptcp_info last_sample;
+	struct tcp_info tcp_info;
+	struct mptcp_subflow_addrs addrs;
 	uint64_t mptcpi_rcv_delta;
 	uint64_t tcpi_rcv_delta;
 	bool pkt_stats_avail;
@@ -370,6 +399,8 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 		olen -= sizeof(struct mptcp_subflow_data);
 		assert(olen == ti.d.size_user);
 
+		s->tcp_info = ti.ti[0];
+
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
 			goto done;
@@ -391,7 +422,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 	do_getsockopt_bogus_sf_data(fd, MPTCP_TCPINFO);
 }
 
-static void do_getsockopt_subflow_addrs(int fd)
+static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 {
 	struct sockaddr_storage remote, local;
 	socklen_t olen, rlen, llen;
@@ -439,6 +470,7 @@ static void do_getsockopt_subflow_addrs(int fd)
 
 	assert(memcmp(&local, &addrs.addr[0].ss_local, sizeof(local)) == 0);
 	assert(memcmp(&remote, &addrs.addr[0].ss_remote, sizeof(remote)) == 0);
+	s->addrs = addrs.addr[0];
 
 	memset(&addrs, 0, sizeof(addrs));
 
@@ -459,13 +491,70 @@ static void do_getsockopt_subflow_addrs(int fd)
 	do_getsockopt_bogus_sf_data(fd, MPTCP_SUBFLOW_ADDRS);
 }
 
+static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
+{
+	size_t data_size = sizeof(struct mptcp_full_info);
+	struct mptcp_subflow_info sfinfo[2];
+	struct tcp_info tcp_info[2];
+	struct mptcp_full_info mfi;
+	socklen_t olen;
+	int ret;
+
+	memset(&mfi, 0, data_size);
+	memset(tcp_info, 0, sizeof(tcp_info));
+	memset(sfinfo, 0, sizeof(sfinfo));
+
+	mfi.size_tcpinfo_user = sizeof(struct tcp_info);
+	mfi.size_sfinfo_user = sizeof(struct mptcp_subflow_info);
+	mfi.size_arrays_user = 2;
+	mfi.subflow_info = (unsigned long)&sfinfo[0];
+	mfi.tcp_info = (unsigned long)&tcp_info[0];
+	olen = data_size;
+
+	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			perror("MPTCP_FULL_INFO test skipped");
+			return;
+		}
+		xerror("getsockopt MPTCP_FULL_INFO");
+	}
+
+	assert(olen <= data_size);
+	assert(mfi.size_tcpinfo_kernel > 0);
+	assert(mfi.size_tcpinfo_user ==
+	       MIN(mfi.size_tcpinfo_kernel, sizeof(struct tcp_info)));
+	assert(mfi.size_sfinfo_kernel > 0);
+	assert(mfi.size_sfinfo_user ==
+	       MIN(mfi.size_sfinfo_kernel, sizeof(struct mptcp_subflow_info)));
+	assert(mfi.num_subflows == 1);
+
+	/* Tolerate future extension to mptcp_info struct and running newer
+	 * test on top of older kernel.
+	 * Anyway any kernel supporting MPTCP_FULL_INFO must at least include
+	 * the following in mptcp_info.
+	 */
+	assert(olen > (socklen_t)__builtin_offsetof(struct mptcp_full_info, tcp_info));
+	assert(mfi.mptcp_info.mptcpi_subflows == 0);
+	assert(mfi.mptcp_info.mptcpi_bytes_sent == s->last_sample.mptcpi_bytes_sent);
+	assert(mfi.mptcp_info.mptcpi_bytes_received == s->last_sample.mptcpi_bytes_received);
+
+	assert(sfinfo[0].id == 1);
+	assert(tcp_info[0].tcpi_bytes_sent == s->tcp_info.tcpi_bytes_sent);
+	assert(tcp_info[0].tcpi_bytes_received == s->tcp_info.tcpi_bytes_received);
+	assert(!memcmp(&sfinfo->addrs, &s->addrs, sizeof(struct mptcp_subflow_addrs)));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
 
-	do_getsockopt_subflow_addrs(fd);
+	do_getsockopt_subflow_addrs(s, fd);
+
+	if (r)
+		do_getsockopt_mptcp_full_info(s, fd);
 }
 
 static void connect_one_server(int fd, int pipefd)

-- 
2.40.1

