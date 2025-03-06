Return-Path: <linux-kselftest+bounces-28377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B76A5439D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC7167594
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379F1C8602;
	Thu,  6 Mar 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln7ogm24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992817C98;
	Thu,  6 Mar 2025 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245904; cv=none; b=kvbtn7n8tYnup9Cs5yp3zIN5DvT5BAvJZITnWpLjMGr2Fxdt8b9mUvv9aeQZqMIYdprrIGR3PiczaF4dGwDQGUhWJVNJWqdrdRzMH3V7lmi4jAL6MaWYPa7FWH/R1gn4kquVPkUQ29F3zNG/7RQS9AKYtSisxg8Cd+aZ8ebjweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245904; c=relaxed/simple;
	bh=k05e7Pnks9GT3qGU55+DUjdcK+iN42Qh4CESajk9aP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dy62Z+jhGQjfdcvjrDOnuNlYYy1jl9wd9s8rH9gZDyCvKz3j5VxkolQ+iGkLcSThjn7QjZG43cmAKIAx/rBZwqBGJ9hHnHN+8vROpmyyBdIvwV6c+yf5f8Msazjblt+CEpIv1dKEcrE1E0TPVz8P/LHxg/Nvk9jTjYNv3oHh/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln7ogm24; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so549679a91.2;
        Wed, 05 Mar 2025 23:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245902; x=1741850702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIyxZ1JG3rdG0LAbrbn5O/IyfTxj4J52uMpC7PDQlEE=;
        b=Ln7ogm24OaPHoz4XQjVFV84s0GT9h8O6Xc8YTNxjTj0ykToLf7EzMbzPv5ULyk66sc
         QLf6oIlZgLz4qZqX5KzCM+Ej7Wd3TuUFsJqz/4PDV71HGU4dJAKhReGqaqUpFwju8UhU
         hqY7txjRS1E5WLGTv8V65fnU+fVv1+gol4Vp25eke+InglqsU07Tt/pFf3n/v/Ka32/i
         kC0WWKP0n9lCskU8r1OCfbKrNJxhk6vb3VKyVUa9xMHiFJPoATMx75O84Vpaw04Uxn53
         4uxBlj/PZW2E544hs7BSuu+tWJn2VXD5yA6lDZ4XL6QWg0G5rOQF28SNpNJ8DzqWloD9
         IJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245902; x=1741850702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIyxZ1JG3rdG0LAbrbn5O/IyfTxj4J52uMpC7PDQlEE=;
        b=XRI/jdqJLWdZ9crsu0YHSl2GKCk5nRtDIoxl95KKx5p6KqDEXoB7mtZTE3hNE6WCzj
         cVoZ+Psa6uHuHn6DJVBRwThLLmkCO3OW5WvfCLAoEeHYEReGFdyirtvbpAU3SAURUuPu
         OBwnU2r6gnp3FM/dubQrvkH1K/OFETd0XYU9Bu5KAcEyKdjkQxzAs/S4w6NwyYfSWlXp
         N9tauiL8Na2sYpIXOOBhO5agdyfjoB5CIvVjRB8qp3w+vApasqWwEN9xpxwCzByxBBu+
         m7ZSbg/kzlZU06JqivIGTl1GoEAGsDbyAreWY0ArGGpwb5D/QmdPTMkL83F6TzFJp9l6
         BXUw==
X-Forwarded-Encrypted: i=1; AJvYcCVGjqMM7T4wDwUQglLympOFHookKc6Uo99z3+xv3EVwRg9hNpIUZ1vdHrIGdsGxF3rXSqwPNF7sZfPPCyegg4s=@vger.kernel.org, AJvYcCWG1KBwozc1DwzMHLiua0Y6tcdkm/wHx6dykhI5MnLTJ0fbwQVokfe40kHKC1+m4/Vbe9gco1eW@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJcqfHikuZKu6pCOy0dgTLKvdx+8CMExeZ146K1RE0BL0+yQ1
	aBHVy98iS/1J0NEEbXXTm59CdWBlnHqJawaLVtL5UqYcyAE+c3RL
X-Gm-Gg: ASbGncsQuXsm/NwnMGLqIMHrg6osYqcf76/vqovWwCzZuFn4MEWOM1JQUfaHHivLqpf
	+sCBZBVXjVqNPsndXkVDTLLFwgf7esRQuvYKvlanM5HIT7Xp4OUPMvM17X/QWJmXSOv4GxIwz8A
	Wx9Cs4OI3VlJOLx0uhDNaoHjuFbXCTJj++Rhltl2INDAVOdbSlPo3t6czfoSKM4IGEyUZ8wfEzi
	CQTP8H+aJmuFMEawGR8Mn4wMtqxMOk00v8GRivpdxLoOrJkOaCIKOPmSddq35TgtaqMgu8JtNzQ
	V+HXBuEVB5sQ4oS0IDCzeLo03I4clYdU3w==
X-Google-Smtp-Source: AGHT+IEysYDu9LietDyDtqKHdzeqcK7Oz8Yw7WfjsNGyqIi7IokeJ/1jQc7td6tewQPny8E9KTQ2zA==
X-Received: by 2002:a17:90a:f94d:b0:2fe:afa7:eaf8 with SMTP id 98e67ed59e1d1-2ff4972725bmr9724313a91.13.1741245902231;
        Wed, 05 Mar 2025 23:25:02 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:25:01 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	ap420073@gmail.com
Subject: [PATCH v2 net 5/6] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
Date: Thu,  6 Mar 2025 07:24:21 +0000
Message-Id: <20250306072422.3303386-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306072422.3303386-1-ap420073@gmail.com>
References: <20250306072422.3303386-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devmem socket is closed, netdev_rx_queue_restart() is called to
reset queue by the net_devmem_unbind_dmabuf(). But callback may return
-ENETDOWN if the interface is down because queues are already freed
when the interface is down so queue reset is not needed.
So, it should not warn if the return value is -ENETDOWN.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Patch added.

 net/core/devmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 3bba3f018df0..0e5a2c672efd 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -109,6 +109,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	int err;
 
 	if (binding->list.next)
 		list_del(&binding->list);
@@ -120,7 +121,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
+		WARN_ON(err && err != -ENETDOWN);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-- 
2.34.1


