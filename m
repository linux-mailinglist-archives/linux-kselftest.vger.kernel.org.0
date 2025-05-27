Return-Path: <linux-kselftest+bounces-33868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68453AC5183
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35ED3B8572
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C87C27A10F;
	Tue, 27 May 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpChaz+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CB1DFE8;
	Tue, 27 May 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358166; cv=none; b=UKd0SLFf5VozSVGdhXFxIS0SYnVkiiftg0zVXao/YXPQtbjDPLkZmfYfo51ih7Zk6Fy8Dx0ejLYTpTmt0/NYTPm1EVOY6WPdWGP6e6qp+2pGJESwr51kkeKEq3zPSdsRFW6ba2s/4qmtJSU4i/SJLO3mjUlcRkfkQNWnsBO/4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358166; c=relaxed/simple;
	bh=ufI9LxH1wobCT8D1b4h/1BazhweXoWGp1yYCwSHwCI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti0fGA1cb1cjn2Pin7qUZXDkuB7YFE77sv9RWqM9EerUnOKaIghMbveiMnPUA/pg7wP4gqA6qXxqyTkY3lm7cQ1tDPkMBgxGww66MY2YC2vRVi/DOWBTThiWQUrgGsATEX3cW25LT/6SAXxVjCs2PH7vpg18n0Kxvhej8W3NEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpChaz+o; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-328114b26e1so22267861fa.1;
        Tue, 27 May 2025 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748358162; x=1748962962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWnpNgtFcY6Rfei4jRxG9rFAWp+cX3YYTz4I7H9Ixuk=;
        b=KpChaz+oMtIU2ZaM4L8qlfQj60EJ52fMREPaNr65QKahaPTrdFMFPGRRvimOjDF7Gv
         pLlYu1Cq4kwD61FOKDbtxXNuNI8x91VL9RmjsgjpwflbwhMRSZWhEgQ/EWy9Ae7zjTlU
         TzG7MsMdDXb8JGmZKXAxRNqFUvhRwXiqYiKJkKryGNmrZ82de8C7O4W/YPRKfyrMrJOG
         DeYtCC4e4Rm3YBWReO7aX3Cbw+Cbc0kaFElIcc3HQ9FP6ZfyPQl85urcQOO15fnmD8yJ
         2DHdB+n+2xbxwbRKBsONstpMAYZOeNRK9/phxUNYRq8ZezE5G+Xf0q7d8Pezjn/SYF13
         88/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358162; x=1748962962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWnpNgtFcY6Rfei4jRxG9rFAWp+cX3YYTz4I7H9Ixuk=;
        b=vYzLXEHdx+ZgoupeVjUWzn2FeewBRRcm+4IHvC9lB6bpn1hePWMxKilIwlAsi/40MM
         kTKDQ7p2zDS4+THAFk/tuj6HE5C+Dy2Y9YLQHGLOZ0XHPt+cOJBVxMcK30cWDfYem7a3
         fqz0xsC7hxZjw5HV7aiw+lVU+l85u15uTWIWd5pz9MC1Q4JtJqmMFHcx9ay0k1rXXlz7
         uh1iBWU8IN/rpZXonsd3CxMxHSg5AqIKMgy3LdLyf+2PwiBz4tH9sMRvD26ucgIVKkVw
         brgQ/GgSuz+aRpy8CckHn9i4QCV1y2j21Uu1bqqsmyyGjBlgZ48KCDPxZGOsPsvk8Ztm
         3gMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtVSeZm7qYipcF98W5/i44Ank6VQBlBPG7raWmhFxLRc7wxj+ax9ULPoSCFSwPFU/Jz2nxhORktnBaL5A=@vger.kernel.org, AJvYcCVCK6//BWi5PSxUI8OEI5LxQDPf0vhxBzv73ajyf9FBly4BFiRgfmBkwKn1VDsql1U2uHdcKbD/k0TF01Gxd6s=@vger.kernel.org, AJvYcCVaUnTfnmTYLCQECACrEl41plhxoO6HUaICFo9i6xCgnqORfhb7/xGkgQIatFKvvHtZTr7Qs9K22otL/id5CTrg@vger.kernel.org, AJvYcCW6IVVy3vzlw6r1EzUwn8SfdnF3th6iKnc31LDUn69KPaCpG2AiJ/9G/RJiVNpTaFVh6ad+CrDRv1qS@vger.kernel.org, AJvYcCWdM7WKo3s/L/UMe6ZHJMaj1pMbIs8IvC1N/GosbGWgi9/x7jBnvpvVfku5Imre7DXbAiLFxiZoWUbV@vger.kernel.org, AJvYcCX7ie9rDmFrSY09hbWek8I11f4rJE5a0xSR6N16Cr1dEiu4/NpjnpnUeINP7LSXvaSsEnSD001Z@vger.kernel.org, AJvYcCXtUnsgmRoh+fj+hwbkVaosR5Lfm5e8pUV442jgezTLyTHahjJxD3QuAqylF8WSdwC5KxImUloF6u0jF8aG@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZw5kuw2UShtqwotphoBoY4VWzud4qZcQwnh6/L+h0u1eLnNe
	qXUAKAGTV3O7ANJmsIPRANMRJ27zegUfZDMBnAWr+thvDR5OTUdFxq5FBIdk4mHQayzQXZSuDW/
	TTCuJ31V8cVXYR9Ys7ddI/V6mGerDEco=
