Return-Path: <linux-kselftest+bounces-18178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A797D8CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB6C284723
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA2183CA8;
	Fri, 20 Sep 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fRenGfNs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADE18308E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851764; cv=none; b=Abjhxdnup1viEU+jSJIXib5qDrANaCxtKhbrJSQ8Y9PzrN5jtjzAMW71Qb2r1WIRRPMR2JC+Q4nhWFztYX7XgKi/nIKPWCF97dj2nOpx/EgJyZwv24q2rsvrzysC/zPZ4VMxk7he3oVlpCj4K9hZrxdzy5y/AyawcO7WMs9+shU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851764; c=relaxed/simple;
	bh=w9h1CefcJ+okLd5YzJbRs1AedrZAAUwttxXpzVHu1/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixA4zCDD6NzIU058nMpcoYvS4wXuU/H5v8Gb1vBhmSFdBxRzeSFa/FcuTJ00gPbNdg7rmcgtkx90SLbVLxK2AzagwVFUaYBCZSueB4CAbe69cs3oFcKN58UqaWFIiUtK6pxTxvxtPPFuGeoirmCCIjtwweCtCfEXk1CP0D4p3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fRenGfNs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so19240335e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851761; x=1727456561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Is4o6Aqqio8f/YUXF3EAU0YMSo0vWGS25WFnmeETMQM=;
        b=fRenGfNsloIUzTORQUparJGFxbjbjs7D3vTEfgYEyzN9Ry/hsKIwRBd1CzFvxLK94u
         NW/LWJwfKhzDdzS+1O3hebOCVoZlj8Df9jJ+py+IXVDUtw8BSR/FYZD5IKviISy0Ghvx
         1y8ROMCdA9hSvwQjEOnFC0ycAy3Yk9GiAzTk00MUfuuOS7ryAf1vo/v3XJ7eW7cw1Xwl
         cFCY+2xrzvdjWWpUzouhQFkZunWtUcoKguMXv3VYpEfJ1flTbFNmZt/3aV+oIozt5w8U
         RsjoxQCpvAcxRt/NDAI/TAwREQN80uXTV4w9Mt/EMVnKwk8nZOmXVZ4YVD4xrOgRHfUN
         VTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851761; x=1727456561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is4o6Aqqio8f/YUXF3EAU0YMSo0vWGS25WFnmeETMQM=;
        b=PHa8lV9G1G6qVcxU0Tr2+xkp2xO3BgkcKMS5ia7UAYbm0Gx/nAEcUckU4wTrTahh8p
         wNv866jnTdNuSo/x6B/IVEy+WPZfj9qNde4uuM9kSYWOIEQt9+FZaogm2vg9D+IQezwV
         cReRZ3tRGKMjafyaBQU/N0sirFpEKnL0FoKii2EQe5vKYdyzGG5iPwzITmqFFHmWWp6r
         pb3WQTsBTvITagXcghl+FOaErcFlYdv0u/GLtEgoglRaRrnQ6qve716uJGegv/7In4Hc
         sgg6r3kMOlpETfwumnBn+0QbKhHPKCdbPQXdM/Mf52PIrifyAGRjsc7J7r/WHbcBSz+X
         sYcg==
X-Forwarded-Encrypted: i=1; AJvYcCUkPgnjZQDPcBwYRt0tTphWIEVTmdniEwPjGszqWs8IvBJUiACC7hu31u3g9dzlzj/10kp4cYOy+vEvnVBVX2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0s3QTMPI9WV0CU6z+kk4jnWJexF8MHGq0IMA2PRyU9TsMU4sd
	t0eoGYg6R994bB4KqrNgjfkxrT34jeXAwwiG6Z6AW7W+UVHmKYe8ddcIKQxlW3U=
X-Google-Smtp-Source: AGHT+IH5drHWMRoQlh9lyOuuO5OIROadJhuc02Kuodcwh54UgLoyHg6qjS+Fwcgn3oluSIWYw37tQA==
X-Received: by 2002:a05:600c:1c84:b0:428:e866:3933 with SMTP id 5b1f17b1804b1-42e7ad880ddmr29967395e9.22.1726851760820;
        Fri, 20 Sep 2024 10:02:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ac2sm54237785e9.24.2024.09.20.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:02:39 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 20 Sep 2024 18:02:12 +0100
Subject: [RFC PATCH v2 1/3] ipv4: Support setting src port in sendmsg().
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-reverse-sk-lookup-v2-1-916a48c47d56@cloudflare.com>
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
In-Reply-To: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

