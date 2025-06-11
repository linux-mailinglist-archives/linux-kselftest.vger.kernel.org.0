Return-Path: <linux-kselftest+bounces-34720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0812AD5874
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A76C7A94B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6342BE7C8;
	Wed, 11 Jun 2025 14:19:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C32BDC2F;
	Wed, 11 Jun 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651556; cv=none; b=ULbScRy8nVJzNHcxJaAlnka9ke3v93vhqlWu4qao6W6/BHOcO2JtpKG53zagte6I6Qwoc2ApleBjbjOFIkO6loTKqvYpIR6fRjBlAS3MTcxgPxxv22jmnIRmHiv+tlrCF0B1R8CnXAanGwJ1hYKr0Wg6hmG5GsyPotRt0VlThdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651556; c=relaxed/simple;
	bh=11HeW/BW2ezUf62qSDE6k77RuJurRYrt5Fv+ask0ZJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OP7WZY8TrTiZue1+GRKYreUsgzm9Yn9OL9fSDeUCYRTMre9SJyYjy6mMS0DWd6fnj80jWoTYKtVFXbW7PFGnqt/HbvfG2kJgb6vHgrGGk58fUyaZIKiXDPgWZ89T0IWghpWLKKqW9689zTe0+OuVEd2xdlJM9XFG2vB9v+0bSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso1086831066b.2;
        Wed, 11 Jun 2025 07:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651553; x=1750256353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wE1ZdjeMGd/Lj/Y789gUtgoVV9g+RCFQuvjFrwgVVjM=;
        b=uL4jmpO4XV9UW+Q4siJ4q5WdZ9wWSc9dPXo3g6LcEAeOAYCSbCnA33qOBDSFZC5mul
         ogrzCMohLL/JbV33miOH+Kxo7C1slKzR1eG2ufVL7dQshh6+rZutNfC6YUx9vrzXDWmx
         iw2jZGND0F5H4NBDzukXw+FPKCfnORq9Pp3kzMSBex9Pg4NshuQDx9KruLxxsefgl0dG
         ZsFoWjFYRKM0kjiIE2MdnDRaN2MLlp4FdcMvZUIi7W7L/JbvN91bpW6CdvF1wZENlXpo
         bLeCpl+TTFjFLg5WRn6xJuevpCXFL7WbDLrcynHtPPULaPfF0lkorrvdIahq/twNc1E6
         RYsw==
X-Forwarded-Encrypted: i=1; AJvYcCVmihr92j23UolFNtDhWK+qyaYyKKa5GdGQ25W84GIa0SHgtO3o7FtD+rmV5VRc/NygyrHzNRAZRs7TpVlKHl+r@vger.kernel.org, AJvYcCWCoUn9iy3orhJMS082Phry9nYIOrq5FPA0JNm+IwXQNQXdJTRzd6/lRpT4/MnWjX8mjaX3PD7wiue1EaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8u8YDo7IzP2pv4RI40LTr8jgOoRH5D3yL6ipZ8TA6oTlFGpm
	YiqO9VI3ZGjrCh+99t1tXpP3KEaeU5Xs9vIlckhEwqoBi6Fzb9FFJyvw
X-Gm-Gg: ASbGnctQ6AR4ZPbt3Xbfrem3q9DgNfXE6YceqwgNeMfRAV+94DoqTvtx1UIRi9zMZA+
	NfS9Dz5nqCq75ys1f1SOf1Jv3OlktLKNR49r6SmfXUja4BdoBQkWL5/yOK3W/HMaWzf5KsyPrXq
	1asvHVIZ/OFAC2Y9eaje+/ie1ykNSYH+ZkDtp+6Yo2R5oWNNyaZ4v6jZe69hSQWaOrTjnDGryWw
	XUgCaLt+VEGVRnIdN7aIxS2lpS9nQcKaKlBMWo8U9ppaCm3jFaxSe6hXZDsI/bI4U/RvrBPUzS9
	aY2DdtfTWDrIIFEfzOok+W3QzradB3LJcRc9Q/McuTu8Un6cjF/W
X-Google-Smtp-Source: AGHT+IHYmJfgPQWJPOravoqqPH3ZXtzqmUX0D4vOQzypu8zXhzAfCwgK5q9+Dd6ArMdXfwmozPfr2w==
X-Received: by 2002:a17:907:3e09:b0:add:ed0d:a583 with SMTP id a640c23a62f3a-ade8950f8b6mr357647066b.19.1749651552829;
        Wed, 11 Jun 2025 07:19:12 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade7a3603b3sm300867366b.38.2025.06.11.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:53 -0700
Subject: [PATCH net-next v2 4/7] netpoll: move netpoll_print_options to
 netconsole
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-4-ab1d92b458ca@debian.org>
References: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
In-Reply-To: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=leitao@debian.org;
 h=from:subject:message-id; bh=11HeW/BW2ezUf62qSDE6k77RuJurRYrt5Fv+ask0ZJE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZHy6mYXrfk0iJB65wJDRUgJC8nY4pgyba6
 3+Rk4T3s7WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bQttD/9sfYt0sIOwnj/7Uhcl7yG0ypktjEpiALmspOSQ1IE4t7aR1RyBi5WfTE3xyKnYvaxrd1Z
 H3N/16cCH98nvnEx4jqQjOp1sWLiyeeKuUNa91vckRwVmFtNtG6cL4DYboM3177q4My7V/M8leD
 AaxNd0+H2P7dY1NaSkM0BQkW3YDBQKiI1Mxd47jmj20TJ7GH6GAVwcGcaT4RsAFQubSLSwqkw4V
 ZHTQPhGBtBYjirYFth3XSAgzrJvkiE9T+WC87xYmQf6JfsjUwMV0XDs/mdHiGFsEVL24M2iZs0/
 v6k0i+hTdf/FKLJKn69P/rIEYcAYuNNPnGvW9cd7811R3unM5fVCjYaywYJimLy80Wrh4TTs+yv
 NzBbG/RQV2Zrx64PjtCH31kQ1BT8sfQ3+xIh1XC2zG14J4CuwNCGXhQE1qT/zqq8mG+7oME9Tu1
 LjStSVeJDfqrFeqpvazkUqdwM5dsx6oN7d8rvLtMPTBdmaRx2uIlHqbhgQtf/0RZ0UCZO5kDtUo
 zQTkqGJiLO31W3Tw4uAOACp4tAgK0qM3wy/caaXW6pgynTcTI1M7t/G0vVHoT2qgp1B++pRHxKn
 XVltObmSMHot3FoiGniQ26eqfhlgvN2ktzMsLdrrphBqdyYeZWWSYrIfnqY6aCR8tgJAwB7ADBl
 gT+HhVvhs9XaaAg==
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
index 6741e5484f053..1b8f9150eb350 100644
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


