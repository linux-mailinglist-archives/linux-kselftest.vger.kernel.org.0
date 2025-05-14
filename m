Return-Path: <linux-kselftest+bounces-32977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4ECAB78F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C6B189C2F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DED22652E;
	Wed, 14 May 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HrXbSvj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED49224AFA;
	Wed, 14 May 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260991; cv=none; b=nJLs1dtkv8HUrlk8U2lAcHnORJAFjxLhERp6By8E43PTJZ/vEWI1sHz830St+GG1vd5UwiuztdSJOsCxRgcWvf6OzQrOlR9jbVHoxnki9RURQSJeECIosKmrffS7uDGHiZ711nbIusENhdtwPxqagPz8nZp2lazgiOpnLoGJLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260991; c=relaxed/simple;
	bh=8KERzOWdSrZs8kSwJdKHRZwEAinPslc0Smuxbo46QIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuRjGn3UcSd+a+C3T5PFLslCJr/Z9CrNvXJfK6/+9ZPiSpst+mhpl3mhyq5z33QivpBkyEKbAqEuBvtk6fW70lAjdoX3AXJygJUSrv8pbZGreyIVCIski//07RhtL8jLh3NSrKZUaDV6bB4PqTQ1HfHO1nJqKhgFt1c79+Ilpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HrXbSvj8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOl-001vfe-Rl; Thu, 15 May 2025 00:16:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=xvhM4tbojY9tDkQHmJNrLd25j/vmeCNoOANSmjk4XqY=; b=HrXbSvj83fKZ1zxaxaAsVUVMyN
	RNMmnp0yapE7aKb0wT0mwAMZozSex40He2ZKAqTzQyd8EgcLGT+iILMiWC4/wejnRqdYkx0sZUgWL
	+xpNKGJbRQ1JAiTYOo8uoNuan0MMdsuGYSTQvbJHAAq+Hz6gT0Sv2dDZMqSE1rWnazUV+1PeuK7H2
	5n+atxSNSo2VLymoaEKOW7ddbOQnbLeKly2dBM895iR48vwGF1JCof4QXJFPCX7nAxjMZW/COviqL
	Wfmi+Xzlds2DmhM0CI+I3l/gyoDIfWAGqcumcMFKotfU6FlKw2THHUh7xHYT6LdGFHk5fyHmnFqI6
	XGoQO/iQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOl-0004Ja-H5; Thu, 15 May 2025 00:16:23 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOO-005bJ3-E1; Thu, 15 May 2025 00:16:00 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:29 +0200
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: sockmap_listen cleanup:
 Drop af_vsock redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-6-a1ea723f7e7e@rbox.co>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Remove tests covered by sockmap_redir.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 112 ---------------------
 1 file changed, 112 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 4ee1148d22be3d7f26a5c899542e6a29ca5e7d6c..f0ad548bdf09d1c5ffdcedfbba11c304b19490c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1487,116 +1487,6 @@ static void test_unix_redir(struct test_sockmap_listen *skel, struct bpf_map *ma
 	unix_skb_redir_to_connected(skel, map, sotype);
 }
 
-/* Returns two connected loopback vsock sockets */
-static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
-{
-	return create_pair(AF_VSOCK, sotype | SOCK_NONBLOCK, v0, v1);
-}
-
-static void vsock_unix_redir_connectible(int sock_mapfd, int verd_mapfd,
-					 enum redir_mode mode, int sotype)
-{
-	const char *log_prefix = redir_mode_str(mode);
-	char a = 'a', b = 'b';
-	int u0, u1, v0, v1;
-	int sfd[2];
-	unsigned int pass;
-	int err, n;
-	u32 key;
-
-	zero_verdict_count(verd_mapfd);
-
-	if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0, sfd))
-		return;
-
-	u0 = sfd[0];
-	u1 = sfd[1];
-
-	err = vsock_socketpair_connectible(sotype, &v0, &v1);
-	if (err) {
-		FAIL("vsock_socketpair_connectible() failed");
-		goto close_uds;
-	}
-
-	err = add_to_sockmap(sock_mapfd, u0, v0);
-	if (err) {
-		FAIL("add_to_sockmap failed");
-		goto close_vsock;
-	}
-
-	n = write(v1, &a, sizeof(a));
-	if (n < 0)
-		FAIL_ERRNO("%s: write", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete write", log_prefix);
-	if (n < 1)
-		goto out;
-
-	n = xrecv_nonblock(mode == REDIR_INGRESS ? u0 : u1, &b, sizeof(b), 0);
-	if (n < 0)
-		FAIL("%s: recv() err, errno=%d", log_prefix, errno);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
-	if (b != a)
-		FAIL("%s: vsock socket map failed, %c != %c", log_prefix, a, b);
-
-	key = SK_PASS;
-	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
-	if (err)
-		goto out;
-	if (pass != 1)
-		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-out:
-	key = 0;
-	bpf_map_delete_elem(sock_mapfd, &key);
-	key = 1;
-	bpf_map_delete_elem(sock_mapfd, &key);
-
-close_vsock:
-	close(v0);
-	close(v1);
-
-close_uds:
-	close(u0);
-	close(u1);
-}
-
-static void vsock_unix_skb_redir_connectible(struct test_sockmap_listen *skel,
-					     struct bpf_map *inner_map,
-					     int sotype)
-{
-	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
-	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
-	int sock_map = bpf_map__fd(inner_map);
-	int err;
-
-	err = xbpf_prog_attach(verdict, sock_map, BPF_SK_SKB_VERDICT, 0);
-	if (err)
-		return;
-
-	skel->bss->test_ingress = false;
-	vsock_unix_redir_connectible(sock_map, verdict_map, REDIR_EGRESS, sotype);
-	skel->bss->test_ingress = true;
-	vsock_unix_redir_connectible(sock_map, verdict_map, REDIR_INGRESS, sotype);
-
-	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
-}
-
-static void test_vsock_redir(struct test_sockmap_listen *skel, struct bpf_map *map)
-{
-	const char *family_name, *map_name;
-	char s[MAX_TEST_NAME];
-
-	family_name = family_str(AF_VSOCK);
-	map_name = map_type_str(map);
-	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
-	if (!test__start_subtest(s))
-		return;
-
-	vsock_unix_skb_redir_connectible(skel, map, SOCK_STREAM);
-	vsock_unix_skb_redir_connectible(skel, map, SOCK_SEQPACKET);
-}
-
 static void test_reuseport(struct test_sockmap_listen *skel,
 			   struct bpf_map *map, int family, int sotype)
 {
@@ -1882,14 +1772,12 @@ void serial_test_sockmap_listen(void)
 	run_tests(skel, skel->maps.sock_map, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
-	test_vsock_redir(skel, skel->maps.sock_map);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);
 	run_tests(skel, skel->maps.sock_hash, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_hash, SOCK_DGRAM);
 	test_unix_redir(skel, skel->maps.sock_hash, SOCK_STREAM);
-	test_vsock_redir(skel, skel->maps.sock_hash);
 
 	test_sockmap_listen__destroy(skel);
 }

-- 
2.49.0


