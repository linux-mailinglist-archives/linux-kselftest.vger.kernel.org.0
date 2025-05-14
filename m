Return-Path: <linux-kselftest+bounces-32983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED1AB794F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 01:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA20F16E268
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75678221FB8;
	Wed, 14 May 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DT+kGBjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A120E6E7;
	Wed, 14 May 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264125; cv=none; b=nlbe7QHW/rdsrnn7HQdrDHvDiyEFcspdkqHe4SPlYBhSKIeLcUNhcV1hrb/3nswvwrKWVXPAnpESyI3t2UxNbTArfxlhCrz847Z7zLRGV+HHaAHuCsD51DQgeQtfj55w1UkuStRVk5O45P7FsMI6lAIg8UAJncfvga76Cqi+trU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264125; c=relaxed/simple;
	bh=KnQkdp4PuJIqcd44bLxDryVtdBfFszktP1VdxL9wWz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WB77ubYxeIghKbwei1wrLIyIDK1/A+W2w5GYIFYkfl6h8Li30JAFb5AAK9l8QpwCYsxybDtH6pJ1OiLxUAvaejfV4xEm3DUj8mUnMvEZOmGAPvyRrdXwTz/zo+x+eVoYRRUGCOOkiKjYVhKI+IfBUd/hBGUOjqryCWqa7I/RhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DT+kGBjc; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOh-001vf2-Pn; Thu, 15 May 2025 00:16:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=9xhO29vFcmTnpIi4IR/kL+pG5kZoH+hvhoDGRurs7Ls=; b=DT+kGBjc7ZHWGoTYK+SMXNmIAs
	ltm/XCzwXM5Ya4AUfi7snGiQtGZ2h+qd4IiE3I4zd96dginsIb+6/XHozB4BcYVlbFcNZ9vG9CZGd
	QOdTSn+UuW11pm6+3SE4i7Y/BtqEb9Au/7BbnAAaZEX8ai36VA3Ivx62hhJ8jVMQv6nQguvib2wgu
	5W0ND/agZIODWwbCSlgYyNqMLvndSZsNKoJiYgN8F3SRGyA02totplloEncIboptgDNc6rVBaJtGB
	iVTJoL8zQzDajoLd79MAFBtaG7kqmvhK3x9TsVuvE97K0oTJIZvUKp7n8c1WLcH/GG2tKxjqtnSKi
	XiDTIM/A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOh-0008AA-Et; Thu, 15 May 2025 00:16:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOP-005bJ3-BD; Thu, 15 May 2025 00:16:01 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:30 +0200
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: sockmap_listen cleanup:
 Drop af_unix redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-7-a1ea723f7e7e@rbox.co>
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
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 219 ---------------------
 1 file changed, 219 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index f0ad548bdf09d1c5ffdcedfbba11c304b19490c0..4f38dd7d23daf3aee83793be49748916d26d93b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1429,64 +1429,6 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 	}
 }
 
