Return-Path: <linux-kselftest+bounces-34896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19868AD8A8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D0C3BBD8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0B2E339A;
	Fri, 13 Jun 2025 11:32:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A622E3367;
	Fri, 13 Jun 2025 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814321; cv=none; b=Wo2GD1WeZ4b1TheDKhohGI3ATueyCJ/H6BImrxVjAEDmwtvwsZrNpSKsYo/TqUlX9ynWFGQBxaR/laBUTpkUxlsd2I6OoY0Se4209wjbFiDjwfCtxy7dGJ7t97eSjQNP39jIA9EGrMBeTWs0+/CQG5bfQLyR/gCGOnTKKJ2cx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814321; c=relaxed/simple;
	bh=nG9lqbera4cWIvLyPAaGuSITzB8a1kH3fjDNlCEQQrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En6TiXaespewfKi/DsmtoWsHaNdVzYwprLJSknOBDQJf39kSjARnPG+z54+hitWrHp+HnmY5yBFbNKEzV5chZw6voJDtqYxlt2tOzWeEKtBU/QHUiCj4kVzbf8Z6IN+o2S7Azv1OseJe+Fgo2t9DPK46QuZHmARXHHn7ZIWl7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adf34d5e698so39576566b.1;
        Fri, 13 Jun 2025 04:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814317; x=1750419117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KffISuF4N28NQHV5ZELr9ntg0njf9qfPssK6Px9zOCs=;
        b=a6buflKrqZBEl/iYeYQojAQvPhiOsE+8/6OqpuEuMZGrAaX0Tru7MUUHqg8oTRZlxl
         DR6F5vX3vNpTNm87rznavbAlqg+IXs0axl+Jbqm6jLsxYtfRE6qXZtjSgEVY8Z5aJhlm
         3IWCZxoI/v1u41whHWqjM4a/ZEdfvRBUuDoyPApJL8XVFWOb6MQe8LHozOiHV/2nb3p6
         s9JuW9geAJC6xxWFIDuv1bzJkhLRJ5/CFAaaW72DMCVZaByMvSwwjCaIBPWWvCutPiJ8
         2Lup4+KR0si/XH++66LbqTeaeUdBIiGaGK2R+BXd9C2jR2cJIvnPyUXNZCGv/cjsNf/o
         JuvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiCgTNc0xq6BQOmCxQcbpNh11WzSbgq8rp3hb8qwaz6g6tWV3foCBStGhNoHMx14st1ypABicrFmM9wmU=@vger.kernel.org, AJvYcCVespusU7AOrMzDrSMU+DP4Gtwq16pXcCYahS/UYK4qFGmXfOse5+0aUIqlmof4aOHrtJ7Thj3f1uRbfjPP7Mr7@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMPYthxiCTnDamjUSdygXdHrhyD961YtKkqfzO7NwSzY8ZdC4
	dF0V/sTR8Hwkrn953MmpT/LMYlStijWYwElsm/bEJNkWUyjeYt9YlrDjeYj6rQ==
X-Gm-Gg: ASbGncsPdqG1IitgfArwL95Rq/yhqOz4qcSXL3xc2Siz+w80dcmY32hT0hCkk9V/sQl
	4+1YmKNRlNh50CVPwHRtzQHZ2yes+j3DY39Oba2Zt3EJspQ9tbXIo3Dv4u7wUszj6DecQzIj5L5
	K9YLAtT/KEX86Dezl76cuU1FxGJlVsYjEYSQMdYBbgcSUp2praz/1ZUzSn0fr/Gh2T0JfDTPp/i
	Ag4YbHXznOVQ17fOLYoNy+VmjDf0JIEy449HigNfqmSL6sKGpZUGDHUo1DF7L9IE2HjNYszqhHs
	PeJqDM6B0ZDUY+BhL1Qt8hEMuVuxq5E2j8gI98j1/qbGJYOijxNd
X-Google-Smtp-Source: AGHT+IH6Wj8krt+LQbLYv75e70wBnZYtFTCh29git6uwmbYYLmNh8Va8CRXWI1zL4lvBQy1E8Xj3bQ==
X-Received: by 2002:a17:907:9813:b0:adb:2f9b:e16f with SMTP id a640c23a62f3a-adf54d06fecmr29613066b.16.1749814317077;
        Fri, 13 Jun 2025 04:31:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897c397sm111501166b.167.2025.06.13.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:56 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:33 -0700
