Return-Path: <linux-kselftest+bounces-29787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57200A70B7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B8D17AAF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481426657A;
	Tue, 25 Mar 2025 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NoDVDhB0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5BE242918;
	Tue, 25 Mar 2025 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934560; cv=none; b=WQPmklB2rtMjm1/IZYwo1TeQXEg5qcbZ4fcyPCYbPdD6EyTQoW1pm5tpXHqx/1QHvoZzUeKac0GVYYesmVW2uH5+DgGOZND6+Me0aeEtk5NPsQ2MDDcvsxaPtUkwx/ns+O5xD4Rmn2ek0nduTJl3pQiqs5AJogY+xQlfY390xuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934560; c=relaxed/simple;
	bh=NsitWpF5+dUl6XB3pC20OcXtL3Kh1Nr2StHOUU26Rww=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcQgQdy8RdMfRFJqUTFZPRexG+lQqj69lxxpy1NBdwQp4vfHE4s/qftaJCtlXS4s22pfnCPK/dfynIPnumVllTL6bfHr0JqSrwj3eAz4uLURu9IUtvOmJXNmo6OaDMgwg6GmGi0Tg8kH3IXBAcAsyGQZ1xBwz7xXy0e2Vt9OzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NoDVDhB0; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742934549; x=1743193749;
	bh=fTPMqJdkIWV8h1b6QmmqOOGLsg9Vu94+5wCbSBo1U7M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NoDVDhB0CCmupcRCAvZNSH3l1aD/WNyg9Mg4ubXTk2x9A1WwphRRcBy/NfuIy7beH
	 5xdp33WpCl5Len7Jvp4qcFppKQ9WTY+A7MuM3oOrTENvmDD+q+XmxJbVVtnCk6OPe0
	 JXSZgIjTnagLUB5xZiH/xReFA5Up4rHcSiXJgHZ/gbo81dZg+KdsuxY/MyAkhFNHCV
	 1iW0Q5kvL0EtnlXmT5navgKbHpRNYjA9xcIP2bV1bvcya2U1olC2W/5hDzEDJ02onQ
	 C5Z5jApw9fbSAEaureo70Wul/jT2ZXBjleb8MB+1vDPK/kREjQRv2ktHjxndOedxe/
	 s1gEN5loBVDvg==
Date: Tue, 25 Mar 2025 20:29:01 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8PMQ9AY26ST.1PH9M02PY6JI2@proton.me>
In-Reply-To: <CAJ-ks9mMVzm4m20AxiZ53DyAmSEaEh9veMoVB5XRxmTQP_H_ZQ@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com> <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com> <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me> <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com> <D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me> <CAJ-ks9mMVzm4m20AxiZ53DyAmSEaEh9veMoVB5XRxmTQP_H_ZQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3bb29e99a5a636aa3b2a32b49e8de7a3d3efd080
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 6:17 PM CET, Tamir Duberstein wrote:
> On Tue, Mar 25, 2025 at 11:33=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> On Tue Mar 25, 2025 at 2:34 PM CET, Tamir Duberstein wrote:
>> > On Tue, Mar 25, 2025 at 7:05=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Mon Mar 24, 2025 at 10:59 PM CET, Tamir Duberstein wrote:
>> >> > On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@=
proton.me> wrote:
>> >> >> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
>> >> >> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.loss=
in@proton.me> wrote:
>> >> >> >> I'll leave it up to you what you want to do with this: add it t=
o this
>> >> >> >> series, make a new one, or let someone else handle it. If you d=
on't want
>> >> >> >> to handle it, let me know, then I'll create a good-first-issue =
:)
>> >> >> >
>> >> >> > I'll add a patch for `cast_lossless` -- the rest should probably=
 go
>> >> >> > into an issue.
>> >> >>
>> >> >> Do you mind filing the issue? Then you can decide yourself what yo=
u want
>> >> >> to do yourself vs what you want to leave for others. Feel free to =
copy
>> >> >> from my mail summary.
>> >> >
>> >> > Well, I don't really know what's left to do. We're pretty close at
>> >> > this point to having enabled everything but the nukes. Then there's
>> >> > the strict provenance thing, which I suppose we can write down.
>> >>
>> >> Yes, but there are also these from my original mail:
>> >> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247=
,
>> >>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
>> >>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if t=
here
>> >>   is a clippy lint for this.
>> >
>> > I don't think we should go fixing things for which we don't have a
>> > clippy lint. That way lies madness, particularly as patches begin to
>> > be carried by other trees.
>>
>> There already exists a lint for that: `clippy::ref_as_ptr` (almost
>> created an issue asking for one :)
>
> =F0=9F=AB=A1 picked this one up as well.

Sniped yet again :)

Thanks a lot for adding this one as well.

>> Here is another lint that we probably want to enable (after the `&raw
>> {const,mut}` series lands): `clippy::borrow_as_ptr`.
>
> This sounds like a good one to file.

Since `raw_ref_op` is already enabled in rust-next, I just filed it:

    https://github.com/Rust-for-Linux/linux/issues/1152

---
Cheers,
Benno


