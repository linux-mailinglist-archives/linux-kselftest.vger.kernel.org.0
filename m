Return-Path: <linux-kselftest+bounces-41822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2913B84307
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 12:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81931673DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5E2FE07B;
	Thu, 18 Sep 2025 10:42:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049E2EDD6C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192139; cv=none; b=Kyz7IuKRLgCiYkFrMei52Dc2QP6M3vBqSnS0LHDuS1sGVcmOcLJPu7hLcDpsb98qcp2tQz0AwFuXGI/RFtZzutSkmCezzvt8Yt1LbB59Mr/IPuywcGrKuJ5ocIO5hzxLT0FIZZTuKNQQvj+Xw0PAdq9ReT9bt65DhYI6rtiwu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192139; c=relaxed/simple;
	bh=0qblMs7pvAvukMaqH1XZzSc/HsAgRmJmnlAnkCtcl+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUXJlDrMDtTiZfmgFYxuqF2FqPZ19hSL1LjEAI/4GBilrheZ/yQeDmOkTlMc3fFoNv3G1Ylz7Svo9pyR8xBhGvNTIWD9aIuCwMSQFxcPr6Q74LY6BmXKC5XxdKRIdY2nc7InHACke5Hv/zp9imeFb9BLBuG2Ni1ZpoDcDNaqV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0787fa12e2so126680466b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 03:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192136; x=1758796936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cRw8y8aLRwmgMXJrfhUT0H+SQQUEvdJ4IqhIR3aLXE=;
        b=FYHEjz8PP0McqPU7FUW6H5+u4IRPNsCvNRWsJ3rLiKDDHFPFq4osUTNgmANZYT4W2D
         0rmkzn4bVSjMuAdeuKS1cGxJKAwmWB5gHU5rqgSpGa5Px3nOGMDFJSF7RpPyMmi1kTVA
         QpYnXnO4kN5y6gUQWxAukatK46Ka+y189zbY9qEdTOyHyFMHmGx4sKK7QciEVkTAhXA6
         YFuQYAaD4R5xmnyGg8rMRexzQnUUVq61tdNs7hXhLLxFNMNhmBYrQTL/IZB/MTDwe7X2
         /HomDADkxS2PDXGK8brc5UVT8LzmIKr01Q+6EO/7p40UZusznBaRlZcZ3xaJHgycOpa1
         S+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+k4BYIozO8RhQSHc83o5vZN/Ni4rcUhmXczylymYa/OiyUM46qKXSi+4NoY+ThNJkCtJ7WYBmu2aBX4TmdfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXWFdZ4McCezOGR/79yzcN+nMkc7cLJ2W3YiCZl/Vex0Kmb/X
	nMr0gdaqFkGoGbqSFhp0sFnEEGJ02lXDKlwDU0QJEBbwtYJNw5NRImou
X-Gm-Gg: ASbGncuSDv2OwSFNCEm73Dal05OuHHJ0Igd9lqPfh/8SPhTazm/2i/KIHmqVOk6b9RM
	WYsTUjamL6QGCzprlyWxnKSzR7840egvs6QqEOHRjANrExjMJOG9Q0Bg4uMbgC5SUYhLKXZMoCb
	4aHzZPn46x8QxPEYAjJk+Ol52koZ7BFOdSRKdmM9T8iqlmA14OhaV1K6AFZFY7GU34YDKzxiFWB
	vNRfqFdXUtUZb6laQ+CTXdcZeGfzD44JCfnIXPblJPBhnkC5Y0hwT8YicKF3FvOHf8qDrYN2xDG
	iJ4HkEqHy9YltZ4vFjIp3EuQ0VkjH9RzwqJgDI3KUhJ1UOVnFNDyqsE6QEeXYIsa1UkutYe/u0y
	heogjUGDzI4MLImkRg2yF4QUtitE/tbc=
X-Google-Smtp-Source: AGHT+IEen4VTSshGtU3k73aBIzuXFSnZy2lHMd9isfLbu7lLEngvBaj6Hd/jeZSUE4Vng9OKkRulaQ==
X-Received: by 2002:a17:907:3c90:b0:b0a:333:2f97 with SMTP id a640c23a62f3a-b1bb7f2a341mr613829266b.37.1758192135547;
        Thu, 18 Sep 2025 03:42:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43884sm173998466b.3.2025.09.18.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:05 -0700
Subject: [PATCH net v5 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-1-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
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
 h=from:subject:message-id; bh=0qblMs7pvAvukMaqH1XZzSc/HsAgRmJmnlAnkCtcl+M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEkg4upfaClHOYSMpVXOdvghNm1AX/xX9xQ
 E7C4l8p1CqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bRDHEACE+pWQpKmGFKBg2obJPsqbG17N51Rjp/3+eJPs1geX03/x0rU7llUqu8zKj48ZxwUn123
 oAQXLBUqFqXpzFERQHVZHdKbhELy0bbRxxufyPN+RPkOOjTAvN8Rp2mUYvKqAsFW8aAi+MvyiB5
 hXmuxMm8Vd3KHbVSnF5wFj4+jAPinZb/r/qhkUdxF9CsoHED0yZULlHCtqYMo8i37xxqPGXTM/D
 z2ofBArf0qCgbYSVeuRJJ9tKKr431dXLi0ZSdOm/J5OT5J6JkgU9ilRGSAzijjUTuS7GqJWOOEj
 emVUvt2yG20XQCfkt7G7pN1ib9OM3vQxrQYXrv+5t2b8br6tqqPOo0irlw7bhBE7SISP0o16YHr
 5akPpO0ez5Jhda79rDFEuTDD3KSRrJYEeGats53T8uaM6YoSSYj/AzHWsVIYnz6VkXS1yu5jUR2
 VRLg3DLeSnbuFNs/C9Ak6tAJeO0h4usrWhDnpGsS0Qo0LOtVAo3QrUXqm7THxmhYaYwnY3BdLSy
 eC3uAwOpw7VxKYRAY4Jm0MzsGye/8dpy0Fo2qAJYy7ot70SDVe/ikfZMWaIDmp13nWYK24ilgs/
 x8mqmuEFYjktZ0rn8Dl63ok9w5EQMYdlteorbgFDZXPmiLubNZnnjukm6rhQoSUar5paKAVlFV4
 qgfg8owAi/QARkg==
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


