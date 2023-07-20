Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7575B2AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjGTPb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGTPbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 11:31:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532C272C
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so1485288e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689867054; x=1690471854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9vM5wwa750nRnPWEJb6XAJ919lw+QT8F9GWIwMy1Kw=;
        b=XbKtG0IrHJHpsbf4p0uTeVQb0rwrbxmiIb8bh876jlF/hsXQItKLwAi045rVm/kxMo
         6ZtKHuvClG0OsbGsq9kAiLyhlGpqBNuPrM9pk1OqpKII5cqxeeipDIu0XG2BAOpnfqbP
         a0Xo3kteqeyiUNOWTGHORPNbpvdF3lQNC9lyIr8kazM3/9kRSQa56km4eYfCgoJHseLO
         zeU4xGyfpKErG4/c41BY8YfZMzo32AZRavXhY20BXbBsSFudZTK0F5QQo3ePFaNvc6Yd
         7dDT4RfQLTYs2pzy8EBdHFDS4jFCSvIMb8Muj+QSTHieNwp4e3ls7KJrUFRYTVosfYVA
         VEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867054; x=1690471854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9vM5wwa750nRnPWEJb6XAJ919lw+QT8F9GWIwMy1Kw=;
        b=DF1o/DTqWcZ+Lk/u5MTAz+wRhdEG3iq+rDyrLeWupjyDTjzTqYPTaqNkN4nhiXcXM6
         NLCoTtIFM/4MQmx8qEtka/WwDlZiFQg8ikA4sdf9UWqpReNd93EbumyP7kVG0deuM8dp
         fdkzXJggmuJj/k+k62H96AzD3wmjIJtb64pUBnbQJ/ZxrMWfwbj0dQ1fKpGf8I5xyh9w
         aWIyu4DZUfhw4aIRFd27FIgvl96T/AMYFZ3KbwCKDOu1kmLOJWkWanlHQcUFnRJdZXCP
         SsOTsQezufyB/r8SQrAJrROLLB1NN2KiCP7zV/CB1sMYKbBAH6hRN5Z8f1OxohDHPs9L
         o2/w==
X-Gm-Message-State: ABy/qLayRXybNLKSuoqYS02O4k/jj41xVgZQjudbH2SDg5IWFAbgzRK/
        h4DjFhDgd4uW7MkxYuXlHtJxYw==
X-Google-Smtp-Source: APBJJlE4HlovfIP4NvH5BEUjtVQ8HqIc0ypdCqhndVMnkY0YkTDj9bSGsVbk2zsTtBVjD5xYk1nMEA==
X-Received: by 2002:a19:4f02:0:b0:4fb:73d1:58e5 with SMTP id d2-20020a194f02000000b004fb73d158e5mr1563717lfb.53.1689867053782;
        Thu, 20 Jul 2023 08:30:53 -0700 (PDT)
Received: from [192.168.188.151] (p200300c1c7176000b788d2ebe49c4b82.dip0.t-ipconnect.de. [2003:c1:c717:6000:b788:d2eb:e49c:4b82])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm851007ejw.225.2023.07.20.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:30:53 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 20 Jul 2023 17:30:12 +0200
Subject: [PATCH bpf-next v6 8/8] selftests/bpf: Test that SO_REUSEPORT can
 be used with sk_assign helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-so-reuseport-v6-8-7021b683cdae@isovalent.com>
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>,
        Joe Stringer <joe@cilium.io>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 tools/testing/selftests/bpf/network_helpers.c      |   3 +
 .../selftests/bpf/prog_tests/assign_reuse.c        | 197 +++++++++++++++++++++
 .../selftests/bpf/progs/test_assign_reuse.c        | 142 +++++++++++++++
 3 files changed, 342 insertions(+)

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
index 000000000000..622f123410f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -0,0 +1,197 @@
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
+static int echo_test_udp(int fd_sv)
+{
+	struct sockaddr_storage addr = {};
+	socklen_t len = sizeof(addr);
+	char buff[1] = {};
+	int fd_cl = -1, ret;
+
+	fd_cl = connect_to_fd(fd_sv, 100);
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
+static int echo_test_tcp(int fd_sv)
+{
+	char buff[1] = {};
+	int fd_cl = -1, fd_sv_cl = -1;
+
+	fd_cl = connect_to_fd(fd_sv, 100);
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
+void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		.ifindex = LOOPBACK,
+		.attach_point = BPF_TC_INGRESS,
+	);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, tc_opts,
+		.handle = 1,
+		.priority = 1,
+	);
+	bool hook_created = false, tc_attached = false;
+	int ret, fd_tc, fd_accept, fd_drop, fd_map;
+	int *fd_sv = NULL;
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
+	fd_sv = start_reuseport_server(family, sotype, ip, port, 100, 1);
+	if (!ASSERT_NEQ(fd_sv, NULL, "start_reuseport_server"))
+		goto cleanup;
+
+	ret = attach_reuseport(*fd_sv, fd_drop);
+	if (!ASSERT_OK(ret, "attach_reuseport"))
+		goto cleanup;
+
+	fd_val = *fd_sv;
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
+		ASSERT_EQ(echo_test_tcp(*fd_sv), ECONNREFUSED, "drop_tcp");
+	else
+		ASSERT_EQ(echo_test_udp(*fd_sv), EAGAIN, "drop_udp");
+	ASSERT_EQ(skel->bss->reuseport_executed, 1, "program executed once");
+
+	skel->bss->sk_cookie_seen = 0;
+	skel->bss->reuseport_executed = 0;
+	ASSERT_OK(attach_reuseport(*fd_sv, fd_accept), "attach_reuseport(accept)");
+
+	if (sotype == SOCK_STREAM)
+		ASSERT_EQ(echo_test_tcp(*fd_sv), 0, "echo_tcp");
+	else
+		ASSERT_EQ(echo_test_udp(*fd_sv), 0, "echo_udp");
+
+	ASSERT_EQ(skel->bss->sk_cookie_seen, cookie(*fd_sv),
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
+	free_fds(fd_sv, 1);
+}
+
+void test_assign_reuse(void)
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
+		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT);
+	if (test__start_subtest("tcpv6"))
+		run_assign_reuse(AF_INET6, SOCK_STREAM, "::1", PORT);
+	if (test__start_subtest("udpv4"))
+		run_assign_reuse(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT);
+	if (test__start_subtest("udpv6"))
+		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT);
+
+cleanup:
+	close_netns(tok);
+	SYS_NOFAIL("ip netns delete %s", NS_TEST);
+out:
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_assign_reuse.c b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
new file mode 100644
index 000000000000..4f2e2321ea06
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
+static int
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
+static bool
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
+static bool
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
2.41.0

