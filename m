Return-Path: <linux-kselftest+bounces-34601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4FAD3D14
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E55F3AA614
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACD241CB7;
	Tue, 10 Jun 2025 15:18:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277532417E0;
	Tue, 10 Jun 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568712; cv=none; b=qfU9XD3tB4Sd2u6iiHjpi+Q62rPNeiYYdyOiATCPXULEtvx6ftZH7Wpbc3ihVl5279JGg2HO5lxTzRW61yzopwcxH6b56DU1EoUdSiLuSmBqAV9BGQLN0KK+mUYM+0cwtGIinrYq8rJ/kVGnzSiBO1TJpgO083DoZP7dsxVzv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568712; c=relaxed/simple;
	bh=ELE6/E7HccXbM89haD8jxqL/F0Q13DuUMNnMP95XilU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0KUiUe4qWkhq/aed1rpZMoureQhkAktH+CS4PLXUXy+YxJYc/vdIavXDDQnMb9TdvJGhDQDYppZ9M+fal9e2B9wZYdNhG05+p4oHDjuESBEg/8gvpjEQF1cNkeLtWCFeAusNEqrDnI7GKIYt1CwA9qfFeZezJlqxfCgPG7La2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so767353666b.0;
        Tue, 10 Jun 2025 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568708; x=1750173508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNJBJN8ruAzkE4jdoJqoCEdFnnUo4AIPbizdSl6cvmo=;
        b=Mn5mVGlWH9kkjMRdrUYBgrtct6Z2mtrygiWYZEt9qdNcs1wyxfWgZ1FdiwAmdpZ5Lx
         2meceLEDp1QFiaXYiDVhG3AKfIORzHc6RIvFYnWlR9RJITnD//wG5cwo81acjFWdRAUu
         M8Hd0ri/vb4mTEQnAUF/x5PzPKDNrvJUOgZIvMpIbZ1vCvSA4Lje0KFJWBhSJFTImuV0
         rx1eCKswh5Af1QvwEeJe/uGW9eyixzPpnu8C6HNRu0X48DVbKVlZAHVlKSMkH/TsJ+HD
         6UtswXI92fr1irYKKiPXHbeYg0X6V68FElxiSv7Frb8g8uye7Mjvc09R3w9tJirNz/Bv
         ZRCw==
X-Forwarded-Encrypted: i=1; AJvYcCU/moSMdixBLXxgcWOE5vqRNpJ7PgyXB9tYOhhn4BrC3cVgM+O44DMzrii90rTtjterJ+jn8PozIDEtrMI=@vger.kernel.org, AJvYcCUVVQlZ+6DwobGqDCSc6Meg5WK+KK3fyWa71EXIRmrEyVE27nVZDPlWh37Q7DZX5AalFUTEeSukL8WAN5k9EUYs@vger.kernel.org
X-Gm-Message-State: AOJu0YymYQCsMA3MAnkyDpH5NEB/zg+HqAV+k45k+JNVmcGgaqolwB88
	FeaHoPqEL/oR+7ysW8L8BanFjZfe2Y3HpIg0LB1ziLkfEICHruPf885S
X-Gm-Gg: ASbGncsFvzbMPjOGVpmsTXhYXMvCrKn6HLImXNM6zS65jvJPfdvoCh/SFXEAkIy1v3n
	Jd7usreNG1wEuWn8A7wraafhoWZQl2r1GWXjLx3jMkfB2///PHbSPeVD03tt/psCiLEIxwBCled
	bUlJEiC3EzcR2Rg2Zc1tGzKMC62yMeAdtcTVnYaV3hBtQtUQuc1XWl8OpNWFiNCM/w3ot4LXxc9
	7dTUND6akmToB3ZBmv0+r5nXfTLV9lMLG6EG1j05gYL6Q1ACMvnXxMfvuW181MXGTFT7MW/pAxM
	4P4rBBT/QVK6gfRZxQV0Z7KJA/O6x5Iii6S5ub6Ed/HBiuUOmPHH
X-Google-Smtp-Source: AGHT+IH/bV9DJxyKz5+T6dTRQy4Sn0VEPk5y+gTzwBJWQDTFhmSBF8uQ0vi3o5o+0c6GJSjJItqjUw==
X-Received: by 2002:a17:906:dc95:b0:adb:469d:221f with SMTP id a640c23a62f3a-ade7acdf3b3mr309023766b.31.1749568708195;
        Tue, 10 Jun 2025 08:18:28 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c676sm747742666b.105.2025.06.10.08.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:15 -0700
