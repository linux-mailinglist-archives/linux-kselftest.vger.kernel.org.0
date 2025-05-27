Return-Path: <linux-kselftest+bounces-33867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A115AC5170
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7FD3A18DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261B279919;
	Tue, 27 May 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhAw9Kqr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F42798E6;
	Tue, 27 May 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357871; cv=none; b=bqyuucQ06WB3oZEjNTS3pM3BqhhfPaionBMD2mlXlIPKcjPPYpUQpX3JmnOfyXk54tZbMhpHhWGU+vXHBujfANo9vhjHsIQd83Y/IBC1W2HORveumxpepH2YAvFAS1suC6XD3cOh2HmYH8um+PhcGVKbMrRdzNzPu8/s6yTbmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357871; c=relaxed/simple;
	bh=si/3D/lqAp5z97oyh3H7Ttrei9OF36F1phtFBwnKSQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpRpsKGhmhqQjAaLxArtw/0F+POVcK/beT4BmGqyiIr+8bAY2n/+c0GZQJM6qjzbaknppD63WQlApVxV8AWY4CicwYzlNJZcNL6GHSyM5Q9KD+gRyldKkg1GZKrDtXfdbK4FaXJPYMHMhrXESQ3a8kSyTzA7kXvJvE/n0O3w06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhAw9Kqr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30f30200b51so36628581fa.3;
        Tue, 27 May 2025 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748357868; x=1748962668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNE3eNQigcgAPplki00LvwTSib7PfNi6+3iBJNr9+88=;
        b=fhAw9Kqr7Zb/809HyPBiQNKjRIKXzu0HwWwyhYLtt98exSLsMpzdXm+fiFWgYHR2Aj
         AjJg4Wgd4hjKMukqVAnmtvfsYZA1DN/YhBgTB222JylLvgfRAM2gcAV87f4W2XDZg58/
         RDo2U+HVo+WWLujhQ8ssw5KDYA6dtO4tulg7t1RjoJmZzZY1xly+k996XERpo4dI/lbv
         gLCK5AAyaB8xRVGQXkMJonUVKKZi9cvpq3mYU8dpBiBdeoySddI6BNcjagXY7OOugUvj
         JyYRtUP+ojpyw2LkGklM0rdqdToblJKT+qFHUwx/2uKHFne+zUI2JzpYKDS3Qck2hWQC
         +cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357868; x=1748962668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNE3eNQigcgAPplki00LvwTSib7PfNi6+3iBJNr9+88=;
        b=w8tWlA6LBXg5f3uzmWEDjwYQ3Rr8U1JNHaheFQwUVbeTeul8grWA5NfbPrYz2y2yz7
         PRyF6NI0BSvR0gE3fviGxzTrpuHTlyfElWoY25pIc7ZobyValFMt4xlmwsIYrooYyvxX
         yqubnTVnBcnzQq6pdM0MdvvNIU0gyRdBBnwbcszDm5L6DTmvHqcmh6SkC6Tw7b8lfayZ
         MLvv3LI9CqexbX2ciaGwMGUbJE0Rz2KtzDFFdcn1HGfsv83R5nFph6PGVG3uE52+L5NT
         SRp0IFDs1+iKAnMmCY0aQAPgrAMllwvJ/gO7HeP0VJEOXvDTA/NAAR41N1PbKiSixpsD
         0z0g==
X-Forwarded-Encrypted: i=1; AJvYcCUNAfzms8ShxzK8AprRSOIWxWaFFwdFwya0rLrBPdTFfkczLP2Fm5O0Y+9vFQElU9WrZy8rWfrL8tstXcQ=@vger.kernel.org, AJvYcCV4VuLf3CGUzY0qTtWYkqU4ujymEt0TQ0hV62hdUS/maWv3Fm3zdHgjNZFTao9/Gz+UBmj9voxbBZ0M@vger.kernel.org, AJvYcCVO2Pq4WGiTgdCRKSuyb2bYOqThS95PreUPZiuTLzEdj36mYt+mE0SWuh741j6mJKxmEpRBZoRHAtKUSRjC@vger.kernel.org, AJvYcCWCftjuKhBxAh1+o+DE0TGXw/WPlwKHrqgOQWDEWQKj8wnXNKQnRc9emvV0P5kcBh4J29Rxcr+F@vger.kernel.org, AJvYcCWHpJFsRqU7ha4pNDnFPP7WIINau4XHyx/FB2B7TYWij53uirMS5Y3WeKGmf9PBG/3o8h0AKAMj+K4x8kqvLtg=@vger.kernel.org, AJvYcCWfOZRnZk7cg6GPd4TcY0Cm31D6GPnt9OEkyorqo9LS4AaN2KKLG2eoxRIaMIVxrXaXf9oyp3hxh5AZ5unr7EGD@vger.kernel.org, AJvYcCX2wqzDGcLBnHLPfhPdVwX4d+TP8Or33havnSaDCePx6v9WH6Xfq5dmV9g1tvJXKvmEUfHeiq6HeObD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LYTwl5CyyMfPYxh99YwFTU+uINXZ9k/A8+SlzoADFxUg0Sdd
	A5DdEfq0wmK6njqhsm6CNKqRx6FHmNyctHQgGqkxEc4KJggF0Idm+4ziW2BoOC4DItw4ev3T4rp
	sQDIC97TO09Akva7p0O0c/Q4dt9hPC6A=
