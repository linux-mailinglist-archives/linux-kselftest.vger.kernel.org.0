Return-Path: <linux-kselftest+bounces-34010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0564AC83E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 00:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCE7B3CDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025D21C9E5;
	Thu, 29 May 2025 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiXfxJ6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1C1AF0C8;
	Thu, 29 May 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556515; cv=none; b=HymqUhZVzE24jicSVuuQgLwVY/GTbi4EKqvgMJ7P8lPyz0O2j+JDTT4tHY88LPBZ1kiIdap+qkVkzSNyR0bwPl4T/mdXtlmwhChMczcPXN4zE03NEKG5pl6tg/LiF8DbA3TEi/nHoZYxXbrrxvofqOCXQWmPm829f1q4oIS+M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556515; c=relaxed/simple;
	bh=M0tbtdLApdJAq/4ogJahNv+Hgt/JeFqIHwEJhoEDBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXnLimkf8PpBuMa5tcDgyuZuX1fxQuRHU+/BWMoS4VqhuCHYUAbwAWyhvTE5BwKHBHmQ/72cx8staZLAJ6GJ0jcXJ++aiGImOD88AfTNTZsSt7bb7hLxmQo/tYlTfbVf4jLo0CaLoxDLBizaUSyEkXgBWF5i8KL7jKZZCYM5ZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiXfxJ6W; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32a63ff3bdfso10096961fa.3;
        Thu, 29 May 2025 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748556510; x=1749161310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpJVcptDcpTpszgwiBlbfF17mFy9KW509xkzZ9NUjik=;
        b=eiXfxJ6WeQcEoq232QqFmHB4GXmoObkb0md3lMdmOpYB+3XoubUPt0JSJ5KRnnPkIO
         tEB0EGwYqgvch37afi+h4w+yLUfIg10Az7chHl87igpdpNtiUB2Anb1t1Wp7fDWE6bDI
         haGvJWfINY18JtyjOCpAvZEGjCgHWcNr7BGHIM/durFQVA1/DUQJPomMY3HFwvuZTtpZ
         ZO/OfjYUGp9Dne5SIbYYbadJ2mO4xeDbg24RxW/21glAVMMMKSogUYdD0zp/DKVyFg4u
         pdx8OpuDKc0TTOjWjpBlSCzf1MkUjZof/cMMvrEHWFJ+L63Rhcyu7RmhezAMAPZloHC7
         W4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748556510; x=1749161310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpJVcptDcpTpszgwiBlbfF17mFy9KW509xkzZ9NUjik=;
        b=nOMd6SiZO1z4Tu7tRuirb0lXgZx1jd1jO5CyU2eAvbINkg7CaSLu3dRdnFNipu04Me
         TNPAyBFeoCis5aUg/3XgZi2hQlISAwfFsTZLvL/Q+pWm99dhSepGxpdHEjBYExK1V/YV
         dKaFowQs9z/OoGBzqmKkSuS4ennjObXp6iNR0whKztRcLwCympG0f062TVBN6rwpFlCY
         S19+NWuuSXe6D2fnXe9OUiwWahNqeVD+YH7HLkUWKa4lLhE3GnBcB5TpTgrZA3VdzqV1
         lGV9b+DEjgCnLUcSaKadurPKZIMzxk05mAH8AuB45DKSQGzIEAiYbimf5ZDJpEUKPcL3
         Is/w==
X-Forwarded-Encrypted: i=1; AJvYcCUAQ8pbkFrAk07zJeQHBTkSsF+xnRBvRxRaDHGEXPoksGXZuRkyo2HEnK2BEndz4E32nbXm3MFfaPWOfAoB@vger.kernel.org, AJvYcCULq+o+pmpGHDjuVcwRPZ2Q9zlYGCx+UDw2N38vuHaIB/Cmfskpmi2CbfVZ1goUVPFrEa1YaNne7NVKxYQ=@vger.kernel.org, AJvYcCVQaDcgmS+9wYmzVw7Sskysn0iJir/OJJ03QQ92rSV2bg8ZOAOgOOD32aQYeiELheZaCpSPXVAy@vger.kernel.org, AJvYcCVjSgH9eZZ4bBxaaHurmGPO+TnsM1BO9HpSCwqdHxeUBXwynSKWpmM/NIt8QClHLdW0+YR2PudOZWp0K4dY6bKm@vger.kernel.org, AJvYcCVjcrECEaFBdZtolDUYuXDList+ZPWGUhGarBqPksaFr8ZTxXYFA7SeEfHKWBAi6+LOBwnSP193amY1/y1hXh8=@vger.kernel.org, AJvYcCXGcqIlnB0yF0pk27+sMe4aTiQ5hEjQrBPhEvVA4F1vW0CQcjSOZ5BnKxnC7chlzoPWwVvPB7CEgyp7@vger.kernel.org, AJvYcCXWYhrxbZ2M4QQkbMFx6EVTSC9NiZcdMMdSc+7bpD3hAtFK2hEEbtccub7NmsHae1oirLtmo3mpqVDe@vger.kernel.org
X-Gm-Message-State: AOJu0Yylq/AdtOfHquUclaUDVUua7ynrBUy++jS57qF6FgD43kH2FjaF
	/5PoqUU2H4CMnJeXBrxOKeW3FiskNQYH8LDDTOCAWaCv1DzmfvMebWGDo/CiCTnQUWl4+hfeTkt
	HvY6OwG81Eh+Lh8t67zQjixgPX5uq78E=
