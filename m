Return-Path: <linux-kselftest+bounces-18179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9C97D8CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E391F24537
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971C18452C;
	Fri, 20 Sep 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z+AoIdr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB4183CC1
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851767; cv=none; b=D8hZVnTX5rsLeW7g240SxLjEElKbzidnE9DVrCCxcTWwtEENm8kBoHCU/nsDuD2ujMEag2aP5zpe8H2nvrZBI8sItRXQEDJSifK3+W94wVSIUIIKlFy/wSJqqqJckk+NT687tUPFzPTg6a/0R11Lbd2DFIUE10EOCs3tmw0+2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851767; c=relaxed/simple;
	bh=v89J2+o71RESAPvqh/orwcJSb1lF7d+zv59I/FZtjJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjiMEz26/vMcfEw60oTl2drWYSv5i8ynJU4LRwxA920NBitjdIfJj6IWq4trU+7361UfANFIP39VLKbQ7XwOHTmB/xRTcowRwG+eK+H9xnZ4V4s6MUMsf06GP0Ws944Cax91DEA8exPWTCaqjePKWBEBLZ0tZXb0l86hEPopAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z+AoIdr1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37a413085cbso846400f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851764; x=1727456564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNu/wIWpR6BVsiVdEMBba4r7mnzMXDYDuRyNKEzyszc=;
        b=Z+AoIdr1qwEeycrglmRDUwKvhyWVfF+LnQ88A3Cb5S85IkDogtQJyRuATZVrBCs0b9
         47lCsYk/KGkk7XlNCPgh8KF9npcr1FpKTEkntNo8V0uVe1KojBKDiF3hBv4LJTHbm06Q
         xifFMr0m8blktMFkS+nmB0HRyVzZvpIRHD1FubHxioSZZWlK0sIJ7QPrX2s/ZOU7VJ3H
         RghAt2Ol40SJSDSTzhRQ4mPx2IZcVH6QyA2UfcfxAjbqt9FaHhtrreehGsqLntJm4aPz
         tBb0j6Ew7RKvhT0EGe0kPixHUEXfdO3NW6YEujTPvez717V6X/TpO5k3SRdtosqMwCi9
         7f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851764; x=1727456564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNu/wIWpR6BVsiVdEMBba4r7mnzMXDYDuRyNKEzyszc=;
        b=k5YEXb+O/N0ViPRlEkotWVobqEC1NTyt6ZWnSxPW5xD2VbzGuH9AYOH72nIl0GOCMg
         sHtmmYSFSbhTi1mYnw6+oIxAP+QTLfov7sy9l8ZP6ER5r3MYn/E6osjExulDM8lUNbHT
         A0PmXa6bSoj8hQJhSPPq/eYAtxNEWos1ir7AfmBcAu9DnT2X1WrNPMen7PnHPvYKUvLG
         LLGzD1l20vWv2jJiS8TLNl1BeX6u41kFT4YfE77FeJtcQMA4SsgbVtnlgdu1aVf/fEOh
         x3rPFrng45SehfBBPZQsnxW5QSUpZjQGq1nOMDftzmfYINDmVZuS64ulQ8tlGnwmxfr7
         TeGA==
X-Forwarded-Encrypted: i=1; AJvYcCWyYIk9l/2Fal3bdWmgOL3P9paRxVI6QbM1xEJXA8Cw0cvw7NMGq2rL3o6lb5P3yd/LC+qeVccUwRJUyZjkh4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBiWUQXDyJ6YoGEaWewHAPngwaBCd1fR+dPoytBQzbyXb+bSt
	BaHiIHXm+CMbu5GhHSpGmMO1TBuUb8tljxuK4ps+bL0zBcAJAgYatA82rS0Qnas=
X-Google-Smtp-Source: AGHT+IHTa8ZT1z85swYNN6qezqB8nH7ihc1ZBRPsp4k3W11KF8Hjwoa+dq/Rn9kcVzVlZQufXuj1wA==
X-Received: by 2002:adf:a31b:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-379a860baa4mr3975349f8f.28.1726851763900;
        Fri, 20 Sep 2024 10:02:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ac2sm54237785e9.24.2024.09.20.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:02:42 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Date: Fri, 20 Sep 2024 18:02:13 +0100
Subject: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
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

This follows the same rationale provided for the ipv4 counterpart, where
the sendmsg() path is also extended here to support the IPV6_ORIGDSTADDR
ancillary message to be able to specify a source address/port. This
allows users to configure the source address and/or port egress traffic
should be sent from.

