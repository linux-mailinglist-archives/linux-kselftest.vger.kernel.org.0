Return-Path: <linux-kselftest+bounces-35260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625DAADE59B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5BD188525A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019327F002;
	Wed, 18 Jun 2025 08:33:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140D280A5E;
	Wed, 18 Jun 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235585; cv=none; b=p1WrKmBIkHpxfWu3rQxci2gAcxvkpNQGGkse+6y1E+zjVLzR6BsxCOpmDbiVRs8euPwlE6F6bxilitxnOWS8+sf8lJRxKFqaD6axQIXVAz4CaW8w1AOTSaL/iTEPVeYQHLGik8nXo3aaDuwHgzwTNaqrU1KSbKAzDnW3hNY6Lpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235585; c=relaxed/simple;
	bh=IxDaiUHf7Z4U8Z5WO/QsWUnQL9pxC4qsiCIvomywaYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKM1lblSMkXCZi1td4NMQCuXMNG7d1RXJaayClOMVztB+f8GLZW98CW+4dwqwEYSzmrNND6hCWcLb3poofnAIr6nZ4RUngZKc+l/XkGCxuqGvwHI8LrTFWv+31FdRtwckv9vLH/Eoo5OO1xXVqqKMzfty44ehDnB6AcPHHroBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade33027bcfso1091495066b.1;
        Wed, 18 Jun 2025 01:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235581; x=1750840381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDofrZxQJK7TRalX2xX6XRULh/jbQyPTf/PiTffP/g4=;
        b=rW+YIRO88R3qVpyr4deWyC34Ew1bwhxG1Sd8SWTmEMGC1noKdnDZWGCAbouFfjQ7S1
         uatDvaSgPR+0BrYJjFL50gnHT69nR4w2JCuYnvBw4+eH32FKeJgacTBc1boUo4LPgxad
         qIba3RA43nWp51LinHvKcBdghHhR0VQ0htRnfIAOBMUl80IlKvvV5cGvOoHRBhr+unO3
         JUeydSw9RjxoS4TZ9m3COpUjsYj4PByPTdxWQP3L7/mmX+eWv7Ikdh5X9VWVduX4ugVA
         kKX9AtL2901hVLUn3JUXwjvC0jNKS96LJ1aS+3gKMme0ade0rmAcUh13+KH5PP/qZu9Y
         j24w==
X-Forwarded-Encrypted: i=1; AJvYcCXOqGO48mXMyI8YH04SOuXVgMDmxmqj5gyG5OPa4xMaTZ0L6lDRgW2jJ1Xceob4PcQ9BLUdhttgtodaGdo=@vger.kernel.org, AJvYcCXkeleujUefoUEVlgcKOSJsglgdclr1ljmt3Hda6sl5Sd8X2CBYUFcwQiXkiL6oZDiY+IADtPs9XzKimB/T+1Wj@vger.kernel.org
X-Gm-Message-State: AOJu0YyK87An8+LHHy0bI8Ke/+KJgWHU1EmlngWm7Lqw93TZEyYhSdYS
	cgGaASAXEQsuV08WUXeV6HtjUUOGKXEbCCCQ+7PLFE3vwsNH1UBaqLIS
X-Gm-Gg: ASbGncsZ719vztFCXzhpXmRAJIJD97RPcFVwwrOOvYb6rbhve+7Zp8Uwh+liM3MJNbH
	DipbA32eAUyRNDEF/OlNDq8CE2C/OtcY8XWFi5ZnMW4iJ3cMN8HOQirAvYUHZQL8N0soUOH84La
	tpGgK/c2Wn0+BwF02PwMbDvYMUeYFop96hFlv/n0X1S4tlqFXO+Kv8ajj2r43S2nLZ+4avjB1pF
	9WOWLR3KdhE9/+BxSeMRYzHjGLSiy6O0tcxLgIeQ2pAUADtD0AGZo7W/O9d5ZBbKswHNDef9psg
	UKwabI5HpYCVBDVssqJUTRFVJhTasZ/sWKD1HU1KClinUJjkOaah