X-Gm-Gg: ASbGnctRZrHEbWRJum7HsqC0X96HB/oIBVp9ZHjuLOCGdGZ6Kxtnhrh/l42atafjbdt
	JyiCEhInG3f4XZ1/mvHGI6Z0pr6Nrxwzwa+fYqA9DuLS3A0Soau663FJChqoWa9vA28NBPVxgts
	DSrFx5BVGfsgOTZGd53lVAGuDxNV3yEIPjkjBGtFGhpHjh1s662pSmwop7F2DnTyWgXQ==
X-Google-Smtp-Source: AGHT+IF7xscUHJvyGi+GvuMMKxSnSgP5AcyU3GpJtxmnO/5KSLUzYGntXscHYyM85fadDL0Kyjmy6YDgmBtNFpFE8dI=
X-Received: by 2002:a2e:b8c6:0:b0:32a:8916:55a1 with SMTP id
 38308e7fff4ca-32a8cd3fd89mr5150041fa.7.1748556509725; Thu, 29 May 2025
 15:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com> <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
 <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>
 <DA6GSMHMLRFM.YH9RGZWLY2X4@kernel.org> <CAJ-ks9nTf4dCoDdg4+YSkXM1sJsZ-0vuSC7wybc2JMAoGemhXQ@mail.gmail.com>
 <DA78MDRNCNB8.X69904APMYCB@kernel.org>
In-Reply-To: <DA78MDRNCNB8.X69904APMYCB@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 29 May 2025 18:07:52 -0400
X-Gm-Features: AX0GCFu41pC0z7_KQ2CYQPyB1pil2qNhuH6L70S1ECJZkmQT9P0P8s6oLTTUl3c
Message-ID: <CAJ-ks9=OsopMhr6Ui3PLD-ZkBo736ha9Ltkw=0ZaBzrQLC60Eg@mail.gmail.com>
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

