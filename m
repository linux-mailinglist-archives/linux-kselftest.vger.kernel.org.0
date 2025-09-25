Return-Path: <linux-kselftest+bounces-42266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56378B9D354
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 04:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7B03A3EF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473C2DEA9E;
	Thu, 25 Sep 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYML3YRu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61622C355
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767599; cv=none; b=NZ5kJ4XYJPPGoIJ8tBjcoT0NITn8tfgg7mgCoUhoF+wvK22z3nTvyhQAiHyGDIMkb8VGOJSB3MYcf29mq814BLZu8bsPJ9T+CcpFz0HHTHUPh+D/XvP4ti7wezjYoKadCAi0n6POmxh8mN4x0i+5l0D1Tgp4Z3nKHaoLJVmhjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767599; c=relaxed/simple;
	bh=A0SYA/uGVqV0t12v78y7j6A0Qn1o9/UofWKnTo4rxks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSaZxMBxS/fJY0j4lLht9veXjrg4zfZ41RzhPlYUeY7m187fjzwVAAmg9YZdsXDsH+8qjYyFL3+41aA7OoV+K8drgtckjaqNviffmEBXq9qhrgmtuQilwWuldGEb04NUDzA8NtGpId6Fb6513oxaiAMhMPzHxVp7wwR3a640P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYML3YRu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f207d0891so527850b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758767597; x=1759372397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFI9CyYkDTQ36kWZc+gCQLPuFnUp/y5mcXpEnS25+DY=;
        b=YYML3YRusUXWqwYQe9I9m0oZ4xxZy92Gin7ShxHB5ncLMIG57M83nHmpVSQINvJQK/
         uI/uaXZj9r/RwpQrTqO+Ig4t06uSpMxQJv6UnAYWuxoZun1PVBx+EHi3Gli8GdKb/uDZ
         sc1vsSEVwC6dUiWjdSHOXU6ZMzkrqZoCGr8JstYJgiH1ciOt9zzoNqr4soga3+hBbHkK
         PK225ZMZ2+faLdmr0bBtCg7JOGBib4xo3jnC/2XSx7TRfU89OKNGatAKO9otyFzBCqTW
         youVfN/lzakAZjSUw5pqODqe3Tow4YRFjF95NDQh0miNbcL47vjDYetwwxiyTb9LTTg+
         2StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767597; x=1759372397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFI9CyYkDTQ36kWZc+gCQLPuFnUp/y5mcXpEnS25+DY=;
        b=tdbG4EbMyz6N6niXRqyCENI1quaK8eOrCIpS/mA+0VPaWQ1rZLP2WFqC3+Dh3vGCVa
         uG+roLZCE/28K2SkU67zI3FZ4u+17uPsrUj+eBNSE0OkmUC/fHJexenCeJ+CAuSpIPOI
         8CUL0BUID1IAsffMHTE4EgMGIDdEfJXLtixTWGaKJGuQ0hGfWqojK9BvYyi6iUuCr+pq
         CYG5Hm40aNRY/a5IyR83QqLaGJ7d4YSYPcXjB7QTVywWTkPGwHXu5oGHde+12u4RhckW
         mvR3GGrYplRWT4XL8xVMltogaGAXRRld+j7PC2Evmo/jP6ns0BadTHgFRvzVvlStE/B3
         SfMw==
X-Forwarded-Encrypted: i=1; AJvYcCU9bnaPaRrE9b02cv5ADhaB4hylRjCz9QHVVWjqaYYvy6K6wGuCiJM0AbLEo4z0zV0rbz8Wvo9BdoCBcm2Xrac=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbL+nT58/I6kVOK9A+FpzFv3ChfHgMsCkCjZLW93HgnPkNCnF
	gnpZi6h8D7mfivgBqFSK0LFbGuaL/oJtsvnFKhvm9RRFX0dl/5PvgKMR
X-Gm-Gg: ASbGncu+Ebbfg+QRzUAoj9MGA8zc5xY4UVkN+8BjUi6FG5hI4t8GoR1GCzxtU2h5tYd
	rKo+ggIXHvaAWlUvocph/GgqqLSZsuoOQ0TeSUJp21MQMsv7hRQii8tsWVi9ilradJ5pcx2ZSNH
	Mw7KPQJV7Ui5rz3FKQwlMjlyN5okQtBUsUN/tBgwp3vSm0tqvB2DKnN09/G7NJLTOWYIcHweLMw
	WIpJ6JyIw6u/vu4Bh1Ql4eQrQ3q1bU/D59Z6CRIE00n1NltC1hbVGzO/3nLlpG9CUzWdyMxnZFV
	l0dYCiD+ABlHbZSzwmMwdhvTtHLyZcGqPeAk/PgMsJSCtsPMXVX163Nk/90bHzCwkDVevQ7H1q7
	XhGUT5akPdoXHni46ovn4KX4tvheeqeIQVuUP/JzUDg==
X-Google-Smtp-Source: AGHT+IH8e6so5L+GLUmp5IFsgA7Wbe8X1CYUgfB3rRYj9V6GMkDn1aEkWIvP8u5OgMXiN0FPD+ogew==
X-Received: by 2002:a05:6a21:9998:b0:250:1407:50a4 with SMTP id adf61e73a8af0-2e7d1755812mr2265155637.43.1758767597219;
        Wed, 24 Sep 2025 19:33:17 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78105a81540sm125952b3a.14.2025.09.24.19.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:33:16 -0700 (PDT)
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
Subject: [PATCHv3 net 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Thu, 25 Sep 2025 02:33:03 +0000
Message-ID: <20250925023304.472186-1-liuhangbin@gmail.com>
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
v3: rebase to latest net, no code update
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


