Return-Path: <linux-kselftest+bounces-34604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC44AD3CD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E9616B727
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D5246792;
	Tue, 10 Jun 2025 15:18:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B42459D5;
	Tue, 10 Jun 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568716; cv=none; b=mjLBr+HcZivdai6tOh1nU08WMsdYy5l6lvb/Ac0KX/GBq2MG1e6ic/LSLMHJQVLDxLi4Uu51BIkCrS6GgJuevTqjxqT17o8dt7cOJFbvI2bLuRmFK0ByjjnAb8AOPzJZrBxkJ/UhoQDhgPK59GL5ybQkrqXWxmSL0baJDdOKzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568716; c=relaxed/simple;
	bh=gL4hophrvKavJhtc5bA24dntNiRgjnALWCf3bYiRI2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y26Vzhj9Vk6J9Ifjad/MgjQ8FqPAlE5rh5J6xK75qlHCdADCvTTPPt/8+Q/2Ff10ySnNkBF1YIODjSKrXMQQqOBbWGXEMjJbT5eKitNRR/nQxqIgsrJ+tlnpL4byApgHMRlxp7D7zupYdwzAK3uCr3GUW+S0l7LLUSQYNqExhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so903848066b.2;
        Tue, 10 Jun 2025 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568711; x=1750173511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gmL5b01iheNder2mMcUL/fkMuF1KCU61E/Tx/JVdTs=;
        b=BS0MFPgZt79Bplyvnr4UmukmW2u9ZGJIPo/5JOtcTt3Wq9+ujsFi+F+U3SDiKavLwd
         LOszdMYzjlShxA+IzyeTZ4nngnorcmjKJiS4n5LuX66bKnIem6pDHB4thQH5kgHPUlho
         XKIg0fQSUP7EbNvPwbszUvqI2/1lvkqe9V9wOjOAaKB05+O3VUrekD2L5UaOocq0s4uG
         eaf8lzjXIXKMPHDf38l71tUMaR9VdlQQxqHlFg3VV6F1OzHiQQalH3zASmHDXbuSiE8B
         J+8h0KiG3ombLo6rLa3bjpDnCvW/RCSGkKdl6kh9/caCS6qXU+DEs4ZZM1e75fuNXmXw
         x0zw==
X-Forwarded-Encrypted: i=1; AJvYcCV81+pmHBTNMLMqWmCENSCMYMMhNpHGXxgXDf1F02H5EZzY7DbotameLEF1NsGP195KKT3S9DfiiNRTbDVS22Eu@vger.kernel.org, AJvYcCVDihL664gmXrM0eF/Ipr2zJ0yinin91EvM38upalHe8WqsofOPTh8x3NOpjqvLRPYpnnlS6gwgkkaTlws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrzNmA35cq0v3NSj62unqyBAu5fD9p9BhbcAHXu6MQFFzS2Fo
	ClQEhqvHMhxGyOh26wTUVEkhlaYH7QeBjsQxPn0KwVb1yWPtXTf8XbtS
X-Gm-Gg: ASbGncsu1E9deNcMX3XX/pyVoxjAqoMV1QKd25F6M+oLoevAZP26eEZ+lICo/FnAG8C
	SW1iVuEOt4ETSwudTBkgURO+ggigjINvfG6/FAgKEy59DyhDrz7AqS9VvQpTowTrFciq+Mn/sdW
	KpGBR8Qn7GuDq2kzJCfj5HcPo7P+HZhIaE+CMbAaFA7HjP942eqqK6DgEQWdPSqxDDMKQiJ3K3A
	tyT8+Zlr2vLCJU518VbulS0wv+8ghJU9MaC6V/qbNyts6evFpew1yWMVBWKdI80PVkt5g6Tskve
	dTPis1UTnouCPU976HK6tXvWpcO7V7Vt+8MYPdDuPzC+ijDctjxOcwqgXpzKQWM=
