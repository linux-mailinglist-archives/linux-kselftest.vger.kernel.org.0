Return-Path: <linux-kselftest+bounces-40825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9FB455FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609B95C5B1E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32934A329;
	Fri,  5 Sep 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lQsned7G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD234A32D;
	Fri,  5 Sep 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070739; cv=none; b=GAMFHn78haTdVG+tUlxrJjxpr7FLdT32ZgxJgsB1uv88XsUUpFRsNgQyZZJTOD5rH5WumtAZ8uz5AfmTsA6wR57w7ZJ26UEXHJC2uj0y9boNZOW+NJQ+4zyoBPeeIN6hSICvgKMIAcgc18tc9PEiXqhf+dqjkPaNhABgV7UF4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070739; c=relaxed/simple;
	bh=t6Rj18HPnifnNiTJet0Gv+ZbNp1682MFTdRToJhRwwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSMdFlTmJ/bXQ6FA6bQQncMcwu12/sDx0TR5HpJ21HJN3ZqcnDcMJfhPlimiFm87LQ13N6l86itBAhdE5RdwrDnrjUBpArDHBG1rZrDTPIaFQaYH09/E0tvVzPaEuQg2dSpXpWLjvfLeRVr1nKr0tvX+waFiFn23kIt3WAR5+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lQsned7G; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMY-003TJp-LR; Fri, 05 Sep 2025 13:12:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=tPRtNOCc0T6RXMXNRg93pifV3fla/+JNX7dzc2AQnI4=; b=lQsned7G591sjWTg+WIeXFDsFP
	G6lUF3KH/00ujbWTTLtvPtPt5OWvmY3LH7PRnAs14sD3bOg+fmbL4k+6Nwt6ytSIJ5nsJO9yabOMZ
	2C5gesKoyFpKoxb53IYmluP27TPjoVV81qGGJqBAoOXXSPIZlwVSduAIy43Og9+1F9gIMFPIbKXVT
	+7RsrbI34M/O5zXXsQbfq2maRdKZoBKzvO8zWl9PljcZAd1HTJ65lGWRxeyXTqbSLZb35zEeCwTEf
	xMLSypz2IEcaPlOrbbQuKaQqrpwU3sjndNntADiv++8XO2gCUvgtApF1YQ8RjXtST8++eOSvGSbcu
	JfWQzLWw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uuUMY-0002K3-Ak; Fri, 05 Sep 2025 13:12:14 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuUMD-002yZ1-UJ; Fri, 05 Sep 2025 13:11:54 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 05 Sep 2025 13:11:45 +0200
Subject: [PATCH bpf-next 5/5] selftests/bpf: sockmap_redir: Support
 no-redirect SK_DROP/SK_PASS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co>
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
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Jiayuan Chen <mrpre@163.com>
X-Mailer: b4 0.14.2

Add tests that make the BPF programs skip the actual redirect and
immediately return SK_DROP/SK_PASS.

Suggested-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_redir.c       | 74 +++++++++++++++++++---
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
index f89df1ca1174800d801f221a819b099abf911450..4c752000bbd8c84684b2df81eb389be953d8ba02 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -18,6 +18,10 @@
  * AF_UNIX, SOCK_DGRAM
  * AF_VSOCK, SOCK_STREAM
  * AF_VSOCK, SOCK_SEQPACKET
+ *	x
+ * SK_REDIRECT
+ * SK_DROP
+ * SK_PASS
  */
 
 #include <errno.h>
@@ -65,6 +69,10 @@
  */
 #define UNSUPPORTED_RACY_VERD	_BITUL(1)
 
+/* Mark for an immediate SK_DROP/SK_PASS, i.e. BPF program will not redirect.
+ */
+#define NO_REDIRECT		_BITUL(2)
+
 enum prog_type {
 	SK_MSG_EGRESS,
 	SK_MSG_INGRESS,
@@ -154,8 +162,9 @@ static void fail_recv(const char *prefix, int fd, int more_flags)
 		FAIL("%s: unexpected success: retval=%zd", prefix, n);
 }
 
-static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
-			       int sd_recv, int map_verd, int status)
+static void handle_unsupported(int sd_send, int send_flags, int sd_peer,
+			       int sd_in, int sd_out, int sd_recv,
+			       int map_verd, int status)
 {
 	unsigned int drop, pass;
 	char recv_buf;
@@ -171,7 +180,7 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
 		goto get_verdict;
 	}
 