X-Google-Smtp-Source: AGHT+IGpDAiL+bPgtttXdIS4xC1X7eTKg8ENkBlTt5BVg38XjKc2Mnk+aapAFu5GWm49xnmgY2dIVA==
X-Received: by 2002:a17:906:9f91:b0:ad5:840c:dda7 with SMTP id a640c23a62f3a-adfad331583mr1444026266b.21.1750235581122;
        Wed, 18 Jun 2025 01:33:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c5be2sm1008087466b.64.2025.06.18.01.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:33:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 01:32:45 -0700
Subject: [PATCH net-next v4 4/4] netdevsim: account dropped packet length
 in stats on queue free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netdevsim_stat-v4-4-19fe0d35e28e@debian.org>
References: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
In-Reply-To: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=leitao@debian.org;
 h=from:subject:message-id; bh=IxDaiUHf7Z4U8Z5WO/QsWUnQL9pxC4qsiCIvomywaYY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUnm1xoD7CfA8U+5RhDI/AQvcPoqPt6/kNi/vi
 OeGn2HZG+qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFJ5tQAKCRA1o5Of/Hh3
 bUhMD/9mE93RrHPUHWx7lQIfw8olDDA7viOhnT9ubI/vy1hli7uFVHUpyc8lWPjcEui7GLYfBnC
 kt03b8v7ei2ngYIwwYHnHr5tEDuQIFLzJXs/OvcA/TTd8F8TnIN36rhpqk1mhcO92wKwwVkL2fG
 O+8cB1DviPBz1MXOsTCyb9mSpqv02ApUUGOvPv1x4f6/q+QwKUNEC1yuF0EjILu7Gn20Z7/a0k4
 03Af1PImKdM1kR4NUfWXxBYcTBohGH7ilyaAMC0ZiG6f4/KAbXT2AljQZhscJbZpWw4ITx2r46K
 c32Pfumiwp55F6jetZT2fL+8MZxwiS3+4Gv//DtwfqBsIUeQgumFGKhQSX+p8vVrKftifeS2Dro
 h56BmFJAM9i7nEmKtMpR1/OWegrko78XdCsss/9rHZtGMHFqMx9t0Zuu7ByODrX4AtI+hqx1Y4r
 LFTZwlB6MucI7y37nyBwG63VQW0JnKg/UGjcRRkRW6GUVsooM37l96ewKsBLbOfL5h/xTIVjMV5
 mHDPhLpylLpLKuG1B7u0usRSPzXKmr4FyFBdeIDVAGLiJ/KYLTCPLE5pIOL8rkswVaps8Z4JBVw
 Lh16dtj172ac7q/CpwNf93e7FiuQUayuxiAATGyIINVGsnpZV7RaAxZpM5mj9S3Dtwz/CzLQ+//
 zh05boud7Pz8qDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a call to dev_dstats_rx_dropped_add() in nsim_queue_free() to
account for the number of packets dropped when purging the skb queue.
This improves the accuracy of RX drop statistics reported by netdevsim.

local_bh_{disable, enable}() protection is used to disable preemption,
which is necessary given that dev_dstats_rx_dropped_add() access
this_cpu_ptr(). See discussion in [1].

Link: https://lore.kernel.org/all/20250617055934.3fd9d322@kernel.org/ [1]
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index de309ff69e43e..07171cf8b07ee 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -632,9 +632,12 @@ static struct nsim_rq *nsim_queue_alloc(void)
 	return rq;
 }
 
-static void nsim_queue_free(struct nsim_rq *rq)
+static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
 {
 	hrtimer_cancel(&rq->napi_timer);
+	local_bh_disable();
+	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
+	local_bh_enable();
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
@@ -681,7 +684,7 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 	return 0;
 
 err_free:
-	nsim_queue_free(qmem->rq);
+	nsim_queue_free(dev, qmem->rq);
 	return err;
 }
 
@@ -695,7 +698,7 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 		if (!ns->rq_reset_mode)
 			netif_napi_del_locked(&qmem->rq->napi);
 		page_pool_destroy(qmem->rq->page_pool);
-		nsim_queue_free(qmem->rq);
+		nsim_queue_free(dev, qmem->rq);
 	}
 }
 
@@ -913,7 +916,7 @@ static void nsim_queue_uninit(struct netdevsim *ns)
 	int i;
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		nsim_queue_free(ns->rq[i]);
+		nsim_queue_free(dev, ns->rq[i]);
 
 	kfree(ns->rq);
 	ns->rq = NULL;

-- 
2.47.1


