Return-Path: <linux-kselftest+bounces-29843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB0A722B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 23:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0563BC756
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193CA1B425C;
	Wed, 26 Mar 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpNYGiYO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5314A4E0;
	Wed, 26 Mar 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027001; cv=none; b=Xexb1JGlScjtz8EfkGFvKc+GI9cC9Xst4DNAYZ4bAclY+nwtqgrCZgZ6tb1/Fa4s+NkllZCgWP3V2t1pTypXSz0UPO6yVsmcGBGU6rDJ22Y27O3Ug+mTs4EZaYlLBptajcDze0ag5D5kWKpsK6ANQa3pNOQB3HMhZR6/5cFWmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027001; c=relaxed/simple;
	bh=25Tr7RM7XhHf1JCtkM+bWEr7gcCanZ/l1B2na6DpLrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE3l01OmJvmL/jfnM6oaQUfvExV/N/2SfID19zogj+E6y+r+tjfnAEN9Oi3yWqczeGUgldtsOcM7AAhXF/dz8dnqXPgCx4WarnMFuXrgRr3e0h71cRauOhhTNaqd1WzlqSi+04LK5ldPmiz44YeBrxryH35cgxohF5xrCh55Obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpNYGiYO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so3074791fa.2;
        Wed, 26 Mar 2025 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743026997; x=1743631797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25Tr7RM7XhHf1JCtkM+bWEr7gcCanZ/l1B2na6DpLrY=;
        b=MpNYGiYO4yDbsQe6zzpDaE0Jd/jCtiogrX12Ioy6whfOJAU3y9m1k7l7cW70JIG+Fm
         Ca5xdpz3VgWvEwzfx678zlvFel4PwLXnZarxoDYD0/CD4p7a4wOEXCoLKEW+ghVwzRUS
         PCtqfP2RgGi7+V+iX+AZvoImf2ieXhPxYjagUGKBRNOMrScdIRA8j9aq1K5+L1HQD4Sl
         rda++dZgGs66cUqhdWsC7o6SS3Ks/ln4rZcxL/cfXmeIo+KSCD+hjhRR3j5Ewb6Q+y8B
         UJjCN6CBI1oJ8Hzq2ekfv8eAvUfWa6CWH0vgkaw6LOoGY7NTmChGhgI4g2DwJUxOA1kz
         b3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743026997; x=1743631797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25Tr7RM7XhHf1JCtkM+bWEr7gcCanZ/l1B2na6DpLrY=;
        b=EMRytNpPpeJSBetJzjSFTNS0vQeO+9oYZ0JjSI4HpnASXXIzpgGodVN64YJiGCOJrf
         WXgRFVxgfoGolk41nmX5L+SvkyvWH2FGO9h7BXYG/pWg71az88gvNKi4Cn983ritjucF
         xgM2aSElRrNqwuYzUPB3QYXMO5nthSEplRGTbPNO331Mn57vOGQS05xt30IsvsbWugrV
         nevDTK+uwqJ47nf9Ci+ljD26gjrn1xN20AR51Pi3K5/iK6k97TTouxkCQnKniDpHaUwe
         sjj6KgnVV57I5g9ssT87RtIwHUCgnEoh5M4o7UcR0knv1SK4kw66sQURAhSEs+pwumcC
         /zGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxleR5oNwQo7SV8hTsRlmt2UDGO9ONUyzGgtHvASQ9PKfKpHrYGJnHIMu7bwdlyQK4Dm+T1Yl0@vger.kernel.org, AJvYcCWKDY38m5VfGk0LJ07aVGUFhYCj/M9174jxGRw3meHwL0EgxDIqz0fi+swWWcxVIAY/ifjMbRO6Kg41uoQNtbI8@vger.kernel.org, AJvYcCWo6rR5PHOu1XlVVThMr4NWdahdatc8N3yzFedHlKVkA4CFymTro5Q+bEvFUcTAN3sK5/uCe+1e+V/aTdAUA+4=@vger.kernel.org, AJvYcCWywqkt2fq4j2ELv/C9JHaAjMnBiwZXnfODfGj4sq/gG7TqUgEgZ+2tYLWrqjFDIUaiEzxgLAgoKR7taZE=@vger.kernel.org, AJvYcCX9g1T5j2VtYsAWGFoQkn9qJfvka0LRu1usnStjIwPp29eOcO9uOIvz9OD1x7gti+dvkJLoC4Umtk3d@vger.kernel.org, AJvYcCXMo3mMrUjLf1kvQh5GGuK6Gcm/7gjny2lXHOdbztCNO2HcFsTWXOwk9mzzRwjLydUMhBhZpuJFNjU3@vger.kernel.org, AJvYcCXy05nECEpnzM8zjSunTd39mnCQKezQcSnxH/2CwJ5rEYFFAO3He8JUMFCfCa5EydxNxBtUbWcnFDfQ0gA+@vger.kernel.org, AJvYcCXypFzzZdXDMuzBUet+Kw7QrQrRKPVTs1YZc6j+mA+JQoKPf5pJl/y3dXx4PQeGmdTy/hWfUkEs9o+d5XNV@vger.kernel.org