Subject: [PATCH net-next 3/7] netpoll: relocate netconsole-specific
 functions to netconsole module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-3-7cfde283f246@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7728; i=leitao@debian.org;
 h=from:subject:message-id; bh=ELE6/E7HccXbM89haD8jxqL/F0Q13DuUMNnMP95XilU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+MkOFwNSv1yN5uCINM0P8BOJ/1wbKCYvRq
 lufpo0WBFKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 bZVeEACkftbYtve5Qa8RKaWKwGyfomqoPuGcKb9Zr065TkDg8msJ5F5/a9f3XdNaBLLLKBLbnOZ
 CaV8JmFo2BBZv0t4sW7ilRC7vysJYUNm4VcLgIj3XKdLJz7jO/Zzyd6W9W5utgJOXpPd+ntk6eq
 uMcDIqhnp/DfjjcZhBD4Y8qJakOEjUMy19bBXH1SSPsochCbD8e9RNjblNG1q3T8DvCUFHoXzHg
 /OAUXzHjg+tEN+L3G/cPwTYCFq1p5h/cTIYsxRSLGElvZComk7YONpY0mZGNR5szP3kuROWOrE7
 NCi2/GBXlmx/qmHcB5weQzrpwCe3mCOfPDYVAUU1rwtAMKmD58QHmZLi/PKv1B8n/rS0ZL/jed+
 Yl4ik3zZ6Dx07JFwuXx5WrqLBl50MfEHHWpWjdiU+JCGxLSaxLbpzDfb9upyqOpQLk7aYg6G05d
 qO7FuMlwe86SRFfm5CTXSSBx4uF8PuhdUAA++KI+wJE0GF2pR9nh02xnk8fP2JhRE6DtKjnQi9x
 SGALidFLHgnd+iFrkenH8Fo27r2TdWqzdNMNfz+EwwxwqRorpabX4DB/IudjlPCdX7GMBPS1CW3
 bKvz3LTchmw1yiEwU2QlXtBTR75KKBoIn+V6E1RtyC6+mS/1lIeFJXNyXTQESSiuyV6ua8hNCJ1
 yrQbP2n9PbsFHKQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move netpoll_parse_ip_addr() and netpoll_parse_options() from the generic
netpoll module to the netconsole module where they are actually used.

These functions were originally placed in netpoll but are only consumed by
netconsole. This refactoring improves code organization by:

 - Removing unnecessary exported symbols from netpoll
 - Making netpoll_parse_options() static (no longer needs global visibility)
 - Reducing coupling between netpoll and netconsole modules

The functions remain functionally identical - this is purely a code
reorganization to better reflect their actual usage patterns. Here are
the changes:

 1) Move both functions from netpoll to netconsole
 2) Add static to netpoll_parse_options()
 3) Removed the EXPORT_SYMBOL()

PS: This diff does not change the function format, so, it is easy to
review, but, checkpatch will not be happy. A follow-up patch will
address the current issues reported by checkpatch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netpoll.h  |   1 -
 net/core/netpoll.c       | 109 -----------------------------------------------
 3 files changed, 108 insertions(+), 110 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4289ccd3e41bf..07424ae4943d7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1614,6 +1614,114 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
+{
+	const char *end;
+
+	if (!strchr(str, ':') &&
+	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
+		if (!*end)
+			return 0;
+	}
+	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (!*end)
+			return 1;
+#else
+		return -1;
+#endif
+	}
+	return -1;
+}
+
+static int netpoll_parse_options(struct netpoll *np, char *opt)
+{
+	char *cur=opt, *delim;
+	int ipv6;
+	bool ipversion_set = false;
+
+	if (*cur != '@') {
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim = 0;
+		if (kstrtou16(cur, 10, &np->local_port))
+			goto parse_failed;
+		cur = delim;
+	}
+	cur++;
+
+	if (*cur != '/') {
+		ipversion_set = true;
+		if ((delim = strchr(cur, '/')) == NULL)
+			goto parse_failed;
+		*delim = 0;
+		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
+		if (ipv6 < 0)
+			goto parse_failed;
+		else
+			np->ipv6 = (bool)ipv6;
+		cur = delim;
+	}
+	cur++;
+
+	if (*cur != ',') {
+		/* parse out dev_name or dev_mac */
+		if ((delim = strchr(cur, ',')) == NULL)
+			goto parse_failed;
+		*delim = 0;
+
+		np->dev_name[0] = '\0';
+		eth_broadcast_addr(np->dev_mac);
+		if (!strchr(cur, ':'))
+			strscpy(np->dev_name, cur, sizeof(np->dev_name));
+		else if (!mac_pton(cur, np->dev_mac))
+			goto parse_failed;
+
+		cur = delim;
+	}
+	cur++;
+
+	if (*cur != '@') {
+		/* dst port */
+		if ((delim = strchr(cur, '@')) == NULL)
+			goto parse_failed;
+		*delim = 0;
+		if (*cur == ' ' || *cur == '\t')
+			np_info(np, "warning: whitespace is not allowed\n");
+		if (kstrtou16(cur, 10, &np->remote_port))
+			goto parse_failed;
+		cur = delim;
+	}
+	cur++;
+
+	/* dst ip */
+	if ((delim = strchr(cur, '/')) == NULL)
+		goto parse_failed;
+	*delim = 0;
+	ipv6 = netpoll_parse_ip_addr(cur, &np->remote_ip);
+	if (ipv6 < 0)
+		goto parse_failed;
+	else if (ipversion_set && np->ipv6 != (bool)ipv6)
+		goto parse_failed;
+	else
+		np->ipv6 = (bool)ipv6;
+	cur = delim + 1;
+
+	if (*cur != 0) {
+		/* MAC address */
+		if (!mac_pton(cur, np->remote_mac))
+			goto parse_failed;
+	}
+
+	netpoll_print_options(np);
+
+	return 0;
+
+ parse_failed:
+	np_info(np, "couldn't parse config at '%s'!\n", cur);
+	return -1;
+}
+
 /* Allocate new target (from boot/module param) and setup netpoll for it */
 static struct netconsole_target *alloc_param_target(char *target_config,
 						    int cmdline_count)
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 72086b8a3decd..1b8000954e52a 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -73,7 +73,6 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 void netpoll_print_options(struct netpoll *np);
-int netpoll_parse_options(struct netpoll *np, char *opt);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9e86026225a36..d2965c916130d 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -510,26 +510,6 @@ void netpoll_print_options(struct netpoll *np)
 }
 EXPORT_SYMBOL(netpoll_print_options);
 