X-Google-Smtp-Source: AGHT+IHdOUJIPUOAH8GhZMUmgA1NBxkzIOpLVyPmpU3W+vxCtSe0xVNvtd9kQwK9DiCOhkAVMeMiCA==
X-Received: by 2002:a17:906:6046:b0:ad2:1cd6:aacf with SMTP id a640c23a62f3a-ade7acf8d25mr196119266b.47.1749568711105;
        Tue, 10 Jun 2025 08:18:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc38a11sm732113366b.116.2025.06.10.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:30 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:17 -0700
Subject: [PATCH net-next 5/7] netconsole: rename functions to better
 reflect their purpose
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-5-7cfde283f246@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=leitao@debian.org;
 h=from:subject:message-id; bh=gL4hophrvKavJhtc5bA24dntNiRgjnALWCf3bYiRI2I=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+7ccCAtyZ/tmWV+GeHkvJ5w7X0jl63ezZE
 /ftBC+40/KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 bfTqEACP91poOQiPw80BuXyVC6pQD8B4jrgZxr3w5b459yBCrEbWwm5XfKGCNftnJgg/xRREXSG
 i0bXjLzP3BhO89N/JPCLnq4nktZQ2QBaLhUY9otWUVuCLWKcUhJhucl9lS4SAxtOo+kSKz9BfJ9
 VLTeG9vRL1ynqNs4L/a61AhptT2xq8Yyeq03k5T3kF3544coO3HLgBM0YuHf1/f9A30jECwxLJ5
 yK/Av+yg92rmjpsR0E2gyUck7tp2qtqXtfc2RP6mm4BWY2yCD4JfpZXGGzRj3BpzxHuWulwrWaG
 v4K+FvOd3ducJRVWcsRt9h/bYXxQWNkrUyL7pxzZ4K4ewGuJYsw4/mshhm0UpXGO9FaVWmaTuf1
 ndkQM/9HkQ2Dzn9wE19bCYfmLhyIFNn61ulRt1fjiKwMKlA5x5EBqpP9uyez/7ukUf2DbX5qY9j
 47lWqakPImY3kCQq+hBP2Mm3vQj2PpXcTfQ/wClunpXKHqMgpZ6b95GaUioku9Al9dLGVNlQObw
 175E//4CkzgMM3DlS91zBN9osNJlp0FZYPsmuSSVFNQ5XSs9vzTI3XEecjnz1bA9iMKMD6AI6Xr
 7yoYDzAZddKIjue297zsEYCrbIJMfAo7gycmU2BZfWMa3b2ynm7X1oKyim3XalsTrhkCoXnynWL
 vDRjy0hADoqo8Tg==
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
index 18e482b28c427..3406a5cbdc11a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -273,7 +273,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_unlock(&target_cleanup_list_lock);
 }
 
-static void netpoll_print_options(struct netpoll *np)
+static void netconsole_print_banner(struct netpoll *np)
 {
 	np_info(np, "local port %d\n", np->local_port);
 	if (np->ipv6)
@@ -509,10 +509,10 @@ static ssize_t enabled_store(struct config_item *item,
 			register_console(&netconsole_ext);
 
 		/*
-		 * Skip netpoll_parse_options() -- all the attributes are
+		 * Skip netconsole_parser_cmdline() -- all the attributes are
 		 * already configured via configfs. Just print them out.
 		 */
-		netpoll_print_options(&nt->np);
+		netconsole_print_banner(&nt->np);
 
 		ret = netpoll_setup(&nt->np);
 		if (ret)
@@ -1651,11 +1651,12 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
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
@@ -1730,7 +1731,7 @@ static int netpoll_parse_options(struct netpoll *np, char *opt)
 			goto parse_failed;
 	}
 
-	netpoll_print_options(np);
+	netconsole_print_banner(np);
 
 	return 0;
 
@@ -1768,7 +1769,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	}
 
 	/* Parse parameters and setup netpoll */
-	err = netpoll_parse_options(&nt->np, target_config);
+	err = netconsole_parser_cmdline(&nt->np, target_config);
 	if (err)
 		goto fail;
 

-- 
2.47.1


