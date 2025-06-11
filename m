Return-Path: <linux-kselftest+bounces-34719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653DAD586F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94AC3A4858
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE92BDC3E;
	Wed, 11 Jun 2025 14:19:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2B2BD5B4;
	Wed, 11 Jun 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651555; cv=none; b=TDEiQmlqYPcoTrEH8n2owofdd1+AptLZ4MsY2XX0eIAtm/AODpiOMm+AaAhp4b50XolBBlvgk8NdkQrIoyvKS9Y2zLiQUX8RgznZHocPa3BCOdABlwuibrT5FUlDx4c6wFnf+A+yCDAamHZJ2IgcJU2wI/nInyAV70iEyZhQEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651555; c=relaxed/simple;
	bh=4g4vBwWPdT4IgtiPcAtD4LEJ+GCF3RMDEty2lSNgRKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGdd0aRE3Dhv8uUzwu3kgDzJ1KjBZGx+NkF2MsgFERGiUg0+yxZ/OqAuXXoCRiZo102788u8wAEuXw1iVlMxu1Xc4tSW8s7jCoWcdb5Cb7lsqByqrp+5VHaY0aXAq8e163ZYoiCfV69fyA3HSMn9RZW+lPgnkH2enhMZ3CI+DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade58ef47c0so201066966b.1;
        Wed, 11 Jun 2025 07:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651552; x=1750256352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyGUnyAgFY+pvwrKu8sNKKhFp9R+q/qeb7KvVtPdSFU=;
        b=EzL12qLf+YKBb5ppiq/X/tCS6ByNf5i2aNGWEZOB319G15BuWzZ3LD6FC2fukQ3rDU
         A05QHnaeIwnmksPrFx4LEfzFWBW6pnhxmuRNvldW1Sc6SH5WDlvqKyl20TfliePRK5QK
         QwjDReSuEtS7AHRyrAQBQzMqUmue60tkf5G25IAQmcbmG7B6uzkmzIU7wHj8dCFYWcuS
         ZF5KsLBOA8DEiIt1xclyMA1Pv7D5BYfJ8E3BtTZq5sM/z6N2vx7Ct1kZu+RT3xmVuP+L
         smxZ4GZDCNUI6ZC2oz/C4WDYlKXQ4w0kDWv1YSXQuyqhfZiGPDYKlbyalLyQkzsAaoHK
         363A==
X-Forwarded-Encrypted: i=1; AJvYcCWbDV1TMIQ1+kW4LwhkDS7WIpqzdWXCGEloPb5NXXjM7gcv0hzCGqEweRkGQpbWFeNwDCHhSzSPvpF0IVo=@vger.kernel.org, AJvYcCXU7I3AlherL5VNkbeectC9O8hun1P1+6de5En845FQlyD6AR6ihAymmn1Z8zdW03dS8tnfNERImR1B2GgXwKu0@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjD0eSblu8QqFyOf0CZ0FTZ+irb2N2tHPOYPwV5aGiKC8F1nr
	lai2u2whQK69RGAnOG0qh+FA3x6lKxw1QeJFzdiuYUkv/WXktDjKie8ehbSSow==
X-Gm-Gg: ASbGncsZWBF+E7Iv/tOq+aXGdDFLAvYt4ZTe4f6oS6O+g8l7+s9vZCiOPE3A5xB5Qw7
	NGdhAs/reXMxnGCLqS7CF278My254cEXN93fMKnDtvfhPEA2OM/zXqo917tEvvYwk0kQPBoJPd5
	qaM6VhFXp0HKQaaoSxkFeWVuful7QAQJ/5V3gFbift0/Tj4NKhirzZigbgpSkeWHp3HiF3dP2oX
	EG3J4bkeygtUBOpPSmAvm0yXOM9rz9GSYxkqbnLnMykf7CTeyhQOMXHdhAaL6seS9P7XwFmIaBA
	5vxfwVz+3/DcyQ+vDgwhjdvAlM6YMh3/mYogoPVkP8UxIbbO5oTM
X-Google-Smtp-Source: AGHT+IFrnnWp2i0nWQ8ik4xeowC/mQaCysLjNojr1d1ev8T2ufTRaWOnjM+l9gVViA1UZC6kNcFDtA==
X-Received: by 2002:a17:907:3eaa:b0:ad5:2d5d:2069 with SMTP id a640c23a62f3a-ade8982dd3amr378670866b.13.1749651551413;
        Wed, 11 Jun 2025 07:19:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db576basm905398766b.65.2025.06.11.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:52 -0700
Subject: [PATCH net-next v2 3/7] netpoll: relocate netconsole-specific
 functions to netconsole module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-3-ab1d92b458ca@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7728; i=leitao@debian.org;
 h=from:subject:message-id; bh=4g4vBwWPdT4IgtiPcAtD4LEJ+GCF3RMDEty2lSNgRKI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZNxeY4KcqFpoSFDSF66ZvvJp0jceZ2mIuK
 loOnM6tejyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bc5RD/4rOGDPuKuYnXU5270wa0Rerejiwxd9kTqUWbxCgPRe1TIQ3Yq8ZUCv8AcyXyw+LfhhVFv
 BmiAscQRK7QCUk2zWE+ThXh55m81WIKzbB7VmbPgEM35Iuvt0Wlm4IkZ9JnkQl3kFrhG/vJ9+AX
 k5wDBwnBPiH3eEEIX9BOsnyDXTxEe1dzvX601t19F04i3blZkEmhO4TO73M7OnVrTkLEYSg6Kpm
 mbtLE3gw2tF4t7ZRIvvwrO/U9v7f+xD/4+Coeumh2BZ91YPIpfTyhDG4LracNE1+sPuqoUCmHCp
 spwGfCnxY3Ls5jl1PyrmveGwDXtpAxSEIdA6YC9MogV915fett/68iM/wC1W84YbSfs646npSS2
 zDIPGLu3wHOOl5Zv2LUbkbj13LKr1Jeu46C7Vc8SUr4JW+w1fO3uGzc2dAkQhE0+PVUzcizunBb
 VinF602a9n5E+v+2K4wgdEoXltGQitMu1cSY5YV1k9Sb9ffTRYFyEbEn/O0J47UVT31FIpwKLv0
 jvp9d/gP1TftlROl5/RmhxFxPbS7Ys3ONziinQVnrsgctOZvBDi7UnrGOKyEBF4geoxQW8vspJ8
 8i+sx71QaAiHAGBTJF+pXbBh98iXzhwhTkTqhT069BG9mw8WF5jSTYJXZCp3bBLcv019BCNdCKY
 QN93MM6yw2Lsc2A==
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
index 21077aff061c5..6741e5484f053 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1660,6 +1660,114 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
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


