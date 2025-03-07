Return-Path: <linux-kselftest+bounces-28454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B1A55E34
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 04:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B92176DED
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1F194AF9;
	Fri,  7 Mar 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc1IqCq1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF218E02A;
	Fri,  7 Mar 2025 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317569; cv=none; b=TS/k3n1v0MejUex41rVjHoGqWVO7znxj3g2O7T5G9BarXbXlCj0iI5hlBwtaFlPbDbCnaYbvukTU4B2bTHZSo3kytnkWunN9os5/amnPWgjgUt9yB6qwqLdr31uP1jAswnCtcQ1VY+5yvZISDz0zgJMqWLdvfYk2UN7yx0DPSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317569; c=relaxed/simple;
	bh=Uc2Y4LX7nLo4V+yn1T2U9yZeBAqdGZWqoe3sbEo99As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIKwQAcv/VIFsWpQPM+6Z+9w5tM4BEJlf9YcQ6Nyy8KNeiO88n/r8qfrb/ZNxU1M5MGrOzYhCijnzXE/I4YtHMtueXS/NeLUZhvezEdHYcVXpQMFAYJ68fuz8ZWSJSBAqLtoGXj6igUJdnMXbdateMQcJp57vXc/cprYUw82PWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc1IqCq1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff087762bbso2164995a91.3;
        Thu, 06 Mar 2025 19:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741317566; x=1741922366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfVhujCifJI6eQhwz0SXL+R1pNFuvqV62APgboYQN3s=;
        b=dc1IqCq1srMQGuHkkICOM6HVb7wbIYqrfqkZ2J27Hfbkg19HKq9+4qze8nWduOLJye
         PJYZ21ywMuK5A351rf17d05TE/orwxPHZ4n7ETN3sKEq8ukGWm67FmjjZOwZHkwRsRZJ
         VqMLj1+8SkbHWBhxUe79J9Mji5pV4FoWxd1jynhK/BzVFn0WfwO/9BL9x/oEKuygK5tW
         Q/z2d7nMRdeq5cqz9gcbhe3Xu7tG6sT495Vq01CH5BxP52zX0AxMSbysSODUQ/J4Rh7J
         UNm0kO7YzJK0JanohQW3W5mBAkgAt4+DCJ3v+FD2mWMgABUKY7EVCJ/vZlfjH/tAvH+7
         XwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317566; x=1741922366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfVhujCifJI6eQhwz0SXL+R1pNFuvqV62APgboYQN3s=;
        b=RBo4i/RoqRBw2pn9ipAA48jAWIdRKNdaYYQiqPUEpfpqUt4DB3DUrgpjpLRcFp5zXb
         IF1ED82JUaRajpghFJC+i14lVzAUXGdslUlP2CZeu/k4yVoPJdF9bYvuoRJUJQU6bWVY
         Um93uvL7WFmdd0YUHhJuvvMQaGyKpRwv7nmYT79V9254wWoZvn9BLJecZZ95j5P2l/c8
         hGVXEzR7eHxO5jIJkaZvCJCp6RPBejfTnNZ7G9sGilRC05LxnjIKSfkOwl13fyMZnCXp
         gh8SBGCaeK/1ct3YvVp2fUIbOB7i3QLV8nbKVkhEw5D4UyfMPmtIcCDg/oIu8mIuFT5Y
         aElw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rp2eUhT3vx0j0g8lR3DuBjAFL61kVh9bQYOdSj6C10mHrBwByhEqLokRw5ZBEyK6sqkoaCWik9qgqSaT5K6b@vger.kernel.org, AJvYcCW0HvauTYEorkKglJSVqnYPQiwSZ0ZoyRMrLR6431arNHtZmUbafFolFC5Qqa28qka+IIwDsbPUd7JDh3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8JPc09LKILgrOfL6MQNvgminpMRCFQY3WbKeVIkPsCiWm0px+
	4HSCLw+nf9gCUHVg2x+TCYl3BzgXS9oWOJFxD3oqvj9tAzVA6lTyynhL+e2UGdb+7g==
X-Gm-Gg: ASbGncuyHmg8x1ENi5mBP9P5DJH44Rj+veunXil9KSnDFgA44BDcxqmPkj8tl3Qjf+0
	nXlF60CmSPbDeXMbCsrYdQazrUeGz+LbqTJ/51l3VSzVi8szNJNQIX/6XZmY38t1dmMoQJCIIHE
	OQzDb6POBJwET8f1nQWW9OYZKf11x6Tf4ffVD3Ho5e06QoDN/DhPdLoyLzP2PGzQ8DXVPePPBVx
	0Inxq5ZPX4fkH1AEDMbhXqZX8Kd8BudE7LyQgxm3A50xCVK99P7CVdoN14Mln7yS4K+jzhIGylX
	bZNzMDCBHg251qnKP2Y9d+9xdhrryMJWb3Gm5Bp8/rIP5mwUPpxeUDofAnQQFHTP
X-Google-Smtp-Source: AGHT+IH9BdiBzTzH4qtj3b4pWxNcrckb/AcaufdblDqmhdyDhISkyBvr09Txp5nhkbg0LogOUyHYRg==
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-2ff7ce8361fmr2955637a91.11.1741317566262;
        Thu, 06 Mar 2025 19:19:26 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5e2sm20013165ad.15.2025.03.06.19.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:19:25 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net 2/3] bonding: fix xfrm offload feature setup on active-backup mode
Date: Fri,  7 Mar 2025 03:19:02 +0000
Message-ID: <20250307031903.223973-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307031903.223973-1-liuhangbin@gmail.com>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index dd3d0d41d98f..a060960927e9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4422,7 +4422,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..ed16af6db557 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -568,18 +568,20 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..e5e005cd2e17 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -707,6 +707,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.46.0


