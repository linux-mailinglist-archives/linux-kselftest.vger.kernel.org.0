Return-Path: <linux-kselftest+bounces-29818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58526A71C1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3273018861CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A791F8670;
	Wed, 26 Mar 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iWbHoKQ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583D1BC9E2;
	Wed, 26 Mar 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007420; cv=none; b=gVovTZlkj8MnuWu8EXs6inv4wy4wIBtX+egKuYVydL7z6tRAvOLvDAAq1Rde2uMyJ9GL7xdAVrDPch22CP/xxpfKyZWrUS9g1E1vC4fYDmkRISEDbZ5SkdUfZm3ztO6tSwL244twes9LGr3GgWH6aUDAxUmqHS/7rvnYB2Jz9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007420; c=relaxed/simple;
	bh=dRoILmxBCmB+LmPipcAncHBrEibSROR5ByjhNIYvaEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFVuXq8WsAWrkYcX9onnH7swgHbGtKbL0Rv7GsHOu4ofXx3fUGbtFh3RKLktKnYsLArKfL/YXITtaFCFZC6A+UCSOZUM7dqGR5jdVB1YBIdSxN6vhGlX/h9skPBBL3YS/ze+Dymcxv4EWDTam+1BT1wsLCd0f2bPPUcY62sAUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iWbHoKQ3; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743007415; x=1743266615;
	bh=SBA0lIVlYigqsD6gj5BKr4rg3daBl3KuUvd0a5qoKyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iWbHoKQ3q//lzkeLnbXrpD/K0JBHRvanSfajOeHLvf/ABisj8J8MxZ+5Szf6IAVwz
	 cm6CROl1XHcgLoi0c8f8WF2vZ4BIPsM5D4ffwPzx2P24j7XXDs8bhVLjBqCUUQbi4S
	 LLTPIrty/DypE1RsJLAmhmdT++IBIwQDPOF6RiBEJViq1/YyFB1nebuFXfgkcSS3rv
	 RnwsOHDfYpSHbih8pB5hshb/Yg11MvlDP7va/eqAPI5HhqXjCSJl0zPxG6x0qK8mjB
	 Q4UuBTuuBwVXZquozIs6zNsdDgjSmdtxqbPbriXVgWN6nYRPn8UKI/p8DYLWx1pKoP
	 XcdjKJZB0215Q==
Date: Wed, 26 Mar 2025 16:43:29 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me>
In-Reply-To: <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me> <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com> <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com> <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 56fa6bd54add0cb38181c1a80c576e471517373d
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 11:35 AM CET, Tamir Duberstein wrote:
> On Wed, Mar 26, 2025 at 6:31=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Wed Mar 26, 2025 at 12:54 AM CET, Tamir Duberstein wrote:
>> > On Tue, Mar 25, 2025 at 6:40=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Tue Mar 25, 2025 at 11:33 PM CET, Tamir Duberstein wrote:
>> >> > On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossin@=
proton.me> wrote:
>> >> >> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
>> >> >> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> >> >> > index 40034f77fc2f..6233af50bab7 100644
>> >> >> > --- a/rust/kernel/str.rs
>> >> >> > +++ b/rust/kernel/str.rs
>> >> >> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
>> >> >> >      #[inline]
>> >> >> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
>> >> >> >          // SAFETY: `BStr` is transparent to `[u8]`.
>> >> >> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
>> >> >> > +        unsafe { &*(core::mem::transmute::<*const [u8], *const =
Self>(bytes)) }
>> >> >>
>> >> >> Hmm I'm not sure about using `transmute` here. Yes the types are
>> >> >> transparent, but I don't think that we should use it here.
>> >> >
>> >> > What's your suggestion? I initially tried
>> >> >
>> >> > let bytes: *const [u8] =3D bytes;
>> >> > unsafe { &*bytes.cast() }
>> >> >
>> >> > but that doesn't compile because of the implicit Sized bound on poi=
nter::cast.
>> >>
>> >> This is AFAIK one of the only places where we cannot get rid of the `=
as`
>> >> cast. So:
>> >>
>> >>     let bytes: *const [u8] =3D bytes;
>> >>     // CAST: `BStr` transparently wraps `[u8]`.
>> >>     let bytes =3D bytes as *const BStr;
>> >>     // SAFETY: `bytes` is derived from a reference.
>> >>     unsafe { &*bytes }
>> >>
>> >> IMO a `transmute` is worse than an `as` cast :)
>> >
>> > Hmm, looking at this again we can just transmute ref-to-ref and avoid
>> > pointers entirely. We're already doing that in
>> > `CStr::from_bytes_with_nul_unchecked`
>> >
>> > Why is transmute worse than an `as` cast?
>>
>> It's right in the docs: "`transmute` should be the absolute last
>> resort." [1]. IIRC, Gary was a bit more lenient in its use, but I think
>> we should avoid it as much as possible such that people copying code or
>> taking inspiration also don't use it.
>>
>> So for both cases I'd prefer an `as` cast.
>>
>> [1]: https://doc.rust-lang.org/std/mem/fn.transmute.html
>
> I don't follow the logic. The trouble with `as` casts is that they are
> very lenient in what they allow, and to do these conversions with `as`
> casts requires ref -> pointer -> pointer -> pointer deref versus a
> single transmute. The safety comment perfectly describes why it's OK
> to do: the types are transparent. So why is `as` casting pointers
> better? It's just as unchecked as transmuting, and worse, it requires
> a raw pointer dereference.

Note that you're not transmuting `[u8]` to `BStr`, but `*const [u8]` to
`*const BStr`. Those pointers have provenance and I'm not sure if
transmuting them preserves it.

I tried to find some existing issues about the topic and found that
there exists a clippy lint `transmute_ptr_to_ptr`. There is an issue
asking for a better justification [1] and it seems like nobody provided
one there. Maybe we should ask the opsem team what happens to provenance
when transmuting?

[1]: https://github.com/rust-lang/rust-clippy/issues/6372

---
Cheers,
Benno


