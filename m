Return-Path: <linux-kselftest+bounces-34033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D7AC8772
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 06:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35B37B2ABE
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85860205AA8;
	Fri, 30 May 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="p0jMeCwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568820101D
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580637; cv=none; b=Aqphz4xRIY+cslPBFyqsZJYgFvuvtTZvnYmjXPm/29rAHfvOqM8JlFiWjGt4wadYWqvoH49QInh64h8MB72ZnibXNLslE/5POWjRcMWKCZ6FBj1nXiAvuN0qzqUJe8c91ap0PDOlLSwMVxcYBdFelWVHNGic1auw410mZHzDpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580637; c=relaxed/simple;
	bh=2oUMDnIBYoOmxLZqcn3thZSyZ/SbegpNqOzQC+cCzEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=PBJk0YFuIzF1l8ZhzJUFHBi+BZ770GMgAxjx+/vBVJtBFvhKO3i0KBBJXCA9q65a+Xo5V9ymZSoYoJMbE9Bx6ZcDdxDedmTAtd3tn338xzTHgqAHQSPZamxopaT5aV4IFB3FCmFoEudkHInc8ZoldNzk4JQJK8Ogvj6uWckpw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=p0jMeCwR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso1687102b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580635; x=1749185435; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTqe1YGUMZdFRvXBjnIPkdBxtf7RTeZ/o279FoAQM6o=;
        b=p0jMeCwRTCl3QbpKCZ0PeAx4iBbKOypHeipYJ1LbfO5JLAbEZH7aXtAZI4aV4tPGs0
         AGujK3Dx23/n/XtwrMEFpH+Cvg5VWG9OrmMDsldqPzqEN/8i/EZKWu1Vta75nj8BUq3V
         g2DEZoI15jzk2MOqK7mMoJVEf+aev6sa2KsOlBi+xuVf7lhm7FdzoycMqLMsRzWojcZU
         Oeo7hFtAGGlQNIYuNurIAVyHXawBLnnNpvaLQyFrCbP5tF3KLQiFWSHZiK4I/YRa5XDw
         Qe0AFjJPjzZicbMyddnsG85mDrb2o2pOrEeewQ/kCHnsx3oN9x5F7oq7vPtsYfIUu968
         9BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580635; x=1749185435;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTqe1YGUMZdFRvXBjnIPkdBxtf7RTeZ/o279FoAQM6o=;
        b=hJwYxbYSOuk7oa0rikxbNAlU5P+b5TRefCsepXcPqWIRUH5oED/+TkAOXuNYOewshF
         zyTkxgmjDCW+R8wm0uRo25yDDfhqYrl524Hd5GYj+H1djweDYvjfKgiFhclndJ4nIicX
         a7Zy5N9HHRatRJByq5I1dSV2NOiOsQ1EqrhUKcgT+heaCktk7yl4NQzsvecqSvllByZr
         Qp3xYXhXMX2Cas26tQ/0oIh4IHuQ4AlfWV2Hl7olYFoKfqb6m7RXRlLJkbq8ybnrqCHD
         W3IBhDsovZqAKs0BHlfS9EqyFh0JHiRtYOZQ1AIYhqD1BTHwwnq28kFD+mFR5F8DKM5f
         FajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwTpa/ikr7YIsVVpbNvGCYjGU/m6E14o9RyAgrtUbpQq8Zyx34MHhY1KuG/AqgiMKURHk9ArmSVlUCtk8LF90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+vShHGibxjCBJ/WiJuvUjP3y6+fqNPZOIhxDIfHw4beUZAHw
	SCWhzyA+VFUC6EKeV6DyzxjIzlMVDfZPzkofC3sQZ81ETrWe2qlFFNyLU10gWMJnu5E=
X-Gm-Gg: ASbGnctLZsDILZtwhvauOacyFFAyw1IUNCyOnGkd9EEnC2kbdADsyjIIah94y7euCIZ
	C7hzKN1f07OKu3MQeHGwKYItunYFlYIXJ9uKnu8syFyFTqSN6RqQ9kNwslN5aoBmVctCGtswf4G
	waQSNm7XTL1xdaMc9J7Rp50kh0DCyNsRVHMroPxpDEyTRQo2UOQwWWJ65fi6J8CkPuY9I/GKM10
	erp/f1lROBC1Y1IAoKU/iUyPLmyGcVMI5BB1XGfTrEJQskgMGN1nI9qLivF4+vdf0jnwdMw4cuK
	gFFyBkRS70PfA7MiMTa1SUW3QqmwMAQX/H7cRTKX+p39j5S3hzJxmqiKm8Jz28o=
X-Google-Smtp-Source: AGHT+IECFVZeba3N9ihXZ5rbjNszUdlvoohjDNehjvfvwHvZL080L1tWJfpWoXRRwXkMbrFpkWtKqw==
X-Received: by 2002:a05:6a00:4b54:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-747bd97b301mr2912852b3a.12.1748580635197;
        Thu, 29 May 2025 21:50:35 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afeab6bdsm2179867b3a.37.2025.05.29.21.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:06 +0900
Subject: [PATCH net-next v12 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-2-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e856..d01c1ec77b7d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb5..32c7ee31330c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.49.0


