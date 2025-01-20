Return-Path: <linux-kselftest+bounces-24791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184AA16B7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAF21883E83
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6D1DF251;
	Mon, 20 Jan 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Niajq6Q5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E0167DAC;
	Mon, 20 Jan 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372289; cv=none; b=oUCvSPzZnul1JFMksLlLRWAH4/rXNNcApGuOBZjjS4EYyFn0GCFd/NxWWhapMTOeToPS2CIOlwrmvsoRowaxBCpU7+btRVpMZZZao+ceYo6e3VlVdSwvI0Il4VgZkoAq1I6aKiolGBhjhUUyCjz82nm483wV1cEQBu5ZhigoQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372289; c=relaxed/simple;
	bh=F8c8n8lUERUPHL+mdTKkzpkhrHzyZz5klNWhEUx/HOs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G961PY+iTd4fTnjmEOGSbEfi+Wxe/DbjaYPK9dYPfqk39wd8RgwDQV59bO3ln1sQUl0PDfxJXOVNiHoyQ0JSUuoL5hQ+FdBSaAWD9fA2/xizPTZ6zjRhoAimcfbPR3tTHZRKMFYZzlSvczM0dyEBZMiNC+1Ms4K76RTJeEMgY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Niajq6Q5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a37a2a53so49222391cf.2;
        Mon, 20 Jan 2025 03:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372287; x=1737977087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2b6PEWocf214nlQxHdjOFbir3dB1Ek3Kvgqh1AcVpc=;
        b=Niajq6Q5LmPOxaBrfFesoutYRkYaGmBLdBHt55r/RniA8Tkwsn12RpO/SzQVSjuePn
         SMFakVWeXJF3MTcWQsQjfdaDcPTLfnlMdjBPgTyPSiBz3Lec+V9tgha+ORNop1uWWM/5
         VAJy6kAqC3p8RcfWuxeBUSOUefzgubpuyqQWyuUyp7qvuLKbJR8mjZ3qt79nq7GVMSe3
         ZltKOaObISIbcfScEMELp0jANrMiOwoTyag7zK4zu4uELJ6ia0K7b9C1/tkXwLg+P6TY
         /UnR3FKun4iUsWGx3vF4JO3bygDo7/ijpLRjX2smnAQdt2TMC07OxzlOVj9X8STpKqm1
         8w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372287; x=1737977087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2b6PEWocf214nlQxHdjOFbir3dB1Ek3Kvgqh1AcVpc=;
        b=rWevPVqOCkbv/4e0VIsGbI4NCg0fbu0YGA2frPKP/f9YIq/YwdUJE7zTUlkRFLF1RF
         1eNfMnx78yW8Z1LZIT9nzf1lOenthc7TvZnp2TXsGOfPRd7xBNV4GX+eT0Gf8VVrVS1k
         gr0a6DOe4pkx+jDAQw1mBDRVioIfmNT3TUfu0c3jibrFzhe/zBXb0Z7xbam/WCxiUqGv
         FOasR9bRhj/PH+v0tsVQFYwjtxYaa9ZAKjBJfwYZTZ/pR4avIr0WHdqKFJ8zj5qGBtct
         JwKTRlGLiafH91HKHjXc6gQtsuTF+FbUrJWdZNh1e0Ru3GyF12f45nVpOxHTHyX7z11E
         FEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUfrH3sngP28LQ5TtB1ziOP6lRjkmYziZh38AQICuVh9B9DTqn3IvTkVkQOoEYVkJpXe4Jt1luh1TFx@vger.kernel.org, AJvYcCVRdleOL5uCA6gXtjIujSO4EJIi496EjvpmNRhZRNCKk6Vl9qtcg6obX5gbYl90v/EKSGE=@vger.kernel.org, AJvYcCVnrZxJ6JEI7QtgI8wN2YQHHpMLPiCQKdXXWLOj+KLzy6xeSu6QQEv0KyRSm7wfJMHFBeiNrtS4@vger.kernel.org, AJvYcCWbQyC3t8aDlilBZuVTuT6PZlrmfigi+skdxa42OKAvOdK5/xl44Q0FW9iBhaDo8tLo4WIvD7nmsDh0ovQV@vger.kernel.org, AJvYcCXT9s5XMNJq4/l7/jnG2ZdnEieb814ZMO+XzxWNUpyDyvrs3JTSswkzwGr4bVxkVTyTjXAXBe1/CH1N1lLoSjKY@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfDLCu910T96E3ZvRX7uHEkxSSyrCSoRa6Xo2oMWuvTisFBjS
	OcsT77P70g5SHBlM4ISVbq1I96KKbDIIX4Hj9suWt/8FYvIu7kOL
X-Gm-Gg: ASbGnctDi0iX1cN09AoMpZ/0gsPObip5lJyng2avninFnn9LxWB4mc5GNAzMJdqXKN+
	1uzR1/kmX9SxBgBrI6gGpbu2jNbiY3uihnYXiX8eVfKUhD4EOhlGQvssCmW2NDqjg5hMSvDM/0m
	wMR//1laOmlry4MPsEe4d7qS+Weh8b20K0pGzGOx/faw2IzrPbAI28Uwu19K0FpBOGPjnawJX9V
	0eKkWVQBGmohkLP7807kgSzr/pavEKNKpBZCWNeewD6sSQsW0ilB5BVINKpx0n1CBL66o7+cMZF
	mBjLNaszuqyMcAwkLiTseAsCnlJL/vsd1lTrkbTKDA==
X-Google-Smtp-Source: AGHT+IEbMrWKUTs5M/W8DCHFtlIrBWKmvjQeT8P8UnoJEJpMua5cPVTSwsGq0gh/5/6so3JDrbLKwQ==
X-Received: by 2002:ac8:7f4b:0:b0:466:b394:92bc with SMTP id d75a77b69052e-46e12a0c2aamr181155671cf.6.1737372286947;
        Mon, 20 Jan 2025 03:24:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e2f67ea89sm15197411cf.10.2025.01.20.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:24:46 -0800 (PST)
Date: Mon, 20 Jan 2025 06:24:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
>  	int vnet_hdr_len = 0;
> +	int hdr_len = 0;
>  	int copylen = 0;
>  	int depth;
>  	bool zerocopy = false;
> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  		err = -EINVAL;
>  		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>  			goto err;
> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
>  	}
>  
>  	len = iov_iter_count(from);
> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
> -		copylen = vnet_hdr.hdr_len ?
> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> -		if (copylen > good_linear)
> -			copylen = good_linear;
> -		else if (copylen < ETH_HLEN)
> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> +		if (copylen < ETH_HLEN)
>  			copylen = ETH_HLEN;
>  		linear = copylen;
>  		i = *from;
> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (!zerocopy) {
>  		copylen = len;
> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> -		if (linear > good_linear)
> -			linear = good_linear;
> -		else if (linear < ETH_HLEN)
> -			linear = ETH_HLEN;
> +		linear = min(hdr_len, good_linear);
> +		if (copylen < ETH_HLEN)
> +			copylen = ETH_HLEN;

Similar to previous patch, I don't think this patch is significant
enough to warrant the code churn.