X-Gm-Gg: ASbGncuxt4TNLbesUhcDviTqFRFg21sp379DQvM7Vn0XGWydTiUBCFXlCjTpR21LGkY
	uSiNcLFo4QNNztG63iC2nbz4BUNBmTMFQiyfk+376EuMktoYXaZHBFoC45700Qu5uMrD7JoE0BF
	SyeeqC8+JEtq7PPt5NxXldMAjm+hd90cZCUbvbwFbAFi2/HYEx
X-Google-Smtp-Source: AGHT+IGMpsgNs0H0v36WCubbxlinvgNLfiVk9IX6EmewrCYJWnUCTsflWg1QTkNc19iE0AzQz3ot/ZAJjdnwjF/SkXc=
X-Received: by 2002:a2e:8a93:0:b0:32a:604c:504e with SMTP id
 38308e7fff4ca-32a604c5122mr6252591fa.38.1748357867433; Tue, 27 May 2025
 07:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com> <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
 <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com> <CAH5fLgiUhvp9P7oSf4Rtv5jK1SNebW9-r5YFHVzCZjEwaR=Mjg@mail.gmail.com>
In-Reply-To: <CAH5fLgiUhvp9P7oSf4Rtv5jK1SNebW9-r5YFHVzCZjEwaR=Mjg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 May 2025 10:57:11 -0400
X-Gm-Features: AX0GCFv2oY8lzrXQtwfj6_dQyq0RFoGjtHhR6-NzX_hnZZ_7RGNdHOXxleigo1M
Message-ID: <CAJ-ks9=prR2TNFhqip8MsjtTWKkoUhoMG75v2mSLF1UaRNwJLg@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Rostecki <vadorovsky@protonmail.com>, 
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

On Tue, May 27, 2025 at 8:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, May 27, 2025 at 12:18=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> > > > +}
> > > > +
> > > > +fn make_ident<'a, T: IntoIterator<Item =3D &'a str>>(
> > > > +    span: Span,
> > > > +    names: T,
> > > > +) -> impl Iterator<Item =3D TokenTree> + use<'a, T> {
> > > > +    names.into_iter().flat_map(move |name| {
> > > > +        [
> > > > +            TokenTree::Punct(Punct::new(':', Spacing::Joint)),
> > > > +            TokenTree::Punct(Punct::new(':', Spacing::Alone)),
> > > > +            TokenTree::Ident(Ident::new(name, span)),
> > > > +        ]
> > > > +    })
> > > > +}
> > > > diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> > > > index d31e50c446b0..fa956eaa3ba7 100644
> > > > --- a/rust/macros/lib.rs
> > > > +++ b/rust/macros/lib.rs
> > > > @@ -10,6 +10,7 @@
> > > >  mod quote;
> > > >  mod concat_idents;
> > > >  mod export;
> > > > +mod fmt;
> > > >  mod helpers;
> > > >  mod kunit;
> > > >  mod module;
> > > > @@ -196,6 +197,24 @@ pub fn export(attr: TokenStream, ts: TokenStre=
am) -> TokenStream {
> > > >      export::export(attr, ts)
> > > >  }
> > > >
> > > > +/// Like [`core::format_args!`], but automatically wraps arguments=
 in [`kernel::fmt::Adapter`].
> > > > +///
> > > > +/// This macro allows generating `core::fmt::Arguments` while ensu=
ring that each argument is wrapped
> > > > +/// with `::kernel::fmt::Adapter`, which customizes formatting beh=
avior for kernel logging.
> > > > +///
> > > > +/// Named arguments used in the format string (e.g. `{foo}`) are d=
etected and resolved from local
> > > > +/// bindings. All positional and named arguments are automatically=
 wrapped.
> > > > +///
> > > > +/// This macro is an implementation detail of other kernel logging=
 macros like [`pr_info!`] and
> > > > +/// should not typically be used directly.
> > > > +///
> > > > +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
> > > > +/// [`pr_info!`]: ../kernel/macro.pr_info.html
> > > > +#[proc_macro]
> > > > +pub fn fmt(input: TokenStream) -> TokenStream {
> > >
> > > I'm wondering if we should name this `format_args` instead in order t=
o
> > > better communicate that it's a replacement for `core::format_args!`.
> >
> > Unfortunately that introduces ambiguity in cases where
> > kernel::prelude::* is imported because core::format_args is in core's
> > prelude.
>
> I'm pretty sure that glob imports are higher priority than the core
> prelude? Or is this because there are macros that now incorrectly use
> kernel::prelude::format_args when they should use the one from core?

compiler says no, e.g.:

error[E0659]: `format_args` is ambiguous
    --> rust/doctests_kernel_generated.rs:8783:25
     |
8783 |     kernel::kunit::info(format_args!("    #
rust_doctest_kernel_workqueue_rs_3.location:
rust/kernel/workqueue.rs:77\n"));
     |                         ^^^^^^^^^^^ ambiguous name
     |
     =3D note: ambiguous because of a conflict between a name from a
glob import and an outer scope during import or macro resolution
     =3D note: `format_args` could refer to a macro from prelude
note: `format_args` could also refer to the macro imported here
    --> rust/doctests_kernel_generated.rs:8772:9
     |
8772 |     use kernel::prelude::*;
     |         ^^^^^^^^^^^^^^^^^^
     =3D help: consider adding an explicit import of `format_args` to disam=
biguate

