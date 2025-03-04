Return-Path: <linux-kselftest+bounces-28125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186CA4D020
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B493ABF42
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21D5FB95;
	Tue,  4 Mar 2025 00:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HjQWdcUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA11F03FA
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048491; cv=none; b=AkvO6RaYs0oW8SHnRwSQRnOfHCQmugE6vEqVRFzr/JtMNfHHMhizcQQPeRMvogp95C3A5oDej0NnOjJ95oMKJAyEIUc+OlJzSqVlHLG8zOHh5ku9vAxEpBHWyfA22ErPgDf239N3VGX9mvCNxmzAX45CtRvxw9S9xVwJgiDdtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048491; c=relaxed/simple;
	bh=McYEaKCFEjQbn8AusBjnUOxx+IQf3NjJNiLhHgAneh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVpG3eLlIAGEpy52slUc92e+ZJMOVR4/TYyD1XnYUTIl+04cDzEm7qTORCr07p9RdDuYjF3C/UC6hfQNFbF0EN97M+HojusH75MeqmCy4X+o3wNsbKFWL3JgpvorwKj205q4Hlob4Rj7Fl+95NA1UvKpK9KEmH7kaW5B29TU/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HjQWdcUh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390e3b3d432so3444649f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048486; x=1741653286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTFyr3fjgK0kcPd3wfWfD7o+GMkxXYPNn+u7MdP5zMg=;
        b=HjQWdcUh1D/LzorylN2mH2QAoLqG1aT5qZ9P4R4G8X6s2Hl2KuisQDTnWgKIWx1Plu
         TdLbXdieWkvq8YIzo54jwC9HXlJlF5Jng6hXndYDwTiXQwhKhqE4zjB3E20ScsxK6EKe
         xT4DB2Po7YeW3zStKF2jK0/BiioCA6bXvWp5CVzD1pwrkcA4625NS4KLNT90eW9IPiER
         iusuxnn5JxWxr4EaBC2qoZiqaMkSQD1xgGl3m/ibkV8goU0JY9oPjzl9gS05wh5E+YYa
         dNiTpEfPLHNJ3tR/CkDmKRjHBR1LuixkeLrsw86jX6UqtdjzywTu4fFEPFzpXk7lQ6nt
         yshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048486; x=1741653286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTFyr3fjgK0kcPd3wfWfD7o+GMkxXYPNn+u7MdP5zMg=;
        b=VreZrKzvAskP2JnHl7cKmgMrcc0FisiaQINV+vlGP22IF6mliV3xB6aqswBYHIM8b1
         X8zf5ig6F2ZCsj93fRm/GCPIB5KRDMz9Am2Je4+RbIixsOndSRSPWkd2r2m3NxOCAdDV
         UmRgdAmSZzVTW78dkVez/SMBYG+SWS3IuLU6cSmyMDhO284YRTbEEwy0z8cIrZBoSnf1
         6+bnHoE+KVtf8A9mxpGHKFUAVH+8z+svLt0aL9jvIEJBADCssUB8227zbRQRT0gwb77a
         o8LECqoDcRZ+a4TnKKb+gb3U9b9nnHvYd8Rva6twsh+OQHof4DNKKdqwOvduyFpnwKE7
         yFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQui57ntFBWUNi9MefmqHhQ3Q92mW8iGmPoVR1AqVjnqKs41GwUtr6p+/EZ8YtsFHMsi8cQkcqJgkIpSqPag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9fPUOn/4p7OfsuFh1lrRdma0+BfH1eXNvNOO3o5uVrhnr5n7
	vHIl9tf3nRtbaeYorPxfDMgBY+YKq+Qdi/3t4hlhzn4CAYKAiTWxNGNOoAv2TmQ=
X-Gm-Gg: ASbGncuxqMgaeu1kqSIJo5Qa9P7Sbpl0Zj1ljaGxdo4qnYUJPjEh645B29oa1NCi0Jq
	jiFlSyglFpwApDct9d93hIRctQhKNhEEwpMabDiOQoltSOPiB5eYAMxB05QsheeA+RCdPySIY1l
	mYMQkhUIIxmzACnKU5maNxaWWw5iIMQzdzZ39meWcTwTihXLupmp0MSQvQ2cRWabjbvrjb2nRfi
	E/A2I53nBvFkqeKdM/SSEUmCZOoD1Ptgqk0sg5QJgmMPIbPALvxFDlQsROnmHdk/4/mmbYaKc9L
	7LPRxNKFrMBvHwet5ggGQ3tUypD3outBrvOaVZ+zzg==
