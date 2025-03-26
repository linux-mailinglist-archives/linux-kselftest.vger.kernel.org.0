Return-Path: <linux-kselftest+bounces-29813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEDA714F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3323B171F60
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17741C6FF3;
	Wed, 26 Mar 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZrKcg5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A921AD41F;
	Wed, 26 Mar 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985359; cv=none; b=oAoD3YFL7RoQjhNAEH5KP03WtqvSf4ZxzMZZR2VHVm3SI4V/icH4kMdCtt5f2CZFWeXKLZF4AqrrQQrSeDC7VxHxJ8sXWm298Lz7ywybNar1ZNA9WmNZrf/Gk7sXuZmYzYewuENZBYSL56TUVPckwJe9D6KhHRmRBTZy5QoZfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985359; c=relaxed/simple;
	bh=r1PHUol5LLO2tzaycxfoWPPA5kKeTN/K4bVoytzpK4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEpKgkAj/nb40VVmqYSKdt7qJlnjUd74ffRnwqF4SXGA2mUTjUYfqlwkROigMW5ZNDIPEpqTaV5Hx4wp9qao0/dkX3Bkrqx/1mCNuMZi2kl6Q+8YDMHCqV0ombePHyo3qvw/DudZdln6WgGQzu7gJtD2dk6QHMzvJSjywh8TEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZrKcg5f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee1cb370so67999201fa.1;
        Wed, 26 Mar 2025 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742985356; x=1743590156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5AiCDUgeTdwDyc9crOgWfabxPyQS/xAXOnubihQEcg=;
        b=PZrKcg5f04M1e3Gk0XmU1ZW985+y49XDKKMnHWfvYwXGAvW2SEQ0l7FJbl1pC2l7Ge
         faHMa7khQ1iSjTVCB3+1ShdsQiaCM89fDlZEKCYWFWfGHS5O1kAvwNv8Lax2Aw1gyKcn
         MeJ/sIl4s6jxbZZde8h9mnpa6mI2k0f4+I1tTU2yjvefLJvGYihYA77sXQNyxzZArZES
         wC0wUeKUUFErdnh7DZ+uoyYXJ25AyGLD6QAto/SX+P3tt46YhLznaeXgOskv7zOPxNg8
         p9f5xZrJuuxYFKO7sNI/Utv8w05dP6osqoQsLJSU0SfOm7TDBA0lBfrDxHVbzvO4bnsc
         nkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742985356; x=1743590156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5AiCDUgeTdwDyc9crOgWfabxPyQS/xAXOnubihQEcg=;
        b=PFRRdhb17lhBC9SODdW3jsfdg6mpatrPCxn3fj62X/ufsyQzaAHKUPQkoZwl8DdeHC
         uGLbafgdAU2kcxe7kfYhhl7/4RARshyR8RET7sdnV7BSN8H7939AZ+F33POVavHXGZye
         bAk3ALMVp/uRkSEPfyRGeBNhojxwzcOpC9nFBEAeSfO9P8pHHL/zvNME+xrBCC9P1TC9
         hedTl/p3f0WT7VrnX7oc+ZcJQKeeol41OJ7y4aBpTcQsSPUMgQUnyAd5AHjVVm/yn2Nv
         wjbhoMjaCC1iHwaUQwAXNR3yUOY8eYK15HUhGKQ5Hotgsx2ybDPxsn6YP8zIysAcXhAT
         jY/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDKkPZI4wq06RL8NnW6CkRmB7j5pXRYtUo4I4ui9w0W5MxBLM+Yn/haRNXMPJkDDkfspuVftlPgvkGbqHRRh1K@vger.kernel.org, AJvYcCV1n/mbHqpcpqQuS4E4nBNm4TK4s1CfVgCGv8QvYM3xQ25oM4qhoVIhGF9I7J1Fqj7XW62qWcr3N6Dt@vger.kernel.org, AJvYcCVQB6LhJKIt5uFh1ynU0gTNKbQwNNTQn2gk8c3Qw4q2/P3p/qYR1cIi2NKkENjziGszjjFEUIK8cxCnYfA=@vger.kernel.org, AJvYcCVuXaEuxHlTmfMOxfOU9SMbSScaxpH8sRAvv44DjdtjlprXcyHe2o/XumfYiFwKuvoJyswlsuSHXZueHjk7@vger.kernel.org, AJvYcCWI1kM7kj+GmyH33cjGcBkldtN+9bTHRby9Frie4ZvaBU9aPu68oAVwQZpVFF4pKhPtFw3rgBKk@vger.kernel.org, AJvYcCWiFtlbn4gZHLvS4cjm2lU/ICb1eXEZ3jXCFVJbuUcHpe3fZYHVaXoDr0Tog2h1joDyVJTJB7I/UaHqGs4S@vger.kernel.org, AJvYcCXeN5vo0c+OIAFkO2OZUJLBxetu3S9FwOaIfkdp9zzJ7cKQDk6pUJePJ8ksATehEzoNpHXgb9IUnNfA@vger.kernel.org, AJvYcCXv+laXmL+id4uFbBtv34gwaVKxpzLJKL+NCsXtmXukRtKrDhSKj9fcFGBT8FM3xev5ssxygkiVE4OrjrXD+rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSENhGyeesRN5s9p3RNL3IFyZmwgFDaSLXrPUhtuXNcmy23dC
	iyAC7R7cVpFLky+GWxRTm7pFYeP3SoP6KywYhZq9xnAIScTxC8dyPSr7efEY07KO1A/7Ymfqpfu
	BZv+pBrDyDN3LpbEipNMNF1XEG2k=
