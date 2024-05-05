Return-Path: <linux-kselftest+bounces-9482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAD8BC2EE
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3991C20952
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A969D2B;
	Sun,  5 May 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wAaaJbos"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923E66B5E;
	Sun,  5 May 2024 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931917; cv=none; b=Lqyhn/1btgRoSg4HGIIz0rnCXhAMWH7acugnXgZnl97zi0WvyYvpbvo0TIpOvRHwAnWns93YQK1E1PGcfIm1wy1BVXH2WssdDJqlvoHZWBiilu7vhMLVHlb07wRM4czM6FoDc/LnMLoYoxDzRfGcGCogXPOwH2GO+6f9Bf2hSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931917; c=relaxed/simple;
	bh=mggA7OS7sKbTIvNFfbbnIDWP1Sm7tY+HZ01K03UVU+c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeuSu4jhupUeTTHNoJ/dA3voju8IxUu9BR57ca4D1WragLhEuuaMot+kvzpgihf+dsHBbrIdkUIL9gL+ThtgQ8kItoF5iDSH4xiIo/qxkRlxJRtNU0oGMP1o8c24f7b5f/T6f7P87E1K6Qu+/4ryTuS6bQrs64wsxK0c5GHxO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wAaaJbos; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 19196205E5;
	Sun,  5 May 2024 19:58:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZiRaueaSu1h; Sun,  5 May 2024 19:58:32 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3BA3420561;
	Sun,  5 May 2024 19:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3BA3420561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714931912;
	bh=lSEHGladzuqmKPIEerNtXlNa4toMQIllV18os6y7qLI=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=wAaaJbosf+VHf9S/ooUL2HqK5uX0oxtJF0mzPyFncEEBzNs2IS444h8d0514JsVr5
	 UYJQeuJrRTpV9BovEA6hj8VWMc8ikr6S3H/SKLVyAuBCOLE0kB0tU4ZtlwSLKB+uUV
	 FKUQk+7k02SFbY2+EhKf4cbvMNXYQA0fLGyCaZt1A+of9hsMJtfpb8B8TR/q54qOcS
	 HNzGv0pX4I+4Ag2X7+cZhGZfCPaPCcz+IkGdxhwRdtQ1ZFsp+ZAssOm08X1eP55m+q
	 xGwcYKMFFiDQXVPsL4WlyhqRK38x9277LipBqAli8BhhILddWDV0W70XORTzcoYRa7
	 E2mWFl25za2zA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 2FE2780004A;
	Sun,  5 May 2024 19:58:32 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 5 May 2024 19:58:32 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 May
 2024 19:58:31 +0200
Date: Sun, 5 May 2024 19:58:25 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, Antony Antony <antony.antony@secunet.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH net-next v2 1/2] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <ZjfIwdWYJTjCt+AB@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714931276.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714931276.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

When enabling support for XFRM lookup using reverse ICMP payload, we
have identified an issue where the source address of the IPv4,
e.g., "Destination Host Unreachable" message, is incorrect. The error message
received by the sender appears to originate from a
non-existing/unreachable host.  IPv6 seems to behave correctly; respond
with an existing source address from the gateway.

Here is example of incorrect source address for ICMP error response.
When sending a ping to an unreachable host, the sender would receive an
ICMP unreachable response with a fake source address. Rather the address
of the host that generated ICMP Unreachable message. This is confusing
and incorrect. A fllow up commit adds this example as a test case.

Example:
ping -W 9 -w 5 -c 1 10.1.4.3
PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
From 10.1.4.3 icmp_seq=1 Destination Host Unreachable

Notice : packet has the source address of the ICMP "Unreachable host!"

This issue can be traced back to commit
415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
which introduced a change that copied the source address from the ICMP
payload.

This commit would force to use source address from the gatway/host.
The ICMP error message source address correctly set from the host.

After fixing:
ping -W 5 -c 1 10.1.4.3
PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
From 10.1.3.2 icmp_seq=1 Destination Host Unreachable

Here is an snippt to reporduce the issue.

export AB="10.1"
for i in 1 2 3 4 5; do
        h="host${i}"
        ip netns add ${h}
        ip -netns ${h} link set lo up
        ip netns exec ${h} sysctl -wq net.ipv4.ip_forward=1
        if [ $i -lt 5 ]; then
                ip -netns ${h} link add eth0 type veth peer name eth10${i}
                ip -netns ${h} addr add "${AB}.${i}.1/24" dev eth0
                ip -netns ${h} link set up dev eth0
        fi
done

for i in 1 2 3 4 5; do
        h="host${i}"
        p=$((i - 1))
        ph="host${p}"
        # connect to previous host
        if [ $i -gt 1 ]; then
                ip -netns ${ph} link set eth10${p} netns ${h}
                ip -netns ${h} link set eth10${p} name eth1
                ip -netns ${h} link set up dev eth1
                ip -netns ${h} addr add "${AB}.${p}.2/24" dev eth1
        fi
        # add forward routes
        for k in $(seq ${i} $((5 - 1))); do
                ip -netns ${h} route 2>/dev/null | (grep "${AB}.${k}.0" 2>/dev/null) || \
                ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${i}.2" 2>/dev/nul
        done

        # add reverse routes
        for k in $(seq 1 $((i - 2))); do
                ip -netns ${h} route 2>/dev/null | grep "${AB}.${k}.0" 2>/dev/null || \
                ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${p}.1" 2>/dev/nul
        done
done

ip netns exec host1 ping -q -W 2 -w 1 -c 1 10.1.4.2 2>&1>/dev/null && echo "success 10.1.4.2 reachable" || echo "ERROR"
ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble of gateway"
ip -netns host1 route flush cache

ip netns exec host3 nft add table inet filter
ip netns exec host3 nft add chain inet filter FORWARD { type filter hook forward priority filter\; policy drop \; }
ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol icmp drop
ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol esp accept
ip netns exec host3 nft add rule inet filter FORWARD counter drop

ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
        flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel

ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir in \
        tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel

ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir fwd \
        flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel

ip -netns host2 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
        reqid 1 replay-window 1  mode tunnel aead 'rfc4106(gcm(aes))' \
        0x1111111111111111111111111111111111111111 96 \
        sel src 10.1.1.0/24 dst 10.1.4.0/24

ip -netns host2 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
        flag icmp reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
        0x2222222222222222222222222222222222222222 96

ip -netns host4 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir out \
        flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 1 mode tunnel

ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir in \
        tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2  mode tunnel

ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir fwd \
                flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2 mode tunnel

ip -netns host4 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
        reqid 1 replay-window 1 mode tunnel aead 'rfc4106(gcm(aes))' \
        0x2222222222222222222222222222222222222222 96

ip -netns host4 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
        reqid 2 replay-window 20 flag icmp  mode tunnel aead 'rfc4106(gcm(aes))' \
        0x1111111111111111111111111111111111111111 96 \
        sel src 10.1.1.0/24 dst 10.1.4.0/24

ip netns exec host1 ping -W 5 -c 1 10.1.4.2 2>&1 > /dev/null && echo ""
ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address of gateway 10.1.3.2"

Again before the fix
ping -W 5 -c 1 10.1.4.3
From 10.1.4.3 icmp_seq=1 Destination Host Unreachable

After the fix
From 10.1.3.2 icmp_seq=1 Destination Host Unreachable

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
---
 net/ipv4/icmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 207482d30dc7..317ad5165408 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -558,7 +558,6 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	rt2 = dst_rtable(dst2);
 	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
-		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
 	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
--
2.30.2


