Return-Path: <linux-kselftest+bounces-46771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A3C95681
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415F63A2AD3
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD72FFFA9;
	Sun, 30 Nov 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7UypCOO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67EF2FF65E
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545739; cv=none; b=JfVzADEnV6DNgEvQvPfjExK3UpBcgwFnhe73D8YjyhxBDDLI2AJzrk40dSUO4LtA7AFBTiKGsGHuWtX55PTjHe1TJoU48TWssCZfkk6oXMSb0Z4L2zdxnmdUJc0ZoZU3qw/TB5dmSthBKj4ME7YH3tHQrUpt2wesm2XI2e6JCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545739; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkIQhqJh43x4G4a5lhDQvxXW7vn6miXRCIFdgs8K4zQ3Ikhn033epdw7tB9ycPIsFjdk/lj05d2Fi+WRPy74Mc33atMCDAnIKjB+kOaS7xXnTBLNnxenKvFQuiEXxUUeg4LPydeS03K5kRXjg/ZWOCcnbedAkVLtSboD/YM+EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7UypCOO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47789cd2083so18976705e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 15:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545736; x=1765150536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=D7UypCOOix839eTbKC/dmhlH6EbPRl2Q9K5FTyuaos0ra5SfgnRH67yxhdXonRzNE1
         JLm/05xwKtxykCoPmzkttHKzOmVki1Jk1KIITlrwiebCDzkATqj3aa0lBfnszDQIwT8i
         ct5CkJNOqMBUydrm89AS2BFiomYcBjCX2G3YsZ3MSuE3aq/ps+ZtYJQxcjULM/Z81xPm
         hqjkAzibMOr0aVfM9a0KkPmay+GuLD7jQddO38eBauV6wOpy2qkK/5B9RIqXSr/PB6RZ
         W0IjlPfXngCtYQbDJzdtD1CA18rqtwJrrgmy1LKiYd9iwF0gqqaZhlRZv5MoKAlOlV0a
         F4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545736; x=1765150536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=RtLOEGo8UWaHVISS2AaVXQZtqV4sVjIbFZOSK9fwztqJLqBeA6/wbHpOiAirzjVDVP
         jomHwXsA8j0E2FTCDyt3kw7UftIWqgH/z0hrKv2LEkEPnorwZWcmRClbWAnjV5sl6RoC
         Tr2WcH7bBTBYMbW2ERTAUggnZT82ilivCJjH2bOFqOIjunotP2xZIil3MjEDDK/tSx/Q
         q/K8FYcUaBqr0Dh0HgOASalVpTCbS+mduT2ZNAUbJEkKuJNRM42UW+9hAesoNa+zs/SL
         R3XNNz62AwVs3BjrHPv1wdpK6F75AruJm5bGqoY16P5d6Xcww/m7Yc1KikvhUYjk6B4A
         3v4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGOMZLrXv0vcrXfxuPe6WNP9sghiwxNSIwlNftJrtVymhIZHPShNoCCP2AUA/UBrgaSkWHZcbxlBD1DTyA38A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn1ItbUcIswpfo5to8NHZK2fILyngTlNI80WzLT9GuqclAGYJ
	iFBIFJMOfwIMgEmw6QIYROjYQF2yHxNzEXfcLUCqz43RaN7Rcb/A9xwG
X-Gm-Gg: ASbGncvx0dlEKvild9WLgfjQt7hcqYx3bYy3NRKJ5wSfXsb1nNzsl3SiVupP8V2UB0T
	3vCoieFPBAff2NMgD913i9qEeOEs6wSCuX5nf6zWXs2QxGtsa2LWl8JyXb31rXWNPZJmJFJepib
	ynh77ZHG0zv8Rs+D5kBkzIgp4p7NPGW0/f7nP6RALJCMrm+yF6crKcwioefVdjdIDhQgHZ26kfV
	lOy5FbXQodBn0O+qr+GVz/PueEPlyOfTQ5jDxP2094Cz+WFnGuodwzMonTbPw5DIUF2hEkPawV1
	eDMBZQB7spV4xG3sRijivmmD2FTBKetzlRy3sPWW+aBJLck1OklVBKsMl+Q/U0KuMA+4K+HU0We
	VBGQXwuyXOgmCNKPNQmNvs2E8qaeB/TfD2PyjhBrnykrkqh2DiR4TNHPKnpJw+5qundEKNSNe3s
	l8Oiw+3HlrOEygAOXh7e7PiMDalaG7P+upJqMLTvq7hZhDHHj177uICjJ3PJWm/W4RfuC+Yiqp4
	Egb/h2G5Y+5agZZtFEELaq8N/4=
X-Google-Smtp-Source: AGHT+IHISYLGMcAbCVZNiKeY1dtZPkbvCAz/q8vqp6c82/yUdHZQKIhPMrYnHbV51FKqG4IwK4u77g==
X-Received: by 2002:a05:600c:5252:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-477c110328amr358728235e9.4.1764545736071;
        Sun, 30 Nov 2025 15:35:36 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:35 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 3/9] net: memzero mp params when closing a queue
Date: Sun, 30 Nov 2025 23:35:18 +0000
Message-ID: <374b055a2119076d43336008817248854774668e.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
References: <cover.1764542851.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.52.0


