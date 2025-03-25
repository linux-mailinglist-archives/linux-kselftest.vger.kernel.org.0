Return-Path: <linux-kselftest+bounces-29741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E6A6EEA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3471888C84
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA3255248;
	Tue, 25 Mar 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GvzDdMjA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAD19F12D;
	Tue, 25 Mar 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900749; cv=none; b=CdM4EA4etaynO84uyZbwCRsvLN6i95FcvzNJ21FaNegD0ibqdDCiXcF6VxxsrrMTPEdsa4NYo+s920qsXE8kdWOuJ5R8wP7zEfJ06sh7xnpcxidtfElaujtAgNpqwdq+IZiuptUwqnwZRJYekM4nSeCXPSSltE2nr1HkTrPKevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900749; c=relaxed/simple;
	bh=RE1crkjfDMTRfO9l+NkEoKH5Q2VQv5QCMnn24nrgW2Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYKeBZPtuDmK0OEk9vWtGvx2TJXAl1ldl7VGD8jOEAd6dPtpJ5p35fS1ko8NFunY1YJ9DFH8WaW0rXkRbroGRXXSzhI8DWK2PYJfUQh5Fb4QBg4iirNvJvezFvngB2z21SN/KY+adyUVgN+OwgqdVoGWtrU75R8fOED6uPZMaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GvzDdMjA; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hkgfeukzircddjyssmulfeqlhi.protonmail; t=1742900744; x=1743159944;
	bh=ZTrBETovGBbpxaZItuToVrfYc/UT5EF5gB+KAeul71U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GvzDdMjAUG7NS1sIsIN2ySv/tEePVztcY+FA/xzy7VQx0a3x+TFR30bbwt2Eu10wU
	 CGFA0AkdW+g9/NNAC4Wc9SA7LUHKsA30BQuzj9bqyZSmTnFEf7nV7RHigfUJakwEnd
	 3h2OVFvIvBXZ0VDaaU1b+5wR041AqHZlk8B2jz6SRvOQKzImecs5GrSEVFRvuokfsj
	 9oiWa9J/5keCoKrgomvku1hsfe9iQyjKB/LaxECf5adMnVsnnQ5aGDqlmeEfwPke9Y
	 7gPPw50JJ9ssVhSVR3QE7wXr9ivWCGrPqOU+qieHTem5y/S6pG3Lb1hnTBLklO7Aao
	 D3SMfk/3USJPw==
Date: Tue, 25 Mar 2025 11:05:40 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me>
In-Reply-To: <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com> <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 43fd8f7124349bec9ba6525a35e3b09516fe44d7
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 10:59 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
>> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> * `cast_lossless` (maybe this catches some of the `num as int_type`
>> >>   conversions I mentioned above)
>> >
>> > Yeah, suggested the same above. I had hoped this would deal with the
>> > char as u32 pattern but it did not.
>>
>> Aw that's a shame. Maybe we should create a clippy issue for that,
>> thoughts?
>
> Yeah, it's not clear to me why it isn't covered by `cast_lossless`.
> Might just be a bug. Want to file it?

Done: https://github.com/rust-lang/rust-clippy/issues/14469

>> >> I'll leave it up to you what you want to do with this: add it to this
>> >> series, make a new one, or let someone else handle it. If you don't w=
ant
>> >> to handle it, let me know, then I'll create a good-first-issue :)
>> >
>> > I'll add a patch for `cast_lossless` -- the rest should probably go
>> > into an issue.
>>
>> Do you mind filing the issue? Then you can decide yourself what you want
>> to do yourself vs what you want to leave for others. Feel free to copy
>> from my mail summary.
>
> Well, I don't really know what's left to do. We're pretty close at
> this point to having enabled everything but the nukes. Then there's
> the strict provenance thing, which I suppose we can write down.

Yes, but there are also these from my original mail:
* `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
  rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
  replace with `let ptr: *const ... =3D shared_ref;`. Don't know if there
  is a clippy lint for this.

And the other points (haven't taken a look at the other series you
submitted, so I don't know to what extend you fixed the other `as` casts
I mentioned). So I figured you might know which ones we still have after
applying all your patches :)

---
Cheers,
Benno


