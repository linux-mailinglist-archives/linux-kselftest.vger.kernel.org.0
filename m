Return-Path: <linux-kselftest+bounces-34718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B61AD586D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1EF3A39BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB482BDC03;
	Wed, 11 Jun 2025 14:19:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196512BCF75;
	Wed, 11 Jun 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651553; cv=none; b=jDD4LQtSOihTCYKBnMvE/1bRlxSepjCWgUo1YPnFAcMUx2zQluOTOOkrwsxTYjsTG1uhjoW5D2SqqVIF+qfpImi00JiL2h8b0suTvhAPd3cgKX3jp4aw4PC03umaLt1EpBxBkFj+wdseGOUzZpviVL95LJI+zn4jXmx8ELTyfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651553; c=relaxed/simple;
	bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHhK96oMS+qu1FkyKvc359TyeNZswfTPB+iDicT1NHB4NEKhkBJbfHhfJaKWfk+sc06b/0+gJcBMLxhj1PpzfKr7nBJooIKK4p4nr/M/iHo9tXCAuQR1aRMAl0wBFD9+HiFvDbtch/CQLhr+uR0ZzzxNKBSnFiOaKe46G3xzrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso1252071766b.3;
        Wed, 11 Jun 2025 07:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651550; x=1750256350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBPQhHa8Mre4rsIn6yFSq4q69O1rqX0rwLacF4V2/d0=;
        b=Ri2QCxBIQIoDdPDBlAK0dW00LePO2NQ41BuoAzTX6UUaEozpZ2DwdceLo85xvBe81p
         YPTBKFowa4F728s5vBZ/XTTFJ9b8IMzu1f4gFh9+SMJstQ9VT0hHEbSBNZtFi1JMHeTV
         PDk9R4ZP4KX1uvkRXPtFd4aS1cqKak2cFO2LqCe2zaDCQlMg1kfgQUEZ42Sp1X6kMWjv
         NdEjnfKYZpd9eZnPx8wwRw+Vrl3mIisTnDNpSHDAbmQr+2yIAlid3k6vY0WqUO4Bowep
         DWQOwk8pXzn+aID2hHKUKMOa4rwyy8pc8PnrKv2y0I7tOLaohddShGOGQPYtDopEiWZT
         KJcA==
X-Forwarded-Encrypted: i=1; AJvYcCUhygejK2YZO3E1A/07jN7iFshISwtT+DdX+NPYQrV1dht0nqCzQxdVVf9KN0JPI9U6glwUJPP0aE9MtDk=@vger.kernel.org, AJvYcCXtDWAAHDUEvOv3lUJ8zKYtokUVW8GTHBgQ23lWCj8DwCBZ3x24k2bylLyN5QJsFuEqh+wa5b7GJwsV8XuKiVsd@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdjlSH/zVTgrBeRoAKq+b+XvNv5m8eNQpjCKNKwNWoWDpAxO5
	Z47arJMueetxyXpY30E3nMJ5Ez4VSFMHJsg5obioKi5MG5tAaGIj70P6
X-Gm-Gg: ASbGncvwi8fGNOpCwemIH6n6xt3Ri+1Xne6Uz6o+MpNYNXTEjU6k4J2RLoQCZOTGE7j
	IJ7+yHdf8Kd8++8bE/To3iO5YRmdKFv2Dq4uEMmak7nkk7pz/20VjRoiaS0LXreDqi0ocGs6FBF
	o3RyLXmz40yxI7Zl5hKH+fo4weqjEBaohTDgYPyc/vgJDtlHGT/LtE+NwvtB8tQRxijAQn5aeIU
	FuEtkXaaH/mn/ZbhOjNaWBHQXgcSlSfuSH33D2Zqoj0Jr0SwovMV0WgNKulw0uefqV7yufECB37
	SuyQD+IWBn5HoAchn81LVWxoLkk2pN87ojmjHC6LghM3q5H9sF0u
