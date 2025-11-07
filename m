Return-Path: <linux-kselftest+bounces-45095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50D2C403F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F13B3422
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF832779A;
	Fri,  7 Nov 2025 14:04:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2D2FB985
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524249; cv=none; b=EfctzTb7uK5z1irTBqkMvCJyPS7NUJdJJ0ArbjE79b/s2Vxy5LFKwvHdC1yRxdFrXyFKAjireWW3SF6ijkfj7pW13vtOHD2V4IjtrG356X/v38ak+u22ZvRU+6pNTB6SPOmGObCgnDnSzPzaoMGEWiyBAyf3+9OVvceuGFT4RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524249; c=relaxed/simple;
	bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMngzZLK/TYxzpYPaQOXTzkcrxY6u4QQ6LGikSIxN6Sha7PfdFiuMdIfEGY9eNfwrbSdSlBmWQy4XHHslOyqe3iH3k3QpjSX8dsVpeoodcdiNkrPj1mytzejIMuAP0K0GBG4dgDkk4wkHC9+gWGMvidkv8nVfHwEroJ0b8gjoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso1491873a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524245; x=1763129045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjGKFyPmmnOORJmfJYb79vkMgO3eaKsfbWlFTGwHffE=;
        b=NEybFf/Nq1dxVIPAf/w3ZZthWH4naelBVHpmolSaJxDZVhaIW8zhopbqZIN2hjBMLd
         4NGeavfEyxI55q5AnpLw+Cwjj5Kexrh6Kjn7awJbrunbrPmKWkeJo3k/xh0SQd5CWhYD
         cXK++vWO0tY3+knccj7YtXLg3PL3KmZBZPc/S/Li8o2DzFhSD55RfSMacLMyKqfzrB3W
         3YGEQfLlk3fI6a00jWxpj7f+VrgvxiHBebkSIOmQSgDWNoKn3PNYbcu5Z5uVGGOKeLfF
         i3OE38jAlIZ+3bRKXITRRKpH8Jj3r9OaCIs1OtuhJae7E4Id81p6vplcU1xG0ft9DT6M
         2SRg==
X-Forwarded-Encrypted: i=1; AJvYcCXYO6gIQL5l9e/v8BSDjwzwulC227GU3c6evZrFisQ3ZwAuIv/Tox7prM9Zl4MjxwtsTMsI87MenhWn5HMuWV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGJtI2l7d8FO9RJntRuhsb4l3uftwRznBhJG8uVAqQTxqSHM2
	SfcsOJE4teUHGVVtWE8Z29kUW39purV1imjjxLNwSkcUFY7ZIknIgWhVyZ4jFw==
X-Gm-Gg: ASbGnculQkoVAcQf6lf1Njt5GSGbES5ikjnR200cK1sH8PZIbboWQmXDgWttbxWrx+V
	6g5hxE3xvQl5njN3ID0be+OSVHxaiCCCxP5KTPJrc3cjQvBxUvQOCG0/YOw9qm2A1DV2xaMb1nO
	W8SKg1Trfko9CK+/7lXfJt8urDCNhXen5q1e982xAJnSnSfIJgNbjFG/6/2/CSeANeAOb2Gkj2n
	hDU6I78Dq8BzdthUore5gbktUVh4CVdW6EQREWhnJi6c88x4SM4DdKEyfVO2BulNDTrMQksOk/4
	aCpCNg3c8jF/X5Vr6b8gGHopvQoqr+21qdT5U/msLFUE1q8PrZbQIICvQ/N17e3ToJF1cMBxKaz
	rypIxZrQpPZEniYV3e9lX5zI2u3BCAh0vIjrkvQAZ2Xa7Rsr3t5kK8QLP2MzoQJuolxZWmctWZb
	G8YQ==
X-Google-Smtp-Source: AGHT+IF0zw7XdYz7vcM3phUQMOrnFBlIHOTr9IuGmwv7KNhzEHTNvBcJ4yY+AVdmmb4MZwhkXftiaQ==
X-Received: by 2002:a05:6402:5112:b0:641:3d64:b120 with SMTP id 4fb4d7f45d1cf-6413ef4f894mr3089941a12.18.1762524244877;
        Fri, 07 Nov 2025 06:04:04 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578ecsm4116404a12.19.2025.11.07.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 06:03:37 -0800
Subject: [PATCH net v10 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-netconsole_torture-v10-1-749227b55f63@debian.org>
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=leitao@debian.org;
 h=from:subject:message-id; bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxR66IUfHQOCEO81HXwPeIzUPA08Bi6dPx8P
 jKinLB5IwuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UQAKCRA1o5Of/Hh3
 beYAD/9T9FlKvwfyunjOenx5s8BJf0h0BhplLEhAaLaDNUiZlHWNi3TX43tzuhundshN7VfbxQM
 pVqbepfqQhbcRuZ+XIP5kk6ZM2tRJxzMST8l2TZip0e5AvlAuhvEPtF4/yD3ikKTvhyYcJY3XMU
 xRXrHoOdhAaoEKdzqGlz+tjSzod5Do02jr1PfX9KQOVWuOr4xHSI/3JBYnvl9iwQUb9iSBtUOP6
 KBnn7c2jPPdhRaG8iarM4BwxSzmeX6L9gfuFPabSZOAsBzIdgiLYkaEb/UaoI9LQoh2kp7JYXcd
 CQN5157iVL56GTLSBydY9lJZiukoq42Znc/w59iSNMXXrJepry2kbjM13pIrEduoNytvnxvOurO
 5mlSpAg44u5ShzovNmNt2NC+L7bZtBYfa3Vug7iYBvzC2649s/sP6yeBXG2dR+wchkHFlY5nrF6
 X+AIjNFD09oi0+ykEjjCSJ7OwzNPs3yUJpMXNs972QqQ+uvu7dS2fZF76XoIBVKaT9ohH7JNukH
 dIKVdHQZ5x2fjNP4Kvx0I0EwEo8WBMkUA7tyPZmx3ye29ceT6rRxvWs2nTpYDW4NZpT55qQZF1v
 tHozXJes+Akv8AiM4tBsXkbL6RlVxJv2K6Nac8ZOgevHz+gKAEHIfx85IHkydMVoMMjxHxMsZ7j
 0vyXgao7lsr9QdA==
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

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c85f740065fc6..331764845e8fa 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -811,6 +811,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -820,8 +824,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


