Return-Path: <linux-kselftest+bounces-34895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0DAD8A82
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168A1189DCB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E72E2F1C;
	Fri, 13 Jun 2025 11:31:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D32E173E;
	Fri, 13 Jun 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814319; cv=none; b=DX74R6Pk44e8pU2u5HauKVUJdo8197Tsrtm6V1AaEWSRTQHCBrYomBmh9+WVykAlY+q/7wYFohONfLNYMA2vFOae3ZfUmsgIabOUrJDE3z1P6OwKgQkHhRuEGROzQUJOSd2Puj5dSZHLD4qiwmx1v+/TVLT3LS3Tj5Jl1yY9wl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814319; c=relaxed/simple;
	bh=HSI3U6c3v3290v4+CeJVcQQmvrYEwOBCcAVwCGIdeRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzBX5U7p1bOgV15onzzeyHG8E2aTONmWdxlAwTF7MZxuCv8n8KdxwW0lmMuBlEf8Uy18uCw/8YgttR8lFeL0cH662/1CTPQCgBmgTa64iMOX39tr/05KBabtSpijEA8ZhnO8tOdC9EuvacX1ksqqXf9ckY/OmkeVgqD+a95U5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so291825766b.0;
        Fri, 13 Jun 2025 04:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814315; x=1750419115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZs310U/9odfVoiw6DtQCw7ziZnUfE4r+2aQyx8AJpw=;
        b=RZYbOPfnAmYbUM1AX3g0kNxPbJCIzYd4/tkjDXjjWIGW85nD+dgfkN9nlrZHPoID6s
         EJApmvec4kKY4xquIWpyhWikzIBgm30sprLWebsEM+MxKVDh5a9ZQ2YcyFovBumicmWB
         D4rM3AfTMCze9oCWi0t4Bjd8A9kBQ/jBg23hJ+XuKPThOAepY2oV95Okwsra2oxYFapT
         LzBXTlBd1BGrI40wk7WJ3EWVRFInFL9IUVl/dk9LIvTJCeg6Eh7fssku/xGaggrm1l9a
         MoLtH5zgrsx6KPwBZgvBqyGHLWZfLorG5Q85LDe6e5osoaWeXBKL4qxg9+h+MJaVu8ny
         ksMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5esQ8fWKkBx0UhpMEENLg9bgxh3dzS9CPYZVt0lyN0+IaQKnX7dng0+JNRHgnUxGP/LUNnel8054jmU=@vger.kernel.org, AJvYcCUQHhWEvE3EB8BPa821PdUo5mDYdBAvlk9qF+YDugA5nJffGdubPmmqns6WOIMomrWITaam7thSPL8gcfSBcM4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4V0WWtNzdDR4reRSyhk4NN5i3zic4pNfSWZ0UqFs0X0D1NvMa
	MOIuwgx5Q1bNfpl2RMYltStce6BERngAgPsE8XqxzuRvP8DmpFglBiku28WbKQ==
X-Gm-Gg: ASbGncvvWN4B4NHdO3xw+lR/mtUceRxh7VvK5pii3De6QPZ7/f12IHGko/GPfZhbiyj
	bxBtOMVAPSXWgAWW0dEXSmQXLD9UGvhzw/oXKXGIeHBkAQdf50Dwej86R8OONEEnq2y5LFeMUD+
	QXg+V+G+/WnSZCyRrajwmN/gkX3Z8XSff6Y3s1B4GE96MBpAILZuSdd1TazwNV0jo1fCQtjvq13
	uM8p1unG8b3B61Pdmp06SkRf9pMjsA5DOwP67VpCJf/ZATjJHIeis46tQvDjOfSwGh9aeOJx8PU
	Cohn6qJB12sU5WzFaGI/uXlBaSgb73TeUWHi1Suplda1Mx48IYs3
X-Google-Smtp-Source: AGHT+IFRA3jjKvcIQJdY86XlF8o6T/hTLmkEvUe4docGrCCXHw+gCg4AvSD7xFelfsYfmnTD0B5I0g==
X-Received: by 2002:a17:907:600a:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-adec5d2165amr210074566b.29.1749814315033;
        Fri, 13 Jun 2025 04:31:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892b216sm112713066b.135.2025.06.13.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:32 -0700
Subject: [PATCH net-next v3 3/8] netpoll: relocate netconsole-specific
 functions to netconsole module
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-3-0752bf2e6912@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7728; i=leitao@debian.org;
 h=from:subject:message-id; bh=HSI3U6c3v3290v4+CeJVcQQmvrYEwOBCcAVwCGIdeRg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlYmHvgkzRtxluUWB/JZlMgm/SuzReFsbeB
 UVOikt7MdGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bQccD/9Di5b/RUZEbyhtnP1SxhczQ5LCiCmPUMqUQhvM4baNyGF2vzi6/gulSCxZdM/QJZmoXmN
 eR4jd59OYqEYEFr1oJc5rnpA+9np868BfA29YtfMmaEHYA6Mmge0PVzxh5dMsll7fNGFDQ7cUGy
 +TG7wIVWcvgqeCyCF1lXPtYrkyzI9TVA5i8qaKK14xczTpaA53AhBsywhsGeLkRkZ2/8UP40894
 4TNfc4b6C5WbMCQsp9ZK/cVnor39S31ig/k1XKaxyvz4e63TTgjSyiT01bneGhRQmMjghWUsCrq
 77ObAqhLrppXAYCNgDU1HyVc1ljjUHMdxURLsNoyEdO4monQFt2MMUIyhT4muHKBnvH23j4QnQR
 j5jF8K0iQGS7/d9VaXP7/HNl6SXmZ3k1hZmBoneP8PMzhKMsLAtLX0tzVUwfQWECrDNq5ZWaEV5
 GFc1wRCvoFfq2xXfFWF5iVrporpuEhjjzzB8u1iAbvKeDclE5cRzKqrUqxRIhogtHasdmDKsvTL
 +vl9eoyfTKa1OFxd7qfv91RVARf3aZw/OHmCJUpz7P3h8eDvZKMUBeW95K4IOgT7pfvLBqhIQA6
 7MlE7hmctkW3jgsES7gIdNkGKT/R0ZDLvhmJT443es3OB9YpujuwCZx2/dv0pQPnM4YRuSOso2A
 nU5+noMV1WUiRig==
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
index 1eb678e07dd05..bc145e4cf6e72 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1659,6 +1659,114 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
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


