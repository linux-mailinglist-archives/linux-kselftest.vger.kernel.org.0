Return-Path: <linux-kselftest+bounces-35191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76CFADC475
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D361888F6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8F293454;
	Tue, 17 Jun 2025 08:19:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47D291157;
	Tue, 17 Jun 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148353; cv=none; b=EEQoXcK7eCptmJm4gySBJEw0bggVc/OvDjncoF5fq6B8xAG81D8nJJr/S4StEa+UjrGh4MCjsuSJ3UXkufzQS2WR4nx1dkj8gQ5r8VmdxGsBVlT6+84IU425E5Lz65/jREECSO8ovhFS1SvV29kqWyei5xrEzHmoqO1+Ge4p+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148353; c=relaxed/simple;
	bh=7bTE/G7XUwA/kVf5XxBEU/9ZUs5UqQAeJdICImaJLPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StV7Xe1y1jbc1+ILfwABYJJsLd6Nb+hIVVaiIkgfLdusev+gOVlmZCVyYpIpiOrxZNmPqDN8J0hTAO/+r5qu63J1eq/UbSuzTUwdbM+ltyP880Mip46qWoF3up3fbB1GsvUsQShsj44tCc4NXI+2wg/mEXGfDVYPeC10lLest2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89333d603so1003322066b.2;
        Tue, 17 Jun 2025 01:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148350; x=1750753150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeajAKYpoows+g4P7650D8aOy+Pi3G5qwSfEQ3Y1fI8=;
        b=SRCoAnEBzTx2pfVRqjmRlmJLz2WS/nCkgdSe484TGg3SaHIvkuCVQKmV0ey2K499bG
         6bMGxd07mBPXIqS9jK3/QPAfCfOMRT23HMu3nz6lI30E1AtKwdgIqjFJIUsTkOaWgWJp
         W4ebGJMTK26Fwzncq8EEG+DopGyClN2HB1M38kkuKXHYN5oVXcBl7JYt74lIqcM2eTMP
         UdytsGXGoVKx9YlQrp1VSu38N0sNiJSOyPTk6R8wgxs5Hd62I9iVfUgfpnMKg7HOTJZ0
         2Lz2+5DtDtuMVaUIgJOQKUgLrE+pP0vmqbJuH5n7yir5qLHsIC9cbXrlCY+hDPFmNpKR
         tizQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE7qKSSmRJQ5JzbaCGHfihrx5by+eKqyZkUYULC5nvUDhB+NjoShPX84bhLb4hNFoXFmxhIN9vnAwHORNCL0Yr@vger.kernel.org, AJvYcCXbFBIcsp+XglSO/1BeS+XcmSzgnr4at3K8Qo/9AgJlQq8AwgfxsPF0qigjyQeHkBdugL0Djt2mEp6Ut1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUNkOl3HR2ER/VzWAxVR9TxNYgkYVQGfQosm/Q0KgaL4tDtk1
	joqp+84/gWp033MCVEHwhI6EWnwSVgQet1rW4dNeQTN0+gyyBv9ArzLu
X-Gm-Gg: ASbGncviqmguTB/zCfKCNZ9AYrd5Tnl57pPfKyT5t/1MvqETixhvRMJoCa5Iv+FBV4F
	ukVlxSHH+pCYKVWOUsUvzXi8wSlCigXpezgk1Jjr/POkXS7WJrzY9i00uHHDikbUj2s0aR9b9sw
	Q34aiTKofcdO3mt5LS0MoVrPQFaJq8jnQNdDu64hVTWZysJ4NEgG3QCYm1ZgK2QtS+HdEtOg+MW
	tzY0tgqjMpSfmJzpP4lBuMHqGSWXaxQA8BApMWzWn5mEwyzux4r81EHp8RElJKhs8OpwwfwaeeM
	q9hsYFVNP1aygKakb6aEzKAo26meJ9eBQJAnHqMrgLpZrRgFdl6/
