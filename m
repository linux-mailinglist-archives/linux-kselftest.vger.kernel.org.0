Return-Path: <linux-kselftest+bounces-28204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF903A4DEF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F315D7AC402
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A32045B8;
	Tue,  4 Mar 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWwnKI/B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FB1FECDB;
	Tue,  4 Mar 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093900; cv=none; b=mFgTkheI9liKDyRdw9hS8Kxpd+id3ZASZWr51cxVBIfyeDjJdUGXSAbuwcd0CmFmYRCdaDInlLpD+Ra/Hc/Hs+1Zr0Aw0PChQ8fgQNDOytEwQOUQUDGEzmBV/oxTiPK1kCx1f9O3GyID1+EVSySFlXop2Bc0A2V/2NcgnnArjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093900; c=relaxed/simple;
	bh=GwIopHlmLYklH7ZrM5n768kXiFLH4/g2LCd7tY6U6OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsVZHGmvcFbDG0197JlKM1syC3jBn4yC/oAghy/YvN2Mj0K0LTbHHmknzQ8yE6BDlmJYUCGjJC5M418Hp0L2BBYU/2hTJoX/Z5lhDRfgXVEDfEDITK+faOAehHbFtYZ+XPssDbpNH73zDlqfauzaA47udmilGjqZxyUyKUaAZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWwnKI/B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a3c035c9so34685735ad.1;
        Tue, 04 Mar 2025 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093898; x=1741698698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2MGJ8JMhppZQszfAJNK6dxuubug61GKu1wl2xvExPQ=;
        b=UWwnKI/B+b3WhWQIFq4YQYiYaeKV3N/DhL8jkf7Emzkj+MgCppslpeCAAwTk8IszUE
         NDd0QOTaJGrSY4VKzZNnrfYlxaOLn71g7OZ2uudZ5Rfcw0OsO4D/YbXe/ytminZKcwR1
         pLxu5LaOZNgPWpXo8j5eEcrlowqzkWID+6PvUvBgIwJOXDuJGhsbhZiQq9oWz9GR3ZvM
         kuNPLBbeYnWJCLnVElsDZpilofHDfg8uUC85oGW+LFfN2+lrbq9Eg8Pdfd+R5E+Ni/36
         Fx/t7bK7oT3hG/EkpQNHTBO7i7sz3uhExcz1hpzRx9FMy14woz+/CIYbmr6zNCNH8Ql5
         fDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093898; x=1741698698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2MGJ8JMhppZQszfAJNK6dxuubug61GKu1wl2xvExPQ=;
        b=H9168krt8U808TvtopWorpTaYK7t+13Mpy+1c/IHHsbCsnO9oeNrUpGMNmyvScdBeV
         eG++NlzhQvOobZlNd/cNRlEgaZoD5a5Bkhs+yVFUkdkm/meayI5GlCiqg44hPhMx6YSN
         fRIQjiRRItNlTXzlkGbfecinJl/8+uJkT3S2q217y5ce662p2hPChilaavqx81FOrAI+
         rSk1aWNcPPR/fl3kxx7ips2vf9ci95m0bBb8c6lLxTaxqZ6RT/+a/zQucigMQsV1/7ZI
         eeGzqrNVKzqKkNbMyVskkdK6NotbjM8dAzOfp+ob8AZOKLl5hH72FnoktkeqWqQItkAR
         20Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVdaNjKV5yJMBl9Yrx1zVpQTHC9tECYie9lWV+G08oeyI+IxPZ91rLqE12voa/TMWEqm/CXIIHbmGlAlWw=@vger.kernel.org, AJvYcCVkQ7G5YL95BdJKx3M2EwGAP8UmAOuyP1BgJ27DG0j0c+dV0fulTzaeEFS304U6IFRKMwm147CJLKpVm3GsE0BH@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYM21vDR8IuqK6tyveLdyjW5+fP3Qdz10Ic5kPXtoLPA8Lu9/
	tQsoBTqCOK8lXAA9ITpI5P6dQD34F7zWYgO1zq81I563t5MMO/Yvx0FcAjA9b9sEdw==
