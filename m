Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86E22C131A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Nov 2020 19:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgKWSa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Nov 2020 13:30:57 -0500
Received: from smtp.uniroma2.it ([160.80.6.22]:41910 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbgKWSaz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Nov 2020 13:30:55 -0500
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 0ANITqgf016939
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 19:29:54 +0100
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next v3 1/8] vrf: add mac header for tunneled packets when sniffer is attached
Date:   Mon, 23 Nov 2020 19:28:49 +0100
Message-Id: <20201123182857.4640-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201123182857.4640-1-andrea.mayer@uniroma2.it>
References: <20201123182857.4640-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before this patch, a sniffer attached to a VRF used as the receiving
interface of L3 tunneled packets detects them as malformed packets and
it complains about that (i.e.: tcpdump shows bogus packets).

The reason is that a tunneled L3 packet does not carry any L2
information and when the VRF is set as the receiving interface of a
decapsulated L3 packet, no mac header is currently set or valid.
Therefore, the purpose of this patch consists of adding a MAC header to
any packet which is directly received on the VRF interface ONLY IF:

 i) a sniffer is attached on the VRF and ii) the mac header is not set.

In this case, the mac address of the VRF is copied in both the
destination and the source address of the ethernet header. The protocol
type is set either to IPv4 or IPv6, depending on which L3 packet is
received.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 drivers/net/vrf.c | 78 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index f2793ffde191..51de12874717 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1309,6 +1309,61 @@ static void vrf_ip6_input_dst(struct sk_buff *skb, struct net_device *vrf_dev,
 	skb_dst_set(skb, &rt6->dst);
 }
 
+static int vrf_prepare_mac_header(struct sk_buff *skb,
+				  struct net_device *vrf_dev, u16 proto)
+{
+	struct ethhdr *eth;
+	int err;
+
+	/* in general, we do not know if there is enough space in the head of
+	 * the packet for hosting the mac header.
+	 */
+	err = skb_cow_head(skb, LL_RESERVED_SPACE(vrf_dev));
+	if (unlikely(err))
+		/* no space in the skb head */
+		return -ENOBUFS;
+
+	__skb_push(skb, ETH_HLEN);
+	eth = (struct ethhdr *)skb->data;
+
+	skb_reset_mac_header(skb);
+
+	/* we set the ethernet destination and the source addresses to the
+	 * address of the VRF device.
+	 */
+	ether_addr_copy(eth->h_dest, vrf_dev->dev_addr);
+	ether_addr_copy(eth->h_source, vrf_dev->dev_addr);
+	eth->h_proto = htons(proto);
+
+	/* the destination address of the Ethernet frame corresponds to the
+	 * address set on the VRF interface; therefore, the packet is intended
+	 * to be processed locally.
+	 */
+	skb->protocol = eth->h_proto;
+	skb->pkt_type = PACKET_HOST;
+
+	skb_postpush_rcsum(skb, skb->data, ETH_HLEN);
+
+	skb_pull_inline(skb, ETH_HLEN);
+
+	return 0;
+}
+
+/* prepare and add the mac header to the packet if it was not set previously.
+ * In this way, packet sniffers such as tcpdump can parse the packet correctly.
+ * If the mac header was already set, the original mac header is left
+ * untouched and the function returns immediately.
+ */
+static int vrf_add_mac_header_if_unset(struct sk_buff *skb,
+				       struct net_device *vrf_dev,
+				       u16 proto)
+{
+	if (skb_mac_header_was_set(skb))
+		return 0;
+
+	return vrf_prepare_mac_header(skb, vrf_dev, proto);
+}
+
 static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 				   struct sk_buff *skb)
 {
@@ -1335,9 +1390,15 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 		skb->skb_iif = vrf_dev->ifindex;
 
 		if (!list_empty(&vrf_dev->ptype_all)) {
-			skb_push(skb, skb->mac_len);
-			dev_queue_xmit_nit(skb, vrf_dev);
-			skb_pull(skb, skb->mac_len);
+			int err;
+
+			err = vrf_add_mac_header_if_unset(skb, vrf_dev,
+							  ETH_P_IPV6);
+			if (likely(!err)) {
+				skb_push(skb, skb->mac_len);
+				dev_queue_xmit_nit(skb, vrf_dev);
+				skb_pull(skb, skb->mac_len);
+			}
 		}
 
 		IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
@@ -1380,9 +1441,14 @@ static struct sk_buff *vrf_ip_rcv(struct net_device *vrf_dev,
 	vrf_rx_stats(vrf_dev, skb->len);
 
 	if (!list_empty(&vrf_dev->ptype_all)) {
-		skb_push(skb, skb->mac_len);
-		dev_queue_xmit_nit(skb, vrf_dev);
-		skb_pull(skb, skb->mac_len);
+		int err;
+
+		err = vrf_add_mac_header_if_unset(skb, vrf_dev, ETH_P_IP);
+		if (likely(!err)) {
+			skb_push(skb, skb->mac_len);
+			dev_queue_xmit_nit(skb, vrf_dev);
+			skb_pull(skb, skb->mac_len);
+		}
 	}
 
 	skb = vrf_rcv_nfhook(NFPROTO_IPV4, NF_INET_PRE_ROUTING, skb, vrf_dev);
-- 
2.20.1

