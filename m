Return-Path: <linux-kselftest+bounces-41026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB1DB4A505
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19238174ADE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E84248868;
	Tue,  9 Sep 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTdKQ8SI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD5238C36;
	Tue,  9 Sep 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405970; cv=none; b=shH/tOmwPHAX4XB80+jeQ+EKZ3z4Yc2xqIHHvSvp9SJ55cej867UegGHvsnMrzGrImjEl6Q6Ql0khhEEQWTZ9eZpFiJu3KfrM9UR8gcOU5QwCyBRrgy4XXtB8qMaML2uKE3CO6gseo8Rdyn4OCzABHgvLsZAfU1MmB9Xj4Vt7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405970; c=relaxed/simple;
	bh=Eu9oo0GclufWi8CUOE7sIIQ2BCgIf/5MYzSwb+NM0W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNZCnkPBR09FgcqUrDm1VMG3NJp8egFLwU816lcCMtrsK+I3Kxpc9lBiqk/FHg5aSV2XbcWmrn5qMhQhn9RdeF4gbuqU/ftH6+9KnF3l72b0TH6cuJt9DJh0tVs8l+9GKElDddQ88xrZct9+BcB2sxTJd1XOmLqbhwVhD1aOcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTdKQ8SI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf605b1so18939105ad.2;
        Tue, 09 Sep 2025 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405967; x=1758010767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUUrBUErthGY79KnwDuuvCi+ucUhohR/OZimf4m8Bpc=;
        b=LTdKQ8SIpe6LM0zaX3JukFhhaeYRuqjpQXmTp6MpGhR0ZqV2hEQe8tR1HJ+2yXYX1G
         CH0SNjI9WPHyHbKq3QnMh10aAW+2QTXl6hysEfw9y3oxN45zhKRHvF5xDZtKjul7Uffe
         7bRXUMxTK8yXjSPn3trFAOLbtba0G1ZKop9bvrhEuL2su1ByAMODiGciYpALeMbGkqFk
         +vGxPXrzsaqN+xq38po9dtSkzr3A6+tdsBSKlmgZUztD7m14deufo2m1l0Uefhv1XNkL
         nA74QV7ZtZbU/9UeO1kVpraW8tc412Iq5GJFI3sn86M8ampCKIVos7zwLfT7UOAloJBN
         n/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405967; x=1758010767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUUrBUErthGY79KnwDuuvCi+ucUhohR/OZimf4m8Bpc=;
        b=Q0bSnXTBFThElb8xQJNMaIroZuWBXqVx7S12nnyzG5KnsZlcD2+gqvaT/k9xJdnlVv
         xUBzMwCdtzJnWG0ZlgjgaxnWIO8u2MrQTY2KLBdi1eLuDqKA/po2MQwxOHkRtkI/j86G
         eElKOpdpwUxZwrti+lvcbeNZnd47c5zOwyMkVA072mqmqOU5x/DsKVJ4w8ihkou2YI4v
         fbf7oFl4JDLGScg8LAMLkNjJADri6IU6lT3EPPrrngWYLtK98gG1QD6AI6QUtxiip4Jy
         91i1KIUGWoLb8LPEyTDpv8FhooQnvF5jJjEfoUKuxkiAf/9DeWzONIO1E0dxbF2FyKkK
         GVpw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqSj0W7T2BPdgcQrbaHQis7rDW8VFEFY0mhrcxeJSbC8P2CEZdinyjxXGz/UDX0AhDJILa1w1iL2tOr1uN2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbz74kKDukW7NoIr9exDtFFbUTmUuxayXydgtZLgnELPa3xTwx
	GkoWZVFyPfULWtWXmyoptoWOxv03qCfzKZeba0RhXaZwRkJaHMA3fL7iWf5yF1ijfJo=
X-Gm-Gg: ASbGncsEZpZFIu63odoYFhwLfrkw+/Tr6siIs4grjMde09AHTJ4xJqm2VqSG2pEgS1g
	ruypE6lqY/Zmxc3U7ejlNBcp6TVJv6XdmrZHWjce6fYqdzZ4jWM9Tq73VRqdS02Jw0Vvxe6adiO
	VmpOQOGOuiGIFWKIY3f/YTMGS1g8EYtbzmWwVPUAChDv+9MROlSMoC4d5uhZB6/O/i3Xw9lHot8
	1eHkyKHbutOzN2Bn5mf434rsG1hojzztBIRKU/qYdEMNKVPpdABlV07pxAqcpjqWyH8CYz/Fkh0
	0neTgD2TvdSsG55T/MztJsNTv4wPeyLO2lKZ8b0qH3q9c3/AxV0NXT5QXVQZb8gQrdrxYZ1xxfR
	phZXkbIh1alEEpUtTF6855j7P9efICsK2y2MtTQ/umAqheO1j7BmF
X-Google-Smtp-Source: AGHT+IEoDozETSAVhjvVYDHFH2NyPH5nJWHyVg1KPi7bNvofIFUX5MaX+Nz0VReUXMgaBo1MCtEA6g==
X-Received: by 2002:a17:902:d54a:b0:24f:b709:b672 with SMTP id d9443c01a7336-2516da06c7cmr159226165ad.19.1757405967020;
        Tue, 09 Sep 2025 01:19:27 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:26 -0700 (PDT)
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
Subject: [PATCHv3 net-next 3/5] team: use common function to compute the features
Date: Tue,  9 Sep 2025 08:18:50 +0000
Message-ID: <20250909081853.398190-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909081853.398190-1-liuhangbin@gmail.com>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
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
 drivers/net/team/team_core.c | 78 +++---------------------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..c5fbe392fc62 100644
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
+	netdev_compute_features_from_lowers(team->dev);
 	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
@@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
 	dev_set_mtu(port_dev, port->orig.mtu);
 	kfree_rcu(port, rcu);
 	netdev_info(dev, "Port device %s removed\n", portname);
-	__team_compute_features(team);
+	netdev_compute_features_from_lowers(team->dev);
 
 	return 0;
 }
@@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 	err = team_port_add(team, port_dev, extack);
 
-	if (!err)
-		netdev_change_features(dev);
-
 	return err;
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
@@ -2190,7 +2122,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2926,7 @@ static int team_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
 			port->team->notifier_ctx = true;
-			team_compute_features(port->team);
+			netdev_compute_features_from_lowers(port->team->dev);
 			port->team->notifier_ctx = false;
 		}
 		break;
-- 
2.50.1