X-Gm-Gg: ASbGncsvbGPzsDBRtiIU4gWSRrrkz5k/HIv07kToNG1fACnV7/7g03HS8PknLJCnxkd
	XP5loRsElrxB8uHq+OOHR8pIohLY6oGXUCqZSDwE7sQ8lt9PDQGGf9oXukqxo+WZVZvcKDsjv42
	XNJ7x+EAK6YB2rdf3tx/NGnJ43mKGSzOQdZfLuJQvKMNNWZpgLac7hCslYpHsfIiEeDcbS0sVMU
	iLCz8NYIO2jrpVNxJYUtE1jjHEM0upuMr4nrI2BEtWCA21ChJtXJueFip4SI4lTPhEzkoZAuR+y
	hQCF21wVBeOsTksEW6E42FCcGoJXocD9UhAuJo7o3cBbyyiv2OltVLz2OFCHFNXT
X-Google-Smtp-Source: AGHT+IG52ZlRFTI5KXHWV6Lj5w9KGHPuiprlHAFZt8l6xOEbJv9lPvHAhkWe5c1sqhSE/kDxckP/7Q==
X-Received: by 2002:a17:902:eccf:b0:21f:892c:ea61 with SMTP id d9443c01a7336-223d978ef08mr57402485ad.19.1741093897844;
        Tue, 04 Mar 2025 05:11:37 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a668sm10824199b3a.30.2025.03.04.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:11:37 -0800 (PST)
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
Subject: [PATCHv4 net 1/3] bonding: move IPsec deletion to bond_ipsec_free_sa
Date: Tue,  4 Mar 2025 13:11:18 +0000
Message-ID: <20250304131120.31135-2-liuhangbin@gmail.com>
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

The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
a warning:

  BUG: sleeping function called from invalid context at...

Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
which is not held by spin_lock_bh().

Additionally, delete the IPsec list in bond_ipsec_del_sa_all() when the
XFRM state is DEAD to prevent xdo_dev_state_free() from being triggered
again in bond_ipsec_free_sa().

For bond_ipsec_free_sa(), there are now three conditions:

  1. if (!slave): When no active device exists.
  2. if (!xs->xso.real_dev): When xdo_dev_state_add() fails.
  3. if (xs->xso.real_dev != real_dev): When an xs has already been freed
     by bond_ipsec_del_sa_all() due to migration, and the active slave has
     changed to a new device. At the same time, the xs is marked as DEAD
     due to the XFRM entry is removed, triggering xfrm_state_gc_task() and
     bond_ipsec_free_sa().

In all three cases, xdo_dev_state_free() should not be called, only xs
should be removed from bond->ipsec list.

At the same time, protect bond_ipsec_del_sa_all and bond_ipsec_add_sa_all
with x->lock for each xs being processed. This prevents XFRM from
concurrently initiating add/delete operations on the managed states.

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 53 +++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..06b060d9b031 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -537,15 +537,22 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		spin_lock_bh(&ipsec->xs->lock);
+		/* Skip dead xfrm states, they'll be freed later. */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			goto next;
+
 		/* If new state is added before ipsec_lock acquired */
 		if (ipsec->xs->xso.real_dev == real_dev)
-			continue;
+			goto next;
 
 		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
+next:
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -560,7 +567,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -592,15 +598,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
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
@@ -617,8 +614,18 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		spin_lock_bh(&ipsec->xs->lock);
 		if (!ipsec->xs->xso.real_dev)
-			continue;
+			goto next;
+
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			/* already dead no need to delete again */
+			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			goto next;
+		}
 
 		if (!real_dev->xfrmdev_ops ||
 		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
@@ -631,6 +638,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
+next:
+		spin_unlock_bh(&ipsec->xs->lock);
 	}
 	mutex_unlock(&bond->ipsec_lock);
 }
@@ -640,6 +649,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -659,11 +669,22 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	WARN_ON(xs->xso.real_dev != real_dev);
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs) {
+			/* do xdo_dev_state_free if real_dev matches,
+			 * otherwise only remove the list
+			 */
+			if (real_dev && real_dev->xfrmdev_ops &&
+			    real_dev->xfrmdev_ops->xdo_dev_state_free)
+				real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			break;
+		}
+	}
+	mutex_unlock(&bond->ipsec_lock);
 
-	if (real_dev && real_dev->xfrmdev_ops &&
-	    real_dev->xfrmdev_ops->xdo_dev_state_free)
-		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
 out:
 	netdev_put(real_dev, &tracker);
 }
-- 
2.46.0