X-Gm-Gg: ASbGncuVu2vef9NTg9ib85P6AZQYn358PtGX4v9KsgDhytqazt9Bfh2oKPnhNSmXNiN
	+RyJ/ADVVzsY+4ZdwpXFZ/QAUaozBHNNEe13nO4y0hm184YgRC1HF+ZFLhISSl+nlwWETzCRSU1
	w95ReEmr0//c+b2RsAu8K6xNf/laUPJh1+8hKtyoaHaErxaBCI
X-Google-Smtp-Source: AGHT+IGFw/n0N4u0zEu1rQhqLzZPgaC14Lz0t0tgt/02Nzcqwd49+7j8OT/V+Lq3Y4h3EFBfzwAWStg3WQPZ89F2+a4=
X-Received: by 2002:a2e:be1d:0:b0:328:604:9da8 with SMTP id
 38308e7fff4ca-3295b991e39mr39297221fa.6.1748358161709; Tue, 27 May 2025
 08:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com> <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
 <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com> <DA6GSMHMLRFM.YH9RGZWLY2X4@kernel.org>
In-Reply-To: <DA6GSMHMLRFM.YH9RGZWLY2X4@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 May 2025 11:02:05 -0400
X-Gm-Features: AX0GCFvsyDAFuT3w5C3nGuFHFjR6aYE_88niNwIangoOQL2awwx9lqh_vNT5Xj0
Message-ID: <CAJ-ks9nTf4dCoDdg4+YSkXM1sJsZ-0vuSC7wybc2JMAoGemhXQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
To: Benno Lossin <lossin@kernel.org>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Mon, May 26, 2025 at 7:01=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Tue May 27, 2025 at 12:17 AM CEST, Tamir Duberstein wrote:
> > On Mon, May 26, 2025 at 10:48=E2=80=AFAM Benno Lossin <lossin@kernel.or=
g> wrote:
> >> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> >> > Introduce a `fmt!` macro which wraps all arguments in
> >> > `kernel::fmt::Adapter` This enables formatting of foreign types (lik=
e
> >> > `core::ffi::CStr`) that do not implement `fmt::Display` due to conce=
rns
> >> > around lossy conversions which do not apply in the kernel.
> >> >
> >> > Replace all direct calls to `format_args!` with `fmt!`.
> >> >
> >> > In preparation for replacing our `CStr` with `core::ffi::CStr`, move=
 its
