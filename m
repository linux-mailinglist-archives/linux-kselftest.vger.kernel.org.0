Return-Path: <linux-kselftest+bounces-40517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F86B3F6AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268732021F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5B2E718D;
	Tue,  2 Sep 2025 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIESf+HV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CE2E6CAD;
	Tue,  2 Sep 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798008; cv=none; b=G++NOmmXEMX+wQa1NZOTHuP4DdtegyIpTanDhQswOHTQ6D6Pp8mD0hO3EOaOiuJ80iaU09WtBSBviaVaeoo95qZ86hhrlucPyf6+/ibVEcKMVtd+RsYiF5e8z9VpL8OyHMVXwyKHdRl6IqVYoKvQNk9RI4kswt2wDAF8pLHCPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798008; c=relaxed/simple;
	bh=fpxAMTh1DHFN9bdroAryNzz1TbRNMH5pMcaPuAnjYMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzkTlJnRyiUeH0b2YGAjRyEo+MX0YsZZlomSW0ZrfF3KJ2PMSKkmCmemL4IiuhTKdco940/47lvb0q2jx6S4UEc68AS2rp1QzZX8INBet1XdnFP+wfX5cyJgDGEI6YQ/Kuur1NKgUU8DRcxwPUNs23XUyGseLlAsBW4K7MT56VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIESf+HV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so3719255a91.0;
        Tue, 02 Sep 2025 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798005; x=1757402805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=bIESf+HV/+6JsKepdCJpZYZNJjUz9+dZfGgTkon+zF60+fLWy68ADjngP5MiG0gyWk
         lzuZjVag2X9zWOKtK7EcnKcE2FXePHQYbKCozvWgGdtveXUdy0O8nP8tPNPXutr3SRow
         Ea7lUKni2XyRH79xrqGfGcVSSZv7Ww9+rL10dBglZpClOag4MWkS6/BAc4tmQh7vEQAi
         CmNCYb4xU9TVM8Ei8P1/M2mxPZikNNxJ41MQVYkpPZ37dbBvNQq9PYh353ahWHOebNxb
         Hrl8u4S+tNR0cITa67br7mf97PaGHW3Az8UHrMenxFDNbHOP6eDfJN0p4g697Ikgxhp7
         wJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798005; x=1757402805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6NPvT6bQ/Fm1Ox6j1QOMXLS7IgmyQZhMktUnB9yevI=;
        b=C4splFLcSMagEtM2eGLnR1ICBjcwsSp9Ggzt5rYDItHNDGJfXAhoQuSQZrbHkPpomS
         mPOjkYAKUPdQoy4sVqjj+SU0IID+/euqTg78nMoqB/xiqYZ3Fb1hxWdwD26aHSAD8+tK
         6qZez9Xqg+pNkQog7sEMChBrAv0NoZ78Gvwsz5B0fCz+1bSTxgZhmm6IWSaXAaHEJvMi
         EPmpGa99pCG4jr83yGA8RHij8tdpqABDCyoFJ/uV/wI+BriPaYsEnXOuDqywFyZ1f8vu
         faFWeOvqgjrmCGNcZMuV54/CF1TkP08FU/fxKeCHbcu0PFC0c1WYUqycVWu4djV2i/5V
         VP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNEhemOA1ROEZ4uN9TwpbTobbIvFQs3Vt63ufUd49/6eEKJtRhvnT1EXrhVM6jTybgcfzsU7Cy0iHBtXQ7eE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjLJ2FyPAGHHFgYjDp/1FNVadBiM/UWCAuZQoxCS/sAjPukFi
	dExi/DUYRk4c27hZBOvFooNvdD4Sbtw9E+fMDykpMQgf9C3avDKhCddu36nHeZrbTmQ=
X-Gm-Gg: ASbGncv2LOLSXvelZ58Du7hjdyBXgeITs7PV9HAtSCgyAuLPU/t3zsi7QSQR/XPWnAk
	0Osqhheu4GbAacjGZ/2Vx8Baq1ChoIGRDuIheuWFeJWKoF6RiCFRtjk1fbab26b9T87hDpkTUPr
	BtlHoVd+mvpruh1JPslFTESDG2rR9Wle3BROu4+1MuRFO3Vd2u+zNJYhth6Gq0GZzzBKJcmFlV4
	s/r7MmC54WMw4k3E8NNHaDib9V8n4FpRYLixw6jGmLJhQNIqUH0Pzymn138Dd0ZvlEGwQUMdFOV
	N7iZ3Ua1Ni1OPNzBj3vFBjGz+qEE+N95POC2eSl9M4vk0hyXtoz+rERy43VdG2YAP5i9+hl5Ms5
	+ouEVmeHtStJ2quLmVlvHZ0CznbWJo56Gef48vUHZOw==
X-Google-Smtp-Source: AGHT+IGdU/ZAXvhK+gb4+6xvuoWstmZphUO60Sh4mLhsd+VaRlO2+ZRrPNUFkcLVJ4111t7W01Yt3g==
X-Received: by 2002:a17:90b:55c8:b0:314:2892:b1e0 with SMTP id 98e67ed59e1d1-328156e55d5mr13525247a91.34.1756798005409;
        Tue, 02 Sep 2025 00:26:45 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:45 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/5] team: use common function to compute the features
Date: Tue,  2 Sep 2025 07:26:00 +0000
Message-ID: <20250902072602.361122-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
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
 drivers/net/team/team_core.c | 73 ++----------------------------------
 1 file changed, 4 insertions(+), 69 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 17f07eb0ee52..018d876e140a 100644
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
@@ -1976,9 +1919,6 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 
 	err = team_port_add(team, port_dev, extack);
 
-	if (!err)
-		netdev_change_features(dev);
-
 	return err;
 }
 
@@ -1991,11 +1931,6 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 
 	err = team_port_del(team, port_dev);
 
-	if (err)
-		return err;
-
-	netdev_change_features(dev);
-
 	return err;
 }
 
@@ -2190,7 +2125,7 @@ static void team_setup(struct net_device *dev)
 
 	dev->features |= NETIF_F_GRO;
 
-	dev->hw_features = TEAM_VLAN_FEATURES |
+	dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER |
 			   NETIF_F_HW_VLAN_STAG_RX |
@@ -2994,7 +2929,7 @@ static int team_device_event(struct notifier_block *unused,
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


