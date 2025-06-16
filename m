Return-Path: <linux-kselftest+bounces-35104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A3ADB696
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20F9170774
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378CE287513;
	Mon, 16 Jun 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY64G0VX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC4286D5D;
	Mon, 16 Jun 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090884; cv=none; b=qcPIwuGry2Nh/5u0sBNgpEsEkEt6bArZdH+Rry+2PP2krKQ5nFknaAR2OJauCd+53CTJgxiwl3JBnZtKWhQe0AY/YfVta2Pyp9hGecYXsDogCNLJeQjaEZYf40iVpn58SMSkadZ66dyWjGYbt0myVWisBJqxnjIWExKFnSi7gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090884; c=relaxed/simple;
	bh=ybzdEKFoXnN30cRASg2fmf1ICH7BtS5CDfPQ1BrrNm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNU6F7g9AS/plHMKwOhOaUNiiy6r+xFenOPdrsL3g8puvnaC/O28nqlEp5LjRagWdStfvZsR9gqVJfJPbLox/Y39e8gkSgZw8KI6A0S+L8KSBKwRMn097sVW9fZNtp1ROjFY4KUCpX5GouojnOO3q1iHdp6zLlHXj0+Bm+FB/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY64G0VX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso4700792a91.1;
        Mon, 16 Jun 2025 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090881; x=1750695681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xlGbr7S7dkulxlPf5XLC+Ja0lhJQ4XwBOGvbFljsao=;
        b=mY64G0VXMrKXQwt4VHoSuEbLR/IjVi4jLlAjU3gY0dVotmDoRUKn3YNkPgcXlgQl4t
         82OJGlRNZEadFCGJzC81ls9SLu1jh3CjV60ND0aBcM7ZdmPAggrhU/HhKb5EF14lpvOQ
         2qch9N1EPHmG2f2EHrJtQUvKuIn6G7KlcF+hsALLbf7WPKn8pS8ZoBj8EvJ0kNNh+8zd
         qwBy8qI+/BQPuWjxMa8stxYHxbYEZX90YC5J9tqQx3CfdYAuzka44+xQE09ThG6Ylr4p
         Jvru0qDhLaj7AfPT4lnxJd/wau3AppvDyGA/5+VIUfThH6Wmm0MMAwliNCVeryihe+4j
         68Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090881; x=1750695681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xlGbr7S7dkulxlPf5XLC+Ja0lhJQ4XwBOGvbFljsao=;
        b=b7d+a78HrfkJGTNr0sqvqGFzFoLQp/GVkcG5UR7nWSA1vMql/TlSfibqwrLLpF1cmH
         fak1eCKa/v0REEM6wCgmz6tEqpbU53yNaQeuzrH8HkQSbHfFBRBqOD8Cc051diKTZ3K/
         /45yOZYe/XV2xc/yin1sVxTZugwDM8v6z+ELXn2gkB7f38YRFsAqcYWADBInlAY5vfum
         /Cc0VTH7AEJolSWSyq4pLWznHxlBpURaGmGmNLHxdDuvW5OOZ6NuGvuszDxgybPfs1OO
         AMXzpfJRJO0PXm3QZXlmBbfUGBRCt8HSDpdDl7Q2MV4AAc7zxukZPbYZPDl1JDQv/tEf
         StYw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ijIGqLNbZaxmLa5bt7flovhB7MtX2XL43wm3zpBRAB43sTQGgeP8Z+1uwUZX6Y1Ka8JRQHC+YxN5nw==@vger.kernel.org, AJvYcCUq1TDoayq54whqomthOspH5MCrnNEwsMy+PVuzdftdiyezds1LEY9NXIhJ1dqVsHEv3HaMarE0uevgKnpcJIND@vger.kernel.org, AJvYcCX8hYPNB8tZwnn9XrRIH1seNP0yQ1JNZ6DuBVzgaKtaMIEWHKlCLAt8L1nCIA0zmY5ZVCnWv9ywOTSSTM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69feI4V5FKO3ysjB2xB5t/OMYbAEjhW4F/IstlYHVIMcWE8nH
	FkFXK1XShvQ3psJmJQzy3kkKNZyEA3zgUbmffvJaeftq9SHRcjV7BYBPj36W
X-Gm-Gg: ASbGncvreja9JiQFQLR2xnuu1t7VZOCk/lNuv4JOLPzo5yp9jdzKTYrSsiKeajxg3Xa
	xIqqwa9apnvND+RDwYQfsjguwuD6nshYNuSOhQ4BCDXngOz2ZanTVcrqGUnYWyB4fwMJCvx0sNE
	yM6JH5yYLdb50bLVAhnn7uWpuL3gjsjs9ovs+Y9stnBF+gO4BEddqfdb7OatnHrL01FRTEbhycW
	rKncIDRjcXcwlE8I3i8Q9EJhyLC9QbiMDHrhN1L++GkfJiblIzTWPAtg7DGaZFHLwr9oNVI4blh
	thjCIYV6wtERlMtuMzrHVLt44siYAX5JDCLUg+8+zoQa39cQK5h2VSbfTL4Y1eJJPRIDwLJeawj
	y1ozuS9LAKkMW08qhUwQi5bs=
