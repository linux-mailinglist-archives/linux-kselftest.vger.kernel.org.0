Return-Path: <linux-kselftest+bounces-28501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70AA56E73
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B680170BD1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493223BD13;
	Fri,  7 Mar 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KoVg3qct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6C21D3FA;
	Fri,  7 Mar 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366698; cv=none; b=gTk/UYjUCVY6AKHhUtiUoDS/Q8WAoQPZmJnZLlIruiiheFrDi+k2L+IqJR3RKdxVv1z/KvgnxYuhnlBLh0TYdni5TYKC70iizV9ouKCqeTYXL7Ahc8AwFbzbPFq/8EuB/AbnE91JhVIuL04vGtPvb2TPOUH13FiRAgV07YpdUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366698; c=relaxed/simple;
	bh=8ZfKGMttq8g+7RETdbLqvlJfh5GTPh/7pkpBAcjkGaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9a6An1c1e38AC8gJU8lqXClPESGohlD4YCT/qtTIs6gZd8uysGoI1KYY2ZJTVWk3sUXOvXWXjlI9dG1wa9sWd+RMGKvCYUxo1gCW9GP6GsppBPj2gIvzJl3ARzJf0n06Sc91SheG58TEyEuEONNRYl2EN/lBuPH5Dp69r0SWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KoVg3qct; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741366689; x=1741625889;
	bh=IJRh7306HT0G/INyJD6xfWIzGNC61ogWPwuQrqZz0sg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KoVg3qctSYhdECxJDuLkssSCJpf2/iKwNuZw2God2r7Bgk04UQy/42mki4KrGcNi9
	 Fa1InOA/obftmq1XitT7c2zgATi14axU8g+boId7FQub3KjBUJmKxDmc9emUu4IZCL
	 6xRd1goIeeJ6hnfRwkNvXFF+Z0Fu9Zg9xBTc3s3W0BMvEa6fvsXv2OpbqMHSzIdjbf
	 g2S3BQKh7lk1x5unXBjiVeXZmcOCicDVGKl4rp0pJMHGgG2CqMa53e5WmNS3dMkPqT
	 ATeP+wH00zHuLqmekxiQ6TMQKNx0CYhQx6nzZy4PMYSvnzMNFowF9kNsJixW0F8eed
	 ao6xho0Tf24Pg==
Date: Fri, 07 Mar 2025 16:58:03 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
In-Reply-To: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5b1486eafd738f5c9cfa5aee3bffacebecbe141f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 5:41 PM CET, Tamir Duberstein wrote:
> In Rust 1.51.0, Clippy introduced the `ignored_unit_patterns` lint [1]:

You link to the `ptr_as_ptr` lint though, is this a typo?

>> Though `as` casts between raw pointers are not terrible,
>> `pointer::cast` is safer because it cannot accidentally change the
>> pointer's mutability, nor cast the pointer to other types like `usize`.
>
> There are a few classes of changes required:
> - Modules generated by bindgen are marked
>   `#[allow(clippy::ptr_as_ptr)]`.
> - Inferred casts (` as _`) are replaced with `.cast()`.
> - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> - Multistep casts from references (` as *const _ as *const T`) are
>   replaced with `let x: *const _ =3D &x;` and `.cast()` or `.cast::<T>()`
>   according to the previous rules. The intermediate `let` binding is
>   required because `(x as *const _).cast::<T>()` results in inference
>   failure.
> - Native literal C strings are replaced with `c_str!().as_char_ptr()`.

These all seem very nice, thanks! I think it would also be a good idea
to enable `ptr_cast_constness` [1], since those are the other kind of
`as` usage that we should be doing via `cast_mut`/`cast_const`.

There are still some legitimate uses of `as` casts, when unsizing
values. I don't know if these two lints can trigger on those, it would
be nice if they don't. So those should continue to use `as`, but other
than that, there shouldn't be any `as` in our code :)

[1]: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_con=
stness

(I will take a look at the patch itself a bit later)

---
Cheers,
Benno

> Apply these changes and enable the lint -- no functional change
> intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_pt=
r [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Makefile                               |  1 +
>  rust/bindings/lib.rs                   |  1 +
>  rust/kernel/alloc/allocator_test.rs    |  2 +-
>  rust/kernel/alloc/kvec.rs              |  4 ++--
>  rust/kernel/device.rs                  |  5 +++--
>  rust/kernel/devres.rs                  |  2 +-
>  rust/kernel/error.rs                   |  2 +-
>  rust/kernel/fs/file.rs                 |  2 +-
>  rust/kernel/kunit.rs                   | 15 +++++++--------
>  rust/kernel/lib.rs                     |  4 ++--
>  rust/kernel/list/impl_list_item_mod.rs |  2 +-
>  rust/kernel/pci.rs                     |  2 +-
>  rust/kernel/platform.rs                |  4 +++-
>  rust/kernel/print.rs                   | 11 +++++------
>  rust/kernel/seq_file.rs                |  3 ++-
>  rust/kernel/str.rs                     |  2 +-
>  rust/kernel/sync/poll.rs               |  2 +-
>  rust/kernel/workqueue.rs               | 10 +++++-----
>  rust/uapi/lib.rs                       |  1 +
>  19 files changed, 40 insertions(+), 35 deletions(-)


