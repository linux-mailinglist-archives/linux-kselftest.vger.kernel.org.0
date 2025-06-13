Return-Path: <linux-kselftest+bounces-34897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088CBAD8A86
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30483189E1EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F372E62C0;
	Fri, 13 Jun 2025 11:32:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DA2E3389;
	Fri, 13 Jun 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814322; cv=none; b=QZ1RMeP9syoFklDsJ3rgdzk0vBTeyGreiOVdRHvrdX9+cCRWMANvs/PaXg0e5WhHm+6Igm6oRu7kch2QCZxSlEeA3r54+QMnpnUYpjoSTYU41xJ1sVCB+vI/NFWSA/3ceGF7cWwAg5YbKfZQzYvo6A6UtxLyG0I4zfw3gbyXw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814322; c=relaxed/simple;
	bh=OGy0eKjv/0jfbBP89XbzYtFF77DX+vnD2tIgiOzWN2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlX4oGkwpP2uQOv506ansnibQzmobk4otf6DKWyuX5YVrqYjWVBwaVvd0DIZ9olgpUgp9FgzQOlwD8vFNW8Uv82mRPNz5tXdLzaJ2Gec8M0WuNMdo/U35mX9iWNF6xX56Btr099NG1XV2OuaWUnGoBL3j1r7hg9AKipG7aAL/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so3826537a12.2;
        Fri, 13 Jun 2025 04:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814318; x=1750419118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXyzK7g13P/cKo/rgUaAA3sU2j1PA2Tn682NBiNYNEQ=;
        b=ucdxXokImsQ63YFqy4xVYuE+ZlLadj1iU2vXo9MNtB4G+B1nR5FFZXMODf9NfE6Uar
         oHGFB+7flnVPNbI9BW6fMQWiGUd9YTUPcUfdiuz19bFpGBjqASzmgTWL5CL+0gWVyljY
         zSduJsqYI8rpBmzzL8/KmTrcJbEy73NpqXG/DXfYyCIXc84OIEB932594erGTFviIAIP
         0yv6hFURZGfWSVWDc/qtqvKq8KXmZ5CyfSmIP0tCkNngo38JDucrm/Ih0KfR05J3z8ai
         dRlOO898rmzOXYCYrkVQTtbUTN+LRE3LgD8DxLGrHIdtQHoMWworLwpTpIwntMjvFOvN
         MmNw==
X-Forwarded-Encrypted: i=1; AJvYcCWVBPZhQNxiSgrG7xncrcCevqKrDxTHk3VnlbFFY5RVTJzENwl6nd6i7/BwACmQwlxjzgUIHpDTKS4v8FM=@vger.kernel.org, AJvYcCWkThYl+dXJPT9WEX1qT0MoZULeX2tkZ9oExr5HgcvMuLZ1HB7MGb46XhFceHaZXv46JbR2o/gbgwiI23OmuFko@vger.kernel.org
X-Gm-Message-State: AOJu0YwYoaHBHcqhk2kUpar+j8YqV/S64nr6k1U3oeSWwDysxCdv+vve
	4vICg4vIoli6h4ppDeGjlBWtwvyquQZ/838qEyjn7EoQ9Q3j08DHwB2CT0XYJg==
X-Gm-Gg: ASbGncuMAfRL7GxGWvHNoCwPaFsEuzXK44JkbJYS1SNozIap8fFiJ8YOjRcIY2VsLv6
	/3KBPT36uzr8E0i0iB2plP26VsLxIFXDYdPs2GSQwIEfy47iMRJHbb3ha+VeVZ5MgF4SztD/TPp
	jmcU1XMy0pzw99l1+vLRrdmjgk83O+IMFLbdAaUFaHsah3uHusRBj4J616tG8QNXw3Qyu8si0qi
	s1MYIBtHQK93ZRKkdnQ/UKHcIso37hweCqh6tRTQ0coBChBqEshiabtZEYYaz3iA6cUmUp4wzbi
	Dy/K21qWHBip+yMI6RPP8icSrRWDWbODzQJkuIIcrpMVufOTLlyA
X-Google-Smtp-Source: AGHT+IF5yxVg5gHaaRBwQ8VJ0OXE0zQATDdMAhgog4kpdQoGi+Mb3H120K6Q9fT8Ibm8DI8XhHkyGQ==
X-Received: by 2002:a05:6402:1d4a:b0:607:690f:b74e with SMTP id 4fb4d7f45d1cf-608b49f87b1mr1842611a12.29.1749814318491;
        Fri, 13 Jun 2025 04:31:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4ae216asm1051164a12.75.2025.06.13.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 04:31:34 -0700
