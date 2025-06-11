Return-Path: <linux-kselftest+bounces-34721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4EAD5886
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027651BC54CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F52BEC3D;
	Wed, 11 Jun 2025 14:19:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE652BDC19;
	Wed, 11 Jun 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651558; cv=none; b=Gn4Yd5ClqcyRBQG3yE5aeKwtYqKVOtHyTiDAlyBTnMhrPlS1K5D3lVFo8Lq3UVK7Zux7YsqzijnAUDWOCjXvoeUm05J93w5CXeMxrS3wnYcvI5l6cutivSP2RQUj0Mu9dzQYg9lHZgObGt/zyNUVosIem6YS9jY+6/LU9+gr92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651558; c=relaxed/simple;
	bh=Fwo8eKlVXNwWqkJY9/H+Q8gTiX4pph3761TVMvL2FfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElEWQ0pXMNCV0EANkqQN0mGm5QHZwe1qFvlMty+P0YSJ+cBd0SlcSbzyjHOjvcYKZuJNjc21r6aPQgUF/79H5Ah+KRvnZL3VS1WB1dQxbvNG6+fvsgSsx0xNN256L3pQ3Fk4HHkzgW8XjAQyAaXC6XxMyHdBCQZYrbyVnLkoh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-adb4e36904bso1331953166b.1;
        Wed, 11 Jun 2025 07:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651554; x=1750256354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfXeyo1sC7jXwyqp5+K4Bcm4n+94BdelX+fnhM+6GaQ=;
        b=nlXAc/72foNFQmlpahClXDC+SlXjHvKe9X2MlhZc3fvNkQwpbwYG/BPMj2Lu5fsvoO
         9+McF+VdBfPUX50al2rv9B9ntOC1xsRvbaKHD1WFKja+iDV06H4Jd0yzsBEBeEke+cUl
         W2xAJu37QtaqqN0BsS2weqHHx2phVJjdgDv6JhhaUiXeF117W2WJ6YCH7yO8Z+gZ7IpN
         QX3cn1pRz0OJT9p4ahUtOy0qW88TXMl3FdP53y3PLaFcD0UrPfSs04XxzNIVa2nYSKKa
         SMcswLndWjPupveRPzfrknbInHiqLR1+Gd9doZZHnmIwPOu+IwIMkhK+qAHcdxInxqbL
         FIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJw3Xbmbq05K43+IeSVODLdzyZepS6wziifQzeC6vewQimes98ygf8RQdV5Q/8814fIEJgaUEkTFs/mvI=@vger.kernel.org, AJvYcCWCTFjzLQl2WoZan9y3HD822cxiVmQdvhUEL5lI1YS0j+yNFZ153AT8AgB1wLf4TvoUBot60x+9oOoRXn8g3Xas@vger.kernel.org
X-Gm-Message-State: AOJu0Yyimv00xXc3T5oFE7kkf3C9j1pzvaB37qivReyuIMMadsm+VW+8
	T3zz3RgHdU2vrl1Mux+jxAghDIbHFL0RlQ0OqbrDSo6ymGGNziLt4V05
X-Gm-Gg: ASbGncurjTa7DtC6BgFKNo6J7olpozm2glo/eJFJ12TmfPDqk5lJ5e/MIwzr1ZXQSSY
	8dFz6jDMTXgYKthRug56zCdJ+vSKbjLE0TWflyJeH9hL+ELl8MJMvYIv5XUXFOxz05RniOWH/dr
	6y3TdmcRscqeK0ZswUS6eSFjWwnr5w/YD6/QQreuo7VkpmLriHGPAZip47og3VtHY4cxRjnNe10
	XDXq87z4x1NZgtoYOuR269WWqxkUDTZpIxrahnG9tQsbzq5w4vkVQaLuZPkiwtZ0T4KynwT9jv0
	gRaX3VJD+DtlP3HskfcH7vsXvXlW/xvEqyDYYyCghO48Ys9pBAymJJQUhgivKBQ=
X-Google-Smtp-Source: AGHT+IGX6PFn6XiLHfgB7a12QDKxsJC69MYvRIaL8NsLgGwt74nuaQn7uePRd6EE5ue0UyfGTRaKkg==
X-Received: by 2002:a17:907:1ca1:b0:ad8:9b5d:2c19 with SMTP id a640c23a62f3a-ade8c5f72e9mr266343966b.9.1749651554338;
        Wed, 11 Jun 2025 07:19:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7541fdsm897272466b.27.2025.06.11.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:54 -0700
Subject: [PATCH net-next v2 5/7] netconsole: rename functions to better
 reflect their purpose
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-5-ab1d92b458ca@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=leitao@debian.org;
 h=from:subject:message-id; bh=Fwo8eKlVXNwWqkJY9/H+Q8gTiX4pph3761TVMvL2FfU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZoUEnbJaCpVqCOoQpSnbZTNKPevLNnjbkS
 CHPVyqphX+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bWntEACjaND0zvquhzuqrRXV2Zr8C9UujgHEFL6XMVQm+bA92ltpriT8QoXADb+Bmbtdqtp2Kmk
 iBfHb1AqJZaAmO4iRzWP/fznQdUyasVr9WlGAY1LTVKDKBdr3ojnaelGAVGjv2ZS75MXKYXFotO
 Rm9ihZouAMwkImbbI2c0dF4D1FFdIsSxMeZ5QncXqg/o3uEkv++DVkQOJdPHfdCYZidCfUT4rjO
 b2xpLOF7KUFsQFgW1o9tWM3jCC5OFtHIMGsWeARyew2A9hAa3kmBuTbKUhxbPGYAFcQxmobSyZC
 n8tAy5XQQpngmevBZk7FR506Xjx6iX5EMrKrpiam6E/CDZoL223vwy60+iRqDo846yZlp/QyO1F
 LeUE1CvBz32Ay8o1+ChLkMPskl+6/NpbPO+M8JtbhDXuwzlL7H8UV8oMiYfK8IaJV01D4/I4S9Y
 ppEJYcPANhqTaGs9xvCWy5Kqb1mJchm4hyfBzKb3jQaEnWp6kFF8+cYdPnZ0pFGsQQssxIqCcEJ
 M0Ev9pUOs0J2Scrt3havJmNuoL7oajZanQyk0rFUjX5wGTM9LZ8LgRm7m75RtJDMxdX12Ti5UB1
 fHum4HxeW/p8+vlNVuTKqXuarxstuW7jP6qAm2V0x9UykFgKYDt+MNfR1CblaiRhkGEMMUb6/6h
 2F0VInJ7yIywCaA==
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
index 1b8f9150eb350..7f1fed7871967 100644
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
@@ -1697,11 +1697,12 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
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
@@ -1776,7 +1777,7 @@ static int netpoll_parse_options(struct netpoll *np, char *opt)
 			goto parse_failed;
 	}
 
-	netpoll_print_options(np);
+	netconsole_print_banner(np);
 
 	return 0;
 
@@ -1814,7 +1815,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	}
 
 	/* Parse parameters and setup netpoll */
-	err = netpoll_parse_options(&nt->np, target_config);
+	err = netconsole_parser_cmdline(&nt->np, target_config);
 	if (err)
 		goto fail;
 

-- 
2.47.1