X-Google-Smtp-Source: AGHT+IHMwV60jceKnITK1JOH2ka+bgBUpOvOuQAdE5Cyq6hPN+c0Tom3J7lS5Z9GapIFVt3hDJv1WQ==
X-Received: by 2002:a05:6000:23c7:b0:38f:218c:f672 with SMTP id ffacd0b85a97d-390eca41904mr8593496f8f.41.1741048486021;
        Mon, 03 Mar 2025 16:34:46 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:45 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:44 +0100
Subject: [PATCH v21 14/24] ovpn: implement multi-peer support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-14-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14855; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=McYEaKCFEjQbn8AusBjnUOxx+IQf3NjJNiLhHgAneh0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPS1UNwCsQkWNV+1a76E4sVWoBo/OLnpwO8
 /UkShahUUKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 hzHTB/4mODA5SEBlHQcT27jGEwxaY8g3y4yxs1O3BeXKp1E4bSxtdZEkspryphkTPX8/a223Zog
 1KFjVHH47rHR5nE9L33jbH0sGShFYRxW5KawbxsUeHM6Pcgvpk7FMUkEf8RtR7zqfwYahVuTe9E
 swwtOGVskReeiYj14zKnFh3JA5oObanTVpLAi/sfC6MOti89RvhBiLCMP5MnJwynYHKoZEQojRK
 9WBpo/fC0CVkydgex8jnm1Ypj2llKQfSjKgft6iQu9FzMUImA+FRCjXRasp/lxT064f5YxtpHbA
 u6zpyvxI2h8LdoD/zDHntRhzKPbWspWmCRXQ6uWKPb4n8Jcv
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

With this change an ovpn instance will be able to stay connected to
multiple remote endpoints.

This functionality is strictly required when running ovpn on an
OpenVPN server.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c     |  64 +++++++++++++--
 drivers/net/ovpn/ovpnpriv.h |  19 +++++
 drivers/net/ovpn/peer.c     | 189 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/peer.h     |  12 ++-
 drivers/net/ovpn/udp.c      |   4 +-
 5 files changed, 272 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 89b03f45dbc79c5de1f3c62ac9ef229acdc98d3e..333a025a69094f1be3fb0a7a934da0cdb5abdcde 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -25,11 +25,66 @@
 #include "tcp.h"
 #include "udp.h"
 
+static void ovpn_priv_free(struct net_device *net)
+{
+	struct ovpn_priv *ovpn = netdev_priv(net);
+
+	kfree(ovpn->peers);
+}
+
+static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
+{
+	struct in_device *dev_v4;
+	int i;
+
+	if (ovpn->mode != OVPN_MODE_MP)
+		return 0;
+
+	dev_v4 = __in_dev_get_rtnl(ovpn->dev);
+	if (dev_v4) {
+		/* disable redirects as Linux gets confused by ovpn
+		 * handling same-LAN routing.
+		 * This happens because a multipeer interface is used as
+		 * relay point between hosts in the same subnet, while
+		 * in a classic LAN this would not be needed because the
+		 * two hosts would be able to talk directly.
+		 */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(ovpn->dev), SEND_REDIRECTS) = false;
+	}
+
+	/* the peer container is fairly large, therefore we allocate it only in
+	 * MP mode
+	 */
+	ovpn->peers = kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
+	if (!ovpn->peers)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ovpn->peers->by_id); i++) {
+		INIT_HLIST_HEAD(&ovpn->peers->by_id[i]);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr4[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_vpn_addr6[i], i);
+		INIT_HLIST_NULLS_HEAD(&ovpn->peers->by_transp_addr[i], i);
+	}
+
+	return 0;
+}
+
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
+	int err = gro_cells_init(&ovpn->gro_cells, dev);
 
-	return gro_cells_init(&ovpn->gro_cells, dev);
+	if (err < 0)
+		return err;
+
+	err = ovpn_mp_alloc(ovpn);
+	if (err < 0) {
+		gro_cells_destroy(&ovpn->gro_cells);
+		return err;
+	}
+
+	return 0;
 }
 
 static void ovpn_net_uninit(struct net_device *dev)
@@ -100,6 +155,8 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->netdev_ops = &ovpn_netdev_ops;
 
+	dev->priv_destructor = ovpn_priv_free;
+
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
@@ -196,10 +253,7 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 
 		netif_carrier_off(dev);
 		ovpn->registered = false;
