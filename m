Return-Path: <linux-kselftest+bounces-21763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCD9C3992
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D45282401
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129115B96E;
	Mon, 11 Nov 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB8l7NWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F115A85E;
	Mon, 11 Nov 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313038; cv=none; b=QRuc1bd9+Wy5CkpmbudDrB+n87yRcOlbD90pB+IsgFMsnncnpzVMmSBfyPBd4m1WVZLPxP7s3dOZy+kgKJgfE3e/ZlfoIQlNv1us2oZFwTTnb+iJlLxsZAFkD7QdLXWT/RsdgGCGnfFM7rzCDhUk+/RIIqP4Vr/bbREZ6ABduVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313038; c=relaxed/simple;
	bh=2BWxN+hwyN5KZizcGtWosAV8xQPNjgU9ZEDGgW7nESo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5njcHRV0+5ULEvH3r7XAI3oxukTPnjM6j22YHVFu/PWkaH9gZU6MYRX39hFXe+6RkwdCVMn++UzqEUKQ4l6oPWVdbsPVgFs6AJfUVv7FkFM7IME7pVlZE2CgpzVkZzFUx3SJUcigNj3PGYlZ2DW07+mdIIvjq/zk+lAsFZRxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB8l7NWr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d41894a32so2370146f8f.1;
        Mon, 11 Nov 2024 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731313035; x=1731917835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZmC22zmrJiHAdVWtwda1/3MCkytTs/3xbfI6zOdY3g=;
        b=EB8l7NWrxCf/hQwur56gk/ngFTP2XE+secT51qiUBjm17RA3+0ZhTSXH8jVerFTCEz
         EsfqBzKgOBNsLHZmnx07ZOLpolnesxJl+Vqr9JytBlRluxiUtnANaFPDkaB/blgnEBsX
         QdF9UK3vnN26oeCM6LAQNC3ikU6bovUsu30IB9RrtBfKn9NfUTBtlYrePTl+Q6npfWow
         t6TvjMwlEKRre6VuZOBG08iD2Tlfk3lxVCqp/TbML9oHUQr59xzLMsj+sjbN30PtlvtE
         AK8p9xMHI845M1HK4t88xipeag3p+AgCo8DTJv+On+BcEqmwJ4COv1h+YE+bNiRQ/4/3
         OZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731313035; x=1731917835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZmC22zmrJiHAdVWtwda1/3MCkytTs/3xbfI6zOdY3g=;
        b=SAzV4q/ldHLIToXjtztBZ27LjNxDqFgY71weCBKQnjA6R14ifb/mRVpPKdiJ60rKrM
         FK7tcAnlQNY5nj6O54FF26S4kk8/n9IlOxAA9oBRNRdOwHXKJVNhNbeYFMgXyPxqThdp
         B9P/XBjh8hbs+Z77lMSQBOsjzdthvTCtB6nv6URhTBQlKahxr/LwnxvgUcwb0e/swqvQ
         Dkv2Mla4Gn/pGQRoRmHLB4zwXPNRJw9ZQ/1zb0H+geFwtY7axSbrC/rio0SMOorLBM3y
         Eqdwi5u1ifMI344kSoyxnxewwbXUQ6x73uOtNApxQupO2Jz/+p85UIjr3A7CJqbWgQW8
         5fPA==
X-Forwarded-Encrypted: i=1; AJvYcCVKesPusJ96riJVWwwbOO1U6p2YAfTuvzMxDYo8CDHAfRgHM88KysQmmLB4BvH05BV2Cv5bPoGqWcjRQj+OZKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95PS3zDQh2+AK7BKUtvkP6e+YlEAshQU4mbC5sUQotyqsqx+j
	m/zXBJMfaDMOHPCMdH95rq93YgeTkEZ7wJTNWhRm5B4t+34ImvG0byeFadTF3FOF9r9a+bfw/uQ
	WMSRsGAxsmybfXIWeknVS0IjJrMMYLXEv
X-Google-Smtp-Source: AGHT+IFtV/OrXYsNz34By/KajVySu5vTvpGy4UZGV925ACn6DsCOL1B18zwfwwU0WsE85CdxnUPgRu7O/S4hPU6tZkY=
X-Received: by 2002:a05:6000:1acc:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-381f1a6675fmr8154089f8f.3.1731313034538; Mon, 11 Nov 2024
 00:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-9-shaw.leon@gmail.com>
 <20241109170102.05a5c3f7@kernel.org>
In-Reply-To: <20241109170102.05a5c3f7@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 11 Nov 2024 16:16:37 +0800
Message-ID: <CABAhCOS1YocXsCp4CqYc0B3SAUzQnc_Kf=guAA+9c-cLWE_zfg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 8/8] selftests: net: Add two test cases for
 link netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 9:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  7 Nov 2024 21:30:03 +0800 Xiao Liang wrote:
> > +class NSEnter:
> > +    def __init__(self, ns_name):
> > +        self.ns_path =3D f"/run/netns/{ns_name}"
> > +
> > +    def __enter__(self):
> > +        self.saved =3D open("/proc/thread-self/ns/net")
> > +        with open(self.ns_path) as ns_file:
> > +            libc.setns(ns_file.fileno(), 0)
> > +
> > +    def __exit__(self, exc_type, exc_value, traceback):
> > +        libc.setns(self.saved.fileno(), 0)
> > +        self.saved.close()
>
> This is quite nice, why not move it to
> tools/testing/selftests/net/lib/py/netns.py
> so others can use it too

Sure, I will move it to lib.

