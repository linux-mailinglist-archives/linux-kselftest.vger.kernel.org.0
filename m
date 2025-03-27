Return-Path: <linux-kselftest+bounces-29873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F03A740AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 23:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1AC17B035
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6A1DE4D4;
	Thu, 27 Mar 2025 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jic0rZP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD161C6FED;
	Thu, 27 Mar 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113842; cv=none; b=G7FH4APpwoFIt39hWpKwVT41nGngMPqn3ay4dGCKTbaDfd+CQn17ZNGv3qLGovtplAHY5gmUrAtz5L5hsa1a3H4ERJfGiLX8fSGMKI+e6cCErpjtYZr6RYCaTU3eLqCVI8lrzfHfyQczX4ceN+IuMNiWJZqmjOR5U+5WfoEvyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113842; c=relaxed/simple;
	bh=89psVsuhmLnpB0D1Kli4UHQLPn+imufHphtlmAmXIs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yj1jiFYyPNoKQl+l+O+b07F1z86xYEMDAGueip+THKLPuwU85vKsUxH0oxueoiDnTWO/XfUV6VjTXd+EbMJgeTElPUnDAhNwoyIC+ZhiRge+GXJQEkZWqdADZ8GFqTU0feCecPqyzxNL8C0Xs6JKcrIiwXO6mqx+EPYVBwe2GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jic0rZP8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743113838; x=1743373038;
	bh=pOr0DNwW22udl+QjNXdk6JXxuaFTQiZdJAYlJD9wBnM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jic0rZP8jIRDUlYJVFn/WyH0SzSXhx/zI69q9kX7QeIHgrcfENJqk0J8WRHjnVLi8
	 NYQ1OQjEs2l7GGNjObJEnLrPxDYndr08EDpfs5TYJPPr+lShwi3LeLeDuagfKMTX0v
	 UXJnlwsDLJtsylUVLqPjRLZYRG8dDGGuGYSii/uS3sv0xX1IDXSgSC7+Wz31lLkvL2
	 5BnTTLJTUPFluto7iYwREkzHvpTxJGSFCr0IhBxuyRScrQ9B5ClXkGkU0BdIv7WVEx
	 65PCUwy1qRK0ngPc/CSLFvWJ2GfvoP8cmalbSSqimzg1t97SUicTxDSvJk0LsHlwll
	 zekMJyBpIF4Pg==
Date: Thu, 27 Mar 2025 22:17:13 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D8REA6VW7QFS.Y5195VX38USO@proton.me>
In-Reply-To: <CAJ-ks9n3BdKkfCpMXhE8M8Sx4B5rASoNvbmA4zPU3rmPQwZCiQ@mail.gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com> <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com> <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me> <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com> <D8QJMH5UR6VG.2OT5MXJJQU5QT@proton.me> <CAJ-ks9m96vf_HxttuopuC_UfNGJbHHNdEGS2er6nZZG38pe3HQ@mail.gmail.com> <CAJ-ks9n3BdKkfCpMXhE8M8Sx4B5rASoNvbmA4zPU3rmPQwZCiQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 82a53baabf13e0ce95fda485724e51f17f7c7368
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 27, 2025 at 8:44 PM CET, Tamir Duberstein wrote:
> On Thu, Mar 27, 2025 at 10:15=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
>> On Wed, Mar 26, 2025 at 6:15=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> > On Wed Mar 26, 2025 at 11:09 PM CET, Tamir Duberstein wrote:
>> > > On Wed, Mar 26, 2025 at 5:09=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
>> > >> On Wed Mar 26, 2025 at 8:06 PM CET, Tamir Duberstein wrote:
>> > >> > On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossi=
n@proton.me> wrote:
>> > >> >> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
>> > >> >> >
>> > >> >> > Yeah, we should do this - but again: not relevant in this disc=
ussion.
>> > >> >>
>> > >> >> I think it's pretty relevant.
>> > >> >
>> > >> > It's not relevant because we're no longer talking about transmuti=
ng
>> > >> > pointer to pointer. The two options are:
>> > >> > 1. transmute reference to reference.
>> > >> > 2. coerce reference to pointer, `as` cast pointer to pointer (tri=
ggers
>> > >> > `ptr_as_ptr`), reborrow pointer to reference.
>> > >> >
>> > >> > If anyone can help me understand why (2) is better than (1), I'd
>> > >> > certainly appreciate it.
>> > >>
>> > >> I am very confident that (2) is correct. With (1) I'm not sure (see
>> > >> above), so that's why I mentioned it.
>> > >
>> > > Can you help me understand why you're confident about (2) but not (1=
)?
>> >
>> > My explanation from above explains why I'm not confident about (1):
>> >
>> >     For ptr-to-int transmutes, I know that they will probably remove
>> >     provenance, hence I am a bit cautious about using them for ptr-to-=
ptr or
>> >     ref-to-ref.
>> >
>> > The reason I'm confident about (2) is that that is the canonical way t=
o
>> > cast the type of a reference pointing to an `!Sized` value.
>>
>> Do you have a citation, other than the transmute doc?

Not that I am aware of anything.

> Turns out this appeases clippy:
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 80a9782b1c6e..7a6fc78fc314 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -240,9 +240,10 @@ pub fn read_raw(&mut self, out: &mut
> [MaybeUninit<u8>]) -> Result {
>      /// Fails with [`EFAULT`] if the read happens on a bad address,
> or if the read goes out of
>      /// bounds of this [`UserSliceReader`]. This call may modify
> `out` even if it returns an error.
>      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> +        let out: *mut [u8] =3D out;
>          // SAFETY: The types are compatible and `read_raw` doesn't
> write uninitialized bytes to
>          // `out`.
> -        let out =3D unsafe { &mut *(out as *mut [u8] as *mut
> [MaybeUninit<u8>]) };
> +        let out =3D unsafe { &mut *(out as *mut [MaybeUninit<u8>]) };
>          self.read_raw(out)
>      }

Seems like your email client auto-wrapped that :(

> Benno, would that work for you? Same in str.rs, of course.

For this specific case, I do have a `cast_slice_mut` function I
mentioned in the other thread, but that is still stuck in the untrusted
data series, I hope that it's ready tomorrow or maybe next week. I'd
prefer if we use that (since its implementation also doesn't use `as`
casts :). But if you can't wait, then the above is fine.

---
Cheers,
Benno


