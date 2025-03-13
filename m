Return-Path: <linux-kselftest+bounces-28883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2DA5EC4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F55B189E424
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651851FFC78;
	Thu, 13 Mar 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="N9z5AYpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E691FBEB7
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849299; cv=none; b=SCk2Ox+pGKbjm+VNu0aDDahyPfbUtudpA6J++FB52tq9N3hUNFbfXl/WWoWaSQoTzSjM3PHH8y6Hww8TrkKyw9Oc8XtkF3nCcprxl0Ux5TrnwXiiTXlQ9iRJblOQepiF28qlQGjI8FebTFP/M8+D9200HwAFle7duwXl97YKURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849299; c=relaxed/simple;
	bh=tjt6UJr/WhYJJgKlXXv2tzURIehZ2/2wH4imLUM3bx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pvB6KiYMr8J0Og4Gxycrp/PmIrcAt6fRk6XFqer6Hj5t96JfyF+SagU4MkeDFcXgkn1ah9xB05H6+simfXCztyAcALt7r227hOBPWtGb57n9Cr/qdIB2UZO0UfW/+eqX2+ErBntWlNm8f6sV+CogglPCdLlk5JRLDJSMt65M/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=N9z5AYpR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso11048845ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849297; x=1742454097; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=N9z5AYpRTofOvsMI8/LwRH3mSDceutebZIF40gGr1Wln4VrZqMJJxmSf1IN25vD9Bc
         XuHixSgts+t26afNcN0yLL502JAakibg5hlGjLEWp+kkGJs2ndzlZTii8AKKoyPiUkkQ
         2LAuA2Z+Qc4+yK3341SYhq1awEmnVeFYiyYRUpGuwi6PTfySqYXNKNo3U64bz7G4rNIe
         9QKbrsWC6KIWTLJIc7cU75WZBZtmuH1EwGg+jSTsbIGUfF38miFZq0n0VM1rObCdzozp
         VpTGXEiCKyyaxKxNrbxiBfY+hen+n2wsF+Ppal9ctqlT6l5E4cMAJj6gj3wjgJv42i9T
         nSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849297; x=1742454097;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgNJjOB2VNdnBavlgHvSgZbzYgc2stuH8jHGRqRaRcM=;
        b=vtWczqeL1YFrte/hlweDf0l4JqGPtep5MNW8GVMyBltiGnaEy2SqD/VOgKset039Mo
         hn0xWrAFAVWtThxGijGsgOcnlClpb9sPJg0NVu2Tzbgsa/Qig1wUuKpvdhIV006rrI9h
         16/f9NYiVqj4gItVzyWTC+XREZskKJepeWv8Vayl6Szb+IvGul2O3qXP9sWFxe9x13ri
         2xeY8PBgfxFQvmaEoq/dKr5FAbwxTiqZ6EHsX4YeKWK9fANd/FVXA1+80bjyVZb6elP8
         cil8Rf2K4QbcS/4rIXwNTKbUXAe6tMvWUFmSnLFclQ+JfJ5SjKQdlhbYWvP2yNgvbi6C
         0VZg==
X-Forwarded-Encrypted: i=1; AJvYcCWulJ8Loi34IZAfj5vKszZ/0J7PDEH8PAdPRY2fS41/ySZjSM20CO2WDx+WSZX1dTyDIeKV/lnW9szsWLAwklg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUfUzLwHJYKpKbCgOL3ed5cHrolgVxwfaEYTuvPtrmjGMlVGnI
	yS+ksJUlofLEMps3FwS0VI/Caf5W6N9M4VZKdL+jBum3csvX50SQBZrputRpbvQ=
X-Gm-Gg: ASbGncsd5U8Wz0nZ/uTJQDUVHLUk68kB5NHmMFWez2b2w2Iyp27lozK96SDug+68vBW
	qKj5T4z2j8gBS5OKzGee+yry/zlok6cc7gsG1QTF9m0XK+UfQYtx+znjStmosi3jqJm3VRsqsOD
	ikR1rVu4MJfaGXuyMhlRHxDi9ko1ut8vJyC4gG9eP6qesZk6gVOOpLMGpH4cOjvNmTjqw6VWv+t
	Avm6/Td5g4z8aLAZiQDBbP4/FAw+pQdMy7hrukBfVpbxo3G2LqO8+kGkg0yBM1fZmSXO8JHPGCJ
	vkEXGK1EVh4nCo5rr3QaPiXs5kOFuhoM8rmQEHIBU/KgeRYvKk4QHdYmEW4=
X-Google-Smtp-Source: AGHT+IF5wWHOyH5JHVoHtTy7K1X2eW3fNA4SOZ5Z2GJbYtGXN3r5z7f/KOO/C3Z0RJnF3qBJwnVUzw==
X-Received: by 2002:a17:902:f548:b0:215:a303:24e9 with SMTP id d9443c01a7336-225c651d65emr18870555ad.3.1741849297043;
        Thu, 13 Mar 2025 00:01:37 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbeb7esm6519955ad.193.2025.03.13.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:01:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:05 +0900
Subject: [PATCH net-next v10 02/10] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-2-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
2.48.1