-
-		if (ovpn->mode == OVPN_MODE_P2P)
-			ovpn_peer_release_p2p(ovpn, NULL,
-					      OVPN_DEL_PEER_REASON_TEARDOWN);
+		ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 2e3f4baf305f0b37b474d7b7d94751aa4af8a2ea..b26ad97215a3d42242ba349b348c2749f570797c 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -15,12 +15,30 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+/**
+ * struct ovpn_peer_collection - container of peers for MultiPeer mode
+ * @by_id: table of peers index by ID
+ * @by_vpn_addr4: table of peers indexed by VPN IPv4 address (items can be
+ *		  rehashed on the fly due to peer IP change)
+ * @by_vpn_addr6: table of peers indexed by VPN IPv6 address (items can be
+ *		  rehashed on the fly due to peer IP change)
+ * @by_transp_addr: table of peers indexed by transport address (items can be
+ *		    rehashed on the fly due to peer IP change)
+ */
+struct ovpn_peer_collection {
+	DECLARE_HASHTABLE(by_id, 12);
+	struct hlist_nulls_head by_vpn_addr4[1 << 12];
+	struct hlist_nulls_head by_vpn_addr6[1 << 12];
+	struct hlist_nulls_head by_transp_addr[1 << 12];
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @registered: whether dev is still registered with netdev or not
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
  */
@@ -29,6 +47,7 @@ struct ovpn_priv {
 	bool registered;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
 };
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 0fe5333c6b8104913526dacc4d7d2260b97f62aa..bed2e591c000c4efecdcd92db484e590f97f9f7f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -9,6 +9,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/list.h>
+#include <linux/hashtable.h>
 
 #include "ovpnpriv.h"
 #include "bind.h"
@@ -280,7 +281,19 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 			     enum ovpn_del_peer_reason reason,
 			     struct llist_head *release_list)
 {
+	lockdep_assert_held(&peer->ovpn->lock);
+
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		/* prevent double remove */
+		if (hlist_unhashed(&peer->hash_entry_id))
+			return;
+
+		hlist_del_init_rcu(&peer->hash_entry_id);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		break;
 	case OVPN_MODE_P2P:
 		/* prevent double remove */
 		if (peer != rcu_access_pointer(peer->ovpn->peer))
@@ -292,8 +305,6 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 		 */
 		netif_carrier_off(peer->ovpn->dev);
 		break;
-	default:
-		return;
 	}
 
 	peer->delete_reason = reason;
@@ -357,6 +368,89 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	return match;
 }
 
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
+
+/**
+ * ovpn_peer_add_mp - add peer to related tables in a MP instance
+ * @ovpn: the instance to add the peer to
+ * @peer: the peer to add
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
+{
+	struct sockaddr_storage sa = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+	struct ovpn_bind *bind;
+	struct ovpn_peer *tmp;
+	size_t salen;
+	int ret = 0;
+
+	spin_lock_bh(&ovpn->lock);
+	/* do not add duplicates */
+	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
+	if (tmp) {
+		ovpn_peer_put(tmp);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	bind = rcu_dereference_protected(peer->bind, true);
+	/* peers connected via TCP have bind == NULL */
+	if (bind) {
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			sa4 = (struct sockaddr_in *)&sa;
+
+			sa4->sin_family = AF_INET;
+			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+			sa4->sin_port = bind->remote.in4.sin_port;
+			salen = sizeof(*sa4);
+			break;
+		case AF_INET6:
+			sa6 = (struct sockaddr_in6 *)&sa;
+
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = bind->remote.in6.sin6_addr;
+			sa6->sin6_port = bind->remote.in6.sin6_port;
+			salen = sizeof(*sa6);
+			break;
+		default:
+			ret = -EPROTONOSUPPORT;
+			goto out;
+		}
+
+		nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
+					   salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+	}
+
+	hlist_add_head_rcu(&peer->hash_entry_id,
+			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
+					      sizeof(peer->id)));
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr4,
+					   &peer->vpn_addrs.ipv4,
+					   sizeof(peer->vpn_addrs.ipv4));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
+	}
+
+	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
+		nhead = ovpn_get_hash_head(ovpn->peers->by_vpn_addr6,
+					   &peer->vpn_addrs.ipv6,
+					   sizeof(peer->vpn_addrs.ipv6));
+		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
+	}
+out:
+	spin_unlock_bh(&ovpn->lock);
+	return ret;
+}
+
 /**
  * ovpn_peer_add_p2p - add peer to related tables in a P2P instance
  * @ovpn: the instance to add the peer to
@@ -399,11 +493,42 @@ static int ovpn_peer_add_p2p(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 {
 	switch (ovpn->mode) {
+	case OVPN_MODE_MP:
+		return ovpn_peer_add_mp(ovpn, peer);
 	case OVPN_MODE_P2P:
 		return ovpn_peer_add_p2p(ovpn, peer);
-	default:
-		return -EOPNOTSUPP;
 	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_peer_del_mp - delete peer from related tables in a MP instance
+ * @peer: the peer to delete
+ * @reason: reason why the peer was deleted (sent to userspace)
+ * @release_list: list where delete peer should be appended
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_del_mp(struct ovpn_peer *peer,
+			    enum ovpn_del_peer_reason reason,
+			    struct llist_head *release_list)
+{
+	struct ovpn_peer *tmp;
+	int ret = -ENOENT;
+
+	lockdep_assert_held(&peer->ovpn->lock);
+
+	tmp = ovpn_peer_get_by_id(peer->ovpn, peer->id);
+	if (tmp == peer) {
+		ovpn_peer_remove(peer, reason, release_list);
+		ret = 0;
+	}
+
+	if (tmp)
+		ovpn_peer_put(tmp);
+
+	return ret;
 }
 
 /**
@@ -446,6 +571,9 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 
 	spin_lock_bh(&peer->ovpn->lock);
 	switch (peer->ovpn->mode) {
+	case OVPN_MODE_MP:
+		ret = ovpn_peer_del_mp(peer, reason, &release_list);
+		break;
 	case OVPN_MODE_P2P:
 		ret = ovpn_peer_del_p2p(peer, reason, &release_list);
 		break;
@@ -463,8 +591,8 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
  * @sk: if not NULL, release peer only if it's using this specific socket
  * @reason: the reason for releasing the peer
  */
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
-			   enum ovpn_del_peer_reason reason)
+static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
+				  enum ovpn_del_peer_reason reason)
 {
 	struct ovpn_socket *ovpn_sock;
 	LLIST_HEAD(release_list);
@@ -490,3 +618,52 @@ void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 	ovpn_peer_remove(peer, reason, &release_list);
 	unlock_ovpn(ovpn, &release_list);
 }
