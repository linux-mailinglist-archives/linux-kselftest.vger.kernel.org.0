Return-Path: <linux-kselftest+bounces-28812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7902A5DF37
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5937ADD03
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807562505CA;
	Wed, 12 Mar 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="igs2XxEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DF242927;
	Wed, 12 Mar 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790411; cv=none; b=Wlms2/3Av3pKTtalxry4a5d64ap6SBnvk3ZkMTfv65qpykAH5PhPB84RMTeJoVKqZj5Aul9WtgSb8jsrvK5oluRHE6cRgC1XPhOJK9WEC3end/wbWZ8kE983IQWM6G/PbiSm6rhsIdjfxA1LzzkULlEcQBMmSjSyaFKW8k1b+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790411; c=relaxed/simple;
	bh=Fi/xls1kSt18tedNUCc6ZZh7/Q3+KsdT4mWnx7Ose1s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLR4oW8tAqM9V1+zvaXOzg0Rb1Kit1QD+JpJ2WV0+qViBi99N5FsHJd6+koGtbUgHPTE3jXEqUUqrUfBsJJYatC6jPNAC5JZqXtbzLIKcq1RCyvwZcJbKlEvK0UM6K/Ncnd1aohIg4TMPAP1f0LJ1Op4bfPFZGBoE0w4TLK+KsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=igs2XxEz; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741790406; x=1742049606;
	bh=ln7+3zkl6JCWdcMdIgyVOnjSeIR+wlhx+5g0dVF9NAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=igs2XxEzdhhAm6M2XBHYRc+ZpZhhqIJ8cnmEd9XPVyUS6FPIBc0clFccpxH1jnbjB
	 Zvgd0MqYs+Vatdh9rW5h0bdJBJZLiz4NQYRnbYHQOR2QKnnVIB29kohar1RmRFshCN
	 Wgnmm2Tdz08mHYdI0hLq7B1CDFt82uNlE76P51c3qeb/2e5trtutknGowYz+uIyAvL
	 2xgwfyMPNgGu0hljClBe2qdCMKqmpiew5GX1T2uocwd/+KJ1LVnm86GLYm4RQRU1aW
	 LxSl+DhoPfxI4XJgp7Yz8vZEVR47xLCAeeR+MGxVAaW+c49n8eqo04Sti1OimU3Fa9
	 AbU5MaXucOkQQ==
Date: Wed, 12 Mar 2025 14:39:59 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <D8ED5UWKL2N1.2JPWVV0297BJ0@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-2-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-2-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cfdcac70a4dffef0ce337ad830841016c81e6356
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> In Rust 1.51.0, Clippy introduced the `ptr_as_ptr` lint [1]:
>
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

Similarly to the other patch, this could be `let x =3D &raw x;`. (but it's
fine to leave it as-is for now, we can also make that a
good-first-issue.)

>   according to the previous rules. The intermediate `let` binding is
>   required because `(x as *const _).cast::<T>()` results in inference
>   failure.
> - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
>
> Apply these changes and enable the lint -- no functional change
> intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_pt=
r [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

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
>  rust/kernel/list/impl_list_item_mod.rs |  2 +-
>  rust/kernel/pci.rs                     |  2 +-
>  rust/kernel/platform.rs                |  4 +++-
>  rust/kernel/print.rs                   | 11 +++++------
>  rust/kernel/seq_file.rs                |  3 ++-
>  rust/kernel/str.rs                     |  2 +-
>  rust/kernel/sync/poll.rs               |  2 +-
>  rust/kernel/workqueue.rs               | 10 +++++-----
>  rust/uapi/lib.rs                       |  1 +
>  18 files changed, 38 insertions(+), 33 deletions(-)


