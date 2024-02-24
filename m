Return-Path: <linux-kselftest+bounces-5405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502086239C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DEE1F23B26
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDC128684;
	Sat, 24 Feb 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D3J89XkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FAF22F19
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765492; cv=none; b=UemT2KSPvc5fGTiTmv5k008Fmso9KB5Tzl27Jf1nYFrHaTwy+UaM9fb6ELgdJSNjWRAraTurk4HymYL27np7/LGCTEj4xcQQ/WC2jNxWygr6GByi6vs9ADabCokeXH5lojw12vnwK1SVZhT/lpe2sFwLtFa0KgNrOs+l+G9CJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765492; c=relaxed/simple;
	bh=c9aqMhav4KaCgJElWHCUEBVRnJ5cadEhjI/bL0vm03I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T11qg1BwSSpE+sD7FAvzROnJL7kq1NND5c5w4D2wUhE+M35nHharuMB6BgzGcZ5UfcSa4mYiRU5Bz2/V6EhhSu1gqUKUm/27yoEN9T72ZnK5TWsa+VLVcd0A9tn10PGTmKWOWK+t41QBWBfuSrkbUAMONm7z7oNTulsOv4LzNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=D3J89XkI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412985ba594so4985505e9.3
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765489; x=1709370289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/kjGHctWC0Cj09lJisIMBFHNypYEYqrv5pxutZK96A=;
        b=D3J89XkI/UXWg0eXD6YVVehTuVO8qUhosE21oCx3YLyEHTCChGFMnbFOYylKBud0Uk
         E9cBNMbc4qH6iA7LaqE8SHmh4GicLRWpAcd859uBADUoXRH81fZOTINIHzpBvw2C5Cde
         q573aGmzXDF+ShQbTwsxRt43TItEQFdZXwU8uueSWF42t+KQK6JYBop/3JI2RCA6lu31
         3J2ozyRwgJb5dQmbJfuufSSV47jVHgNMJFz5qhNcAJGKN8sRARaLl2hFjuU1O1iF/8Ne
         gqpAqRxXdIoXmTd81NG3a6jcw4WhCG4uZjwPTVyobgohiB/rN+/v05QazVeNsJ/2p5gZ
         6k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765489; x=1709370289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/kjGHctWC0Cj09lJisIMBFHNypYEYqrv5pxutZK96A=;
        b=MXfrUzPl0CiKQqxFZaBwRarujZsRvDj3ZZkJMDoqZX5Rjx8tyXms3XqDsuE8a658lW
         bxYjQHT6Uv18DfRvp+6TTj1k/HtWvTZFOM2V+oJLzHUX+AlHHgRT9TizkaGwZ+btrtsb
         JLz4wo7fsh8Ha46NPSd9oCJr06flRZUt9exc4I48PAG+Pfm295Qjgphx672aphLvI86C
         /IK4SsDzoOrbkPCeC8dcTP5Uyy/mwkhUEbtq/DBGYGY0ZF5kAyv9vCqoKEXGPSY9nH29
         HZTIY2xrtsfVRtHeX5s720bA+HWeZXf6jVtV2THYgJnReXVSMpZOL/9nGZR27hEghKeb
         l2pw==
X-Forwarded-Encrypted: i=1; AJvYcCXgd3ZpdZ0LgQz50l9ZQvUzsl+FW1haOOCbDGQ2cMeIwPhNR7/6hATUxQ7NTld+rkgSEisnHOrJlk6E8+xCSp114GmfkY6pxlXhjefqOOzg
X-Gm-Message-State: AOJu0Yybgi7ekLds3R5kq6x1ibg0M33/Z0aT/zsf3P7PP0vQinUU2IVP
	dxiU2OrGy1JcC4WFG6ys1UftHk4b/0Ol3MNTppEHj8rY3ro77B6XFOkRBKuGpQ==
X-Google-Smtp-Source: AGHT+IHC9EDd0aNctjl1KomHFBi0eOUcuyEsCPJ9GK6ABQgNCDbG9AfofEWrqzq9pkarx60vbRB0RA==
X-Received: by 2002:a05:600c:5114:b0:412:90ad:2cd4 with SMTP id o20-20020a05600c511400b0041290ad2cd4mr1463620wms.36.1708765488783;
        Sat, 24 Feb 2024 01:04:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:47 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 04/10] net/tcp: Add tcp-md5 and tcp-ao tracepoints
Date: Sat, 24 Feb 2024 09:04:12 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-4-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=17170; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=c9aqMhav4KaCgJElWHCUEBVRnJ5cadEhjI/bL0vm03I=; b=flCvV/0RM9XwbyalViJHwSnrsXbQcR35PrcyN+gmMXZtMsvul2h+9kEElnUdAVxYOAO4EP7fA +3El6tFZlWAAY3TkobZstPQEiWqPc+NSn2uwMMAQ8PjvtW7XDO2hT4V
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Instead of forcing userspace to parse dmesg (that's what currently is
happening, at least in codebase of my current company), provide a better
way, that can be enabled/disabled in runtime.

