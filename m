Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69294BBC96
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiBRPxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 10:53:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiBRPxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 10:53:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F3254A40;
        Fri, 18 Feb 2022 07:52:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e17so4941906ljk.5;
        Fri, 18 Feb 2022 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=Rcw7NVVt+xRbTVt1okgnvV9SIVxrg6UkjeCztqi7ITU=;
        b=KswQTuqsXHsf71yw2us6jf45qIUFVvmq5HJ70pvj+MnUib22LlFiRJpb9QzRlcm0uM
         v/dweD4d/yJM3pPeovi7nbuXwzEpMETVAi4YoAsWKdAKLiS1cjpAAaoyMbCEWfsBX6mJ
         fIp8AVm49GQQav/mFdJUKUZtMf3hI9Jt+wrKb9cXySLciQdT9gKKQh1ZbnZDiC8u7X+0
         kTjopeRSndk4qxKHWxRAhrSY7SR6V6awvqIEXUD/gFxnJeKwytOqzRPJeXFJtAtXZdAI
         jCuJf5hXXV2WV0cUG+QoXNFQZRb1t2lzDXP9mBKpBhlzM6OVDVH0pEYs4gCLWP7qnUeI
         /RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=Rcw7NVVt+xRbTVt1okgnvV9SIVxrg6UkjeCztqi7ITU=;
        b=0kltfcWqXKVvkEhMwPfIQDMuLnH4iYyJLNP98kvL0O7YcGeVHZNK9mnM23jm8E4B+a
         k/oIFOWqmxdWRYC+m/ZgLHVKwPz328NWkGoPjRUl8BiipKoK2uTCWxdQVLnJZ+O9EgH+
         A7Zodwzwngj0sVheo6+8jAAbwnFEJ7eRyDEzEaoU8gNKHg1NjjikYg4fZVrLsTGPUgn5
         Ry7yYWPM8943AxoHiXd8BzfkLTXn8HyQr7sFq/CxZsgYRGmjc+vwU9pfZNdkDFzk1wBw
         EP/P1J4JIbSFKKAAc1W8YWVrdeQ1t5XiN0QH4XBTn2b0lI9qCxvCzJj98NifqmKHcok3
         RAVQ==
X-Gm-Message-State: AOAM533Q7sxSiA00qKLt2QbcE7ygY/Upzi1CNMsY/1pSbIw3s2k8Q0nw
        ZW9CDvciPwxwKAks7bjfqK4=
X-Google-Smtp-Source: ABdhPJxryYPsXz9kvcRMAoXstAX3zms+hQSPwRHTw0l1sNmRhX0nUzolDBUK/pzrGY+R5tNY352NGw==
X-Received: by 2002:a05:651c:90b:b0:244:c4a4:d5d8 with SMTP id e11-20020a05651c090b00b00244c4a4d5d8mr5928922ljq.97.1645199569692;
        Fri, 18 Feb 2022 07:52:49 -0800 (PST)
Received: from wse-c0127.beijerelectronics.com ([208.127.141.29])
        by smtp.gmail.com with ESMTPSA id v11sm295453lfr.3.2022.02.18.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:52:49 -0800 (PST)
From:   Hans Schultz <schultz.hans@gmail.com>
X-Google-Original-From: Hans Schultz <schultz.hans+netdev@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org,
        Hans Schultz <schultz.hans+netdev@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/5] net: bridge: Add support for bridge port in locked mode
Date:   Fri, 18 Feb 2022 16:51:44 +0100
Message-Id: <20220218155148.2329797-2-schultz.hans+netdev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Organization: Westermo Network Technologies AB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In a 802.1X scenario, clients connected to a bridge port shall not
be allowed to have traffic forwarded until fully authenticated.
A static fdb entry of the clients MAC address for the bridge port
unlocks the client and allows bidirectional communication.

This scenario is facilitated with setting the bridge port in locked
mode, which is also supported by various switchcore chipsets.

Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
---
 include/linux/if_bridge.h    |  1 +
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_input.c        | 10 +++++++++-
 net/bridge/br_netlink.c      |  6 +++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 509e18c7e740..3aae023a9353 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -58,6 +58,7 @@ struct br_ip_list {
 #define BR_MRP_LOST_CONT	BIT(18)
 #define BR_MRP_LOST_IN_CONT	BIT(19)
 #define BR_TX_FWD_OFFLOAD	BIT(20)
+#define BR_PORT_LOCKED		BIT(21)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6218f93f5c1a..a45cc0a1f415 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -537,6 +537,7 @@ enum {
 	IFLA_BRPORT_MRP_IN_OPEN,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
+	IFLA_BRPORT_LOCKED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b50382f957c1..e99f635ff727 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -81,6 +81,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	if (!p || p->state == BR_STATE_DISABLED)
 		goto drop;
 
+	br = p->br;
 	brmctx = &p->br->multicast_ctx;
 	pmctx = &p->multicast_ctx;
 	state = p->state;
@@ -88,10 +89,17 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
 
+	if (p->flags & BR_PORT_LOCKED) {
+		struct net_bridge_fdb_entry *fdb_src =
+			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
+		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
+		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
+			goto drop;
+	}
+
 	nbp_switchdev_frame_mark(p, skb);
 
 	/* insert into forwarding database after filtering to avoid spoofing */
-	br = p->br;
 	if (p->flags & BR_LEARNING)
 		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 2ff83d84230d..7d4432ca9a20 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -184,6 +184,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
 		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
+		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
@@ -269,7 +270,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 							  BR_MRP_LOST_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
 		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
-	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
+	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -827,6 +829,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
 	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
 	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
+	[IFLA_BRPORT_LOCKED] = { .type = NLA_U8 },
 	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
 	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
 };
@@ -893,6 +896,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
 	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
+	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
 
 	changed_mask = old_flags ^ p->flags;
 
-- 
2.30.2

