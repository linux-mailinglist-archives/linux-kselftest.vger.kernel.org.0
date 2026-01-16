Return-Path: <linux-kselftest+bounces-49132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A0D2DCE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 043CF301B778
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A52F744A;
	Fri, 16 Jan 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8nvtzSv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9462F3624;
	Fri, 16 Jan 2026 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551241; cv=none; b=msUXsgbcCDo4kUq20sM0bMzRKzkyNccyWbYkx6dNM8L54SZyIX8clHP4T76qgWFZz8QJlZDpUayQsK6MjhVwLltmUkK//VhKzQ0Lm3TCnDm4rdYvDTNh3xaMtLUmRlBfIYvTEwxfXg9ppqqLnNjXlm6AH/FTswHun9/YLWT3GZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551241; c=relaxed/simple;
	bh=dIbO/mds4NgOKMLchudGMbNJZy61Bm/atGNos1RqNdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBIai1ooKL1s/O9xsmpNNRPi0/ZMTJc73BubY/Tpb2tCssKkYBaksICGSf5qOSHrQYIYFd/pzKWmtZzaRX91OUBXh2QABwMXew48dNY9wBAdEoFLk4YlAhKoBGVyjCPqM+kD2sfOMiLbPnpUBfioyVio8j/rYVpWkUQbXSt7dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8nvtzSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E109BC116C6;
	Fri, 16 Jan 2026 08:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551241;
	bh=dIbO/mds4NgOKMLchudGMbNJZy61Bm/atGNos1RqNdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H8nvtzSvF0OBzP2daU1pF9qRMgR6yczTX8TcivLom7IvQ6BEuQG9I+YXvkCZMviq1
	 +ENyEF8eYBmMW5sP/9AKMCCG7mp6SrhyhuqKf//HoNvMUwnC29lcfCmeUfaY8D0tsj
	 AxgiFCqahjkKhQOJuSZGMaZs8WQM6bAh/ipDeAlX+6pXdgu0JGvc2rOCLNfl9uBwL+
	 Xw/bdCK+qvksYb/hv7ws8RMCrk5ml7zpU0QpG2zynbME2LWSf3v38hDWuWIMtOxtOp
	 qE0tHAWcoXhk0jlfPWX9nTEfHIBXY8Ft23WSKO24fRuWePWRSyw9nfmo24ctSiEud/
	 yjwiL+OgNaoJQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 Jan 2026 09:13:21 +0100
Subject: [PATCH nf-next v3 4/5] netfilter: flowtable: Add IP6IP6 tx sw
 acceleration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-b4-flowtable-offload-ip6ip6-v3-4-c1fcad85a905@kernel.org>
References: <20260116-b4-flowtable-offload-ip6ip6-v3-0-c1fcad85a905@kernel.org>
In-Reply-To: <20260116-b4-flowtable-offload-ip6ip6-v3-0-c1fcad85a905@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce sw acceleration for tx path of IP6IP6 tunnels relying on the
netfilter flowtable infrastructure.
IP6IP6 tx sw acceleration can be tested running the following scenario
where the traffic is forwarded between two NICs (eth0 and eth1) and an
IP6IP6 tunnel is used to access a remote site (using eth1 as the underlay
device):

ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (2001:db8:3::2)

$ip addr show
6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet6 2001:db8:1::2/64 scope global nodad
       valid_lft forever preferred_lft forever
7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet6 2001:db8:2::1/64 scope global nodad
       valid_lft forever preferred_lft forever
8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
    link/tunnel6 2001:db8:2::1 peer 2001:db8:2::2 permaddr ce9c:2940:7dcc::
    inet6 2002:db8:1::1/64 scope global nodad
       valid_lft forever preferred_lft forever

$ip -6 route show
2001:db8:1::/64 dev eth0 proto kernel metric 256 pref medium
2001:db8:2::/64 dev eth1 proto kernel metric 256 pref medium
2002:db8:1::/64 dev tun0 proto kernel metric 256 pref medium
default via 2002:db8:1::2 dev tun0 metric 1024 pref medium

$nft list ruleset
table inet filter {
        flowtable ft {
                hook ingress priority filter
                devices = { eth0, eth1 }
        }

        chain forward {
                type filter hook forward priority filter; policy accept;
                meta l4proto { tcp, udp } flow add @ft
        }
}

Reproducing the scenario described above using veths I got the following
results:
- TCP stream received from the IPIP tunnel:
  - net-next: (baseline)                  ~93Gbps
  - net-next + IP6IP6 flowtbale support:  ~98Gbps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/netfilter/nf_flow_table_ip.c | 96 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 0389d3ef30cdfc05fe862f72d0d65cfd23232678..af019d58d3a7a0b8a5dbbbde6bf10cf6a95ad52d 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -12,6 +12,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
