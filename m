Return-Path: <linux-kselftest+bounces-22641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AB39DF1D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 16:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1471621D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECA1A08C2;
	Sat, 30 Nov 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtzm97FE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317215A868;
	Sat, 30 Nov 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981582; cv=none; b=nhA2yKad/3UIC10ZSnIU85L+j7igsdkRQl5LCvZT+05aC9+xSPeaNjDZwL0ohCRlcyXP0rMH2Z/FC7m9m0/s2VOtCptaik1MiRCnAmUgwbHuh2r7+19qRR1LsXynZmqH0SicIIcwuZ+H8PsXG1e026J73akzAV9Stt8UTNI9mlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981582; c=relaxed/simple;
	bh=x9InXdGmvFA85wG59pkQZoP8WxI0j/CYTcxyfwNcjsQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6dPUO6WanU1q1mJNVc90lGPd2MMdJPvNo1B5wl1NPMW6p65y44nXTXPHF6THr4ViEMywLP8y+8/kFaHxl6ZBxHRWBpHCFNWvSsDt15h9D9S0fYuxXicPH6LXsYK63lUWJlVzJXCmYNVyfwpqpyB2Yhjl7sKA3rKbCVRE62KX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtzm97FE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso25466895e9.3;
        Sat, 30 Nov 2024 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732981579; x=1733586379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6lKD391iHWB7TOTfggVgiiLNoxXl6HnzirFK399CniA=;
        b=Gtzm97FEi2ceZJp+/RNyDS7MOIp/1dLKQMTGPuNPeCc3whXeI1rsBjIrzgEyCx+2TA
         cS78f/iPkKNymf8VpLBBp/0P1U8TQnZTK2nevrEEFsTg6mqyLhr/Qx+IIXaYtJ2Jgdnb
         OzsTlVFfRYBs4a75b4v2eoYdl3ksWWfBdqfjTaiWt6EPk+HTokeVdFafxAuWjLZ1cVbf
         YcjVtO8yKFT7nx1UGKnz7Fc0Pgv/lg5v0KRWyuUgOOOuxxy0bWJiVk45qFyOtNM94kQD
         +CJ/hc3mxCCIr9GLJuBLSmqu62osutISlAPp7RkckcCUSxCq20SpVZKNijbRgBWFuD5D
         fqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732981579; x=1733586379;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lKD391iHWB7TOTfggVgiiLNoxXl6HnzirFK399CniA=;
        b=JANeL6dfmvrA4tEjf09hdsvv0KcwOv3K1cVolCY4FbyEcTI0U2WQb9Qw4PTknvzPk7
         CuLPBijFqMsAsDevrnZeUuRZohWlX+vtEnm6cEE1I18pnA4cAZS5HgO0SVTHf2nk5Grk
         NGNKMDpKf1ajT+uy0rSj+GG7mV3EfU4zo0hBQ3GgLSvNLsBJmER6omPBkyY11dgyyB97
         wf4aOV5kj/h8b6aH7IibSxUO7JNmVTgOcTfjdk4QeDSM4Pm0dw6Y3kIIgWn3SYIF2XYM
         e1sbIKauqttOn2aO0DuFXHxGk0ZKlm4TXkYyKKFDYVURw2NzWYHZ0F8tHYtn57HHs/n+
         9lgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3HZPiAMNluxLlHBWjfTHy7IQspDFVGvVtyASxO5sGtwEC6xSlD8HxTzhF1BmMObUR5XlmW4JN@vger.kernel.org, AJvYcCVzNPxh0OTYs2pVKZlE11LF3PjxWPDOKHZaojMF3Fg3VekF7k+CF9lzegCTm0H6ZM+D2eoSH7n7@vger.kernel.org, AJvYcCW94Ykqe5L3qz5iHybCC8rVLKSbKRysyFWRvK0D42K1JTkkt/NzH1kMSMF6IsU/JPAfICoJ/wc99r2gqlw=@vger.kernel.org, AJvYcCXRdQmTehxv2RGlml+m1MglGq3DtNxEo65P/qi1v6W/EX2vq7lHQhdoATTiSBk8Rgtyed7w37JUoE4lgapz4qqv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2F6Pf5GiIrMOUOeHQjGE7/tptloAP4XvuOqzvFBbS/TaZxA/N
	pnpDRUJqPDpJ9PXpRaiLs1qXBmhfO2quuKcYFl7vtFqe9lvqBASS
X-Gm-Gg: ASbGncuzmaAbdX1xg8sJ9K7k+WME5GmRYF2eKtKYxryIN2OzxddduR8d5tEVfu6glYo
	erD2xBTUnblgfbMIPqjZ01GzLViFUYJEPpn1S8oPUUieGnh4YuPTzGe0Y6faeyJj+pNi1c53hAE
	W2HuJu3ey2DYKcCe1AvwdrNV8M5w1Wkw6S2qqoyb1KpJa1SnuhpYY9Xw9/xLBk1+nNyX0qq5Z19
	pNSUcByATO5s07x7zgNoVE87t8yR5NupbjKb7xQ910UyJyCHAXcGAC0ecg34siJRd1uoAxIXl4l
	v+5M1g==
X-Google-Smtp-Source: AGHT+IEEBbp4nqne2+t3NESzun8xb0ybXJVJbIfDhn+hacab1wCQFETAHtotA+zGWv7y1TYfJ/dg5Q==
X-Received: by 2002:a05:600c:154d:b0:434:a2a6:ed0d with SMTP id 5b1f17b1804b1-434a9e0aaa3mr137130115e9.29.1732981579194;
        Sat, 30 Nov 2024 07:46:19 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a972c33csm99154305e9.1.2024.11.30.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 07:46:18 -0800 (PST)
Message-ID: <674b334a.050a0220.3b307b.ee8b@mx.google.com>
X-Google-Original-Message-ID: <Z0szRv2R9kL50jIg@Ansuel-XPS.>
Date: Sat, 30 Nov 2024 16:46:14 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [net PATCH 1/2] selftests: net: lib: fix broken ping with
 coreutils ping util
References: <20241130113314.6488-1-ansuelsmth@gmail.com>
 <20241130154307.cskk55ecltjkinqz@skbuf>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130154307.cskk55ecltjkinqz@skbuf>

On Sat, Nov 30, 2024 at 05:43:07PM +0200, Vladimir Oltean wrote:
> On Sat, Nov 30, 2024 at 12:33:09PM +0100, Christian Marangi wrote:
> > If the coreutils variant of ping is used instead of the busybox one, the
> > ping_do() command is broken. This comes by the fact that for coreutils
> > ping, the ping IP needs to be the very last elements.
> > 
> > To handle this, reorder the ping args and make $dip last element.
> > 
> > The use of coreutils ping might be useful for case where busybox is not
> > compiled with float interval support and ping command doesn't support
> > 0.1 interval. (in such case a dedicated ping utility is installed
> > instead)
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 73bae6736b6b ("selftests: forwarding: Add initial testing framework")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> 
> Do you mean the other way around? that the busybox ping is the broken one?
> And by coreutils ping, you actually mean iputils ping, right?

Mhh no busybox ping utility is problematic only if FLOAT INTERVAL is not
enabled (aka 0.1 interval are not supported)

Yes I'm referring to iputils ping. With that I notice args are wrongly
parsed... especially with the -c option.

-- 
	Ansuel

