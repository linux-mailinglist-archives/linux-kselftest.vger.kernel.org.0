Return-Path: <linux-kselftest+bounces-27420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8DA439FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B836717B00B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9C2641C5;
	Tue, 25 Feb 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjko5+IK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E42263C75;
	Tue, 25 Feb 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476466; cv=none; b=GBrguCSZjS/5xv3xjRZirnhu/VIubySzx8amcDpUsvihRcy7QCACfTjZK8ucMF/PvY/BO4cPxpTBymKjOK0Gyp7CZh8chHSstuwfmeuY7CMy82Ndq7Iv1L0KcMVkGQJmgC9e4/Kjw9rNKHbM7ZTKz0MU2SFMDGLI8/bQZ9oA8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476466; c=relaxed/simple;
	bh=BEzs8YbLaCpXnNQyZJ+tusTm4nslyHs9SxGIY6yBz3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuIdWr89wnSue4/dRPqv8IDCpNOvRZIYlfMuF2MdVyc1bjTxRJOFbh/c08xbX9/oQp0pQdpuf1a3IWthek9T+JqAM1HrhxATDN/bAnC6mo/1D1LV5fi+DOoYN4+nffVbTEajTJ2e4aplB8VnyDlX3TTY032uGIJGCIKwiiIw8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjko5+IK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ec47991aso73768835ad.1;
        Tue, 25 Feb 2025 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740476464; x=1741081264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCGnd0iVXOo+JNaWHHfQALr3MIKC4v3263hGTUjjNTU=;
        b=cjko5+IKqScFFM2o/7F7KghvtMFjYORKUGU+rUqDBVAH8cFOlg6a+WEHLocHgu9tEV
         uLQihiAjOBwmxNTRHSIaI22GY928jgh+xmN4bBA4jIiMTDuUgIzkTZnV+m/XsxkdRwBp
         by5iGZcIWDqLcLl2pA7CkGwK9lLBNURGwdcNP4DeI//0EqidhmW/NIUGILxfySoIERLd
         b/afRuqJ6WauTMS5SiwGngPjXE4H5i0NVYX/1zHk+rrN15UJPBBuxzjqYfaAeUUlDzpS
         G6j/dXNg5e1pB8fQMzV+QFyr+9Y5QgidaQ9XZWS5t9QWioh3hseZNIZ7oCMOghToovND
         MHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476464; x=1741081264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCGnd0iVXOo+JNaWHHfQALr3MIKC4v3263hGTUjjNTU=;
        b=o6L0CU50ADYSucQ3LsMe5Fh4PBp4vX9BtgtXBEauLbH7G0l4U22n6iQCdTHV1Smecg
         iw716qECQOSrlrd9xaBNZWf2X/IixHE47uKFFJFOq3E4c9Q/jVS3NEbC2eTXP3M+dfg2
         fdZZWCXcPvcXDP1cGUUN5hFh7oFNyhrINH56Ha4HiqSge5xVtOG1U6qooN9Y+UxaS9n8
         vqXylzfdCkNlhiktr9obEygLX8qUUkM7bjavcZuCxuT6m+fOFRZ/TLg17tg/F5b0hvtK
         kHfzI9dUXoi2IvA9Dp31rBALONXQP7n1FNe8TxrXJHpeSGGPtMrRkDUzkKFZUHm/j+UJ
         PQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgxeat5geXOPcDwoImnlVIYzFZmuzMwxP6hKKzsOuH3WqQrEQ0iO8kHY2yt80jpWBNjGWHZ/wdDe+Zp7M=@vger.kernel.org, AJvYcCWuH1H6WS1AOSQXNOp1c12SN5t/SF+kiHQD4LwCgqW8upknKlrIOgGfES7A3jHJy26rQV4LNp56cORtL6WF0b/d@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBNgyybCRPHjbKaPIm5w5W2t+Ph87NcndqyOGjSbc/rv2Nc/d
	Aqb8rc5lhjYAxgIccHJt1ytTht70Is7IAacsOd7RrEP5LayR63FQcxDHuHIbB7s/iw==
X-Gm-Gg: ASbGnctgAYlh1cZ/tmN6EhfVc64qldsr02/F6jSuCRMk8OLmACu2ffAbM51LpRxpqZE
	1w/l0yx6JajNLSxnJnYBK4z++dKijcOB6dPV9w0oNPgELv0xUwAMFZpHSuU26JWFxfODzLkFutE
	LQvRagETBq8SlmACEN0bWvCvkVGyHXpqM5gP+LndEmIQWDPTWYQ7+s7L8R0RjN+0UljqWOM/nr9
	M+HU5NgaUbsiznqNqQ7dj10cMv64D9nS/T9wiAIhIDSigbn3D/jmPphg0AeNw0lWV3lNMtrYSwN
	iW2lISp76MhM8uZUSkJZZzT1IRShr9vOZgQ0hI73PnfFNg==
X-Google-Smtp-Source: AGHT+IEFzn5DHnpazMBJ2UhcKkfBsGgPLtZe9b8aR3mBBWinCqfQBNuc3ZSZ0NUGYqjQZn+NYN5EFA==
X-Received: by 2002:a05:6a00:1898:b0:732:5164:3cc with SMTP id d2e1a72fcca58-73426d728b6mr28039130b3a.19.1740476463722;
        Tue, 25 Feb 2025 01:41:03 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9e6dsm1065597b3a.64.2025.02.25.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:41:03 -0800 (PST)
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
Subject: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for XFRM GC tasks
Date: Tue, 25 Feb 2025 09:40:47 +0000
Message-ID: <20250225094049.20142-2-liuhangbin@gmail.com>
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

The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
a warning like:

BUG: sleeping function called from invalid context at...

Fix this by moving the mutex_lock() operation to a work queue.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 41 +++++++++++++++++++++++++--------
 include/net/bonding.h           |  6 +++++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..cc7064aa4b35 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -551,6 +551,25 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	mutex_unlock(&bond->ipsec_lock);
 }
 
+static void bond_xfrm_state_gc_work(struct work_struct *work)
+{
+	struct bond_xfrm_work *xfrm_work = container_of(work, struct bond_xfrm_work, work);
+	struct bonding *bond = xfrm_work->bond;
+	struct xfrm_state *xs = xfrm_work->xs;
+	struct bond_ipsec *ipsec;
+
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			xfrm_state_put(xs);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
+}
+
 /**
  * bond_ipsec_del_sa - clear out this specific SA
  * @xs: pointer to transformer state struct
@@ -558,9 +577,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 static void bond_ipsec_del_sa(struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
+	struct bond_xfrm_work *xfrm_work;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
 	netdev_put(real_dev, &tracker);
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
-	}
-	mutex_unlock(&bond->ipsec_lock);
+
+	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
+	if (!xfrm_work)
+		return;
+
+	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
+	xfrm_work->bond = bond;
+	xfrm_work->xs = xs;
+	xfrm_state_hold(xs);
+
+	queue_work(bond->wq, &xfrm_work->work);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 8bb5f016969f..d54ba5e3affb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -209,6 +209,12 @@ struct bond_ipsec {
 	struct xfrm_state *xs;
 };
 
+struct bond_xfrm_work {
+	struct work_struct work;
+	struct bonding *bond;
+	struct xfrm_state *xs;
+};
+
 /*
  * Here are the locking policies for the two bonding locks:
  * Get rcu_read_lock when reading or RTNL when writing slave list.
-- 
2.46.0


