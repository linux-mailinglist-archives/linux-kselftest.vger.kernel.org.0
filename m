Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E6710730
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbjEYITp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbjEYITm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 04:19:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A6E42
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 01:19:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so3043395e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685002773; x=1687594773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M+p6XfY9bpbtVibj8wMrTBF5YmJeMykjF37fK2dZH0=;
        b=L9oKsyExayAPw78ikkzAi7uPopVonwaYktWEFmEszxBcFDLYUjBE56Rvd1NlnTL0wH
         LQVHctu2chjWWtGw8zl0ZXA5Gxh/0ia0tisrC8tmqkMkmXOzLyzbrv61kze+xqgb5qQu
         ml+07RHT/EL/jXvy1yBFrDTfbqNHwh6uv6Rsx7hpBJQUMTOoOoPNUtZHWzU0JshobdMc
         ENwtIhUx+Vm/MwfbxAHqqLIoaXl8WqB9fr6vdrrdGvFofFibknNWdHF+X+lKuJAzpA+1
         b6aCJ2w3/KgGSdwCeGfWrs2uC5WOWhDPJGta2eHEXKn9EMB91o6LN23fr7AXnh101uIz
         QI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685002773; x=1687594773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M+p6XfY9bpbtVibj8wMrTBF5YmJeMykjF37fK2dZH0=;
        b=XEpzmpD6kbJFIiYbjFTOvFRoK4+UZJufdABIO7ROS9sYsqurUO6eIjjwlWqlNGK+Va
         ez1QMbGuKno4LiG20Z+ItYJkzp8dNqi0khTu7kEtDL4F+cqyFAcjfy59y/fHKn4N7B+g
         GW3Re58vWp4NrXRgIZFMyfZOqC/yacNr5zNhJk5UzYu5Mrh49J7ADewR612Ut+KCJocT
         qOwIeEZFc4a5MPY3RldEzsH2fnaugU73PACaWhsUQbA5kuOgHfpkytyIYRYozcqcsGY0
         26ewONtwEFWbBmXNYRLF09k+84LVHVALFjVabvVj2tpElrhLUJtB7mrhosRhQba3WGos
         Lo3w==
X-Gm-Message-State: AC+VfDwZr1ksaemxYNEbFOsNbN2fyTtVjmBDE7QAsdHRghl+FFapRk8u
        1eBXCWTdC3hRBZKF0kiYp1cayw==
X-Google-Smtp-Source: ACHHUZ5RyunDcCFe4caQzD0DdT2EQlF3zGscjWuXqb9SY1zMoxQo+D7QQH2bh/NJgX5EvUbi2LTHnA==
X-Received: by 2002:a05:600c:378b:b0:3f6:a44:73bb with SMTP id o11-20020a05600c378b00b003f60a4473bbmr1787873wmr.8.1685002772945;
        Thu, 25 May 2023 01:19:32 -0700 (PDT)
Received: from algol.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm4960399wml.15.2023.05.25.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:19:32 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Lorenz Bauer <lmb@isovalent.com>, Joe Stringer <joe@cilium.io>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test that SO_REUSEPORT can be used with sk_assign helper
Date:   Thu, 25 May 2023 09:19:23 +0100
Message-Id: <20230525081923.8596-2-lmb@isovalent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525081923.8596-1-lmb@isovalent.com>
References: <20230525081923.8596-1-lmb@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

We use two programs to check that the new reuseport logic is executed
appropriately.

The first is a TC clsact program which bpf_sk_assigns
the skb to a UDP or TCP socket created by user space. Since the test
communicates via lo we see both directions of packets in the eBPF.
Traffic ingressing to the reuseport socket is identified by looking
at the destination port. For TCP, we additionally need to make sure
that we only assign the initial SYN packets towards our listening
socket. The network stack then creates a request socket which
transitions to ESTABLISHED after the 3WHS.

The second is a reuseport program which shares the fact that
it has been executed with user space. This tells us that the delayed
lookup mechanism is working.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
Cc: Joe Stringer <joe@cilium.io>
---
 tools/testing/selftests/bpf/network_helpers.c |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c   | 280 ++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c   | 142 +++++++++
 3 files changed, 425 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/assign_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_assign_reuse.c

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a105c0cd008a..8a33bcea97de 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -423,6 +423,9 @@ struct nstoken *open_netns(const char *name)
 
 void close_netns(struct nstoken *token)
 {
+	if (!token)
+		return;
+
 	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET), "setns");
 	close(token->orig_netns_fd);
 	free(token);
diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
new file mode 100644
index 000000000000..2cb9bb591e71
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+#include <uapi/linux/if_link.h>
+#include <test_progs.h>
+
+#include <netinet/tcp.h>
+#include <netinet/udp.h>
+
+#include "network_helpers.h"
+#include "test_assign_reuse.skel.h"
+
+#define NS_TEST "assign_reuse"
+#define LOOPBACK 1
+#define PORT 4443
+
+static int attach_reuseport(int sock_fd, int prog_fd)
+{
+	return setsockopt(sock_fd, SOL_SOCKET, SO_ATTACH_REUSEPORT_EBPF,
+			  &prog_fd, sizeof(prog_fd));
+}
+
+static socklen_t inetaddr_len(const struct sockaddr_storage *addr)
+{
+	return addr->ss_family == AF_INET  ? sizeof(struct sockaddr_in) :
+	       addr->ss_family == AF_INET6 ? sizeof(struct sockaddr_in6) :
+					     0;
+}
+
+static bool is_ipv6(const char *ip)
+{
+	return !!strchr(ip, ':');
+}
+
+static int make_socket(int sotype, const char *ip, int port,
+		       struct sockaddr_storage *addr)
+{
+	struct timeval timeo = { .tv_usec = 500000 /* 500 ms */ };
+	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
+	int ret, fd;
+
+	ret = make_sockaddr(family, ip, port, addr, NULL);
+	if (!ASSERT_OK(ret, "make_sockaddr"))
+		return -1;
+	fd = socket(addr->ss_family, sotype, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		return -1;
+	ret = setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo, sizeof(timeo));
+	if (!ASSERT_OK(ret, "sndtimeo")) {
+		close(fd);
+		return -1;
+	}
+	ret = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+	if (!ASSERT_OK(ret, "rcvtimeo")) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+static int create_server(int sotype, const char *ip, int port, int prog_fd)
+{
+	struct sockaddr_storage addr = {};
+	const int one = 1;
+	int ret, fd;
+
+	fd = make_socket(sotype, ip, port, &addr);
+	if (fd < 0)
+		return -1;
+	if (sotype == SOCK_STREAM) {
+		ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one,
+				 sizeof(one));
+		if (!ASSERT_OK(ret, "reuseaddr"))
+			goto cleanup;
+	}
+	if (prog_fd >= 0) {
+		ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one,
+				 sizeof(one));
+		if (!ASSERT_OK(ret, "reuseport"))
+			goto cleanup;
+		ret = attach_reuseport(fd, prog_fd);
+		if (!ASSERT_OK(ret, "attach_reuseport"))
+			goto cleanup;
+	}
+	ret = bind(fd, (void *)&addr, inetaddr_len(&addr));
+	if (!ASSERT_OK(ret, "bind"))
+		goto cleanup;
+	if (sotype == SOCK_STREAM) {
+		ret = listen(fd, SOMAXCONN);
+		if (!ASSERT_OK(ret, "listen"))
+			goto cleanup;
+	}
+	return fd;
+cleanup:
+	close(fd);
+	return -1;
+}
+
+static int create_client(int sotype, const char *ip, int port)
+{
+	struct sockaddr_storage addr = {};
+	int ret, fd;
+
+	fd = make_socket(sotype, ip, port, &addr);
+	if (fd < 0)
+		return -1;
+	ret = connect(fd, (void *)&addr, inetaddr_len(&addr));
+	if (ret)
+		goto cleanup;
+	return fd;
+cleanup:
+	close(fd);
+	return -1;
+}
+
+static __u64 cookie(int fd)
+{
+	__u64 cookie = 0;
+	socklen_t cookie_len = sizeof(cookie);
+	int ret;
+
+	ret = getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie, &cookie_len);
+	ASSERT_OK(ret, "cookie");
+	ASSERT_GT(cookie, 0, "cookie_invalid");
+
+	return cookie;
+}
+
+static int echo_test_udp(int fd_sv, const char *ip, int port)
+{
+	struct sockaddr_storage addr = {};
+	socklen_t len = sizeof(addr);
+	char buff[1] = {};
+	int fd_cl = -1, ret;
+
+	fd_cl = create_client(SOCK_DGRAM, ip, port);
+	ASSERT_GT(fd_cl, 0, "create_client");
+	ASSERT_EQ(getsockname(fd_cl, (void *)&addr, &len), 0, "getsockname");
+
+	ASSERT_EQ(send(fd_cl, buff, sizeof(buff), 0), 1, "send_client");
+
+	ret = recv(fd_sv, buff, sizeof(buff), 0);
+	if (ret < 0)
+		return errno;
+
+	ASSERT_EQ(ret, 1, "recv_server");
+	ASSERT_EQ(sendto(fd_sv, buff, sizeof(buff), 0, (void *)&addr, len), 1, "send_server");
+	ASSERT_EQ(recv(fd_cl, buff, sizeof(buff), 0), 1, "recv_client");
+	close(fd_cl);
+	return 0;
+}
+
+static int echo_test_tcp(int fd_sv, const char *ip, int port)
+{
+	char buff[1] = {};
+	int fd_cl = -1, fd_sv_cl = -1;
+
+	fd_cl = create_client(SOCK_STREAM, ip, port);
+	if (fd_cl < 0)
+		return errno;
+
+	fd_sv_cl = accept(fd_sv, NULL, NULL);
+	ASSERT_GE(fd_sv_cl, 0, "accept_fd");
+
+	ASSERT_EQ(send(fd_cl, buff, sizeof(buff), 0), 1, "send_client");
+	ASSERT_EQ(recv(fd_sv_cl, buff, sizeof(buff), 0), 1, "recv_server");
+	ASSERT_EQ(send(fd_sv_cl, buff, sizeof(buff), 0), 1, "send_server");
+	ASSERT_EQ(recv(fd_cl, buff, sizeof(buff), 0), 1, "recv_client");
+	close(fd_sv_cl);
+	close(fd_cl);
+	return 0;
+}
+
+void run_assign_reuse(int sotype, const char *ip, int port)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = LOOPBACK,
+			    .attach_point = BPF_TC_INGRESS, );
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1, );
+	bool hook_created = false, tc_attached = false;
+	int ret, fd_tc, fd_accept, fd_drop, fd_sv = -1, fd_map;
+	__u64 fd_val;
+	struct test_assign_reuse *skel;
+	const int zero = 0;
+
+	skel = test_assign_reuse__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	skel->rodata->dest_port = port;
+
+	ret = test_assign_reuse__load(skel);
+	if (!ASSERT_OK(ret, "skel_load"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->sk_cookie_seen, 0, "cookie_init");
+
+	fd_tc = bpf_program__fd(skel->progs.tc_main);
+	fd_accept = bpf_program__fd(skel->progs.reuse_accept);
+	fd_drop = bpf_program__fd(skel->progs.reuse_drop);
+	fd_map = bpf_map__fd(skel->maps.sk_map);
+
+	fd_sv = create_server(sotype, ip, port, fd_drop);
+	if (!ASSERT_GE(fd_sv, 0, "create_server"))
+		goto cleanup;
+
+	fd_val = fd_sv;
+	ret = bpf_map_update_elem(fd_map, &zero, &fd_val, BPF_NOEXIST);
+	if (!ASSERT_OK(ret, "bpf_sk_map"))
+		goto cleanup;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (ret == 0)
+		hook_created = true;
+	ret = ret == -EEXIST ? 0 : ret;
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = fd_tc;
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+	tc_attached = true;
+
+	if (sotype == SOCK_STREAM)
+		ASSERT_EQ(echo_test_tcp(fd_sv, ip, port), ECONNREFUSED, "drop_tcp");
+	else
+		ASSERT_EQ(echo_test_udp(fd_sv, ip, port), EAGAIN, "drop_udp");
+	ASSERT_EQ(skel->bss->reuseport_executed, 1, "program executed once");
+
+	skel->bss->sk_cookie_seen = 0;
+	skel->bss->reuseport_executed = 0;
+	ASSERT_OK(attach_reuseport(fd_sv, fd_accept), "attach_reuseport(accept)");
+
+	if (sotype == SOCK_STREAM)
+		ASSERT_EQ(echo_test_tcp(fd_sv, ip, port), 0, "echo_tcp");
+	else
+		ASSERT_EQ(echo_test_udp(fd_sv, ip, port), 0, "echo_udp");
+
+	ASSERT_EQ(skel->bss->sk_cookie_seen, cookie(fd_sv),
+		  "cookie_mismatch");
+	ASSERT_EQ(skel->bss->reuseport_executed, 1, "program executed once");
+cleanup:
+	if (tc_attached) {
+		tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
+		ret = bpf_tc_detach(&tc_hook, &tc_opts);
+		ASSERT_OK(ret, "bpf_tc_detach");
+	}
+	if (hook_created) {
+		tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
+		bpf_tc_hook_destroy(&tc_hook);
+	}
+	test_assign_reuse__destroy(skel);
+	close(fd_sv);
+}
+
+void serial_test_assign_reuse(void)
+{
+	struct nstoken *tok = NULL;
+
+	SYS(out, "ip netns add %s", NS_TEST);
+	SYS(cleanup, "ip -net %s link set dev lo up", NS_TEST);
+
+	tok = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(tok, "netns token"))
+		return;
+
+	if (test__start_subtest("tcpv4"))
+		run_assign_reuse(SOCK_STREAM, "127.0.0.1", PORT);
+	if (test__start_subtest("tcpv6"))
+		run_assign_reuse(SOCK_STREAM, "::1", PORT);
+	if (test__start_subtest("udpv4"))
+		run_assign_reuse(SOCK_DGRAM, "127.0.0.1", PORT);
+	if (test__start_subtest("udpv6"))
+		run_assign_reuse(SOCK_DGRAM, "::1", PORT);
+
+cleanup:
+	close_netns(tok);
+	SYS_NOFAIL("ip netns delete %s", NS_TEST);
+out:
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_assign_reuse.c b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
new file mode 100644
index 000000000000..c83e870b2612
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/pkt_cls.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+__u64 sk_cookie_seen;
+__u64 reuseport_executed;
+union {
+	struct tcphdr tcp;
+	struct udphdr udp;
+} headers;
+
+const volatile __u16 dest_port;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} sk_map SEC(".maps");
+
+SEC("sk_reuseport")
+int reuse_accept(struct sk_reuseport_md *ctx)
+{
+	reuseport_executed++;
+
+	if (ctx->ip_protocol == IPPROTO_TCP) {
+		if (ctx->data + sizeof(headers.tcp) > ctx->data_end)
+			return SK_DROP;
+
+		if (__builtin_memcmp(&headers.tcp, ctx->data, sizeof(headers.tcp)) != 0)
+			return SK_DROP;
+	} else if (ctx->ip_protocol == IPPROTO_UDP) {
+		if (ctx->data + sizeof(headers.udp) > ctx->data_end)
+			return SK_DROP;
+
+		if (__builtin_memcmp(&headers.udp, ctx->data, sizeof(headers.udp)) != 0)
+			return SK_DROP;
+	} else {
+		return SK_DROP;
+	}
+
+	sk_cookie_seen = bpf_get_socket_cookie(ctx->sk);
+	return SK_PASS;
+}
+
+SEC("sk_reuseport")
+int reuse_drop(struct sk_reuseport_md *ctx)
+{
+	reuseport_executed++;
+	sk_cookie_seen = 0;
+	return SK_DROP;
+}
+
+static inline int
+assign_sk(struct __sk_buff *skb)
+{
+	int zero = 0, ret = 0;
+	struct bpf_sock *sk;
+
+	sk = bpf_map_lookup_elem(&sk_map, &zero);
+	if (!sk)
+		return TC_ACT_SHOT;
+	ret = bpf_sk_assign(skb, sk, 0);
+	bpf_sk_release(sk);
+	return ret ? TC_ACT_SHOT : TC_ACT_OK;
+}
+
+static inline bool
+maybe_assign_tcp(struct __sk_buff *skb, struct tcphdr *th)
+{
+	if (th + 1 > (void *)(long)(skb->data_end))
+		return TC_ACT_SHOT;
+
+	if (!th->syn || th->ack || th->dest != bpf_htons(dest_port))
+		return TC_ACT_OK;
+
+	__builtin_memcpy(&headers.tcp, th, sizeof(headers.tcp));
+	return assign_sk(skb);
+}
+
+static inline bool
+maybe_assign_udp(struct __sk_buff *skb, struct udphdr *uh)
+{
+	if (uh + 1 > (void *)(long)(skb->data_end))
+		return TC_ACT_SHOT;
+
+	if (uh->dest != bpf_htons(dest_port))
+		return TC_ACT_OK;
+
+	__builtin_memcpy(&headers.udp, uh, sizeof(headers.udp));
+	return assign_sk(skb);
+}
+
+SEC("tc")
+int tc_main(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct ethhdr *eth;
+
+	eth = (struct ethhdr *)(data);
+	if (eth + 1 > data_end)
+		return TC_ACT_SHOT;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)(data + sizeof(*eth));
+
+		if (iph + 1 > data_end)
+			return TC_ACT_SHOT;
+
+		if (iph->protocol == IPPROTO_TCP)
+			return maybe_assign_tcp(skb, (struct tcphdr *)(iph + 1));
+		else if (iph->protocol == IPPROTO_UDP)
+			return maybe_assign_udp(skb, (struct udphdr *)(iph + 1));
+		else
+			return TC_ACT_SHOT;
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)(data + sizeof(*eth));
+
+		if (ip6h + 1 > data_end)
+			return TC_ACT_SHOT;
+
+		if (ip6h->nexthdr == IPPROTO_TCP)
+			return maybe_assign_tcp(skb, (struct tcphdr *)(ip6h + 1));
+		else if (ip6h->nexthdr == IPPROTO_UDP)
+			return maybe_assign_udp(skb, (struct udphdr *)(ip6h + 1));
+		else
+			return TC_ACT_SHOT;
+	}
+}
-- 
2.40.1

