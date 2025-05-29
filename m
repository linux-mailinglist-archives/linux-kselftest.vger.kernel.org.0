Return-Path: <linux-kselftest+bounces-34011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA28AC8420
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3161D4A2AFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35A21D5A4;
	Thu, 29 May 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A05dt31G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A312192F4;
	Thu, 29 May 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557333; cv=none; b=NHLAIWCYywP9qMHmI/OnCLP+xgYzBYF8H6PuOnu10/3LjsfRy5SnMduJxrOZ6wA+3455+k9ZsjOvNr82xJr/BJ3aLspSfPoiGbDqKLa50wkPq1ceM8fDTaIvtIXS50QtKlACTgv+h2Ip9GwOahiZ1jqzRSOmjxVtoahSBOBYemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557333; c=relaxed/simple;
	bh=h+uxh98nAg0a8/1S0TuqkdF8yPeO03QyPmf3K/bLIm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajpTsAtsPNY2AJtdnuqYJBouMU1tjYFF0Z7nZR52qLq2j65ti2yDJfDcw6lcj+n5h6O9cGvfWFzKJF2Mi2lD/ACfsz8oo2aiRHo+vy/2SM2JXQ4cRc7ZSCGtS4+WbfGe8IHozTCeyUG/vQvOxkoXcucBvLzNLXpWom10g0OaPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A05dt31G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad51ef2424bso276680566b.0;
        Thu, 29 May 2025 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748557330; x=1749162130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzt/MQxcUpDWFeSkaHOplUQ43G4Uz/X3hb9h5NpZQYg=;
        b=A05dt31GDlBX0sDmmPPAE9pCt8Ybqo2x/WmH1FXtbAAXbdv8JKFFKupv53M4gVzOzB
         PU+Z4p3l5Zt22lQoNbFoa1nLYgUlJu6pQpKCvRvv/dGNl7QQrK6IufVKrSE6njAzPdRH
         MeoJWK8QAh5yj/nrGokqdQsQOFP14/r9B8vyFDt40ZV3A2dOjpyIwTvCcEhaPtOdCREG
         1EVzKNHSx6OGs5ODUqlqyvC7BUntBSfUtgVqjE1NyaLD3Yw3l2B89pYE8jjt1fPDQHRU
         UPY2fUbb4gIkw5BF8ym/X3t4Te2earxc0tLDRLm9c9c/fYuD+CFtJJLrgZHgI5cShSoH
         WVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557330; x=1749162130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzt/MQxcUpDWFeSkaHOplUQ43G4Uz/X3hb9h5NpZQYg=;
        b=rKVZ1dkzmDsL/+6CONyiulF2ncADzMMdAWoklx2ODCjvvqBrpfZrtRBoXi7Lig9mcd
         NoVAJld4NG4Nhem2qTr4+OCQ60Z0Eci3DuTWgYHJ1VjU0TDFS5BteRJCS/FvHkfubD1+
         xT0mBzWle9icUeL4s7N4fpwo22d3V5736i6hM4OfDvq+xPaBk2YZWO3hHU9zWKbcw38n
         kqUTDI5JvOCMsN2JynQdUxwpnyTMmSrhuuwx7nMLu3jSUsI1EqnLuui4CpL/q4bQ+CtJ
         xhrHLZzIKjM+CLeQ2JUHCBC16TskI5VWWruNFz7B3mwP8caG1yp5gUtYc9o70wtUHpHl
         /djQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7thufnnMVZTI3SZC8UhO07FwZaq5ur0ZfDa69IYtRMBdFL4avZqFpxGMjc/JoEba7G12DE0bjNf85uchguRAP@vger.kernel.org, AJvYcCVNWWy5RHm+nyl9ZkTHkIgwLSE08f7aWtH8Zkfkdc5wBkW7/3bsm8dXnKc7mqXGCLiHKj8z8Z9ofjA7MO6XK58=@vger.kernel.org, AJvYcCX2qtKNR1kXgwCJqV2iBj3KkX0aEMduQzv6bNVzJvwmV3UOjduDJvyUv7uBMRuDgo1eqjcUEd31BiOhK3NR@vger.kernel.org, AJvYcCXMWD9Aamrj3SYc6HwaKI/n8KcDbTX45e1vYQIb/MO+pB7uGBYs6kPKfc3hiVSNIlJFg8UTcrQ3ktk3KvQ=@vger.kernel.org, AJvYcCXbT/Z6X0nurt5xF8gPcW9no35lRd2rpJa6C75aSyGuMlvbrttWJItEctPJdoXt7YTVwXN5TiUn@vger.kernel.org, AJvYcCXc+31NpO6bLac2IMIQGcLyruqM/ObzGD4BQCNrUlT+nGI3kjccEW5IjJk4u9ybyDa3S/p+BpIByXKX@vger.kernel.org, AJvYcCXm1tk0mAV7LNe/t3cO1UgP5auAwfsVHEzfciZimnF0ufQ2Cq7562IALzFu3JCkTELC3zYcgF8edYlA@vger.kernel.org
