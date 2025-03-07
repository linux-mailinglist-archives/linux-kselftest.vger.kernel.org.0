Return-Path: <linux-kselftest+bounces-28453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F55A55E31
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 04:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9392918975DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 03:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB053191F83;
	Fri,  7 Mar 2025 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y31wT/hV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED219049A;
	Fri,  7 Mar 2025 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317563; cv=none; b=HwheRDVe+rz9UeaV3bX0ZWkJn7+JYqesK1jWwTdLsgboC2t5vvO0PoNBPPYAX1eJD6ST3XElK/FPbpmr8TdtqqE4SEJXbHM7fHWo0v/QG88xHymOVIRNuuY8d8Nv8J4UmXVv+LMjhciAb9P83duLSilJ6kdXuA1z7NlV23PNFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317563; c=relaxed/simple;
	bh=9jcnBiMIEjCPY7QK6DHqfZ/zJ2duSB/1vtOU+cYGf5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpUZSSHcr4P4SmQXdYs+dpT2RK/ofDWOhdRHDhlB2zRnConxNB7mG45SZpBMRqaPWZtnSSCd4CTLBX4HFASe8fwznNzdpG5aRHM+iG9REopP8doevPp+Nnh7bbTnwXpK+fUztRx3rwRuJqAAFOtGNWLiYYl4akeAnmUvEIlj77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y31wT/hV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so300109a91.0;
        Thu, 06 Mar 2025 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741317561; x=1741922361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVXPe/IPw1lxQV8lI9bp/vRnBlqZTCq+2dNe5J1DRJc=;
        b=Y31wT/hVxxTRblb0OLostbJbf+3VbLhOy1AKJfjHLnFvqqvmAw8bLf6cnqy0p2kX8J
         NfSje4azOp32vLRWX7Ev0eD99RJRUz6cMvX1gqzZR6w6ThZfHHRjNc9zqGAAsG5VL/48
         nNceWhy/EDCLTAGE5HK9gGl/6gw8LVP8SCIAAt9nERmn+rBZw30VBxTjLKv7fd0uv1i0
         ZAzpFdO3i6fyCY6N7BkvJ5Obi/OmlprfzpWSVjZ2A7dzePfKPT8f96jt4nyqiCshrylM
         EFctzo308TkpPG1eA+lRNYQUpYZdg84jBnbauIAL/2Z0UrE9ud2RauOtuvPk7mxv0Y4X
         8C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317561; x=1741922361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVXPe/IPw1lxQV8lI9bp/vRnBlqZTCq+2dNe5J1DRJc=;
        b=JmW8eIngYlD4kaE5GTrXjop4kULW1urSnSKAd5nYpkL1rONKsq4H7/8gg5XkvyGQVB
         NS2Z82qiUO3b1JDzCs9bXog1dpnsT9tMFdkOJ+3HTuDXfG+SKMlvimLFTxE1emYgLO6z
         +eb7dy/r4rewDdFvpz62uoZ7O3y7LabEbc2cP434cJeiSvvZ1t0FD6xzWnYURjDfhmPD
         1/6i2kNabDu3ACaPThWREvjBUEdLekanOsNbxkiXwrq3JA6MxzqYbGwZntVDc3JBY02+
         8s83AR6rV6KTO+PnUwUrHbcoJ3ofsM/DMF85y5wCjXuU5Hh3LVwX1J1DblM/+zb6ZKqZ
         jCGA==
X-Forwarded-Encrypted: i=1; AJvYcCUXL6jzI4WhM3q2VcSJYdz+/Ag6CqgqxaV2j+VNtQyxisZPUPCEAA6Nkuvt7nsehvThpTk/9G8wvjLzWFs=@vger.kernel.org, AJvYcCXesuXUFwWEyfuc1I9P0nLnRvoNzNyEpxyB4ksET9wWZl3GdYO3UlkRcRksFDN2QVhu8TAnbHe38UpLzuDBGsxF@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQeGAYMpYuyuJlI6J1SqM4y05qNfQDKIGHLnnjy0+vQxhIMHC
	fP5hucG1s5j8T172wjen5KcH9puPzjh19iANq91dlQx1WO0UYSw/Ooc8KPT1Lj59Yw==
X-Gm-Gg: ASbGncuniKX2yWL/QzZFGf9cwAwHF7C0uSanTw/7GMJS+137EHszMRy02dt2AhG/ZmW
	No4ibFkzaozClbj/KXVExAKV5sVfqqJzPFLzZJCdxNzQz9PNmoigc9J2RMgnnhZPUeBRcDYFLwB
	3+J+/5ARarkb9Qf2N+np3DiQjShiYcemuUQcOyuX/F2iRTAZmxv1+n9RfdixJmMy6d+UmsrXzwS
	bn1x54ANfGnoe6WxCSLrbCvu4yOyY4IJj1vcHRWPihsVkftMFJoOo6mSy2eILnvHUrJ6TtM04uW
	Kcn+xN0H2kdhIHmPn4axiGpW5q6eJTQI8oyXYWIgiKhu0NGlc+wb87Woc9GExMKs