X-Google-Smtp-Source: AGHT+IF7Gy6U2OL6gPix8g51SpcUE/2qYnFFOYPZXfOzRPgtiht0N+QO0UDM5lmm0Sw3NeYwiMvL/g==
X-Received: by 2002:a17:90b:1b48:b0:311:df4b:4b91 with SMTP id 98e67ed59e1d1-313f1ca77e4mr16887983a91.7.1750090881242;
        Mon, 16 Jun 2025 09:21:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c1b6d56bsm9952895a91.46.2025.06.16.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:20 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	ruanjinjie@huawei.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	kuniyu@google.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v5 2/6] vxlan: drop sock_lock
Date: Mon, 16 Jun 2025 09:21:13 -0700
Message-ID: <20250616162117.287806-3-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616162117.287806-1-stfomichev@gmail.com>
References: <20250616162117.287806-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We won't be able to sleep soon in vxlan_offload_rx_ports and won't be
able to grab sock_lock. Instead of having separate spinlock to
manage sockets, rely on rtnl lock. This is similar to how geneve
manages its sockets.

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c      | 35 ++++++++++++-----------------
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 18 ++++++---------
 3 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 97792de896b7..9d7249caf137 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1485,21 +1485,18 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 
 static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 {
-	struct vxlan_net *vn;
+	ASSERT_RTNL();
 
 	if (!vs)
 		return false;
 	if (!refcount_dec_and_test(&vs->refcnt))
 		return false;
 
-	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
-	spin_lock(&vn->sock_lock);
 	hlist_del_rcu(&vs->hlist);
 	udp_tunnel_notify_del_rx_port(vs->sock,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
 
 	return true;
 }
@@ -2847,26 +2844,23 @@ static void vxlan_cleanup(struct timer_list *t)
 
 static void vxlan_vs_del_dev(struct vxlan_dev *vxlan)
 {
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
+	ASSERT_RTNL();
 
-	spin_lock(&vn->sock_lock);
 	hlist_del_init_rcu(&vxlan->hlist4.hlist);
 #if IS_ENABLED(CONFIG_IPV6)
 	hlist_del_init_rcu(&vxlan->hlist6.hlist);
 #endif
-	spin_unlock(&vn->sock_lock);
 }
 
 static void vxlan_vs_add_dev(struct vxlan_sock *vs, struct vxlan_dev *vxlan,
 			     struct vxlan_dev_node *node)
 {
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	__be32 vni = vxlan->default_dst.remote_vni;
 
+	ASSERT_RTNL();
+
 	node->vxlan = vxlan;
-	spin_lock(&vn->sock_lock);
 	hlist_add_head_rcu(&node->hlist, vni_head(vs, vni));
-	spin_unlock(&vn->sock_lock);
 }
 
 /* Setup stats when device is created */
@@ -3291,9 +3285,10 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	unsigned int i;
 
-	spin_lock(&vn->sock_lock);
+	ASSERT_RTNL();
+
 	for (i = 0; i < PORT_HASH_SIZE; ++i) {
-		hlist_for_each_entry_rcu(vs, &vn->sock_list[i], hlist) {
+		hlist_for_each_entry(vs, &vn->sock_list[i], hlist) {
 			unsigned short type;
 
 			if (vs->flags & VXLAN_F_GPE)
@@ -3307,7 +3302,6 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 				udp_tunnel_drop_rx_port(dev, vs->sock, type);
 		}
 	}
-	spin_unlock(&vn->sock_lock);
 }
 
 /* Initialize the device structure. */
@@ -3537,12 +3531,13 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
 					      int ifindex)
 {
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_sock *vs;
 	struct socket *sock;
 	unsigned int h;
 	struct udp_tunnel_sock_cfg tunnel_cfg;
 
+	ASSERT_RTNL();
+
 	vs = kzalloc(sizeof(*vs), GFP_KERNEL);
 	if (!vs)
 		return ERR_PTR(-ENOMEM);
@@ -3560,13 +3555,11 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	refcount_set(&vs->refcnt, 1);
 	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
 
-	spin_lock(&vn->sock_lock);
 	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
 	udp_tunnel_notify_add_rx_port(sock,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
 
 	/* Mark socket as an encapsulation socket. */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
@@ -3590,26 +3583,27 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
 static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 {
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	bool metadata = vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA;
 	struct vxlan_sock *vs = NULL;
 	struct vxlan_dev_node *node;
 	int l3mdev_index = 0;
 
+	ASSERT_RTNL();
+
 	if (vxlan->cfg.remote_ifindex)
 		l3mdev_index = l3mdev_master_upper_ifindex_by_index(
 			vxlan->net, vxlan->cfg.remote_ifindex);
 
 	if (!vxlan->cfg.no_share) {
-		spin_lock(&vn->sock_lock);
+		rcu_read_lock();
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
 				     vxlan->cfg.dst_port, vxlan->cfg.flags,
 				     l3mdev_index);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
-			spin_unlock(&vn->sock_lock);
+			rcu_read_unlock();
 			return -EBUSY;
 		}
-		spin_unlock(&vn->sock_lock);
+		rcu_read_unlock();
 	}
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
@@ -4875,7 +4869,6 @@ static __net_init int vxlan_init_net(struct net *net)
 	unsigned int h;
 
 	INIT_LIST_HEAD(&vn->vxlan_list);
-	spin_lock_init(&vn->sock_lock);
 	vn->nexthop_notifier_block.notifier_call = vxlan_nexthop_event;
 
 	for (h = 0; h < PORT_HASH_SIZE; ++h)
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index d328aed9feef..6c625fb29c6c 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -19,8 +19,8 @@ extern const struct rhashtable_params vxlan_vni_rht_params;
 /* per-network namespace private data for this module */
 struct vxlan_net {
 	struct list_head  vxlan_list;
+	/* sock_list is protected by rtnl lock */
 	struct hlist_head sock_list[PORT_HASH_SIZE];
-	spinlock_t	  sock_lock;
 	struct notifier_block nexthop_notifier_block;
 };
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 186d0660669a..4ff56d9f8f28 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -40,11 +40,11 @@ static void vxlan_vs_add_del_vninode(struct vxlan_dev *vxlan,
 				     struct vxlan_vni_node *v,
 				     bool del)
 {
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	struct vxlan_dev_node *node;
 	struct vxlan_sock *vs;
 
-	spin_lock(&vn->sock_lock);
+	ASSERT_RTNL();
+
 	if (del) {
 		if (!hlist_unhashed(&v->hlist4.hlist))
 			hlist_del_init_rcu(&v->hlist4.hlist);
@@ -52,7 +52,7 @@ static void vxlan_vs_add_del_vninode(struct vxlan_dev *vxlan,
 		if (!hlist_unhashed(&v->hlist6.hlist))
 			hlist_del_init_rcu(&v->hlist6.hlist);
 #endif
-		goto out;
+		return;
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -67,23 +67,21 @@ static void vxlan_vs_add_del_vninode(struct vxlan_dev *vxlan,
 		node = &v->hlist4;
 		hlist_add_head_rcu(&node->hlist, vni_head(vs, v->vni));
 	}
-out:
-	spin_unlock(&vn->sock_lock);
 }
 
 void vxlan_vs_add_vnigrp(struct vxlan_dev *vxlan,
 			 struct vxlan_sock *vs,
 			 bool ipv6)
 {
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	struct vxlan_vni_group *vg = rtnl_dereference(vxlan->vnigrp);
 	struct vxlan_vni_node *v, *tmp;
 	struct vxlan_dev_node *node;
 
+	ASSERT_RTNL();
+
 	if (!vg)
 		return;
 
-	spin_lock(&vn->sock_lock);
 	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
 #if IS_ENABLED(CONFIG_IPV6)
 		if (ipv6)
@@ -94,26 +92,24 @@ void vxlan_vs_add_vnigrp(struct vxlan_dev *vxlan,
 		node->vxlan = vxlan;
 		hlist_add_head_rcu(&node->hlist, vni_head(vs, v->vni));
 	}
-	spin_unlock(&vn->sock_lock);
 }
 
 void vxlan_vs_del_vnigrp(struct vxlan_dev *vxlan)
 {
 	struct vxlan_vni_group *vg = rtnl_dereference(vxlan->vnigrp);
-	struct vxlan_net *vn = net_generic(vxlan->net, vxlan_net_id);
 	struct vxlan_vni_node *v, *tmp;
 
+	ASSERT_RTNL();
+
 	if (!vg)
 		return;
 
-	spin_lock(&vn->sock_lock);
 	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
 		hlist_del_init_rcu(&v->hlist4.hlist);
 #if IS_ENABLED(CONFIG_IPV6)
 		hlist_del_init_rcu(&v->hlist6.hlist);
 #endif
 	}
-	spin_unlock(&vn->sock_lock);
 }
 
 static void vxlan_vnifilter_stats_get(const struct vxlan_vni_node *vninode,
-- 
2.49.0


