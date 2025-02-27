Return-Path: <linux-kselftest+bounces-27721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3FA477F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7234E16507B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE7225408;
	Thu, 27 Feb 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Lzl7aa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F213A3F2;
	Thu, 27 Feb 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645471; cv=none; b=B2TrwuN8FAmob4lEW2f96kffI4GuHVKDu72TZkhqYCrS3h4aD74PaDpW3BpqYjAlHg5VOJ7K2HnDoE6G8nNfgE1/id9foGz8unqpBEJS0/6GJp/34l0mCLQS9imVvCVYTkqEN5epvZyq8U6onVQqZS6q8/E1tSu+DuU3iIi144A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645471; c=relaxed/simple;
	bh=FUCN4zwqzwUHXMTsfI6Umx43gU4SrLSJl5E8NH+7Ryc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJZPreaI68PmGX2tlDp7pKii+Aj4w/NiaO38b9wTMbnht017mLbng1YNI1LSmB6DOlyliQSQyoV9Hh5++3VCoexEY+avLSpCAQRQNvumM6gmWltngefl/LPFV4b3MroYj4rVJB0mnfWlrlM7nJLTsUbCU+bgA+jroQoAwV3Cbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5Lzl7aa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22355618fd9so4906375ad.3;
        Thu, 27 Feb 2025 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740645469; x=1741250269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POO98shsHT218eCsS+l46Fq7lGdF3geGqLU2HfqrWas=;
        b=D5Lzl7aa/N60H7wixIyqM+amSoI1yrv4S18qe8zzzLH7lZrN4C5XQa2CNg8b2be2No
         6oTmUQQq2trb23H1uyjdXqBL4MY4DAvqe8fkNfMUBuA2JMSaJbtGGFwVcSOyq5wbhFJ6
         bQcqbAO1ikyTnIwkE4BO70os2CwqEtUnP9zDjlzzocaQTMDUJZ4cC0P1yVvyLLHapTIO
         0vrJc44GW7Di18Esuom4rzG/fIG2mRz1HXk8x6u1k09QsNqR5P2MC3Y9bpptKdJ+REJZ
         9MkXjyoqKfODZ3Yhj2EWKVG/t2VYXOP2zGl9MFJBMNa86vvQD6alfJDCPuJcSebw8ogS
         RhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645469; x=1741250269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POO98shsHT218eCsS+l46Fq7lGdF3geGqLU2HfqrWas=;
        b=l4uT3QAYqh5tvdTXc40hz/nMPQwQCdZFeSQ1IJqi0QBQ6Ke3rRX0vBlPMmbiwMFzqY
         o0v8ip904QnfEK+dyZQeG0tXwvCAhF3Rq81ljeh4Xfkj1ajFixvnufGjryNVI78Ls03n
         3Z+qUZ5izWx0oHZ8G8+WZ0RUiWiMZTY3qWVtdWn7eOhx5dYejMI7L0K8UfLtlxDDTGoE
         7HO2SDXnp4ZAb+qlBeyKAMFQ0S2jykWBNUC/9yLYXoDW8qWosWtRJ8cXpPr7OBesfump
         jvJEpywEI22TubtITcEaJwcaid4z/XZABDcEyxCFZWnIXT9HSEUZKSf7VU4Jo1nNyH/N
         VPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUnzn23Jk8D4bMWeFIqhwCvpbCJ3NjhfAAMSm5ceKEARBNa8hiUO1H3E8HftmlYR7JbulVDmzqMvD22hgTGlep@vger.kernel.org, AJvYcCXD/oxZmXZ6aTz3hTB4Dgyke8LQTvnQEfFN93kn3iYPIn2yvs2r/J6n8edVkkjxeUlUw2Omhtn38WLPinQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7BhD91aw5CUR1Wdhi5ZZhpWj6vm/7kphClbvpXJ2iSdTFfqz
	d9BRGD7fJ3TVA3rJx01valPZCy7sAHBSgVmWHdpJFmtmIhsfhqKtr4RFbYbZG4pqgA==
X-Gm-Gg: ASbGnct5YTr0BBFSEL1WOVYcwOs9WamYYqHJOOMSuCymr4fl70nuCvhR50xsn2QpE8u
	Zn02zSFcnM47AI96AyxVh/O91AGYrJ/bPtp/FXXAvmvVkxiVwPEmVySrZErXyfRhbC9IGrLac7w
	GPrk0fD4A1AU1OXc7dOvB9HuqIT/eQ185AiZwiPRzi6YxE5h1IezkY33QZOESOOaei8wHkzcxjn
	z4fb/niZCwTnLJ3ghhjMm+h9ovZZOwYW42np2X6Tb457q1B8HwIWbN4eseQybm/Bh4T1cBbYBh/
	XcEgH093QnVvHQyv/g2ZgoThKJxJyD1lAHEXwZl7wgEcxw==
X-Google-Smtp-Source: AGHT+IH15zUOpSP8FoKXQI43JIbwCv3lersqJIZqvYpNy9A/WdQwA3PB84QIYu1E5PJAnycHX1KUww==
X-Received: by 2002:a05:6a00:84a:b0:725:e4b9:a600 with SMTP id d2e1a72fcca58-73426d78ecemr39393097b3a.16.1740645468967;
        Thu, 27 Feb 2025 00:37:48 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec7esm966796b3a.153.2025.02.27.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:37:48 -0800 (PST)
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
Subject: [PATCHv3 net 1/3] bonding: move IPsec deletion to bond_ipsec_free_sa
Date: Thu, 27 Feb 2025 08:37:15 +0000
Message-ID: <20250227083717.4307-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250227083717.4307-1-liuhangbin@gmail.com>
References: <20250227083717.4307-1-liuhangbin@gmail.com>
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

Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 34 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45bba240cbc..683bf1221caf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -537,6 +537,10 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		/* Skip dead xfrm states, they'll be freed later. */
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			continue;
+
 		/* If new state is added before ipsec_lock acquired */
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
@@ -560,7 +564,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
-	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -592,15 +595,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
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
@@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
+			list_del(&ipsec->list);
+			kfree(ipsec);
+			continue;
+		}
+
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
@@ -640,6 +640,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
 	netdevice_tracker tracker;
+	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
 
@@ -659,13 +660,24 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
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
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
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


