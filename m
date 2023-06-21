Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C95738229
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjFUKpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjFUKov (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB52944;
        Wed, 21 Jun 2023 03:42:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so3772556f8f.3;
        Wed, 21 Jun 2023 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344146; x=1689936146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkw8bQdwFr7zljxAqmtMYnMYfHrOsX7/tbEjabdOhek=;
        b=KA71CGY6OyzlrEkw4NodEkSlBeUYAEAFCEpjoXAtQBPcZVOMyjpnJ0VxEu3vTdfz1W
         QiGRvNSNLIQ3oRwDBHPrD8+HFkXieED9+7dXqFgib3a8uTiik5q76Wv+vqO+Md+uGecV
         uKbI5Y6LFtBM7UkZITIdhNzucRhQDTs+pHWnCAML3QGHcok00szE9jD5rUoYEpXKhKBG
         AMMu6YC1PdKujK36dobSgthu0ps7jViw2DrpC54KhEapWo+u8Y8JvmkPeCW4y5h695kT
         6TFGzIPs0rnlwocDyKrmzOc9AxpJen7Hur7DQbWxcvaBSiHkg8VE4HI2ipl57fjDrqwX
         +eLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344146; x=1689936146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkw8bQdwFr7zljxAqmtMYnMYfHrOsX7/tbEjabdOhek=;
        b=YfGNP826xc4erzd1RfW4ftgmpb6oY75Kl4XQHMb3fffl4WVC9pUDXKTME1TqUVnkBD
         dVFcKmRdw4SEmch8jBnnooQFdg2IV4QjJr0FuPmLe0hzrg4LXX96yJHSeBH7tlQSHn2L
         1GsUWv0Pwdda5/ouURJxinyrJYgzzIjacRUhPunCNbawz5iWHgJzB8RxAUTXftw8wYDS
         yAryA1YIAZkPbIXXrl37ch7dQpYszRSI2GMgf76qD+O1yPEsUjbA5tWvdq4uo7HleNyR
         c9+Izdf4lVdZNkG9dkDjMf9zbJn9BxnpKKDx1AgQcNQMi4K/Py6AHJgT+05/CZIt7XDM
         P4Gg==
X-Gm-Message-State: AC+VfDwpcDHqitUn2TNcxsKqZEC3AtrjP6vuvRE1lqQeTS6EuEw+fFr3
        j8ZFkNoQnMCZExrflH9VI3A=
X-Google-Smtp-Source: ACHHUZ6igvlJqXDL6KDilR6vAX1BaXLuhMjQ0RrzZOw4RRK1c8mo45diX7BWMWCM1mLOAAYuD1Y9zQ==
X-Received: by 2002:adf:f50a:0:b0:30f:b3ec:9e39 with SMTP id q10-20020adff50a000000b0030fb3ec9e39mr10746038wro.9.1687344146298;
        Wed, 21 Jun 2023 03:42:26 -0700 (PDT)
Received: from gsever-Latitude-7400.corp.proofpoint.com ([46.120.112.153])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b003062b2c5255sm4121378wrv.40.2023.06.21.03.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:42:25 -0700 (PDT)
From:   Gilad Sever <gilad9366@gmail.com>
To:     dsahern@kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
        john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org, hawk@kernel.org, joe@wand.net.nz
Cc:     eyal.birger@gmail.com, shmulik.ladkani@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Gilad Sever <gilad9366@gmail.com>
Subject: [PATCH bpf,v6 3/4] bpf: fix bpf socket lookup from tc/xdp to respect socket VRF bindings
Date:   Wed, 21 Jun 2023 13:42:10 +0300
Message-Id: <20230621104211.301902-4-gilad9366@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621104211.301902-1-gilad9366@gmail.com>
References: <20230621104211.301902-1-gilad9366@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When calling bpf_sk_lookup_tcp(), bpf_sk_lookup_udp() or
bpf_skc_lookup_tcp() from tc/xdp ingress, VRF socket bindings aren't
respoected, i.e. unbound sockets are returned, and bound sockets aren't
found.

VRF binding is determined by the sdif argument to sk_lookup(), however
when called from tc the IP SKB control block isn't initialized and thus
inet{,6}_sdif() always returns 0.

Fix by calculating sdif for the tc/xdp flows by observing the device's
l3 enslaved state.

The cg/sk_skb hooking points which are expected to support
inet{,6}_sdif() pass sdif=-1 which makes __bpf_skc_lookup() use the
existing logic.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Gilad Sever <gilad9366@gmail.com>
---
v6: - Remove redundant IS_ENABLED as suggested by Daniel Borkmann
    - Declare net_device variable and use it as suggested by Daniel Borkmann

v5: Use reverse xmas tree indentation

v4: Move dev_sdif() to include/linux/netdevice.h as suggested by Stanislav Fomichev

v3: Rename bpf_l2_sdif() to dev_sdif() as suggested by Stanislav Fomichev
---
 include/linux/netdevice.h |  9 +++++
 net/core/filter.c         | 84 +++++++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c2f0c6002a84..68adc8af29ef 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5093,6 +5093,15 @@ static inline bool netif_is_l3_slave(const struct net_device *dev)
 	return dev->priv_flags & IFF_L3MDEV_SLAVE;
 }
 