+
+static void ovpn_peers_release_mp(struct ovpn_priv *ovpn, struct sock *sk,
+				  enum ovpn_del_peer_reason reason)
+{
+	struct ovpn_socket *ovpn_sock;
+	LLIST_HEAD(release_list);
+	struct ovpn_peer *peer;
+	struct hlist_node *tmp;
+	int bkt;
+
+	spin_lock_bh(&ovpn->lock);
+	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
+		bool remove = true;
+
+		/* if a socket was passed as argument, skip all peers except
+		 * those using it
+		 */
+		if (sk) {
+			rcu_read_lock();
+			ovpn_sock = rcu_dereference(peer->sock);
+			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
+			rcu_read_unlock();
+		}
+
+		if (remove)
+			ovpn_peer_remove(peer, reason, &release_list);
+	}
+	unlock_ovpn(ovpn, &release_list);
+}
+
+/**
+ * ovpn_peers_free - free all peers in the instance
+ * @ovpn: the instance whose peers should be released
+ * @sk: if not NULL, only peers using this socket are removed and the socket
+ *      is released immediately
+ * @reason: the reason for releasing all peers
+ */
+void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sk,
+		     enum ovpn_del_peer_reason reason)
+{
+	switch (ovpn->mode) {
+	case OVPN_MODE_P2P:
+		ovpn_peer_release_p2p(ovpn, sk, reason);
+		break;
+	case OVPN_MODE_MP:
+		ovpn_peers_release_mp(ovpn, sk, reason);
+		break;
+	}
+}
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 5ef00ba6523d7bf6608adb86fa7c7029f559ce2a..2a3b1031f58dd73925a9ed74aed7ac4cb7b8c4c5 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -25,6 +25,10 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @hash_entry_id: entry in the peer ID hashtable
+ * @hash_entry_addr4: entry in the peer IPv4 hashtable
+ * @hash_entry_addr6: entry in the peer IPv6 hashtable
+ * @hash_entry_transp_addr: entry in the peer transport address hashtable
  * @sock: the socket being used to talk to this peer
  * @tcp: keeps track of TCP specific state
  * @tcp.strp: stream parser context (TCP only)
@@ -57,6 +61,10 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct hlist_node hash_entry_id;
+	struct hlist_nulls_node hash_entry_addr4;
+	struct hlist_nulls_node hash_entry_addr6;
+	struct hlist_nulls_node hash_entry_transp_addr;
 	struct ovpn_socket __rcu *sock;
 
 	struct {
@@ -117,8 +125,8 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
-			   enum ovpn_del_peer_reason reason);
+void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sock,
+		     enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 6f4b51089033a8d806eede0a63f62b239197af0b..3367feb5cf725e41d01e140e838072e93f7fd4ef 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -370,9 +370,7 @@ static void ovpn_udp_encap_destroy(struct sock *sk)
 	ovpn = sock->ovpn;
 	rcu_read_unlock();
 
-	if (ovpn->mode == OVPN_MODE_P2P)
-		ovpn_peer_release_p2p(ovpn, sk,
-				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
+	ovpn_peers_free(ovpn, sk, OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
 }
 
 /**

-- 
2.45.3


