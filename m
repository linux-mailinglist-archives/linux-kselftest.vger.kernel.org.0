Return-Path: <linux-kselftest+bounces-38288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1FEB1B160
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1DE3AE18A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540126C393;
	Tue,  5 Aug 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtzX9bs4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DA1E1DEC;
	Tue,  5 Aug 2025 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387223; cv=none; b=EkpXBIYrJlNcpohdSxYDtkiVwHnZmyt6rJ60W0JUImgtqb4F3N1UEWLSphuRDrvAGSduFEy/+heUMEFiwO8k5V1eTRkmaINNZHJ2FaRGRuH7l2zKW3nWIiTsatv9mRoVtVJ5qige33ciWg3y7ciaZbkb7SHYTc0qTLWzCLWA0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387223; c=relaxed/simple;
	bh=q5nd/Y5yuSgOgCjEuyoHPc24221GwfQa3Q44CfFaYcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKy8fNT6tJjTZ3yoWmFgBioXvXK5lQv7TkO81Ddr++3Do9ynBpCM6JHptNOiyeB213TU2wjfgSEcRvOYexKhFdFPSu+7EvKY1YlezGaL43PxODQQeilnykvlpllHbKqT8GzwzSAeHy5pzqFd7U9S7feKz3/w3zE25ALoU33nS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtzX9bs4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24063eac495so32002185ad.0;
        Tue, 05 Aug 2025 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754387221; x=1754992021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUgsuPqINcOFqBIUCBwIjSZ70h0cqljlgDls4syjBpI=;
        b=FtzX9bs4/l0jpRUG7iJMoTg8ze609xRgAG6DqhtdjRRSxD/3Uv7rnzDdkzq1R1Tzc1
         bAV1B1EDhXeIXdVqlrAz6H5LNUHPR1+Di2BQ2DkbMe9ggO97c46ZzC0yKZRC6oKKfFLv
         LW3exYy+RBZRTzPbKxSzIBWzrKUCZafNrkphDwrYhUW0Heycyf2EPDAq6ogstiDLJUtB
         SgsfmGR7sgeRuw0+Acv4xvxjMW3LRgbU1KmU141dlMo5bWvfquTWJb03lEi7oyYSTTQq
         Jn42/eiAXU2MMeDaxlCqu+98gqLDydxxPpdE9cVz3hDg7xQn9uIrjzr9ZlLZCl96XYav
         mLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387221; x=1754992021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUgsuPqINcOFqBIUCBwIjSZ70h0cqljlgDls4syjBpI=;
        b=otIxYjefuqknmPO16W3Zm67B4ZrnUZ8rKAi8owNxtlGuSQ1PDA62LlWHsKu1mOwjsE
         /YjejjcwBOXOWSkiaw4v/1U7ZNZN+fEDfrW2nkW6sBFrIkjqwAOTw131PCD0vnZcrBiS
         MUt1xRpQMVtgTFpj8UcY+5Hb9ddqHyJfsrb77QYoPTzadogGWyjqPf4ruqUGOgA4mAZt
         5HUJpM9ALRHiQEhdxFbKd75gX9UIClRB4gCRJjtV4twqtxQNccPd/n6bwo1dJZsGmScv
         kglpS9wOoJ32BtSKPaqvQSS4UDqWskIX4yf/VHivchnKcD+mBTECSZlHlmb7dSzLsSD4
         g8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRWhAW/rmBSglgA8/z1ft9/yiEx2CyyrTdbqDw3tvpHZ/LoAmCpjNpbIZf+8WUCs2jk7tBAUl2ofpllUg=@vger.kernel.org, AJvYcCVYkooBS56+mHhwhD2+Ff4H6PD+eYgxQ4EuGHuLwR1Xyvi5rD5XO2LZetiLumiPQ2RmOZb/Z8m3TulSVebuzjtx@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7TWIRm3emC0E4cr5vDzpDlt88mSzgwyqmOsSQCVtixG7Wo74
	AvVbAAAvQ4vOjKEOuiIk23pebW0ZyMP9q/3/hSipBBxfkt/9Hmu+EUzpffxNZoJy8qY=
X-Gm-Gg: ASbGncsRlqQE6SxpW/EfxrThWPyCtWjyq43Hv5iwp8ecKCC/kBkivNHR3x64a5g0EWP
	qXNBx0ocwfENORaE2L6Qdr/fbLRRdA+zyfK8oFEOFW7PtyxjxGxqfOEdc3jo5CkYq0NNz8Djfjf
	FZpvpJ//vT+2tZkK/aLPadbDOK1sk8VAF0o2/miquuTSDPqXt5h5meOXlgTZqK9XJr/DBvRNuSw
	9UA0Fvu2r2IWRyNQce45MtcC2bkE9HzpZEvGkhH7ie3X+NYuWKMrvgjcET7XMu35l3/zE69j00W
	aDsa0b7jOrI4Qb4PCkFX8HR5BRdJdRCrz7Za9pyJNuVNhnV7cJ1bR1lHAq4uUn+xMniE/zPeQEC
	5aib9fZX3hN75EaF8bx34g4AsvA7kRbu1D2rN/0Z6KRRi9zdSaTfgDlz+BA==
X-Google-Smtp-Source: AGHT+IG3kmCowGoM9F5ZzFD4Ah/8mafETXm7znqYBaxKh/jUrterNeQiIBH8dlZ64H3bc4KH3eAEMw==
X-Received: by 2002:a17:902:d4c7:b0:234:a139:120a with SMTP id d9443c01a7336-24246feba83mr188646575ad.32.1754387220899;
        Tue, 05 Aug 2025 02:47:00 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899d18asm128934875ad.141.2025.08.05.02.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:47:00 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 1/3] bonding: update LACP activity flag after setting lacp_active
Date: Tue,  5 Aug 2025 09:46:32 +0000
Message-ID: <20250805094634.40173-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250805094634.40173-1-liuhangbin@gmail.com>
References: <20250805094634.40173-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The port's actor_oper_port_state activity flag should be updated immediately
after changing the lacp_active option to reflect the current mode correctly.

Fixes: 3a755cd8b7c6 ("bonding: add new option lacp_active")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_3ad.c     | 25 +++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c |  1 +
 include/net/bond_3ad.h             |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 2fca8e84ab10..414fecfd2a0e 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2883,6 +2883,31 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
+/**
+ * bond_3ad_update_lacp_active - change the lacp active
+ * @bond: bonding struct
+ *
+ * Update actor_oper_port_state when lacp_active is modified.
+ */
+void bond_3ad_update_lacp_active(struct bonding *bond)
+{
+	struct port *port = NULL;
+	struct list_head *iter;
+	struct slave *slave;
+	int lacp_active;
+
+	lacp_active = bond->params.lacp_active;
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave(bond, slave, iter) {
+		port = &(SLAVE_AD_INFO(slave)->port);
+		if (lacp_active)
+			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
+		else
+			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
+	}
+	spin_unlock_bh(&bond->mode_lock);
+}
+
 size_t bond_3ad_stats_size(void)
 {
 	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 1d639a3be6ba..3b6f815c55ff 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1660,6 +1660,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_active = newval->value;
+	bond_3ad_update_lacp_active(bond);
 
 	return 0;
 }
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..dba369a2cf27 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -307,6 +307,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
+void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
 size_t bond_3ad_stats_size(void);
-- 
2.46.0