X-Gm-Message-State: AOJu0YxitNT2j9+EmgpBzSQEgBHFiWEMkJl/jpJLKXa/u1LG7+9TnddQ
	FjoB9Yo/yv9bgtsIvY3pt79U5B9o1v7CN11ONwAOWu0xxZNpOjXfsiyL2NnzGoEVtDzUAkpqnWZ
	oSptoz6UcBd04FA3lkSGyfuz7G/Y=
X-Gm-Gg: ASbGncszqYk7+OX+x3vd8arnrbRXtlPaOu4YfZ36ZmsCAZSEWMNuZQyIBOwvcksI8ss
	YmpywSGPlRFzUqbZll5iBMvgyJXD3UxXB1RtYr7ds5NNrimApp47Vigx1JduJClx7E7DukK0ks0
	7x9sG7M4ZYhVOjnH+qaLiEF4FWwWg3VP/wmwiatdfh/A==
X-Google-Smtp-Source: AGHT+IHX4HWxiuDcJh6RFBYB0z4mv1VQdnwmt/CKhKHr01wYV9yimExXiWC5KliSOM/5II+nRJgfsPlCyM8KCWUVSdg=
X-Received: by 2002:a2e:9982:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30dc5dd50b1mr5206711fa.18.1743026996866; Wed, 26 Mar 2025
 15:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
 <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
 <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me>
In-Reply-To: <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Mar 2025 18:09:20 -0400
X-Gm-Features: AQ5f1Jr4h_VyjyWTUSlSb_WqvOkQ5GTUuP7SqBZOv0icJYUW2AkHAvgmWwY4H9E
Message-ID: <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com>
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

On Wed, Mar 26, 2025 at 5:09=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 26, 2025 at 8:06 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
> >> > In the current code you're looking at, yes. But in the code I have
> >> > locally I'm transmuting `[u8]` to `BStr`. See my earlier reply where=
 I
> >> > said "Hmm, looking at this again we can just transmute ref-to-ref an=
d
> >> > avoid pointers entirely. We're already doing that in
> >> > `CStr::from_bytes_with_nul_unchecked`".
> >>
> >> `CStr::from_bytes_with_nul_unchecked` does the transmute with
> >> references. That is a usage that the docs of `transmute` explicitly
> >> recommend to change to an `as` cast [1].
> >
> > RIght. That guidance was written in 2016
> > (https://github.com/rust-lang/rust/pull/34609) and doesn't present any
> > rationale for `as` casts being preferred to transmute. I posted a
> > comment in the most relevant issue I could find:
> > https://github.com/rust-lang/rust/issues/34249#issuecomment-2755316610.
>
> Not sure if that's the correct issue, maybe we should post one on the
> UCG (unsafe code guidelines). But before that we probably should ask on
> zulip...
>
> >> No idea about provenance still.
> >
> > Well that's not surprising, nobody was thinking about provenance in
> > 2016. But I really don't think we should blindly follow the advice in
> > this case. It doesn't make an iota of sense to me - does it make sense
> > to you?
>
> For ptr-to-int transmutes, I know that they will probably remove
> provenance, hence I am a bit cautious about using them for ptr-to-ptr or
> ref-to-ref.
>
> >> [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html#alternatives
> >>
> >> >> I tried to find some existing issues about the topic and found that
> >> >> there exists a clippy lint `transmute_ptr_to_ptr`. There is an issu=
e
> >> >> asking for a better justification [1] and it seems like nobody prov=
ided
> >> >> one there. Maybe we should ask the opsem team what happens to prove=
nance
> >> >> when transmuting?
> >> >
> >> > Yeah, we should do this - but again: not relevant in this discussion=
.
> >>
> >> I think it's pretty relevant.
> >
> > It's not relevant because we're no longer talking about transmuting
> > pointer to pointer. The two options are:
> > 1. transmute reference to reference.
> > 2. coerce reference to pointer, `as` cast pointer to pointer (triggers
> > `ptr_as_ptr`), reborrow pointer to reference.
> >
> > If anyone can help me understand why (2) is better than (1), I'd
> > certainly appreciate it.
>
> I am very confident that (2) is correct. With (1) I'm not sure (see
> above), so that's why I mentioned it.

Can you help me understand why you're confident about (2) but not (1)?

