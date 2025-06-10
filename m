Return-Path: <linux-kselftest+bounces-34602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F750AD3D0C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A1A3A4257
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6832459F5;
	Tue, 10 Jun 2025 15:18:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3E2417FA;
	Tue, 10 Jun 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568713; cv=none; b=qUo35FLeEUrLUQCsdhkQTSnXHa9rZ8rOpqQGZGAHrqb/FKlvrA6XtNqPwHmdEFyW0KkYIm/LLnomJ13c1rtlFkaoYl5dXCdvouAcydfWdptqb7MoSTiNn4tfNQeOuHge8Cc4hULomGgwvObxzf98ouqwTo+2lFTQdvu1b9G+r2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568713; c=relaxed/simple;
	bh=r2O8/+01a6kXz62r/eNtYlumzp/QwLzjW+M3wmiEa5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N12DQnOhtMrriTlTO8WG7UqIf0vgmr1dc9R3n5qyFhm369lm1yeHDSXBDIeKghB2tb+Ekd/gYi4kjucN1d9PVq8f3u/jcOyEgISpWC4C3Xa5qpknoYFuvjCwZmUHYjatA0wQgrI+v/C6m/7qw9LdeDr4yfXF0U7Wb+jMART6sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so10257550a12.1;
        Tue, 10 Jun 2025 08:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568710; x=1750173510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsg2kGUHoFjE6B+vxs4Ti6GqKpJ6HFVNeSy/lG/YiIo=;
        b=AZR+RCBhTjovRf00b+HBGfRjmSXPwIR7xijtsDQ1i4u4VuY+megBgMsTuk7znIPbH4
         NplkZGcrNtWi7//N14xhUeyq/1CH/KEPOxaMeO5JVgwF8mg3Os34lpL3OkHtGx/qKpPX
         mwSSmtdIaoBTdTkLjq2HzrTjqP2lB5KSUdLEA9JQMK5s1QpYrczVxea3bCcjVr/nmuzp
         muqeVY9WmpJfa3wRGTfPzIV9HsieSmpGZDC0wmkI9sCYaLprergH43ochN8rNG7hERxu
         n8nU56o3SLMrmDY1c7YTIes0s9BQS/P64B3xOyb/ZCcfFvwwyHncNC0Kr46c2euKz5Ea
         cQjw==
X-Forwarded-Encrypted: i=1; AJvYcCX5T3vibmirc+KU5dL3KotYoZ2rUq2Xj/lqES8xLzbIsyulsMHj3pfgFDSRozJd0yEpQ7g4bCoM0h+8uDQ=@vger.kernel.org, AJvYcCXnJGfnjZgO0vk0K/eV4jGzBAnx2y+szAglXnbExO3Z6jIHV5vERBf9mGZtB/SKSRJy0bj9Cn0fJcKsKL8B/xi7@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNayzV7B2Njk/4LpsvFqjt32tojtOFM+q08gpMmFqJ5GBIqbT
	9AU5Qlc3V9KmYtADVVjNOgj8EaopzbMpCK8NN+/ce5siMECyhHQ1tKCj
X-Gm-Gg: ASbGncvYx1UBtJuQkOhJI1onhizHO6lcBMLqtsxJ6VRvEBBFWPZqWpgeJ/VsZaXzC/3
	WinRX/5XRxXt9c4OIMgITHkUbS9w62/5wAPKKmui2IAoTg4cdFg+t8cJkhKijrYn6XUvgqf+F3y
	N8VG8bYe4WXXHKtVbopoFP7LVCKHbslqBTfusSlY55sWwTKc1aia9z7KktEP4Q92ES/04BX7DiR
	L0TFbpnP/Q7JeENKp6ReUlYz6vG0hwmsMGLsNZSvOQ+NJiopNPsJ711cHAD1dgDvl9weji19SSG
	fsmZG1XxhvdnCLF+9aqRDm9ehsCrsjNWR3W+S9NtFvbueyVSpW1k
X-Google-Smtp-Source: AGHT+IE01H2VJzfwk1HF+AmCT+4+vQlEfXzYxIXaP4lI+VyRSq7rBaxTyCXLBQGJjHydYzzkOwi3Cg==
X-Received: by 2002:a05:6402:34c8:b0:602:346b:1509 with SMTP id 4fb4d7f45d1cf-6077351388emr14409988a12.9.1749568709713;
        Tue, 10 Jun 2025 08:18:29 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607f162352asm2925389a12.71.2025.06.10.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:29 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:16 -0700
Subject: [PATCH net-next 4/7] netpoll: move netpoll_print_options to
 netconsole
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-4-7cfde283f246@debian.org>
References: <20250610-rework-v1-0-7cfde283f246@debian.org>
In-Reply-To: <20250610-rework-v1-0-7cfde283f246@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; i=leitao@debian.org;
 h=from:subject:message-id; bh=r2O8/+01a6kXz62r/eNtYlumzp/QwLzjW+M3wmiEa5A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+Z5mWouBpT45Ksw77SzERNAdeUKmi11FFY
 iZR4Pfb8IuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 bb5sEACIETr3C5O3Y6X7Or98khZoQczSvYoR8VAzHIcdllIgHFgX+j60Z7WQ5+QcbBZDR+yskuC
 hfVBWf7m/OQvXpVOeG2eTjDEVERlEKJ/SkkB7sq7Tku6+iIGUdmjs2U02KsS8nb+wrZj7CUiK+/
 KQw2KtzIvxT1RP9t9yIELU6K+r+NSjDDesFokF6nbXHXnskWvanneQMn2EBDzwO/fbsLXvHO601
 E42CNzbYzKFu3+TqO2l2bOYj/84Jp8NawMdgUs9u1FAuBwVcT8K3XcqrkK3QPT/oCyAIVSk2cUr
 teqnzJYNwIUFJUG3MFySRCsPPrZqW0CIcwHB1IyFCB4ab/L150ugrukarVfN7uDuUGSIqi7G7nS
 DAdSrkpvm8yqpMmZKyYKOz0uxVSDBbau//WDdFONH60td+mWV7WT0RqBZ91j3ekIoEovSknEdbv
 r2y00pFJDJGfru6JqQx8pTKvXSmdvAmJ7kbX2tVZ/ZieYMxK79Ty6K9GVVuvfMtGbc22RMZ2ywB
 MadCrcUIejb3g7+iiqcMssf2jxNzVFX8Nd99Qmt50nTdLBdRXI+R8OB9D9zjkPdtX3G7Q4cj95B
 TMx57GOh4H8wArsz8Xmkey7BBhW5Eo9p/HddHqeBFvOnT3sQmGUBhgJeWVpe/SVoaGzhbZDvWwR
 JFNlta3NbQmNDvA==
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
index 07424ae4943d7..18e482b28c427 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -273,6 +273,23 @@ static void netconsole_process_cleanups_core(void)
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


