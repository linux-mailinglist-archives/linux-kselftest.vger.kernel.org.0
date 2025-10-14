Return-Path: <linux-kselftest+bounces-43115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C11ACBD8134
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 918734FA326
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6A30F956;
	Tue, 14 Oct 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE4Gb+Wq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D830F945
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428975; cv=none; b=Er5IGonOyQTsA1SIn7zv1azPcV9wgL77hwV8oMFdpnymjReObngAvi729mEf4AlXmbIy0KN/1yEolXoHbXdDOD8B4SFpv8Ja/ByuATvXEBtk0aCz4It2HofJACP7/Cb8P6VBljora1eK03HLLTOvUVi2ZMOh4umWkMui0wCCrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428975; c=relaxed/simple;
	bh=v/wIJVHymXR0j0ByP0dl5kdKBXrbvxjnB4cnfrt0E4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRh68my64axbGjDGUFWTwY750pdMqeoMSTB45FfEmVW39iKCr42lUgTk22eyY9voDQ6H6mWNRkp2Ag4aBLDXIU55KD0ACmbOWVgHSm7LX4m1ERKiGF+pVB0m6hPcmPse4w5u4fqwdkLn0+oMf1WEPR2JS/HzTOp7Ul2dvUmlbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE4Gb+Wq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so5710713a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428973; x=1761033773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7prt04ADWx0fn0Z7pGOB9FoDOjfwgNqGHsIR96eCJc=;
        b=dE4Gb+WqI2j9zzJG2KBX6Shjz9lColDalE0S9m9zCytOZIJSzfAnGfkjdnLEx5llR6
         MESncMtZjhKm8UGAbq8J2p1N2v64AGMTm2eM7U9vKuewU18A64rE3ZLSk31jl8V4kOz7
         PqxznhGG3WQmEJqVVe3wNzP9bdTh5Fl5mENRgMOEL3QmjT8JcA8scGxB7KzCZ+oElHJz
         Vip29wTk0hbNJ0ckPR3zBnLHbFlFsdKG3tUm6CJXa54Cu7gZJd1t+4KzYeTkb/2kt+hE
         TDX2ak8MvUnun0mbEEV6cylhw/hcGVVamPzXP7sfa2ASsnuVKohCKrjPIqzzRwHxNVyx
         caHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428973; x=1761033773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7prt04ADWx0fn0Z7pGOB9FoDOjfwgNqGHsIR96eCJc=;
        b=g6OiRIzZMqNiNByza43RZs84QAo5vj3CZ+H0JNzgk7BL2qDgiWOxPe0dg8lvCkV0f9
         7+hhPf7MOODxPtbSbiTB7enMFglzvrzDW4zyRkWVok7PMTtgp1UD8NXH/zGabN/n9fHI
         fsa8tso8irxzmb6KrdA1SOPVQL875Ns+C5A2UZaFUD8k3CWpyZIIUY3zwdYx2Mu3ITP7
         UBu0FM7UbumeASbgMKfYcrnqTj6FBXdEhjo99HlOLay0qsdbkYZGze8c6zpiyJMOPTT5
         l8luplHFq1kxVYPaVMhvliFrdMUOQ0t2UNW/BqYXDne2Tjn9RVPF6mPaF484JTz/TaGd
         7gZw==
X-Forwarded-Encrypted: i=1; AJvYcCV89s/gaEUpnmJnc1wyz9SnP9u0c5e275R95Cm88+Ag1H3l07i872o/lY5BzcsFT9bCruNR4stuS9MQW6xX298=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwH9HTjsuFkLoVk+dMVA/0ZKTvrC5NSW1RxIyl675KO3/qtCKb
	AJXyPpNyg+gDJR8s7ruIngnA4yDkoV9y16BdJC83xw6elTGX4pEBs5Mw
