Return-Path: <linux-kselftest+bounces-21435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159ED9BC3DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7792BB21A3C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B218BC06;
	Tue,  5 Nov 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auM3yz62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4482189F39;
	Tue,  5 Nov 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777400; cv=none; b=ZfVu4g4/mfwZXN6NgEykjEUVwwvMFHYsx8gFSBDusguWP1FXBX+hCsjma/id1O3QgQ8qG8P7bVvDlL/KiJ1LbnhiWEZVGatPfuGuaxRxTy4VnejBVHf5TUMbxtVktLXgoc6Ikid4cdiX3oxjWic63fPHzBaXrtnJCF4E/Im/ZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777400; c=relaxed/simple;
	bh=xy8eP0aKp8aFXIatWV6gD6j0hhk+fBHC4dHMl/3z7JA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ass/xqC12Vp0cv5PMPQlKhAxD+L+tHXYBfF4g6W/zce+n9KJcoTGlyOnTb+XH0YpZKk816OWE2o1nrl/N4jXuYu1f9xH2icPTsmxFtR9lDJ01mZbc87lvP5Dzw1paE61VXeMzq3RGRjHuwiyqKSD71l6kISImLBz6yQQC0O8qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auM3yz62; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so3578302a91.3;
        Mon, 04 Nov 2024 19:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730777398; x=1731382198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoUg/GO9QPX5GyFZfYPI/Khp9nkGOAdmWMa/084j4c8=;
        b=auM3yz62W6KsGW//BwoZiw/svpucplbEy7RacKGM8NBmRl0lEr0iVePYHpQW5bvlr9
         oeLL5Pyc5xK2VocMcX60h3YrsyUbZzJXPRmt5ajJ2Ca7JVpoNn0kTt7FMFNFWqeYp/R/
         LkBr/FyL2FVf1kvpLA/liHuXarsoirn5nMDgiwWQ+8Ts38D1vjpkBfS2o0iHVIa5Kh3k
         VT7QjyFus4d9xvcpBSm3GsDWWNopznn20yevIWoEbBMgLkLKosqTExLsCZ5J3QXJ6toF
         doEV/llNkwzQllj2R83IZSwsDC1EONcHOhuVjhUERUI1B4wzsf/BF9+s0HLZMdRx1j+c
         cmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777398; x=1731382198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoUg/GO9QPX5GyFZfYPI/Khp9nkGOAdmWMa/084j4c8=;
        b=FuZ35u/LnudsDgvSemVifIMsPrQ5wEycV1nMvWFUtorvlUFUWsZfLZ+pqmdxeeYJmU
         b17qrIRrMSkDBzYlKWYW/LjqfngltmWrjItAq3K9hR1Pt9J7L+Mb5w49rJTWO8Ytqpw8
         d+hcFYuEdcqqjdLy/RrUdXu3JKhonuAk5htZdu8DOIPrQm93OXBoJLmaY4ZvKjV3iUHy
         Zba0lpW7GdFJB7xr7/ePXzQbrwscaNfYZ0CEINhpecZIuQiLFnmyBxx2GeD+iI/XOVrd
         0FTzTP9yveIXFAw8qdJy8AI0uFen2t5BErpfFNbcbjpIbgrgqazG5NKNmcmc734RW+zk
         adQw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7td33uHXT2Lug18kO07BmPzygy4RKV2Yh3GpnuyjzFfu29MbjFTW2exb15octKHtx8TwD+xs2VFVhMQG/Bkr@vger.kernel.org, AJvYcCVWdd4UtNNqCtNfr4Zu2gr7vpZ5UmBS6WkEPVvEscpro+l4ewu0BAXETwkRiG5zk8jcFYQw8YRJ@vger.kernel.org, AJvYcCWzoOHh+MKODFFb+uY032LpgwR+TvGPSPbjyNj22RKxZx9VyXSbfED4jl0vx2eWtAJD7dzuZHlcsFvK+gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZ5kb4jo108ZiGmEQ735YckGcnbbvEcLToXZKfvNG/kqYs6++
	oZMU7POA0mhfb6h4lkRFwqaK9nr0r4hBHQQJDhsAhM6MEPaAHWQ=
X-Google-Smtp-Source: AGHT+IEDBwJ8RzygDgb71vQZ5s/ZeolaoIa38xVDK/i+YXy/ZagMbg8uflAtuCr9mrfn1awDM9kjag==
X-Received: by 2002:a17:90a:bc87:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2e92ce32e36mr24870387a91.4.1730777397786;
        Mon, 04 Nov 2024 19:29:57 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e98ca48187sm105107a91.1.2024.11.04.19.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:29:57 -0800 (PST)
Date: Mon, 4 Nov 2024 19:29:56 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 03/12] selftests: ncdevmem: Unify error
 handling
Message-ID: <ZymRNJLLDLCqIYyq@mini-arch>
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-4-sdf@fomichev.me>
 <Zylc1dKzubaa0yWQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zylc1dKzubaa0yWQ@LQ3V64L9R2>

On 11/04, Joe Damato wrote:
> On Mon, Nov 04, 2024 at 10:14:21AM -0800, Stanislav Fomichev wrote:
> > There is a bunch of places where error() calls look out of place.
> > Use the same error(1, errno, ...) pattern everywhere.
> > 
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 3e7ef2eedd60..4733d1a0aab5 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -339,33 +339,33 @@ int do_server(struct memory_buffer *mem)
> >  	server_sin.sin_port = htons(atoi(port));
> >  
> >  	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
> > -	if (socket < 0)
> > -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +	if (ret < 0)
> > +		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> >  
> >  	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
> > -	if (socket < 0)
> > -		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +	if (socket_fd < 0)
> > +		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> >  
> >  	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
> >  			 sizeof(opt));
> >  	if (ret)
> > -		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> > +		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> >  
> >  	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
> >  			 sizeof(opt));
> >  	if (ret)
> > -		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> > +		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
> 
> A minor nit (definitely not worth re-sending for this on its own):
> it might be helpful to add which of the sockopts failed to the error
> message REUSEADDR or REUSEPORT.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Thank you for the review!

I later move these two under enable_reuseaddr and make it even less
debuggable :-( Let me maybe keep the calls to error() inside the
enable_reuseaddr.

