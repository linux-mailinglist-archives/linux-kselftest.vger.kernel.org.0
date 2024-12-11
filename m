Return-Path: <linux-kselftest+bounces-23150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0E9EC55E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687A91678B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50261C5CC6;
	Wed, 11 Dec 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2t7rNV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837A1C683;
	Wed, 11 Dec 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733901107; cv=none; b=IJ+fo2us7gX7ZNEnnAiDBAolwBDGQa8NKIhYLftsvSOvohH3X0KWcNIp7jLWLl9oinBIOOINEQ1Ei1lmSi0RckZoRZ+BAy0GBs6e4cmtolNqOb4pAXZ3ENO1Xjsm6PQkg6XY34hGpfFc8GYK7saRpiOL+hPKjcpO9s2lKfWZQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733901107; c=relaxed/simple;
	bh=Vp911zOMAHAW4Nks20EqsH4khwo1z+cwWRmhUJL/qns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B98zo0bstLgx8Bvb2kaaZDeKqy0NvnuRDMMAgBrl/krG9Yi3nfADg3ZYKuzI2jSiz2ePVORmZxzzjv+VNryS3R+zRiKCKm5ANGySvkwqApHASYmW4Ariaxe7ItJEfIyYMYiIY6rd45IQ/fNOUbM9d4KiQsjWHpO2ySqCv1yBxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2t7rNV8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21634338cfdso43207975ad.2;
        Tue, 10 Dec 2024 23:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733901105; x=1734505905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5WpHiQlb2sFoHGjH0ec7NDbzkR/Fn1ZH6iSMtuNv1s=;
        b=d2t7rNV8ftz+lcsPDNlFQeY6NP0MBgaZu+wxGSTCUP22uXBsGV7g3skMjcxo4d6s6Y
         r7DMI3ikwI1Zj8Fehn+Cn6luR9gvXafqHeHoytlg+9qz0I1cd01NxM9C704KACuCxO5L
         qDChR8drKxlKtpcJdOxGknNuX1uTXPaNTcErH9E/Mj9rNrVqV6Oh9SVmj62Bx0BW+RcB
         v3dpEJwXv1ngP01E8SdetxmIIXVpzKITAi2xfIiQKWO4pmxk7k7rVgb16QNkr5K8Zqyu
         2FvUUDYS30HNuleyAMBAsiti1FiA4KIUmYWRam0hF6/WPAo5l1em1nQOzHx7uLR+G86M
         3uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733901105; x=1734505905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5WpHiQlb2sFoHGjH0ec7NDbzkR/Fn1ZH6iSMtuNv1s=;
        b=Yd2cWhEiUHf4Pg/Acve4OclIR16zhMXhbfrrCBs8QHgOQJgizS146tTxDWQ6mzA3GN
         skuN6z40L1RlHil7HEmutWyWasApCYV5wcHp2n1nB3ejNMNRCXko2nWYC/yFlCDNGkoW
         tRra5A4vKltXKiv1BPp5bvzV89uf22/sgNLvNzBl9XsquMgL2sHyL5hoqr3Q+X0KPa3H
         W8y0KULbXr0FoGUbakuj+z+9Thvso0Cupdjfr+OHXTvmfnvWcq8WEGeT/MAV6tpsSrEz
         9ZzuXvThl5USRbhPpjQqZudz5m0RjahwTRJcGuvxABJBI3lrFnTA9lQ+ITDzy8/A3Mo0
         DiyA==
X-Forwarded-Encrypted: i=1; AJvYcCX3DlFwUBMXzFdOjsTu8cH2Li+ojNti/ABBa7RmUXA34fVq3nF2jdVgBOuzsggRi6v4rrcq3c6p2c0L4ZRvF18X@vger.kernel.org, AJvYcCXGDMylVlvwMSvL87tDZvFqbD6cptiWycNsu9CcAclz5vVKcy5INu8A+j0e7N6iLDB672r2WTilwuWs+pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhMjlGZNcztlX21ufKdUQOJwp10hiUBj4QQIWbIf/N75Zlk3R
	ZajEcikwr/olMQ72j6tdTT+tepP6TPgtxIJLKqQaAxZRQ8RJ5GbTfXokggKV
X-Gm-Gg: ASbGncszfmz+EEKMQw78g7FZQ0xoKVAO0Ty6Uvp/Pudo8fZhbjr/g563BuQ6k4YIsoc
	u18A4hfP3YvzTb3kt31pLFKKyMembnLdoCe5CFIJa7Bnn7WcAxLhWjggtisQPYHQL/QTmx+0RA3
	TekKAxs+nhAwfr23KKo7PKrTQCwC8M10eqIWsLQy/jny1fXXrusafOvp8OF09/9mKSR5Aa0bZ2k
	5FaUFTzVWza97ZGx+70vLUXlefqZZNGEjAz+yMR55Tp5gyXYKMie5ILDhmjiBPSDZoVdaIOrw==
X-Google-Smtp-Source: AGHT+IGwzUXiPR7FeRWmb7w2A6GULhFUR/kJWqIJAOUFOAlWpL3IdZatXTfrxL2GqsbiMfxEP3zk6g==
X-Received: by 2002:a17:902:eccd:b0:215:a179:14ca with SMTP id d9443c01a7336-217785200b9mr30786165ad.2.1733901105161;
        Tue, 10 Dec 2024 23:11:45 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9f44sm100311205ad.118.2024.12.10.23.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:11:44 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Wed, 11 Dec 2024 07:11:26 +0000
Message-ID: <20241211071127.38452-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211071127.38452-1-liuhangbin@gmail.com>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_netlink.c | 17 ++++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 49dd4fe195e5..7daeab67e7b5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4389,7 +4389,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..7fe8c62366eb 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -568,18 +568,21 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
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
+		netif_carrier_on(bond_dev);
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
2.39.5 (Apple Git-154)


