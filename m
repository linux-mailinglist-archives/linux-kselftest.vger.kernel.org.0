Return-Path: <linux-kselftest+bounces-41797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9284AB829A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 04:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9DB7BB732
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A52629D;
	Thu, 18 Sep 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOSDPpqd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD225634
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160935; cv=none; b=HRjpZYarJM58KKkg3tuPkErpyPGvO33uHAwCJFM6+k8dzeQbTzHOzq8EocDvvRoZ5ZPeeGskeM53bw1uOuVvgo95Eaoj9b4SuN1/4eyJX2/WIbCTKzVWejFK8YKvYhCCGYS83a7KpmXbRQmNecqgvNPvDHg3lhH1jBDBCtV+hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160935; c=relaxed/simple;
	bh=39hZAvpQH7zkG6OlmutysyBwA764hUu1rnmxK5kLQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5F3I5MXnSgDIVpiTU90V8v23RSN+QrUHkO2oFa13ugHTVSqZxkbDnDB4YOIQf0q9586y823XY88L1CfsKdq6gcObRjWIH1Xc7HAWmP0nou7p2NXmpZSxkg0GdWb/1PfgUIjA8jR/IAdY6fTiSRofy4Su2v6oM895e1h9N20GPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOSDPpqd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698e4795ebso1094225ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758160934; x=1758765734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbsjyy/pOrWCUEBY3PlLlv5Me9QJPNkU3Ay1k3n9YXQ=;
        b=FOSDPpqdR5jIIHmOiyPPvi3i2fI8q+almsd0gDv/2mcggfgOfxf3hZoS8dYnjHG/br
         mStApKQtHDrUfNoq4q7tWUE94L8+sICmgdDmGwj6BwjKQwzh+b/uyNNp/iGVFKN7Zflj
         1POJXfpf/iueeFdtLuP1x2Bzgp83qA4gOy2U3GxXwQnPWNG54uAJiR9ONc96B86tdowj
         nSWW8qwGpT5ukPjnQF3uafUSoClIlPdwC6qU/G9Vbzh5Isu6859a8pnjdtAklvPsUEVX
         Dkm7yfPCFnvlraKe4FHztqasFimU2Rp3bhtjl76b1m+v+SmEVX9GFihaoVjDxfSsSpOq
         WN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160934; x=1758765734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbsjyy/pOrWCUEBY3PlLlv5Me9QJPNkU3Ay1k3n9YXQ=;
        b=VVYH5n7OHyNa4NYYxcizBNogyS6suaa8pgrbTPNcST26NQuiguaCtnGHP2dRS0bvT9
         khIhySassFyxsykcPUmStD+/+mrc8QDhuxdCOdCS5NYiKPqxGxTV7Iu+j39pdJxDtYfU
         Yqln3RjQobUCiPuu5Hy/T+08ny2DLene0IuYnQidPdJIQIIK7r2T+i7QrgScFwZiCryW
         kTz1BHVMhX5P4B7vPWdpU7RiLdylQbgepltGCn/0k4jhLZRabcwZoWRYd7ZoaS9rfSXP
         Df/j0ifCi1+Z9sdp/vEtmjVwICBbaBopHCdMnmeGQuagqt/8eyIzEb7lQjtQMAQZyjPt
         vsHw==
X-Forwarded-Encrypted: i=1; AJvYcCXaCBRU2v0BCJR3N45XJDejNLAQw0hQru1PDAV4y1F4ribddhESO8+uWFqRcvUFZKJ2CqMiTm5b4/vqeztnvuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiRWwu/KTlIlPL5EglAcqgKjeWc8qtfY3K2JA36F0X1UetA7v
	U1cZfAAoWM2za3F3dpV6rKWpQPmz9QQgZb3r/9clxreIHj/5FvphA5BQ
X-Gm-Gg: ASbGnctae+d4lFrCSCh9rOMIYeA6lV62ISXZ/+KVEmMsLYARIxsThNJHu2DrLN6Qb3i
	RNVAFgsc7h8GboX5a8DVLRHEzt036dk9dOU9Xg+Vc4NIX1yqA0mbbiky6JpQqN1bhW+icJZ77IA
	oqRX9Pmsv/UCuRfZnSX3wXdrnFEAkuBz7pmuaoUDW2jHMf4/kARUPplIzFBtp8jPCqZtV5OiLNB
	snQOfCvF97LWm/DW7yR8KabfhxZ4+p8GNR4wYSA6rSntS2tLJ6Sm7Ga7/uNON4g9v5T7IlL2VFb
	eG6vIo6fuRNwS9VCF72U3xQymCfEmUng/KeZT3T5By7F3tZvlFcM0XCLlgG4xHrHwPi9zbv9myC
	THaIx8BLspdocJw3yF/XGhJFpbneawkVjJYVHFGdKLBLlBgKM2TCJ0b4ZCUhB
X-Google-Smtp-Source: AGHT+IGXc2xH+niF5ulVpEiSUmB6Qzqg84j71AZ3b/oFBF3ivS6u/trbL+s7z2H9LCc7pVEKwI9DkA==
X-Received: by 2002:a17:903:1108:b0:267:8049:7c7f with SMTP id d9443c01a7336-268118b3f91mr56656115ad.7.1758160933498;
        Wed, 17 Sep 2025 19:02:13 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff38eaf1sm806417a12.24.2025.09.17.19.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 19:02:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Thu, 18 Sep 2025 02:02:01 +0000
Message-ID: <20250918020202.440904-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
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
v2: rebase to latest net, no code update
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 57be04f6cb11..f4f0feddd9fa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4411,7 +4411,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..7a9d73ec8e91 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -579,20 +579,22 @@ static int bond_newlink(struct net_device *bond_dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
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
index e06f0d63b2c1..bd56ad976cfb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -711,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.50.1