X-Gm-Gg: ASbGncsSOhZ/7N0E+nAp2QJAjwVLF7334ex5LK9ZdZo64z4EuQp0175MV8xBJ1F6UAt
	vdjPaaZNuz8OfwMHInxGP7iabX0uzGKIDNSwVfbz61C6IeppA6Ujlul3PyEvyxTZ65ww5xg5AMj
	Wg+6FJip4LlK9Jknb1qXeXsGRb/srkpQrt06MHcEip+XykCX5faPS19ZdYXv4mziN1D3kYfNMPy
	3H4hk0dJjxPtZLJ+BgxzgD/8eGlTS9OGNp/YXOrlD/vz1wgb+xY4TKf0ycj3cl98HtUi8ay9qX9
	NXLItkI/u4/J82VUzC8bhV7WcbwD8FpVTWD8mdl/iuxN3KXgaIwc+97XBv8PS8Q6P8YN7aLA+Et
	/7yxURXXq+kjp59keO5+IbdEjZI6387XV8V1eNPATCnjbvg==
X-Google-Smtp-Source: AGHT+IEVofAHMNuGc7LSVEwbMFdV5baxM3Yag0mW/ybZvJCPq+vu8y2XQS23VTKmvMmHIC3b+TxwEw==
X-Received: by 2002:a17:90b:4a52:b0:332:84c1:31de with SMTP id 98e67ed59e1d1-33b513ced6emr30004724a91.25.1760428972626;
        Tue, 14 Oct 2025 01:02:52 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:52 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 3/4] team: use common function to compute the features
Date: Tue, 14 Oct 2025 08:02:16 +0000
Message-ID: <20251014080217.47988-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014080217.47988-1-liuhangbin@gmail.com>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helper netdev_compute_features_from_lowers() to compute the
team device features. This helper performs both the feature computation
and the netdev_change_features() call.

Note that such change replace the lower layer traversing currently done
using team->port_list with netdev_for_each_lower_dev(). Such change is
safe as `port_list` contains exactly the same elements as
`team->dev->adj_list.lower` and the helper is always invoked under the
RTNL lock.

With this change, the explicit netdev_change_features() in
team_add_slave() can be safely removed, as team_port_add()
already takes care of the notification via
netdev_compute_features_from_lowers(), and same thing for team_del_slave()

This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
features.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 83 +++---------------------------------
 1 file changed, 6 insertions(+), 77 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..03df6a06e0b8 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -982,63 +982,6 @@ static void team_port_disable(struct team *team,
 	team_lower_state_changed(port);
 }
 
-#define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
-			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
-			    NETIF_F_GSO_ENCAP_ALL)
-
-#define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
-
-static void __team_compute_features(struct team *team)
-{
-	struct team_port *port;
-	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
-	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-
-	rcu_read_lock();
-	if (list_empty(&team->port_list))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	enc_features = netdev_base_features(enc_features);
-
-	list_for_each_entry_rcu(port, &team->port_list, list) {
-		vlan_features = netdev_increment_features(vlan_features,
-					port->dev->vlan_features,
-					TEAM_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  port->dev->hw_enc_features,
-						  TEAM_ENC_FEATURES);
-
-		dst_release_flag &= port->dev->priv_flags;
-		if (port->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = port->dev->hard_header_len;
-	}
-done:
-	rcu_read_unlock();
-
-	team->dev->vlan_features = vlan_features;
-	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				     NETIF_F_HW_VLAN_CTAG_TX |
-				     NETIF_F_HW_VLAN_STAG_TX;
-	team->dev->hard_header_len = max_hard_header_len;
-
-	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-}
-
-static void team_compute_features(struct team *team)
-{
-	__team_compute_features(team);
-	netdev_change_features(team->dev);
-}
-
 static int team_port_enter(struct team *team, struct team_port *port)
 {
 	int err = 0;
@@ -1300,7 +1243,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
-	__team_compute_features(team);
+	netdev_compute_features_from_lowers(team->dev, true);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_features_from_lowers(team->dev, true);
 
 	return 0;
 }
@@ -1970,33 +1913,19 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 			  struct netlink_ext_ack *extack)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_add(team, port_dev, extack);
-
-	if (!err)
-		netdev_change_features(dev);
-
-	return err;
+	return team_port_add(team, port_dev, extack);
 }
 
 static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
 	struct team *team = netdev_priv(dev);
-	int err;
 
 	ASSERT_RTNL();
 
-	err = team_port_del(team, port_dev);
-
-	if (err)
-		return err;
-
-	netdev_change_features(dev);
-
-	return err;
+	return team_port_del(team, port_dev);
 }
 
 static netdev_features_t team_fix_features(struct net_device *dev,
@@ -2190,7 +2119,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2923,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_features_from_lowers(port->team->dev, true);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1