To limit its usage, a reverse socket lookup is performed to check if the
configured egress source address and/or port have any ingress sk_lookup
match. If it does, traffic is allowed to proceed, otherwise it falls
back to the regular egress path.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
 net/ipv6/datagram.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/udp.c      |  8 ++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..369c64a478ec 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -756,6 +756,29 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
 }
 EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
 
+static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
+				     struct in6_addr *saddr, __be16 sport)
+{
+	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
+	    (saddr && sport) &&
+	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) ||
+	    inet_sk(sk)->inet_sport != sport)) {
+		struct sock *sk_egress;
+
+		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr,
+				     fl6->fl6_dport, saddr, ntohs(sport), 0,
+				     &sk_egress);
+		if (!IS_ERR_OR_NULL(sk_egress) && sk_egress == sk)
+			return true;
+
+		net_info_ratelimited("No reverse socket lookup match for local addr %pI6:%d remote addr %pI6:%d\n",
+				     &saddr, ntohs(sport), &fl6->daddr,
+				     ntohs(fl6->fl6_dport));
+	}
+
+	return false;
+}
+
 int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 			  struct msghdr *msg, struct flowi6 *fl6,
 			  struct ipcm6_cookie *ipc6)
@@ -844,7 +867,63 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 
 			break;
 		    }
+		case IPV6_ORIGDSTADDR:
+			{
+			struct sockaddr_in6 *sockaddr_in;
+			struct net_device *dev = NULL;
+
+			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct sockaddr_in6))) {
+				err = -EINVAL;
+				goto exit_f;
+			}
+
+			sockaddr_in = (struct sockaddr_in6 *)CMSG_DATA(cmsg);
+
+			addr_type = __ipv6_addr_type(&sockaddr_in->sin6_addr);
+
+			if (addr_type & IPV6_ADDR_LINKLOCAL)
+				return -EINVAL;
+
+			/* If we're egressing with a different source address
+			 * and/or port, we perform a reverse socket lookup. The
+			 * rationale behind this is that we can allow return
+			 * UDP traffic that has ingressed through sk_lookup to
+			 * also egress correctly. In case the reverse lookup
+			 * fails, we continue with the normal path.
+			 *
+			 * The lookup is performed if either source address
+			 * and/or port changed, and neither is "0".
+			 */
+			if (reverse_sk_lookup(fl6, sk, &sockaddr_in->sin6_addr,
+					      sockaddr_in->sin6_port)) {
+				/* Override the source port and address to use
+				 * with the one we got in cmsg and bail early.
+				 */
+				fl6->saddr = sockaddr_in->sin6_addr;
+				fl6->fl6_sport = sockaddr_in->sin6_port;
+				break;
+			}
 
+			if (addr_type != IPV6_ADDR_ANY) {
+				int strict = __ipv6_addr_src_scope(addr_type) <= IPV6_ADDR_SCOPE_LINKLOCAL;
+
+				if (!ipv6_can_nonlocal_bind(net, inet_sk(sk)) &&
+				    !ipv6_chk_addr_and_flags(net,
+							     &sockaddr_in->sin6_addr,
+							     dev, !strict, 0,
+							     IFA_F_TENTATIVE) &&
+				    !ipv6_chk_acast_addr_src(net, dev,
+							     &sockaddr_in->sin6_addr))
+					err = -EINVAL;
+				else
+					fl6->saddr = sockaddr_in->sin6_addr;
+			}
+
+			if (err)
+				goto exit_f;
+
+			break;
+			}
 		case IPV6_FLOWINFO:
 			if (cmsg->cmsg_len < CMSG_LEN(4)) {
 				err = -EINVAL;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6602a2e9cdb5..6121cbb71ad3 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1476,6 +1476,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl6->flowi6_uid = sk->sk_uid;
 
+	/* We use fl6's daddr and fl6_sport in the reverse sk_lookup done
+	 * within ip6_datagram_send_ctl() now.
+	 */
+	fl6->daddr = *daddr;
+	fl6->fl6_sport = inet->inet_sport;
+
 	if (msg->msg_controllen) {
 		opt = &opt_space;
 		memset(opt, 0, sizeof(struct ipv6_txoptions));
@@ -1511,10 +1517,8 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl6->flowi6_proto = sk->sk_protocol;
 	fl6->flowi6_mark = ipc6.sockc.mark;
-	fl6->daddr = *daddr;
 	if (ipv6_addr_any(&fl6->saddr) && !ipv6_addr_any(&np->saddr))
 		fl6->saddr = np->saddr;
-	fl6->fl6_sport = inet->inet_sport;
 
 	if (cgroup_bpf_enabled(CGROUP_UDP6_SENDMSG) && !connected) {
 		err = BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk,

-- 
2.34.1