X-Google-Smtp-Source: AGHT+IEyrtYKfMbZllONi71VjxAuC6n5czwLwdDLEZhkPbV4VGajnC13vLGNxA3KYJqfPoUX3vxiNg==
X-Received: by 2002:a17:90b:3c8d:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2ff7ce7b230mr2540773a91.1.1741317560947;
        Thu, 06 Mar 2025 19:19:20 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5e2sm20013165ad.15.2025.03.06.19.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:19:20 -0800 (PST)
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
Subject: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin lock and some race conditions
Date: Fri,  7 Mar 2025 03:19:01 +0000
Message-ID: <20250307031903.223973-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250307031903.223973-1-liuhangbin@gmail.com>
References: <20250307031903.223973-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
a warning:

  BUG: sleeping function called from invalid context at...

Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
which is not held by spin_lock_bh().

Additionally, there are also some race conditions as bond_ipsec_del_sa_all()
and __xfrm_state_delete could running in parallel without any lock.
e.g.

  bond_ipsec_del_sa_all()            __xfrm_state_delete()
    - .xdo_dev_state_delete            - bond_ipsec_del_sa()
    - .xdo_dev_state_free                - .xdo_dev_state_delete()
                                       - bond_ipsec_free_sa()
  bond active_slave changes              - .xdo_dev_state_free()

  bond_ipsec_add_sa_all()
    - ipsec->xs->xso.real_dev = real_dev;
    - xdo_dev_state_add

To fix this, let's add xs->lock during bond_ipsec_del_sa_all(), and delete
the IPsec list when the XFRM state is DEAD, which could prevent
xdo_dev_state_free() from being triggered again in bond_ipsec_free_sa().

In bond_ipsec_add_sa(), if .xdo_dev_state_add() failed, the xso.real_dev
is set without clean. Which will cause trouble if __xfrm_state_delete is
called at the same time. Reset the xso.real_dev to NULL if state add failed.

Despite the above fixes, there are still races in bond_ipsec_add_sa()
and bond_ipsec_add_sa_all(). If __xfrm_state_delete() is called immediately
after we set the xso.real_dev and before .xdo_dev_state_add() is finished,
like

  ipsec->xs->xso.real_dev = real_dev;
                                       __xfrm_state_delete
                                         - bond_ipsec_del_sa()
                                           - .xdo_dev_state_delete()
                                         - bond_ipsec_free_sa()
                                           - .xdo_dev_state_free()
  .xdo_dev_state_add()

But there is no good solution yet. So I just added a FIXME note in here
and hope we can fix it in future.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 69 ++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..dd3d0d41d98f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -506,6 +506,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 		list_add(&ipsec->list, &bond->ipsec_list);
 		mutex_unlock(&bond->ipsec_lock);
 	} else {
+		xs->xso.real_dev = NULL;
 		kfree(ipsec);
 	}
 out:
@@ -541,7 +542,15 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
 
+		/* Skip dead xfrm states, they'll be freed later. */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			continue;
+
 		ipsec->xs->xso.real_dev = real_dev;
+		/* FIXME: there is a race that before .xdo_dev_state_add()
+		 * is called, the __xfrm_state_delete() is called in parallel,
+		 * which will call .xdo_dev_state_delete() and xdo_dev_state_free()
+		 */
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
@@ -560,7 +569,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -592,22 +600,13 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
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
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
 {
 	struct net_device *bond_dev = bond->dev;
+	struct bond_ipsec *ipsec, *tmp_ipsec;
 	struct net_device *real_dev;
-	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
 	slave = rtnl_dereference(bond->curr_active_slave);
@@ -616,9 +615,22 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		return;
 
 	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (!ipsec->xs->xso.real_dev)
+	list_for_each_entry_safe(ipsec, tmp_ipsec, &bond->ipsec_list, list) {
+		spin_lock_bh(&ipsec->xs->lock);
+		if (!ipsec->xs->xso.real_dev) {
+			spin_unlock_bh(&ipsec->xs->lock);
 			continue;
+		}
+
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			/* Need to free device here, or the xs->xso.real_dev
+			 * may changed in bond_ipsec_add_sa_all and free
+			 * on old device will never be called.
+			 */
+			goto next;
+		}
 
 		if (!real_dev->xfrmdev_ops ||
 		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
@@ -626,11 +638,20 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
-		} else {
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
-			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+			spin_unlock_bh(&ipsec->xs->lock);
+			continue;
 		}
+
+		real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+
+next:
+		/* set real_dev to NULL in case __xfrm_state_delete() is called in parallel */
+		ipsec->xs->xso.real_dev = NULL;
+
+		/* Unlock before freeing device state, it could sleep. */
+		spin_unlock_bh(&ipsec->xs->lock);
+		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+			real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
@@ -638,6 +659,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
+	struct bond_ipsec *ipsec, *tmp_ipsec;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
 	struct bonding *bond;
@@ -659,13 +681,24 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	if (xs->xso.real_dev != real_dev)
+		goto out;
 
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
 out:
 	netdev_put(real_dev, &tracker);
+
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry_safe(ipsec, tmp_ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
-- 
2.46.0