X-Gm-Gg: ASbGncvKJddCYO/jDR+lYrt8sJxiPsaTvCDePC7r2jP+Cl4JGCNLRJ1SLcsltgdLkUL
	XOclDRCKPMigDKCi2gmF0XfRoWhRQh7wGz8KVEhobYkapBMB5SxppUhYAyFPocwG1oSgwpsfikG
	VjBka8DCzyScw6BPDx3Vov1k6dnMmGkvSIft9m8sXQ+Xzm0YvQnJvMutIBVmQ=
X-Google-Smtp-Source: AGHT+IH0DKwACe1nymEzj0ftx+SgXxFXIMCVyyNtqlvCyo9K6/6zTdS4KoA/gl5ad9HnVZ30KIalN9jorXqZaQaGEEE=
X-Received: by 2002:a2e:6a05:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-30d7e2bb98dmr75572281fa.35.1742985355748; Wed, 26 Mar 2025
 03:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
 <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com>
 <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me>
In-Reply-To: <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Mar 2025 06:35:19 -0400
X-Gm-Features: AQ5f1JrL9k74M9QnPZ9eBW9sSNazpeGZMopS8Asu-Kcyr5Yu4M92EoF_Ba4pH7Y
Message-ID: <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 6:31=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 26, 2025 at 12:54 AM CET, Tamir Duberstein wrote:
> > On Tue, Mar 25, 2025 at 6:40=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Tue Mar 25, 2025 at 11:33 PM CET, Tamir Duberstein wrote:
> >> > On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> >> >> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> >> >> > index 40034f77fc2f..6233af50bab7 100644
> >> >> > --- a/rust/kernel/str.rs
> >> >> > +++ b/rust/kernel/str.rs
> >> >> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
> >> >> >      #[inline]
> >> >> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> >> >> >          // SAFETY: `BStr` is transparent to `[u8]`.
> >> >> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> >> >> > +        unsafe { &*(core::mem::transmute::<*const [u8], *const S=
elf>(bytes)) }
> >> >>
> >> >> Hmm I'm not sure about using `transmute` here. Yes the types are
> >> >> transparent, but I don't think that we should use it here.
> >> >
> >> > What's your suggestion? I initially tried
> >> >
> >> > let bytes: *const [u8] =3D bytes;
> >> > unsafe { &*bytes.cast() }
> >> >
> >> > but that doesn't compile because of the implicit Sized bound on poin=
ter::cast.
> >>
> >> This is AFAIK one of the only places where we cannot get rid of the `a=
s`
> >> cast. So:
> >>
> >>     let bytes: *const [u8] =3D bytes;
> >>     // CAST: `BStr` transparently wraps `[u8]`.
> >>     let bytes =3D bytes as *const BStr;
> >>     // SAFETY: `bytes` is derived from a reference.
> >>     unsafe { &*bytes }
> >>
> >> IMO a `transmute` is worse than an `as` cast :)
> >
> > Hmm, looking at this again we can just transmute ref-to-ref and avoid
> > pointers entirely. We're already doing that in
> > `CStr::from_bytes_with_nul_unchecked`
> >
> > Why is transmute worse than an `as` cast?
>
> It's right in the docs: "`transmute` should be the absolute last
> resort." [1]. IIRC, Gary was a bit more lenient in its use, but I think
> we should avoid it as much as possible such that people copying code or
> taking inspiration also don't use it.
>
> So for both cases I'd prefer an `as` cast.
>
> [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html

I don't follow the logic. The trouble with `as` casts is that they are
very lenient in what they allow, and to do these conversions with `as`
casts requires ref -> pointer -> pointer -> pointer deref versus a
single transmute. The safety comment perfectly describes why it's OK
to do: the types are transparent. So why is `as` casting pointers
better? It's just as unchecked as transmuting, and worse, it requires
a raw pointer dereference.

