Return-Path: <linux-kselftest+bounces-6133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC2876DEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 00:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833EB1F21ADF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E53FB92;
	Fri,  8 Mar 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="L2SVzAze"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E053D0C6
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Mar 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941679; cv=none; b=aSSFJpB2hlSoW6R34SBZsizZ+1DMUlD7eszlevqEISd1YlyTQhmOP4c4+VrV8FQeI1hyJVje5mfE6fVaTZtWgsIkRyx9Z1QBhn4wKUolL8G/ss3l2vbWa7oAntTQf8c+ru75NyW8V9pMisKqZ6qJd6lQuuC9hTSU2lF9DxC3xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941679; c=relaxed/simple;
	bh=dchB7UCiRqdqw0lIYP5nDwZdV0ZR/CGk1fMQm9ZuI6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYG0ZGvRetL08qFVZBq0tqefhrICnPlWKDXB4XWn/19ylU92YY6MmdJ+keBmm5e7751wsDiywZpZIbSv1ZCOSVHwZNThyS+E2wO7i3NczUUUMb1xzW32DfSIP9eQZtcVzf+8Fo1u/14CVvGClreX19WlL48IahnKll3dPVoz5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=L2SVzAze; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29b7b9a4908so1004910a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Mar 2024 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709941676; x=1710546476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9az8igjncgnaY0U1W1wkJljIYsplkUiE6Xc4XiRbO+4=;
        b=L2SVzAzePwXBRM6vqpB+QFbzZEMkhm600Z9LNU18bXT3rfz7fAe/P7ogRt60U4uG7i
         HXLidI2y6SP+IL0S0e8jPXgk0ZTJpN0/8y7eullrSL868jS664cbUrjHCXR4O/6af6wp
         ZFLM6nJH/aSwMmPRAQgT5BU9GqHvIXEaYVB8iHQqH1I3dbD8/HOv68ShDA3QuRuclBlr
         9zrKlcKkyUVAbCme+7X6/7vFm8kDVZig93IjG7yddBQmcoZmtKttWjR3jTz/d2rjhG8X
         +gu3mBdIQhOXdcGDqOlGqigx5LEmPztkJ7/Ngv2Sp4AYJ5m8wOa7K11omw88Hs+ppJ82
         5Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941676; x=1710546476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9az8igjncgnaY0U1W1wkJljIYsplkUiE6Xc4XiRbO+4=;
        b=SqKq7qA3kpXKUco5Zt1lHvfjUH1phYOyDaf0w92bNTpy53xPcTcjT8PVeTXC9LiYnf
         PXimfI62k08Kg/Kyv+XVYDZ+61jCnqoznccGNEpfdYSqzqXlwUW5vcQuf369ycLW4Fi0
         WnBwS79rFuOEP5Pj6WBT4o7HTnaw6+rTkxnZiH3uSuUqENZczks84Tz5Yy6LzYl+dn5N
         dnWXcm3shHWYIhtM9Uhoc0Aq/it8y7MZUxlQ2W8vXNT4DDTWY6zIxa3W6cDZrf+K/0x8
         OsIwy7c1xtq9t3CrHajs/kbT1Yr8FqKawn1JP8kOI1bg+wzeuQjqfmy0IA3imazOeDyo
         7NbA==
X-Forwarded-Encrypted: i=1; AJvYcCUkZBgDgNdqNWBn/owjRh/lH2bfbIiVQiPI21NtSfHQ54blVghMZ8VSI3huc5i93joobSUQcakuw55N+++zKjSqgzN30eg08XMQky8xfWNq
X-Gm-Message-State: AOJu0YzZv8oOHH95GfckAyCKtQUMDJ24X6tv+kvFzDWAKFXUjX7At7F4
	mS7ZBhUQhZiuevaG2fFxXgE8L+2Xkrmsj0uOaN3sWkFNRMYe6GfJlSNC6cxzmmA=
X-Google-Smtp-Source: AGHT+IF8a9eHGDem6IS2N02q+0T3yH36EZ/hJ5LpJRaMKjh8ZuXGZ+UFipKrEBkF+ws+Cz/PyRkACw==
X-Received: by 2002:a17:90b:1286:b0:29a:e097:50be with SMTP id fw6-20020a17090b128600b0029ae09750bemr690309pjb.31.1709941676412;
        Fri, 08 Mar 2024 15:47:56 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::5:2342])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090ad98f00b0029bbf42daeesm265183pjv.30.2024.03.08.15.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 15:47:56 -0800 (PST)
Message-ID: <54891f27-555a-4ed1-b92f-668813c18c37@davidwei.uk>
Date: Fri, 8 Mar 2024 15:47:51 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-2-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240305020153.2787423-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-04 18:01, Mina Almasry wrote:
> This API enables the net stack to reset the queues used for devmem.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/linux/netdevice.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c41019f34179..3105c586355d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1435,6 +1435,20 @@ struct netdev_net_notifier {
>   *			   struct kernel_hwtstamp_config *kernel_config,
>   *			   struct netlink_ext_ack *extack);
>   *	Change the hardware timestamping parameters for NIC device.
> + *
> + * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> + *	Allocate memory for an RX queue. The memory returned in the form of
> + *	a void * can be passed to ndo_queue_mem_free() for freeing or to
> + *	ndo_queue_start to create an RX queue with this memory.
> + *
> + * void	(*ndo_queue_mem_free)(struct net_device *dev, void *);
> + *	Free memory from an RX queue.
> + *
> + * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
> + *	Start an RX queue at the specified index.
> + *
> + * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
> + *	Stop the RX queue at the specified index.
>   */
>  struct net_device_ops {
>  	int			(*ndo_init)(struct net_device *dev);
> @@ -1679,6 +1693,16 @@ struct net_device_ops {
>  	int			(*ndo_hwtstamp_set)(struct net_device *dev,
>  						    struct kernel_hwtstamp_config *kernel_config,
>  						    struct netlink_ext_ack *extack);
> +	void *			(*ndo_queue_mem_alloc)(struct net_device *dev,
> +						       int idx);
> +	void			(*ndo_queue_mem_free)(struct net_device *dev,
> +						      void *queue_mem);
> +	int			(*ndo_queue_start)(struct net_device *dev,
> +						   int idx,
> +						   void *queue_mem);
> +	int			(*ndo_queue_stop)(struct net_device *dev,
> +						  int idx,
> +						  void **out_queue_mem);
>  };

I'm working to port bnxt over to using this API. What are your thoughts
on maybe pulling this out and use bnxt to drive it?

>  
>  /**

