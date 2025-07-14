Return-Path: <linux-kselftest+bounces-37284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B4AB0490A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74C9169C56
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC22609D4;
	Mon, 14 Jul 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBiaaEEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D592586EF;
	Mon, 14 Jul 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527059; cv=none; b=T1xP3qNp4/i/FzNn4ikd2Q9qpbwGd1Z1SrSXOTrAKnBceDporb5tOpHusDO+0KIpsxYNbymWsaC34kGT+uXsa6jbmVaVv4JkiPd9t+fcfCqEXmKET8tFI5ipDE3p+AkGtPtPqyuazPVp8HWoGFgRJ8qjDmY0tC3PMVnFg4U2qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527059; c=relaxed/simple;
	bh=wA/E5+JOmOUD6QGm2lQJtFQRXT31mbSkz/JyDNyumnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgdXVLNFRHahuGaSiBkBqaORBid+fahq5XgqxkyrL7j7pvwmSQ7HRDJxb4Ahg3mmiHwuapGsMhXeiqrK4eyFdzdnXHZ+BFeZCx1sQcpSTKgMPWuq4oqbTGOzVxI+IZH23/B8wyBolBA6USFvxuhyGq39dWiGwz49cipAVMjKm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBiaaEEf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d3f72391so47148305e9.3;
        Mon, 14 Jul 2025 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527056; x=1753131856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPvaZZJy6KQO4+hpnGAfzGnnzy/nMfkrJi1aRs1pXjE=;
        b=LBiaaEEfjPcA98B3Th6EW2eX7j5048njHSWZfgsK4EKeoXA/7o6I+i83A+SJ4ZP2lO
         xXQfMNkL8z6l7Fg2D9831SXOiUopfHLSiWXa0UP29rufQk75MWZXftNETLBEKXED/xcc
         R8crRavhwebeXOpfa4st4zx7ldtFvvQ+C8jPJ3hbW1UNq10E5mEqg/jF0HYeFrqoKaRR
         Jl6WI4NXeyTm9tTsAQHL9PNYsRtk83Aa0YE4Mb9WbgJSWsMKYwpXx4u62TtuuWT+hHcJ
         0M8XKOtv93yZDJ1AxkCuFLyBFMokEF9E92tw0wYQ4OJUt6wuqv79m24tsSTIb/f0E0JV
         GZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527056; x=1753131856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPvaZZJy6KQO4+hpnGAfzGnnzy/nMfkrJi1aRs1pXjE=;
        b=AVBVjkh8e7aiOnsP8jTtdZSLbXYMRv2BiPxLA+Z0Mat52H6yK/OqjvGrk6zkApL0+M
         OW0uhkHb7xTwwgSiDsqwjfnoQW7kIn8vq2xSA6MfYhN5eBWa0A/jr4D+bgsKJx2tVBek
         SE0bn4HcI8NnS1Vy1K74qPfvNgZ79jwVxaX2aSwv004nf6QkIBkQWHFuGd2bnzLdJHTK
         UDNLjJRB+bnHKpvT7ObPYQr1gVcl5ZH4mxDtV749IG5VAOIpd9difrzrM3O7TkZJfLyR
         VFmSZJpTvaFBA3nJ4qaavcScFC5X+5HlGbSeTkahlE8jBE7X/t3zYM8ZLaw2mfC8ZGrG
         rgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh17IDNhSBDbxnDteNvYE2QnqgmsMXxodfX1KIanCp5IdWM3ksVIbRM8F+ytULq3zoydQ=@vger.kernel.org, AJvYcCVUgYFUuZNvL1LVsmNz+TDnKtg2M72Qn612/W+6WF/41Zga69kcyE3U4sczV8mrnTeWv9fGoPBkm6LTbUWf2ngz@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWsr3JteqWgyW5FEmTkbbLsbn5JbJH/QkkaoSteBObQkGGbGM
	SmqDz5hkzUqrB+/fQFyN+FNs9lvgqJWP0KIdxo61udRX2nFB2D9SlSSR1hxx+3Me
X-Gm-Gg: ASbGncuiXY03DxXnXqgNVvtpm59G+Db8Z+cD3pwZuAniIsp/32I4eKrc2h1GvvEtC3L
	TUS9TwrSnGKtk+yPsT8yKHzL9FbGPeKiDsvX7IWWQpa6PS+1If9yOf0p4Osibm8Vj6Xou2Bur03
	m656/dzMRSKGcSc8ZvYPpEM8cIDGFD44ckWVnP+znUX4AWY5h1Fi4aUH08yrLDcgJHsoOlMZfeD
	IgrapeiXmvIYLXqvON13Sp/iES5ws8Q95MMDxfyAnA0Zs2D2nPVXoB1JPkRtFmKL4zWa+SgB6qU
	HUubZrzQDhxhhogKU8qMqWazBiIFcVb0prxww9BRdbP0ncYSZXIUTBKLg6HczShk05ya1hFQkGM
	Kh9iQ3imPqCwXVvTXFl4=
X-Google-Smtp-Source: AGHT+IHEZ3LhJZDT17IVQpaXd2iM8w8nvGGTrjRUngW8VoVdJWJUxTOVg+hS6v2DCx6sNcv8IZobYw==
X-Received: by 2002:a05:600c:6387:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-455fffb208fmr86755555e9.5.1752527055768;
        Mon, 14 Jul 2025 14:04:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f8fc5a01sm96112865e9.32.2025.07.14.14.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:04:15 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next V4 1/5] net: netdevsim: hook in XDP handling
Date: Mon, 14 Jul 2025 14:03:48 -0700
Message-ID: <20250714210352.1115230-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
References: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add basic XDP support by hooking in do_xdp_generic().
This should be enough to validate most basic XDP tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index f316e44130f7..ab2cdbf968a7 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -332,15 +332,32 @@ static int nsim_get_iflink(const struct net_device *dev)
 static int nsim_rcv(struct nsim_rq *rq, int budget)
 {
 	struct net_device *dev = rq->napi.dev;
+	struct bpf_prog *xdp_prog;
+	struct netdevsim *ns;
 	struct sk_buff *skb;
 	unsigned int skblen;
 	int i, ret;
 
+	ns = netdev_priv(dev);
+	xdp_prog = rcu_dereference(ns->xdp.prog);
+
 	for (i = 0; i < budget; i++) {
 		if (skb_queue_empty(&rq->skb_queue))
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+
+		if (xdp_prog) {
+			/* skb might be freed directly by XDP, save the len */
+			skblen = skb->len;
+
+			ret = do_xdp_generic(xdp_prog, &skb);
+			if (ret != XDP_PASS) {
+				dev_dstats_rx_add(dev, skblen);
+				continue;
+			}
+		}
+
 		/* skb might be discard at netif_receive_skb, save the len */
 		skblen = skb->len;
 		skb_mark_napi_id(skb, &rq->napi);
@@ -882,7 +899,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_TSO;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
-	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
 }
 
 static int nsim_queue_init(struct netdevsim *ns)
-- 
2.47.1