+#include <net/ip6_tunnel.h>
 #include <net/neighbour.h>
 #include <net/netfilter/nf_flow_table.h>
 #include <net/netfilter/nf_conntrack_acct.h>
@@ -635,6 +636,94 @@ static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
 	return 0;
 }
 
+struct ipv6_tel_txoption {
+	struct ipv6_txoptions ops;
+	__u8 dst_opt[8];
+};
+
+static int nf_flow_tunnel_ip6ip6_push(struct net *net, struct sk_buff *skb,
+				      struct flow_offload_tuple *tuple,
+				      struct in6_addr **ip6_daddr)
+{
+	struct ipv6hdr *ip6h = (struct ipv6hdr *)skb_network_header(skb);
+	int err, mtu, encap_limit = IPV6_DEFAULT_TNL_ENCAP_LIMIT;
+	u8 hop_limit = ip6h->hop_limit, proto = IPPROTO_IPV6;
+	struct rtable *rt = dst_rtable(tuple->dst_cache);
+	__u8 dsfield = ipv6_get_dsfield(ip6h);
+	struct flowi6 fl6 = {
+		.daddr = tuple->tun.src_v6,
+		.saddr = tuple->tun.dst_v6,
+		.flowi6_proto = proto,
+	};
+	u32 headroom;
+
+	err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6);
+	if (err)
+		return err;
+
+	skb_set_inner_ipproto(skb, proto);
+	headroom = sizeof(*ip6h) + LL_RESERVED_SPACE(rt->dst.dev) +
+		   rt->dst.header_len;
+	if (encap_limit)
+		headroom += 8;
+	err = skb_cow_head(skb, headroom);
+	if (err)
+		return err;
+
+	skb_scrub_packet(skb, true);
+	mtu = dst_mtu(&rt->dst) - sizeof(*ip6h);
+	if (encap_limit)
+		mtu -= 8;
+	mtu = max(mtu, IPV6_MIN_MTU);
+	skb_dst_update_pmtu_no_confirm(skb, mtu);
+
+	if (encap_limit > 0) {
+		struct ipv6_tel_txoption opt = {
+			.dst_opt[2] = IPV6_TLV_TNL_ENCAP_LIMIT,
+			.dst_opt[3] = 1,
+			.dst_opt[4] = encap_limit,
+			.dst_opt[5] = IPV6_TLV_PADN,
+			.dst_opt[6] = 1,
+		};
+		struct ipv6_opt_hdr *hopt;
+
+		opt.ops.dst1opt = (struct ipv6_opt_hdr *)opt.dst_opt;
+		opt.ops.opt_nflen = 8;
+
+		hopt = skb_push(skb, ipv6_optlen(opt.ops.dst1opt));
+		memcpy(hopt, opt.ops.dst1opt, ipv6_optlen(opt.ops.dst1opt));
+		hopt->nexthdr = IPPROTO_IPV6;
+		proto = NEXTHDR_DEST;
+	}
+
+	skb_push(skb, sizeof(*ip6h));
+	skb_reset_network_header(skb);
+
+	ip6h = ipv6_hdr(skb);
+	ip6_flow_hdr(ip6h, dsfield,
+		     ip6_make_flowlabel(net, skb, fl6.flowlabel, true, &fl6));
+	ip6h->hop_limit = hop_limit;
+	ip6h->nexthdr = proto;
+	ip6h->daddr = tuple->tun.src_v6;
+	ip6h->saddr = tuple->tun.dst_v6;
+	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(*ip6h));
+	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+
+	*ip6_daddr = &tuple->tun.src_v6;
+
+	return 0;
+}
+
+static int nf_flow_tunnel_v6_push(struct net *net, struct sk_buff *skb,
+				  struct flow_offload_tuple *tuple,
+				  struct in6_addr **ip6_daddr)
+{
+	if (tuple->tun_num)
+		return nf_flow_tunnel_ip6ip6_push(net, skb, tuple, ip6_daddr);
+
+	return 0;
+}
+
 static int nf_flow_encap_push(struct sk_buff *skb,
 			      struct flow_offload_tuple *tuple)
 {
@@ -923,6 +1012,9 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	if (flow->tuplehash[!dir].tuple.tun_num)
+		mtu -= sizeof(*ip6h);
+
 	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
 		return 0;
 
@@ -1012,6 +1104,10 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	other_tuple = &flow->tuplehash[!dir].tuple;
 	ip6_daddr = &other_tuple->src_v6;
 
+	if (nf_flow_tunnel_v6_push(state->net, skb, other_tuple,
+				   &ip6_daddr) < 0)
+		return NF_DROP;
+
 	if (nf_flow_encap_push(skb, other_tuple) < 0)
 		return NF_DROP;
 

-- 
2.52.0


