Return-Path: <linux-kselftest+bounces-29820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A70A71C8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CE7163E24
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5161F4190;
	Wed, 26 Mar 2025 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdgj+EHt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776271F4288;
	Wed, 26 Mar 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008283; cv=none; b=oFMNtS8AzXuIJRrBUNVfUfbDTltJLzHyYopsTE1FDkpj8rMX/kuLE3LMda82BBeJjUQ2THEgX4LW9/YtFSXbCTZQ4apB84d5chQCynLmIiSM7oTfuu49ycDOaWhYmfVzeskGaHiiPrTjebD2PiGsvdRhd6iT2FpBcfEcWzrCTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008283; c=relaxed/simple;
	bh=Jt0Xdrm+rScME3lM0LyrrW4w4gFEei0CeD35pgjnb7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrH+DanCISY1Pd4QA1ld/QHuT7IZPVNiXSDn4X8WeFGqePZS+/1frxzJy09t9qCVCZqoo05nHV8bMIUoD0b7V9wGI6/HLqYplQEFEY2LJyCyJyG725G8vIKBekxdMw5YCqre9fpy5UpsgEjyRaTLaPDjRgSwrrUC4mrghuB4MEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdgj+EHt; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf1d48843so954581fa.2;
        Wed, 26 Mar 2025 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743008279; x=1743613079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqICdU+/Fj/rPyvr8c71jUD3Qz8HzL0I+xuDALYEeNo=;
        b=Qdgj+EHtQw8CFiDMTrOv4Bp4l3hFfVXb8eZhGJPaqr8T37dGgf1fWcC28QfsjReQrW
         zqgONs2UPSbqmt1ldwkRO0BrdJHDWnuH8D/8KmdzFKOtwW77R5U6i1GmzB8MpAVe+AVi
         Nc4Z0/p3S2Tyoh2pF7W20letKaWyXpKZG2mDj4nUk5WAUg5TsPpD09UCwynsbZYcDgEm
         ejIY8J7UcYppqIO6Vqh7HOXG7QZZ1F5mcOaVK+fcPLP8X7pNZvZpGg7vbaAX1CO4NPEB
         VSXyBHvhjxAZdpJDl91WJyPv/ikHwiVCcGDD1v7ULQ8Mx89VstM8PNTkiaWt9yV5nhrZ
         HjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008279; x=1743613079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqICdU+/Fj/rPyvr8c71jUD3Qz8HzL0I+xuDALYEeNo=;
        b=aNdpEWrTnorpXqb8VbZpexQUhzpDMRiOReNoy1Q9vj9e33ARpGySd7vZbsal4NH/5O
         gJdivXOHF7/nklP8D74/vuwmCpHEJQVvLrir0cBPHfYEg4rT/CUv/Jr7Fo+Br92AK7am
         cdlix95mU0HrymCOtrroz+NsCAL4OoM8S3vzNcV3gfR/JugEAjvvk6UmF0uq1XkG8U7Y
         7UuAXojQqtoHEWCaBuKQfvP1S27qhqN57z6B1jZI13a2rpbBXKdv25uZFHT0ANVmBZPC
         0EQd60JUvEZOrIw0DnUSzK11lmzXuW1mTaffUuTgFXRzKuCOOTcvCD3aMlviklXWj/2a
         ZWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYRml05JHQMK6q1w6JF+YL+TSZRd+RUujWRjZRXjSUM+yjp/GfsTx85gnNlvh2SAaY/TaE58fSiqM9KrZs@vger.kernel.org, AJvYcCVBoAmuNsSFxdUmQchaN4OiDZy+0rIgGX6368Kr/MEB6IllNfkHuvh+b9w9kYT4KX1BzgNHidNlcs6zLcVrDCA=@vger.kernel.org, AJvYcCW69+KjAvAUopHlghQLRyNEfcMhAjEwjwYvGe0E12mf7QtlHlwsUDxY2UUvjQWgRzjnwQz3Bzcb9ykp@vger.kernel.org, AJvYcCWTKc5JR+a2j+3yRjHNDhe8InVmrU07Uh3rdilKbk0jzC/xbWsdkj4F6NAAXRveTBfOBcw8JMxW@vger.kernel.org, AJvYcCWeaeQaMaPAO6S5Ju6LrY1MQgPWQ1WWRywkCwDBBntXBEKvEgh1Cs9KO2C7uYGl0A5OxRBvxKfW+f2qOFhO@vger.kernel.org, AJvYcCWsFZ32cg2H6DsDMjMQzeboOYFLIXyJkD5VHC/fCfAgIzdm5SlSm/kiEmeASJnYtOfRdM37sGCosrLmKYCC+rIh@vger.kernel.org, AJvYcCXSII6vGoH1eDwVCX3/ACGPuixjU5DxF5GsS4Ms3F4nypYPiYCiY+1nBd6/rt3eH0uf36FD0CRfh9DSo0Y=@vger.kernel.org, AJvYcCXX54MWEvRZ96Bfx2Gwy5v+2BtFhVl7piS0YhC+CQs6OepROhw0smhLS6qPzHVnx82BTiCIpk0Br06a@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZlYYtOjsUfMmveiCG/Rrpox83MJayw8naJLEzUuH8ObnctIl
	P2VjXINMHoVeMwsEF/uMFYDfWm/eb23d0CU0FhS+ElnfNVKbXZ6JuvHxuJEcrpag3eB81tou+aN
	esvNjAAPIthq0FrFOaxl/kciIJaE=
