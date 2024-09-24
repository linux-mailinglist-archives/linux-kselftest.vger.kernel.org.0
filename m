Return-Path: <linux-kselftest+bounces-18279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9D984167
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90424B24CC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8216F8E9;
	Tue, 24 Sep 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="i/YFuAt2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E158DD1
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168483; cv=none; b=INtqawJJMDOooGpPN1YmYjRS8+mBIIXFEtAzJxIQgn+0afilxdPSVO7jLvIGGdxkkWWr4WJVQBqpWpOag0vv24zEi1A/TGo7PqfU5M3VKAXb+9vOYs/oDzPGQp47rWFv42GIdlhBywZbOulR3paLZkNF5ukYYTLeeHFqmwLkt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168483; c=relaxed/simple;
	bh=jkhM+x9bNKZH2KnPiJz0Wz2oSY9j9Yf3OXEdL7BBvmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=PeDqJnKrHmOhIZkO2ehS/PEicIx2b6mts08U4jyreEYMYuiP7GRbjJejq2cCl3d//IcNIXbeJuXpPxzZJFOAyDFr1f9fe8Tfw3TXunclgSJMKvKCHV/q2f/Ur9bfnbM4cKXfHDAnyg9usRdEY9/aoB3E1kL0HoMBPd9bcqGt85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=i/YFuAt2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so283688a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727168480; x=1727773280; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=i/YFuAt2kUDgdhMLNiLfwvnLHrHNKIRH5RltR9Kk4QaB09kSG64ykLz4L3TSaHXfNp
         gZALPqXuzwzSvDZBNemoN0Rs1cSX3nvxGQYJlSVRPWv8HGma99W9IGmbJYunMGSQ55LG
         Bib/VZS/eBXixyCLtNG0Ex9IF8b0H/K13Ija+CTW/Vos1SmUVf3QItkOaxfvSvk54gMV
         OyW53cmnLF1wpkbquZZmtowSDL5Kq5mHEdHIyqHBoERrxsUzsux4l9fcC1uKYTFd30SR
         wDgXQuDdAd8kyFzx5Pslbs8MGHie7AufcRk8o46y/PauLJOC4rDULwDF9GPR7rejXztf
         bHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168480; x=1727773280;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLQiR3TXPfmR5MbSmS8z1giBJhJI6LMQJhK91hzIYDE=;
        b=lebpJe2YDpYAcIoXI66oAWlbDCBoKXiB8wfBeG/N9ILihvpBSGyByKNfks1vpnUAgz
         +cAdiN2L5TjMI9Aw9dvqYN6rojrYDzdPtXPFJevA3FY2OKEcrEdB298t3ededF8LMMCr
         VbTZUN4YOKIbjkVvg2Rvrb6BbT/5pWV5V4cEDj865xFxOfFVDZxpNOfmQCKD2XoqKMKN
         JLU69XS8ivVMtw1k3to3ImbSioQsJhU2Jfwy5GCS8hh0j4EssPd7sw5yFYnEXzlrGjis
         Yb8RH2Irj9TCf9HxkfqIizgdx+qJ8zG7GbZUlS7VuDW+BqvM9N6xJiaooLJzDF3iogs0
         oCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/pwWW1Fz3/PPJdWiwuMUepozeP16KF+QsCKVYHExdq9pyL/PdYCE3wBeYb7c1jOFDDtt1WWAYAqLGGZ8K9dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3GDwDJ3gr/TGHvkCj7A7exiJqYj0skhMR0pVpzH1RR8vv1Iv
	B/c6r/tTangHXWVvBI88SwYHQVgQoPK/R4m2/5vwK8dNA10ivRc/JVQ/t22HWO+oZShQBhNUWWI
	lrT2iVhFp
X-Google-Smtp-Source: AGHT+IFpGV2s1+MT/Wmetrjt1jnUx/JVoB/QDy6LvgWwnmt/y8aBUWSPmWV8V/zA8CCvTi/SZQaLnw==
X-Received: by 2002:a17:906:6a22:b0:a8a:7b8e:fe52 with SMTP id a640c23a62f3a-a90d58c1039mr1494327966b.59.1727168480198;
        Tue, 24 Sep 2024 02:01:20 -0700 (PDT)
Received: from localhost ([193.32.29.227])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a93930f470asm58712666b.151.2024.09.24.02.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:01:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 24 Sep 2024 11:01:08 +0200
Subject: [PATCH RFC v4 3/9] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-rss-v4-3-84e932ec0e6c@daynix.com>
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
In-Reply-To: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
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


