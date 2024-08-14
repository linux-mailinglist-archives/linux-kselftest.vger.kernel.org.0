Return-Path: <linux-kselftest+bounces-15334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F911951FD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CBA1F221A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748D1B9B34;
	Wed, 14 Aug 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZANC8TFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C91B86C4;
	Wed, 14 Aug 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652456; cv=none; b=oiqwrDKvuL3APG0cYuepEQ3pX8HaRK1aYRAJgp0aPc9uJD8L//2hVwT69SKt/f5T4fFiuNCzVIuXsHKoA9FiUSUdIXRh3eEA2HGKgtJ8lCq9IZSCGmS7HMEzp36XbrDWNBaI6Q4maMuBTKPisI+mBrFQ4awkT90xq06ZEGeYzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652456; c=relaxed/simple;
	bh=rgAu4K6r7WzSzmmJO1fCrQvT3MGA3+T/oM3XbKnZQXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JBrF8ClTerM7a9fDK/AYwXWTdw5jQI5LSfJpNbLv7pJCJMsLQ34skTsRIpN0pEeWNqgiF8M1A6cPGSu/sKWGJcWI7ugDQga6VPRr4XettKwLRa0mHtAf02GJG1mGqMEcVxYoiMMoM0HV8LsPAy8N09ETFGyiIY4rYIzEWN9u7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZANC8TFY; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1seGjt-00H1bf-Ja; Wed, 14 Aug 2024 18:20:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=U8otZwZzZZvDkhW6NIBLeajqA7W4gQUWgdPnnL8wM3g=; b=ZANC8TFYLlVReXcZGhpcD+EJcg
	TKpD/ukYn6q9SHK+GCvEr445iJjGaHrI/9jLm62CS5HuBm+AazesjFGakekO8nJ84XLz8Y/7FoYMo
	voVWhDyGywXsmY77D18MukZsVwi/V6O4p1bXITsjgZyVWDBpWpy9xSMdvhfbvP4y3wmJxNRRtCWZn
	P92rb8SoQXO5R1JJGaw+Xn1vUS409mHwvLrqBtB3AJSe1M+X6sy29VV6OwK81QlGsul+26QNnB5t2
	L/OcqHFxJRh1+3HNtyWMfOYi3H1MaJOsuqbEPvingZsJKI/z3AhjDaQObc+zd1VeH0w1eUjc1nR9U
	UifbXgCQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1seGjs-0003ro-RX; Wed, 14 Aug 2024 18:20:45 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1seGjb-00ETRD-U3; Wed, 14 Aug 2024 18:20:27 +0200
Message-ID: <7ccedf8d-56e2-4c20-b463-7566bfcb50e0@rbox.co>
Date: Wed, 14 Aug 2024 18:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] selftests/bpf: Add selftest for sockmap/hashmap
 redirection
From: Michal Luczaj <mhal@rbox.co>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test redirection logic.

BPF_MAP_TYPE_SOCKMAP
BPF_MAP_TYPE_SOCKHASH
	✕
sk_msg-to-egress
sk_msg-to-ingress
sk_skb-to-egress
sk_skb-to-ingress
	✕
AF_INET, SOCK_STREAM
AF_INET6, SOCK_STREAM
AF_INET, SOCK_DGRAM
AF_INET6, SOCK_DGRAM
AF_UNIX, SOCK_STREAM
AF_UNIX, SOCK_DGRAM
AF_VSOCK, SOCK_STREAM
AF_VSOCK, SOCK_SEQPACKET

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../bpf/prog_tests/sockmap_helpers.h          |  58 ++++
 .../selftests/bpf/prog_tests/sockmap_redir.c  | 315 ++++++++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_redir.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index c50efa834a11..db0a7b4dc8be 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -16,6 +16,9 @@
 #define VMADDR_CID_LOCAL 1
 #endif
 
+#define u32(v) ((u32){(v)})
+#define u64(v) ((u64){(v)})
+
 #define __always_unused	__attribute__((__unused__))
 
 /* include/linux/cleanup.h */
@@ -485,4 +488,59 @@ static inline int create_socket_pairs(int family, int sotype, int *c0, int *c1,
 	return err;
 }
 
