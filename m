Return-Path: <linux-kselftest+bounces-30584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3903A85BE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE523B13B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968E28C5D0;
	Fri, 11 Apr 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="E5tjnKjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C120FA81;
	Fri, 11 Apr 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371238; cv=none; b=ADTVxyCNkZljMDfgrzIT0SMADirxBwOg2c8v5RgiEJNdL/hBL2HhO3/+39NJWHvU2st6qsZ8ZuPx4uAYqCxlNtAESXYEuWvI7+Sjx3RmStzoXcBBR3ECxLmzSnivP4jSjXwac02+odBUkumiK0g2WzfvRgQzk+YMRZf4HJeRMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371238; c=relaxed/simple;
	bh=NejzP1HfPGR6MbBrjs4VQ97u5eVME30KBiuMGWxwwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7cxRfW7qkb6s9bG2tyjt6VCqMlUmN67giphbr4FyPujnudd4Ml/40441VI2uPnEBwI/7FWp3FLVZpiCilnr+b3u1QuXphn7FIS7DwchOARhikLYcl4llqQhOVOD4dkiRNgfhZI2Fs9yWOS3LaZGvUlyLsAQYA+5Vwi8jmF/PRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=E5tjnKjG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdn-005qKz-3k; Fri, 11 Apr 2025 13:33:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=wUJzBgAJMEls90D7PsoVLjYlWCdcWc60W0LMkOxAROE=; b=E5tjnKjGla6ROnnroXx6UgHGH6
	vPeAH3TUhmOzzwqJ7dJgUqN7AyoqKcpACjCpeHWVcJqdFe43nZkkhO4STHiiAAp7wqtJwk2OanD2l
	i56v8UJuWdW2g0vtD19sNTuEbo2NWpozSU7znb1OUL7nPTPfrNjsKxQnE2hqDxrK/d3IT9pJHATpM
	WWyfdpKtoM3po5n8KPOJQCVL+a2AuViiMFCL/vI3KD9/8WMWk9qy/8bYEPqw/fwDL328cahI9cUd+
	Bxwf6f3d/k6jZPpWPr/nVmaLfeVrONrNtty4LrqD6s9UhqN48fwi67bImlMZ1r9hnW35ACZXpRsqm
	R+iZRZzg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cdm-0005tE-Dy; Fri, 11 Apr 2025 13:33:46 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3Cda-00D5Ut-Bq; Fri, 11 Apr 2025 13:33:34 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 11 Apr 2025 13:32:44 +0200
Subject: [PATCH bpf-next v2 8/9] selftests/bpf: sockmap_listen cleanup:
 Drop af_inet SOCK_DGRAM redir tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-selftests-sockmap-redir-v2-8-5f9b018d6704@rbox.co>
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
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 126 ---------------------
 1 file changed, 126 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 7e29d2f168801f90c2fa02e16126e6a5fe0fc59a..61943b5d75a9cfe93c583dd3461e451bb16bc292 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1366,69 +1366,6 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 	}
 }
 
-static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
-				     int sock_mapfd, int nop_mapfd,
-				     int verd_mapfd, enum redir_mode mode,
-				     int send_flags)
-{
-	const char *log_prefix = redir_mode_str(mode);
-	unsigned int pass;
-	int err, n;
-	u32 key;
-	char b;
-
-	zero_verdict_count(verd_mapfd);
-
-	err = add_to_sockmap(sock_mapfd, peer0, peer1);
-	if (err)
-		return;
-
-	if (nop_mapfd >= 0) {
-		err = add_to_sockmap(nop_mapfd, cli0, cli1);
-		if (err)
-			return;
-	}
-
-	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
-	n = xsend(cli1, "ab", 2, send_flags);
-	if (n >= 0 && n < 2)
-		FAIL("%s: incomplete send", log_prefix);
-	if (n < 2)
-		return;
-
-	key = SK_PASS;
-	err = xbpf_map_lookup_elem(verd_mapfd, &key, &pass);
-	if (err)
-		return;
-	if (pass != 1)
-		FAIL("%s: want pass count 1, have %d", log_prefix, pass);
-
-	n = recv_timeout(mode == REDIR_INGRESS ? peer0 : cli0, &b, 1, 0, IO_TIMEOUT_SEC);
-	if (n < 0)
-		FAIL_ERRNO("%s: recv_timeout", log_prefix);
-	if (n == 0)
-		FAIL("%s: incomplete recv", log_prefix);
-
-	if (send_flags & MSG_OOB) {
-		/* Check that we can't read OOB while in sockmap */
-		errno = 0;
-		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
-		if (n != -1 || errno != EOPNOTSUPP)
-			FAIL("%s: recv(MSG_OOB): expected EOPNOTSUPP: retval=%d errno=%d",
-			     log_prefix, n, errno);
-
-		/* Remove peer1 from sockmap */
-		xbpf_map_delete_elem(sock_mapfd, &(int){ 1 });
-
-		/* Check that OOB was dropped on redirect */
-		errno = 0;
-		n = recv(peer1, &b, 1, MSG_OOB | MSG_DONTWAIT);
-		if (n != -1 || errno != EINVAL)
-			FAIL("%s: recv(MSG_OOB): expected EINVAL: retval=%d errno=%d",
-			     log_prefix, n, errno);
-	}
-}
-
 static void test_reuseport(struct test_sockmap_listen *skel,
 			   struct bpf_map *map, int family, int sotype)
 {
@@ -1469,68 +1406,6 @@ static void test_reuseport(struct test_sockmap_listen *skel,
 	}
 }
 
-static int inet_socketpair(int family, int type, int *s, int *c)
-{
-	return create_pair(family, type | SOCK_NONBLOCK, s, c);
-}
-
-static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
-				   enum redir_mode mode)
-{
-	int c0, c1, p0, p1;
-	int err;
-
-	err = inet_socketpair(family, SOCK_DGRAM, &p0, &c0);
-	if (err)
-		return;
-	err = inet_socketpair(family, SOCK_DGRAM, &p1, &c1);
-	if (err)
-		goto close_cli0;
-
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd,
-				 mode, NO_FLAGS);
-
-	xclose(c1);
-	xclose(p1);
-close_cli0:
-	xclose(c0);
-	xclose(p0);
-}
-
-static void udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
-				       struct bpf_map *inner_map, int family)
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
-	udp_redir_to_connected(family, sock_map, verdict_map, REDIR_EGRESS);
-	skel->bss->test_ingress = true;
-	udp_redir_to_connected(family, sock_map, verdict_map, REDIR_INGRESS);
-
-	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
-}
-
-static void test_udp_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
-			   int family)
-{
-	const char *family_name, *map_name;
-	char s[MAX_TEST_NAME];
-
-	family_name = family_str(family);
-	map_name = map_type_str(map);
-	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
-	if (!test__start_subtest(s))
-		return;
-	udp_skb_redir_to_connected(skel, map, family);
-}
-
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 		      int family)
 {
@@ -1541,7 +1416,6 @@ static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
 	test_redir(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_STREAM);
 	test_reuseport(skel, map, family, SOCK_DGRAM);
-	test_udp_redir(skel, map, family);
 }
 
 void serial_test_sockmap_listen(void)

-- 
2.49.0