-static void unix_redir_to_connected(int sotype, int sock_mapfd,
-			       int verd_mapfd, enum redir_mode mode)
-{
-	int c0, c1, p0, p1;
-	int sfd[2];
-
-	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
-		return;
-	c0 = sfd[0], p0 = sfd[1];
-
-	if (socketpair(AF_UNIX, sotype | SOCK_NONBLOCK, 0, sfd))
-		goto close0;
-	c1 = sfd[0], p1 = sfd[1];
-
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
-				 mode, NO_FLAGS);
-
-	xclose(c1);
-	xclose(p1);
-close0:
-	xclose(c0);
-	xclose(p0);
-}
-
-static void unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
-					struct bpf_map *inner_map, int sotype)
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
-	unix_redir_to_connected(sotype, sock_map, verdict_map, REDIR_EGRESS);
-	skel->bss->test_ingress = true;
-	unix_redir_to_connected(sotype, sock_map, verdict_map, REDIR_INGRESS);
-
-	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
-}
-
-static void test_unix_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
-			    int sotype)
-{
-	const char *family_name, *map_name;
-	char s[MAX_TEST_NAME];
-
-	family_name = family_str(AF_UNIX);
-	map_name = map_type_str(map);
-	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
-	if (!test__start_subtest(s))
-		return;
-	unix_skb_redir_to_connected(skel, map, sotype);
-}
-
 static void test_reuseport(struct test_sockmap_listen *skel,
 			   struct bpf_map *map, int family, int sotype)
 {
@@ -1589,162 +1531,6 @@ static void test_udp_redir(struct test_sockmap_listen *skel, struct bpf_map *map
 	udp_skb_redir_to_connected(skel, map, family);
 }
 
-static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
-					int verd_mapfd, enum redir_mode mode)
-{
-	int c0, c1, p0, p1;
-	int sfd[2];
-	int err;
-
-	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
-		return;
-	c0 = sfd[0], p0 = sfd[1];
-
-	err = inet_socketpair(family, type, &p1, &c1);
-	if (err)
-		goto close;
-
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
-				 mode, NO_FLAGS);
-
-	xclose(c1);
-	xclose(p1);
-close:
-	xclose(c0);
-	xclose(p0);
-}
-
-static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
-					    struct bpf_map *inner_map, int family)
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
-	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
-				    REDIR_EGRESS);
-	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
-				    REDIR_EGRESS);
-	skel->bss->test_ingress = true;
-	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
-				    REDIR_INGRESS);
-	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
-				    REDIR_INGRESS);
-
-	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
-}
-
-static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					 int nop_mapfd, int verd_mapfd,
-					 enum redir_mode mode, int send_flags)
-{
-	int c0, c1, p0, p1;
-	int sfd[2];
-	int err;
-
-	err = inet_socketpair(family, type, &p0, &c0);
-	if (err)
-		return;
-
-	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
-		goto close_cli0;
-	c1 = sfd[0], p1 = sfd[1];
-
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, nop_mapfd,
-				 verd_mapfd, mode, send_flags);
-
-	xclose(c1);
-	xclose(p1);
-close_cli0:
-	xclose(c0);
-	xclose(p0);
-}
-
-static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
-					    struct bpf_map *inner_map, int family)
-{
-	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
-	int nop_map = bpf_map__fd(skel->maps.nop_map);
-	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
-	int sock_map = bpf_map__fd(inner_map);
-	int err;
-
-	err = xbpf_prog_attach(verdict, sock_map, BPF_SK_SKB_VERDICT, 0);
-	if (err)
-		return;
-
-	skel->bss->test_ingress = false;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM,
-				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS, NO_FLAGS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, -1, verdict_map,
-				     REDIR_EGRESS, NO_FLAGS);
-
-	unix_inet_redir_to_connected(family, SOCK_DGRAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS, NO_FLAGS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS, NO_FLAGS);
-
-	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_EGRESS, MSG_OOB);
-
-	skel->bss->test_ingress = true;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM,
-				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS, NO_FLAGS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, -1, verdict_map,
-				     REDIR_INGRESS, NO_FLAGS);
-
-	unix_inet_redir_to_connected(family, SOCK_DGRAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS, NO_FLAGS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS, NO_FLAGS);
-
-	/* MSG_OOB not supported by AF_UNIX SOCK_DGRAM */
-	unix_inet_redir_to_connected(family, SOCK_STREAM,
-				     sock_map, nop_map, verdict_map,
-				     REDIR_INGRESS, MSG_OOB);
-
-	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
-}
-
-static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
-				int family)
-{
-	const char *family_name, *map_name;
-	struct netns_obj *netns;
-	char s[MAX_TEST_NAME];
-
-	family_name = family_str(family);
-	map_name = map_type_str(map);
-	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
-	if (!test__start_subtest(s))
-		return;
-
-	netns = netns_new("sockmap_listen", true);
-	if (!ASSERT_OK_PTR(netns, "netns_new"))
-		return;
-
-	inet_unix_skb_redir_to_connected(skel, map, family);
-	unix_inet_skb_redir_to_connected(skel, map, family);
-
-	netns_free(netns);
-}
-
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
@@ -1754,7 +1540,6 @@ static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 	test_reuseport(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_DGRAM);
 	test_udp_redir(skel, map, family);
-	test_udp_unix_redir(skel, map, family);
 }
 
 void serial_test_sockmap_listen(void)
@@ -1770,14 +1555,10 @@ void serial_test_sockmap_listen(void)
 	skel->bss->test_sockmap = true;
 	run_tests(skel, skel->maps.sock_map, AF_INET);
 	run_tests(skel, skel->maps.sock_map, AF_INET6);
-	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
-	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);
 	run_tests(skel, skel->maps.sock_hash, AF_INET6);
-	test_unix_redir(skel, skel->maps.sock_hash, SOCK_DGRAM);
-	test_unix_redir(skel, skel->maps.sock_hash, SOCK_STREAM);
 
 	test_sockmap_listen__destroy(skel);
 }

-- 
2.49.0


