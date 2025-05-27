Return-Path: <linux-kselftest+bounces-33854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB591AC4ED6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252FD3BF26B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172526FDB3;
	Tue, 27 May 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcvoRoLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2D26A0F4
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349886; cv=none; b=ja2xUiHUJZC65yhL+lza2vFAY/dRz5bQnkEcYtOhPDLj9v8wzaAuI5Iv9vC+PNVlPNgjaSPcg0vo5t4sgGQ8huG+pcyYmgt/Eh05OcJKCxlcmcCps4rrJeV1PB6eFB06BoPK9v5psgcu5v62OkJQS8117DB3Z/ez3ICwrgJciCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349886; c=relaxed/simple;
	bh=10pm6SoapnDJvi5UUh+zwz2m9mE3i07P8POT8yLYzj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onechj8AIc5NFQjBC0Duu+Uzk3ihXxCGakpf4NnF3CO+g1zIUup4xpnlSq/vX692ZRzR+7qOpsp8zarLeXYB7lcKM6LIRxxorIc0kHQg15t0cR6dxTPfb3LPBGa7cyKAsqGeAkXRVZW1fKvhVZUIFO1aCeiajRW1cKXGntXbC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcvoRoLc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so22649925e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748349881; x=1748954681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+1ORexpCal/yWarvUklj5P7KVERu3osu4+FfJ0CMj4=;
        b=XcvoRoLcCtVUPvy65xJfk1KQG529kbbSSLET2kD3LxtcR1OWq+EO0wGuefGCcCSZvP
         BNkVRWIgQQi+aqSu2GroQ3HnyNVDr1o5sT8K4drSuez10Cp+jklozf+9UWipo21l4irS
         Ma2BNmBAcmiDt8Ogc8QFesXS+QX9MIPRtHNZEjrSVXNv1tRyFSsKH1Pt/Djwpyb9QrDc
         CH0JPjnO8SiZcbllaKVbeQomjd67TgzU8YWdlEtHrWAw7lLMgGJaaHXmMD2SxiiaofTx
         1psySLAkisHF3Bk1w1auUZvbfqPsPNDbLWPepopvnenbtJNSBxFfDM/t5s4JEffG/ORa
         2z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748349881; x=1748954681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+1ORexpCal/yWarvUklj5P7KVERu3osu4+FfJ0CMj4=;
        b=vVzpR+xXsfbAwXhFpe8tbKU18q6G/EbuKVQWUjofE52uzDxH1mNtyZMQzpnMPjI389
         HJJXRUFYVJ5YQzcKBplZU6oimPbZt9GZQLVVNeUg4553cDWSYCXKWReI5c/0Sm8D30gx
         YYAh4Z4Bh8/I/tkXsnJu9whEDW9REZTvCEIXFzRIREvU15utxBY46lYFYrcRG3bOcJza
         YGeZG46wbvfbsbTyK49FQ2SziWCOhEgtMZyFOmj/vMcNa4FC9nsi3Hq1n3X1QMfP9W8H
         iMF50fdHAyriheMIhdLP21yL0pm4Cp2gN8b0FoCbpZlrsL8hN7fkwMFo/qZvB+jMDeRf
         EegQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6QOcVl4ka6g5veyYZMONe5Grbp6YGc2qOB6ady7fBs2PlUh35RjTKKckTcFjv7nUpkMBY2F8bWVI9VITQPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiul45/T2ggPV8lY5XyU7UnCSz2i12X3t9Y4KAhXrYcB5SC6Ki
	x0s4S1UA3TgURodgdQki611Mll7ZK5WOMBhupeWw9XM6vsHwr7iYy4vltVyoqW/2MYO9abgnnnb
	iU9hEHNuh8X6U6pZOZqFBnh7t2UXNx6LhjXRJpMqa
