Return-Path: <linux-kselftest+bounces-17403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E896F827
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B692FB213C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FB1D2F4F;
	Fri,  6 Sep 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeClO6xR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044D322A;
	Fri,  6 Sep 2024 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636398; cv=none; b=LnWofJZu8fJGT9riAr7VHLxCPxKvn1oEPawivYBzktelm1loBD6Y6j5rJccbfZlF2DzGQ5OvLhReFzBVcEYDTmKC4jKDvFN3PevzqVTygOm7Ctd+HFkM8xmI2qUQs6JlvhAkDL2Q1gVLuUv/OYwP8chWvBd1mbYEEHIAUMGICqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636398; c=relaxed/simple;
	bh=3SqYXY+ttX9zVf2l5mvEVVWweoGMYIlR2Fv7fTMsMW0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qgg7s8N4Sf8EFWITKFmn22j3zLeTqatHw9hVgWNEnomzdG87CYR56MMgNjPdMZHbOBLQ4qgIFhATqateK3Sft55lFEgJIsklzD3i0xLP6WZsfXUsFdq4tZdCA7+omBOrN1RKQBh74TJMEOwh+h8IKA2R6QqEfAu4VsAb6sKKNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeClO6xR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45677965a3cso8092801cf.0;
        Fri, 06 Sep 2024 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636395; x=1726241195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nzvaSWcAbtxqvKF0O7voRzmbalLmJD9rsb8jJ0QDK0=;
        b=QeClO6xRJiXWg7zFWTmQQOV857Ufu8gMrc8VPZhgzTvELuySb/bUFuuYKXQw5mTIV3
         hVhE/vlrYrjthWe86jFALyHXfCfgg+vw70DpLtM0oRXWLN0tcmFDNZzxoNXWc2yn2y/q
         lezhGXg1bY/rpjF6vapKdxnR7Zt4asdoN7paSWhcIGT7pz7eVNJqH//HTW2I6vw7CFTK
         fiHosBInAK254/EkraLxlGFlSEvXEzrr4rXf+2NG5JVCiwxW+ldz9EwpT8XDi9l4nLep
         PR5PMAL9ZxpK21sr0k6CTTlYQU2omChIylme6qmUZtTKgLqe/kpRUFwimPndhd96H74K
         Hebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636395; x=1726241195;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5nzvaSWcAbtxqvKF0O7voRzmbalLmJD9rsb8jJ0QDK0=;
        b=LqPy4+QeOQqdFMrD3ZfIBtSdk0hiZx7kZqH+Qh9fnOo72fkqB97KzvI8SXsi1AwHqR
         2F3qEMzUDbAxUHTV2jiBsd0w1PY8b668rEBC5LU263MyndXzjedGLAG57hwGcyUCdDVk
         NXKVNCrgu7j0bUMydcILH+RfvA6DCQLmRDbvAeFdu0KrZSs/geDJFJ6OUgMb1SBrV8Nb
         G08HwPK3e4DLUD6/Sss0UPkT2ZT34QqN5TCcPd7nYswjW5hRUS+uy8W68lF5GfY2znU1
         tTVTXO/L3RV8E/0BoCCtKOf6IsnvTDbZFp/YSbflsGEaiF4g7FrgC+HwvqNHf36BVDhG
         jH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZsJlKhFb1j9OhpaqgEKNy/SZA6B0ABJNmywg3/Zk1fC1PKoAiwKl4raIm0jeH1PUsGTI0HdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw387qvU5QBN43qRsED9UswQ4BwhiPmcA04pzT/rLbWzkUKFwDl
	+XJGL+NIJX4TDbWUpjReUKYkBL8XRZe+/wwyj3Psn6ADXgB1bBwk
X-Google-Smtp-Source: AGHT+IHVNLgTNOINZS7RppykF6OYjCvNw5LiyvtApGsvHtKz988FR6GHmBclChZ8wl/9ty2gQcu36A==
X-Received: by 2002:ac8:465a:0:b0:456:7fb1:cc60 with SMTP id d75a77b69052e-4567fb1cc93mr276834641cf.0.1725636394966;
        Fri, 06 Sep 2024 08:26:34 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a15441sm16970101cf.19.2024.09.06.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:26:34 -0700 (PDT)
Date: Fri, 06 Sep 2024 11:26:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 willemb@google.com
Cc: linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66db1f2a40965_29a385294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240906095706.77636-1-kerneljasonxing@gmail.com>
References: <20240906095706.77636-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] net-timestamp: correct the use of
 SOF_TIMESTAMPING_RAW_HARDWARE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
> timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
> SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.
> 
> So let us revise the doc here.
> 
> Link: Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch/

nit: duplicate keyword

> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

indeed

> Signed-off-by: Jason Xing <kernelxing@tencent.com>

