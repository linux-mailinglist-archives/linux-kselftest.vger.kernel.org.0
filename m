Return-Path: <linux-kselftest+bounces-5310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5286044F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70531F22864
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD37175C;
	Thu, 22 Feb 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISJ8KiXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE036AFBD;
	Thu, 22 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635926; cv=none; b=k1toy7XF1lxu0HSvNSDUyZt0qUKmvjWGmcCa7x2rAd85wnxateTZlsQUD+t/bNAd9uYuhl9DZGpD6nXexF/XOYIXUprFUtAuCwFxOUbIsN7VA9SwkJKC7HhTRJ3UGV83CbP8ByiVZ3/19SnaizIejN8jK4j58L+JkUqBFjDD9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635926; c=relaxed/simple;
	bh=yD5pBPD/kYxJPTUYZvrUJwnIAwaUmh2gCraooFp2UHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NXanq6YlLe9g9ysyXyls81j6e8PyHjZydsaxAH/6UCkLrb6M+Lym+Y7KJ8w908MAVDuTwztOXCbDxYNvboSF6oPaJCDh0TpE28NHswFpRh+ncYDZC0jZA9ftIJx5g9YzlPHO0Z+p+3sxOSaR/pScDOenSZb12Z5iAD+ABtlyk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISJ8KiXX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so1278615e9.1;
        Thu, 22 Feb 2024 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635923; x=1709240723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIYgPTK6VpZSbtimKRFbQMOHfT2uNIHrnwc0TVN0yNI=;
        b=ISJ8KiXXFu+qwE59xAzQVIjJ6ss5bHBNYGQg/j+Xbkw3sgks6SNOSUzYkyUlG7Y49Z
         DWtS1Xf0+OfSJNeaf6kzm1hBn7p9lN0TFcSkPj/rNf2FPMHL4HJ5aE9+q+5PR4zp/7Yq
         3/Eay9eDM7CdWAcxD8HLf9h5Xk35KwUBAkHOMxlT3UuqTW5RpS5u1NHBbX4B/MSEvWMM
         jAx3D2fS7MifpOk8SdMZC6tteZSEHtzM/ym64z9XXKGdIDK35bayOWf90eIt6Ovlea4h
         Fqf+YgEwINKJWTzD/0jMEcrgelHvgAPj8MuWskxJPVrjnHqzV1xYooVt0C8htDvSV0e/
         P7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635923; x=1709240723;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YIYgPTK6VpZSbtimKRFbQMOHfT2uNIHrnwc0TVN0yNI=;
        b=fKKc1px1Fj5nFVSYSduRQKIBoH7ovKHsOdbU1kFXumJx8psR6OnA9dnH6DxLMuNdNl
         +GBxYFnabUYU4weU5QxZE8CBXlUscydsgZFHJOqqIlseA1+5p0jDydUnAuAkcUY6EUrU
         P+kNRSqZnmAcpnO3yE9WGHZfKbQ1tPzDXTFLJU1hgaXy/KPuKInAXV2Lfo4rEut2jv3c
         2C6g6M4sz1RuDQpGYRaHmaRV83wlK6tjQXKXDA9FKjpS5DE+s5CEBq1XqhyAAeCIhHuV
         4mGB5DTxAqz+bXWMDlJH8MQdHToHl7jnrXcBrbo5+aI8bydfO3jhIPanHh/Bkotn/81A
         4raQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuHya+qQfOiPdWmgZOTwHBBkt8T5f8R3dvEhibWKYjcWEO327kGMq23S3/oV4vs1FG+K9Hr0NFskzx335NaN/kSiMWxyEyGcdqbAAV/qOQpf5VgDUONKBFfHRIS0vsfVSVA49HBQPgiKY2Q8lk+bsKgJviK+qjeiaBsgWrgQCXAOYJKNG+
X-Gm-Message-State: AOJu0Yyh7sXWmu0iHTA858NsT+XtopJa+52bgdsDpuI9/J+g1wmvv3a/
	+OKqPHLGKSeW2ywnqDKZ4OkIuw5yjdTo+vNmG47MDacOfpoiZu6hJwdDSLdq
X-Google-Smtp-Source: AGHT+IHreq6rtNKAgSf+gtsztxpU6WO5jwtuaciiBvX7Jja5+hgNjWGMXWt+Z/Dsw0HBBSeVNP4WRg==
X-Received: by 2002:a05:600c:19c7:b0:412:3bff:a813 with SMTP id u7-20020a05600c19c700b004123bffa813mr13897746wmq.10.1708635923137;
        Thu, 22 Feb 2024 13:05:23 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b00412157dc70bsm23434119wmb.30.2024.02.22.13.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:05:22 -0800 (PST)
Message-ID: <446695cb-50b8-4187-bf11-63aedb6e9aed@gmail.com>
Date: Thu, 22 Feb 2024 22:05:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 1/3] net: gro: set {inner_,}network_header in receive
 phase
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
 liujian56@huawei.com, horms@kernel.org, aleksander.lobakin@intel.com,
 linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
