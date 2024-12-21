Return-Path: <linux-kselftest+bounces-23716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC559F9E57
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD116B70A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A0B1DF270;
	Sat, 21 Dec 2024 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPnbmQth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D55154444;
	Sat, 21 Dec 2024 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734757062; cv=none; b=MxTYq5w3TGO6lFFlOCOVmodM2ViVDHtYwpO2/5T+ZhqkVBX1EZHrA5Q0cHYptgCj62uziX+P8VlymkQZpOHrApiox9MM51yYYN/hCyiv6nEL1GcX10n/PE1sPKi2270ovLWWWy+cBFKd7EkXLu5coD4aPgHx6IG1H5EG2I5FdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734757062; c=relaxed/simple;
	bh=1TbBP933VVm6DFt5zwnwojHrXlx9MRKIcAMq2Q24PRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk3yvWep7aviH8RZncOgNWmPs6A9NdmjpTdmyVj8AUI8/OUq13lo5ZQvFh2vpqusSCdvL27y/9T2ddtky/b4jAUjJedp3pN/PQUGrYusZvt+B8h2Yzf1kaynMwDoPGHni5GgbNNy2E7utdkzVlUYlAEIQPWOsQRhRg3pnpDsf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPnbmQth; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so22421505ad.1;
        Fri, 20 Dec 2024 20:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734757060; x=1735361860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqv1ZszYehiDYgEKLjMsBt3fQMyet+8+2qfk3kv/l5s=;
        b=CPnbmQtht3Vvu3As1Vx6FlRGBkm2kprD3DzWU1RLoojXmOnWuHoq6yCtCOU0Ua2EQq
         ZXVAbRsvGKLgoQZdoS2/kIoXkkNuiz82FHqLNUzlWNjDmfYAFMvha9R+UDvbp026swrC
         Fk2hWZrR/YWDiMb5S1l3PeeHBBoE0NCmMXLcdOkfLbbknvUhojANPqklsaaf0MHyVAOs
         HES+swi9lYJwCoyW3+iaBAmOAWANE0LJ9QTYghiZWYtOgcMvHwAgOU7WYsdy4rBssw8+
         HJUkYNPvJQyTLH3DhiVf1GnqVdqffHilfascmo8Qoenm0KWlO2tJrSTFZZkL69HicmUT
         /XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734757060; x=1735361860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqv1ZszYehiDYgEKLjMsBt3fQMyet+8+2qfk3kv/l5s=;
        b=aEZgZoz+rdHLBcpyjSaxD1g4TFVGDpzSaalCJHQDZcTcQ+7gN3Hu/cxhWKL0Vtjz2C
         T0D8njnES+eTqft1tzjSmDlypR7r/yRWamR0P3M04aUOwlYojG1ohie0yvR7Kpj51w+/
         3trDnFWr9BaCIEtcCFeQVuEdGlDuICSGGeSAyLsDYgn83TUNdCPgjjY1HZ56m4/xDce5
         Ogt5plU6qvb+art6NYlG06ccSrChUyue9+5y789LwmczMJXduLjlE2a8HdjzGWOmZdoC
         7pzOF6tq+FcoItmcifCtpjeeN8nDTKFJj73v/tW/9ThBs9BQDwKYtNUYEg2v1ytoV+w5
         suJA==
X-Forwarded-Encrypted: i=1; AJvYcCU9M2xreNkxTHgjzH6hrMIBupvRenDS5sz24Rc6KTDwVawqrNSVHGwLHseUqizl5Cv3qEkRMAmp39Wc@vger.kernel.org, AJvYcCVvhdnHirSAp1WeJAWIkwUli8+y+RJ0HmcpOiv8B8YKoBZ6B4sI44qCteKfM/sEs/pGqHtdumsGRM897Qnx@vger.kernel.org, AJvYcCW5M0ACqLYfIXrWGaWi7ACCnKMazlQxhCne3WqznwtK3Wv/XSFPyNSCOjd27N0e9E2N4l4=@vger.kernel.org, AJvYcCXMb5w8LzWci2UNXrbb8uiY1o9SKUbDuWHKx/5Xq+OgiZCqpch4CLhP26WjYNtLGpXMGaVd4MLVYN0qsbPKdqpd@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrQhq4zJ0sN+yyUYenr8DzTvnx/6O7ZGXZk6mGWiNM2DIh5BQ
	skwgR5cUXwj2IXWkzgAjwleuenUjXqaBBcrYPvm79h+VlW381pM=
X-Gm-Gg: ASbGncu8z8kgdMO3trUvBjw0ouXcvCLF0vGv61z7w+pAWdfti5NRQXGXDeuRje4ZLpA
	hA0oSjw7ZTqDlY8YhJuRo3SeUKdn+GAoUX/BzbmA4dsJKtJeiPGMxLGvgaI+iO0Z1HYI7p2if/C
	c44o8TB4EsaEcr3ZH33/PtrV2KBKfeNcZrJVd0DjDp1T8yq1SpwwqqiEcnZbze1uzcYjQpb7nX9
	fnBqxZkIhg0cLp+g3bOjTjJ46BrakIdBL13RhodS8O8Z4xq08zD/vVU
X-Google-Smtp-Source: AGHT+IG6FSPopi6xlzdqkbYcTmn3BmRFpq5te9eTJ720B4DBzo4y3NotsWuyWaPDlRJsgb5CqmCuag==
X-Received: by 2002:a17:903:94d:b0:216:46f4:7e30 with SMTP id d9443c01a7336-219e6f11764mr84025545ad.43.1734757060132;
        Fri, 20 Dec 2024 20:57:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e76fsm37133515ad.65.2024.12.20.20.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:57:39 -0800 (PST)
Date: Fri, 20 Dec 2024 20:57:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement
 devmem TCP TX
Message-ID: <Z2ZKw-k133QxigOx@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-3-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.

Do you plan to include python part for the non-rfc series [1]? Or should
I follow up separately?

1: https://github.com/fomichev/linux/commit/df5ef094db57f6c49603e6be5730782e379dd237