Currently, there are already tcp events, add hashing related ones there,
too. Rasdaemon currently exercises net_dev_xmit_timeout,
devlink_health_report, but it'll be trivial to teach it to deal with
failed hashes. Otherwise, BGP may trace/log them itself. Especially
exciting for possible investigations is key rotation (RNext_key
requests).

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/trace/events/tcp.h | 317 +++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c             |   7 +
 net/ipv4/tcp_ao.c          |  13 ++
 net/ipv4/tcp_input.c       |   8 +-
 net/ipv4/tcp_output.c      |   2 +
 5 files changed, 345 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..5065000aad93 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -419,6 +419,323 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+DECLARE_EVENT_CLASS(tcp_hash_event,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+
+	TP_ARGS(sk, skb),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(int, l3index)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(bool, fin)
+		__field(bool, syn)
+		__field(bool, rst)
+		__field(bool, psh)
+		__field(bool, ack)
+	),
+
+	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		__entry->l3index = inet_sdif(skb) ? inet_iif(skb) : 0;
+
+		/* For filtering use */
+		__entry->sport = ntohs(th->source);
+		__entry->dport = ntohs(th->dest);
+		__entry->family = sk->sk_family;
+
+		__entry->fin = th->fin;
+		__entry->syn = th->syn;
+		__entry->rst = th->rst;
+		__entry->psh = th->psh;
+		__entry->ack = th->ack;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc L3index=%d [%c%c%c%c%c]",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->l3index,
+		  __entry->fin ? 'F' : ' ',
+		  __entry->syn ? 'S' : ' ',
+		  __entry->rst ? 'R' : ' ',
+		  __entry->psh ? 'P' : ' ',
+		  __entry->ack ? '.' : ' ')
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_bad_header,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_required,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_unexpected,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_md5_mismatch,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DEFINE_EVENT(tcp_hash_event, tcp_hash_ao_required,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_ARGS(sk, skb)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+
+	TP_ARGS(sk, skb, keyid, rnext, maclen),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+		__field(int, l3index)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(bool, fin)
+		__field(bool, syn)
+		__field(bool, rst)
+		__field(bool, psh)
+		__field(bool, ack)
+
+		__field(__u8, keyid)
+		__field(__u8, rnext)
+		__field(__u8, maclen)
+	),
+
+	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		__entry->l3index = inet_sdif(skb) ? inet_iif(skb) : 0;
+
+		/* For filtering use */
+		__entry->sport = ntohs(th->source);
+		__entry->dport = ntohs(th->dest);
+		__entry->family = sk->sk_family;
+
+		__entry->fin = th->fin;
+		__entry->syn = th->syn;
+		__entry->rst = th->rst;
+		__entry->psh = th->psh;
+		__entry->ack = th->ack;
+
+		__entry->keyid = keyid;
+		__entry->rnext = rnext;
+		__entry->maclen = maclen;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc L3index=%d [%c%c%c%c%c] keyid=%u rnext=%u maclen=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->l3index,
+		  __entry->fin ? 'F' : ' ',
+		  __entry->syn ? 'S' : ' ',
+		  __entry->rst ? 'R' : ' ',
+		  __entry->psh ? 'P' : ' ',
+		  __entry->ack ? '.' : ' ',
+		  __entry->keyid, __entry->rnext, __entry->maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_handshake_failure,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_wrong_maclen,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_mismatch,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_key_not_found,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DEFINE_EVENT(tcp_ao_event, tcp_ao_rnext_request,
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
+	TP_ARGS(sk, skb, keyid, rnext, maclen)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event_sk,
+
+	TP_PROTO(const struct sock *sk, const __u8 keyid, const __u8 rnext),
+
+	TP_ARGS(sk, keyid, rnext),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(__u8, keyid)
+		__field(__u8, rnext)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		/* For filtering use */
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		__entry->keyid = keyid;
+		__entry->rnext = rnext;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc keyid=%u rnext=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->keyid, __entry->rnext)
+);
+
+DEFINE_EVENT(tcp_ao_event_sk, tcp_ao_synack_no_key,
+	TP_PROTO(const struct sock *sk, const __u8 keyid, const __u8 rnext),
+	TP_ARGS(sk, keyid, rnext)
+);
+
+DECLARE_EVENT_CLASS(tcp_ao_event_sne,
+
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+
+	TP_ARGS(sk, new_sne),
+
+	TP_STRUCT__entry(
+		__field(__u64, net_cookie)
+		__field(const void *, skaddr)
+		__field(int, state)
+
+		/* sockaddr_in6 is always bigger than sockaddr_in */
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+
+		__field(__u32, new_sne)
+	),
+
+	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+
+		__entry->net_cookie = sock_net(sk)->net_cookie;
+		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+		TP_STORE_ADDR_PORTS(__entry, inet, sk);
+
+		/* For filtering use */
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		__entry->new_sne = new_sne;
+	),
+
+	TP_printk("net=%llu state=%s family=%s src=%pISpc dest=%pISpc sne=%u",
+		  __entry->net_cookie,
+		  show_tcp_state_name(__entry->state),
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr,
+		  __entry->new_sne)
+);
+
+DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_snd_sne_update,
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+	TP_ARGS(sk, new_sne)
+);
+
+DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_rcv_sne_update,
+	TP_PROTO(const struct sock *sk, __u32 new_sne),
+	TP_ARGS(sk, new_sne)
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fd61ae6bcc9..81f22d6afe4a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -279,6 +279,7 @@
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
 #include <net/busy_poll.h>