X-Gm-Message-State: AOJu0YyPo9D1MXjvyl8+Nx0FdxQlY1bHStcBcOfxZ4pfdRF0UDFaabvN
	eBDRZzxk09g5rq9R02mGPHfE3uae8qnxl/kGli9zeGvam9AWnd8IBMaEQUaFYEzZMyj51+iJLXD
	PrZRmXLJUcPKa8Ao9Jejsq4IlzHdefH0=
X-Gm-Gg: ASbGncucIkEcy+77Ymr5oSL6pe0s3ep2YouhzJNnmYKpbuZq5xasj9P7UuvHHF451gh
	/yv5ZQbjY7jmXu0GFO8rhzKqn28HBIayJ3eQm1cnwn7ymryzadEfYAjhWNMZJWXKOBhCkmIsQ4q
	xdK/CdEOmdp6kR76GyO8j51jUmQS1do0gpwHOidtYu5Lwb31SWt8dDUxH4+d7IaRYlUA==
X-Google-Smtp-Source: AGHT+IFIWF7by3gTs9nskHKuDrd5DhLirM+9vmkqnyJc8DqSb/t3iOg3xoZJQ/VvsEAFPlJfLOTUIKCA5jn+ma8BioI=
X-Received: by 2002:a17:907:72ca:b0:adb:229a:f8bd with SMTP id
 a640c23a62f3a-adb322fcfebmr110658666b.29.1748557329539; Thu, 29 May 2025
 15:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com> <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
 <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
 <aDbnLzPIGiAZISOq@google.com> <DA7WJYNAN5AI.2HE6B953GR16A@kernel.org>
In-Reply-To: <DA7WJYNAN5AI.2HE6B953GR16A@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 29 May 2025 18:21:33 -0400
X-Gm-Features: AX0GCFuFM8jRq3YcmcHlgxg8fSyonDU9gdfdyymDZiM0nf24_ZjIqY6KX4ZOh1M
Message-ID: <CAJ-ks9nmxdSKtEuzT=yBU-WEuZXBupr5N6tainzrk=w3U_enXw@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:35=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Wed May 28, 2025 at 12:36 PM CEST, Alice Ryhl wrote:
> > On Mon, May 26, 2025 at 06:29:46PM -0400, Tamir Duberstein wrote:
> >> On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.o=
rg> wrote:
> >> >
> >> > On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> >> > > +macro_rules! c_str_avoid_literals {
> >> >
> >> > I don't like this name, how about `concat_to_c_str` or
> >> > `concat_with_nul`?
> >> >
> >> > This macro also is useful from macros that have a normal string lite=
ral,
> >> > but can't turn it into a `c""` one.
> >>
> >> Uh, can you give an example? I'm not attached to the name.
> >
> > I also think it should be renamed. Right now it sounds like it creates =
a
> > c string while avoiding literals in the input ... whatever that means.
>
> Yeah that's a good way to put why the name is weird.
>
> > I like Benno's suggestions, but str_to_cstr! could also work?
>
> Hmm, I think then people won't know that it can also concat? I don't
> think it matters too much, the macro probably won't be used that often
> and if someone needs to use it, they probably wouldn't fine it by name
> alone.

What do you mean by "it can also concat"? This macro by itself doesn't
concat, it takes only a single expr. The example in the docs
illustrates:

    const MY_CSTR: &CStr =3D c_str_avoid_literals!(concat!(...));

I think str_to_cstr is ok - I'll do that in v11.