+static inline int dev_sdif(const struct net_device *dev)
+{
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	if (netif_is_l3_slave(dev))
+		return dev->ifindex;
+#endif
+	return 0;
+}
+
 static inline bool netif_is_bridge_master(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_EBRIDGE;
diff --git a/net/core/filter.c b/net/core/filter.c
index e06547922edc..6f8de7e62a81 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6555,12 +6555,11 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 static struct sock *
 __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		 u64 flags)
+		 u64 flags, int sdif)
 {
 	struct sock *sk = NULL;
 	struct net *net;
 	u8 family;
-	int sdif;
 
 	if (len == sizeof(tuple->ipv4))
 		family = AF_INET;
@@ -6572,10 +6571,12 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	if (unlikely(flags || !((s32)netns_id < 0 || netns_id <= S32_MAX)))
 		goto out;
 
-	if (family == AF_INET)
-		sdif = inet_sdif(skb);
-	else
-		sdif = inet6_sdif(skb);
+	if (sdif < 0) {
+		if (family == AF_INET)
+			sdif = inet_sdif(skb);
+		else
+			sdif = inet6_sdif(skb);
+	}
 
 	if ((s32)netns_id < 0) {
 		net = caller_net;
@@ -6595,10 +6596,11 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 static struct sock *
 __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		u64 flags)
+		u64 flags, int sdif)
 {
 	struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
-					   ifindex, proto, netns_id, flags);
+					   ifindex, proto, netns_id, flags,
+					   sdif);
 
 	if (sk) {
 		struct sock *sk2 = sk_to_full_sk(sk);
@@ -6638,7 +6640,7 @@ bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	}
 
 	return __bpf_skc_lookup(skb, tuple, len, caller_net, ifindex, proto,
-				netns_id, flags);
+				netns_id, flags, -1);
 }
 
 static struct sock *
@@ -6730,12 +6732,17 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	struct net *caller_net;
+	int ifindex, sdif;
+
+	caller_net = dev_net(dev);
+	ifindex = dev->ifindex;
+	sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_skc_lookup(skb, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
-					       flags);
+					       flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
@@ -6753,12 +6760,17 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	struct net *caller_net;
+	int ifindex, sdif;
+
+	caller_net = dev_net(dev);
+	ifindex = dev->ifindex;
+	sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
@@ -6776,12 +6788,17 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	struct net *caller_net;
+	int ifindex, sdif;
+
+	caller_net = dev_net(dev);
+	ifindex = dev->ifindex;
+	sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
@@ -6813,12 +6830,14 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	struct net *caller_net = dev_net(dev);
+	int ifindex = dev->ifindex;
+	int sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
@@ -6836,12 +6855,14 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	struct net *caller_net = dev_net(dev);
+	int ifindex = dev->ifindex;
+	int sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
-					       flags);
+					       flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
@@ -6859,12 +6880,14 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	struct net *caller_net = dev_net(dev);
+	int ifindex = dev->ifindex;
+	int sdif = dev_sdif(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
@@ -6884,7 +6907,8 @@ BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len,
 					       sock_net(ctx->sk), 0,
-					       IPPROTO_TCP, netns_id, flags);
+					       IPPROTO_TCP, netns_id, flags,
+					       -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
@@ -6903,7 +6927,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_TCP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
@@ -6922,7 +6946,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_udp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_UDP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
-- 
2.34.1

