Return-Path: <linux-kselftest+bounces-28205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46503A4DEE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D783B3A6A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DCE2046A2;
	Tue,  4 Mar 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCBZt+sF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5051FECDB;
	Tue,  4 Mar 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093906; cv=none; b=n+NK1UQp+4TRkGVLyZfemnq1ts5ItwI4Aog5+y2ZK0AMNWy60qAJIvb6S+gj8xz1lOeSnwaxLHa8HVBtblziTBJ4gJFmA9K3LuMgCqSEasx8Mm4D0WuhSPQt9olg/sPtXN/Oo3IhcmbKLb9jluM1DvdasEtjjReBglZWSX+lGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093906; c=relaxed/simple;
	bh=rnFMPWLGPgZPYYBXGEOWcNlR7wJoCsop/Kh/oaTC5Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFjY+c/0eWmwiwGTjuXCVdHCzKNxKt88Ki14B/gxXRf8DbRUx4Gb+PYCzNaRn9y2mbjsAjv5CdbF+2fSeAlf8oWjs+o/vXjcBDsYmZap+GF27gg+MOkflYHl9r0P27lwNMdVHQU/BeEvE09q2dsS3sS6s7oyM94kI+e8T6a2lJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCBZt+sF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22382657540so56809265ad.2;
        Tue, 04 Mar 2025 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093904; x=1741698704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2S2J9YC0kujf8OoTQU0Yx2LORzPMId7j+x/W3z5Nxc=;
        b=CCBZt+sFvwq2MROZZjn8A3ij58oVb1E8hmGcL/rwzzTs8SYVwDuxpkSsBjkZoIM175
         whn7OaG5paMCCw5+lQOA3VKD4mkxzMZLrdj1W0KgpyDXIG8KUHuQGo10kWWhKDf9muRC
         10rRBACTVhH1JLGyEfIo2D0m6qt+lhZR85YGl6X75Cq+hzZBPy26cQJEIKNOQn5te45b
         WQb8MrXkztVyI7ljdybUpQi6C6HJG3VJ8/RlYR+UMM/177l05kbx3I3rx6dowgHOgsmx
         L0KiaF0TTqidmIHDU7OLzgGqir2p1EJuj/P13ORbq7ZMyrhYtPEH1ZpImM+n3925rL93
         gMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093904; x=1741698704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2S2J9YC0kujf8OoTQU0Yx2LORzPMId7j+x/W3z5Nxc=;
        b=VUgVuYayngMQp3EI+5YsDjgjPXMRtVCQf9KzZmkctLQv+OrRwpcRmrXLeDwguhfhlB
         LcIjziuIUpBI4EQN5LCQeX7H6feXW4oEzl+8v0K1zUHnJrBIAIpJQRI81sCqVBciPIrt
         aNY6lnYsXdYK6yjPdBD8ObUtQ3pttGlrg3Ol/TPscY/tMQTdLl7AgLS+MiN2F+Vrankd
         jt3cNK1yieV8CfhAi8+hCuJkoR7bx1Q96mzq8ehqgcEH/ZuT8IrD+D1BsAvpDQluof+G
         BVk9Wd/eKMl2D+rT3BXKiEI4sDQwVx9lBFVC5DC5kt1PPzxjk1F7Oz5+kyPxk2Bk0wDy
         lLew==
X-Forwarded-Encrypted: i=1; AJvYcCULbZdI63+TisMUO2DBIuhZZ4zIKcgP1CO1V/BAbFuClC8sRjMe/HUMZlWsuEBrH7CkcodSURse2woGT1k=@vger.kernel.org, AJvYcCWb4L7gVih7TxJZEh014FbFeBIudx47SaJE/a21KbpY4Ob94gTtVYxHk8hcGUo53NCGul/Ue1KYMZD6mPI3iWPC@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQB4zIPAKKYCev/jZb4g+biVESrawcwvsftxMqzcknj4wWzkT
	zfwf2aU+ijNZX5aIHHMLK8gQ2Ejh3QJFScyEpQB9FQkpdLt1a+AcquJReqjrAr/I4g==
X-Gm-Gg: ASbGncvBiLq7lkN3nWk39phLirlfb5zyAQP1z7oQZtuk4+z/n71qGoHzT0/4TVgixwq
	GuvIuuSZEV57+eT8UEf1GC3GWxemNvLnYl368GYOJWXc68mkVz2Rp/QRYqpjRAL8lKDJOhia8KL
	fMjFDRYTUvvvgEKRUJMH4hDBOEE7zCQkYFbCbIPTG1EHkeMmySdR3cmVJxTUpQGfgLCEPl1M1CJ
	tpiiLJd13YoMAJQGOJ5q1Chw/4CIoWBijGTcw0ZbD13RSB6zaAzF302LIM5jGrLKijXfZHw4C/n
	n7569VpF0Nmbkiad1Xc4KzV4n1TYNskgyOxULmd93I4FVBi+Iqaog89oJWkYps/B
X-Google-Smtp-Source: AGHT+IGYEuFl4VpW+rbLtTdgwznV034ZWw4oQI3xyYSP4kR6T7XRN/fYQ6ATJgqByuUB4llIgzYROg==
X-Received: by 2002:a05:6a00:2191:b0:736:5504:e8b4 with SMTP id d2e1a72fcca58-7365504e9fdmr12491254b3a.19.1741093903604;
        Tue, 04 Mar 2025 05:11:43 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a668sm10824199b3a.30.2025.03.04.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:11:43 -0800 (PST)
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
Subject: [PATCHv4 net 2/3] bonding: fix xfrm offload feature setup on active-backup mode
Date: Tue,  4 Mar 2025 13:11:19 +0000
Message-ID: <20250304131120.31135-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250304131120.31135-1-liuhangbin@gmail.com>
References: <20250304131120.31135-1-liuhangbin@gmail.com>
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
index 06b060d9b031..1fd2c0a5b13d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4410,7 +4410,7 @@ void bond_work_init_all(struct bonding *bond)
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