-	if (pass != 0) {
+	if (pass && !(status & NO_REDIRECT)) {
 		FAIL("unsupported: wanted verdict pass 0, have %u", pass);
 		return;
 	}
@@ -237,14 +246,14 @@ static void test_send_recv(int sd_send, int send_flags, int sd_peer, int sd_in,
 		FAIL("incomplete send");
 	if (n < 0) {
 		/* sk_msg redirect combo not supported? */
-		if (status & SUPPORTED || errno != EACCES)
+		if (errno != EACCES)
 			FAIL_ERRNO("send");
 		goto out;
 	}
 
-	if (!(status & SUPPORTED)) {
-		handle_unsupported(sd_send, sd_peer, sd_in, sd_out, sd_recv,
-				   maps->verd, status);
+	if (!(status & SUPPORTED) || (status & NO_REDIRECT)) {
+		handle_unsupported(sd_send, send_flags, sd_peer, sd_in, sd_out,
+				   sd_recv, maps->verd, status);
 		goto out;
 	}
 
@@ -326,9 +335,10 @@ static int is_redir_supported(enum prog_type type, const char *in,
 static int get_support_status(enum prog_type type, const char *in,
 			      const char *out)
 {
-	int status = is_redir_supported(type, in, out);
+	int status = in ? is_redir_supported(type, in, out) : 0;
 
-	if (type == SK_SKB_INGRESS && strstarts(out, "v_"))
+	if ((type == SK_SKB_INGRESS || type == SK_SKB_EGRESS) &&
+	    strstarts(out, "v_"))
 		status |= UNSUPPORTED_RACY_VERD;
 
 	return status;
@@ -370,6 +380,41 @@ static void test_redir(enum bpf_map_type type, struct redir_spec *redir,
 		       status);
 }
 
+static void test_verdict(enum bpf_map_type type, struct redir_spec *redir,
+			 struct maps *maps, struct socket_spec *s_in,
+			 enum sk_action action)
+{
+	int fd_in, fd_out, fd_send, fd_peer, fd_recv, flags, status;
+	char s[MAX_TEST_NAME];
+	const char *s_str;
+
+	fd_in = s_in->in[0];
+	fd_out = s_in->in[1];
+	fd_send = s_in->in[redir->idx_send];
+	fd_peer = s_in->in[redir->idx_send ^ 1];
+	fd_recv = s_in->in[redir->idx_send ^ 1];
+	flags = s_in->send_flags;
+
+	s_str = socket_kind_to_str(fd_in);
+	status = get_support_status(redir->prog_type, NULL, s_str);
+	status |= NO_REDIRECT;
+
+	snprintf(s, sizeof(s),
+		 "%-4s %-17s %-7s %-5s%6s",
+		 /* hash sk_skb-to-ingress u_str pass (OOB) */
+		 type == BPF_MAP_TYPE_SOCKMAP ? "map" : "hash",
+		 redir->name,
+		 s_str,
+		 action == SK_PASS ? "pass" : "drop",
+		 flags & MSG_OOB ? "(OOB)" : "");
+
+	if (!test__start_subtest(s))
+		return;
+
+	test_send_recv(fd_send, flags, fd_peer, fd_in, fd_out, fd_recv, maps,
+		       status);
+}
+
 static void test_sockets(enum bpf_map_type type, struct redir_spec *redir,
 			 struct maps *maps, int *skel_redir_type)
 {
@@ -413,6 +458,17 @@ static void test_sockets(enum bpf_map_type type, struct redir_spec *redir,
 			test_redir(type, redir, maps, in, out);
 		}
 	}
+
+	/* No redirect: SK_DROP */
+	*skel_redir_type = __MAX_BPF_MAP_TYPE + SK_DROP;
+	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
+		test_verdict(type, redir, maps, s, SK_DROP);
+
+	/* No redirect: SK_PASS */
+	*skel_redir_type = __MAX_BPF_MAP_TYPE + SK_PASS;
+	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
+		test_verdict(type, redir, maps, s, SK_PASS);
+
 out:
 	while (--s >= sockets)
 		socket_spec_close(s);

-- 
2.50.1