> >> > `fmt::Display` implementation to `kernel::fmt::Adapter<&CStr>`.
> >> >
> >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> >> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-Ge=
neral/topic/Custom.20formatting/with/516476467
> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > ---
> >> >  drivers/block/rnull.rs      |   2 +-
> >> >  rust/kernel/block/mq.rs     |   2 +-
> >> >  rust/kernel/device.rs       |   2 +-
> >> >  rust/kernel/fmt.rs          |  77 +++++++++++++++++++++++++++++
> >> >  rust/kernel/kunit.rs        |   6 +--
> >> >  rust/kernel/lib.rs          |   1 +
> >> >  rust/kernel/prelude.rs      |   3 +-
> >> >  rust/kernel/print.rs        |   4 +-
> >> >  rust/kernel/seq_file.rs     |   2 +-
> >> >  rust/kernel/str.rs          |  23 ++++-----
> >> >  rust/macros/fmt.rs          | 118 +++++++++++++++++++++++++++++++++=
+++++++++++
> >> >  rust/macros/lib.rs          |  19 +++++++
> >> >  scripts/rustdoc_test_gen.rs |   2 +-
> >> >  13 files changed, 235 insertions(+), 26 deletions(-)
> >>
> >> Can you split this into creating the proc-macro, forwarding the displa=
y
> >> impls and replacing all the uses with the proc macro?
> >
> > Can you help me understand why that's better?
>
> It makes reviewing significantly easier.
>
> >> > +macro_rules! impl_display_forward {
> >> > +    ($(
> >> > +        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* =
} )?
> >>
> >> You don't need `{}` around the `where` clause, as a `where` keyword ca=
n
> >> follow a `ty` fragment.
> >
> > This doesn't work:
> > ```
> > error: local ambiguity when calling macro `impl_display_forward`:
> > multiple parsing options: built-in NTs tt ('r#where') or 2 other
> > options.
> >   --> rust/kernel/fmt.rs:75:78
> >    |
> > 75 |     {<T: ?Sized>} crate::sync::Arc<T> where crate::sync::Arc<T>:
> > fmt::Display,
> >    |
> >            ^
> > ```
>
> Ah right that's a shame, forgot about the `tt`s at the end...
>
> >> > +impl_display_forward!(
> >> > +    bool,
> >> > +    char,
> >> > +    core::panic::PanicInfo<'_>,
> >> > +    crate::str::BStr,
> >> > +    fmt::Arguments<'_>,
> >> > +    i128,
> >> > +    i16,
> >> > +    i32,
> >> > +    i64,
> >> > +    i8,
> >> > +    isize,
> >> > +    str,
> >> > +    u128,
> >> > +    u16,
> >> > +    u32,
> >> > +    u64,
> >> > +    u8,
> >> > +    usize,
> >> > +    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: f=
mt::Display},
> >> > +    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::Uni=
queArc<T>: fmt::Display},
> >> > +);
> >>
> >> If we use `{}` instead of `()`, then we can format the contents
> >> differently:
> >>
> >>     impl_display_forward! {
> >>         i8, i16, i32, i64, i128, isize,
> >>         u8, u16, u32, u64, u128, usize,
> >>         bool, char, str,
> >>         crate::str::BStr,
> >>         fmt::Arguments<'_>,
> >>         core::panic::PanicInfo<'_>,
> >>         {<T: ?Sized>} crate::sync::Arc<T> {where Self: fmt::Display},
> >>         {<T: ?Sized>} crate::sync::UniqueArc<T> {where Self: fmt::Disp=
lay},
> >>     }
> >
> > Is that formatting better? rustfmt refuses to touch it either way.
>
> Yeah rustfmt doesn't touch macro parameters enclosed in `{}`. I think
> it's better.

OK, but why? This seems entirely subjective.

