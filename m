Return-Path: <linux-kselftest+bounces-29430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A2A68EDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BD6461B5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B251C0DED;
	Wed, 19 Mar 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjIFafIC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86F17A2E7;
	Wed, 19 Mar 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393711; cv=none; b=IMr8MkuAwZupGbhgO7AO38EtQWXxoG9JqKas0mRCapDpU7uOvjT5rnsrz1OSPZ15PH43TnPCUdNORAYQ37f8IlyO4LSbClhtRXGEQDfWwrhJ/39bEQmAE2Jz6vKSichTTT6sl9hct82Nhw5ad96U2nwhehHdkl3pAlrpJY58Uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393711; c=relaxed/simple;
	bh=soRBHKuXHAhfbzS4wZUjxzqCvZJqD5O3F1rh8HobrP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9h7axLRnYXoAc49B2ksMgSYOoUgH900f51J4Sxg7ivaqIZOEJqmAaK5QafIotPHhKSHQUuNwg8x6GKDaCE444gGRV1UwwPx/cBmB1QEugd7rD6+fSjQH2cRKbazo5chg/7ytH0gZ3quYIhmN6m5RbG9U7pCaUbjSMcRfJ5f+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjIFafIC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfca745c7so69896461fa.0;
        Wed, 19 Mar 2025 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742393708; x=1742998508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omRKJWK9MexjsAQwKDXOrJ+QXdF1TIOx0mszaRJ4U3E=;
        b=MjIFafIC6qJPytuAzn4SqnRontOUv4Ap5qI28fVaXWe9AL+rAm7w9MKQey+/FGJzqt
         DfwPIXzJiH3w4mlqY6fSwVE7zH4g6ZpsW28Zi5ji6E0PBYfnrNUyNecwBfoEtwQdzs3g
         Me5MwxESfywpnM9bH6UPbJbenpqke1qsfSDbR8y5Y2XzH6Bpz2cxv1tUTizwa/SEBdv9
         X/H8OvMTitxAajpvF35Kj0w0LQYGgO+LGMh01YiP4xc1KL6zuoTeMPhoTHe7Yc+o6YU3
         x2RcWbC88BVDtqtC/tJzBDhf2KOUhSGYq9Nf9VZdjsKm/Hy27FKhL3eHZyZrIF4PRsnj
         ZVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393708; x=1742998508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omRKJWK9MexjsAQwKDXOrJ+QXdF1TIOx0mszaRJ4U3E=;
        b=evaBrEzo/Odux78eLQVkdZf1qW43fdCkGP2KmJpzKxzxw9x2uIK9lXT685KA1IlT9w
         zk0ehwCPTN+QKrf2U8bor3QX63yFRm384j5p3XjA5ocRwrqVBCIc/TlPg7gec8tsNmRw
         zM1l2aXHlN4xKoK4iOmWbLRW7DR6HM49Wqqc9zmje1IxWIyjqMET+FpTr4pDzOs9HEO7
         5Q3nT8SOTVRKQnlQ2B3t4Kw4ugUdfNI0/MW41sOKNBm9Bbz9REX2DikqrqnM/TrauHsZ
         ngkRKF3WISdHmci0oHrPrCUOVQFc08CvAO624T59NOOJ9WvyVU3niyxpkZwWVTG9dCWK
         krFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ArWjGBuu70okt1UrOAtWrubkOtljI7nHVxVcWM9vgqQw5YCcOvinOzcV35wu5z3uaV1j/E9kbmsu@vger.kernel.org, AJvYcCUkATTNVyafHZm2i+la5nGbsymWK2UmpXd4zTFHO2YL3s8WcA3Tck46OznaX06/13Lxqbsz8Ky2WqUHeuo=@vger.kernel.org, AJvYcCV1XE43Lr4J6RfTfTdVNQpFYnAnBVfLDX/kS5K1sEvAGxthozxxM4FA9oPeqd+YzDQQ0QnGnbSNlMGS@vger.kernel.org, AJvYcCW4fH0ea7Wez6P5ZNEReUd237hhDkEBNhBxs99IlWap2gmYpPRKb8qzSGwCmjlv5KsSy+2/A0edgziCln2j5L8=@vger.kernel.org, AJvYcCX7X5YJ7LHW665iRms4X0RM3Ed8QEJi7p0KSu9KEOFVNtp12+5aEXO+Kvl0nvoOrTUWk8Odj+4Msh4V7dgBUjjv@vger.kernel.org, AJvYcCXPAr8WhOaIsBWQ2sJ46D1KGmN6Aiy5TM4fTKxze9tzZKkPFa6xUaiJuKyXXs1/kMynGNuDF3Zyc8TMb4r8@vger.kernel.org, AJvYcCXSOFY5v6WxSoX4PHpJ65/cJ0DBSq5zWPqIMpXm9LZxWtShtMyxLLJuIqpeLvygKylUrCG+dROHA0dxgID+@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVaj69bOlm+ROerAVinVaBe+zSp3r0saHpeqDnpRmzkyN+8Rz
	V7/7uADqUfkB5x/zKyBe4pl4ad95DFWPvJ7M81Cmpfz7zRyuzvZgsfJhGVfcb6cIk4AnaP7Kt50
	CphoJvo26/MeWQT5iOByDi2yqVQw=
X-Gm-Gg: ASbGncv9seVvKt7nx2hP5WkxcaEZXH6dqHZ9rmBNSr+Es0UcBHoPjIcEyqDrHWjSfwe
	m3xUwh7S796bsxioKIEmJYjv++a1Khh2wfzZfcfLNzThCfuxAdSB7EGz76PgeUr7q7fwywHFnh6
	zm3XecBnKINYtjLl82gbcCcNOKrFsvUQYtpXPgtx1NDg==