Subject: [PATCH net-next v3 4/8] netpoll: move netpoll_print_options to
 netconsole
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-4-0752bf2e6912@debian.org>
References: <20250613-rework-v3-0-0752bf2e6912@debian.org>
In-Reply-To: <20250613-rework-v3-0-0752bf2e6912@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=leitao@debian.org;
 h=from:subject:message-id; bh=nG9lqbera4cWIvLyPAaGuSITzB8a1kH3fjDNlCEQQrM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlRIciDLgRf6W+3uDx/fAs4R9xWTs+Ai1MB
 f1ZCfvpxgSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bSfnEACrR3C3JqL4fGxgc2Qo+vu348SJrBUE1kM6l4GHkIsr5LXTwCaYt9JYyHZiRfyqMZELfQS
 UyMi15ILegvr/+iSAR3PeQJzC9+di/L3OZxGlGpTq1N9iXJeLLaH1gkYpAjnMR7rrkdsTkp+eMv
 jGkAVbrkO28yI0BnICq5fVo86qeRrewiqNh9/E9lYbrX1qlNkOZxKPppbwhUKpxFchuggl1uESs
 SSv75bfU8fBudgRv/Pwq++PjEjQT2h38OXOORmAHTJ65+GlrGDEAlKWs1LKbs4o6XHDdkhpg3VG
 e+ZMC44CjSZ1vY6wt3k/BtHdLNYIu2iZnFDb084oRhvf2TP4HiBb5iTuPsWoluMrjEM8h651QIf
 1gsS2TzGnNieJKiSVUAZpKzire1hnrD+vCqhzrutZZBVc0dV3otO1DoBuXyDHgAadhV6FnEFOf8
 dzCvu1vO1kNSjyI7jf66zZWO2YA4Nqc3KK/bCF/FKMyGUoA+OMEzAWMy8NpZJos9gFW9hN2IX/k
 E+cyrMKqm+NbJwKliMRCtdK/opJTrsb4sZle0z3I2KByjVAcSWi0IuBAwXB/An2n+KQ55e1aAvt
 6rwt/faXosW/XcdyRzMIQ5dsxOF5T6gvvO5AKFJ8Li+beS6cFfZy4aZXWoM9/GoEHI1ubE6kfl5
 xz0m38ypb7xQjcQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move netpoll_print_options() from net/core/netpoll.c to
drivers/net/netconsole.c and make it static. This function is only used
by netconsole, so there's no need to export it or keep it in the public
netpoll API.

This reduces the netpoll API surface and improves code locality
by keeping netconsole-specific functionality within the netconsole
driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 17 +++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 17 -----------------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bc145e4cf6e72..71522fb0eeeef 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -278,6 +278,23 @@ static void netconsole_process_cleanups_core(void)
 	mutex_unlock(&target_cleanup_list_lock);
 }
 
+static void netpoll_print_options(struct netpoll *np)
+{
+	np_info(np, "local port %d\n", np->local_port);
+	if (np->ipv6)
+		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
+	else
+		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
+	np_info(np, "interface name '%s'\n", np->dev_name);
+	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
+	np_info(np, "remote port %d\n", np->remote_port);
+	if (np->ipv6)
+		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
+	else
+		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
+	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1b8000954e52a..735e65c3cc114 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -72,7 +72,6 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
-void netpoll_print_options(struct netpoll *np);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index d2965c916130d..07c453864a7df 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -492,23 +492,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 }
 EXPORT_SYMBOL(netpoll_send_udp);
 
-void netpoll_print_options(struct netpoll *np)
-{
-	np_info(np, "local port %d\n", np->local_port);
-	if (np->ipv6)
-		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
-	else
-		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
-	np_info(np, "interface name '%s'\n", np->dev_name);
-	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
-	np_info(np, "remote port %d\n", np->remote_port);
-	if (np->ipv6)
-		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
-	else
-		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
-	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
-}
-EXPORT_SYMBOL(netpoll_print_options);
 
 static void skb_pool_flush(struct netpoll *np)
 {

-- 
2.47.1