> >> > +/// Please see [`crate::fmt`] for documentation.
> >> > +pub(crate) fn fmt(input: TokenStream) -> TokenStream {
> >> > +    let mut input =3D input.into_iter();
> >> > +
> >> > +    let first_opt =3D input.next();
> >> > +    let first_owned_str;
> >> > +    let mut names =3D BTreeSet::new();
> >> > +    let first_lit =3D {
> >> > +        let Some((mut first_str, first_lit)) =3D (match first_opt.a=
s_ref() {
> >> > +            Some(TokenTree::Literal(first_lit)) =3D> {
> >> > +                first_owned_str =3D first_lit.to_string();
> >> > +                Some(first_owned_str.as_str()).and_then(|first| {
> >> > +                    let first =3D first.strip_prefix('"')?;
> >> > +                    let first =3D first.strip_suffix('"')?;
> >> > +                    Some((first, first_lit))
> >> > +                })
> >> > +            }
> >> > +            _ =3D> None,
> >> > +        }) else {
> >> > +            return first_opt.into_iter().chain(input).collect();
> >> > +        };
> >>
> >> This usage of let-else + match is pretty confusing and could just be a
> >> single match statement.
> >
> > I don't think so. Can you try rewriting it into the form you like?
>
>     let (mut first_str, first_lit) match first_opt.as_ref() {
>         Some(TokenTree::Literal(lit)) if lit.to_string().starts_with('"')=
 =3D> {
>             let contents =3D lit.to_string();
>             let contents =3D contents.strip_prefix('"').unwrap().strip_su=
ffix('"').unwrap();
>             ((contents, lit))
>         }
>         _ =3D> return first_opt.into_iter().chain(input).collect(),
>     };

What happens if the invocation is utterly malformed, e.g.
`fmt!("hello)`? You're unwrapping here, which I intentionally avoid.

>
> >> > +        while let Some((_, rest)) =3D first_str.split_once('{') {
> >> > +            first_str =3D rest;
> >> > +            if let Some(rest) =3D first_str.strip_prefix('{') {
> >> > +                first_str =3D rest;
> >> > +                continue;
> >> > +            }
> >> > +            while let Some((name, rest)) =3D first_str.split_once('=
}') {
> >> > +                first_str =3D rest;
> >> > +                if let Some(rest) =3D first_str.strip_prefix('}') {
> >>
> >> This doesn't make sense, we've matched a `{`, some text and a `}`. You
> >> can't escape a `}` that is associated to a `{`.
> >
> > Sure, but such input would be malformed, so I don't think it's
> > necessary to handle it "perfectly". We'll get a nice error from
> > format_args anyhow.
>
> My suggestion in this case would be to just remove this if-let. The
> search for `{` above would skip the `}` if it's correct.
>
> > https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D5f529d93da7cf46b3c99ba7772623e33

Makes sense to me.

>
> Yes it will error like that, but if we do the replacement only when the
> syntax is correct, there also will be compile errors because of a
> missing `Display` impl, or is that not the case?

I'm not sure - I would guess syntax errors "mask" typeck errors.

>
> I'm a bit concerned about the ergonomics that this change will
> introduce, but I guess there really isn't anything that we can do about
> except not do it.
>
> >> > +                    first_str =3D rest;
> >> > +                    continue;
> >> > +                }
> >> > +                let name =3D name.split_once(':').map_or(name, |(na=
me, _)| name);
> >> > +                if !name.is_empty() && !name.chars().all(|c| c.is_a=
scii_digit()) {
> >> > +                    names.insert(name);
> >> > +                }
> >> > +                break;
> >> > +            }
> >> > +        }
> >> > +        first_lit
> >>
> >> `first_lit` is not modified, so could we just the code above it into a
> >> block instead of keeping it in the expr for `first_lit`?
> >
> > As above, can you suggest the alternate form you like better? The
> > gymnastics here are all in service of being able to let malformed
> > input fall through to core::format_args which will do the hard work of
> > producing good diagnostics.
>
> I don't see how this is hard, just do:
>
>     let (first_str, first_lit) =3D ...;

It requires you to unwrap, like you did above, which is what I'm
trying to avoid.

>
>     while ...
>
> >> > +    };
> >> > +
> >> > +    let first_span =3D first_lit.span();
> >> > +    let adapt =3D |expr| {
> >> > +        let mut borrow =3D
> >> > +            TokenStream::from_iter([TokenTree::Punct(Punct::new('&'=
, Spacing::Alone))]);
> >> > +        borrow.extend(expr);
> >> > +        make_ident(first_span, ["kernel", "fmt", "Adapter"])
> >> > +            .chain([TokenTree::Group(Group::new(Delimiter::Parenthe=
sis, borrow))])
> >>
> >> This should be fine with using `quote!`:
> >>
> >>     quote!(::kernel::fmt::Adapter(&#expr))
> >
> > Yeah, I have a local commit that uses quote_spanned to remove all the
> > manual constructions.
>
> I don't think that you need `quote_spanned` here at all. If you do, then
> let me know, something weird with spans is going on then.

You need to give idents a span, so each of `kernel`, `fmt`, and
`adapter` need a span. I *could* use `quote!` and get whatever span it
uses (mixed_site) but I'd rather retain control.

>
> >> > +    };
> >> > +
> >> > +    let flush =3D |args: &mut TokenStream, current: &mut TokenStrea=
m| {
> >> > +        let current =3D std::mem::take(current);
> >> > +        if !current.is_empty() {
> >> > +            args.extend(adapt(current));
> >> > +        }
> >> > +    };
> >> > +
> >> > +    let mut args =3D TokenStream::from_iter(first_opt);
> >> > +    {
> >> > +        let mut current =3D TokenStream::new();
> >> > +        for tt in input {
> >> > +            match &tt {
> >> > +                TokenTree::Punct(p) =3D> match p.as_char() {
> >> > +                    ',' =3D> {
> >> > +                        flush(&mut args, &mut current);
> >> > +                        &mut args
> >> > +                    }
> >> > +                    '=3D' =3D> {
> >> > +                        names.remove(current.to_string().as_str());
> >> > +                        args.extend(std::mem::take(&mut current));
> >> > +                        &mut args
> >> > +                    }
> >> > +                    _ =3D> &mut current,
> >> > +                },
> >> > +                _ =3D> &mut current,
> >> > +            }
> >> > +            .extend([tt]);
> >> > +        }
> >>
> >> This doesn't handle the following code correctly ):
> >>
> >>     let mut a =3D 0;
> >>     pr_info!("{a:?}", a =3D a =3D a);
> >>
> >> Looks like we'll have to remember what "kind" of an equals we parsed..=
.
> >
> > Hmm, good point. Maybe we can just avoid dealing with `=3D` at all unti=
l
> > we hit the `,` and just split on the leftmost `=3D`. WDYT? I'll have
> > that in v11.
>
> Sounds good, if there is no `=3D`, then ignore it.
>
> >> > +/// Like [`core::format_args!`], but automatically wraps arguments =
in [`kernel::fmt::Adapter`].
> >> > +///
> >> > +/// This macro allows generating `core::fmt::Arguments` while ensur=
ing that each argument is wrapped
> >> > +/// with `::kernel::fmt::Adapter`, which customizes formatting beha=
vior for kernel logging.
> >> > +///
> >> > +/// Named arguments used in the format string (e.g. `{foo}`) are de=
tected and resolved from local
> >> > +/// bindings. All positional and named arguments are automatically =
wrapped.
> >> > +///
> >> > +/// This macro is an implementation detail of other kernel logging =
macros like [`pr_info!`] and
> >> > +/// should not typically be used directly.
> >> > +///
> >> > +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
> >> > +/// [`pr_info!`]: ../kernel/macro.pr_info.html
> >> > +#[proc_macro]
> >> > +pub fn fmt(input: TokenStream) -> TokenStream {
> >>
> >> I'm wondering if we should name this `format_args` instead in order to
> >> better communicate that it's a replacement for `core::format_args!`.
> >
> > Unfortunately that introduces ambiguity in cases where
> > kernel::prelude::* is imported because core::format_args is in core's
> > prelude.
>
> Ahh that's unfortunate.
>
> ---
> Cheers,
> Benno

