Return-Path: <linux-kselftest+bounces-29812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F5A714E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AABB1739EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80D1B6D11;
	Wed, 26 Mar 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ViqpvZj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FD19C569;
	Wed, 26 Mar 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985069; cv=none; b=htyH/4e0KIJXuxwzoOjYBjcH7utLtV6y+zxs/lAFaXlJ93GzfDtLgHFzG615mjRX2gVRllOs9ONVMtX6RvpgamPDR279i27ac1ovimnOtDX+Y03+YjZGXdKah+KkZoErKq9OQusurIcI/G6jmEAUgwXi8ZC/fb15Qu13PslJEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985069; c=relaxed/simple;
	bh=pSoI1WGaycGSmBtCOUNQSjGw+nskVB7jyyqdbGzX9pE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncvpb7w7tbUILWIH+762f9hHpsIRPMeKu4tBtTYdkWEhGHNSKL9ULCDREtHtfJUpCSscC6GBi1QXuydvV9bkBTtu93ZLO6jhWA9kmhKCL4PfhvXlpVU9H5f19vEY5CQfKT6j0VSJoTiobUv9AW/HCTyFbGd86UlUwefu/Nlow5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ViqpvZj2; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742985064; x=1743244264;
	bh=PD6QsKlbd/UTEIZFjdWL2INF7cdUTBh6ExeiHs8aHeE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ViqpvZj2DYShZqRsjkXRHya7dm+a8V1pJaSqmByjF0GxUAhLHBw9zK8OGj2tJfKYn
	 W22bKXuOek30uCw7TONhJ+SsJ5O2t36d68I0KUmw1yXcEV0uuTtKPD0yOVbeuOSTeB
	 eGeVXA9Js4rg17xXT76DaF91riSkaGXNVfpX6+zdJxwt16NqaSXUZGFh6s1LLN5KEU
	 gflg5QvG69rpxM1yFrnnlcWKeat+CI7hMkQ/PiLfWdwH2ouVQcYV6hfwWt4oXPjVxq
	 OP5L7EM+1YJYcwmU6Bqj6wY6i2ytPo1CNgJx1tbMtBTTsAOpafptEC3pI24CS7+euR
	 W1EGIj+3YmK+Q==
Date: Wed, 26 Mar 2025 10:30:56 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me>
In-Reply-To: <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me> <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com> <D8PPIYIJCNX8.13VPQULEI0ALN@proton.me> <CAJ-ks9k6220j6CQSOF4TDrgY9qq4PfV9uaMXz1Qk4m=eeSr5Ag@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e50c9b550854ec00eb95a773d66c999d39fa5c32
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 12:54 AM CET, Tamir Duberstein wrote:
> On Tue, Mar 25, 2025 at 6:40=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Tue Mar 25, 2025 at 11:33 PM CET, Tamir Duberstein wrote:
>> > On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
>> >> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
>> >> > index 40034f77fc2f..6233af50bab7 100644
>> >> > --- a/rust/kernel/str.rs
>> >> > +++ b/rust/kernel/str.rs
>> >> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
>> >> >      #[inline]
>> >> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
>> >> >          // SAFETY: `BStr` is transparent to `[u8]`.
>> >> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
>> >> > +        unsafe { &*(core::mem::transmute::<*const [u8], *const Sel=
f>(bytes)) }
>> >>
>> >> Hmm I'm not sure about using `transmute` here. Yes the types are
>> >> transparent, but I don't think that we should use it here.
>> >
>> > What's your suggestion? I initially tried
>> >
>> > let bytes: *const [u8] =3D bytes;
>> > unsafe { &*bytes.cast() }
>> >
>> > but that doesn't compile because of the implicit Sized bound on pointe=
r::cast.
>>
>> This is AFAIK one of the only places where we cannot get rid of the `as`
>> cast. So:
>>
>>     let bytes: *const [u8] =3D bytes;
>>     // CAST: `BStr` transparently wraps `[u8]`.
>>     let bytes =3D bytes as *const BStr;
>>     // SAFETY: `bytes` is derived from a reference.
>>     unsafe { &*bytes }
>>
>> IMO a `transmute` is worse than an `as` cast :)
>
> Hmm, looking at this again we can just transmute ref-to-ref and avoid
> pointers entirely. We're already doing that in
> `CStr::from_bytes_with_nul_unchecked`
>
> Why is transmute worse than an `as` cast?

It's right in the docs: "`transmute` should be the absolute last
resort." [1]. IIRC, Gary was a bit more lenient in its use, but I think
we should avoid it as much as possible such that people copying code or
taking inspiration also don't use it.

So for both cases I'd prefer an `as` cast.

[1]: https://doc.rust-lang.org/std/mem/fn.transmute.html

---
Cheers,
Benno


