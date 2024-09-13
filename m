Return-Path: <linux-kselftest+bounces-17923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC2977C60
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AC21C21BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE51D88C4;
	Fri, 13 Sep 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Nlvw6BYZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F401D6DCD
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220369; cv=none; b=QonxNNXBRg5CmlTd6n6C6U9o2yu6G74UZC9U8yl9taiOG5YQ7QOT+lG7RUd923x5lxix2Z3v0GlRCeEk7xVatkTgHNcgyIBcgLSxXo1XImjaUww9gzwXOxzsikCX3LV9CJFvMUmDDLPqORJHhyjZpK/j/9HhjDxSi4BL1txg3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220369; c=relaxed/simple;
	bh=Tw4uEMSI5Dr5SJ/9tx+GPhyTrfSGhN6/WFouKDUT30Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTn+m/PX9JIID4c8EHrAQ4wAVrCba+CyLpMQV7FCn5w/xUkEBz4vM9Ywxs9kOqcnk7Uh3baMteeq7iPENKvsaZoUG+/Dp86s5+NmXi/h0+AgDQgs7OG8j0EpHyyC6cFOeDfMayUQ+tOLtxF8OZUW5TLI1BeE/EvflhCn5v5m9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Nlvw6BYZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso18612175e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726220365; x=1726825165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/F5VsUKzBY+Gvp0nTts52JPym3MtK6dVK27Lo+tSTM=;
        b=Nlvw6BYZ76+Y74dwpyYMfEt793vm8RH9JUskZ/y3SLWDL2ffYuTq0Kdto4x1Hm+oAo
         nNT3WMGg+nqEC1uVEqORAv9T6Tc3T6KI4Fsrh91vb+uBiZFogAgr+I+e3h6UIcZFVXfs
         uqm5XKWevnyBcafDgvxgrW0lVbMED9g2LVfrXtGNl6g4eI48G5nxv8/SsXlZCBHQG6UJ
         YbM+iqovUVTTjHy9c1SIZJB4aEiyrOmVYFlluDB8/igdjUB4df4HbnQx/dfXQA44BGKE
         9QC0iF9to+jQp0hG8SPx/xFEdV9z8al62X8Zj2GKfXRPBC2NEUII9DbxfsTnABorKEl0
         iRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220365; x=1726825165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/F5VsUKzBY+Gvp0nTts52JPym3MtK6dVK27Lo+tSTM=;
        b=nTRQlT8CH6QmIupeQBKQOTxxJIDLhO1HRGp+Y6wo+WMQmFa6BgbGXHi49eBYJ9k2v2
         fuulvkBI2EerpsLyq1AOHLmW3EOCRGFA0E8opzeKGMw4+7C3fD5bNY6S8d/jMDdqCZ2X
         3WzCQSNUA/P3j7J5qt2n9NuTlkPesrOv0410liBYu1nORTZfptM4d7zXQP6PIsYF3dtu
         3Pp1XZQy0682Qm1A5csI1jvhbrzNC4OH39VGSYOZV6qtGLcfgP0YjBFfGD7INenyRM68
         8lQ2EFxqQqH1wjqIktDkOkuamxjdfxrxuUIrm69FfPbx+4F+gJ2IwuXLKPGkIX6gBXnW
         B53w==
X-Forwarded-Encrypted: i=1; AJvYcCVivk48iiD2LwBlMUYReedZAPrqshPLUur7cauDroFdjj0vu0FGwLfZzTAqxE5yiMytry4jL0hycejdZFduBcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8ERQ5pswN5dkpjvAgLfTlDqJIGSDbnxtlV9n1polNxf+M9JG
	MBlpjd6IOT44ImVqi3bXi94MH0cQo15nQad9PQdT2UxsV0sYJbQV0SovaPSYgLE=
X-Google-Smtp-Source: AGHT+IFCLnGFac4d/lytgKhxj1y4y6Vc0xqjrzbKxpeoAAZXwZWlNKOpOSOEZ8fmlHYwc00Ryjx6Ug==
X-Received: by 2002:a05:600c:3505:b0:42c:a8d5:2df5 with SMTP id 5b1f17b1804b1-42cdb586ee0mr45446675e9.24.1726220364867;
        Fri, 13 Sep 2024 02:39:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3802:d2::15:37a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665548sm16474484f8f.34.2024.09.13.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:39:24 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 13 Sep 2024 10:39:19 +0100
Subject: [RFC PATCH 1/3] ipv4: Run a reverse sk_lookup on sendmsg.
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reverse-sk-lookup-v1-1-e721ea003d4c@cloudflare.com>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
In-Reply-To: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
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

In order to check if egress traffic should be allowed through, we run a
reverse socket lookup (i.e. normal socket lookup with the src/dst
addresses and ports reversed) to check if the corresponding ingress
traffic is allowed in.  Thus, if there's a sk_lookup reverse call
returns a socket that matches the egress socket, we also let the egress
traffic through - following the principle of, allowing return traffic to
proceed if ingress traffic is allowed in.  The reverse lookup is only
performed in case an sk_lookup ebpf program is attached and the source
address and/or port for the return traffic have been modified.

The src address and port can be modified by using ancilliary messages.
Up until now, it was possible to specify a different source address to
sendmsg by providing it in an IP_PKTINFO anciliarry message, but there's
no way to change the source port. This patch also extends the ancilliary
messages supported by sendmsg to support the IP_ORIGDSTADDR ancilliary
message, reusing the same cmsg and struct used in recvmsg - which
already supports specifying a port.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 include/net/ip.h       |  1 +
 net/ipv4/ip_sockglue.c | 11 +++++++++++
 net/ipv4/udp.c         | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

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
index 49c622e743e8..b9dc0a88b0c6 100644
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
@@ -1179,6 +1180,37 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 	}
 
+	/* If we're egressing with a different source address and/or port, we
+	 * perform a reverse socket lookup.  The rationale behind this is that we
+	 * can allow return UDP traffic that has ingressed through sk_lookup to
+	 * also egress correctly. In case this the reverse lookup fails.
+	 *
+	 * The lookup is performed if either source address and/or port changed, and
+	 * neither is "0".
+	 */
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    !connected &&
+	    (ipc.port && ipc.addr) &&
+	    (inet->inet_saddr != ipc.addr || inet->inet_sport != ipc.port)) {
+		struct sock *sk_egress;
+
+		bpf_sk_lookup_run_v4(sock_net(sk), IPPROTO_UDP,
+				     daddr, dport, ipc.addr, ntohs(ipc.port), 1, &sk_egress);
+		if (IS_ERR_OR_NULL(sk_egress) ||
+		    atomic64_read(&sk_egress->sk_cookie) != atomic64_read(&sk->sk_cookie)) {
+			net_info_ratelimited("No reverse socket lookup match for local addr %pI4:%d remote addr %pI4:%d\n",
+					     &ipc.addr, ntohs(ipc.port), &daddr, ntohs(dport));
+		} else {
+			/* Override the source port to use with the one we got in cmsg,
+			 * and tell routing to let us use a non-local address. Otherwise
+			 * route lookups will fail with non-local source address when
+			 * IP_TRANSPARENT isn't set.
+			 */
+			inet->inet_sport = ipc.port;
+			flow_flags |= FLOWI_FLAG_ANYSRC;
+		}
+	}
+
 	saddr = ipc.addr;
 	ipc.addr = faddr = daddr;
 
@@ -1223,7 +1255,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (!rt) {
 		struct net *net = sock_net(sk);
-		__u8 flow_flags = inet_sk_flowi_flags(sk);
 
 		fl4 = &fl4_stack;
 

-- 
2.34.1


