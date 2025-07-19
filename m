Return-Path: <linux-kselftest+bounces-37615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43230B0AEB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 10:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440601C21DBF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA72367D7;
	Sat, 19 Jul 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ1mxjGe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B3235C01;
	Sat, 19 Jul 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913889; cv=none; b=WXgy7WQgNIXH2mVdbJXua7sNR1aB5Okn11bmNlaumKuHS0RAsOjqF5NfLt3duIoWrzkuoP6NnyBdmp0F25ckL/3hl03lHUfVyPr+RDEeExlce7Bty9US7eMfk3x1+YqZ12M20BgaVFeiKdYe0jjsV/EG7BgKxWL/33meaaY0qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913889; c=relaxed/simple;
	bh=tkJPSIi59XHN9fF/q4MByoCVzmykKuP7k9Ib+L/auVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nje9vDTNFeYh/c7mI2yNsKBjbqATDlwOpdwuH0Rq23AvqAZ1yuKrWFKGHYdjHsLB24/cUCIAyAqlflho86n6MLUqme6R0SDsHh1qQQUF2ag5NEvZIDgjiDITE/g/hC3l+Tp2sNv9F9iCbR0tf6wQmejiHf8jV07Z5Q9YBGaYP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ1mxjGe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45555e3317aso17105765e9.3;
        Sat, 19 Jul 2025 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752913886; x=1753518686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDcGeiGNqBeCksEvhHpD9Yw5aiU56UCUr558cU8kIhI=;
        b=PQ1mxjGe72G3h4wbvzFLFKQ9QtfG4vZaGoatXp1LjR+aiGPa/COnEAgc2nSbUZ3os4
         p7/g06nmnuIw4poJKd4bxX+WOwDy6Ik6zGl9x55q1T7hxz0meQttZB+f9CTEiJfzOHsg
         BgVfCt+ybf6oiNttA5vcYhXJHIXqrAue38L6jDss+m981Nx2jBKrT1iKLA49O6bkYNxw
         KXvDO2F0GCp+ndc+CP1fBiAJPXJlnEBHlmXtOkg/zBq6tiz0/qtSakt4BZx3Gbsq43uU
         QH679KyLEIX486774Oz6MpcmsyMFU50vDHVAqxcINDPFAPFHTdFbE5y+eubtSglgXQAE
         /AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752913886; x=1753518686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDcGeiGNqBeCksEvhHpD9Yw5aiU56UCUr558cU8kIhI=;
        b=VccXisUGc9JeahivoSx0/z8N1u0+V+CFJIm4ZYxcFDkUOzmwaNW92xHnMnRwKXyHLf
         oq1NLvDxWCtEQu2sTWuyO9C03NxDkAA0uTgCEu4YgbWsem/K6gWsjOjbp5CcT4pJlXLi
         oAZ1xJ7Gmrs5B0oKxpouFFhvAvmFpfkYHBOyBewi0tm/Mh7gDKx4YCfwd/36BkrjCyPq
         2uXJJcquLpuppbbJx4VemdG1iUMBf14H8u807mamgDuP2UcLgdW6hW6CqUoMEhY8FuQD
         0ci/kNPB7Odsmu3Ub+TO1UIyOyZTHBMi1QELnqC5nINLZ7xK1cyFziPAOP2tJXGgbeLy
         azMA==
X-Forwarded-Encrypted: i=1; AJvYcCUmZLYhVGNo+ri7WrcXHIRBLMg+292ZdBFwEjLiZrNJtaaMJFcrpR9rgE9zdLAzWYcFHAoEBtPrb/xxSy6Q7B88@vger.kernel.org, AJvYcCXquNhrBG8P3S8t9c7KbIfxgH0MIL47LNXRNK8MVVBGxz6Eu30IA/uUdq0dOz3dhTpkFFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaz8tfz1K04JI+wcIn5Gis7UFJmEGgMXfQIznNVYF1mSeg65it
	F3yXhmCee15SJPnwZHxCRXnBXUKc9bu/90zjH+jwGBwQZSktDSUrO7MyVd++fJ6U
X-Gm-Gg: ASbGncu3vd1Tf2cBYZf+UlMNkpo8qlBXJt+CoR+2+HpEi8PblnjnAOZ5W2+iw6s0Ixi
	4iDhMe5WxbNEsGIJJ9eJ4ijIwGCbwd4/YPud5AurDM9+esTmKSvPRUJncqOjKQVwCh8R4+ybbFh
	07xCynmWaldQHSFpEK7uvhSGscWcIWFG1kIC8UCYqWF10ZDNUmjfrnrJPpfgsnC3M373e59WbpU
	He8u/eO5CJbQlAI9d4HGzCtiZXAzZ3TFGLR9AnBTY+mC6h6mhSlOoZGHzZOD4MJ1tNpKpcYqP48
	UQM8ctPSYL8VtFXKE/JHUcBVHYUd1mzQbCk4Pz9vhREzBQuD7IPEaNmT0GtDqs/9YKMi3JuBUSd
	ucmE6n4UnNYoKzLWqcqo=
X-Google-Smtp-Source: AGHT+IFkNet5uHb3/c8lWyYxDXjpEWHstlNMS2AHrN4Vc1bp9rHxD673u6W8OpqkiwvNZniTA6tRGQ==
X-Received: by 2002:a05:600c:3488:b0:456:f00:4b5d with SMTP id 5b1f17b1804b1-4563a1f42c0mr57061125e9.22.1752913885695;
        Sat, 19 Jul 2025 01:31:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca254e7sm4146417f8f.4.2025.07.19.01.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:31:25 -0700 (PDT)
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
Subject: [PATCH net-next V6 1/5] net: netdevsim: hook in XDP handling
Date: Sat, 19 Jul 2025 01:30:55 -0700
Message-ID: <20250719083059.3209169-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
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
 drivers/net/netdevsim/netdev.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 611e7f65291c..a7628f5c09af 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -387,15 +387,34 @@ static int nsim_get_iflink(const struct net_device *dev)
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
+			if (skb->ip_summed == CHECKSUM_PARTIAL)
+				skb_checksum_help(skb);
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
@@ -936,7 +955,7 @@ static void nsim_setup(struct net_device *dev)
 			    NETIF_F_TSO;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
-	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
 }
 
 static int nsim_queue_init(struct netdevsim *ns)
-- 
2.47.1


