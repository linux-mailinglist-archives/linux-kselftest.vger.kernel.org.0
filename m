Return-Path: <linux-kselftest+bounces-24090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4853A06C38
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 04:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284387A2D45
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0322D19DF52;
	Thu,  9 Jan 2025 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjB3oky0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA56199238;
	Thu,  9 Jan 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393313; cv=none; b=Z7w2BArbUWabQGo3joCSzekDbhwYSZoT8ON3qJvv3PNYSgqMrWrdM7D3QaOJclhO2ccfcamsJJ3g+S8xYZRLj4VTTQv1GzjRMqQdP7FuZSf96aFJ6zsDKgtkNzxMmNq6bmyvkxIj2uNSRC/IoSoeKSqR5dfa2OOhMNN2U6s2n30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393313; c=relaxed/simple;
	bh=1CvGJBdfsQrSZP0bq41YTjTW80fDNBCU6ihC5Tvay2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxCDmCxKNaTgxQah8kYW1eCNw1uUbETBfkCWc1uslzN3VFRrWwIZ7gojopQZKiSmBpf5Bxe3zqA/QIP6lulgLZTjCpH8Yd8APiDQYD78llUFwzM4S7EbMlLXy2FX6O9LUFiuUSp1O43Hx4jMIWkh/2Dmkx6ao0FMw+GGTDCOpwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjB3oky0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b8618be68bso33850085a.3;
        Wed, 08 Jan 2025 19:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393311; x=1736998111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXzhdavCNuMsnLueA0771kqTUjEAV7QKi1FIGuZMdYk=;
        b=fjB3oky03wUN23xEcjeg95z3rDtdSeK7BOIxlbOfsEz64uoVL+O90zeuIR3KFiYhiM
         EsLWSq89m82OH26tgYyrPaApPIdGYRPRQzuO3pdZYEpek/49ANuQGCeoBRsgCDKaMzuI
         G9mnIGSVL7xiZnz8sroMYi6OVNno9UE48R8iJmornYm6xsxkB4diD9pSQrKVmWA+gMX8
         ExF8pi6dT7EOWmKFnwFJe83dq6zTvby1O9NieMOUbLBp4jvE1nc9oCCIwzo6JyJZqgRn
         dEq56iIcGrPVvfqeo+fG4kAjQ+x5jML4FlisWIXE3tu8KjxJZSrUU4CqEwr3+S1/expj
         jPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393311; x=1736998111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXzhdavCNuMsnLueA0771kqTUjEAV7QKi1FIGuZMdYk=;
        b=IfvIo8ezOVwQj+fkLSO5+h6fTawlDxZgFAwxYDjWtkcpgmxozL40VyzD7jt2bXknmi
         KaZHeQKX6sMyTBO1nXIjaGzL89U87ufqM+LVYHN67Wh/0TGxO1xiwIio2uYRdcdzfY30
         Nufclb60pGHj8ISP+HqPv38CntNHw9lhj+TwYnUy3h6jsg3xAZ+sedbVp+yPOTKvpo7r
         JBNGRLuGoJi8KwIkSuOWsSk1qYg7ro0H2q01d2Kw9qh/OTJ1qbt3hMXAEdZrZl5ke3Xm
         YlPXQ6ng3yK5wZvpamDqnyOPGr2XUFqj7iWcmhbtQdTIa8qKdJAhVxNO/R6MOoU2AiKj
         6/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV4DZucK8eOL2q3k+3S6i+ptU3N1zcNlj31Gsa+VBfqqDk9WFnQb/yGyvK4cL9BRZdCgDutGQXK9AiTj2vjrjQ=@vger.kernel.org, AJvYcCWd8w1KyHqHuT1P0a2NXWLM2UQ88mJWmxlyW5hgAQsJRkvcrJCEy5rwpJJI3nV6TVt5FwytoTcd@vger.kernel.org
X-Gm-Message-State: AOJu0YziGZEm9gIqus5GoVCRWFz8fduJulH27p4Hqde92YQYoFwORQf9
	Dpq4o0D+w6j06bDzZFKgeyDjwxRNbk55BSZAFvmmIiTjnfIbrFk3MlIAd9wt
X-Gm-Gg: ASbGnctHJL1KHI4QrK3DXRQduUAHwXMRJcaoUlqVTiu4WiseUSnZL2qcEZWtrAjZODK
	ACW2KkYtVSHnCTxQCvmRgNVh5LgWA+oQe9hXk+tMGjmuii5400QmzEQ58mkp8ZOwNd0CxFSoSWG
	Kfrx7lXj/Tcfe2JANY/CXfX+g7xeWV6FeIkvlxaRIc7yDumif0bF262oVbTX2vwMevXC+teaXTm
	bHuuexHdgvr2Srx6kL49hdyXiQOQQX5qFMgNUpjPR//Asfe6G6ntfGx4g==
X-Google-Smtp-Source: AGHT+IGmGky1psL51y6RMRavI8fZGYTmcJUDQZkiQve7kzUZ0k4cwfJnjA4pFibfRMLOGuYp8Dkh7A==
X-Received: by 2002:a05:620a:1992:b0:7b6:de3e:1831 with SMTP id af79cd13be357-7bcd972f1eemr896165585a.9.1736393311220;
        Wed, 08 Jan 2025 19:28:31 -0800 (PST)
Received: from echampetier.lan ([2607:fea8:1b9f:c5b0::4c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35160c6sm25547085a.114.2025.01.08.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 19:28:30 -0800 (PST)
From: Etienne Champetier <champetier.etienne@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Etienne Champetier <champetier.etienne@gmail.com>
Subject: [PATCH net-next v2 1/2] ipvlan: Support bonding events
Date: Wed,  8 Jan 2025 22:28:18 -0500
Message-ID: <20250109032819.326528-2-champetier.etienne@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109032819.326528-1-champetier.etienne@gmail.com>
References: <20250109032819.326528-1-champetier.etienne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows ipvlan to function properly on top of
bonds using active-backup mode.
This was implemented for macvlan in 2014 in commit
4c9912556867 ("macvlan: Support bonding events").

Signed-off-by: Etienne Champetier <champetier.etienne@gmail.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee2c3cf4df36..da3a97a65507 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -799,6 +799,12 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_PRE_TYPE_CHANGE:
 		/* Forbid underlying device to change its type. */
 		return NOTIFY_BAD;
+
+	case NETDEV_NOTIFY_PEERS:
+	case NETDEV_BONDING_FAILOVER:
+	case NETDEV_RESEND_IGMP:
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
+			call_netdevice_notifiers(event, ipvlan->dev);
 	}
 	return NOTIFY_DONE;
 }
-- 
2.47.1