+#include <trace/events/tcp.h>
 
 /* Track pending CMSGs. */
 enum {
@@ -4448,6 +4449,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
 		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
+		trace_tcp_hash_md5_unexpected(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
 
@@ -4477,6 +4479,7 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 					      l3index);
 			}
 		}
+		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
 	return SKB_NOT_DROPPED_YET;
@@ -4501,6 +4504,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
 		tcp_hash_fail("TCP segment has incorrect auth options set",
 			      family, skb, "");
+		trace_tcp_hash_bad_header(sk, skb);
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 	}
 
@@ -4520,6 +4524,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
 				      family, skb, "%s",
 				      !aoh ? "missing AO" : "AO signed");
+			trace_tcp_ao_handshake_failure(sk, skb, keyid, rnext, maclen);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
 	}
@@ -4539,12 +4544,14 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
 			tcp_hash_fail("AO hash is required, but not found",
 					family, skb, "L3 index %d", l3index);
+			trace_tcp_hash_ao_required(sk, skb);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
 			tcp_hash_fail("MD5 Hash not found",
 				      family, skb, "L3 index %d", l3index);
+			trace_tcp_hash_md5_required(sk, skb);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
 		return SKB_NOT_DROPPED_YET;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 8726aa58e8b6..416cdeaccd07 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/ipv6.h>
 #include <net/icmp.h>
+#include <trace/events/tcp.h>
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
 
@@ -895,6 +896,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		tcp_hash_fail("AO hash wrong length", family, skb,
 			      "%u != %d L3index: %d", maclen,
 			      tcp_ao_maclen(key), l3index);
+		trace_tcp_ao_wrong_maclen(sk, skb, aoh->keyid,
+					  aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 
@@ -911,6 +914,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		atomic64_inc(&key->pkt_bad);
 		tcp_hash_fail("AO hash mismatch", family, skb,
 			      "L3index: %d", l3index);
+		trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
+				      aoh->rnext_keyid, maclen);
 		kfree(hash_buf);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
@@ -927,6 +932,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		    int l3index, const struct tcp_ao_hdr *aoh)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
+	u8 maclen = tcp_ao_hdr_maclen(aoh);
 	u8 *phash = (u8 *)(aoh + 1); /* hash goes just after the header */
 	struct tcp_ao_info *info;
 	enum skb_drop_reason ret;
@@ -940,6 +946,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 		tcp_hash_fail("AO key not found", family, skb,
 			      "keyid: %u L3index: %d", aoh->keyid, l3index);
+		trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
+					   aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
 	}
 
@@ -979,6 +987,9 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		current_key = READ_ONCE(info->current_key);
 		/* Key rotation: the peer asks us to use new key (RNext) */
 		if (unlikely(aoh->rnext_keyid != current_key->sndid)) {
+			trace_tcp_ao_rnext_request(sk, skb, current_key->sndid,
+						   aoh->rnext_keyid,
+						   tcp_ao_hdr_maclen(aoh));
 			/* If the key is not found we do nothing. */
 			key = tcp_ao_established_key(info, aoh->rnext_keyid, -1);
 			if (key)
@@ -1043,6 +1054,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	atomic64_inc(&info->counters.key_not_found);
 	tcp_hash_fail("Requested by the peer AO key id not found",
 		      family, skb, "L3index: %d", l3index);
+	trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
+				   aoh->rnext_keyid, maclen);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 74c03f0a6c0c..11f4da3aa827 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3575,8 +3575,10 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && ack < tp->snd_una)
+	if (ao && ack < tp->snd_una) {
 		ao->snd_sne++;
+		trace_tcp_ao_snd_sne_update((struct sock *)tp, ao->snd_sne);
+	}
 #endif
 }
 
@@ -3601,8 +3603,10 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
+	if (ao && seq < tp->rcv_nxt) {
 		ao->rcv_sne++;
+		trace_tcp_ao_rcv_sne_update((struct sock *)tp, ao->rcv_sne);
+	}
 #endif
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..dcdaf3229de9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3727,6 +3727,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 #ifdef CONFIG_TCP_AO
 		struct tcp_ao_key *ao_key = NULL;
 		u8 keyid = tcp_rsk(req)->ao_keyid;
+		u8 rnext = tcp_rsk(req)->ao_rcv_next;
 
 		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
 							    keyid, -1);
@@ -3736,6 +3737,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
 		 */
 		if (unlikely(!ao_key)) {
+			trace_tcp_ao_synack_no_key(sk, keyid, rnext);
 			rcu_read_unlock();
 			kfree_skb(skb);
 			net_warn_ratelimited("TCP-AO: the keyid %u from SYN packet is not present - not sending SYNACK\n",

-- 
2.43.0


