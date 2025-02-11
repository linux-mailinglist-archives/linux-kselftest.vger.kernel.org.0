Return-Path: <linux-kselftest+bounces-26372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76837A30FE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A4218869A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11167253329;
	Tue, 11 Feb 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlVNSFh6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEE1D54FE;
	Tue, 11 Feb 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287992; cv=none; b=OOiS7ZGDwDKZ5mXg576YjoxYQHMNEULy0hX9K1/1fi2Ah3t4CM/7AH2Wa7lMmOedqUXZroqAly2fgRgDWYEEOK/YfRKJ5TjDAqrgnXR0m4wZzALZJqHsNG4uBVCSH6STMOily2kI3lg28nKqrrXHpsGd6ourSKMqMuCb8PwKgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287992; c=relaxed/simple;
	bh=YNGkFnlzlwRtOdRnAVLsZY3LGyByKbmeHBrMNsgvNSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUH4JRmaU+09GW0mJpE6dMYFM9cyzjNwiez0jXfuhM7RjQUwYaxTQMnhI7utr068sVJcPwHo00Zy75GmD+BPgkNaFw8XevSIfdiQpZB2pLOtWYVk2+ecWw+lXOZQVOcJaS8FO7mStHcuBSkOwsGIFaIAci681ilQON4cqrF0F00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlVNSFh6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307c13298eeso58043191fa.0;
        Tue, 11 Feb 2025 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739287988; x=1739892788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNGkFnlzlwRtOdRnAVLsZY3LGyByKbmeHBrMNsgvNSM=;
        b=MlVNSFh6IfmDF5/f3CljA3KzYxPKp7IxyvFSMsM/RPDrxMyuHRcgZKXfj1Onpn+/RE
         Y3QpXZzpn3ZhrZphV7cNKEjWRi2nDyRE6gAOXHJhWSwa06WnAsuliuRpt/PNALpjwTgS
         w5fg8riabD2UCOXyQh/dCE1DYEhmDgFKmGk7k+YExyDjnPW7DhEP+Ni7j9DF8F6++4Lw
         B2boOzdIpTwgo/KqA0UTiJtV8p3pUY4/CH1wDPfs+gskSg5JhZZRNKjizA05zvS6DEGX
         Uz3q2c8x5vkTXBR/jlnrrB4hP9FMaMqSYhGSe5yqGAhQdNDKEO8IfBZ3+8Yjvf/9YFug
         PX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287988; x=1739892788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNGkFnlzlwRtOdRnAVLsZY3LGyByKbmeHBrMNsgvNSM=;
        b=DH/CvKD54asRg4wp9ZGPZn15wyH7G4pOHhiiaHdPrshx0aTzW/ykvWGl01aC/Z6jTd
         FdIf0n/pZCfCH7slzrLyOEkvd7NCdkZRp5B4kceQHdm3RV8fjakLqcuqLCIokRyRsUBZ
         kPn+M5RTJ68yMvgmrMKG9p7Kq3h+T7W0ITMglkWNVYJN0yEOi7LaRmNpfimcWKcGycRR
         gExj9WEp8cyoKxuLQoRQP2juOI3wlXLXpGKabeAIcegCD+hNuzwc0ZJN0GaKGTAFL40M
         teSeOh0KXJ9eThahPOIHGHPNAX0U7ozm4tm36Nja7lCzNTfVdrANHi5M6kL8i+kY5DM/
         UWYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+UaSh2ftfFefr+EwvLP9/N5QHFFKilT1IxRs6jSdhYKveG+o9WmAH/yHn20RbOcXr8NijzH3p@vger.kernel.org, AJvYcCX/MiSlqjf4485vDaeAeynIdHAe6cM+RmpGyOkTOFnaZ27X+zSYkZmhe2gAfOi4P6IWYdQQKoBEsiNybAw=@vger.kernel.org, AJvYcCX4D5zXbbBgVaEm1XpetNgbGM5Li4YGDbAhi16ZB+CmGruVlLcURFhDguXBodmKqEUZnSsWGWKFMG6zATbF6/Bk@vger.kernel.org
X-Gm-Message-State: AOJu0YzVS8jzbI89pSTuE7l0NGx2LnXbnx3uU10xVqEjZ3kut+xvw4Xc
	QZcHx5hjanBmHmoltoZp/XmYjEcpuxZqDJlWOFttD7oIlYIw+qXW1IlEWRG0JHozZKpSMkUDPzi
	roRQrHldX5fOt6gHBObGjO6XLakY=
X-Gm-Gg: ASbGncuycxRjLOinpArSeg4wC8jpTDCd4VtvE+LfCCXUDA4GHGlIWpHIdlt75OtLim2
	Kv4gqdEi1qKupwvV3csV9J5McyKXOijt11GF/HfIP7GQQO/e7J20zXYzV7HeDxrS/SHEvAh7rcr
	QKYDTDdFJWkA5w
X-Google-Smtp-Source: AGHT+IEJIadN2vcB3Csnlfq1Mk6E54+R37oXLjSd4XLWNMgXv60YKkYbgT6YQjGh9tMenLxjvbqCI+Hb1rXcI8wrbGM=
X-Received: by 2002:a2e:a80e:0:b0:308:eabd:297b with SMTP id
 38308e7fff4ca-308f910bd38mr13409571fa.4.1739287988170; Tue, 11 Feb 2025
 07:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com> <20250211144744.GA1615191@kernel.org>
In-Reply-To: <20250211144744.GA1615191@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:32:31 -0500
X-Gm-Features: AWEUYZkWF6fllMbg1VhwNw-lz_6L-I85jBsAu5kQqPz4yDcgkWQy-hEBswDaQoU
Message-ID: <CAJ-ks9mpqHc_m1VCiBkjgONjJGUVJRWqKUQziA1STfOvUFTqjQ@mail.gmail.com>
Subject: Re: [PATCH] blackhole_dev: convert self-test to KUnit
To: Simon Horman <horms@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 9:47=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Feb 07, 2025 at 06:38:41PM -0500, Tamir Duberstein wrote:
> > Convert this very simple smoke test to a KUnit test.
>
> Hi Tamir,
>
> I think some text explaining why this change is being made is
> warranted here.

Hi Simon, I think that would be stating KUnit's raison d'etre? I
followed Kees' lead as seen in
https://lore.kernel.org/all/20240612195921.2685842-2-kees@kernel.org/.

In this case we saw the benefit right away: kernel test robot
immediately spotted and reported a bug which I fixed in v2:
https://lore.kernel.org/all/20250208-blackholedev-kunit-convert-v2-1-182db9=
bd56ec@gmail.com/.
Weirdly this message is absent from lore, but should be in your inbox
(and my reply to it *is* present on lore).

> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > I tested this using:
> >
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1=
 --kconfig_add CONFIG_NET=3Dy blackholedev
>
> ...

