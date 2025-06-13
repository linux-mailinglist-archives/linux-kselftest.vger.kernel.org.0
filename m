Return-Path: <linux-kselftest+bounces-34886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE67AD89A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03E13B60CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291442D5C9D;
	Fri, 13 Jun 2025 10:40:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F32D5C75;
	Fri, 13 Jun 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811214; cv=none; b=p4+V4Kx7PMhlzy/oIQIzdigZ+hheRyfslnEJSmVi6nPCHWDFQYbug8Rg6sjmsow0bOmejeAINkx4gEy3eC1quDOyPs2f2sbnv0SWpoXoiV8dw3rDuMr8FLIMNN6s9ki/MtgZVHjCGN3M9EYx45qLfzia3iUDyW6OYFNTcdqNlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811214; c=relaxed/simple;
	bh=zSahHAyNc5DOSjDOrc5CjUcgeEcPOt9C4NT28ZOvawA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7OEUhAOLOYU1ZIA3Z/R9cO0df5f/H2KJ5PfP1CSQzoXmARvKHp0u4ITU2CACdT5H8MLxXwgJTnptme+MdZeETsrqIJP7dPB9tF2V2P7FFHiWocjoZg/jDNzbBl/auzJWHOGIcPp+NUPCXx+DlsTUtKYOT824XOGxkx1Nsl1FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so2975623a12.0;
        Fri, 13 Jun 2025 03:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811210; x=1750416010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlVblHQijd++iGoJb0guuLbpbR8TvW/TOOZWY1DJSx8=;
        b=PG/iW0YRC8qT7Dba3xfiIGdUrTI+Bw5LLcCVa0cma0yvzATYnhK7wUhqAiJMefZza9
         XX+8/wKQVu8jAwWJsn+jYbEM0e0tu01rhG9gNm//ah0BS4x2zzajYXj5s6StqQBUU1A7
         ikbxD4AuFJeM1NsGoWZWhXKZyNtYk+BbqsAG0eJ8ziTqYdePJq6AFb4c9mFP021ilpyR
         AG8QiNfQWIkXT/1eiorFdyKfvyipOBy7lKXvMygoIEMwj7oC3RxFMGQ+5nYR4YuQRVaK
         NvbR2f4/eSl7EGNyQFXaxZ0sPntaFqumXM6EiQnAVzhklk76Q8YdTs8ot2G84+KZOs1w
         ZjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhtXB5iF07ByqZZGEhmNJkd3J3zR+Hy3dOHb47mCQ01FT7w4TA2ES6OhBQHSA43l369haC7EzvxGzf2an5A08h@vger.kernel.org, AJvYcCXW3+ce/0yfRZw3B9sXkUVhjV/zAgEibs/DePbTzxH9/r/49On8ywIw2jjJFUnqARhMaPMKa9oeESRGWok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6aUP/tM/OftNcZK5KbEcrrEGP2NXUCtgLlzMHSMKADYRMUGh
	MNuwb6aabJ0+z03bfeSTkSRnjwdxH3ClN4Z4mSNgzQdespf38SviWqBA
X-Gm-Gg: ASbGncuWDwJ7gTelGjYG1STBv+xehOCBnH4z/4MRJdMNlHO4mGkUzrSHGQxHhFPg9lX
	rbTbpElgnuKzNzK+pLYAGf3AFLdJ4SF+7Q5JDx8voq5HK+NRjg/y620dJQbrrzLZm1ZJP3NpP/d
	HvGPN9rCYcB0VIMnHMo/bzLa3TAOLWhxHb/dJxt5dGaJbMpCZpnc1Lbw6Hp3HVfA0iKRQEFoXze
	o7I+8FWvgBS02ELddvDFKBlK6gRDU8o4mOzEnSXem4vi35he4Vp6yky7nSw1ZJ7FQMPfilSozih
	A7EF+jglW2VtnNoCFi4NGOVmtvWmbZah7H/4NRY8UIcjMIVeMAZp
