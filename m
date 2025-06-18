Return-Path: <linux-kselftest+bounces-35259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEEADE599
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B53BBB96
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159A280CFA;
	Wed, 18 Jun 2025 08:33:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C727FD5A;
	Wed, 18 Jun 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235583; cv=none; b=srkTMDV6oJL92c/4xqMvUnIZRvZt5cWNO28QjSh/nbydgx2obfdxwNI4wkfzPm0s336YtiP029zGmehTJKbiP14cYzTLEOfzLO3NM5Kl59SD3sj2kM4y0QqD+8F5EQGNCY6aUaTJVUYidvwow5PwBCu6/56EirI/3o1TzILh9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235583; c=relaxed/simple;
	bh=pun+ai7i9KoSJwqGh21Y7Vt3za1e9TA2aXklqAhyP90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+kC/vX5kwl3dPKfsZAoduloMjxVKMd4+rxMBsmz5zct3kBtK0SnXIncKxod6f7kSKS9ojATMen0iG/XvAcOZWRZob7duZOfelpO82l+fULHz8Pj+1bVa3yCAFqshCW9P7XsXSn2TzWyPUCkjmmhFGfZgsFHMlB6oLMhRbcp+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad883afdf0cso1301336266b.0;
        Wed, 18 Jun 2025 01:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235580; x=1750840380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvxHENa/I/iZADWNuu1fWoBxTp31OAQX5sQQgeuscxo=;
        b=KsaIYXmaMjsFzabScEhO69doE/iICY5wSetiqBokeeQZ/vtrrlg9vCSVmlDJlWEBOz
         UKbUc5UVEKdekYV6+Wu80A+ljzDQ44OxSgPqmjU45G0ITTdZCZzSPNNNusHqPbAvJYlC
         WyoTdFQ14KfCLeV8LoxluiM5ePwsak/jORXqN5MWWa+P4xDmVZz7Dq2/ixVEz4iPpyfM
         oOBqT8PNqmrlYRZfyjTKEjFHu6XI7pm1vMptwuekSJNfJmAT/IaJaa1gzLl1ghmXjjUs
         nVc4vzHDEW0AwfJcdme11qN4AIF7hMAMTek3hQxW2kAg5Vc031u17T13VDfOb6rVHAJe
         I60Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9WUCT0eENHV4NRPwumSEonPrHiJRwc0iidwvY3XRQa+IlfqX5bKmKjzVucaRdLy+qJeYM4b/n09ynkf8=@vger.kernel.org, AJvYcCXQQX60Nry3mEZmfOxQT1FMDjLBT5LDQiwKMtL0Cyt1hK/tcyshqm1Tx7RlXgRLQaaIDxhzD3oxTR4B4POUhEuc@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzxvKOqdXnBNd64tCYjWtAbccUPxOAgihSMGkjrmnNqfsnTC4
	yfxvOu9SIpOSTTDsUYwL81QajMrcDLiASEwQuRE1NxPqljMWqIpRTlZ7jR8kBQ==
X-Gm-Gg: ASbGncuMFBRDXQ56JJvfcOClfsV6g+W/QZoyz788zSusPhfTh+mKTQtwuuU4SwRwZtU
	wXM676y3f6FWCQ/5PFLdG3GpB23wLs4FSsCh9ROi7N9kP14kFb9C9aLBjP9FljhRMATDhR3eUO8
	6schj4ay/I5T56q3zycJxAw3mC3rMzM260OLClZGngUsSjNHdCZ6Bl11rRmTpg8YOfyhkRQEhug
	RKb9LAEpik4HM2FuEBknH0AjVd8947QRaLg9ehM0Up9vVC2g+i4KQMQMRLyz36/+I14lG/wNU1O
	rkOrAvYc8Xt5jgMda/lc3wwIizfnV2RlbgFcpmjiMyt1a0NpHWFa
X-Google-Smtp-Source: AGHT+IEOLy3dKbnVwV5DkJBjEBfns4jt3+wb82Urf/sw5HVMmm7KmqELH2iM50rsdibQrqj0CwsYug==
X-Received: by 2002:a17:907:7ba0:b0:ad8:9ff4:c02f with SMTP id a640c23a62f3a-adfad35906dmr1721122566b.19.1750235579671;
        Wed, 18 Jun 2025 01:32:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892b024sm1000863366b.130.2025.06.18.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:32:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 01:32:44 -0700
Subject: [PATCH net-next v4 3/4] net: add dev_dstats_rx_dropped_add()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netdevsim_stat-v4-3-19fe0d35e28e@debian.org>
References: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
In-Reply-To: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com, Joe Damato <joe@dama.to>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=leitao@debian.org;
 h=from:subject:message-id; bh=pun+ai7i9KoSJwqGh21Y7Vt3za1e9TA2aXklqAhyP90=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUnm1mwbJrwv0YDwYDDNXccLkbOic+BzOVdpdn
 WMtG5PmJCOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFJ5tQAKCRA1o5Of/Hh3
 beAJEACvhn0olRdl4m8biKIukOMbdjGI/RjV2lIT17X1e2VOxAlVLUVdpVmSgwswF4kb1BmlqZM
 EAHJ4/JlsRdikQkZbAbZoHA4RsVR1revLnqgNDmo8eKI9okA19uH0KWW9Ln+QdURnkbdAVH1Acb
 g2f+oaDq/d1SCJysg6UrHM2wzezFDKVUUrh6UkjXZQIYAlZWvNYjNkeEzmGYzLQSbvfGmh3xtH6
 3H5+kkcbLus8lLcCw/q65OU53+rMTYJ6kesvmDwyhYOChkThE+5W6dtcjpetB0JJDxR+LilMSIT
 qLvjt74Cb9psQBR9XYgro2zHxOKM4HlUmENh/IZg2H+mHovtt+bBpI3CT+Kiy03MD5wJyG6ir1G
 qaPF5nPpyO7RXm2xTrUF8cv0RZ3OvopKqwGxiQov2mIx7mKuk7GmDaK+Pv1vgvyZ5MlEg79C/cX
 uM8T0uAO74Mzxn0SozhEFkb6kxXTGPspYrW3kcd+Y3F+CroielSPUlK+ZhHw5G36s1+b5JMZLbT
 zK3gbv4XwyHit9H+9WQ55Adcf+rlHOuCjSypjM4HAKDH1Zcb0MuoePofSQlV/BnAMnKGoTViHtE
 LjdbdS+o/PLe7qFX7cTH7ZLZZ6jIzq85FDda5x4ihe+NouMqMPgud/LLzD1iR5hXmX0gZE7Kuu1
 ODvwXKGjWHHebsQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Introduce the dev_dstats_rx_dropped_add() helper to allow incrementing
the rx_drops per-CPU statistic by an arbitrary value, rather than just
one. This is useful for drivers or code paths that need to account for
multiple dropped packets at once, such as when dropping entire queues.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netdevice.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9cbc4e54b7e4a..03c26bb0fbbef 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3016,6 +3016,16 @@ static inline void dev_dstats_rx_dropped(struct net_device *dev)
 	u64_stats_update_end(&dstats->syncp);
 }
 
+static inline void dev_dstats_rx_dropped_add(struct net_device *dev,
+					     unsigned int packets)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_add(&dstats->rx_drops, packets);
+	u64_stats_update_end(&dstats->syncp);
+}
+
 static inline void dev_dstats_tx_add(struct net_device *dev,
 				     unsigned int len)
 {

-- 
2.47.1


