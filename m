Return-Path: <linux-kselftest+bounces-12366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4691159F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D009283196
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0815748C;
	Thu, 20 Jun 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AroCWOny"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24E155C86
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921981; cv=none; b=Euw2lBO3sKJHCstxmluYxIjjhOT+BUdVl3SPQIgKBj/kKNttRxCUMIVXiaNLIGGnMnlOiqG657hdQUZi/OphO1eIbiz40zLc2s/dm5irzYIEOBEw2woTXYWPxCjbyOntE5l1MeBf2CMuey/4q6U1o75mIsTICwhrrjkO0aFt57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921981; c=relaxed/simple;
	bh=WuC+c7gIRxQRfWzku/JuPQzydIUAyqXMs6It56sQNMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnaj4fpZxAhJCmHh289lW2YGhjxJ617FzwKdY4259PSObmA/cTcCBJ+rAiXR1fTn97C6ymzHWMCHep7sdHdfpW8jb9ktHoMxbB8L+vr5YvodCpuj1GefNlqtW3T6sLq5aKkqba+btauUUW4+//jMerKROwM2LGeMkdEEllZ0+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AroCWOny; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-444be1a2b01so2999591cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921977; x=1719526777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuArwN7o7WoLSKyeVKHPzr4B3WlUmOtTdlRtE1mmap8=;
        b=AroCWOnyAVjCqE9HJkbK7DrfC3TaBY3hEpcK8HJ6pa1LGzCOYm7N/vo/WdS+EgFpPS
         vZrdY52YYBOwbFU/haZpsDQfOtBP8y99oIgLqQ8jO4M+tYaGeS7rQhsd8pzZRlNBRsh7
         K+7jBeewXmTkQaJbPAvAwHsr1j6g+pr1Ep23np6sRp67oNcw5GJqxaaQqe6ItMphcA57
         5HreJGL5QzhDGT97OA2g7F7GFfPt0vXWi+W2ax98nCfcLJq3a/tlGglM2aJ2N5RFBkCT
         OEcWdYq/DFO6Si0OXFC95PSJDprXK7pmvlirEyStl07BllW6Jw9XC9wrqpUZb5jTylBh
         FP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921977; x=1719526777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuArwN7o7WoLSKyeVKHPzr4B3WlUmOtTdlRtE1mmap8=;
        b=Dj1y0inAu2CWoWSR/xmQVpKQsMNE3N8T2h4x3UiycN1A7HXB3WkB6DKFsOUzW5ugLz
         dx/GJu7KyaYVfys5iOWyijlJnKTL9i4oFasBa3K5rm552BqOcRahggAfaU4rUiOs5+0K
         f2n0OeJ7vGy3kfYGqXkKKCy9fHonYA5j/sFw/NI0AS35D6cuMkUpKhelGaLVaiv1a7VC
         R9nhCQduSwtzGlBBjWr443ePFpsnGp/S+uRhzhiwehDfgnTy9lGdmOvw3wEtbTJmRQXm
         H/jDD0Hw4QNxMvTSd2oVxFBjPjxVfsNmx8XLvUjKuo2pr12sTkdyCc3wiqGNTqtvToUr
         gI6g==
X-Forwarded-Encrypted: i=1; AJvYcCWoCOIN7VhZwivbE2YphLZGSN0UmPivaCyul2IWuuLu0HXi8JSNl/M1JiDYT7NLQN2wlIVIFSm3wO1Z0pu8iD5z5NVSqEHM2Q8Q43N542WF
X-Gm-Message-State: AOJu0Yyy//v1mTCLiM5DL1byovz4ncx09y26aahunct2cEv0x3AmPsgC
	m97wX+sHMQo3WGAG/kf3pzgVGjzco8XMo+CIyDDOhcZ/5UdcDHl6xw2sUqg1fmw=
X-Google-Smtp-Source: AGHT+IE90gJSTf/sLdYoKoD9DTjeGf3DuiiwFPO4yuige78jRidVqNJPFiNlxGOmBXNcyVc3qM70vw==
X-Received: by 2002:ac8:5a4c:0:b0:440:279c:fa0a with SMTP id d75a77b69052e-444a7a5537bmr78675951cf.53.1718921977535;
        Thu, 20 Jun 2024 15:19:37 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b95594sm1965991cf.48.2024.06.20.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:34 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC net-next 9/9] bpf: selftests: test disabling GRO by XDP
Message-ID: <04f25110b5f4c240b56dd9d449b6496096c74ab5.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Test the case when XDP disables GRO for a packet, the effect is actually
reflected on the receiving side.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/xdp_offloading.c | 122 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_offloading.c      |  50 +++++++
 3 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_offloading.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_offloading.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2fb16da78dce..e789392f44bd 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -96,3 +96,4 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_SKB_GRO_CONTROL=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_offloading.c b/tools/testing/selftests/bpf/prog_tests/xdp_offloading.c