sendmsg() doesn't currently allow users to set the src port from which
egress traffic should be sent from. This is possible if a user wants to
configure the src address from which egress traffic should be sent from
- with the IP_PKTINFO ancillary message, a user is currently able to
  specify a source address to egress from when calling sendmsg().
However, this still requires the user to set the IP_TRANSPARENT flag
using setsockopt(), which happens to require special privileges in the
case of IPv4.

To support users setting the src port for egress traffic when using
sendmsg(), this patch extends the ancillary messages supported by
sendmsg() to support the IP_ORIGDSTADDR ancillary message, reusing the
same cmsg and struct used in recvmsg() - which already supports
specifying a port.

Additionally, to avoid having to have special configurations, such as
IP_TRANSPARENT, this patch allows egress traffic that's been configured
using (the newly added) IP_ORIGDSTADDR to proceed if there's an ingress
socket lookup (sk_lookup) that matches that traffic - by performing a
reserve sk_lookup. Thus, if the sk_lookup reverse call returns a socket
that matches the egress socket, we also let the egress traffic through -
following the principle of, allowing return traffic to proceed if
ingress traffic is allowed in. In case no match is found in the reverse
sk_lookup, traffic falls back to the regular egress path.

This reverse lookup is only performed in case an sk_lookup ebpf program
is attached and the source address and/or port for the return traffic
have been modified using the (newly added) IP_ORIGDSTADDR in sendmsg.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 include/net/ip.h       |  1 +
 net/ipv4/ip_sockglue.c | 11 +++++++++++
 net/ipv4/udp.c         | 35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..e5753abd7247 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -75,6 +75,7 @@ static inline unsigned int ip_hdrlen(const struct sk_buff *skb)
 struct ipcm_cookie {
 	struct sockcm_cookie	sockc;
 	__be32			addr;
+	__be16			port;
 	int			oif;
 	struct ip_options_rcu	*opt;
 	__u8			protocol;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..6e55bd25b5f7 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -297,6 +297,17 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			ipc->addr = info->ipi_spec_dst.s_addr;
 			break;
 		}
+		case IP_ORIGDSTADDR:
+		{
+			struct sockaddr_in *dst_addr;
+
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct sockaddr_in)))
+				return -EINVAL;
+			dst_addr = (struct sockaddr_in *)CMSG_DATA(cmsg);
+			ipc->port = dst_addr->sin_port;
+			ipc->addr = dst_addr->sin_addr.s_addr;
+			break;
+		}
 		case IP_TTL:
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
 				return -EINVAL;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 49c622e743e8..208cee40c0ec 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1060,6 +1060,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
 	struct flowi4 fl4_stack;
 	struct flowi4 *fl4;
+	__u8 flow_flags = inet_sk_flowi_flags(sk);
 	int ulen = len;
 	struct ipcm_cookie ipc;
 	struct rtable *rt = NULL;
@@ -1179,6 +1180,39 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 	}
 
+	/* If we're egressing with a different source address and/or port, we
+	 * perform a reverse socket lookup.  The rationale behind this is that
+	 * we can allow return UDP traffic that has ingressed through sk_lookup
+	 * to also egress correctly. In case this the reverse lookup fails.
+	 *
+	 * The lookup is performed if either source address and/or port
+	 * changed, and neither is "0".
+	 */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    !connected &&
+	    (ipc.port && ipc.addr) &&
+	    (inet->inet_saddr != ipc.addr || inet->inet_sport != ipc.port)) {
+		struct sock *sk_egress;
+
+		bpf_sk_lookup_run_v4(sock_net(sk), IPPROTO_UDP,
+				     daddr, dport, ipc.addr, ntohs(ipc.port),
+				     1, &sk_egress);
+		if (IS_ERR_OR_NULL(sk_egress) || sk_egress != sk) {
+			net_info_ratelimited("No reverse socket lookup match for local addr %pI4:%d remote addr %pI4:%d\n",
+					     &ipc.addr, ntohs(ipc.port), &daddr,
+					     ntohs(dport));
+		} else {
+			/* Override the source port to use with the one we got
+			 * in cmsg, and tell routing to let us use a non-local
+			 * address. Otherwise route lookups will fail with
+			 * non-local source address when IP_TRANSPARENT isn't
+			 * set.
+			 */
+			inet->inet_sport = ipc.port;
+			flow_flags |= FLOWI_FLAG_ANYSRC;
+		}
+	}
+
 	saddr = ipc.addr;
 	ipc.addr = faddr = daddr;
 
@@ -1223,7 +1257,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (!rt) {
 		struct net *net = sock_net(sk);
-		__u8 flow_flags = inet_sk_flowi_flags(sk);
 
 		fl4 = &fl4_stack;
 

-- 
2.34.1


