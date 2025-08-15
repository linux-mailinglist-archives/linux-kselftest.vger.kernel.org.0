Return-Path: <linux-kselftest+bounces-39060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2BB2790D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DE316F522
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE132BE7A2;
	Fri, 15 Aug 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ7oQnmG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37822BE054;
	Fri, 15 Aug 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238819; cv=none; b=k91lj/4rMxWQkwL41hbMtshEtFdpAulJSCgyupmpdoabLvYEIuXoNYqZe2PIGu5+mssq/PKGtqUSpzEFQf2Ug7JIs8+UgXC31Q0wNLJkU9CvW/46z+R9QiW9H+J5ECPA3hbclyeQk6ocrcAT1uhCy0qDRAMwjTCX7OfekLZmPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238819; c=relaxed/simple;
	bh=lK5zkef5cKqd23qXzdQvroNbSbdGLd4vAGXqaVs9VRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPKjMa8BUaZwdmmav7myCfn39Hp5rHO4BLvo38HJjMJqdPiQXIM7htsbqrKfAMiNl1+/Xg1UO3JKGsO9L0HmfY7VTuKRccyzhgJGuf4Us/7pAfyJh1K32K5Fz0OIatBr7NgSUYozd/AYE+4KcQM8NvHu2B9+ljmlB8Ok0jPnyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ7oQnmG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266b2368so1233619a91.0;
        Thu, 14 Aug 2025 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238816; x=1755843616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXBPJFE070kbLr6SjD+Vna2EUaNdA1XNDeA15UUUetQ=;
        b=NQ7oQnmGAfEyRbCqRQvOgfstHwkI9y3rjQrlOtxnbXmWyZgm5010va1NSqjOUrGUVz
         bgCS4IPqWJa/JuIW8IPHjRv9dAtULSlHF8GRF6LmVf1m7V53jnN0EsdEcj41rnhIX1iw
         75rl9ZG2gbpXkP+7FbOi2MzTwF6zzNOotHpuk63sgxJnJbRTouEfzsiHRjUFCEUa1jBT
         eZnxfHMRh7X3cCsJ00ICBMegqG1pnSN5FOge3+vOzQcNVAstXWXRNz+/vRJN7s9/IVQO
         1dg//92cVkeCxCytaH4nEuA7ku7pp6/dFnEWAj1J3lrHCcN1ozJdv87bkkyuQWQizYDm
         dFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238816; x=1755843616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXBPJFE070kbLr6SjD+Vna2EUaNdA1XNDeA15UUUetQ=;
        b=EWsUBDp/icPHU32jk4bC4v5dA3zRN7YCrS1SsWXzhgL2Bckx/BA0IYkwXdCZp9UuHj
         3UsnD3GR1lJr465OJ8vdVi+mf5py+MXjjPal89nxM1B17uzgXLIbFmrGWTS+3J8YFGGs
         snnspYV4s/yRfr/n0whsGO4VyF3ZrlWRRr8VC71rvELiXuhN6D+ZuQL6hbCorJEkGuQ7
         /GSTfreVfC1ZGSxLeW4K0OUQp3o6wcBAll/w5epMNx9B+1YHzBiiE/AJwKBaDuNKGI3F
         xNE+23vgATHQx5oc8/JKCiowd+pPeRQLo/9Hr3dNPY4Y4AAcov4Eo4qnuvGZstFwBmHM
         nc0A==
X-Forwarded-Encrypted: i=1; AJvYcCUsUviGq1igAGs0+zFpH+qZu2D5HIk65mkyw5Owrgp2IbZOAwznEQ4ufEfb8S2MjMTZawxsfip4T+9Gpr0=@vger.kernel.org, AJvYcCWfdNC44ILO2d2sHpDeFx3LRsvnifWtUNFhYbEtk31te0T/Wi+/KguIghrhW9rqLGBwM9Xk+GfvLP2qY+vsOW9d@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJ+QEPh83jf04S+WmlZ7Yx8jQ7nOzRMkKSdjuRp+UlIXmobfr
	UMo+INyVOP4+J8JTaRTU7V+MRwJlK6unwaPBQJIQ+lpzCHSS2qzqLzofZMMXzcYV
X-Gm-Gg: ASbGnct/OEL/W0+hxcvnfeptE1P8oi4H4VsXNDca+S/RyhI2iQa6J0cTxMd/LOHv0/e
	3BUu7oXafTGb7G/UhjSWSJBniHxYF8COQ/ySFymgXAwnC4DX/KpQNNBONjqOFcFbgjSvmXgTH8c
	BUIzrELERmhseVrVccRd5FZPPLIQnmvA4pa2lPbHdChVS3nKpVrkfBpfgFXgTNMM5K9YRcjeh5l
	HQ+/JuyzdXXHB+agPp52r/UD1IvxRdegIZXjKYYhsp5BcuHuYGYFvTTernJ7OWFK1ghuvnQK0sD
	KmrfKC0VX6uPb+fRhCYR/gXZ5kImBwwjIoma6ARJTgL4keFb88dB1XsK2yLzmS7zvmK1GJnfro2
	XBkP9EYBBA07WNiRVsPtiV7vGBR9hahF8SkmAZnpppQ==
X-Google-Smtp-Source: AGHT+IF5/cA9kDJRJAps4NuwCaiWI8kJ9VWzISNdOQMCKTkjR2rcc96cntj6yxmHbzqPeS+m5cerEg==
X-Received: by 2002:a17:90b:5864:b0:31c:c661:e4e with SMTP id 98e67ed59e1d1-323421866f4mr1598609a91.33.1755238815851;
        Thu, 14 Aug 2025 23:20:15 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76df62sm425206a12.41.2025.08.14.23.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:20:15 -0700 (PDT)
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
Subject: [PATCHv3 net 1/3] bonding: update LACP activity flag after setting lacp_active
Date: Fri, 15 Aug 2025 06:19:58 +0000
Message-ID: <20250815062000.22220-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815062000.22220-1-liuhangbin@gmail.com>
References: <20250815062000.22220-1-liuhangbin@gmail.com>
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
2.50.1


