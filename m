Return-Path: <linux-kselftest+bounces-21664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21E9C19C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D001F22F31
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437621E130B;
	Fri,  8 Nov 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCOyuUSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27D1DACA1;
	Fri,  8 Nov 2024 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060307; cv=none; b=vCN/06NnKWYnJVL3bdXJA7cvvjLOBvh85W0dW6ueK852RYykyjJVjnVmp45RMGUOFTvhaQO82MHkaKynjjzh3tn2fAWujWk0IVdkEClaoMFoBP8Kt9SLPLBpvyX7mGhiEo2ZWGLiA9c2zsw3SGaFIWvYkP9NL2yTAY234TYXwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060307; c=relaxed/simple;
	bh=kOc9yUGznIb1qrqKk3pTDsR2QqT/9CMCrFMGkEQRBMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVR7G1LaCls60dD14hKKF3qyivXouttzemcIJ1qdXfh9InhWEhMnd462BPF1qQprXRPt+Hpiwvlvres79atB9ABR5t+kAK4dTMTDndu6/8mdlaBaLpxI78Lw39bhPapDbmBmeMcXHN+LZzQDw/Sso3EUlke1qUdHV4STByf69BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCOyuUSV; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e602994635so1406286b6e.0;
        Fri, 08 Nov 2024 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731060304; x=1731665104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOc9yUGznIb1qrqKk3pTDsR2QqT/9CMCrFMGkEQRBMU=;
        b=BCOyuUSVZ3gaObhrlMfbxZhxwyKasorj1iZApiMOd63whsqrYshbSc7A0v5SQFmaHG
         7XvTuKPlVzuNvwwXlIo78dvaLercJnkRJQtxwmHk372HR6WNi4M2XvNQI1Q2tMX1Ncxo
         Hq7UteFkELZ/TtSwF7ifqHPoQR4uT421aWgjWEh/TmHhQXTGpgd0jxMucAD7r2SNgnzb
         t8QfamMPsiWY9y1Hwdy4oG8YNj2Oq7zZM8QDRThpOyPb+rb+4IBbxzwsynMsWQNQ4cJT
         SZ3DdGdRvLPI1Izf39EJC0rKsqW/CyMzSZBzF+xD0hKjlnlq4n+PbzqShHP/D7m9k6g8
         kx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060304; x=1731665104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOc9yUGznIb1qrqKk3pTDsR2QqT/9CMCrFMGkEQRBMU=;
        b=HCJVnEBhiXyP4Ze8bOxzq3G8yM73P8TcGhIJWvyqEF++ndVNBblnhNYRVISA0IO5Qz
         2icysFMOwVm3QIXsXVzvty0KVAG7Z57hSLYz0B+YOIqq6L/5g1lQQ4/97c0lrKWPLB0H
         +Ngj9B0h64JsAB9aTcaEDYNEnPOFs7MiO62MPKthfV3u6/QsTGQLjeoSSm48NJMMXput
         qt3gv8im6aGal47qg5KB1FK+HJFsphzkfTvpAq9iC0iPifwx/rR1VhdSmZA/AN/1GuHW
         v2BKR1ZRpFSX0ouEWfHqrAMAnYcg/3ArZjDYF/Ol+Yfe4MGpMsBTeXHIKghHxeco+GEl
         NBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUA6UBh/B8Ovt4ULgBDS8z45inXAzkXwBEyhx513k8X5xN7L17h94VsUkZZmaOKgjDE3C3dJQ/JrnWob9h1EsQ=@vger.kernel.org, AJvYcCXO0Fop2v3Z35hnU0+9/9IDR5CWeKR0fmzLx++DU49xUkD/pZgp2Ykid1LmmI5LMyiYpm34+7nt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx72fcagO5Kn2L9sCAxFcQ4v1KA5stfS3YnGTcliHKm4uZqqG0
	TaQoSYRxT0XF1yG3Nw7Iz4YerXYGtUHXvKjMOz6iKEoRZMx0PfqChit79WU6oPCbzd+pZZPFmmr
	vn/2gFEM6ASNz1OCTfmNbnK3tn3s=
X-Google-Smtp-Source: AGHT+IEBMZnlah/bbgec1wFpK6gV3dfc27LhLyONeUc0Upa3yapPbjlADYZoj27FRpdXMdMy2WO90g1EuHcUbutlaNA=
X-Received: by 2002:a05:6808:23cb:b0:3e6:2620:2000 with SMTP id
 5614622812f47-3e7946ebccdmr2319155b6e.35.1731060303966; Fri, 08 Nov 2024
 02:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-8-shaw.leon@gmail.com>
 <20241107080420.6a5a5243@kernel.org> <CAD4GDZwOzLQd+FYd0AHr5AUcANWkf731Jgu6aeyix8EjRGXRag@mail.gmail.com>
 <CABAhCOSvo4OemcevEnNmk3Jny_YEoCb3s9GPC6o217oj-t5FnQ@mail.gmail.com>
In-Reply-To: <CABAhCOSvo4OemcevEnNmk3Jny_YEoCb3s9GPC6o217oj-t5FnQ@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 8 Nov 2024 10:04:52 +0000
Message-ID: <CAD4GDZx2hEjJWJknS+x++dwPE_UYGiCTYxj2Ntt6BaS=UGZqyA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for async notification
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Nov 2024 at 08:46, Xiao Liang <shaw.leon@gmail.com> wrote:
>
> On Fri, Nov 8, 2024 at 1:16=E2=80=AFAM Donald Hunter <donald.hunter@gmail=
.com> wrote:
> >
> > It's then a question of whether we need the repeat logic in poll_ntf()
> > because it's always possible to use check_ntf() in your own repeat
> > logic. Either way, I'd prefer not to call the parameter "max_retries"
> > because semantically I don't think we are retrying - it is a count of
> > how many times to repeat the poll. Thoughts? Should it be a "duration"
> > parameter?
>
> Yes, a "duration" is better. The meaning of "retry" or "count" is not cle=
ar.
> The original check_ntf() is good enough for the test case in this
> series. Could you make the change, or do you prefer me to submit
> another patch?

I'm happy to make the change.

I have prepared a patch which reverts most of 1bf70e6c3a53 and
introduces poll_ntf(interval, duration).

Jakub, is it okay to submit this as a single patch, or would you
prefer me to actually revert 1bf70e6c3a53? (there's about 5 lines
retained from the original patch).