+static inline const char *socket_kind_to_str(int sock_fd)
+{
+	int domain = 0, type = 0;
+	socklen_t opt_len;
+
+	opt_len = sizeof(domain);
+	if (getsockopt(sock_fd, SOL_SOCKET, SO_DOMAIN, &domain, &opt_len))
+		FAIL_ERRNO("getsockopt(SO_DOMAIN)");
+
+	opt_len = sizeof(type);
+	if (getsockopt(sock_fd, SOL_SOCKET, SO_TYPE, &type, &opt_len))
+		FAIL_ERRNO("getsockopt(SO_TYPE)");
+
+	switch (domain) {
+	case AF_INET:
+		switch (type) {
+		case SOCK_STREAM:
+			return "tcp4";
+		case SOCK_DGRAM:
+			return "udp4";
+		}
+		break;
+	case AF_INET6:
+		switch (type) {
+		case SOCK_STREAM:
+			return "tcp6";
+		case SOCK_DGRAM:
+			return "udp6";
+		}
+		break;
+	case AF_UNIX:
+		switch (type) {
+		case SOCK_STREAM:
+			return "u_str";
+		case SOCK_DGRAM:
+			return "u_dgr";
+		case SOCK_SEQPACKET:
+			return "u_seq";
+		}
+		break;
+	case AF_VSOCK:
+		switch (type) {
+		case SOCK_STREAM:
+			return "v_str";
+		case SOCK_DGRAM:
+			return "v_dgr";
+		case SOCK_SEQPACKET:
+			return "v_seq";
+		}
+		break;
+	}
+
+	return "???";
+}
+
 #endif // __SOCKMAP_HELPERS__
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
new file mode 100644
index 000000000000..335dd348b019
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
@@ -0,0 +1,315 @@
+#include <stdio.h>
+#include <errno.h>
+#include <error.h>
+#include <sys/types.h>
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+#include <linux/vm_sockets.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "test_progs.h"
+#include "sockmap_helpers.h"
+#include "test_sockmap_listen.skel.h"
+
+enum prog_kind {
+	SK_MSG_EGRESS,
+	SK_MSG_INGRESS,
+	SK_SKB_EGRESS,
+	SK_SKB_INGRESS,
+};
+
+struct {
+	enum prog_kind prog_kind;
+	const char *in, *out;
+} supported[] = {
+	/* Send to local: TCP -> any but vsock */
+	{ SK_MSG_INGRESS,	"tcp",	"tcp"	},
+	{ SK_MSG_INGRESS,	"tcp",	"udp"	},
+	{ SK_MSG_INGRESS,	"tcp",	"u_str"	},
+	{ SK_MSG_INGRESS,	"tcp",	"u_dgr"	},
+	/* Send to egress: TCP -> TCP */
+	{ SK_MSG_EGRESS,	"tcp",	"tcp"	},
+	/* Ingress to egress: any -> any */
+	{ SK_SKB_EGRESS,	"any",	"any"	},
+	/* Ingress to local: any -> any but vsock */
+	{ SK_SKB_INGRESS,	"any",	"tcp"	},
+	{ SK_SKB_INGRESS,	"any",	"udp"	},
+	{ SK_SKB_INGRESS,	"any",	"u_str"	},
+	{ SK_SKB_INGRESS,	"any",	"u_dgr"	},
+};
+
+enum {
+	SEND_INNER = 0,
+	SEND_OUTER,
+};
+
+enum {
+	RECV_INNER = 0,
+	RECV_OUTER,
+};
+
+enum map_kind {
+	SOCKMAP,
+	SOCKHASH,
+};
+
+struct redir_spec {
+	const char *name;
+	int idx_send;
+	int idx_recv;
+	enum prog_kind prog_kind;
+};
+
+struct socket_spec {
+	int family;
+	int sotype;
+	int send_flags;
+	int in[2];
+	int out[2];
+};
+
+static int socket_spec_pairs(struct socket_spec *s)
+{
+	return create_socket_pairs(s->family, s->sotype,
+				   &s->in[0], &s->out[0],
+				   &s->in[1], &s->out[1]);
+}
+
+static void socket_spec_close(struct socket_spec *s)
+{
+	xclose(s->in[0]);
+	xclose(s->in[1]);
+	xclose(s->out[0]);
+	xclose(s->out[1]);
+}
+
+static void get_redir_params(struct redir_spec *redir,
+			     struct test_sockmap_listen *skel,
+			     int *prog_fd, enum bpf_attach_type *attach_type,
+			     bool *ingress_flag)
+{
+	enum prog_kind kind = redir->prog_kind;
+	struct bpf_program *prog;
+	bool sk_msg;
+
+	sk_msg = kind == SK_MSG_INGRESS || kind == SK_MSG_EGRESS;
+	prog = sk_msg ? skel->progs.prog_msg_verdict : skel->progs.prog_skb_verdict;
+
+	*prog_fd = bpf_program__fd(prog);
+	*attach_type = sk_msg ? BPF_SK_MSG_VERDICT : BPF_SK_SKB_VERDICT;
+	*ingress_flag = kind == SK_MSG_INGRESS || kind == SK_SKB_INGRESS;
+}
+
+static void test_send_redir_recv(int sd_send, int send_flags, int sd_in,
+				 int sd_out, int sd_recv, int map_in, int map_out)
+{
+	char *send_buf = "ab";
+	char recv_buf = '\0';
+	ssize_t n, len = 1;
+
+	if (xbpf_map_update_elem(map_in, &u32(0), &u64(sd_in), BPF_NOEXIST))
+		return;
+
+	if (xbpf_map_update_elem(map_out, &u32(0), &u64(sd_out), BPF_NOEXIST))
+		goto del_in;
+
+	/* Last byte is OOB data when send_flags has MSG_OOB bit set */
+	if (send_flags & MSG_OOB)
+		len++;
+	n = send(sd_send, send_buf, len, send_flags);
+	if (n >= 0 && n < len)
+		FAIL("incomplete send");
+	if (n < len && errno != EACCES) {
+		FAIL_ERRNO("send");
+		goto out;
+	}
+
+	/* sk_msg redirect combo not supported */
+	if (errno == EACCES) {
+		test__skip();
+		goto out;
+	}
+
+	n = recv_timeout(sd_recv, &recv_buf, 1, 0, IO_TIMEOUT_SEC);
+	if (n != 1) {
+		FAIL_ERRNO("recv");
+		goto out;
+	}
+	if (recv_buf != send_buf[0])
+		FAIL("recv: payload check, %02x != %02x", recv_buf, send_buf[0]);
+
+	if (send_flags & MSG_OOB) {
+		/* Check that we can't read OOB while in sockmap */
+		errno = 0;
+		n = recv(sd_out, &recv_buf, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n != -1)
+			FAIL("recv(MSG_OOB): expected failure: retval=%zd errno=%d",
+			     n, errno);
+
+		/* Remove sd_out from sockmap */
+		xbpf_map_delete_elem(map_out, &u32(0));
+
+		/* Check that OOB was dropped on redirect */
+		errno = 0;
+		n = recv(sd_out, &recv_buf, 1, MSG_OOB | MSG_DONTWAIT);
+		if (n != -1)
+			FAIL("recv(MSG_OOB): expected failure: retval=%zd errno=%d",
+			     n, errno);
+
+		goto del_in;
+	}
+out:
+	xbpf_map_delete_elem(map_out, &u32(0));
+del_in:
+	xbpf_map_delete_elem(map_in, &u32(0));
+}
+
+static bool is_supported(enum prog_kind prog_kind, const char *in, const char *out)
+{
+	for (int i = 0; i < ARRAY_SIZE(supported); ++i)	{
+		if (supported[i].prog_kind == prog_kind &&
+		    (!strcmp(supported[i].in, "any") || strstr(in, supported[i].in)) &&
+		    (!strcmp(supported[i].out, "any") || strstr(out, supported[i].out)))
+			return true;
+	}
+
+	return false;
+}
+
+static void test_socket(enum map_kind map_kind, struct redir_spec *redir,
+			int map_in, int map_out, struct socket_spec *s_in,
+			struct socket_spec *s_out)
+{
+	int fd_in, fd_out, fd_send, fd_recv, send_flags;
+	const char *in_str, *out_str;
+	char s[MAX_TEST_NAME];
+
+	fd_in = s_in->in[0];
+	fd_out = s_out->out[0];
+	fd_send = s_in->in[redir->idx_send];
+	fd_recv = s_out->out[redir->idx_recv];
+	send_flags = s_in->send_flags;
+
+	in_str = socket_kind_to_str(fd_in);
+	out_str = socket_kind_to_str(fd_out);
+
+	snprintf(s, sizeof(s),
+		 "%-4s %-17s %-5s → %-5s%6s",
+		 /* hash sk_skb-to-ingress u_str → v_str (OOB) */
+		 map_kind == SOCKMAP ? "map" : "hash",
+		 redir->name,
+		 in_str,
+		 out_str,
+		 send_flags & MSG_OOB ? "(OOB)" : "");
+
+	if (!test__start_subtest(s))
+		return;
+
+	if (!is_supported(redir->prog_kind, in_str, out_str)) {
+		test__skip();
+		return;
+	}
+
+	test_send_redir_recv(fd_send, send_flags, fd_in, fd_out, fd_recv,
+			     map_in, map_out);
+}
+
+static void test_redir(enum map_kind map_kind, struct redir_spec *redir,
+		       int map_in, int map_out)
+{
+	struct socket_spec *s, sockets[] = {
+		{ AF_INET, SOCK_STREAM },
+		// { AF_INET, SOCK_STREAM, MSG_OOB },	/* Known to be broken */
+		{ AF_INET6, SOCK_STREAM },
+		{ AF_INET, SOCK_DGRAM },
+		{ AF_INET6, SOCK_DGRAM },
+		{ AF_UNIX, SOCK_STREAM },
+		{ AF_UNIX, SOCK_STREAM, MSG_OOB },
+		{ AF_UNIX, SOCK_DGRAM },
+		// { AF_UNIX, SOCK_SEQPACKET},		/* Not supported */
+		{ AF_VSOCK, SOCK_STREAM },
+		// { AF_VSOCK, SOCK_DGRAM },		/* Not supported */
+		{ AF_VSOCK, SOCK_SEQPACKET },
+	};
+
+	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
+		if (socket_spec_pairs(s))
+			goto out;
+
+	/* Intra-proto */
+	for (s = sockets; s < sockets + ARRAY_SIZE(sockets); s++)
+		test_socket(map_kind, redir, map_in, map_out, s, s);
+
+	/* Cross-proto */
+	for (int i = 0; i < ARRAY_SIZE(sockets); i++) {
+		for (int j = 0; j < ARRAY_SIZE(sockets); j++) {
+			struct socket_spec *in = &sockets[i];
+			struct socket_spec *out = &sockets[j];
+
+			/* Skip intra-proto and between variants */
+			if (out->send_flags ||
+			    (in->family == out->family &&
+			     in->sotype == out->sotype))
+				continue;
+
+			test_socket(map_kind, redir, map_in, map_out, in, out);
+		}
+	}
+out:
+	while (--s >= sockets)
+		socket_spec_close(s);
+}
+
+static void test_map(enum map_kind map_kind)
+{
+	struct redir_spec *r, redirs[] = {
+		{ "sk_msg-to-egress", SEND_INNER, RECV_OUTER, SK_MSG_EGRESS },
+		{ "sk_msg-to-ingress", SEND_INNER, RECV_INNER, SK_MSG_INGRESS },
+		{ "sk_skb-to-egress", SEND_OUTER, RECV_OUTER, SK_SKB_EGRESS },
+		{ "sk_skb-to-ingress", SEND_OUTER, RECV_INNER, SK_SKB_INGRESS },
+	};
+
+	for (r = redirs; r < redirs + ARRAY_SIZE(redirs); r++) {
+		struct test_sockmap_listen *skel;
+		enum bpf_attach_type attach_type;
+		int prog, map_in, map_out;
+
+		skel = test_sockmap_listen__open_and_load();
+		if (!skel) {
+			FAIL("open_and_load");
+			return;
+		}
+
+		if (map_kind == SOCKMAP) {
+			skel->bss->test_sockmap = true;
+			map_out = bpf_map__fd(skel->maps.sock_map);
+		} else {
+			skel->bss->test_sockmap = false;
+			map_out = bpf_map__fd(skel->maps.sock_hash);
+		}
+
+		map_in = bpf_map__fd(skel->maps.nop_map);
+		get_redir_params(r, skel, &prog, &attach_type,
+				 &skel->bss->test_ingress);
+
+		if (xbpf_prog_attach(prog, map_in, attach_type, 0))
+			return;
+
+		test_redir(map_kind, r, map_in, map_out);
+
+		if (xbpf_prog_detach2(prog, map_in, attach_type))
+			return;
+
+		test_sockmap_listen__destroy(skel);
+	}
+}
+
+void serial_test_sockmap_redir(void)
+{
+	test_map(SOCKMAP);
+	test_map(SOCKHASH);
+}
-- 
2.46.0