X-Google-Smtp-Source: AGHT+IGCq5ha3fGkQvwbBbsxckaS2fcSPaelGVokqtnlen6vmoVHqRZX1gnlf2BAw2N3roLpCVqeBg==
X-Received: by 2002:a17:907:3e23:b0:ad8:8f44:134 with SMTP id a640c23a62f3a-ade8972af9bmr374993366b.46.1749651549934;
        Wed, 11 Jun 2025 07:19:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade343eeea1sm792827066b.74.2025.06.11.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 07:18:51 -0700
Subject: [PATCH net-next v2 2/7] netpoll: expose netpoll logging macros in
 public header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rework-v2-2-ab1d92b458ca@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=leitao@debian.org;
 h=from:subject:message-id; bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZAjsT6mgCnutBVMZQlHPN/O2YeZMrN3E+u
 zZxJBKeWhWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bTNqD/9aEQ8m/UEYnEhbY5rEjxcbTntbw9+72eGW8dKkHUfuTX7euj/4vvrGWcHjlpRbNebPyz0
 NeBKytgXaWkv0F348Gk8gVMyTtexTB4ieSMKJmYz57z/Nzn5JKaAosfOqiGZi3UhbWOQKTDOvWY
 KARoC3M8IMVZ33hktWA7aq3uMOD4IewKxZNvOIo8n4hqxTk+10YVvpE6Ru5kzcxA9pU5Ue+cqLy
 WqrcOlA8E7d0eYl65H06/6W7G1cIwLnOzUtzrVYofP0tbl0NGhz8iizir4OraGckxfX7yNtsHn3
 WUMGIz0HI4RBcVcC+5o2yNVL7yFakPCp85dzvj6zBHejDgu1djmPSr3swfVVNqSLkgQjdxuj6pr
 HHJdeeyJYZHspU5Roe3uPdlPwubFiIX7sH1ZsnBCFllIu6PPLtux6V2YHpyNKzEIUih4D9riVf7
 LY07+vz2AApyoHNF6AZBJZKMDaDkW+QA4pnSRiE0jRFbIat6ixz/hnLVHzR/0YNMKraDdrRviDI
 qMO8FN3djxYCPMmUZ2y1VLuSRvfPDzCo/ZYxTshVgilKyV7OLTBB7/vRJSogxBSUlK4eAT1OWCx
 N8/wluZTvi85Gyncs6mOISL8GsssqeJvLIo75Yc1xyQ5A2ZJPu3hx989Y+Jz0WAtlebecTWZto1
 Ja/nge2d8w2blpQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move np_info(), np_err(), and np_notice() macros from internal
implementation to the public netpoll header file to make them
available for use by netpoll consumers.

These logging macros provide consistent formatting for netpoll-related
messages by automatically prefixing log output with the netpoll instance
name.

The goal is to use the exact same format that is being displayed today,
instead of creating something netconsole-specific.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 7 +++++++
 net/core/netpoll.c      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index a637e51152544..72086b8a3decd 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -42,6 +42,13 @@ struct netpoll {
 	struct work_struct refill_wq;
 };
 
+#define np_info(np, fmt, ...)				\
+	pr_info("%s: " fmt, np->name, ##__VA_ARGS__)
+#define np_err(np, fmt, ...)				\
+	pr_err("%s: " fmt, np->name, ##__VA_ARGS__)
+#define np_notice(np, fmt, ...)				\
+	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)
+
 struct netpoll_info {
 	refcount_t refcnt;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a69c2773841a5..9e86026225a36 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -58,13 +58,6 @@ static void zap_completion_queue(void);
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
-#define np_info(np, fmt, ...)				\
-	pr_info("%s: " fmt, np->name, ##__VA_ARGS__)
-#define np_err(np, fmt, ...)				\
-	pr_err("%s: " fmt, np->name, ##__VA_ARGS__)
-#define np_notice(np, fmt, ...)				\
-	pr_notice("%s: " fmt, np->name, ##__VA_ARGS__)
-
 static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev,
 				      struct netdev_queue *txq)

-- 
2.47.1


