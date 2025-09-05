Return-Path: <linux-kselftest+bounces-40858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12548B46008
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3B41C25EAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99135A2A4;
	Fri,  5 Sep 2025 17:25:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DA3191BD;
	Fri,  5 Sep 2025 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093130; cv=none; b=ti9BaFx3NlbPcdxq2xZ1+rdOU+pTO5X0s9xifYwJZYpE/g5uneGPrJQLw3GG+rfupOVFpiV3EXvd7yxhwFYfIEx9CgPUrglJ5KHAa7L5/9qitHSEfBYhTHIJYPBjtjzn+oltFI+0m2FGkJUW8v/tPgCeBaRNheJXr3EbDA9zBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093130; c=relaxed/simple;
	bh=Y2cL2CM8ef0LBZWCrR2npIMKpR4HevyWNbeYU+ljeao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tihy2ScybPHFMGVqFzWEU12stbO7uyQ8qiOUZ23c+2nDGbRKA+Yx2OejGiHtOJaSXe6p8TZspL0ISNPM8an7jZ0eupFCeAuJ8rBtEGTje+NTGi/1sRV3mtRRuFsyNIKXu1wx3P2HwVd0UYgNCKpUjJxSUoqpSjAOppz3pO4ZQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so384665466b.3;
        Fri, 05 Sep 2025 10:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093126; x=1757697926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkvSPla93Dt856hF1a7lZwE5EkX9Dd0cV124BnG0es0=;
        b=rYe1/wxctWqB1fi8r2Ie73L596P60KWfWuHAttYqR4fFkz4XwVx8ySF8qv3ETPqghO
         +/pQ159u1T80mlvkm1xY8+r2OTQ5LIOsmEIxnB8TZRTp0ycu+Vx3fO8GJRoRtzY+BN1Q
         LoMF2Y8X04i+Wqm31eTFEo1cOt4FkYNNE2LMQsFqWn3xpl2XPL5UOG3TD4zbVKrkRqBv
         jEZcU6ULIX7Wpx+ypqiqMkD0P4Il9Y6B04mLu64OKRN4ew54Ukj55tDQ27Rh3YkQnskA
         goMXNmx7hL6wmBwBRvazLhxcaEL6/NxpIHQK5OIECwD6uBJnl/XxUN29shdq10EgsYLQ
         DdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6veGayU7LjtvRvPiiRrDSXvw2L1JMfwAGW6IyFIsryNjEQLzrBxuPbPuZIWYd4OJt+7iNbk7Z@vger.kernel.org, AJvYcCUCbr8c7STdB6xNG9xqS+jXbHaNHtj9ta7wbicuHD/4ADTPex5ldGP2ahcuNTolu3eYSy+7hW6M2HRDkwn7lBA=@vger.kernel.org, AJvYcCUOoi0n1K+BSFocb+fUlgGngGupe1X25Dvsn4T8ZkZQyEcIzeF8Yze7kQmhqwRRIuM+8xBCOYJS@vger.kernel.org
X-Gm-Message-State: AOJu0YztZTNN1JGKLYLDibU9mQQD/CG6hh7UFm+buy0WgqYeOhi3iR6g
	KNW4DX3eAZma7DGEMt1kBY3Slzu8MO8CiKx/GZdxpqfxGst3wCAAw0NL
X-Gm-Gg: ASbGncup8zl6O7ahyZsa7oFGjWy+2NSb2//cdxJvIZ39aRXb+rnx+ZF2kbLUr6zzEMJ
	YBWm1q/k7XSB0ZgGMrwW4Gl1X54JXiLRNvWBADZ+6WuEqjN5XX8P6pXDoJTaQtmcatVXshAymKw
	2z4QP3YmRJK1wUvzXlQ6zwXCBn4NffeR7YJAMmAc6LSgkxF29DIlV0FLrNAoLuiND65cUtyplii
	KbhWE1Hx8LoIc4YpCUkJfqv4CZgYo5WO2hM8kta6hCidcxjodn37TTcdl5B/z7e6vYTYUL4Pf8Y
	iXiDC22EkmxN4iSQvPKc1vLCvaom/ZZPrNZslsgldNZAN1BJPX1PS2bvrH9ul3+fH0z2Dw8Q2DA
	Yor5V0H1Z3kMDw4ZO6kBaBjo=
X-Google-Smtp-Source: AGHT+IHZNHOzCTLu5B1UuBIpDxd2yWEGYNKxFVvQXi9qBB7P0Y3feStu7lTLcIoWOaS98cHSOIs2wQ==
X-Received: by 2002:a17:907:fdc1:b0:afe:b878:a175 with SMTP id a640c23a62f3a-b01d97a0c24mr2557577666b.46.1757093126253;
        Fri, 05 Sep 2025 10:25:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0426516668sm1313660666b.46.2025.09.05.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:25:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:25:07 -0700
Subject: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
In-Reply-To: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org, jv@jvosburgh.net
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2614; i=leitao@debian.org;
 h=from:subject:message-id; bh=Y2cL2CM8ef0LBZWCrR2npIMKpR4HevyWNbeYU+ljeao=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoux0CXzKDzBcB2ock79juPuqbVcy8Z57Wdi9h7
 EhzpIBUxuqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsdAgAKCRA1o5Of/Hh3
 bbQvEACkkIRatGO5oJfTm7pj0y0Cm80mcErUguFwHsbPMe+AWbOdWZIgMWotUStcWcgf09XPnva
 tZOXRCn/fvBMa8aqwysk47WKWTJsV/HxKmMslr+6aApzTtEk7r64FAxsHxCfSvtjOIHMM9nOYPw
 Yo9ruEU4I5pP0DwjbBMiXNWC4dbGYQAehRkOmqdxoxBaAnMCGBTwOI1RO8D4JcDivGu7dtvHGTG
 H8Xq8HZ+80dVSrsSONPNiOsPk3Y/ZLj2aBRd1JKuTK49swb/8Bjol2LWRe6bOkTBGXMXSYP/SLZ
 /p9/sfY7uUGqxlI08zc+vkcM8kbdpoVzp9whM4dXFg7EMTw7xtK92DOv5GOba4l9+6nJhwLfu8Y
 ff489kWI0sklPdh9Ib/1ZjDMG21EAoGxXy291x8X2X5saOqHhwrjTYDa+bDRFyGL172d7li2Myd
 sGCG72R1Dy4vSYzaDbV7qMp+rkCWEBLNALtwhRzWKoon62qW860Gbl9H5UjwKYXFcaWsrhmOwoy
 zJYof/VpWYok+NwP4cPvxgsNtEHKTk09/FU7vU7D1/u4TJABnp8I5SW/r9Skr23BezY4Vwq7NkZ
 KiMUEHK2m4d5C/5TjHMLKafI6VKE8bb7I3G44n9swikJyX3hMN6qKs+p/Ag2sgeGCIWgdNZQmY6
 lcA0yV8XAH665tQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: stable@vger.kernel.org
Cc: jv@jvosburgh.net
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..19676cd379640 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -815,6 +815,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -824,8 +828,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


