Return-Path: <linux-kselftest+bounces-35189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8290ADC46F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42E63AF13A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5492900B2;
	Tue, 17 Jun 2025 08:19:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36A28FA85;
	Tue, 17 Jun 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148350; cv=none; b=MeQ7fiPG6Cx4j8vcXHNfe2E1eIABoFf9xRFcIBy/amnYV/mIfyl/wqAYoq+Fxs+YBQqU0DNO1JiFLqVKOIADNzthLAjZXcZAwudTdfxh0uoERaa+qCCFzC2sd5d6VfTr3WxUxJgmg8QtGE8YeSQ/kmJwIXbcmvNT+C/8vl1jSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148350; c=relaxed/simple;
	bh=zSahHAyNc5DOSjDOrc5CjUcgeEcPOt9C4NT28ZOvawA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcjEAp/jruo3VCC8EIkNS5YfdtASo7pEycOSgJPePwnRYG/9rlVnAt39TMh0wMJ36OvKCZO6y82H2fhM+b1rLvah6GU2XMv5lmbRDUtqQcL6z1c8ts3KgjZv9UZSY2ZmKRc0PoNIvWCSyh/aQNjTQn4Emsf5HiGoQrLPxEdgtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb2bb25105so924541066b.0;
        Tue, 17 Jun 2025 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148347; x=1750753147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlVblHQijd++iGoJb0guuLbpbR8TvW/TOOZWY1DJSx8=;
        b=giTW7znVD69XBZeoGL/PUt22VKtB6t0VkznScyniKDxkD6aRiDCMNglRpuAACX2SOu
         UO0FuXdYPimFlRt92d6GEfk9cMzvgVZOn9Z8gGGA4HAdeqt0qhKjgmW1SRy7lI2J52pl
         BD8T62ExblZ6g+qunvrOVRn2f+0+px4Zb61dUlwLmckkntwrxETEq2B2hFDS+7YuKhgE
         ls7JTghJKhw1ibdyI0LftEBY0iaZFt8vYmIsEvju4LvsrLTj3QNSWwyKTfwSryVyupIW
         PiOSufPXvyhaJR4If3n8iEO1IKoKpnFhhzpjhbs3eHzeebt44zTAvCAbiuLlqGs03Njv
         /CCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfXKHk5Gkl3nBgPq3ypSlJFfm7fZCzQMGkX8RXsvlePbXSY1VhLub0+8lqK9rm7PGcG2RJxMSowr8UtpZ641GL@vger.kernel.org, AJvYcCXw5x7hp70t5HP1kRTOboxzaleXRvdkb3dpfg+sP57um1CiyRbIGTxngJ1sdzJk+xe9xVgKykdne8SUaAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOiP3+dv3Dvs9kjB+zOlBtRXOCVLlUIM5UULuV3WUNyCc6b2a
	CPJSwR+/DYnK8hfeuYZU5e2NtclfRJ2DID1FkevXB5+hjqIyQElsmf0JPxlvHA==
X-Gm-Gg: ASbGncv5aGgmE34IIEHgh11GbM0tFPl/1lQWNxMbuBBHbGrsBi+EdS71xVcb9AkWwS2
	/KOoGk5o6vWBWi6AFuW6UOdtXDpZ4T3hkQyYsfIeP7SEW5dynLZsumKwYiFqMuPilUm2vMTlLD3
	mGDwmcMEu9pjj7uDxXP0E82gsNoNUYxrplJ2xlXiFIcBPHCwnqa3HkwpJBstSL1TdBOiNwRtZH/
	B8cfWvNa/vBjSJKTdB1V+F6pusZsDDBBsWGGO8+mHsTlS6LDZH8RWJ+J6JiNgcx7iGcB2Z+J+rp
	FuQy8pFzeSY/lyL3EjJEkxBMrjtaGNi7M3txT+IQaTMI+7NJXQrZDuEIIqDCMgg=
X-Google-Smtp-Source: AGHT+IE6do/tauMsh593lKnCKN/UhMYGoMcr2fi8w9aKtlP8oACRmL0Vnl1YvCwuWQPQw/y0z+yZtw==
X-Received: by 2002:a17:906:f587:b0:adb:45eb:7d0b with SMTP id a640c23a62f3a-adfad320f5amr1156169066b.15.1750148347183;
        Tue, 17 Jun 2025 01:19:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fed6esm818235766b.103.2025.06.17.01.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:19:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 17 Jun 2025 01:18:58 -0700
Subject: [PATCH net-next v3 2/4] netdevsim: collect statistics at RX side
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-netdevsim_stat-v3-2-afe4bdcbf237@debian.org>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
In-Reply-To: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=leitao@debian.org;
 h=from:subject:message-id; bh=zSahHAyNc5DOSjDOrc5CjUcgeEcPOt9C4NT28ZOvawA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUST29i8ZdzNuLthjSAm8ILxp/8HE4N03WuDmh
 EsJ33cWIqSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFEk9gAKCRA1o5Of/Hh3
 beAtD/9zpxcfZ/37WLYRBVMHXk/C/Te8pEh0t9sKzN9nhwFLcIaTIzRFQfc8WrDMQBhCCWPQ3j4
 XWp3aULBm2+MEriEIH1QpCP9bayQ/3xvI9f8tYyd/6eWSAXgb16bWGfEqI0FSvNjrmyYvd+3W9w
 TLFQe8aQXSR4Hz37SKYjePhIYcD6qdSYpR+QntfLCdKPLLhGg0QhTvyCskykbOvwUwRHUusj2a5
 a2z+vdhXzFLkUMLQ0qE+dR4HQ0E4Ge/GF6G7k0t/+AZtY+mwStm4fb70j5ebHkN8Zetgc3YHgzg
 3eOurnPgPpcJUKxxzfZlnLWpKdOxeRf4mEPAwhC7uG6khX8/wCLwiPNmuwogQPUvrnNtVe9sTyV
 lsabNtGiy86KYRjeaNkwKsEgeyikPGRRgoVPxJDYQbMUDY384Y+Gr00owpo8bZmzO5PUVuUtEEn
 lbLKgTcuGnP1JEwuGY9L4L+cY5Z2O62rqNPLROaPguUx+K09yM22h1rcMPlb/uRRP0MHlD9Lhqq
 6GszUqvhQO1XtV2atsAycDmK+cQ9y5TeoijCiti2Y1e5z421LuM4Em+UVav2ykPzMFPjIxbLq9W
 oX2yVzYsuUshP9WNiWWtr/zd6ZeZJLc4mJE1CHJF6tGz2J7u8uRjE69DcYBogcwRctfJfJ0Og6N
 XUtoMb03C9NYJMg==
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