new file mode 100644
index 000000000000..462296d9689a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_offloading.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_offloading.skel.h"
+
+/* run tcp server in ns1, client in ns2, and transmit 10MB data */
+static void run_tcp_test(const char *server_ip)
+{
+	struct nstoken *ns1 = NULL, *ns2 = NULL;
+	struct sockaddr_storage server_addr;
+	int total_bytes = 10 * 1024 * 1024;
+	int server_fd = -1, client_fd = -1;
+	int server_port = 5555;
+
+	socklen_t addrlen = sizeof(server_addr);
+
+	if (!ASSERT_OK(make_sockaddr(AF_INET, server_ip, server_port,
+				     &server_addr, &addrlen), "make_addr"))
+		goto err;
+
+	ns1 = open_netns("ns1");
+	if (!ASSERT_OK_PTR(ns1, "setns ns1"))
+		goto err;
+
+	server_fd = start_server_str(AF_INET, SOCK_STREAM, "0.0.0.0",
+				     server_port, NULL);
+	if (!ASSERT_NEQ(server_fd, -1, "start_server_str"))
+		goto err;
+
+	ns2 = open_netns("ns2");
+	if (!ASSERT_OK_PTR(ns2, "setns ns2"))
+		goto err;
+
+	client_fd = connect_to_addr(SOCK_STREAM, &server_addr, addrlen, NULL);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_addr"))
+		goto err;
+
+	/* send 10MB data */
+	if (!ASSERT_OK(send_recv_data(server_fd, client_fd, total_bytes),
+		       "send_recv_data"))
+		goto err;
+
+err:
+	if (server_fd != -1)
+		close(server_fd);
+	if (client_fd != -1)
+		close(client_fd);
+	if (ns1)
+		close_netns(ns1);
+	if (ns2)
+		close_netns(ns2);
+}
+
+/* This test involves two netns:
+ *     NS1              |           NS2
+ *                      |
+ *        ---->  veth1 --> veth_offloading(xdp)-->(tp:netif_receive_skb)
+ *        |             |                              |
+ *        |             |                              v
+ *    tcp-server        |                         tcp-client
+ *
+ *   a TCP server in NS1 sends data through veth1, and the XDP program on
+ *   "xdp_offloading" is what we test against. This XDP program will apply
+ *   offloadings and we examine these at netif_receive_skb tracepoint if the
+ *   offloadings are propagated to skbs.
+ */
+void test_xdp_offloading(void)
+{
+	const char *xdp_ifname = "veth_offloading";
+	struct nstoken *nstoken = NULL;
+	struct xdp_offloading *skel = NULL;
+	struct bpf_link *link_xdp, *link_tp;
+	const char *server_ip = "192.168.0.2";
+	const char *client_ip = "192.168.0.3";
+	int ifindex;
+
+	SYS(out, "ip netns add ns1");
+	SYS(out, "ip netns add ns2");
+	SYS(out, "ip -n ns1 link add veth1 type veth peer name %s netns ns2",
+	    xdp_ifname);
+	SYS(out, "ip -n ns1 link set veth1 up");
+	SYS(out, "ip -n ns2 link set veth_offloading up");
+	SYS(out, "ip -n ns1 addr add dev veth1 %s/31", server_ip);
+	SYS(out, "ip -n ns2 addr add dev %s %s/31", xdp_ifname, client_ip);
+
+	SYS(out, "ip netns exec ns2 ethtool -K %s gro on", xdp_ifname);
+
+	nstoken = open_netns("ns2");
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto out;
+
+	skel = xdp_offloading__open();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	ifindex = if_nametoindex(xdp_ifname);
+	if (!ASSERT_NEQ(ifindex, 0, "ifindex"))
+		goto out;
+
+	memcpy(skel->rodata->target_ifname, xdp_ifname, IFNAMSIZ);
+
+	if (!ASSERT_OK(xdp_offloading__load(skel), "load"))
+		goto out;
+
+	link_xdp = bpf_program__attach_xdp(skel->progs.xdp_disable_gro, ifindex);
+	if (!ASSERT_OK_PTR(link_xdp, "xdp_attach"))
+		goto out;
+
+	link_tp = bpf_program__attach(skel->progs.observe_skb_gro_disabled);
+	if (!ASSERT_OK_PTR(link_tp, "xdp_attach"))
+		goto out;
+
+	run_tcp_test(server_ip);
+
+	ASSERT_NEQ(__sync_fetch_and_add(&skel->bss->invalid_skb, 0), 0,
+		   "check invalid skbs");
+out:
+	if (nstoken)
+		close_netns(nstoken);
+	SYS_NOFAIL("ip netns del ns1");
+	SYS_NOFAIL("ip netns del ns2");
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_offloading.c b/tools/testing/selftests/bpf/progs/xdp_offloading.c
new file mode 100644
index 000000000000..5fd88d75b008
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_offloading.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#define IFNAMSIZ 16
+
+/* using a special ifname to filter unrelated traffic */
+const __u8 target_ifname[IFNAMSIZ];
+
+/* test outputs: these counters should be 0 to pass tests */
+int64_t invalid_skb = 0;
+
+extern int bpf_xdp_disable_gro(struct xdp_md *xdp) __ksym;
+
+/*
+ * Observing: after XDP disables GRO, gro_disabled bit should be set
+ * and gso_size should be 0.
+ */
+SEC("tp_btf/netif_receive_skb")
+int BPF_PROG(observe_skb_gro_disabled, struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo =
+		(struct skb_shared_info *)(skb->head + skb->end);
+	char devname[IFNAMSIZ];
+	int gso_size;
+
+	__builtin_memcpy(devname, skb->dev->name, IFNAMSIZ);
+	if (bpf_strncmp(devname, IFNAMSIZ, (const char *)target_ifname))
+		return 0;
+
+	if (!skb->gro_disabled)
+		__sync_fetch_and_add(&invalid_skb, 1);
+
+	gso_size = BPF_CORE_READ(shinfo, gso_size);
+	if (gso_size)
+		__sync_fetch_and_add(&invalid_skb, 1);
+
+	return 0;
+}
+
+SEC("xdp")
+int xdp_disable_gro(struct xdp_md *xdp)
+{
+	bpf_xdp_disable_gro(xdp);
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2



