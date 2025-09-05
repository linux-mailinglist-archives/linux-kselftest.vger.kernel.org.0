Return-Path: <linux-kselftest+bounces-40823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED6B455F3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E48A7C6058
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254434A30B;
	Fri,  5 Sep 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OScDwel8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E9345721;
	Fri,  5 Sep 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070730; cv=none; b=h1ljUv4BC599Kb7sAa/YdYt3W2ko8oZASK/S2/2FXXCfnYYhcDY3J1u1JNKZF1OZ3u+vQIvYBSahhFrgWYlCT370Xed0a3+xDosggs9Av2kTgPlB4lROTbQw7n/2UKx5xNCz08CaD4XSkrwRUKVHytK/iPfx6X1Tl+cbwLidv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070730; c=relaxed/simple;
	bh=uFSjXhlUsJWf4M8iMNwEYj1BtPc+bInOKVbCCpbhzLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVjtBuBo1ygLYFngIYSw03kEqoQP546ThWGQiDyKIxa85LsElMefh2x3eZAqfiuM+AEBCFoetTtCviw8YqmcL+MaZjCnhIinoCx4jkuC8wBSThnfdnOJVB3KHMpuTlMhMnU2pDZjUek/zkjmawIzdPLvhxcQyhSRFsU2XmjHG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OScDwel8; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMN-003TFD-Ek; Fri, 05 Sep 2025 13:12:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=8Ml/q57UnovbWFQocDRim2+luhY4OknJEfSmVdybkuI=; b=OScDwel8s11nxTMsFIDA9bxW7T
	sRmcXxT+LTpyHSsquN/PHS5Lx6S+yeS9jsZXjNhHfgAKUxwtxoloAf8dZ4QnTRC0IFXP8JGbtudiy
	EbJ6hvCRH+gSJVWHM0ulyQN/u6MB3h1IG1qOv6zRJ2WmBSoG10Bq2pT1zvc8gsYlzH0o5cSBSVtNE
	aFxbS8jzqdM+jszm8fs6Ggu38s0Kj5sI+T8sldenOnz6DMh29sFvgDGSwJY/X4APATmdog8OSjnJq
	Ry0yKziN0w1Gy99irgwo4g532aJSFkC+yygazNr79XdV2hLGAm6oEGHlVSbuA26lGGaz4PLNanxj5
	SFBQzAFQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMK-0002Gw-Te; Fri, 05 Sep 2025 13:12:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUMC-002yZ1-0N; Fri, 05 Sep 2025 13:11:52 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 05 Sep 2025 13:11:43 +0200
Subject: [PATCH bpf-next 3/5] selftests/bpf: sockmap_redir: Rename
 functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co>
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

Preparatory patch before adding SK_PASS/SK_DROP support:

test_redir() => test_sockets()
test_socket() => test_redir()
test_send_redir_recv() => test_send_recv()

After the change (and the following patch) the call stack will be:

serial_test_sockmap_redir
  test_map
    test_sockets
      test_redir
        test_send_recv
      (test_verdict)
        (test_send_recv)

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 25 +++++++++++-----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index 4997e72c14345b274367f3f2f4115c39d1ae48c9..9fc5b4dd323d8554e6dc89d06be9054612e41020 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -210,9 +210,8 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
 	fail_recv("recv(sd_out, OOB)", sd_out, MSG_OOB);
 }
 
-static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,
-				 int sd_in, int sd_out, int sd_recv,
-				 struct maps *maps, int status)
+static void test_send_recv(int sd_send, int send_flags, int sd_peer, int sd_in,
+			   int sd_out, int sd_recv, struct maps *maps, int status)
 {
 	unsigned int drop, pass;
 	char *send_buf = "ab";
@@ -335,9 +334,9 @@ static int get_support_status(enum prog_type type, const char *in,
 	return status;
 }
 
-static void test_socket(enum bpf_map_type type, struct redir_spec *redir,
-			struct maps *maps, struct socket_spec *s_in,
-			struct socket_spec *s_out)
+static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
+		       struct maps *maps, struct socket_spec *s_in,
+		       struct socket_spec *s_out)
 {
 	int fd_in, fd_out, fd_send, fd_peer, fd_recv, flags, status;
 	const char *in_str, *out_str;
@@ -367,12 +366,12 @@ static void test_socket(enum bpf_map_type type, struct redir_spec *redir,
 	if (!test__start_subtest(s))
 		return;
 
-	test_send_redir_recv(fd_send, flags, fd_peer, fd_in, fd_out, fd_recv,
-			     maps, status);
+	test_send_recv(fd_send, flags, fd_peer, fd_in, fd_out, fd_recv, maps,
+		       status);
 }
 
-static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
-		       struct maps *maps)
+static void test_sockets(enum bpf_map_type type, struct redir_spec *redir,
+			 struct maps *maps)
 {
 	struct socket_spec *s, sockets[] = {
 		{ AF_INET, SOCK_STREAM },
@@ -395,7 +394,7 @@ static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
 
 	/* Intra-proto */
 	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
-		test_socket(type, redir, maps, s, s);
+		test_redir(type, redir, maps, s, s);
 
 	/* Cross-proto */
 	for (int i = 0; i < ARRAY_SIZE(sockets); i++) {
@@ -409,7 +408,7 @@ static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
 			     in->sotype == out->sotype))
 				continue;
 
-			test_socket(type, redir, maps, in, out);
+			test_redir(type, redir, maps, in, out);
 		}
 	}
 out:
@@ -460,7 +459,7 @@ static void test_map(enum bpf_map_type type)
 		if (xbpf_prog_attach(prog_fd, maps.in, attach_type, 0))
 			return;
 
-		test_redir(type, r, &maps);
+		test_sockets(type, r, &maps);
 
 		if (xbpf_prog_detach2(prog_fd, maps.in, attach_type))
 			return;

-- 
2.50.1