Subject: [PATCH net-next v3 5/8] netconsole: rename functions to better
 reflect their purpose
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-rework-v3-5-0752bf2e6912@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=leitao@debian.org;
 h=from:subject:message-id; bh=OGy0eKjv/0jfbBP89XbzYtFF77DX+vnD2tIgiOzWN2g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlw/MNuO+7Jpz7S/Hw9HKi8JyTzsuj+UN8g
 Sjc+s0U/ImJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 bXWHD/9yy5NppbQ8E6jwAQYNTdyWRs5QmwRtzgKovvGn4LPLUg95KFdY3sqqA8pECQ9TCkIPFhP
 mSfTIeoeWFhstgjhVSbq37AJ9Aqvsjy6KQ5QOlxn0gt4bDVE2xx6moaLVwG5cdQsRuE8WtdXptw
 lGidtNkLNWcB79VhZdEQJmgCaCKzcsJSlJdy+RTskoXs5mljpTevhs4hssCZhglGUQ2/XFUEBJR
 f0hIQ2KcPRXoCAedhxIwXteAhld1OTbbwy9wkxfkLyA/aDtjTiXo7sQcoZGE30UyFwoJGsI3WFB
 MfrOGFFw9b4LVNfQFtN+6+tkqvd1Pq2JHVQORjYUNRVFcea9/4Z7s/rIXC0C8spGemMjR5i/O++
 MiOPIjPExcuihRFMSWX2DUHh2lS6sJWbLql7eKZZ0Mkd62O0dU6atPPAhV8XJw6nIU1M1M9M7HH
 d9nx7RZFmVQI6pgLjO+t1YPah/ug0FR5PIcyTgKeexAe/l48kdBq1THMgM30E3o4JJ1F5pGSdRd
 M7BS03RrksoDMyO8ugVC8zXmut4zkS6ZZq2U/ZVLR/6W8TEp2tFdtQ3wU+/4gIm7I7MP8YOwfrm
 AxSmT/3kq+4ZH79yWRexP4VQFhFjs0Iom5k/kCip2QQgLJwbHfzS0V1/ixF0ZsRL1J8WrtsmjcB
 menULEaa0nH6pKw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Rename netpoll_parse_options() to netconsole_parser_cmdline() and
netpoll_print_options() to netconsole_print_banner() to better
describe what these functions actually do within the netconsole
context.

Also fix minor code style issues including variable declaration
ordering and spacing.

These functions are specific to netconsole functionality rather
than general netpoll operations, so the new names better reflect
their actual purpose.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 71522fb0eeeef..cc45ec18848c9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -278,7 +278,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_unlock(&target_cleanup_list_lock);
 }
 
-static void netpoll_print_options(struct netpoll *np)
+static void netconsole_print_banner(struct netpoll *np)
 {
 	np_info(np, "local port %d\n", np->local_port);
 	if (np->ipv6)
@@ -551,10 +551,10 @@ static ssize_t enabled_store(struct config_item *item,
 		}
 
 		/*
-		 * Skip netpoll_parse_options() -- all the attributes are
+		 * Skip netconsole_parser_cmdline() -- all the attributes are
 		 * already configured via configfs. Just print them out.
 		 */
-		netpoll_print_options(&nt->np);
+		netconsole_print_banner(&nt->np);
 
 		ret = netpoll_setup(&nt->np);
 		if (ret)
@@ -1696,11 +1696,12 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	return -1;
 }
 
-static int netpoll_parse_options(struct netpoll *np, char *opt)
+static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 {
-	char *cur=opt, *delim;
-	int ipv6;
 	bool ipversion_set = false;
+	char *cur = opt;
+	char *delim;
+	int ipv6;
 
 	if (*cur != '@') {
 		if ((delim = strchr(cur, '@')) == NULL)
@@ -1775,7 +1776,7 @@ static int netpoll_parse_options(struct netpoll *np, char *opt)
 			goto parse_failed;
 	}
 
-	netpoll_print_options(np);
+	netconsole_print_banner(np);
 
 	return 0;
 
@@ -1813,7 +1814,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	}
 
 	/* Parse parameters and setup netpoll */
-	err = netpoll_parse_options(&nt->np, target_config);
+	err = netconsole_parser_cmdline(&nt->np, target_config);
 	if (err)
 		goto fail;
 

-- 
2.47.1


