Return-Path: <linux-kselftest+bounces-30585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60370A85BCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527F2189971C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271512980BA;
	Fri, 11 Apr 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="e32SPZpG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104D210F44;
	Fri, 11 Apr 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371239; cv=none; b=YwdTZKnr6SVn7K4i5UI4gWQEhiRjEu/fKf7Gnk4QvEE2bJOPcBhvRhpuWhBcjx6Y4K2097WavAYuog4DkU8vOxIgKt2vYe4sq1LYRFfe2oboD2xVnqLd6HHxSr0HQ8qqnCyEPLS2SpdLOKraB6Lrgxq2/ILvIGU5EIw5BjE6cNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371239; c=relaxed/simple;
	bh=5Xdtu4d6dgiceFu52O72CxQMUd60UPZ4kUSlJl24q9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaJIwWirwzpTEx4VDjD/or7mfCpv5d/V+VIiY+1BonXP6VsxvH+eTIQhstiFsOiUgGr69t6d1poEhi7fWaiiGG9602CKZqQkvfoFigc4kp7vPe0C3fbr7RSP7PJbNod/MaWXCPtBwkmIkSj/UI57JNNcm2D6JNJz2fmDonILpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e32SPZpG; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdl-005wxe-RR; Fri, 11 Apr 2025 13:33:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=TNZv6V2tLJyazhkwdFFKmtH6fmWBkdp8iKvcYE3bz0A=; b=e32SPZpG2UVEMDo2Qk76jXFBlx
	4oDVLJi5tbvBFYtwVGThKjyL2ijqg0dL3qLe3T25CvMzY83vt32AOKfQudlPkj7ACQM2FAICxL33J
	XceMGIbvpSzgh+yBDacSaL8UYi3gaMWgB8Xxptro9piKqfeCSlIdMlWd3V6YLTNeWvRyilEcXJFdV
	Vha1X6d99jRtfBEFQhdCU12OoiBc89yeYTRga0bBFVgkwUTPlit+F5CQnN6MD96joNy5wAeYU0h+0
	XYbOc8Mc8IthDKpydqe6wbzD0P0+ov5ajvV447UNTdqxd0a5n1en8t5Mfo/6Kp9Rpar0hTTSX1y+r
	aaNlllhg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdl-0005t8-8O; Fri, 11 Apr 2025 13:33:45 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3CdZ-00D5Ut-Bg; Fri, 11 Apr 2025 13:33:33 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:43 +0200
Subject: [PATCH bpf-next v2 7/9] selftests/bpf: sockmap_listen cleanup:
 Drop af_unix redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-7-5f9b018d6704@rbox.co>
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
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 219 ---------------------
 1 file changed, 219 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 59540876e782f63cc314e0402135768f839923e7..7e29d2f168801f90c2fa02e16126e6a5fe0fc59a 100644
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
@@ -1756,7 +1542,6 @@ static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 	test_reuseport(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_DGRAM);
 	test_udp_redir(skel, map, family);
-	test_udp_unix_redir(skel, map, family);
 }
 
 void serial_test_sockmap_listen(void)
@@ -1772,14 +1557,10 @@ void serial_test_sockmap_listen(void)
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