-static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
-{
-	const char *end;
-
-	if (!strchr(str, ':') &&
-	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
-		if (!*end)
-			return 0;
-	}
-	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!*end)
-			return 1;
-#else
-		return -1;
-#endif
-	}
-	return -1;
-}
-
 static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
@@ -539,95 +519,6 @@ static void skb_pool_flush(struct netpoll *np)
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
 }
 
-int netpoll_parse_options(struct netpoll *np, char *opt)
-{
-	char *cur=opt, *delim;
-	int ipv6;
-	bool ipversion_set = false;
-
-	if (*cur != '@') {
-		if ((delim = strchr(cur, '@')) == NULL)
-			goto parse_failed;
-		*delim = 0;
-		if (kstrtou16(cur, 10, &np->local_port))
-			goto parse_failed;
-		cur = delim;
-	}
-	cur++;
-
-	if (*cur != '/') {
-		ipversion_set = true;
-		if ((delim = strchr(cur, '/')) == NULL)
-			goto parse_failed;
-		*delim = 0;
-		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
-		if (ipv6 < 0)
-			goto parse_failed;
-		else
-			np->ipv6 = (bool)ipv6;
-		cur = delim;
-	}
-	cur++;
-
-	if (*cur != ',') {
-		/* parse out dev_name or dev_mac */
-		if ((delim = strchr(cur, ',')) == NULL)
-			goto parse_failed;
-		*delim = 0;
-
-		np->dev_name[0] = '\0';
-		eth_broadcast_addr(np->dev_mac);
-		if (!strchr(cur, ':'))
-			strscpy(np->dev_name, cur, sizeof(np->dev_name));
-		else if (!mac_pton(cur, np->dev_mac))
-			goto parse_failed;
-
-		cur = delim;
-	}
-	cur++;
-
-	if (*cur != '@') {
-		/* dst port */
-		if ((delim = strchr(cur, '@')) == NULL)
-			goto parse_failed;
-		*delim = 0;
-		if (*cur == ' ' || *cur == '\t')
-			np_info(np, "warning: whitespace is not allowed\n");
-		if (kstrtou16(cur, 10, &np->remote_port))
-			goto parse_failed;
-		cur = delim;
-	}
-	cur++;
-
-	/* dst ip */
-	if ((delim = strchr(cur, '/')) == NULL)
-		goto parse_failed;
-	*delim = 0;
-	ipv6 = netpoll_parse_ip_addr(cur, &np->remote_ip);
-	if (ipv6 < 0)
-		goto parse_failed;
-	else if (ipversion_set && np->ipv6 != (bool)ipv6)
-		goto parse_failed;
-	else
-		np->ipv6 = (bool)ipv6;
-	cur = delim + 1;
-
-	if (*cur != 0) {
-		/* MAC address */
-		if (!mac_pton(cur, np->remote_mac))
-			goto parse_failed;
-	}
-
-	netpoll_print_options(np);
-
-	return 0;
-
- parse_failed:
-	np_info(np, "couldn't parse config at '%s'!\n", cur);
-	return -1;
-}
-EXPORT_SYMBOL(netpoll_parse_options);
-
 static void refill_skbs_work_handler(struct work_struct *work)
 {
 	struct netpoll *np =

-- 
2.47.1


