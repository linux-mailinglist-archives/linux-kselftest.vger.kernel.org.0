Return-Path: <linux-kselftest+bounces-3553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456F83BC47
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705691C228A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C201B958;
	Thu, 25 Jan 2024 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NleBauai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6C1B951
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172539; cv=none; b=jqto/TuoNGVWn54/lt1JmFddEY/Kgc88gEvGYkmXXb7HwUizqmzFBfGf4ZMDp483lbl/8yRW0OFvROyzOXbvU5gbO6BLUKgNw3nqSFe517ESMn8jcGhtIIFI6IsAOjkZTvJNM1mPUxxUAtqhSfnQ2noDRigQiFPfxEHpS/GjKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172539; c=relaxed/simple;
	bh=ugVRvbXMqaaI04cZgFh3Eflw+q3XhgQV8p/8i4Mur6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2/vACf8Y4IziAlerev5MhxCseAiW1mDp9TpIZODVGag+fGlATJyMz+B6IJXpT2h1ed75I7jYcEef6zGivLVjOOTMTqbTEBsEG965y8ovNCsmCf4pPfP+MguhN2WEprMFSCR9HW9/ZucnUhlgDkDHV6qEF6/zplgjklWp4Wulb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NleBauai; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11597a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706172535; x=1706777335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prP92GbmaxKiGBLaZVvyY/3do2YP+LsQqUWaXmO/hL8=;
        b=NleBauaiYTamzNzcUgclMnqdr/dPtbzwr76WZXTikuIpV46orP0jMA/vHxEUjcuPLW
         ltm+jGvt9yJePRQzwdgJBJOwzNdXam0mXMxaz3aDCnuopGM0aLBpUx1O6RiIn2sNSdGF
         DvMexNEuzVU2Y5VfL2XPWVBM/OV38KaUVsorTJ0T0yNkTseJrNz/xB2PEzehPu5S+SNY
         VMBfHjZMIHsHRZaosl4qfBYLDZmxf5/kyEXwaryMCB1ercjto8jdRqA4Axhvp+PL8N1I
         0KM/5f8q4L0obj3uspTqVPMm9g4bzeJcxHYaxT3dDXDNobeUupk4Z2geULAgLI2btmIp
         kbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172535; x=1706777335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prP92GbmaxKiGBLaZVvyY/3do2YP+LsQqUWaXmO/hL8=;
        b=oNPGE6cilcGAawTMDnJIMWkGK+dKm9TfOGz12dAfg0nP8aogCghEJkUCqSgealLyNO
         I8iYZUWEpayI6AyrNFnuuq3ENRA4cu07rA5zSXtfSEW7Qnxc+7Vgk0ysLu+t3W/YF+du
         s58vrNcbm3cUh2jBTsN/oWvfRwqlUxxVWDmfCH9RgtjYj5I9YE4YA9N7KuhZyGSkPdwB
         jYLSlcOsoFASFRM1PGQofXHEleq3momY/wMDOwO329k4jyvSmFIIaFOTjKQ8j8czLxZ6
         HT2+fE6CszV9THsG0L6HkHVybV93iOTmeztpxGMDJ/kZ5ywFapTA3DM8pjXkmS7wfjh2
         4JtA==
X-Gm-Message-State: AOJu0Yzs7TlS/Z0vvzVxp/zKRfBHt/5guwYRkV4Bm1Wl2DlMvODkmr6c
	Ly32t/IPpSaRcYOsAnsJr2hd9uN2aTRbfS3BrAuu86CtM7IrRGMk8Du3A/Gw+8x+Zj65zC+Krl7
	Ijj5P/r/sn+YNA0Ct6bsfRBq+2Jax0rsT72Gf
X-Google-Smtp-Source: AGHT+IEJS5MJHBuMVjXoGYBdRZxSQCog1ImgX5JUClFp0G1spvHjBWOHdlsQl6HXFAWavxeJgx9lK+EdYZQJ78edRuk=
X-Received: by 2002:a05:6402:1d88:b0:55d:152:7d59 with SMTP id
 dk8-20020a0564021d8800b0055d01527d59mr58730edb.4.1706172535337; Thu, 25 Jan
 2024 00:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
In-Reply-To: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 09:48:41 +0100
Message-ID: <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej enczykowski <maze@google.com>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> the udpgro_fraglist self-test uses the BPF classifiers, but the
> current net self-test configuration does not include it, causing
> CI failures:
>
>  # selftests: net: udpgro_frglist.sh
>  # ipv6
>  # tcp - over veth touching data
>  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>
> Add the missing knob.
>
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-test=
s")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

FYI, while looking at the gro test, I found that using strace was
making it failing as well.

Not sure about this one...

Reviewed-by: Eric Dumazet <edumazet@google.com>