X-Google-Smtp-Source: AGHT+IF/WkC5WjulJfTGXwmTsJfOj+XCL9sqQhkMsmLB1yclgbLvaZSi3vctB0k0QTHL4T1RZ6jeVA==
X-Received: by 2002:a17:907:96a9:b0:ade:3b84:8ef6 with SMTP id a640c23a62f3a-adec55a9bebmr221865466b.23.1749811209516;
        Fri, 13 Jun 2025 03:40:09 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81bff9fsm110155466b.52.2025.06.13.03.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:40:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 03:39:59 -0700
Subject: [PATCH net-next v2 2/4] netdevsim: collect statistics at RX side
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-netdevsim_stat-v2-2-98fa38836c48@debian.org>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
In-Reply-To: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=leitao@debian.org;
 h=from:subject:message-id; bh=zSahHAyNc5DOSjDOrc5CjUcgeEcPOt9C4NT28ZOvawA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAAFUG2gfDv3upypiuacq6IiKhNjEjy3MOghP
 2H+LlgjCb+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwABQAKCRA1o5Of/Hh3
 bUfpD/4rMX2bZgxxyiDtLKhWuF+vloXxZn9fc4761du/Q78rW5SGAtFEoXmad1GliVWCJ9Oo+uI
 xj7h7alV4BNh3U0Ul+YPS6r7aTXpvFp8QtUUan6xzIlUK0ayull2afoiuBnWtF+FJsqVrnJmpvF
 qs/ctszt1hbHdw4p7xAHNlKDnBIB8yw09Z+kOi8ylhyqWES3zOok+5oB2I7OnejhKiLKt+LUaF8
 y0u944xMf+lhZtfasWUuwj4ZrnnOrYnc5b9Br4PDnPKlNRNrAEdWkuaqRpln14DkRBPuaejQYF1
 KdVV3Gd/ns6GcZN/sgV0lcBpA0pJBErwrXCvbiewoB6OM4iOt24pCJUAWxK8H+YXDewsfJOTGFs
 5AlJw4gPy2hZqCi4Ipunu8yw77YBxIHq36MA82naxPzAt2kShyOnEew1WRa9FSpn2ydm76BTiD5
 9fTZ4MkAvZY9BH47V49fTHg6M5yJlQQUtWtcNAnT2YQ9oACL/janstEqtGzifnvZlfepF7Duiah
 SQohCq+NTXT4QofTxoByxYRXoN9CzuJUa5VaCdCorUMmnlk/yomn6OOJ5Zw2jdl/IZoB4fyYaqm
 5Krd/PHy/Cw5TYLFCEDdZ6GvZzgyoli7HK6vAChJ92mJxrXEzGk2TywnJHuuA3tldF4WK3DOG6A
 ExyYaHosC62NRjA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When the RX side of netdevsim was added, the RX statistics were missing,
making the driver unusable for GenerateTraffic() test framework.

This patch adds proper statistics tracking on RX side, complementing the
TX path.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 5010d8eefc854..de309ff69e43e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -331,16 +331,24 @@ static int nsim_get_iflink(const struct net_device *dev)
 
 static int nsim_rcv(struct nsim_rq *rq, int budget)
 {
+	struct net_device *dev = rq->napi.dev;
 	struct sk_buff *skb;
-	int i;
+	unsigned int skblen;
+	int i, ret;
 
 	for (i = 0; i < budget; i++) {
 		if (skb_queue_empty(&rq->skb_queue))
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		/* skb might be discard at netif_receive_skb, save the len */
+		skblen =  skb->len;
 		skb_mark_napi_id(skb, &rq->napi);
-		netif_receive_skb(skb);
+		ret = netif_receive_skb(skb);
+		if (ret == NET_RX_SUCCESS)
+			dev_dstats_rx_add(dev, skblen);
+		else
+			dev_dstats_rx_dropped(dev);
 	}
 
 	return i;

-- 
2.47.1


