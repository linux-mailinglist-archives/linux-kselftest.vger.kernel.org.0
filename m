Return-Path: <linux-kselftest+bounces-36488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A097AF83D9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B753AC544
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557C2D0C93;
	Thu,  3 Jul 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfDhqPkk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BF2D0C77;
	Thu,  3 Jul 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582792; cv=none; b=Q9ATPtviFBYsw421oo9hWZBMjOGiYnVMvV3MQLf5rlnCJ+cugTGKUTP6+SOR5rsL17kWQsuHtXGz/YUN6cbHh9CuNUB5bZC6mD775SyhaRJ2UBjiBF8q152wIKMK3kqM6tQLpRLDo5WeMghMKU5wBx1YgXyG3T0MN1cfPWPFsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582792; c=relaxed/simple;
	bh=YQ89OCdtlbGh5+E9e/L5GelOcn+S1I4YLQnLaEx1cYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjAKtVlYpb6RpPXkZ3gXAlcx4sSbHmO1YCqz1KSFSb/w4Li5MzGdQ56V5ocxV9W3ShEKs7/BlpBu2VjvDtqH4Cw6+aYFFqTwPR807M+a3TCC7drfWjuR7QL7L0b8fFzG7GmeXZZhx1JYSRqpaAqR+ArV7sigq+e7E6nyxSsHjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfDhqPkk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ce252c3acso2256161fa.1;
        Thu, 03 Jul 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751582789; x=1752187589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ89OCdtlbGh5+E9e/L5GelOcn+S1I4YLQnLaEx1cYY=;
        b=XfDhqPkkP25VOnku3St9rxVzchn3Tr5+C0aH9RpYkAA5V3ZqUBKB7/u9yxc4KFb1rf
         2TXViABUWrFs02FC+XK9oSevXSy3D9qHShIQAa82XT2sqhYfVuKi+zpqkqfTDOLhCmTx
         IX34cgjJ+YlUVap7wWY0LstMuDr02xWQUTHu7ndLEm0uKYZwRPso49A5iW+FNLUAElDt
         SO5WVCNcj63o8z1M/5ODMES1RaMm467y8PMqkCm5UxLBdyt/eXA8S1uOgaT1CYLRsaGf
         WFqBKD7py+yVcBk2sXMu5kvMoSfuO7XfuLFzyWkVgCbM9vLbM7FXpo5tE3ohyRzsywV5
         U9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751582789; x=1752187589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ89OCdtlbGh5+E9e/L5GelOcn+S1I4YLQnLaEx1cYY=;
        b=VEb5Yw3JBjay6KoZaToEtzlCG91Z2P3yfZQZxFWUPlIngRUH8TctnN2zMLcnwP8pu+
         vMYmFJJ1/oyRlZ8FIIQwIeDHAnixjKBbNggbOz59UQ7JmUdLbzn+AQ2qAnMaVKNis18P
         54XYpEYmwOfm1uzQZXlqB1Af6viKDdMmeChyTZwczM4PpcGoUNxrB2D3L2201lM+10tQ
         1+6qvwj9Bq6EEjR3mUb4N5kKmXnmiKWlSJv322mY779g7agmf5sJr1sRfOVY4N6Kb14M
         jOitsObTfe9jkMniACEkNhnXv+pyvgrrOpgd13QK7gPoktH5q5zTHGKcdC6bScFXaz3Q
         Gdfw==
