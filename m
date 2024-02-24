Return-Path: <linux-kselftest+bounces-5406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1228623A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A182821BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610038F8F;
	Sat, 24 Feb 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kecxXJsk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480725761
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765495; cv=none; b=l693oidVZf7lmZoxY/87hrXBipLI9wsIax3LWMohm2UtJzsYOqfFOYTuLrP2u/WRfkmg8kF1flQbpjeSqsbWKxtLPZDLoYb29QiDP2nZ6cSsrRpzwDbmOc8odJdUSBxSN31qkA5H6kw8lvFlQ9YV+UgdvxeIKoC9CgeABYq0upE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765495; c=relaxed/simple;
	bh=102HRfrUAQjjWH58WHrrD12WSyo7oflbFvQouUtSetI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ek7i9ByiHeS/b61uKaR1Vtv9+uX0RJbwx0Hd8fGoCBMuuhSk7NWKWcdqlsAJJeVGM1GxQ4FzjJSWTjcWvOwxViweBkyqrQSE7AIA4SouyO3djXWrbfGH0kz7fVeb8tnYYBVjwy1KPIZSZb0UWwVxS5UpvlD46M34btH65Sk/oXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kecxXJsk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d26227d508so13922401fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765491; x=1709370291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WCWN7oYoEuG7HunFuhQOorajxoQi/eLk6qQ00vzKmA=;
        b=kecxXJskS/VPkcy2d6pLkwy1enjie9s6ZsZCz/Eho52RjQ0R2jXMzFF9veb/QJ1fEW
         PDByytLsa+TSxFiV6r6+j/Fy8Xy8qkKKAixiElXU3mVFPQ+XC2S9iYm7FZVXEoMacGnq
         a0u8tcnK7E26RYEjV04CIp+wkIwugPbptA++fRRVy1Ay2iftrJoQlWwRGndWL7AUe38t
         juGI0B0dxLHOP1sE6Kqmic64r//4C+ZjjW4fvxPsVnOJQndHj7UvyKML+rnCixb4fgvX
         2TPv3pLGGO+lJEcRgXVhI7BliN0I0zQ7qpkBWyDJa1XkzLGjEdrWdWbGryw26xcqDwn4
         e6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765491; x=1709370291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WCWN7oYoEuG7HunFuhQOorajxoQi/eLk6qQ00vzKmA=;
        b=flOhcXaPEQ1tvpROKZUOeRUIBRgn9g9uO1ezCbGg+vGyNDWD9Y6reQZFahtza94JX/
         ERGwah5YzgUUTv4E2jCzTbnCgMtgFZfejTrtlGlGvegR9pF4pla48Cumt/jcUDYf8+ru
         8DkVa6U6aY4mrD0Q+ILXlRQzTOSGyeR4WuZBL424+CW0XZkh4dMWi6tbBdfc/5sqYk5b
         OX/Ch/7L22f8dnLh0bh0sBF3WROl57ckxfILnsNextqL3Lcg29cjmm46H6C5iHs5XENm
         dUy2EwMrsH0EZPx2PH9TWpP2VkCPIRSZosI08rRWIun2JgtOor4klnc5vtoVH8VdDgtt
         RHsg==
X-Forwarded-Encrypted: i=1; AJvYcCUK7qz16WEUz1oGfCEhIAv+rrNh1wNq1pFyykezB6hnAjupa3+yCO/WfTjrNCOmtqY6ENoE8+kNc1q6tltfvwUL1yvz9BMwCQdvmuvyfqwb
X-Gm-Message-State: AOJu0YxdTRf354KNqY/wmRtlM7grCF3KxlG6m7KwKOiGyHrzgUWUYEzy
	oQQl7yfT2w4uMMyfP5GwSTXnl/x4K3PyTVeUuyzDWYskzt2Pn0D0WL3GXEdgaQ==
X-Google-Smtp-Source: AGHT+IGItgi/S4aXwX6jxP3G6/HGuR+v4MqB1yQa+1g5JY9Fgv3f2PE1a1lH+3q5kBYjs21MPuEybA==
X-Received: by 2002:a2e:8410:0:b0:2d1:1de5:3c42 with SMTP id z16-20020a2e8410000000b002d11de53c42mr751193ljg.24.1708765490647;
        Sat, 24 Feb 2024 01:04:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:49 -0800 (PST)
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
Subject: [PATCH net-next 05/10] net/tcp: Remove tcp_hash_fail()
Date: Sat, 24 Feb 2024 09:04:13 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-5-15f31b7f30a7@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=6825; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=102HRfrUAQjjWH58WHrrD12WSyo7oflbFvQouUtSetI=; b=KuzFXrwGm/QiXWsQtc0Vn6P92cAYtnXKfXYserYzReUDAUFuXH+EUeP0KbUmC6fAtLJAdtW0c jt0POjVpiFoDOqY9QA2u49RZDcJ/hc0Ifew/MAFXfSaqbi/CS7HiMtj
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Now there are tracepoints, that cover all functionality of
tcp_hash_fail(), but also wire up missing places
They are also faster, can be disabled and provide filtering.

