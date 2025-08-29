Return-Path: <linux-kselftest+bounces-40260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBFCB3B7D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB9A7B8210
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AE307AD8;
	Fri, 29 Aug 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBYnL48d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2723074B6;
	Fri, 29 Aug 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461313; cv=none; b=RzTxCzsKNoKYIvPQXCEJ79EwQkkH46TWQFbbp6NueCX+ZzfF3LINF/t2kOiuPf/znkFR7HZxmKoxx9XjbptrWlII1ZIgHsiKIj4j08neUUHR7QLCDedSUPnM8RSQ6Oa6wMZ1+ZhhCFdAATDYNzEJsSEegYLgiTXS2vArnvoKuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461313; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkdhtShShHfQCL5BQxHeAwlVJi8RLnm6w4UyAWyViEDIj81tl+86Eup7CtOwR6uKEWzCbPGRhJLiA6m/MVbs/9bKioUVljNDnJYKPV8a+jzIniDNMjRZpWxVZTBOFHWAKsPrN5iMMBmNiNqlkjxC/yJ0Uh1D17rO6+fCo3RTMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBYnL48d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so1457513a91.0;
        Fri, 29 Aug 2025 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461311; x=1757066111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=BBYnL48dXMse9m/8yQUwsXk6D3wwCcUU8sYxrMLwzkOv8A6o9NhpHMujdWegk4p4rf
         BE7tLdFU11YmgIJ+Sf8A2xRDi5KezXH/BDnhE2XVLrPi3/SmY+8LDfeqpHmJwC2VYDRG
         uCxAz4MxC4OwRUSRjlo0F519jNgEUyZ6Foag+n3FpLyJ/O21SVRPU/TXBz2nnr/yxp3b
         m22GMxN9fRG3RQMi0213dFCQrxf4t0KWIxihuom/tPcr2thj9int50aKl774KS/jAxDA
         srzyEyqM+pgdggP3IDmvvmvilfv51sF5U6CxeO0/AxNKbiH5s9+omIRmsK81pJfYCphV
         q/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461311; x=1757066111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=ElUUDahiiAHTk5qLLhpk9RThvAtmpI9afrauMvt0u5HsAXCXQKTvTfh+A+fnIiDa50
         wLNK20/pzr35m76EAp+gec340O+H9c9IidTTuBTqYoPyNFEKWOM2pd3pz2F9Tw9BwC6e
         pamKI0Lp6q5kMh4Vnq7yhe30EkYrlc+MoYzQBTESTDriTsJKQCrPhk2Bl2t221A8zb+F
         uN7Ztb8bdCJ5da63dI2AYHvJmTWWKFdacZqACOJwPfC6VYbEYk/lUX+YzJbpjU0/WUdB
         6JQ6Yn+zJPZraAeQreYu2Je0hGqQqrTp30cQpr3RpvGEfCnW+N6bEDfW4StyxBdQkMVp
         /PCw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1l6BqGnDayR1csx3vZFd/lpqDWmobwwf0lAlSdUyjM2SdbLYIBDzVTh+Ip546GK/4Ru3rphayQ4BSdVsT8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zy5iUdZS9k699kHtz/ZXArUUrOslA7JbLkFuyWaKYJ/0eDnP
	sEmBeWYLSH53w/FYX8l4qqtYUg/EP/g0jBFTuOF5NS2DtuXbbE49HgU6eT0SV6dAzIU=
X-Gm-Gg: ASbGncuRYmx6rXycFE6hftLGFRlEeydQ7UL6ylXV4i5HybEEPgmiL2efdjPylm1dfhr
	oRUwpHEfSD+WbHcU0E8J2A0UQ98onnFi6zUKPlW0W9AAO0L9cWxhKvJKSSuUlr2x9CHV6AZKvWF
	5ovbxqOlFJ0xfaMYhzVgm3ndc8dKoqrEh0NR2EQYQT/Hxp8UIm6bBTpblCn5l8zcl5PbkJwtAVu
	6qjT0EZ1B/cCh4eaqCKxD/QP6r2uCDKkm28V5xeV/Q/GSDNzItDGukF5xjXnXMozvbjr3Lt8xFW
	w7EwVWaJn/cv04JNbhUOHuY5QejpQdhqkU5lhdYQQnJV1dBJe/fisk8vrk73egWfkJHkXuG1DdS
	5gCFvu2qo6fNW+x5wKgpAPyARGgUTgPSXdQ8HcLtPjw==
X-Google-Smtp-Source: AGHT+IHsK4m1pnnbSsQ0TC8ivkR557BH2bcTyUBjY0FSec8e/powKl/lqDZiDqj3ASoVraxYAGyFIQ==
X-Received: by 2002:a17:90b:2ccd:b0:324:eac4:2968 with SMTP id 98e67ed59e1d1-32515ee13cdmr36122443a91.33.1756461310881;
        Fri, 29 Aug 2025 02:55:10 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:55:10 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 4/5] net: bridge: use common function to compute the features
Date: Fri, 29 Aug 2025 09:54:29 +0000
Message-ID: <20250829095430.443891-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829095430.443891-1-liuhangbin@gmail.com>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_features_from_lowers(),
the bridge now expose additional features, depending on the lowers
capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..8fe44e8c008c 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -525,20 +525,6 @@ void br_mtu_auto_adjust(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, false);
 }
 
-static void br_set_gso_limits(struct net_bridge *br)
-{
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	const struct net_bridge_port *p;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	list_for_each_entry(p, &br->port_list, list) {
-		tso_max_size = min(tso_max_size, p->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, p->dev->tso_max_segs);
-	}
-	netif_set_tso_max_size(br->dev, tso_max_size);
-	netif_set_tso_max_segs(br->dev, tso_max_segs);
-}
-
 /*
  * Recomputes features using slave's features
  */
@@ -652,8 +638,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 			netdev_err(dev, "failed to sync bridge static fdb addresses to this port\n");
 	}
 
-	netdev_update_features(br->dev);
-
 	br_hr = br->dev->needed_headroom;
 	dev_hr = netdev_get_fwd_headroom(dev);
 	if (br_hr < dev_hr)
@@ -694,7 +678,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
+
+	netdev_compute_features_from_lowers(br->dev);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
@@ -740,7 +725,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	del_nbp(p);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
@@ -749,7 +733,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_update_features(br->dev);
+	netdev_compute_features_from_lowers(br->dev);
 
 	return 0;
 }
-- 
2.50.1