complete phase of gro. The functions always return skb->network_header,
which in the case of encapsulated packets at the gro complete phase, is
always set to the innermost L3 of the packet. That means that calling
{ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
L3/L4 may return an unexpected value.

This incorrect usage leads to a bug in GRO's UDP socket lookup.
udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
*_hdr functions return network_header which will point to the innermost L3,
resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
encapsulated packets.

Reproduction example:

Endpoint configuration example (fou + local address bind)

    # ip fou add port 6666 ipproto 4
    # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
    # ip link set tun1 up
    # ip a add 1.1.1.2/24 dev tun1

Netperf TCP_STREAM result on net-next before patch is applied:

net-next main, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.28        2.37

net-next main, GRO disabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2745.06

patch applied, GRO enabled:
    $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
    Recv   Send    Send
    Socket Socket  Message  Elapsed
    Size   Size    Size     Time     Throughput
    bytes  bytes   bytes    secs.    10^6bits/sec

    131072  16384  16384    5.01     2877.38

This patch fixes this bug and prevents similar future misuse of
network_header by setting network_header and inner_network_header to their
respective values during the receive phase of GRO. This results in
more coherent {inner_,}network_header values for every skb in gro_list,
which also means there's no need to set/fix these values before passing
the packet forward.

network_header is already set in dev_gro_receive and under encapsulation we
set inner_network_header. *_gro_complete functions use a new helper
function - skb_gro_complete_network_header, which returns the
network_header/inner_network_header offset during the GRO complete phase,
depending on skb->encapsulation.

Fixes: 57c67ff4bd92 ("udp: additional GRO support")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h        | 14 +++++++++++++-
 net/8021q/vlan_core.c    |  3 +++
 net/ipv4/af_inet.c       |  8 ++++----
 net/ipv4/tcp_offload.c   |  2 +-
 net/ipv4/udp_offload.c   |  2 +-
 net/ipv6/ip6_offload.c   | 11 +++++------
 net/ipv6/tcpv6_offload.c |  2 +-
 net/ipv6/udp_offload.c   |  2 +-
 8 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b435f0ddbf64..89502a7e35ed 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -177,10 +177,22 @@ static inline void *skb_gro_header(struct sk_buff *skb,
 	return ptr;
 }
 
+static inline int skb_gro_network_offset(struct sk_buff *skb)
+{
+	return NAPI_GRO_CB(skb)->encap_mark ? skb_inner_network_offset(skb) :
+		skb_network_offset(skb);
+}
+
 static inline void *skb_gro_network_header(struct sk_buff *skb)
 {
 	return (NAPI_GRO_CB(skb)->frag0 ?: skb->data) +
-	       skb_network_offset(skb);
+	       skb_gro_network_offset(skb);
+}
+
+static inline void *skb_gro_complete_network_header(struct sk_buff *skb)
+{
+	return skb->encapsulation ? skb_inner_network_header(skb) :
+		skb_network_header(skb);
 }
 
 static inline __wsum inet_gro_compute_pseudo(struct sk_buff *skb, int proto)
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index f00158234505..8bc871397e47 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,9 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	if (!NAPI_GRO_CB(skb)->encap_mark)
+		skb_set_network_header(skb, hlen);
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 835f4f9d98d2..c0f3c162bf73 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1564,7 +1564,9 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
+	if (NAPI_GRO_CB(skb)->encap_mark)
+		skb_set_inner_network_header(skb, off);
+
 	/* The above will be needed by the transport layer if there is one
 	 * immediately following this IP hdr.
 	 */
@@ -1643,10 +1645,8 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	int proto = iph->protocol;
 	int err = -ENOSYS;
 
-	if (skb->encapsulation) {
+	if (skb->encapsulation)
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IP));
-		skb_set_inner_network_header(skb, nhoff);
-	}
 
 	iph_set_totlen(iph, skb->len - nhoff);
 	csum_replace2(&iph->check, totlen, iph->tot_len);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b5..8bbcd3f502ac 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,7 +330,7 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph = skb_gro_complete_network_header(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6c95d28d0c4a..7f59cede67f5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -709,7 +709,7 @@ EXPORT_SYMBOL(udp_gro_complete);
 
 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph = skb_gro_complete_network_header(skb);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809be..db7e3db587b9 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
 	return proto;
 }
 
@@ -236,7 +236,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
+	if (NAPI_GRO_CB(skb)->encap_mark)
+		skb_set_inner_network_header(skb, off);
 
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
@@ -259,7 +260,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
@@ -353,10 +354,8 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	int err = -ENOSYS;
 	u32 payload_len;
 
-	if (skb->encapsulation) {
+	if (skb->encapsulation)
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
-		skb_set_inner_network_header(skb, nhoff);
-	}
 
 	payload_len = skb->len - nhoff - sizeof(*iph);
 	if (unlikely(payload_len > IPV6_MAXPLEN)) {
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index bf0c957e4b5e..79eeaced2834 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -29,7 +29,7 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
-	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const struct ipv6hdr *iph = skb_gro_complete_network_header(skb);
 	struct tcphdr *th = tcp_hdr(skb);
 
 	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 6b95ba241ebe..897caa2e39fb 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,7 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ipv6h = skb_gro_complete_network_header(skb);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
-- 
2.36.1