This potentially may create a regression if a userspace depends on dmesg
logs. Fingers crossed, let's see if anyone complains in reality.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h | 37 -------------------------------------
 net/ipv4/tcp.c       | 25 -------------------------
 net/ipv4/tcp_ao.c    |  9 ---------
 3 files changed, 71 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 6501ed1dfa1e..ebc6d4e3c073 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -148,43 +148,6 @@ extern struct static_key_false_deferred tcp_ao_needed;
 #define static_branch_tcp_ao()	false
 #endif
 
-static inline bool tcp_hash_should_produce_warnings(void)
-{
-	return static_branch_tcp_md5() || static_branch_tcp_ao();
-}
-
-#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
-do {									\
-	const struct tcphdr *th = tcp_hdr(skb);				\
-	char hdr_flags[6];						\
-	char *f = hdr_flags;						\
-									\
-	if (!tcp_hash_should_produce_warnings())			\
-		break;							\
-	if (th->fin)							\
-		*f++ = 'F';						\
-	if (th->syn)							\
-		*f++ = 'S';						\
-	if (th->rst)							\
-		*f++ = 'R';						\
-	if (th->psh)							\
-		*f++ = 'P';						\
-	if (th->ack)							\
-		*f++ = '.';						\
-	*f = 0;								\
-	if ((family) == AF_INET) {					\
-		net_info_ratelimited("%s for %pI4.%d->%pI4.%d [%s] " fmt "\n", \
-				msg, &ip_hdr(skb)->saddr, ntohs(th->source), \
-				&ip_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	} else {							\
-		net_info_ratelimited("%s for [%pI6c].%d->[%pI6c].%d [%s]" fmt "\n", \
-				msg, &ipv6_hdr(skb)->saddr, ntohs(th->source), \
-				&ipv6_hdr(skb)->daddr, ntohs(th->dest),	\
-				hdr_flags, ##__VA_ARGS__);		\
-	}								\
-} while (0)
-
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
 struct tcp4_ao_context {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 81f22d6afe4a..e83fdce91554 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4448,7 +4448,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
-		tcp_hash_fail("Unexpected MD5 Hash found", family, skb, "");
 		trace_tcp_hash_md5_unexpected(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
@@ -4464,21 +4463,6 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 							 NULL, skb);
 	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
-		if (family == AF_INET) {
-			tcp_hash_fail("MD5 Hash failed", AF_INET, skb, "%s L3 index %d",
-				      genhash ? "tcp_v4_calc_md5_hash failed"
-				      : "", l3index);
-		} else {
-			if (genhash) {
-				tcp_hash_fail("MD5 Hash failed",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			} else {
-				tcp_hash_fail("MD5 Hash mismatch",
-					      AF_INET6, skb, "L3 index %d",
-					      l3index);
-			}
-		}
 		trace_tcp_hash_md5_mismatch(sk, skb);
 		return SKB_DROP_REASON_TCP_MD5FAILURE;
 	}
@@ -4502,8 +4486,6 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 
 	/* Invalid option or two times meet any of auth options */
 	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
-		tcp_hash_fail("TCP segment has incorrect auth options set",
-			      family, skb, "");
 		trace_tcp_hash_bad_header(sk, skb);
 		return SKB_DROP_REASON_TCP_AUTH_HDR;
 	}
@@ -4521,9 +4503,6 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 			}
 
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
-			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
-				      family, skb, "%s",
-				      !aoh ? "missing AO" : "AO signed");
 			trace_tcp_ao_handshake_failure(sk, skb, keyid, rnext, maclen);
 			return SKB_DROP_REASON_TCP_AOFAILURE;
 		}
@@ -4542,15 +4521,11 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 		 * always at least one current_key.
 		 */
 		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
-			tcp_hash_fail("AO hash is required, but not found",
-					family, skb, "L3 index %d", l3index);
 			trace_tcp_hash_ao_required(sk, skb);
 			return SKB_DROP_REASON_TCP_AONOTFOUND;
 		}
 		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found",
-				      family, skb, "L3 index %d", l3index);
 			trace_tcp_hash_md5_required(sk, skb);
 			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
 		}
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 416cdeaccd07..e99bf734d070 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -893,9 +893,6 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash wrong length", family, skb,
-			      "%u != %d L3index: %d", maclen,
-			      tcp_ao_maclen(key), l3index);
 		trace_tcp_ao_wrong_maclen(sk, skb, aoh->keyid,
 					  aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
@@ -912,8 +909,6 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);
-		tcp_hash_fail("AO hash mismatch", family, skb,
-			      "L3index: %d", l3index);
 		trace_tcp_ao_mismatch(sk, skb, aoh->keyid,
 				      aoh->rnext_keyid, maclen);
 		kfree(hash_buf);
@@ -944,8 +939,6 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
 	if (!info) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
-		tcp_hash_fail("AO key not found", family, skb,
-			      "keyid: %u L3index: %d", aoh->keyid, l3index);
 		trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
 					   aoh->rnext_keyid, maclen);
 		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
@@ -1052,8 +1045,6 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 key_not_found:
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOKEYNOTFOUND);
 	atomic64_inc(&info->counters.key_not_found);
-	tcp_hash_fail("Requested by the peer AO key id not found",
-		      family, skb, "L3index: %d", l3index);
 	trace_tcp_ao_key_not_found(sk, skb, aoh->keyid,
 				   aoh->rnext_keyid, maclen);
 	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;

-- 
2.43.0


