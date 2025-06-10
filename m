Return-Path: <linux-kselftest+bounces-34606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E228CAD3CE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547D4174B38
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576524888C;
	Tue, 10 Jun 2025 15:18:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD2248873;
	Tue, 10 Jun 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568722; cv=none; b=bzKpo3UuDPRFdzlsfiEECbt9ZujFWIAijEh1H3frhjRCBq2J3sRZ+/qOiVl9dGydp95wDpiHSxkeQpGSVA369M2gmcXJfr3M+JY3WPEeW7J5WAx6ENKbmvCWB/x1cJu2zOqO2xee6CDOuISRQ2qKMaITKe0+JCvGVi1VOoaeRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568722; c=relaxed/simple;
	bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYr/krA9UpF8/RMj9uSS+AAmTGbHQClGYwO5mLTRAzeNp3XyvipVivLaYu+QrMuy3ChRqcuAMtsPFxhYJRkwBCCwN3YKpa0te/inkdamKCYFW/BMqIMJEuRZQOtzS/ks/NS6nEEMG6YqNSbBHhnkRNvQXBlJIj3eh6egoG5MqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso11005910a12.1;
        Tue, 10 Jun 2025 08:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568718; x=1750173518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBPQhHa8Mre4rsIn6yFSq4q69O1rqX0rwLacF4V2/d0=;
        b=o4fQohhoxi81zBO7I2YwJ2/CTdn4/zGPWs9x9abIzYD0XhDBjVoEnHgcxB1cRWJv8U
         uoNIDhbDVUxyS45FUVXUOqY+YRcEwqNRnAa5xKfxwrJC6GL4ZiH2ic5ckJyWl4LhEFsE
         jtOsUcZLO96kDTHNLYFM0It3Bl3QHsuqz2SCszmeswuHy1D8qAJQ8ZheRg+4MSs4LmR3
         xlH/awmhqReuR0jyE7C0IPdnYKllryUKcqim5AQ5NTFwoJpfjop7AhdtSGA1Q+qD4QQl
         4lzzxWt6Jze+Z6iylBaxbw4sStBb9IInFsdN8vtPP8HQj3NmrMPZs2DAI9F+ffSoG3wY
         H6wg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXc7nnzWyXydrYq/PN0cbX9NpNyziacMI3XlQomW5Wa6LAMeyUhNzMTc+XQzsUSdElwquFKfR9olfrkg7FLRG@vger.kernel.org, AJvYcCXCp1aQOXQ4qdie4dmScPi7uDv6d4saQa4xpAEto32Y60dvL0uUswTQaNbC73xe3MvsW7oAMmQExSw3tsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFr41Oon4qKLgmJEFOF8J5vZCOKuT08GyAB0+uXIao5WY1DIpV
	vjiJ8G8VaygetbbcMHKn2jUXdcgsYYBrP9UPMIczqmuyfn565M9KkUWtnXB37w==
X-Gm-Gg: ASbGnctKQ0mZQ2/0gxmAeBDJZhcRTs15izER2tsGTziexoqhxx5BpPq9xFLLL0DVTD7
	vW+wHWmYQMJybwciLxdyT6744NIcvaTwKYQUsEdIUpGDJ15oO78FB9VVaRsCW71Mdr4kb7HM0AT
	6hBP3529/k7PD3k/WQH3xZhBRb6JzQn9zKJA6TWBGq7rej1LLW7eUqBnqDopttN81Y/1meNKAwr
	/3ZIIvcLOJ2osiS7l8s9BXupRSRLIJxtl2P47xrICXjky/G9kWp3VRwLVqU4SCaA+Imqmf/6dPr
	7MFMZYiHUlmicEhn+ltOTc6VQXGvxs+81MfuiKs+GJ/eCoUOrDwo12T4LOhBYZo=
X-Google-Smtp-Source: AGHT+IFi7m7IPJloJyOQs2CLtH3z718IwouGyQ1nOAQKQdL2sR29+mTuDOLtp+cEiVwjfgC4aIc2sQ==
X-Received: by 2002:a17:907:9483:b0:ad8:8689:2cc9 with SMTP id a640c23a62f3a-ade1ab325f3mr1861228366b.56.1749568706707;
        Tue, 10 Jun 2025 08:18:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d755281sm748188666b.18.2025.06.10.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:18:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Jun 2025 08:18:14 -0700
Subject: [PATCH net-next 2/7] netpoll: expose netpoll logging macros in
 public header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rework-v1-2-7cfde283f246@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=leitao@debian.org;
 h=from:subject:message-id; bh=9MWyVnOGtCTb6f3l99b+ZT3EK3ZbCVffW6Ctmx3iUqo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSEy+qpFULA29lNETIGCTd3h76nekk19u06qRZ
 p69G+PbiFmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEhMvgAKCRA1o5Of/Hh3
 balGEACgWZ7XicJeIucyZxRxslAdwKCNmnMKL8WHVsa29IBDIMNUsvjVYHEyZZHwqy2nqSTVj+Y
 fpdH2/XD9KCmHW2FoZzCTxzAghZUg0eMFbIvAp6NxMu6e6SYVfUi5G2pT5SuSvKpjwyPgzj9oRW
 CbPVOY5G24wd1gjAJXqTpJT1aOj8nnrE7jOeWFuGbJvbkiYJmaRqsoPCwNTWSQv8UvjAzQiIigQ
 AjzD1KEdfDAh5wm9q7LeFUP/Il9N1NL44HL4xhVFQuvWx+R/Na7SsDTsTddd4Y3eF97CTrmwvEo
 5tYIvG2A5+Ji7DJlFmssX74bNKPKfKDmfosMsuxPl61aewnEA1ziq6+kxdWzYkhMn2SuWBU5uTj
 CRjcnwLPov3lCDQ0yvBiuO26/KtXR+lXsULrQHyg+DNfTnOqq4AM4LveqgWdBoNozoJLIoeov7W
 t0+r4SENytg+oLA4lneYvk5HGkDC87PkWAedvGfzyd78K9wR1xum6/sj3a3fGv/8SVCLDyg4bjy
 8dJoYcRndWLy0LgLuJ0I1FPxRKgYwfvbEZ2qjVLn+YC0GNb/lVRFoDjkvIfjrJ1ogv8rxL8dTQr
 5/SX/Todrm1UMp7k7uyf8BrCUU4S8Jr46dcsvK8XkGV4dG7uGRCnc804q9GuTGhyt2nlUtwT3i6
 lBfwOsOrjT7LIGQ==
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