X-Forwarded-Encrypted: i=1; AJvYcCU1HZObTiacQMLNYRKwfKwFgpDJFprmQJK8ZvL4eTXoyuQnQWp5zhhypfrpJLG/p8+UCFam2slzXEKxuYQj@vger.kernel.org, AJvYcCU7Mn/cxKdoOA9f3nn2urxQl4yo8nzolHbPl1SQ1aVLDBZR32ANsqWYiDAwXMnrq1Wq+huf17KC2ng=@vger.kernel.org, AJvYcCUDLMbCjVjYofoHPHTIkrGlxyXNYngmInS5XROqxwCTdZINcYEEYgFe5pd7ehNMPxLLEZJ0shaGBrMjtTgtDpg=@vger.kernel.org, AJvYcCUEMZydo2sWsWhg36WvOuLCmCRCxw/GRwyz/K1FpE7wreEMmQeeyN5fXGiMo2ztdg3kEJww/L6ZRutQ@vger.kernel.org, AJvYcCVMyQYyVT2TQC5WkqpqPS4iefJwxqbeHbI2EZ4hxpNoRNoPlADLk6JEinZ71rRatzK9Lgnea0nr3viJlkJsP9Um@vger.kernel.org, AJvYcCVkMmUHn3xbahXlRQUiBYH85qJlFbyCGoV0s/Ct9bYLXO6Zzf1VPSYjvfGnqKFNn/K4xohO4IQI@vger.kernel.org, AJvYcCX7nkZSm8GeD4C2lCdmwXme22gqwY06AwKbEPkZvuPEvaPiF8Vs0CWB0rxSKKAByi24lcF8aFO2MsN7/Yc=@vger.kernel.org, AJvYcCXLqMKmunCiQEopN1CqEndLYqzwzfgJPBQWfLGEPBDKY/RfSb8NjalHyrF3lIGMSepng/w4qtIIlEMv@vger.kernel.org, AJvYcCXyh0YUPsLu2KZB7JiX7RbJpR6Jw+AKr6znHQ2xRwkj0WezgHnPcYKTduSgULB6cjSnd8ODj8oVH4kE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45c8EOtHbZfCO33l7Y9dYS08ofE0ZVQAqXeYTSP9q1xtAIYTi
	e6imCqE2adhzNTZTn1E4BNQReeBwthU/wp46/leHuqncGprk+1HR8skasFUSYZ9hfmPfe5FtFta
	4JHKYvpphQ2dswFdusTaAPcPZ5LF1/yI=
X-Gm-Gg: ASbGncs/+IiN0PZBAIlVUnQvSh5yqIqi4lCJU02/2yKA1YJT4maatnQPZqROijrfXJ2
	ooGaL8KRa8Rh1rTEunMmOf2R1c5TPCx2gAPiNdXRHxojy0nI1bxWt7YFi9ILvuQ6wcy0+r+ko2y
	fdsP9J9mDbFTBDJwZY7WAkV+xqS1rORHUfqytoLJFE4+WkPWkMOB4WhcsPSGdJwUf7dL25Fr9h3
	8CMXw==
X-Google-Smtp-Source: AGHT+IEl+sPP1B8mCxMl52InEsjqgDrQhGFgZ4gKQQCtMPmYktkmfkeMhqG8tc4KCe8e7E7L2nh/1DkqsMZO1oU3bHY=
X-Received: by 2002:a05:651c:4013:b0:32a:7856:7412 with SMTP id
 38308e7fff4ca-32e5f617942mr529651fa.27.1751582788733; Thu, 03 Jul 2025
 15:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org> <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <34c00dfa-8302-45ee-8d80-58b97a08e52e@lunn.ch> <CANiq72ksOG10vc36UDdBytsM-LT7PdgjcZ9B0dkqSETH6a0ezA@mail.gmail.com>
In-Reply-To: <CANiq72ksOG10vc36UDdBytsM-LT7PdgjcZ9B0dkqSETH6a0ezA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 3 Jul 2025 18:45:52 -0400
X-Gm-Features: Ac12FXzLoSh37LekSqc1NAd_zq6FaEAH_wUVbUZ0bDWsTpL5vqgS5iCX-O9_oZo
Message-ID: <CAJ-ks9mkC3ncTeTiJo54p2nAgoBgTKdRsAwEEwZE2CtwbAS7BA@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Benno Lossin <lossin@kernel.org>, 
	Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 3, 2025 at 11:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > A small patch tends to be more obviously correct than a big patch. The
> > commit message is more focused and helpful because it refers to a
> > small chunk of code. Because the commit message is more focused, it
> > can answer questions reviewers might ask, before they ask them. If i
>
> Yeah, also better for smaller reverts, as well as typically easier to
> backport if needed, etc.

I appreciate that this advice is well-intentioned, thank you. I agree
that all things being equal, small changes are better. In this
particular case, there are specific downsides to splitting for its own
sake which I tried to explain in previous replies: splitting the proc
macro from the rest of the machinery risks forcing a reviewer to
assess a chunk of code without seeing how it is used; in my experience
this limits the scope of the review. Splitting by subsystem has other
downsides, which I attempted to enumerate in my reply to Benno in the
other fork of this discussion (let's discuss those there, please).

There's also a tactical question about splitting by subsystem: are
there any tools that would assist in doing this, or is it a matter of
manually consulting MAINTAINERS to figure out file groupings?

