Return-Path: <linux-kselftest+bounces-18109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9697BC73
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBC81C21324
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63108189901;
	Wed, 18 Sep 2024 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avn5dHax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2E4409;
	Wed, 18 Sep 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663620; cv=none; b=nU9+NsCkn8KTSHxQbdef9KE5slsg0wnSS5gZXRUlGSI3lid84uTnqQRecG5Mpp52EG6OxWWcrHTT+bcl6yaxveOgHgOfTrb9N0gsnimc7M3oTw7pBMyr+YXIOIfRAPpQ2beXz3cUWBC3TC588F3u39FBbwlcKKUVysk2Tt7Zia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663620; c=relaxed/simple;
	bh=FfCTcp0ZVpfsylfuxeYRb0/Fe0NXrZIXNkhO2rk/C3c=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gsZ3LmFA2xi9sCr7BBlhlokJ6oHJeCW6OMsS3mIJn3iUWD/cjxfeLnqwXQCBtXY3nM/3LTSnSeoyL1dHQg/RDcmQoogs21f2sB9uE3KQr7zxPDEIpniyX67uT+UFO4xqDiWxBaoHY4xoBAe2LCegXjOlGs777TVGjxh0iqza0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avn5dHax; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846c5c2a8e9so1336862241.1;
        Wed, 18 Sep 2024 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663618; x=1727268418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEiE54XLGCyNeFLyuQe7PaxspDTPjoL4Q+YGo4YshIM=;
        b=Avn5dHax1t0eaGgubb6zZwheophJccf6tw58NwaVuu/sjXcitJ9TuY3i767cL1hnCR
         IDCuPUPTKWp1SCflsOWn6zWzAmvknC7fgnURlyVDb6CEX/73gjNxinS1MzFh1+NrQdZn
         Bw6zognUkCi42e9m7WuN3CKG1UF8efMjt7+HmN5cWDjSy5vcZSHmXBePx33eP7r+pknV
         GfHFXZ9JYQ7rjTNN2o4px+LqknqunMAvNigMqCqbPxPx5IAw/ogTXWXStLSXc53D5TM7
         n+d3PxCxeHqvKVmssvYkB7FlOUpS8o+wj3NZoz7q39WMGs2cLxiWZPB158se/zWjCp4g
         4Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663618; x=1727268418;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEiE54XLGCyNeFLyuQe7PaxspDTPjoL4Q+YGo4YshIM=;
        b=R4KAiLnWK3sncMzpZXBH9wI5bI1bx6mg3jCNTekSzm8idMvgbufRCfyC4CvZwv+ORr
         1advRkwmNfbTLrq5sDskyE8HuKch+mCettRxmeONIw1nOBZTPmO+xsUvimr5CJNP/LuA
         YEHA12n31dyABa8+D23bgwNWArfmSQjOIB7x80ZU/rdOCl5qwRz7fTSDRRhVe8FVmjmj
         xRel8ocLvAFIR/EYSwqoEkt3I8SlewqT1KnflX8GEMUBe9/O1S6lGmWL4b+7Z+wDr+ua
         We9NFbmJTQOqoAdpQAKXl46SXuImRS7w5YmAlJyNe0iNxMu1EhTvLh2J+UqHInN0w5Ge
         SzMw==
X-Forwarded-Encrypted: i=1; AJvYcCUUblAfLVau9A+pINmwdEWBITsCwddQmDKWZnnBWPUxkQZ63AmLydAdUS0QKvrdbtLfWyJml4sPsDsh@vger.kernel.org, AJvYcCV+7BxAB2IPWpUi1r0egXNLXCgKm6iChP0LBl9RkcCvVBiSzVsn/M3yS2QNjTctSuiEFSsv6c84oR9nEemQ2n2w@vger.kernel.org, AJvYcCVxhgJdr/gEcb5VEMmkwDLbrhd7mJufwojvrliwZtctUYWyt26xqrDE5enLNFRV3RGJfOM=@vger.kernel.org, AJvYcCWjdq+0bXuqCFqCGfnJstuBWeQvTuUVbcBglUZDC/Z5P7z72HoRXrR3YRjq4USQPX0bTIqW0ZEt@vger.kernel.org, AJvYcCWmVqGPd92qnDQ28ApvnntyFygp7SgTTDs6g2dokRIu5RFidr1l2JnkIBGdncGj9CORrb2m9Z/wezpRja4M@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrf0kjnanHE1plWqW+gp1EhmpuiDBp98dVdr/ZPodWjfKbvxDk
	Q/rNvnn1B9BDWrTSfckoT4D086xZ4Ld9rSRU9uyML+t0PjMs0Aly
X-Google-Smtp-Source: AGHT+IFrKCQScpPxemEjNo4inlsJUJ4zUHIc/PvEWxO3LcIB17Qy4vN/uLMJEYjH72+/k8IlZqRh8A==
X-Received: by 2002:a05:6102:e07:b0:48f:dfb8:77aa with SMTP id ada2fe7eead31-49d414bab43mr15069675137.17.1726663617491;
        Wed, 18 Sep 2024 05:46:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c645ce3sm43438606d6.67.2024.09.18.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:46:56 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:46:56 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66eacbc0b16e7_29b986294cd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-1-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-1-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 1/9] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
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
> This new extension will be used by tun to carry the hash values and
> types to report with virtio-net headers.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/skbuff.h | 10 ++++++++++
>  net/core/skbuff.c      |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 29c3ea5b6e93..17cee21c9999 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -334,6 +334,13 @@ struct tc_skb_ext {
>  };
>  #endif
>  
> +#if IS_ENABLED(CONFIG_TUN)
> +struct tun_vnet_hash_ext {
> +	u32 value;
> +	u16 report;
> +};
> +#endif

This is unlikely to belong in skbuff.h

> +
>  struct sk_buff_head {
>  	/* These two members must be first to match sk_buff. */
>  	struct_group_tagged(sk_buff_list, list,
> @@ -4718,6 +4725,9 @@ enum skb_ext_id {
>  #endif
>  #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>  	SKB_EXT_MCTP,
> +#endif
> +#if IS_ENABLED(CONFIG_TUN)
> +	SKB_EXT_TUN_VNET_HASH,
>  #endif
>  	SKB_EXT_NUM, /* must be last */
>  };
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d1..ce34523fd8de 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4979,6 +4979,9 @@ static const u8 skb_ext_type_len[] = {
>  #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>  	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
>  #endif
> +#if IS_ENABLED(CONFIG_TUN)
> +	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct tun_vnet_hash_ext),
> +#endif
>  };
>  
>  static __always_inline unsigned int skb_ext_total_length(void)
> 
> -- 
> 2.46.0
> 