X-Google-Smtp-Source: AGHT+IE2kuxS9+6hmerN8azzogPPnG6YOR0pawaKaHpqogkvHtFjmfrpl84a2HNK1iEZA2uiAgHTzd6L5hmK8RS/L14=
X-Received: by 2002:a05:651c:2127:b0:30b:c83e:720f with SMTP id
 38308e7fff4ca-30d6a410c7cmr11265591fa.7.1742393707679; Wed, 19 Mar 2025
 07:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com>
 <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me> <Z9q2xpwsNMDzZ2Gp@google.com>
In-Reply-To: <Z9q2xpwsNMDzZ2Gp@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 10:14:31 -0400
X-Gm-Features: AQ5f1JrpdSjcw-UeRIviJZbfSflMiKfOV4agzm5OnMFsQT1IS5sITNF_DoEDTos
Message-ID: <CAJ-ks9m8r_ABh4ift3wmM_wpbYLo=ZuhUarfLJKQnS7TcGHRdg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Mar 19, 2025 at 12:23:44AM +0000, Benno Lossin wrote:
> > On Tue Mar 18, 2025 at 1:29 PM CET, Alice Ryhl wrote:
> > > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > >> Throughout the tree, use the strict provenance APIs stabilized in Ru=
st
> > >> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> > >> functions at the `kernel` crate root along with polyfills for rustc =
<
> > >> 1.84.0.
> > >>
> > >> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc=
 <
> > >> 1.84.0 as our MSRV is 1.78.0.
> > >>
> > >> In the `kernel` crate, enable the strict provenance lints on rustc >=
=3D
> > >> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introduc=
ing
> > >> compiler flags that are dependent on the rustc version in use.
> > >>
> > >> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-=
provenance-apis [1]
> > >> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > >> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.=
me/
> > >> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > >
> > > I'm not convinced that the pros of this change outweigh the cons. I
> > > think this is going to be too confusing for the C developers who look=
 at
> > > this code.
> >
> > 1) I think we should eliminate all possible `as` conversions. They are
> >    non-descriptive (since they can do may *very* different things) and
> >    ptr2int conversions are part of that.
> > 2) At some point we will have to move to the provenance API, since
> >    that's what Rust chose to do. I don't think that doing it at a later
> >    point is doing anyone a favor.
>
> We don't *have* to do anything. Sure, most `as` conversions can be
> removed now that we have fixed the integer type mappings, but I'm still
> not convinced by this case.
>
> Like, sure, use it for that one case in `kernel::str` where it uses
> integers for pointers for some reason. But most other cases, provenance
> isn't useful.
>
> > 3) I don't understand the argument that this is confusing to C devs.
> >    They are just normal functions that are well-documented (and if
> >    that's not the case, we can just improve them upstream). And
> >    functions are much easier to learn about than `as` casts (those are
> >    IMO much more difficult to figure out than then strict provenance
> >    functions).
>
> I really don't think that's true, no matter how good the docs are. If
> you see `addr as *mut c_void` as a C dev, you are going to immediately
> understand what that means. If you see with_exposed_provenance(addr),
> you're not going to understand what that means from the name - you have
> to interrupt your reading and look up the function with the weird name.
>
> And those docs probably spend a long time talking about stuff that
> doesn't matter for your pointer, since it's probably a userspace pointer
> or similar.
>
> > Thus I think we should keep this patch (with Boqun's improvement).
> >
> > >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> > >> index 719b0a48ff55..96393bcf6bd7 100644
> > >> --- a/rust/kernel/uaccess.rs
> > >> +++ b/rust/kernel/uaccess.rs
> > >> @@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUnini=
t<u8>]) -> Result {
> > >>          }
> > >>          // SAFETY: `out_ptr` points into a mutable slice of length =
`len`, so we may write
> > >>          // that many bytes to it.
> > >> -        let res =3D unsafe { bindings::copy_from_user(out_ptr, self=
.ptr as *const c_void, len) };
> > >> +        let res =3D unsafe {
> > >> +            bindings::copy_from_user(out_ptr, crate::with_exposed_p=
rovenance(self.ptr), len)
> > >> +        };
> > >>          if res !=3D 0 {
> > >>              return Err(EFAULT);
> > >>          }
> > >> @@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T=
> {
> > >>          let res =3D unsafe {
> > >>              bindings::_copy_from_user(
> > >>                  out.as_mut_ptr().cast::<c_void>(),
> > >> -                self.ptr as *const c_void,
> > >> +                crate::with_exposed_provenance(self.ptr),
> > >>                  len,
> > >>              )
> > >>          };
> > >
> > > That's especially true for cases like this. These are userspace point=
ers
> > > that are never dereferenced. It's not useful to care about provenance
> > > here.
> >
> > I agree for this case, but I think we shouldn't be using raw pointers
> > for this to begin with. I'd think that a newtype wrapping `usize` is a
> > much better fit. It can then also back the `IoRaw` type. AFAIU user
> > space pointers don't have provenance, right? (if they do, then we shoul=
d
> > use this API :)
>
> We're doing that to the fullest extent possible already. We only convert
> them to pointers when calling C FFI functions that take user pointers as
> a raw pointer.
>
> Alice

Personally, I agree with Benno that `as` conversions are a misfeature
in the language.

I think this patch and the ensuing discussion is making perfect the
enemy of good, so I'd prefer to drop it and revisit when the
ergonomics have improved.

