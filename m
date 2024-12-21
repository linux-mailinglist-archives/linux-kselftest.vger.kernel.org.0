Return-Path: <linux-kselftest+bounces-23714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BD9F9E4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 05:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEF916B472
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCE1DE2D4;
	Sat, 21 Dec 2024 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9EFj1db"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D6817;
	Sat, 21 Dec 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734756816; cv=none; b=CSvzbOF/7PEFMz+5SkqJ+jUyeV+mM6JFqlUBXf2j3DVqhb/O/BdzkeAIf9EUte3LI+CG7HZIeCgDRBlJOTF77Qr91L1oO3h9kuTa6sHSvm6jSewQWTJ4RvN9wjUsJSOLryW5YLT5N6XokmlTCPa4Z+jLTHZ/4QmW3/5eMev04MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734756816; c=relaxed/simple;
	bh=a6ZvjQA4/kqmDuCOMFGSi2a2T8rwtspvFrFjZAv2Blc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntz/5oVBq82C8uYgU2ABrN2Q5yACv0+J6sxIabWmAc3s2wZ+UyzQnC2GLlBkU47//3B7gVt5RpyWjosx5qj+bdf5/VPtjXqyeWJWdCwrixW97yOlN2F6mwL980Br6k/Q2kjctE854I2p5+XI2r3H+u7VBHB4X8qDlK4xXk8T+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9EFj1db; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216395e151bso17473435ad.0;
        Fri, 20 Dec 2024 20:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734756814; x=1735361614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/akANvp7VhtOPKaDZibMQ+5IWRJH6Tag+KqsgXaV/k=;
        b=e9EFj1dbPeAWcfiuj8WUd3SqcY1tTZcevBbAEmpbZzSkTlyDokUGSgtTWSFjhotUzr
         N2JQRlbZqCkznkFFPlO6/IuQFoM5SIytrXe/iqs31mlUYk77t2F7JunZhgciamDbxII+
         vsEG/98EUN8sD7NNS9laDcj38NMjG5+X8nYa3JzkEQDqfORMJCOTmnlJOlKDY4DZSyby
         t0E9kefaamJ542a78VOsgYncPnj4Q2v650Tt9mmk6nAfeQXvjGJPIYnhr2BrtVCHRCRV
         no7s9e0YZA0SSLNOY8HTugBjjgCcLdk3LqNcJkHDo/V+ToP94jevIoWHPt94ge4wfd1a
         THiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734756814; x=1735361614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/akANvp7VhtOPKaDZibMQ+5IWRJH6Tag+KqsgXaV/k=;
        b=YLP1oznpwlg9GxaQlc2PshjxcRP7MHh3f/8TexW5BcusMSp32F2zKg0Fez09f7CAO5
         bjqnk0ZuHRf3UVffMJ5eBRgpJPxRMWgm8K8E/9HDoKoKvYam+KNYjG1iLPNLAzN5LXjr
         HTPBvLalHh0PQnu7Bean6VTHzVrWmI3WCTThFIhCX5nnqMfz8eZnLODaZN3Eajzq/aGj
         01bJssPC0gIpkVGQZBYpSvAUSWqlykmc4OfOa22yybvuRuZq12Ol0NCwc1yWWmKnSK2o
         C3PmhozuSCzZ9VEDeQ+Hofrqs6KIumGvoliKBlezbTHuqcyhApD3ucI3hzrQbjJCTGQK
         HJcw==
X-Forwarded-Encrypted: i=1; AJvYcCUfT2Bc6WIJYy3Y6MD69NmAFalIR1bL+/6gpUPWMjCVDe6BfgbE3Jdx4RWmORf6YRRB1q5oBH3oJxGZ3Eyy@vger.kernel.org, AJvYcCWcfSzukS8l7njYqSQ604B+Fh6U4ZNnpn1rqX4lcXIoQLZR8jsHvrlFqRolFPSRw6wwIBg=@vger.kernel.org, AJvYcCWhDnJ8P5nSqx5Zi5it7plNDENhSONwrFrqAsfdjfYs3vgVH+4VO4tBvm0EfawxJBVmDG9B84QBule9@vger.kernel.org, AJvYcCXdWp+e1iAjrcw6Tk61Kn5yEXLicCYXFcSiWUm78fg/T6ohyXT56wSLK7eq97szlLPrJvsaeA7D4iNLA8Wk5Ept@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoa5LOnmo8HoyFf59Ai5/pq0lwuQtfPMA0e0DqrX0UUA+BpQj
	YVUSllFeeaQ1GW3UyEjB6sjWNGEBH7pL+hpchDIYDomO0HeSRl0=
X-Gm-Gg: ASbGncv1demMq4Gem57bgHh/nciUmPt0vknBY0dBGZkYJk8OtXeOvtJfJW8jNlLPcIM
	vnM4TX5g37s+4zxoDPYtOujqh5CHHnM3SjWSVCHezODDoEpjDcywVNVyRROG4hZAzm20vdr7Oc3
	y+4mhw9DzeRIcW4G5lZbRquXi7bMsZzMTuzlPuRovQyLhqEtSvVT2bSeDl+x1iUayX5ENVZo2BN
	YpiAu9uYxNL2pcNmTbIQxDsNAhZsXKm4MbFohWpzOXEhhPBzfwgrZ2d
X-Google-Smtp-Source: AGHT+IGefqGwlNhgS844VD5QltPfx06Q1qkLbqdGPbeGj27JsIktfQiNrqJssTxBch8qAGNI9J6jqA==
X-Received: by 2002:a17:903:1c4:b0:215:58be:3349 with SMTP id d9443c01a7336-219e6cf87fbmr80420885ad.14.1734756813706;
        Fri, 20 Dec 2024 20:53:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02888sm37069405ad.261.2024.12.20.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:53:33 -0800 (PST)
Date: Fri, 20 Dec 2024 20:53:32 -0800
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
Subject: Re: [PATCH RFC net-next v1 0/5] Device memory TCP TX
Message-ID: <Z2ZJzAqS7ZrnREuI@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> The TX path had been dropped from the Device Memory TCP patch series
> post RFCv1 [1], to make that series slightly easier to review. This
> series rebases the implementation of the TX path on top of the
> net_iov/netmem framework agreed upon and merged. The motivation for
> the feature is thoroughly described in the docs & cover letter of the
> original proposal, so I don't repeat the lengthy descriptions here, but
> they are available in [1].
> 
> Sending this series as RFC as the winder closure is immenient. I plan on
> reposting as non-RFC once the tree re-opens, addressing any feedback
> I receive in the meantime.

Thank you for squeezing it in before the window closure. I will be off
on Monday-Wednesday, but I'll try to test it on Thursday-Friday.

