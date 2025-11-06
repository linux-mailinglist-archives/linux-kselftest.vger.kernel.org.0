Return-Path: <linux-kselftest+bounces-45002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D14C3C373
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A151B3BC031
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6763446B2;
	Thu,  6 Nov 2025 15:57:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28A33CE86
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444620; cv=none; b=pDj0UxIhl9g/ZI1FEiwLdkxhTR27CRBg6k0BjONx3gzON+fIlIc8vnGE9qTOfiLUAJ0Lm7JTI3pUnEyYZckTVeB2Vzd6PIghpbJ10N9OqvPPEg1zr7gcb2gqK8ceG8Y6ba48zli/Tv554NZa52h6Vd3ayxFZgdTy0s7IydDSGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444620; c=relaxed/simple;
	bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOH9RDuLbiFd5YA314IldsCxDZHoj2LGp77tnY24tA6n9vrSUjk2Icpy9VR3XCWMfKPK2ABkPAwwvZHsgUMVCZxWen9EFAWa9tjRTWxaZTuEvHXknka64bN9dhq23sEpei8ggsv21v7wuVLHGaSYGu2ptqOxaihxkEy8m+yLKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b727f330dd2so189556366b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 07:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444617; x=1763049417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjGKFyPmmnOORJmfJYb79vkMgO3eaKsfbWlFTGwHffE=;
        b=HGe2wa/chl7nIXeZWqNngWe574m9J1gf79VX8IiCfVtXgSwbX0/w0abXUsrtNapdUj
         1ihtwNshwp6P5HPco4O0IJJwDIA3/2qsnvy9kdv6/Agd9KLOKL+8YoHDEwfU4Ys9JFhw
         GROEpP88fri8GNCdZiKgznBmt23Y3ijCgF/alqRyNhq1/VV1jYnnDlZQu6/OYfWVHA4L
         /Ce7l6HsyaeycTVpXQwYhqCHNXrD9xtsRperiltuw/v1xG4AQzh0f4uYz8I6Pf5JK8ak
         lLQgKyZljxOte4/9a84iVHM/40wGeaz+TwyAyEJA4eJMSdJM6TeBwt9dzanh3P9VbgQZ
         7h6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxIxci5OpgbiJJ8yMoaeCEQFjXkIkVq1Mq19paD797fVahzgOXQw6a7lmN6G5Sk7FwRN0uVSqLc3FZ7ZUUYsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaReh+rKmfc+k+51cqhHT6vs27GBfJjvblSHuCcbJJWrKehFP
	1Ujg7FEyfdBPiFmh5ly2qtAHGzZvjocqa0Ek4MlsHXyvX4HD8m2lu7AR
X-Gm-Gg: ASbGnctCXI/FYXIoPbln7S39Rj3/of0RW5pKhE1uBJmlniY1HcsHKJ7zPoOu/mLGBdp
	rNYs5QekodtHeYfcVpPUibHb1q5kQzzifzSzf0YKDIJviHtUkM6/OwGgb4THKkfyAYAq6rXGWs4
	QCAj9KA+QFTYzwk8AhArZwVP2LY0dwAFZynGE/QJ3BZgWarERYbDUu+X4npmGRQ69x8oxD4vcwS
	dKIAmdwsc57x1n36dZysit35RZ1qLBxVxzGqTXb32x6Q2yabG7ju9IsXr4le6PCswkwYo+viprR
	D41xlBufG7PVU6ejSv5LCTA1mbyrFCmhkE3Z9PCyyzv2gjWWmiNlFQPy/QyTse7cZhqNwDKWfdb
	5Kc2JLhhyuErroSWU55wo6Xmd0+rjV+Kj4PJjetokL9a/gz6R/ah82RcD0O25etfIGAxRRizNjD
	I4AQ==
X-Google-Smtp-Source: AGHT+IE1I3KsdrFfPzR8ZbLblQmlN8xA2lL4chWTQNh9/e/sKcWfQSx/nPRWrqzoh4RnHnBtbfozTg==
X-Received: by 2002:a17:906:f855:b0:b72:95ff:3996 with SMTP id a640c23a62f3a-b7295ff4f7amr227875066b.10.1762444616910;
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334090sm250482366b.13.2025.11.06.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Nov 2025 07:56:47 -0800
Subject: [PATCH net v9 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-netconsole_torture-v9-1-f73cd147c13c@debian.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
In-Reply-To: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVFPcvHaEIvqY/K0FMrxc5XuLCG7DPYcVfKr
 zAJADuB4YiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRQAKCRA1o5Of/Hh3
 baWiD/4+Jm/bGM23oRiaStiDbJzcHe9o+DQub4eeoFUmIU9ViAwTIOYJKC2Nqx44QF5Nx8VSWWf
 U55ww+CydeULqtsdCNc2D1LQf2uqpuVKSY2yEhgy416XNIB960v0vxXwc6PNUWqu9qNtn2GfXoO
 g1zIdEe3lPWnVzETl1lt8lsapfeQ21XNwWIY+QQbD3FICLeTGLhzEOsgFyRjw3M/tdbI5OetPef
 O7qwcMiXmdoZvQP1GpQfwZX+F0rLI4+vAVvI3gWMKlKqYRf33nCY8ErINNcKCcrPI3DVuIojB7G
 eLwPPnpn4RAcs6PAkaoU9Nof5DA50QAndSBbjLMr4E7ez3GtlUE6q5SjnS/HGs/OdgPyf4sL5sz
 lXQI6/GJgcCIhciHAFVD5vlOSderxZGNeEXfvkJGgqtVLnw7EAbH+u0UmQchNTlCixBV4VEpYi1
 4BwLALvT6ST/xqAacz7ffxsGDAMiAAQ5wRy4y72V6kmBu4AvCFyZC9r7Ea4cFuorwtl+Vf3mVPF
 qN1Kwga41B9UVEe/YD9UeNdg+q8E06PtLpdLF96ocI0+VRK0Tt5lGoTpYZgq8ljGhglTbtF7fyN
 Hiaal6823bpg7LCdP7+xCRFdx98EpWj4VoWZWzBhYskGMkmosh1qJAQVUyoybopbHFQM+lXOe+t
 8nTugHL0cqI6kRw==
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


