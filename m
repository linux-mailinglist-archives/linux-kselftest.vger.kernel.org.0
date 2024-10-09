Return-Path: <linux-kselftest+bounces-19354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A65996CB6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509C9B2543E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF881991CC;
	Wed,  9 Oct 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijMnoR0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A0198E7B;
	Wed,  9 Oct 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481909; cv=none; b=O37+QJNvIeRCjuge/+d0n/baTjVPlHVMuxqh7XsMxQRIftfztWf68AAe0iNrd5KWGor3Hdo3koUWo28VhdAFczqdLtx6rmGFe1Bov+CHsDex3+TE+f98bBvBpOFBuAga65CqKUV9Y2CSneDviWOa7hpJ72nak/vJ99iqzGJ2yxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481909; c=relaxed/simple;
	bh=jYgb7BwLs38wtXSfN1wpIvBf5tLjsHOZeuzvh4Bgntk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a6iPfpwW+BYikBf3y6Zv0STUH2NldL9eCT4a/H4eVrahtTtk69l6YFUYYjbrzM9LJK65/8v/J/h5VLX3yDdz3TXtP7J4LIFw6t1h/zwM0IvRjv/7AR3ZS/yHZYU63zXkZsDjN2XTj5xlhGMieKwAFej9CJgTv7GVu4AKru6lg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijMnoR0I; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbd550b648so2179896d6.0;
        Wed, 09 Oct 2024 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728481907; x=1729086707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUc34dZTHKciGaII3zabz1ZKWWaMos36cbYH1GBxAp8=;
        b=ijMnoR0It9zDof8YnOZuP6DexnR7PztZyVvGOby6q8ll5BB764L0oQGG2IYioJCWAl
         XUIpeAzlhrAYhE9bUVUt73YBJgzJdB6nZlKrPzJE9M6WyFqFXC+S4wC45/PxTGaNfMxO
         NrRQiHU4GGe6yA6PccURE/6s5y1ZMbNkc8V6iursFvNO9FLvdHAMstEn0GwlCNtMlw+T
         RrA3XTsVssHz6EiEvzwNsMjUuxEa6D+1o6+bfpjKZWIASTx17q89xlrhionqOI9biDYH
         wlyT3Ln++S6UFIISQP3kCIcFvixi43ivhcxy2VS/7lfin1gGetmTtyuqZy5/2OBoCxXO
         ZSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481907; x=1729086707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUc34dZTHKciGaII3zabz1ZKWWaMos36cbYH1GBxAp8=;
        b=W2MIm+BXPu4P4sVqc8RpfxhxuxD5ADYF0mV5edGnb2kuMF2iGijRmJqFrANcob6EPo
         q3qeh4S04kOhsXkac84oN+jVVOKLmUzgemzqsAcN8wgHtJbop6ksHqWX9Kz0fEtRf/6n
         I9wBhVSgqomgnlqFJQXUZV7wh4m1Yutl7iZKud4WKA9iEYLt1VXNbEXfnndcJ28p+wNx
         LsMLy2fGLtl6mfm1qjRxIRQ6PjY3337mlYhWjV9XgUaSbGvCdTIlR5HAl5MRgO/9O8D3
         qKAMqbxSU1gJhf9M6HYaxp6miU6PeeL2a7/zqgm0qz60sxUCMcf6+qzQjzrDEcC90RPQ
         o3QA==
X-Forwarded-Encrypted: i=1; AJvYcCU8OXqIQt/6OoEM0anjfyKXa43wIJhJy8oxd37O2gt9U0yMXuXNaiY9s3m6uxS34iQLKOM=@vger.kernel.org, AJvYcCUOcx2y1W3TZphZwZ1Z7Emb5OK4DdAq+31aeI/93N9VZEiBs3Bie/eknQ4pSK8wNjcuvW/851Zdk/o2zg60MjuJ@vger.kernel.org, AJvYcCVTU9kFJKjSf91vdtzNiSC/F0E8mj/ooq7LMFIBvf/2aDrYe5umeTmJOuQl1+9GFNawchXIRmOW@vger.kernel.org, AJvYcCWS9NS9mEqCgQY1/Oin6NK5Wifl4t0rvVVeBQKDGcnkVx5SN2DpC/mssQdN16d65TApOM/TJk2i4N9s@vger.kernel.org, AJvYcCXSx6IIzS6lVAmro9XbhqLmECGJO69Zs5B6EYZLEl0dP6yNAQjqhwtIZhalOp+XCajjatYLTI8vummNa6fH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Yq4vYyv+aSyl/7dpz54d3sgPz2VWszKl/ByO8bTaRShYyJo2
	lBHp38+JETZo3N7udL1u7vwd4RimS26IiorsClBsZ9rzAQt9pL3k
X-Google-Smtp-Source: AGHT+IGkew5/j69otxM8iwfX7gFjP4eK+FksUEv8jew+/bnfYJy9/Nhw1Lw41t2weOaHSSLA4zni5w==
X-Received: by 2002:a05:6214:5d83:b0:6cb:3cc8:5d7a with SMTP id 6a1803df08f44-6cbc955e801mr51908116d6.35.1728481907058;
        Wed, 09 Oct 2024 06:51:47 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751294sm46132086d6.93.2024.10.09.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:51:46 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:51:46 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-1-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
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
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++

No need for these to be in header files