On Tue, May 27, 2025 at 4:49=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Tue May 27, 2025 at 5:02 PM CEST, Tamir Duberstein wrote:
> > On Mon, May 26, 2025 at 7:01=E2=80=AFPM Benno Lossin <lossin@kernel.org=
> wrote:
> >> On Tue May 27, 2025 at 12:17 AM CEST, Tamir Duberstein wrote:
> >> > On Mon, May 26, 2025 at 10:48=E2=80=AFAM Benno Lossin <lossin@kernel=
.org> wrote:
> >> >> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> >> >> > +impl_display_forward!(
> >> >> > +    bool,
> >> >> > +    char,
> >> >> > +    core::panic::PanicInfo<'_>,
> >> >> > +    crate::str::BStr,
> >> >> > +    fmt::Arguments<'_>,
> >> >> > +    i128,
> >> >> > +    i16,
> >> >> > +    i32,
> >> >> > +    i64,
> >> >> > +    i8,
> >> >> > +    isize,
> >> >> > +    str,
> >> >> > +    u128,
> >> >> > +    u16,
> >> >> > +    u32,
> >> >> > +    u64,
> >> >> > +    u8,
> >> >> > +    usize,
> >> >> > +    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>=
: fmt::Display},
> >> >> > +    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::=
UniqueArc<T>: fmt::Display},
> >> >> > +);
> >> >>
> >> >> If we use `{}` instead of `()`, then we can format the contents
> >> >> differently:
> >> >>
> >> >>     impl_display_forward! {
> >> >>         i8, i16, i32, i64, i128, isize,
> >> >>         u8, u16, u32, u64, u128, usize,
> >> >>         bool, char, str,
> >> >>         crate::str::BStr,
> >> >>         fmt::Arguments<'_>,
> >> >>         core::panic::PanicInfo<'_>,
> >> >>         {<T: ?Sized>} crate::sync::Arc<T> {where Self: fmt::Display=
},
> >> >>         {<T: ?Sized>} crate::sync::UniqueArc<T> {where Self: fmt::D=
isplay},
> >> >>     }
> >> >
> >> > Is that formatting better? rustfmt refuses to touch it either way.
> >>
> >> Yeah rustfmt doesn't touch macro parameters enclosed in `{}`. I think
> >> it's better.
> >
> > OK, but why? This seems entirely subjective.
>
> If more types are added to the list, it will grow over one screen size.
> With my formatting, leaving related types on a single line, that will
> only happen much later.
>
> >> >> > +/// Please see [`crate::fmt`] for documentation.
> >> >> > +pub(crate) fn fmt(input: TokenStream) -> TokenStream {
> >> >> > +    let mut input =3D input.into_iter();
> >> >> > +
> >> >> > +    let first_opt =3D input.next();
> >> >> > +    let first_owned_str;
> >> >> > +    let mut names =3D BTreeSet::new();
> >> >> > +    let first_lit =3D {
> >> >> > +        let Some((mut first_str, first_lit)) =3D (match first_op=
t.as_ref() {
> >> >> > +            Some(TokenTree::Literal(first_lit)) =3D> {
> >> >> > +                first_owned_str =3D first_lit.to_string();
> >> >> > +                Some(first_owned_str.as_str()).and_then(|first| =
{
> >> >> > +                    let first =3D first.strip_prefix('"')?;
> >> >> > +                    let first =3D first.strip_suffix('"')?;
> >> >> > +                    Some((first, first_lit))
> >> >> > +                })
> >> >> > +            }
> >> >> > +            _ =3D> None,
> >> >> > +        }) else {
> >> >> > +            return first_opt.into_iter().chain(input).collect();
> >> >> > +        };
> >> >>
> >> >> This usage of let-else + match is pretty confusing and could just b=
e a
> >> >> single match statement.
> >> >
> >> > I don't think so. Can you try rewriting it into the form you like?
> >>
> >>     let (mut first_str, first_lit) match first_opt.as_ref() {
> >>         Some(TokenTree::Literal(lit)) if lit.to_string().starts_with('=
"') =3D> {
> >>             let contents =3D lit.to_string();
> >>             let contents =3D contents.strip_prefix('"').unwrap().strip=
_suffix('"').unwrap();
> >>             ((contents, lit))
> >>         }
> >>         _ =3D> return first_opt.into_iter().chain(input).collect(),
> >>     };
> >
> > What happens if the invocation is utterly malformed, e.g.
> > `fmt!("hello)`? You're unwrapping here, which I intentionally avoid.
>
> That example won't even survive lexing (macros always will get valid
> rust tokens as input). If a literal begins with a `"`, it also will end
> with one AFAIK.
>
> >> Yes it will error like that, but if we do the replacement only when th=
e
> >> syntax is correct, there also will be compile errors because of a
> >> missing `Display` impl, or is that not the case?
> >
> > I'm not sure - I would guess syntax errors "mask" typeck errors.
>
> I checked and it seems to be so, that's good.

=F0=9F=91=8D

>
> >> >> > +                    first_str =3D rest;
> >> >> > +                    continue;
> >> >> > +                }
> >> >> > +                let name =3D name.split_once(':').map_or(name, |=
(name, _)| name);
> >> >> > +                if !name.is_empty() && !name.chars().all(|c| c.i=
s_ascii_digit()) {
> >> >> > +                    names.insert(name);
> >> >> > +                }
> >> >> > +                break;
> >> >> > +            }
> >> >> > +        }
> >> >> > +        first_lit
> >> >>
> >> >> `first_lit` is not modified, so could we just the code above it int=
o a
> >> >> block instead of keeping it in the expr for `first_lit`?
> >> >
> >> > As above, can you suggest the alternate form you like better? The
> >> > gymnastics here are all in service of being able to let malformed
> >> > input fall through to core::format_args which will do the hard work =
of
> >> > producing good diagnostics.
> >>
> >> I don't see how this is hard, just do:
> >>
> >>     let (first_str, first_lit) =3D ...;
> >
> > It requires you to unwrap, like you did above, which is what I'm
> > trying to avoid.
>
> How so? What do you need to unwrap?

I was referring to your unwraps above.

> >> >> > +    };
> >> >> > +
> >> >> > +    let first_span =3D first_lit.span();
> >> >> > +    let adapt =3D |expr| {
> >> >> > +        let mut borrow =3D
> >> >> > +            TokenStream::from_iter([TokenTree::Punct(Punct::new(=
'&', Spacing::Alone))]);
> >> >> > +        borrow.extend(expr);
> >> >> > +        make_ident(first_span, ["kernel", "fmt", "Adapter"])
> >> >> > +            .chain([TokenTree::Group(Group::new(Delimiter::Paren=
thesis, borrow))])
> >> >>
> >> >> This should be fine with using `quote!`:
> >> >>
> >> >>     quote!(::kernel::fmt::Adapter(&#expr))
> >> >
> >> > Yeah, I have a local commit that uses quote_spanned to remove all th=
e
> >> > manual constructions.
> >>
> >> I don't think that you need `quote_spanned` here at all. If you do, th=
en
> >> let me know, something weird with spans is going on then.
> >
> > You need to give idents a span, so each of `kernel`, `fmt`, and
> > `adapter` need a span. I *could* use `quote!` and get whatever span it
> > uses (mixed_site) but I'd rather retain control.
>
> Please use `quote!` if it works. No need to make this more complex than
> it already is. If it doesn't work then that's another story.

Let's adjudicate that on v11, where you can see the code.