X-Google-Smtp-Source: AGHT+IF0mLEPQrvM663gaZ8FaaBbSS2col1J40tAb3DaS7Lz7DmEBxKbo3aAuqpplB49aCZ4TGoybA==
X-Received: by 2002:a17:906:c105:b0:ad8:8529:4f7e with SMTP id a640c23a62f3a-adfad5d023amr1097081566b.53.1750148350038;
        Tue, 17 Jun 2025 01:19:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60992edde8dsm513899a12.23.2025.06.17.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:19:09 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 17 Jun 2025 01:19:00 -0700
Subject: [PATCH net-next v3 4/4] netdevsim: account dropped packet length
 in stats on queue free
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-netdevsim_stat-v3-4-afe4bdcbf237@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=leitao@debian.org;
 h=from:subject:message-id; bh=7bTE/G7XUwA/kVf5XxBEU/9ZUs5UqQAeJdICImaJLPY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUST3PrLTzP3psEvjdg5T0ylUHZIFtN2Bjmecu
 KNlL35baYeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFEk9wAKCRA1o5Of/Hh3
 bQVID/4hMQtm+luiiBqD6qkSR92UwcTtZYmySSKba4eQkLE996vNi8E9ow1WBxfuDFDyCYiLIhP
 h6Y2wpJsHZQ45G3dES+u44D+hdA6olGC58Pb4I9bWxoXh3Ak9Altws4x2XWctOtUjrQpp/unVUT
 CJLsAfDqM7j7TqNezss79EA/N+jOdFzHzb/aKO/obA/T4ahT0YfBcpohxTVGqofZahZyGq1rzEw
 37wbHhgriYSBNLyjmDTl5XHCDvojfbVek0Or8YS92Oy2khnxAUf0ITukyIKh6LN3OexInOyb9iN
 AX04d6yCOwdDLpzUVTxENzUl90YKPbptpdIIJKtSm9Hd21dDYlJ3UwEZtdNGCjEFLuz18YC5A3O
 61WH/3HDsjIG4uYoCwitO7ISbuu5ZBAHopEMDLeWjgqmC+HxwHcLGIStDMdJn7Wd7plZFR9tnfS
 ympRhYXcYAFvQCzk/Q72JHhuRqHnEP75QABkNVrYNbIuBgr9nOp0iRrXtjiLs3byzv3w/+l27CD
 vlaywv/AmOWZeMEFfgh7qfLVyN71ObNJdN9eg8cPH4JmR24kZo6HTHnK93gKvH+BOU/MlrQa8ha
 qioUx0mOSfbqy3Lrv8T3/4an0eGLVAYvysA2aVCc/YOG3rch82SwTGQoaXgv+kRlM47lhTMyQvW
 lVb77YIC0jGJbkw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a call to dev_dstats_rx_dropped_add() in nsim_queue_free() to
account for the number of packets dropped when purging the skb queue.

This improves the accuracy of RX drop statistics reported by
netdevsim.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index de309ff69e43e..5d0b801e81129 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -632,9 +632,10 @@ static struct nsim_rq *nsim_queue_alloc(void)
 	return rq;
 }
 
-static void nsim_queue_free(struct nsim_rq *rq)
+static void nsim_queue_free(struct net_device *dev, struct nsim_rq *rq)
 {
 	hrtimer_cancel(&rq->napi_timer);
+	dev_dstats_rx_dropped_add(dev, rq->skb_queue.qlen);
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
@@ -681,7 +682,7 @@ nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
 	return 0;
 
 err_free:
-	nsim_queue_free(qmem->rq);
+	nsim_queue_free(dev, qmem->rq);
 	return err;
 }
 
@@ -695,7 +696,7 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 		if (!ns->rq_reset_mode)
 			netif_napi_del_locked(&qmem->rq->napi);
 		page_pool_destroy(qmem->rq->page_pool);
-		nsim_queue_free(qmem->rq);
+		nsim_queue_free(dev, qmem->rq);
 	}
 }
 
@@ -913,7 +914,7 @@ static void nsim_queue_uninit(struct netdevsim *ns)
 	int i;
 
 	for (i = 0; i < dev->num_rx_queues; i++)
-		nsim_queue_free(ns->rq[i]);
+		nsim_queue_free(dev, ns->rq[i]);
 
 	kfree(ns->rq);
 	ns->rq = NULL;

-- 
2.47.1


