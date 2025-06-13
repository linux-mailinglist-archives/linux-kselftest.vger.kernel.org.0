Return-Path: <linux-kselftest+bounces-34963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03998AD965D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71CA17BD72
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5608B259CA5;
	Fri, 13 Jun 2025 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPG13Iva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1825393B;
	Fri, 13 Jun 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846812; cv=none; b=SXEezqeoDG833oRMDWghpnS3CRjOf1X5ECgYbK8AFkj28CQHcGG4jVJGgq53QJGpt9B6rcIfu9oA/hMpuFDpIxEHvhJz4DM0uLAHdvokgGfesIHf17Gow7nRqEuxXB/jH8PZmGOcvSqEjP2M8+T356RWSf0CVv1kNhloH+E/Y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846812; c=relaxed/simple;
	bh=oeGkPPqUa3oXQUEhmOMhhqRXMCeGtWKIAT1/uhAceNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD71zqFWvEAM9/H3/ipwlkVsTr51/eTqf3CmWiQbGoELPT5FM80xfhcCz3kQQc3XwwXyTA+98EtQ2W1qnTz+jV3/lS6pAnsftLGnTL21RAqsrFF71D4ttbr1sbkii0oDje/cMeDJi7NxTlcy9L2ahMw56nJkItY8BlM58PiVPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPG13Iva; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1396171fb1so1769107a12.2;
        Fri, 13 Jun 2025 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846809; x=1750451609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1eKBxLffGBEe4AlTfaor7d8YdO+Y5hGW4DOpCWQYdg=;
        b=QPG13Ivaq3dA2FHHZ3nvFbFbfDye7BFZRpxe3nBPxyPGZYqDzygjC/GQSGQelszog9
         hmn7QlNGFhKHTtdyMfvJEabipfx2sYpLFULv7szy2fsm8gqbC77/6goKx7dodFQBkiwq
         AwQXMAbCs6AQ7OtEiaTbhQzDA9NnE/l+Urlrk11+m+NLu/JiZPyGtHQdL6XD/DZJFMqg
         LY2PWZasVTB7fatpr6QIPHxRxGbRa+UAnnBRLu/ofKBGfpLC0iEP7e8/WimIsa37u4zh
         GcYXh1WUqhYkKclW+aTSLA6fJjjONDUSu69Z4yg42p2FcYqx79CsETgbVnHAsx1iAQWw
         g9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846809; x=1750451609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1eKBxLffGBEe4AlTfaor7d8YdO+Y5hGW4DOpCWQYdg=;
        b=MpvUZR36SXWyCQUhcvZew/jK5luiQvPLdTdAjHfpVCYix4xun8gc3wcjBb5AnYk9lT
         OsUnj1mdeO9KoXIlIyDaR2F7BdQGSy6zI7TGVkL3y1MO+hB98eWglDKIE81DL/LazmWW
         ANLnOGGt/WJ6TvyjH0wCayfwPcD5bAwSXmPykIypaTgy3ohiUtwVjp4BKanN6AjuavRe
         AewspA0QAUzlD+iS0Muw6Z0cxdOpQq+nE2Sww7y9w8GJQdTIp4uWyTbhfXDdrMPX2SSR
         gXjRXxyeTivDEpRtdJBYYUe1eWRZnyXYcabLaz5zZ/D/A5Wv2X/59LoYfFoddDeEaUXm
         RaGg==
X-Forwarded-Encrypted: i=1; AJvYcCUd+CQy6XoqLsy/U963N7Dmn1TjckMgKmhx39o+52/T7ebYx2PgcJKpscEPWeLKJiAD+DCXX72iYae390k=@vger.kernel.org, AJvYcCVr55LEOWhwWwYjd40w93cavXip0VAUW/TIZ5q4OxVVtIKppZSExKo64+87pYuNn7bsLGbNFQqzKZbVSA==@vger.kernel.org, AJvYcCWNkdnv2VgXI6W2N3mV8nwbS9FDIT9E8RewU6hqfaF1SZnGvwhHNdkN+mitM6poI1sF3CXC0hpAY0I6UfWqSDf9@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsUd9bUncijlXt/WmZ4ULRcCy9I69FTVuC8SJsNoI0zI/iId+
	WaUN6ro9ak1bEmO3ohWQlnn/j4sWpXye71Pfd0zwaFNtt99bEKivJyQKEgzg
X-Gm-Gg: ASbGnctVrcidQtdW5iu4kr4a9o6nA5YqfK9D4BsjcFpo1P7iMGcGHFGi8BR2TYIAXws
	5suiNUqzsOnTAvUtQnpiGMvWEngEPNkcwBtDbi71JWmeOEFBgHi3sMI7vNt815u1E35vK5hwSHS
	e8FZZAaTYRynXvCHYOkD9z/o0sNHXMCYfUIYI5yKFPf4WSIYsRBROxySR9cHellxd4ul/rqW67N
	irogs2yPShhbYyQG3pOKxF/yUUwybqwblgoKUo405yJO5cPsOJXQFXM7ps8izwh7cP9HD1GU/W2
	sq5j9jtU1jHUmAFw3V08dpzyn7lEhDjA7drYHL1O3pDGlUMVqAx0rVikz/4PM5Z+3i65B6xHNOX
	0GHMDwHrodfEwAuGKBpweQDU=
X-Google-Smtp-Source: AGHT+IFzjhuaffrLRD3SnaPHtjYEGlUXNW0DyfRHXKa+uMaTmfULw+e9Y+axbj6oEJJJ9nwLktaA9A==
X-Received: by 2002:a05:6a21:6191:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-21fbd4d6179mr1086802637.15.1749846809450;
        Fri, 13 Jun 2025 13:33:29 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900051a6sm2084709b3a.42.2025.06.13.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/6] vxlan: drop sock_lock
Date: Fri, 13 Jun 2025 13:33:21 -0700
Message-ID: <20250613203325.1127217-3-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613203325.1127217-1-stfomichev@gmail.com>
References: <20250613203325.1127217-1-stfomichev@gmail.com>
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
 drivers/net/vxlan/vxlan_core.c      | 34 +++++++++++++----------------
 drivers/net/vxlan/vxlan_private.h   |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c | 18 ++++++---------
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 97792de896b7..01362e98325c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1487,19 +1487,19 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 {
 	struct vxlan_net *vn;
 
+	ASSERT_RTNL();
+
 	if (!vs)
 		return false;
 	if (!refcount_dec_and_test(&vs->refcnt))
 		return false;
 
 	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
-	spin_lock(&vn->sock_lock);
 	hlist_del_rcu(&vs->hlist);
 	udp_tunnel_notify_del_rx_port(vs->sock,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
-	spin_unlock(&vn->sock_lock);
 
 	return true;
 }
@@ -2847,26 +2847,23 @@ static void vxlan_cleanup(struct timer_list *t)
 
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
@@ -3291,9 +3288,10 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
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
@@ -3307,7 +3305,6 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 				udp_tunnel_drop_rx_port(dev, vs->sock, type);
 		}
 	}
-	spin_unlock(&vn->sock_lock);
 }
 
 /* Initialize the device structure. */
@@ -3537,12 +3534,13 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
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
@@ -3560,13 +3558,11 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
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
@@ -3590,26 +3586,27 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 
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
@@ -4875,7 +4872,6 @@ static __net_init int vxlan_init_net(struct net *net)
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