X-Gm-Gg: ASbGnctZ0PnboPNDxo6114Ir1o0WCXIi06coV2KeZYJ89xpqKz7dvWfKodJcS+WxNUu
	CO2cZMrzRcZhsV8DgHo/JQqMprLKYrzml/SVmAgEs4wYLbAhqvvevHXhnLiS8571ar5dbUXicv0
	1+DAs1XjRE23i7NDsVbekoZhlAczhEfmUvvzenq0khYsiJNElnEFqviM+OK+quk8jWrprIQXha
X-Google-Smtp-Source: AGHT+IEky1d5meo1qHzcDPYMKOo6itgabi6xnmNH55BIUhfTHja5jzKInw1nb+GfsRVDFZjoQp10Sz6+0092+zxkyU8=
X-Received: by 2002:a05:600c:54cc:b0:442:ea3b:9d72 with SMTP id
 5b1f17b1804b1-44fd1a229demr3814135e9.5.1748349881244; Tue, 27 May 2025
 05:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com> <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
 <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>
In-Reply-To: <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 May 2025 14:44:27 +0200
X-Gm-Features: AX0GCFs41915HXTpfqcCKH3n_1X5KqqnwxYwkDK8S1yQqomTcDJwCXbrNKkuqdo
Message-ID: <CAH5fLgiUhvp9P7oSf4Rtv5jK1SNebW9-r5YFHVzCZjEwaR=Mjg@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
To: Tamir Duberstein <tamird@gmail.com>
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

On Tue, May 27, 2025 at 12:18=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
> > > +}
> > > +
> > > +fn make_ident<'a, T: IntoIterator<Item =3D &'a str>>(
> > > +    span: Span,
> > > +    names: T,
> > > +) -> impl Iterator<Item =3D TokenTree> + use<'a, T> {
> > > +    names.into_iter().flat_map(move |name| {
> > > +        [
> > > +            TokenTree::Punct(Punct::new(':', Spacing::Joint)),
> > > +            TokenTree::Punct(Punct::new(':', Spacing::Alone)),
> > > +            TokenTree::Ident(Ident::new(name, span)),
> > > +        ]
> > > +    })
> > > +}
> > > diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> > > index d31e50c446b0..fa956eaa3ba7 100644
> > > --- a/rust/macros/lib.rs
> > > +++ b/rust/macros/lib.rs
> > > @@ -10,6 +10,7 @@
> > >  mod quote;
> > >  mod concat_idents;
> > >  mod export;
> > > +mod fmt;
> > >  mod helpers;
> > >  mod kunit;
> > >  mod module;
> > > @@ -196,6 +197,24 @@ pub fn export(attr: TokenStream, ts: TokenStream=
) -> TokenStream {
> > >      export::export(attr, ts)
> > >  }
> > >
> > > +/// Like [`core::format_args!`], but automatically wraps arguments i=
n [`kernel::fmt::Adapter`].
> > > +///
> > > +/// This macro allows generating `core::fmt::Arguments` while ensuri=
ng that each argument is wrapped
> > > +/// with `::kernel::fmt::Adapter`, which customizes formatting behav=
ior for kernel logging.
> > > +///
> > > +/// Named arguments used in the format string (e.g. `{foo}`) are det=
ected and resolved from local
> > > +/// bindings. All positional and named arguments are automatically w=
rapped.
> > > +///
> > > +/// This macro is an implementation detail of other kernel logging m=
acros like [`pr_info!`] and
> > > +/// should not typically be used directly.
> > > +///
> > > +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
> > > +/// [`pr_info!`]: ../kernel/macro.pr_info.html
> > > +#[proc_macro]
> > > +pub fn fmt(input: TokenStream) -> TokenStream {
> >
> > I'm wondering if we should name this `format_args` instead in order to
> > better communicate that it's a replacement for `core::format_args!`.
>
> Unfortunately that introduces ambiguity in cases where
> kernel::prelude::* is imported because core::format_args is in core's
> prelude.

I'm pretty sure that glob imports are higher priority than the core
prelude? Or is this because there are macros that now incorrectly use
kernel::prelude::format_args when they should use the one from core?

Alice

