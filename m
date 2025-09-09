Return-Path: <linux-kselftest+bounces-41027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F196B4A50A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B3B3A6225
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCE24A078;
	Tue,  9 Sep 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/LTX2fC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F124BBE4;
	Tue,  9 Sep 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405976; cv=none; b=NIgqFeye17QFDeOqDuUJlls2MQ35GF0jQOPtG0AU/5xw0gRFGg0l+0ySg1PE6OS3K3eoj7PKFZAJHh1suY4uLed/S/4D1JE1RmXvZU2mWxx72HnGsbY0Vz3EM9gcPLKgbceeWgZRKdJq28MWIOvOWlhrSl34/zMfe6BPok+cYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405976; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TArvWxsy81ldkn2YsxPmFw6CoGayEEJq9QU78X8WlWP5khwA0Dw8dsfGLILlC4juK0WJggo0gvWXOYwwRdjZ3tDYhABEzDmLD9md9+DUvpYZDiXx/CQE6Vpu208x6NQwIA/hqbqLSMJmWCBlIns0YXJ7r46G0usZisHitL+LTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/LTX2fC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c786130feso46497775ad.2;
        Tue, 09 Sep 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405974; x=1758010774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=f/LTX2fChlFQ0cl1+0sx4UmEYim/+GUDQe2D4WSEI3oXlVUVHxATICF/BMDmi9Pia6
         FbBu5P3oeLraMfNLOuh2eQRuVEfHHSLrFEGPSFRyrIq1pew5PZjWl+Bw54eYAVg3Y9k5
         NkDiAITShI5ojZHUhhTzVNGZ+JnLJWERIkv0vaKvvPSAalZYidYbVscVVd5DPbh3iD6Y
         Z5HyAxtwVzjo+b9GFKY1oG/CHU1/YqWhSWqpyCG9uDPe32BbQ/9darFtGeG2zS071GKo
         vByDgfdgoqeiHBjGuNllK9KKYN9pqWfFCMZXxWX2OrgBMKBOg1L7pvclh/eqRR47OHB5
         +Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405974; x=1758010774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=RMnqrk6bBlOtxLN1IPuMPI8pmXj5B8vX6/yduVs+g0TT8GEcxpiZgB1YipjXLt4XCn
         cPfzn+2BnIsAPPcKXuLdAQjRpX+Ve8T4oItjlA/6ENdgIqMoTHK6AbTb0z2CloqrCrRi
         RbUWz5jtyFfEsa3Fb2D+jgvSoKGxvndHOH8w3lc23EB4sB5vaOgES7xbhve5ImHH25W4
         fvbzu7YranrYCK3aCv1SL5RAzSqmrKv1nuAoth3NQPkHAAI/YhrierXPBgDOLEQAS7nY
         6rJoGJgmUk5uG8pI2HC6HcX4GvJdh2/LUnC+0zPgzNHsKGdACcm0zIZ0oPIjRLVx0o78
         vjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9zU0EgNyjbKidFPEtyyNG3zmRtnOV82toK9TVkUP6VKyMvvJCuKCwqNURrIwIW42aSLwGaxqEC7dCbctqvEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmYOnefcHWuFgXdSEUeW2PqKQgu9LUEhT8GuuoA0O3keqhYms
	E6qbnhrB8PMnze4UcTvxz/Z+ZMRNMhBnGgJa97kwxvyO5noa+oQFKLn7FtbGItndfKE=
X-Gm-Gg: ASbGncv/N2Tmg9JuYiUaXdav3y47LgQMo1/ZmiBzaCi/ENcZQIfpHGF1eHy6W8Y1OHP
	eIhYcAv1fAmFKKfqRwrqwFa5RWEaW4feUKRGS56L1NbYEhWsYiDXYFXKQHQ6ThzHcVFcLX14T2E
	PProjf+vrVd3ci4GNOJolCHfWaeTLhNs0wNNcPXaziNO9dDQgWI7E8YF0/rD4zq+4FgGEwXb2yQ
	DoFUA64kYwnY8RU6J/CXbaEA8DEffRM2OjgywEcr3r+AxYpkFW0dB+CiJCOICL5CE0wxnNwUWGp
	5uVgKSWqwwBVGuTyMO4HhfSgoDCK/ZYT8yBJ/wCEl/ExVd1DVb23WXVN9jE1nU23aKzaRaqOjMo
	n5SWd9ylriqXxflcCAADIpL06QDNwLH5bAtAWSTlDulaFGW8yubiO
X-Google-Smtp-Source: AGHT+IFkevz+07KZP1RBJh2ujaoDNj45NZZpaRqI+pqsnwseopNaWUHlbdVezTUcHfaceDpVDyDddA==
X-Received: by 2002:a17:902:fc44:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-2516e887fd5mr144769785ad.19.1757405974451;
        Tue, 09 Sep 2025 01:19:34 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:33 -0700 (PDT)
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
Subject: [PATCHv3 net-next 4/5] net: bridge: use common function to compute the features
Date: Tue,  9 Sep 2025 08:18:51 +0000
Message-ID: <20250909081853.398190-5-liuhangbin@gmail.com>
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


