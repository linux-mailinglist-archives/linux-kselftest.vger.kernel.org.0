Return-Path: <linux-kselftest+bounces-14142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676093B05B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA811F24CB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084E15884B;
	Wed, 24 Jul 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="wyAP3TP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EF74424;
	Wed, 24 Jul 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820832; cv=none; b=RdDCdCgRXLpoDlCxS8AffeQfH8L1cviCeAABHpMdRhVqDtdUVgp+0UfwaoqdQJ3WTPytmGulZLeVllHphSEDt9kYrnZcHYtKbEXRv/KpCnFx/CG4A5JpCFzwk8qmuDGUClkGERF171R7TMadVmOzMLtSLMV4U0YoTZ0lJDfAooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820832; c=relaxed/simple;
	bh=G9RNrBANBO5DT6liRRNsVU1O+MHguLsID6qwDutDtcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxhxMOHwp/osgfo8MJMn9XZzn5hAu7tGNU9BVM3ZcNtMvJNzZQOynuSrYNB1s9zetlE+rhQ67Z5S12JylgzPylkxsa85PquXToqr8YAe5WEPDvgEXiXxgO3S2GDC5QXpgBKUWmTDFL5ObIzFd7/+v5xP7s4dhj2NK9SRpnv66aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=wyAP3TP5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFV-006K18-Cd; Wed, 24 Jul 2024 13:33:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ra+gEbfL/+9Bc67fOIAgA1NInXmFgBolUaIk7jzGadA=; b=wyAP3TP5oxtYJqydCwKzXBoAo2
	1aALolzZZgqhqQIP3DOxjwKYlbbSLZHFVldcL6woJNGq5dF3KAxZxKUbFksv6Hub6w6AJ+LsBxeqt
	J4af86LSXL8A9y6OeAhQFqNU6cGD8AWDxy0N81ycTS5iVKi7EC9U9ZOhr0luWQP/9xPnDv69ms+YV
	h4fjtQw22NDzI5j8X2//K7KRJil7ufBBFrBYLfvNrhRS2XquYA0K0LIMjrh10oJHKqr+rncNoTkCq
	RNUfdo/MNw/UnQQOgW5fyFwz0xIGkr59oiklDSi5Ed/3RzeEQAre1Rai6LWI+V57aZ+WkF7/cjkmi
	/O5b87Dg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sWaFU-0003xl-Ix; Wed, 24 Jul 2024 13:33:36 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sWaFM-00EK6H-5u; Wed, 24 Jul 2024 13:33:28 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 24 Jul 2024 13:32:38 +0200
Subject: [PATCH bpf 2/6] selftest/bpf: Socket pair creation, cleanups
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-sockmap-selftest-fixes-v1-2-46165d224712@rbox.co>
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.0

Following create_pair() changes, remove unused function argument in
create_socket_pairs() and adapt its callers, i.e. drop the open-coded
loopback socket creation.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  9 +++-----
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  4 ++--
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 26 +++++++---------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 5b17d69c9ee6..82bfb266741c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -503,8 +503,8 @@ static void test_sockmap_skb_verdict_shutdown(void)
 
 static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 {
+	int err, map, verdict, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
 	int expected, zero = 0, sent, recvd, avail;
-	int err, map, verdict, s, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
 	struct test_sockmap_pass_prog *pass = NULL;
 	struct test_sockmap_drop_prog *drop = NULL;
 	char buf[256] = "0123456789";
@@ -531,11 +531,8 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
 
-	s = socket_loopback(AF_INET, SOCK_STREAM);
-	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
-		goto out;
-	err = create_socket_pairs(s, AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
-	if (!ASSERT_OK(err, "create_socket_pairs(s)"))
+	err = create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
+	if (!ASSERT_OK(err, "create_socket_pairs()"))
 		goto out;
 
 	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 77b73333f091..ead8ea4fd0da 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -437,8 +437,8 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 	return err;
 }
 
-static inline int create_socket_pairs(int s, int family, int sotype,
-				      int *c0, int *c1, int *p0, int *p1)
+static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
+				      int *p0, int *p1)
 {
 	int err;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 9ce0e0e0b7da..bfbc217637d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -677,7 +677,7 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 			       int verd_mapfd, enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
-	int s, c0, c1, p0, p1;
+	int c0, c1, p0, p1;
 	unsigned int pass;
 	int err, n;
 	u32 key;
@@ -685,13 +685,10 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 
 	zero_verdict_count(verd_mapfd);
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
-	if (s < 0)
-		return;
-
-	err = create_socket_pairs(s, family, sotype, &c0, &c1, &p0, &p1);
+	err = create_socket_pairs(family, sotype | SOCK_NONBLOCK, &c0, &c1,
+				  &p0, &p1);
 	if (err)
-		goto close_srv;
+		return;
 
 	err = add_to_sockmap(sock_mapfd, p0, p1);
 	if (err)
@@ -722,8 +719,6 @@ static void redir_to_connected(int family, int sotype, int sock_mapfd,
 	xclose(c1);
 	xclose(p0);
 	xclose(c0);
-close_srv:
-	xclose(s);
 }
 
 static void test_skb_redir_to_connected(struct test_sockmap_listen *skel,
@@ -909,7 +904,7 @@ static void test_msg_redir_to_listening_with_link(struct test_sockmap_listen *sk
 
 static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 {
-	int s, c0 = -1, c1 = -1, p0 = -1, p1 = -1;
+	int c0 = -1, c1 = -1, p0 = -1, p1 = -1;
 	int err, n, key, value;
 	char buf[] = "abc";
 
@@ -919,13 +914,10 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 	if (err)
 		return;
 
-	s = socket_loopback(family, sotype | SOCK_NONBLOCK);
-	if (s < 0)
-		goto clean_parser_map;
-
-	err = create_socket_pairs(s, family, sotype, &c0, &c1, &p0, &p1);
+	err = create_socket_pairs(family, sotype | SOCK_NONBLOCK, &c0, &c1,
+				  &p0, &p1);
 	if (err)
-		goto close_srv;
+		goto clean_parser_map;
 
 	err = add_to_sockmap(sock_map, p0, p1);
 	if (err)
@@ -944,8 +936,6 @@ static void redir_partial(int family, int sotype, int sock_map, int parser_map)
 	xclose(p0);
 	xclose(c1);
 	xclose(p1);
-close_srv:
-	xclose(s);
 
 clean_parser_map:
 	key = 0;

-- 
2.45.2


