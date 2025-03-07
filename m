Return-Path: <linux-kselftest+bounces-28503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C1A56E9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1778C7A957B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF822069A;
	Fri,  7 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="e5Un2u01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37C23ED6F
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367067; cv=none; b=XzgQn5tGlwJ1HO2uWZVEYlxjC4qn0/U9xCtQlr+TkyO9Rv7A4GHBUK9okp+5MzQ33Y5PFjxAyGMwhv8pRvovy5i4hgYMbn80eHLaub99pqiApo2zhBDcAG/rgbP2FZLEXttHdjT2cHmev9dkkuyFksKEqi1DZehsBwvM7oydu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367067; c=relaxed/simple;
	bh=LfRUR9imXYSKKvLrl+iJaLiXAiKVHlQDnfUrl+nLo3I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd3I6yhz5EnT8jFrCXnnnDYKyCxXcLlYc4e+VVlg6Aj0P7wV21C2EJZsQ2F9/3tnxbdyiH9/t/M9zMglzi0h669gtMs7bwFUpunidoJgpxoglGKZ0FRW97szi0V4AXgYoVZNib9jH2O6+SRCJcgN0daM0uc3TNX8bGZjTnOWnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=e5Un2u01; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dqbexgxa7zagff75t33ye5vhc4.protonmail; t=1741367063; x=1741626263;
	bh=d+BGEMvZqYX4vzucipFmX/Hq6uMjZnJaUNee9FIc1F4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=e5Un2u01KK8+cr5B6KPxd+KOg5Iynj8Z4vOSmbRKzzonTE4Cpxz27KGuBzdzu2CG0
	 fX1ThyFreLGSfa0fefG3xcSyBvpNxeegn0O+hAmuZgNRdBAZZixfAr/koKgiUdZACi
	 8e9bWTSj2dKVugIkiLUxWsHlIWuUo8SZPVcdU3i+COw9Xg5fbajlxvv94D78GLTiSW
	 aBWPwkkDegCmH+bT1iJ517hfOaPbnePhVuce6bzD1P5sW0QMxi2wbztrxH5hFidd1a
	 FZDoc0IIOiauVmpM4v7jCPS0RcRqSN5Nm7d4F3GM7z0ft+C+/RbJxKrvzjNR+K/gOF
	 xhGghAlABui8A==
Date: Fri, 07 Mar 2025 17:04:20 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <D8A73PQELZV8.24M3P13CM0062@proton.me>
In-Reply-To: <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com> <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2bedca22970b9567596acc03b33f8409cd7d352b
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 5:58 PM CET, Benno Lossin wrote:
> On Fri Mar 7, 2025 at 5:41 PM CET, Tamir Duberstein wrote:
>> In Rust 1.51.0, Clippy introduced the `ignored_unit_patterns` lint [1]:
>
> You link to the `ptr_as_ptr` lint though, is this a typo?
>
>>> Though `as` casts between raw pointers are not terrible,
>>> `pointer::cast` is safer because it cannot accidentally change the
>>> pointer's mutability, nor cast the pointer to other types like `usize`.
>>
>> There are a few classes of changes required:
>> - Modules generated by bindgen are marked
>>   `#[allow(clippy::ptr_as_ptr)]`.
>> - Inferred casts (` as _`) are replaced with `.cast()`.
>> - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
>> - Multistep casts from references (` as *const _ as *const T`) are
>>   replaced with `let x: *const _ =3D &x;` and `.cast()` or `.cast::<T>()=
`
>>   according to the previous rules. The intermediate `let` binding is
>>   required because `(x as *const _).cast::<T>()` results in inference
>>   failure.
>> - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
>
> These all seem very nice, thanks! I think it would also be a good idea
> to enable `ptr_cast_constness` [1], since those are the other kind of
> `as` usage that we should be doing via `cast_mut`/`cast_const`.

I didn't mean to make this sound like you *have* to do the work. If you
find the time and want to do it, then great, otherwise we can turn this
into a good-first-issue :)

---
Cheers,
Benno

> There are still some legitimate uses of `as` casts, when unsizing
> values. I don't know if these two lints can trigger on those, it would
> be nice if they don't. So those should continue to use `as`, but other
> than that, there shouldn't be any `as` in our code :)
>
> [1]: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_c=
onstness
>
> (I will take a look at the patch itself a bit later)
>
> ---
> Cheers,
> Benno
>
>> Apply these changes and enable the lint -- no functional change
>> intended.
>>
>> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_p=
tr [1]
>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> ---
>>  Makefile                               |  1 +
>>  rust/bindings/lib.rs                   |  1 +
>>  rust/kernel/alloc/allocator_test.rs    |  2 +-
>>  rust/kernel/alloc/kvec.rs              |  4 ++--
>>  rust/kernel/device.rs                  |  5 +++--
>>  rust/kernel/devres.rs                  |  2 +-
>>  rust/kernel/error.rs                   |  2 +-
>>  rust/kernel/fs/file.rs                 |  2 +-
>>  rust/kernel/kunit.rs                   | 15 +++++++--------
>>  rust/kernel/lib.rs                     |  4 ++--
>>  rust/kernel/list/impl_list_item_mod.rs |  2 +-
>>  rust/kernel/pci.rs                     |  2 +-
>>  rust/kernel/platform.rs                |  4 +++-
>>  rust/kernel/print.rs                   | 11 +++++------
>>  rust/kernel/seq_file.rs                |  3 ++-
>>  rust/kernel/str.rs                     |  2 +-
>>  rust/kernel/sync/poll.rs               |  2 +-
>>  rust/kernel/workqueue.rs               | 10 +++++-----
>>  rust/uapi/lib.rs                       |  1 +
>>  19 files changed, 40 insertions(+), 35 deletions(-)



