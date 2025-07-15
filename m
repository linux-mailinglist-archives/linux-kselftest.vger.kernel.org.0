Return-Path: <linux-kselftest+bounces-37383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A467B06846
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FA13B5746
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F002BF005;
	Tue, 15 Jul 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyqIx2Bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488F2BEFEF;
	Tue, 15 Jul 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613565; cv=none; b=POn/YS2YF89+Aky3gpK+yMTqQso+DGIa/FYn52K3EscPoaYdzygLZq9OUA4ajNYMjhkY6ZF9cJl91Bl4e2XSqBKYAIrSiBML64zCCzc9+ur6/WoNfWhbL9HKYwJkSvgv729vT75AmwW2zDmknAXiZU3zHCH/Rj9XNM+GRClbd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613565; c=relaxed/simple;
	bh=SIFkul1CcqDCKoC4+wlXOTU2x+nnGJ/CaZjoDH55Trg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gno7YAAqn+Rty89WS/KZ3l/5Yvv6aSo7kOfL0NrMhvU0sQV1Bnj1991pJIsdBPlRXn9xQg/obuNK/Gi9/HmWirYhzwQgq4jjiyaFXNI97DbMy9lg792nw2Iflx/TJsj2ZL9kzs1uVvprwXZHB/mCz2L0iG92626YmefmMe1rAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyqIx2Bb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso61770035e9.3;
        Tue, 15 Jul 2025 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752613562; x=1753218362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6qJVedwXtW2wu0HYlGLibAipqbdIItFX4qAyGg2GFk=;
        b=TyqIx2BbA6D3rE8Q4CfxFyPLy0UwZ4gy7x1ZS+EZAuCWOERlHuQE28NXCfGlDmdKNZ
         +Yjfos4vhhXuvqntrcv3j4/xS96ZCDbyeqEtXdAzP8jkBP4kAu6gvBUKBKcbrnRX6hRf
         HG8MoXHKY/HABwxJudh0G8nRi5lhlI925f9pQAmaxwqp9xWpT6SV/kkn3gP/ycIct21l
         g9eOIB2aQAGvzM7JK6VdnGzw2fmYE6O8iNjbMhQ4lO9J0Wszf3VCQrfpNsB/Lewd/2Xm
         LLWfZqX1nyrQbYfWrvIFpa2gisvhYQBeIRjKCVNJdMc5HJN0TKBUB0EdUHMzxc7IhkZx
         F5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613562; x=1753218362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6qJVedwXtW2wu0HYlGLibAipqbdIItFX4qAyGg2GFk=;
        b=uhIZht0DpN95udRv4MSMKqDQrbGG8m6FYRSzuFo+4LaDcLXHlCBOcJK8Xbdh0cCihM
         DYwSMwVVS08XmLG6gEKXvPb9QpFOZpWo8/sCiEvKprieNTT5no4h4QAyT0HXoU3qlb2m
         /T6XPS5AGBgyTMtA/LWZQOUp7RgmNsDsqVAFhwtfilmkDH2nz2ctzPVpYEMwaoKQazuG
         5T6Y/pHWzp1eSsV1L5LCnVNcM6NM9RhcwfobQHjx44vuxps7MygGV2jzxmGwFMDQJJPy
         +GOwO9FPzCkUdsiXBJkWvOKJeGVY7zJipioOzFgbp2d6e6eGtfyhdefk4vKDsF4hnZn3
         Xudw==
X-Forwarded-Encrypted: i=1; AJvYcCU2lxppeJ28AwIOfW979BHthnqd/1HlN/8rVK3Y1qly+nIYFnJWQDBEFnTu1jb2AyNr78o=@vger.kernel.org, AJvYcCVDTJFYiXfkCqMudZhG4QZ9zzdYL3p2/a8OOG2vLA9yBfkd+n5H4L7RZgwOvlFIz6Ds1KEFlmHjf9iAKN0v18lH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqr3q9V3cuDwbw955YmvwbFyq8Y4ST1HEDeC5ELH+7K5t5v7j9
	EK48enYsZF8XV5AHJdp+Rb2pQIGoQPtAxqXDI+llWbszkbBzan35dvABsGz+sC+T
X-Gm-Gg: ASbGncvC9X6UIftqpjCKGHbQA6AXqjkwkb0TCAS5tcInufOwnp6z8wCIPIBCtJ8VGmR
	cmngGd3VAs9XoxMdUcBSQRYJxLAj/LceLAreqTKIKPLiOjJRI1sPoVypR9swRfTl/YRqC07uTcf
	WCDnoExkNTNCx7WuxElp8/PKBsX18V5LNo58TXHITudUJBK8rFaVDSn8HOfstX+wsLaIccToatF
	YJyZY/cmpib+SGsw2lh5fYU9nfz7UiDepWw8F14wGx9vsx2UEs3wimNffuWHZNaxSrKbOALxYAb
	6+NwwIUKvMNWPAn6dQU2tVvusMhQKZqV0clRmayNoIVA+hZMtSNKQ4ZZgrcQfyYIhQpAAw2n6nA
	atdSAbHnCZBuDAuNiUqlw
X-Google-Smtp-Source: AGHT+IEll29/F9GryhP3KmfLKP+1l4l1058+oo0OnQbnYL/CHjrIr8MPnZjhCifce1hz0eFWSDDV8Q==
X-Received: by 2002:a05:600c:1d03:b0:456:18d4:5f7b with SMTP id 5b1f17b1804b1-4562e044fc5mr3644415e9.9.1752613561561;
        Tue, 15 Jul 2025 14:06:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8026e4sm1237105e9.11.2025.07.15.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:06:00 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next V5 1/5] net: netdevsim: hook in XDP handling
Date: Tue, 15 Jul 2025 14:05:49 -0700
Message-ID: <20250715210553.1568963-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
References: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
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
index 611e7f65291c..ba637bd0971a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -387,15 +387,32 @@ static int nsim_get_iflink(const struct net_device *dev)
 static int nsim_rcv(struct nsim_rq *rq, int budget)
 {
 	struct net_device *dev = rq->napi.dev;
+	struct bpf_prog *xdp_prog;
+	struct netdevsim *ns;
 	struct sk_buff *skb;
 	unsigned int skblen;
 	int i, ret;
 
+	ns = netdev_priv(dev);
+	xdp_prog = READ_ONCE(ns->xdp.prog);
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
@@ -936,7 +953,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_TSO;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
-	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
 }
 
 static int nsim_queue_init(struct netdevsim *ns)
-- 
2.47.1


