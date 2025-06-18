Return-Path: <linux-kselftest+bounces-35258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACAADE597
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1252D17ACA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7428000B;
	Wed, 18 Jun 2025 08:33:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22727FB01;
	Wed, 18 Jun 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235581; cv=none; b=mWjp6Qh198n1G31z2KOlHCwxQuior0Ny4XDXiIbzaArqAVJm2ymwp01Ub4gp7W28gj5kCN7JnOSOvNgoyn/kzJnXVPr9jIoxK9rUTV3hxUkHAoVr3wQ+I3CMBf77OyG1xRuy6W0HRNaiWlwW3Dh0Mjqy64IuPzRJB3V65wZ+5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235581; c=relaxed/simple;
	bh=5XMFG3vfJ8oR1819aaGpibVmrBL7u7fC6somW9XJGN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srAduZ2h41Mf38ITH3/auoqfQwkauPh3riFAnQpua+w/iPWueacVEKUN4fx9VweE3Z+AgL7hLNoOvqM7Bxa5IquEmF9dfAO9GMP7Kl49/BpkEVYzyLXWd6Gkaq/I58XFijpoMbV9IaDN3lHUSuvXTSOiu231SMbUkAVZh21MEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1087269166b.3;
        Wed, 18 Jun 2025 01:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235578; x=1750840378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xnMBVq33gXIc9LYivha/soR9GpiA0xG3owR1CxH/A4=;
        b=O/uIu5nfXwatuRZi6qNHVAkcxk0foDPoRQrdg03CGpI1iPF0aYgKdsBVAUoXDe32cO
         6gNQH08mbYXk+ADPD/XWyFJWTpj+BF9C9Mnqp7faOm95tmUubX8/8M85Gd51epjcQc96
         47RoEqyXyQr5YHwOlxFfpNdr2KqKkUKbm92VOCvuN0rjTeYpuZx1Ui5eendI7cgqqLO1
         UilICLlzGMzoDaQy6MOc/HDte5CgIxoK9TgVgRKmtiEdXEGfsOa+kQ3DLo8PZ/A1sv3v
         oBR1Gljt9FQhPkV1kEd69+19kKDaXtQTD9VvfjZUsTEXF/xlhQwamD7iSeRoYy/c/pbZ
         KTHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1XNH4bnzTZz5nW8zmew5qnxpI1ZE76VGEMd5SSJy7mW0Iw6kEdlx3UA5L031fgLs7vOoArARzUKbLeGo=@vger.kernel.org, AJvYcCXKWiXo+DKThG53ta6OWh7rVzRqsaN+wASITqMAx5HvNQkIglBZ/5+GDmszbw8hk9frgBiJkJU7gmL1Af7xxSCf@vger.kernel.org
X-Gm-Message-State: AOJu0YzeledkTKmk0FXx9RG5AJHW61XQjnOor/YQjFutpIRf3VHt6/fM
	YIDaMKZNVhPok7YiH3zWrnXgkiCMWA102pD0kE+Y7bGKMDZWFspBesgv
X-Gm-Gg: ASbGnctl04qr6DuP4qRWfS7PgwxKeCEO8AC3HYx6VmDK1DloeiYk/l0a7AmivCIQbrx
	HASOCa7V+rTwKsU9XpoqYahZgfCW+MH5tZc3uNqRMj1QZXNcfpy06WZBomkNpVX0k7IqcfYKI/5
	WtoHMkjyJNmEjkURk1ruGYMRuPm6Cje72242QR/kdfkOr5RueWyvEaynEq4e9r8HlCSBR9LtDBO
	pn89t8VzDN46/TPT+/Cje+JFxaJ4dE4u+ZVKUHkId58gRntxGgqWTLW7Rl29pTNglMJUes03/VY
	L/T1tXDFHsATkKwvrjFfhFpb0cBYFF8ovWj+9Wq2aOZ+DCnD+ZNAOg==
X-Google-Smtp-Source: AGHT+IFDIXeOAJtGZAN04LqmAEg5sQOnOdrtOT8uLSYCPsHsZ/luA6U9O+LRKMHx4Gd0M7BZnN0/Tw==
X-Received: by 2002:a17:906:c14c:b0:ade:c643:62ce with SMTP id a640c23a62f3a-adfad530b00mr1753843366b.56.1750235578289;
        Wed, 18 Jun 2025 01:32:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adfeaed2d10sm435100066b.105.2025.06.18.01.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:32:57 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 01:32:43 -0700
Subject: [PATCH net-next v4 2/4] netdevsim: collect statistics at RX side
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netdevsim_stat-v4-2-19fe0d35e28e@debian.org>
References: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
In-Reply-To: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com, Joe Damato <joe@dama.to>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=leitao@debian.org;
 h=from:subject:message-id; bh=5XMFG3vfJ8oR1819aaGpibVmrBL7u7fC6somW9XJGN8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUnm1w/sUKRh0SEmr+3keje7qNIgQKBuzhq64g
 ELmMwteQvWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFJ5tQAKCRA1o5Of/Hh3
 baKMEACqOe5oLcGnQfFubQq3ZQbbngQshutioFomFRc9/SnnmjNvM3+BkMrZrqQbfUVW47hk+mB
 b4SXKt/DtiLeHNak5AIYeBt+FnSSDVmqljrDuLu17rQVPDOrRZkhl/rYivbvoOIlWzP0mmgJaC/
 ZowAs3b95syq9iE46XuIozBF3DtC0yCqvBJ4Ksgo2cVus072r/9DAbFyAw1TyWIoyE/ZFxpQVOY
 ZtHleo/iPAneSXRjXpUvYwR6Uk4VpYgPCAAe74M1Gd51UVq90zU1DBxQe8aIGWtkJr+fJu9ueEy
 UvBONMS+hnhqyZrsagpO2MePiqNfRyR+XouscqB9idcJKV8c/M03XmmPMcj6gkUGCB3MXHlslIh
 tOgj1BDoAfx4+4wIxTT+xAjjUsRNwvcsn643IjT4etMByd6CsQwSFDHZp6TTWi82CCBbFMKv5XH
 PtbBZWiPU8AFNiUfC8W7sN9/hqXYqIz+6rtyeX+wstOA9Dv9EkPUnucBzN1pWKnxe0MBluMp+xL
 Qu9Crn4IKh7sHOUHxRv9ext/TgU3iJkrHK82jdqYr+jMGOfgkayzOd/94K0BNeJp4yTvnhOXaTw
 0xim2UmJRdjzlB68WHg00BFWJqxPcPbb7eH8jZMjEc/grrn9vODDeHJ21t6itQ+No5gDK/ViAvS
 DJhBuYxUVsr2hMA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When the RX side of netdevsim was added, the RX statistics were missing,
making the driver unusable for GenerateTraffic() test framework.

This patch adds proper statistics tracking on RX side, complementing the
TX path.

Reviewed-by: Joe Damato <joe@dama.to>
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


