Return-Path: <linux-kselftest+bounces-32060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D6AA5A12
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 05:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D60B1892029
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3120C461;
	Thu,  1 May 2025 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pUrl7qfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B31EA7FF
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746071537; cv=none; b=DglmsRStJA+fw/4C4X7oYNbk1hhYPPXpzdotyLCbDSI/xN4uIPOPfed6s2nyEGucSmY/VSI0Us7B5EgFoCcssx2uc85arrD4bJgzRIun/o+vzQJsB1g1yb7OgIehU7LF+khDrMK+ZQz+y9dRo5HXfuujo1xotouQ0auJJ1ET6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746071537; c=relaxed/simple;
	bh=39IOGPGemYqMgPsgi7Xt8KWzR7zEQRPrG3lVcmjfL64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNRZOryNPFqrT6YC19JL/OglIHAm7XzL+UWjLF+ACv1pkFm6MKGp2Rtjv2WAOXYH7XiGWSS89DaWfmBcH3g5lVzptSElOyobkIaS2pl5qg4SeBkeBp6m70Jw+OTi2eHl/A0HNTdPfjmYeQjoVsUXkY892d6AH60tcq4bBjraudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pUrl7qfO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746071532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x4IzOhxyRF1krYhh7iapiMZajQWSUqZZCDSXkt0jpIQ=;
	b=pUrl7qfOqIBEI9lkJOE1EDQxJHigOA1j/ASbnBX9B0Xs3oHPH1cTHTiBTNrnKODyPgHF6p
	veHPla/BOFnVJjmBTLkdlPu7Q8OSfdOJta+FVpbllfRsVXZ5RXzz4EKD9/PDgt2mNQKG0b
	ni1EeXpopA6zawTiG1Sewva6gvS7z1s=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC net-next v1 1/2] udp: Introduce UDP_STOP_RCV option for UDP
Date: Thu,  1 May 2025 11:51:08 +0800
Message-ID: <20250501035116.69391-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For some services we are using "established-over-unconnected" model.

'''
// create unconnected socket and 'listen()'
srv_fd = socket(AF_INET, SOCK_DGRAM)
setsockopt(srv_fd, SO_REUSEPORT)
bind(srv_fd, SERVER_ADDR, SERVER_PORT)

// 'accept()'
data, client_addr = recvmsg(srv_fd)

// create a connected socket for this request
cli_fd = socket(AF_INET, SOCK_DGRAM)
setsockopt(cli_fd, SO_REUSEPORT)
bind(cli_fd, SERVER_ADDR, SERVER_PORT)
connect(cli, client_addr)
...
// do handshake with cli_fd
'''

This programming pattern simulates accept() using UDP, creating a new
socket for each client request. The server can then use separate sockets
to handle client requests, avoiding the need to use a single UDP socket
for I/O transmission.

But there is a race condition between the bind() and connect() of the
connected socket:
We might receive unexpected packets belonging to the unconnected socket
before connect() is executed, which is not what we need.
(Of course, before connect(), the unconnected socket will also receive
packets from the connected socket, which is easily resolved because
upper-layer protocols typically require explicit boundaries, and we
receive a complete packet before creating a connected socket.)

Before this patch, the connected socket had to filter requests at recvmsg
time, acting as a dispatcher to some extent. With this patch, we can
consider the bind and connect operations to be atomic.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/udp.h      |  1 +
 include/uapi/linux/udp.h |  1 +
 net/ipv4/udp.c           | 13 ++++++++++---
 net/ipv6/udp.c           |  5 +++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 895240177f4f..8d281a0c0d9d 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -42,6 +42,7 @@ enum {
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
 	UDP_FLAGS_UDPLITE_SEND_CC, /* set via udplite setsockopt */
 	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
+	UDP_FLAGS_STOP_RCV, /* Stop receiving packets */
 };
 
 struct udp_sock {
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index edca3e430305..bb8e0a749a55 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -34,6 +34,7 @@ struct udphdr {
 #define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
 #define UDP_SEGMENT	103	/* Set GSO segmentation size */
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
+#define UDP_STOP_RCV	105	/* This socket will not receive any packets */
 
 /* UDP encapsulation types */
 #define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f9f5b92cf4b6..764d337ab1b3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -376,7 +376,8 @@ static int compute_score(struct sock *sk, const struct net *net,
 
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
-	    ipv6_only_sock(sk))
+	    ipv6_only_sock(sk) ||
+	    udp_test_bit(STOP_RCV, sk))
 		return -1;
 
 	if (sk->sk_rcv_saddr != daddr)
@@ -494,7 +495,7 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 
 			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
 						       saddr, sport, daddr, hnum, udp_ehashfn);
-			if (!result) {
+			if (!result || udp_test_bit(STOP_RCV, result)) {
 				result = sk;
 				continue;
 			}
@@ -3031,7 +3032,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family, sk);
 		sockopt_release_sock(sk);
 		break;
-
+	case UDP_STOP_RCV:
+		udp_assign_bit(STOP_RCV, sk, valbool);
+		break;
 	/*
 	 * 	UDP-Lite's partial checksum coverage (RFC 3828).
 	 */
@@ -3120,6 +3123,10 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		val = udp_test_bit(GRO_ENABLED, sk);
 		break;
 
+	case UDP_STOP_RCV:
+		val = udp_test_bit(STOP_RCV, sk);
+		break;
+
 	/* The following two cannot be changed on UDP sockets, the return is
 	 * always 0 (which corresponds to the full checksum coverage of UDP). */
 	case UDPLITE_SEND_CSCOV:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1..55896a78e94b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -137,7 +137,8 @@ static int compute_score(struct sock *sk, const struct net *net,
 
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
-	    sk->sk_family != PF_INET6)
+	    sk->sk_family != PF_INET6 ||
+	    udp_test_bit(STOP_RCV, sk))
 		return -1;
 
 	if (!ipv6_addr_equal(&sk->sk_v6_rcv_saddr, daddr))
@@ -245,7 +246,7 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 
 			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
 							saddr, sport, daddr, hnum, udp6_ehashfn);
-			if (!result) {
+			if (!result || udp_test_bit(STOP_RCV, result)) {
 				result = sk;
 				continue;
 			}
-- 
2.47.1


