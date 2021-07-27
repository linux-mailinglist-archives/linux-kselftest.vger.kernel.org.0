Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD43D6AE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 02:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhGZXde (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhGZXdc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 19:33:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E11C061757
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 17:13:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d1so6433883pll.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6M50SO0f7wufQ/jujQ208p4BlTANnLL9cUbaQYum9w=;
        b=omBSBExB2QKPiZorevGKFTuwV9TNcLpvqJ4xPshh6zimiZC9doVPDYbGCbeVXqkVOL
         8G6dew7JsYhvjqzkHmI4RgHlOEp9P4IKF1U8hQ4xQYbdgmrNtXG2DwVc0EE1IuXjc1Kn
         cpLwXGtX+axw4/4U06XzkZ0p+p7QUNjZWNWfKL4LSt/3mmFWqqDUn5Xvnhv6xztZ3OB3
         zlsfP/rvvm/CPTpZAPYpxfHqQ/j/gz5hPlEfLKFzdNDDr55TBuX5N+92EFwV2OXX01BR
         FjC8pR1aoBXEpMIiiO6uhULRcxhIo/SlOtqsqs3CgWsFOKUZQbdDA8OdDv2PxPHRlvK1
         /dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6M50SO0f7wufQ/jujQ208p4BlTANnLL9cUbaQYum9w=;
        b=dnIZIFTwuBRno0asPbQS81opCT0WHpTpnyqUEOqOh0P/BgLspS+/+LCZTt5fmIdg6T
         BMGwzbyxZADBrrafPRAcL/Awj6pai/QrhqfqGPTyERkOoYZoWqVrjaJdZjWErOT0tcTw
         NngvDLqwBCl1e9jOVaAeH+fpvF1h7Fz+Orb1atPBAObi30I7XOfmL+KAQ5q7iwrOzuQt
         xj7kpeXzIgUVm5pS2lFX3JfAdv92bCZ2gISdOTtblFGSCX6Wxa2cZEW1eALfQuA72Q2C
         MsTPxlhBzn/FRAUX34IGfy4GixYbIwoqUxJeq/K4/DG3UAY6hrP7DXeJecNPHwfCoFXo
         HiwA==
X-Gm-Message-State: AOAM530qpX0r0bxyPlwi37RnIsDrNkfAbQYbHUEVhRSLBlttZMJZ2lTb
        nd75L013f+xKARMQC26ykb8nRA==
X-Google-Smtp-Source: ABdhPJyyfyYfDKR+2Yf7LTqdmG+mduU/eFFAMV3vTn4HO23ZIiy0uVf4soy6PslMjRXCQXqFIbg0ng==
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr1492539pjb.87.1627344836488;
        Mon, 26 Jul 2021 17:13:56 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k1sm1079452pga.70.2021.07.26.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:13:56 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 4/5] selftest/bpf: change udp to inet in some function names
Date:   Tue, 27 Jul 2021 00:12:51 +0000
Message-Id: <20210727001252.1287673-5-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727001252.1287673-1-jiang.wang@bytedance.com>
References: <20210727001252.1287673-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is to prepare for adding new unix stream tests.
Mostly renames, also pass the socket types as an argument.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>.
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 7a976d432..07ed8081f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1692,14 +1692,14 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 	}
 }
 
-static int udp_socketpair(int family, int *s, int *c)
+static int inet_socketpair(int family, int type, int *s, int *c)
 {
 	struct sockaddr_storage addr;
 	socklen_t len;
 	int p0, c0;
 	int err;
 
-	p0 = socket_loopback(family, SOCK_DGRAM | SOCK_NONBLOCK);
+	p0 = socket_loopback(family, type | SOCK_NONBLOCK);
 	if (p0 < 0)
 		return p0;
 
@@ -1708,7 +1708,7 @@ static int udp_socketpair(int family, int *s, int *c)
 	if (err)
 		goto close_peer0;
 
-	c0 = xsocket(family, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	c0 = xsocket(family, type | SOCK_NONBLOCK, 0);
 	if (c0 < 0) {
 		err = c0;
 		goto close_peer0;
@@ -1747,10 +1747,10 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	err = udp_socketpair(family, &p0, &c0);
+	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
 	if (err)
 		return;
-	err = udp_socketpair(family, &p1, &c1);
+	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
 	if (err)
 		goto close_cli0;
 
@@ -1825,7 +1825,7 @@ static void test_udp_redir(struct test_sockmap_listen *skel, struct bpf_map *map
 	udp_skb_redir_to_connected(skel, map, family);
 }
 
-static void udp_unix_redir_to_connected(int family, int sock_mapfd,
+static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 					int verd_mapfd, enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
@@ -1843,7 +1843,7 @@ static void udp_unix_redir_to_connected(int family, int sock_mapfd,
 		return;
 	c0 = sfd[0], p0 = sfd[1];
 
-	err = udp_socketpair(family, &p1, &c1);
+	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
 	if (err)
 		goto close;
 
@@ -1897,14 +1897,16 @@ static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 		return;
 
 	skel->bss->test_ingress = false;
-	udp_unix_redir_to_connected(family, sock_map, verdict_map, REDIR_EGRESS);
+	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+				    REDIR_EGRESS);
 	skel->bss->test_ingress = true;
-	udp_unix_redir_to_connected(family, sock_map, verdict_map, REDIR_INGRESS);
+	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+				    REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_udp_redir_to_connected(int family, int sock_mapfd,
+static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 					int verd_mapfd, enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
@@ -1917,7 +1919,7 @@ static void unix_udp_redir_to_connected(int family, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	err = udp_socketpair(family, &p0, &c0);
+	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
 	if (err)
 		return;
 
@@ -1972,9 +1974,11 @@ static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
 		return;
 
 	skel->bss->test_ingress = false;
-	unix_udp_redir_to_connected(family, sock_map, verdict_map, REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
-	unix_udp_redir_to_connected(family, sock_map, verdict_map, REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
-- 
2.20.1

