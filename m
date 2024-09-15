Return-Path: <linux-kselftest+bounces-17994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E1497940B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 03:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D831F22DCC
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96B1B85DD;
	Sun, 15 Sep 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="XyfoobCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524391C32
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363133; cv=none; b=vC9kA4R5AF8pilRdXC6JM1yhU7RYgqKLR3tqN52xqhox9Q6OJEymWItFlhmJrdeQMFlDTMkU6Hxww9XS6oWWuAgSIvE8dIqptMemTc4Qa19XKDk7mfQdPTJhY/Wtrx+XGfwQEbL0ZfnFAA9z1Akg/G3vYLvD5jExqqPM9URxIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363133; c=relaxed/simple;
	bh=jkhM+x9bNKZH2KnPiJz0Wz2oSY9j9Yf3OXEdL7BBvmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=PbGwm08ROvez2S8o0bECAo+I9A0T80u0fTnRV8pMWc80ZMUa9kYt/U8LsfqzAJD1xzarLfmca7UVa8Bv1qAc7IEkASpLLoTxRY34GcOw+uQHpgEnMN/kvp9HBtBCB921i8SC+sBoG+zDlcN/eJudn8phFHetibI7O1XuNiaXH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=XyfoobCn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205909afad3so35710055ad.2
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 18:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363132; x=1726967932; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=XyfoobCn2rYXL+dohwnawA3pnZWnLOXxzw3Xnkw6ST0nG1/AUENo+fhjx9ymWs5/Rf
         aJB8Vqvo0x8crpVlMMCj8wyfeNl9NnqDavKzonAWJ2vUAx3B9GMCMrzcWhXmwgp0+M0z
         H4vwNi8nRYLDEKvlGoqbCrxzcB7lVhiL84l3T1IZdk9VtorDDfKTBev8KXQrUpTBlI4F
         CL+jLPPqgcT3wvn0QvvfLXa4d3ebT5+wr0SUph5jEtjwhUSJkkKz9b8lxzGW/RlDYQrl
         nS1MJK08noQ+3dScMSHr3sDbA8qSik9y1pQGboaV9nDzuHpfjDbn8nrpnbinph1Lyh22
         VVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363132; x=1726967932;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=AOerZvZI/bjM4Jlm7alcEeEZsCYye3AYuzNJWTRVA44E1uin4EKL4cPtlL17BOI7oT
         isI2xV4YK5OLq279DLR8o1A2ND2plUaKEw3oxE+0I/qf8HQAAqI1+m7qnnmO2utMJHz8
         QdNNw9Qg+eM+RPcuz+aAR/3a74rikBQsyiqTqLo0JjhRatGi3nxa2VsMd9bplYuOTifK
         A5fngwKIAxZZ6G8S0k3bDyo3NEhQErvaZ1l1BVShnALESEaXGgUndELqB9QTtlEzUMnz
         LtbQYQtVqw+bYOzG1FrfGvmPgOHCX+pOOIZ/ftJ5T1XLMs9iAbpX/9VLWaJqKOuMDjG9
         1ndA==
X-Forwarded-Encrypted: i=1; AJvYcCXcd5h5dogJjl4YO4vBBgJRydS6bn+/I9OOt2XUA3nVkOWOBHQvDNUazAZ00SuGiAu1KfWmGG46kIuzbBapb/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRYsTvx9lYCN5lbTzQROrV4yYHhQCLvS42prpLzQ4JZvFfNIo
	JoMFAohf02S8HBHvNcSRQyhlkUTsKj50p9pm0EdrK0dGm9k2cwaymIgjDKnylvI=
X-Google-Smtp-Source: AGHT+IHa2pPsD6I/59W1SS+oOKkVkOqdCgI07i1yNz/1QsPKuheqwpLtXx9aikNZgE4fL33O/C0z7w==
X-Received: by 2002:a17:902:c40e:b0:206:add9:624 with SMTP id d9443c01a7336-2076e39fc33mr198047165ad.36.1726363131701;
        Sat, 14 Sep 2024 18:18:51 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-207946011f0sm14895345ad.78.2024.09.14.18.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:42 +0900
Subject: [PATCH RFC v3 3/9] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-3-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
index 0e638a37aa09..9822988f2d49 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1852,7 +1852,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.46.0


