Return-Path: <linux-kselftest+bounces-40518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0346B3F6AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC254840B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12582E6CBD;
	Tue,  2 Sep 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTX0uPVb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632D2E6CB3;
	Tue,  2 Sep 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798015; cv=none; b=DyVxWBJZWGYDDuF48D1o9HaK+lfgN2pfU9ericpiLbPa3RxCAXSuUWrRapN00//8wFT9RzZmCGz/wa1Gvbr+ha40x2335OIEadb5J/AlNbFcf/zPMu/9On88Xe0sPM66a0eIPGIfErSWfAFJ0LDqVZYqBltJhVpiMhdCGG6kvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798015; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIBV7jseup+3rV3k0LUKjFnRMh9psDKpufoTTIyu7td61QKhhCv2/y/53uxj5HBrqqZFUhMJEtdT/c9k9z2fHBXCFiE33d2aCPwjHsd+1D7Qv+emZNa0RklDqnYy1MYlGJgZs5JJAt/SsMm+BdgUCbHnYbv5wfN5GhaIGGu7iA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTX0uPVb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772750f6b0eso139557b3a.1;
        Tue, 02 Sep 2025 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798012; x=1757402812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=eTX0uPVbGIHYn/Dmku0sl599ERB41spXGjWiHmNfTz8LZdsSOzbn5BrsFYOHR9sijS
         fWD1527FAQqJAkjKy4MdER76qDdMNgPh0ufvIv7BtnD7ORPiTcVFWnybmvoYQTMjFBW1
         UIT4Ool8kA91w3USbGjtYyUXkLrEuDbRoUrtBhoTbaDeed1H6/NihxgICz19387MT40A
         Q5AZDPe4JpwcAbzGMWYGcT9tFxyT5hU3lovnRrxo/nabxjpeX7yZDZe2AgZnPNMdZleu
         QTMRfSxGHq8A6k0oozOJ1RozCagrGi/zzxtmKoyoNmBR6s3evHXoh+5JA2PBZUI+or5K
         l9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798012; x=1757402812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=tHtniuWEVV0OUgk3EYkdMXYY13dfSsJkw5a0EvXHWa4DDl0NeoQro3LnS+SbAYyREN
         f+/oNJZm7yVDOH4ky5qNW76OWOaW6Zki2t+T6fLnm+dEGPNT0CvlgukJZpPhaNzTEFdB
         dhjFfDJphc67sIUp7/29o95gwpgcZ8X/wLbcygjuHwl+HHF5zG5BInMQy/wPSnEewPNI
         q1GescrqTl3xMGUOi5H45R29m2j2rP+gzkHszeq3mUJkwQ2Y6qw/cYfBPw9od0HvhOBh
         5vI++kyp9gYKspx/kyWxQxtuq9av51B2DkXzuhaR3JP7VfkOTkycBSwV1vsPgtJYE9on
         zBcg==
X-Forwarded-Encrypted: i=1; AJvYcCXoYGBsEU1WNH6ut8JEgU2IupUl3v7uztfUbREZLD/16/y2e9mghHi5glCEGveMTjlYDWot7XQ7S4EJ29sUJ0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKy+Aps753gwfPqBp6IEdPCqDCkwRZUOtui3BweIjMN+yDDAy9
	VZDhtMi/bX2gD4aB35x9GGq/aKtUodtIJ1B2cd52uhgTTh63e4HeCMAKZF3NeNUOTDA=
X-Gm-Gg: ASbGncu1enbl472yX7fKJ2RH9W/5sbQADpQJGEkQHAwNyeAjKEuJ/hL9roHfreYE93O
	8d7O08dyDaMPlzUXzUOXTt5M6HdZjj7/UgtChthTfZon89MIRutSkGR/n4nwDGSNnKCPco1mNwi
	wxkoh/B2G0fuxN4e1Daux09MggWNQpSPBfmTs9X29tGLXGbjJPSZ2zrL4l6eSsB+xQeSCcPqmYF
	Y+T9fQEI+LHLFaE11G4p4Lkhijjag5RGhGh/v5NSVMmxt00Z1rSlzhSrVenE2FHxPSFfomCQIGz
	zxLWkummo0e5ktwiLKc/ePZ3uckT+3y9WibVMKXteO34zDfwLmEK9dIMjKUbBIjAkuzmZ+yekXZ
	yaPFENk9ujbUsCKx2sVjOWQ7/QPGZywMp5AZ3p0IpVg==
X-Google-Smtp-Source: AGHT+IFE5feWtU2KgQp1RM18qUQKlzI09j/4JTDWTFuzVs2U8m5ajSDdOry2e6kxrkWUVrtwE2/S+w==
X-Received: by 2002:a05:6a20:4c8f:b0:244:58:c147 with SMTP id adf61e73a8af0-2440058c3f7mr2245485637.21.1756798012292;
        Tue, 02 Sep 2025 00:26:52 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:51 -0700 (PDT)
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
Subject: [PATCHv2 net-next 4/5] net: bridge: use common function to compute the features
Date: Tue,  2 Sep 2025 07:26:01 +0000
Message-ID: <20250902072602.361122-5-liuhangbin@gmail.com>
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


