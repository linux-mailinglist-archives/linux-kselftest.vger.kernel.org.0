Return-Path: <linux-kselftest+bounces-30591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE87A85BDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064CA7B5561
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CD29DB7E;
	Fri, 11 Apr 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="c9bfNm/5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB129DB6B;
	Fri, 11 Apr 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371247; cv=none; b=ZSeo9B8GOnThm7euRbNRziJoIBn8TrZUGCRJ214pxDYrzkMRhHMwY8BSCSe4bSAnjHCYDIQxy+9ohydLf1hFd4GzOYXeLGgFersHAHOUCQTy27ZsJuC/6CCf0MMFfMbrxgoO7Svafhi3ZB3cSPEkCtmHY5ju0WjFIRSNFmWhPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371247; c=relaxed/simple;
	bh=gS8E0ufCPvPiNjRhv2e4YEuIEDzYuIcV3WiP/PYjBQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdCcUxqTWAExu33xoTs2JPvgZUCj8Vw6KjGm5WDupRdqRA7pciD3nHZuI1n569tl/VzTnK98qquHLYaSMPE+wwnEETGnCyf9At7sgLfiWNbCmFCk4KrHTWguNvubIUHfI6PaL9xPe4+N8lHSGIc6HxLoFrcqKrDsKufF5HB7ECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=c9bfNm/5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Ce0-005wzs-Ql; Fri, 11 Apr 2025 13:34:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=i7LDn0/OHTpIIfbROXXaPol/WDd8buCWNyOI8VM/A3Q=; b=c9bfNm/5qDgyqTZuUXLS87uNgu
	rXJmLq1LqYBP7HkZtyrv871R4uB6A0H86FdaLlmDQaKi5dopi/FxVK/3Gug9N7gdfUluq+3qyZvSd
	3EA2/us0LeSs0NieiGxuWMFu3toqH/RySi5sScUAzD8TX6MYkjh+Ta0P1n4NP3Sq41JvAgSQI5MdD
	S+Xu9vbO9mefY0EGkRDyqLAlNLaCAyBXeXmbUcVTnLpnJITSS7rIZSZx13lPxtZpWBxat+BCbl9ID
	cSl1AqKPGTURU32vkvywAzHm8x9sqkvr2rGb9YlaVHXd29006bNRY+cyn9q+yJgk3b/JSzi3tbVpy
	ni1oSECg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdq-0005tU-6g; Fri, 11 Apr 2025 13:33:50 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdY-00D5Ut-BM; Fri, 11 Apr 2025 13:33:32 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:42 +0200
Subject: [PATCH bpf-next v2 6/9] selftests/bpf: sockmap_listen cleanup:
 Drop af_vsock redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-6-5f9b018d6704@rbox.co>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
In-Reply-To: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Remove tests covered by sockmap_redir.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 112 ---------------------
 1 file changed, 112 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index c8b736f96503829cba51da0f08c545028b48b8c6..59540876e782f63cc314e0402135768f839923e7 100644
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
@@ -1884,14 +1774,12 @@ void serial_test_sockmap_listen(void)
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


