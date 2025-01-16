Return-Path: <linux-kselftest+bounces-24632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CEA134FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3891888F2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01001DE88E;
	Thu, 16 Jan 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Cek3tFnv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B11D63EE
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014976; cv=none; b=NT6hwRAaBbMVty4jQPWoLnPGid5RP2JE7bKLRHV6XPgw+zcX9j0YtXVxL57nv3Foaf39hX7x5CDo0OZ22ZxguoML2oKuVINtWv3luy3rIDJdA4hrOtgoqUeaz5y3r37uM8HG6FgizDyaZ9YfY7y4cYrca4a8L/t1hUhVbVSOStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014976; c=relaxed/simple;
	bh=hmozYSHMasgRBCBF4xrgoPZ2LwIXeYuHywhslmCDunM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=EmhUpqvKR6em3mL0HxkjUceQzW3ptH4P11uopQH00/acMTeq8SbMkA7udjOcwG3CokawpjRisjShAjKpBxnATSlABAsIvaTgMEP/YfvOeCdOKdRt46YgRzP4o6EA2B8bYITj4E7lyLxkUObTWPQ9aXxC2IgLkG5SUIJwzmGzSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Cek3tFnv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso952551a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014973; x=1737619773; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrRxU+soYwScLHZl10nkQ00JQwkyOSxqF0iWMzuJt8Q=;
        b=Cek3tFnvdD6dLam1Yt3WNkz2Aa7ykL12K02mdVdlspHrhRPv5A8rh8eGPwL+sJOj2C
         mDvy3OZqaLpgvEqe4Z0tKBMlC69zmyDlFz486/aOGi7ky44oSbSUL14e5qadt5x81biV
         vTy/OgNunL/1RS7PHeBtmSklmL1LrvFujE/BNeNNZKK7s3NOgCtQdTdVWJT9sPojSMfQ
         1HPBx1z7qAbdLQoQv/2yPn3I7xq0/pIc1OvetTfcS7A++hpUZmS78d/VqUPYmpbg2qGu
         CaClI1Kq/pFP9dkDKNTyJvDq2i29Aoi77u1NFN3QOsvPDj+dVcClwVMs5/Kx+MMIZbqJ
         Sibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014973; x=1737619773;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrRxU+soYwScLHZl10nkQ00JQwkyOSxqF0iWMzuJt8Q=;
        b=XGAJHmBXcl4m1gYkTqR0mxlv71fGF6/iAwLVaZ+gjTZM71nu+Je7U0MFPKXoZgK3OR
         IRvfV52S6ZRYoEsyzavV1bJXf5/tlaoZf2KPXi41OV0yZSvjgtLwp+M5bZuzQAhptkYp
         yQNctz1yF61/WIk/zIkTI34JrD421M8w6pIHJHsYtAYI9bFZbODsL8/Ei7w3x8gpq2rt
         3Tq5Ta0irp+fZMJMv39sLFlmfxRVCzYjlOofqjdaGlA/YM4T5lweWPGVkbcj9ZGl/7xV
         R2M3dyEHlcGDnuL4hIFpJkSwSai6LiVEjKcLHWihE7NoRS3w/jK0tzLq4pV72ZKl0TLZ
         rfhA==
X-Forwarded-Encrypted: i=1; AJvYcCWuNmwCj/0ffXxDsRg3Piyvm6gaXUskelajKtHJWALhN4HGHNYPEaIZSVStLlRQgz9YmVW2FBMAyBj7cZsC73A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhXaNFdHPrrLKaUxDdQpg8VTLxyNtrKOYwEnSuIkbBHcHcyZc
	Tx6G0Q8tSZBWhrl7P5Wn0JQfz+h4TsOFURD3bdG25AlBc9QJH9M6CFpDwC7hW4k=
X-Gm-Gg: ASbGncu8uawjLK6pkjfs2r4ecDuZywLX+5jQEwsUvLsM/J5Fqy+fEEsacQ/rKMaKcmT
	ZOOh1bOYWJhCr+Cuf0E408mdgHuDoZp97jhofrvFg+bWewcKljA2lJ9XSTy7NJHEIj7jqrgiDve
	/1Dk5GLt4cn21/P3OWrHPv+w04p05m2+pnntzs7pnfxey7QRktV/YXpFxBQI57j0sFAA+sT1odn
	DHVkmpv+yMcrr2q5fOkAde40yXWz5pcVgcUCmqfO6WfQ/at8JrWqaaVF1k=
X-Google-Smtp-Source: AGHT+IF/aivT7VGN/9qY0NI0lkx2WlvvYYZoSqZ5FMDTYVZ2BGLKcm5XiuPnE5f2W/R9LM3n5U+OJg==
X-Received: by 2002:a17:90b:2642:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2f548e9aed3mr42283442a91.1.1737014973234;
        Thu, 16 Jan 2025 00:09:33 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f72c1ccbd3sm2690558a91.22.2025.01.16.00.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:09:32 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:11 +0900
Subject: [PATCH net v3 8/9] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-8-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 061c2f27dfc8..7ee2e9ee2a89 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	int err;
 	struct virtio_net_hdr vnet_hdr = { 0 };
 	int vnet_hdr_len = 0;
+	int hdr_len = 0;
 	int copylen = 0;
 	int depth;
 	bool zerocopy = false;
@@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		err = -EINVAL;
 		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
 			goto err;
+		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
 	}
 
 	len = iov_iter_count(from);
@@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
 		struct iov_iter i;
 
-		copylen = vnet_hdr.hdr_len ?
-			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
-		else if (copylen < ETH_HLEN)
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
+		if (copylen < ETH_HLEN)
 			copylen = ETH_HLEN;
 		linear = copylen;
 		i = *from;
@@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (!zerocopy) {
 		copylen = len;
-		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
-		if (linear > good_linear)
-			linear = good_linear;
-		else if (linear < ETH_HLEN)
-			linear = ETH_HLEN;
+		linear = min(hdr_len, good_linear);
+		if (copylen < ETH_HLEN)
+			copylen = ETH_HLEN;
 	}
 
 	skb = tap_alloc_skb(&q->sk, TAP_RESERVE, copylen,

-- 
2.47.1


