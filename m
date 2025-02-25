Return-Path: <linux-kselftest+bounces-27421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE9A439FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD117C012
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075D26281A;
	Tue, 25 Feb 2025 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNrij+Nd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52929263C75;
	Tue, 25 Feb 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476471; cv=none; b=WrARrB2hyoq4PCYl4+ii7TOlPdef/5HQkgpHmrvzD2JVfi48nKxJStlbdGKi9y0Gv5ItdL2/A+spEyAktGYcU/+jk5Yy/15XJejo32aSFeU/rRPrgdCyS0FL67lvREwffIndX4D1brFHCHNvkKs/lmBhcJNokpysfXBCpnGvn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476471; c=relaxed/simple;
	bh=sQhxvoukCDtsyFQ2gDfGlhvbXHHwIBvtZyvewvnGC78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJCa8OCJxpNZRrfjK/Scg3g1lLxkkIPrFcqRPFZJ29U0kVAfBe6GxIFIPOHU9I4GIvThPyADdk1qRJkFKKwpJYUlp8R4Fc+fwtWBuejCpSmb6wTa+tJ6Yjr/dGeIclBHNRiKSxEb7BIDCAnLeOmOkA8jdBqUI6Vs5vTua0QPPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNrij+Nd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c8cf98bbso26770315ad.1;
        Tue, 25 Feb 2025 01:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476469; x=1741081269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKV50k5oKnw6MK8vZSME6ax/mJXjZVzGCmPzRh9r8Fo=;
        b=WNrij+Nd84uldIsr0W5xug1OQYHCwr/oFXpulXhRBxuGDrbOAT/26KY989D4IzAALN
         KpjK/FLOsdxPjgWH9SCHrDgs+pLD5Is8LKPRDwAZeQvlijSJnmfRqwCbOz9GYVvmai/O
         DT3ehffa0hmeSGkbinkWcKSyiCuG/IBsyTkiU8W+Em9sBsg1PGprwthFAkXWcKb01S1G
         LpfjNkLJOqKybimwWkLaXmjuiDx6qozNJHUgDpz4yJvyaclNFDJuLWxW4x2PeG1HfN8E
         ahtY68hoxjTcbfxm4btMYIkiJD8hLStPnc2YUc5UN8ZWbX4pJqVgnnOsalIgG9ARpGac
         TnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476469; x=1741081269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKV50k5oKnw6MK8vZSME6ax/mJXjZVzGCmPzRh9r8Fo=;
        b=YtJr93KpZCWwo2toZl6UXUzXXkdMfxr/oKcm7onNfkdOfY1MS98wcdC3PSeTTxLPgi
         tElX5P/vMkzr1+eQyvmMhSJsma8EVI4Abvld4brcnOaqTQoLE/KHZg//Zwjk/b13L/so
         ByIqRP+1h98RFQn6A1hmRSFFM2adhVataM90O7/0RlVPE8v1P0MdFT92gl2ce9yxRRsG
         mNpn4VMewzBI3Ksv3r7h7Y3+wCts7L3RVGnXnNiTSxborbq3LXKJfUpSd6T2RiMTfgej
         SdS8apHLKVTPaKjakxKQDERRD9tflM7Iy7Wd7XuYQlF28rT8iL53vdBu76eR36jf8SIY
         Jazw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJNOLzT1+jkeytjYCF8RJ0kXNF8X/8KhnNxD4iG4ijEV/plauOvM3QXrldajexLsvrggaAbZMXHuc+2CjtgKR@vger.kernel.org, AJvYcCXHCJI6MafDRDcna5LoeR0EiPjNnU31ZbrGmvMhmr2d23uOBXUk/IhNIdpIkID1zJr9DI4wBvCm3mY/zNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CNUT8PdPyyMxIk8SxIONB1XsLzY8i/55sM9bAHtJoDv93lvN
	8MCNH5tkaBR0g/iSsVSCg6UGYX5wIqXnY5gKkhDvZeSlZFnouMhvT7y3PvcBsNiN2Q==
X-Gm-Gg: ASbGnctGr88GKJ6gdX5RRcTChFY+cBTu37woYhDfrkbHMzn9oj340eyB2S1ejHPE/ya
	4NA/TdvkZDfHU3ymlBdRUYbheCgFrbVoVQxqd5F5RW4q+wKNHG6xZJTE4jlptUfdKlHxHhYwitk
	1/CvcvooanOIzKVJvORl0anG/GUTH2GphJHlP06d9ijSfUwr0s7spUh4Tj0IYUaTLScF1qlo30C
	JKDFZGcLvcAJQ97jLEGglZRy53z+7q0kaJWP5UlRzArKtvLLAvFYRnyxYWg4IIe3moCnpRs3sYn
	z34TlmTF1a30Lej16HhBR013epN43JCX9gOpFCKWfWXXzg==
X-Google-Smtp-Source: AGHT+IHGrX3RShBzXNqqV1Asd6wqOTK/PbOyHp8r7dSAjVFWnm231L/QjCTXrCJV5At0/kThynXQSA==
X-Received: by 2002:a05:6a20:7348:b0:1f1:432:5396 with SMTP id adf61e73a8af0-1f104325399mr871796637.22.1740476469357;
        Tue, 25 Feb 2025 01:41:09 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9e6dsm1065597b3a.64.2025.02.25.01.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:41:08 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 2/3] bonding: fix xfrm offload feature setup on active-backup mode
Date: Tue, 25 Feb 2025 09:40:48 +0000
Message-ID: <20250225094049.20142-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250225094049.20142-1-liuhangbin@gmail.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
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
index cc7064aa4b35..881d8d94dd9f 100644
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
index d54ba5e3affb..aa326fd90eba 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -713,6 +713,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.46.0