X-Gm-Gg: ASbGncvtmXwAe8P0pED9WoAHxiQJyBsx1lPyALZ0jmTnJg299cxKmXwJtLFtD2bkxXk
	xMGugQJHr/lFz2KXqaCbPSNB5GcVIZstjj1CgT2mLXTFW7H1vDhAT8JXoQBHcmnbE/oSqwgYSPz
	XJRAss0lKWLvKcMPpGTAHxMiYCoL5NP2WKp7WcqOJJlQ==
X-Google-Smtp-Source: AGHT+IHPmamLHlMJlHI8sBUo4uWAXvfGRb8nW0bPTmn1FCPvvjT2j+y8ppF5Dq8MM/1VqdX3RkASobn3JxoYQd4Kpg4=
X-Received: by 2002:a2e:a901:0:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-30dc5f4fc11mr2688291fa.37.1743008279197; Wed, 26 Mar 2025
 09:57:59 -0700 (PDT)
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
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me>
In-Reply-To: <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 26 Mar 2025 12:57:22 -0400
X-Gm-Features: AQ5f1JqRV6BswIsFmo4Lj79OnLQkYDCkrkMtDbiR3sIOJuzkCqt-e4S8pI8XxRU
Message-ID: <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
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

On Wed, Mar 26, 2025 at 12:43=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Wed Mar 26, 2025 at 11:35 AM CET, Tamir Duberstein wrote:
> > On Wed, Mar 26, 2025 at 6:31=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Wed Mar 26, 2025 at 12:54 AM CET, Tamir Duberstein wrote:
> >> > On Tue, Mar 25, 2025 at 6:40=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> On Tue Mar 25, 2025 at 11:33 PM CET, Tamir Duberstein wrote:
> >> >> > On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossi=
n@proton.me> wrote:
> >> >> >> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> >> >> >> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> >> >> >> > index 40034f77fc2f..6233af50bab7 100644
> >> >> >> > --- a/rust/kernel/str.rs
> >> >> >> > +++ b/rust/kernel/str.rs
> >> >> >> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
> >> >> >> >      #[inline]
> >> >> >> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> >> >> >> >          // SAFETY: `BStr` is transparent to `[u8]`.
> >> >> >> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> >> >> >> > +        unsafe { &*(core::mem::transmute::<*const [u8], *cons=
t Self>(bytes)) }
> >> >> >>
> >> >> >> Hmm I'm not sure about using `transmute` here. Yes the types are
> >> >> >> transparent, but I don't think that we should use it here.
> >> >> >
> >> >> > What's your suggestion? I initially tried
> >> >> >
> >> >> > let bytes: *const [u8] =3D bytes;
> >> >> > unsafe { &*bytes.cast() }
> >> >> >
> >> >> > but that doesn't compile because of the implicit Sized bound on p=
ointer::cast.
> >> >>
> >> >> This is AFAIK one of the only places where we cannot get rid of the=
 `as`
> >> >> cast. So:
> >> >>
> >> >>     let bytes: *const [u8] =3D bytes;
> >> >>     // CAST: `BStr` transparently wraps `[u8]`.
> >> >>     let bytes =3D bytes as *const BStr;
> >> >>     // SAFETY: `bytes` is derived from a reference.
> >> >>     unsafe { &*bytes }
> >> >>
> >> >> IMO a `transmute` is worse than an `as` cast :)
> >> >
> >> > Hmm, looking at this again we can just transmute ref-to-ref and avoi=
d
> >> > pointers entirely. We're already doing that in
> >> > `CStr::from_bytes_with_nul_unchecked`
> >> >
> >> > Why is transmute worse than an `as` cast?
> >>
> >> It's right in the docs: "`transmute` should be the absolute last
> >> resort." [1]. IIRC, Gary was a bit more lenient in its use, but I thin=
k
> >> we should avoid it as much as possible such that people copying code o=
r
> >> taking inspiration also don't use it.
> >>
> >> So for both cases I'd prefer an `as` cast.
> >>
> >> [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html
> >
> > I don't follow the logic. The trouble with `as` casts is that they are
> > very lenient in what they allow, and to do these conversions with `as`
> > casts requires ref -> pointer -> pointer -> pointer deref versus a
> > single transmute. The safety comment perfectly describes why it's OK
> > to do: the types are transparent. So why is `as` casting pointers
> > better? It's just as unchecked as transmuting, and worse, it requires
> > a raw pointer dereference.
>
> Note that you're not transmuting `[u8]` to `BStr`, but `*const [u8]` to
> `*const BStr`. Those pointers have provenance and I'm not sure if
> transmuting them preserves it.

In the current code you're looking at, yes. But in the code I have
locally I'm transmuting `[u8]` to `BStr`. See my earlier reply where I
said "Hmm, looking at this again we can just transmute ref-to-ref and
avoid pointers entirely. We're already doing that in
`CStr::from_bytes_with_nul_unchecked`".

> I tried to find some existing issues about the topic and found that
> there exists a clippy lint `transmute_ptr_to_ptr`. There is an issue
> asking for a better justification [1] and it seems like nobody provided
> one there. Maybe we should ask the opsem team what happens to provenance
> when transmuting?

Yeah, we should do this - but again: not relevant in this discussion.

