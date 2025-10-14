Return-Path: <linux-kselftest+bounces-43116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8EBD8153
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 10:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5C61921F38
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD230F94C;
	Tue, 14 Oct 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2C41zQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B830F926
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428982; cv=none; b=HESnaHibsNUDUyICgdzSfofyTzEo9HqEQ6vt2CgUW7oWdHBsQ88NDqOUdHiTDDh3lD47LZaXI3Lgu5EioZn1xPcoHxCgQymDDquytmmlyjgpxCsubSwy3T2/PLy5LKLayE5f2HPTsmzTmSVUaZufYkZ9npHgs+mCUen/6cgkOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428982; c=relaxed/simple;
	bh=lH3Fg0xYXRRKlOcO2hIA1PKojnFE7636KmAX1iarqLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd/cdTjMtoQZgbRb/CChbUjT02jF59wxJvFQZi+tbIYaZz0I5MNvC92kM2OeAz3oDldv3kcOZ4WI1zfNy5y/IQZggykb2pd5hZlJ1gvB1AJH2yr1ZxfU74FTA3VnKAULX16ji3YzIMeGOmVaNC1ro7GCu4i5ss1aG3sqoekU644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2C41zQJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4533218b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428980; x=1761033780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6CIivt01bOqUoEaRvA5upBzPrQco5NjM7gJAaWtH0s=;
        b=g2C41zQJjuwDI67yltLMcXdAOVYUIPtcSJUT8dpeoBo88e/9f97HXvu5r4KG/FwFI5
         f/ua0emcRxJsH+orpQzpULCcjhyqfZNFavTdnZdldoBAr4GWklXVMt9XCPIRHbv3E1Fu
         A3nDdnEM1sAZtR59+Q9HgfwE/Psr/eEHA4Lq4Wa+Wjcm+uN7Cd+iwH8VEFuvukA2UL5U
         kfsJwFelc/WJ03+jrKpQv1eoQem7cHx9yW+6AjCBPuE+ndq16Dx/2xXdUTl7HAO5UXaR
         HnLB0ssKbUqRYHJEEQ0tdEnNzJo2CYYRVxElYzOjTPfupX1fvr0aW4aXxEVHR2cF5CC8
         FEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428980; x=1761033780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6CIivt01bOqUoEaRvA5upBzPrQco5NjM7gJAaWtH0s=;
        b=qwenYNWyahQ2Sk2W9b/XVTXCBc38l8EPqTboIULdkNIHHv/PC23XoXDAvdjg5xMIFT
         RrS+JmRTIxkIZcreajK3bWGsNtAPwLDiQSSzlcjN5Wpt1vbfkrVum4fCMvkd7IbEW4Tc
         bSdY7RlhpyKNNmivGcgIBgecTQNgsxHrqgSRNQpSzicQxUZHxDdRYjI7o+ggACuYVPQD
         65N05doo/I8/BeJ/+jeAGe2dks8kHYO3+kvCPuGHvtlSKt4+Zo546UHWs/+SJ94OtWE6
         jpTXmpO/kc7iQeFHWAiTC+/Wy5ulxYOCsj0vfP3c8oK/bPBZb3SJ7bsb5ImK+TyNp09g
         SJDg==
X-Forwarded-Encrypted: i=1; AJvYcCWaJdxpa4feUff7vmjUDU37D5j3FqynBeO6whbs+cJ7H4Jxeqz+Ajmm6EUw6PLoIHxqoDbAFASp21TRjsjFf18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8z2tuTw2HLyR/SIVlLT5Gw69/LLI0noTW10ZnDOQR1m7R9ql
	JvHS3MOYRp6bORA1PWY4fukNURv+jNXfSlRTdmo1sx3aw+ksaxZ7NDDo
X-Gm-Gg: ASbGncuORWXpPJcpjHx21yMRSpgZ/CiRf8ZMuNJaoHyGsvHJe8t5zk4jVwofd66/pg9
	/4MfZOBK1eKyEsjRJf1WVvNwS0n7RF0pr0w5t6+vdunqDofzUgT0Iq7KnAcTMpRXSNy5AH0e0dF
	1B3zBzQo/Lq0nQAjNw5QskRYZ5Qxg5wXzgap6fqQ4jj0k4DuMZMoTJOFkqX5jm+meNHsVjN2SBg
	jZWrh5838t0kvmMaCS+X2qQuFNMpQqJA9tRdimpdJI4Pt+mp6QM1l14WC1LP1CVOMFQa2ywftLy
	rz+N2n9v+s6GSK+Hk+L3QJMqLaveEhpiM6eaav8Ovtq02Qn+FXIIS3yiy/A+jYxDsnDw1Zy+3E5
	1gBhuUvkMGTD1TrKGs4I8UyVi8Tk93KsrvBei830f5NnSZw==
X-Google-Smtp-Source: AGHT+IGSzBQQGsbNRR3SZqd7vh9nZGoC7PUS1lh3+/p13pc6t1WziAuBTsyvJqOXqUW55QcL91DiiQ==
X-Received: by 2002:a05:6a20:3d96:b0:2df:37cb:6b73 with SMTP id adf61e73a8af0-32da80bb9c4mr30115116637.11.1760428980002;
        Tue, 14 Oct 2025 01:03:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:59 -0700 (PDT)
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
Subject: [PATCHv4 net-next 4/4] net: bridge: use common function to compute the features
Date: Tue, 14 Oct 2025 08:02:17 +0000
Message-ID: <20251014080217.47988-5-liuhangbin@gmail.com>
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

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_features_from_lowers(),
the bridge now expose additional features, depending on the lowers
capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Bridge has it's own way to update needed_headroom. So we don't need to
update it in the helper.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..d614378245f8 100644
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
+	netdev_compute_features_from_lowers(br->dev, false);
 
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
+	netdev_compute_features_from_lowers(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1


