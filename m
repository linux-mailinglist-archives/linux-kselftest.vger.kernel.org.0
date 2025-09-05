Return-Path: <linux-kselftest+bounces-40824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937FB455F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545B11B2518D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D434F49F;
	Fri,  5 Sep 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="daZ+R/x2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41234F474;
	Fri,  5 Sep 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070732; cv=none; b=SWdq3oGt66iwCluAiz8c5IbePo2tdKTyVj8StYwpxj5/AAbuP2PaRADmEWNI1SRJz35SGdWdqH47QDnhfzok5ULhRAaVWkas0LX1wnsPh3Fa/dQZ89sR2Y6a0JV7MCdY3qrlT8MP/GEPqVcout69O4Pj6Zct6/6Hy5w2Y/LOrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070732; c=relaxed/simple;
	bh=7Tsy7ROVoOHxxVMAnzKBn0Y5eMA7rE7joEcmL2lJBVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLPf3TIOYSsqBw6PQx/Obt7zYzQT0uJ+zS2AwedBgvSXxGI5SOFYIoAt9GVLFI/qJfSASRTd/pI1MfbcCom4HX3oCAtusKiDJvW+IuvdpKjmelEpNhJnKlUyOE4sq1bnLzcAVyedrmc43PCg1/LWpdd10f+6Ss6Hu5OVKVPfi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=daZ+R/x2; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMQ-003UR9-83; Fri, 05 Sep 2025 13:12:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+pRX1EHWIu4uVLS1iKQ0e4UmcUny8V+/+FbSvwtoeV8=; b=daZ+R/x2+DfqwfHt7UmEv0f802
	4zzpGOT3I0NOlRE6zmjhR4NBnX5u67d99vXvu0HMVURiQzhp/IOOAMGkwxSolHYkqHDwcipT3n6hC
	r9cAo/E2e93lksbAf92fBlQWLAjZYwFfxd0gQiouIs3Jo0ky9sPZY7GFx7NbegiBxJcJswT9nk0K8
	bUNpMG0+NDLYRhDcqieQ1ScSvg9ZcRj1x6fQcbLYp6Wp+oKvBc9CtGX1C7Xm9HPZUCOGzbC8Ao6Yi
	V4URgJKchAebB+b8xMDbgKIVhmPnept/zuSZ7Y/rq/qUx8rZSCIFzcafJoUllhOl0/xQRPv2yt+pP
	96BvdtYg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMP-0002Jd-OB; Fri, 05 Sep 2025 13:12:06 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUMA-002yZ1-19; Fri, 05 Sep 2025 13:11:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 05 Sep 2025 13:11:41 +0200
Subject: [PATCH bpf-next 1/5] selftests/bpf: sockmap_redir: Simplify
 try_recv()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-redir-test-pass-drop-v1-1-9d9e43ff40df@rbox.co>
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
In-Reply-To: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

try_recv() was meant to support both @expect_success cases, but all the
callers use @expect_success=false anyway. Drop the unused logic and fold in
MSG_DONTWAIT. Adapt callers.

Subtle change here: recv() return value of 0 will also be considered (an
unexpected) success.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++-------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index 9c461d93113db20de65ac353f92dfdbe32ffbd3b..c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -144,17 +144,14 @@ static void get_redir_params(struct redir_spec *redir,
 		*redirect_flags = 0;
 }
 
-static void try_recv(const char *prefix, int fd, int flags, bool expect_success)
+static void fail_recv(const char *prefix, int fd, int more_flags)
 {
 	ssize_t n;
 	char buf;
 
-	errno = 0;
-	n = recv(fd, &buf, 1, flags);
-	if (n < 0 && expect_success)
-		FAIL_ERRNO("%s: unexpected failure: retval=%zd", prefix, n);
-	if (!n && !expect_success)
-		FAIL("%s: expected failure: retval=%zd", prefix, n);
+	n = recv(fd, &buf, 1, MSG_DONTWAIT | more_flags);
+	if (n >= 0)
+		FAIL("%s: unexpected success: retval=%zd", prefix, n);
 }
 
 static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
@@ -188,13 +185,13 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
 	}
 
 	/* Ensure queues are empty */
-	try_recv("bpf.recv(sd_send)", sd_send, MSG_DONTWAIT, false);
+	fail_recv("bpf.recv(sd_send)", sd_send, 0);
 	if (sd_in != sd_send)
-		try_recv("bpf.recv(sd_in)", sd_in, MSG_DONTWAIT, false);
+		fail_recv("bpf.recv(sd_in)", sd_in, 0);
 
-	try_recv("bpf.recv(sd_out)", sd_out, MSG_DONTWAIT, false);
+	fail_recv("bpf.recv(sd_out)", sd_out, 0);
 	if (sd_recv != sd_out)
-		try_recv("bpf.recv(sd_recv)", sd_recv, MSG_DONTWAIT, false);
+		fail_recv("bpf.recv(sd_recv)", sd_recv, 0);
 }
 
 static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,
@@ -257,15 +254,13 @@ static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,
 
 	if (send_flags & MSG_OOB) {
 		/* Fail reading OOB while in sockmap */
-		try_recv("bpf.recv(sd_out, MSG_OOB)", sd_out,
-			 MSG_OOB | MSG_DONTWAIT, false);
+		fail_recv("bpf.recv(sd_out, MSG_OOB)", sd_out, MSG_OOB);
 
 		/* Remove sd_out from sockmap */
 		xbpf_map_delete_elem(maps->out, &u32(0));
 
 		/* Check that OOB was dropped on redirect */
-		try_recv("recv(sd_out, MSG_OOB)", sd_out,
-			 MSG_OOB | MSG_DONTWAIT, false);
+		fail_recv("recv(sd_out, MSG_OOB)", sd_out, MSG_OOB);
 
 		goto del_in;
 	}

-- 
2.50.1


