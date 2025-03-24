Return-Path: <linux-kselftest+bounces-29701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BDA6E3FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C61816FA94
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B01A0BED;
	Mon, 24 Mar 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TI71ew07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B02A1CA;
	Mon, 24 Mar 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847389; cv=none; b=RVR+gtI5s5cV7VaQwXkYZFkDm1XnvQv32njsqqlqNoZvI/bXEObcmc1NV6BK5H1A2PxBCBxEKulY91HmpNWmtWH7N7hTNl94jnJpgiZYQpG5PHIX/Iz5N0tlDGxogrCtF0ZAHjfS/pIgpicoE8INkxJdF2sNDKZOHS0dzsXTHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847389; c=relaxed/simple;
	bh=pi/J5f+zxa5+vr4I4x8F+Q+w3M7QcKQqlVHWcxr7Mbc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af/gdKfaKjNWLPBtosrAWc8Q9R2wZsAre+yKCKhwKn+abUFub7GzYkveaTP4TA4i4MPcbSV7TCDLhuZyo0O08TOY2sWjSwDcmvZnlmwV3uiGGN/4yJc72UsLFMY7cVq1r/cGIkZMaJWsWiWYYZgJ2bLd9pyh1k+gatIaqtjZbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TI71ew07; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742847380; x=1743106580;
	bh=5zkri0TfwaVQ5Do9MmCdBt/y8+WtBGC8HaDSalWQ/b8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TI71ew073ff2IQeYGaFDBN5e4BpGTt+SQkDr3Gkx+pNBx1wepjbufC3naVIb0fTMo
	 J2yr7/mP9FptcD9UZh5KkLdy+CarcuEfod41sZ3T24kmeQSSMoeWGVSmafgHR/6KBJ
	 J29pRX64HDAQU0ukZj2mUOBhTIO8UNETpQgZs/eGfIS4WLTI8KO8Lw0tooKRx+TDdE
	 ZLlUBETcRMBO7pIfsQc0d+rlN/I9yBKB0Vom9Rl01ucsiWJhLsG1GCy3nMuXHvBInX
	 dRHApYxwuXhZH/un8+cFYrQfOFEOtO5JPJH/8s50xSt9+q4265ZNup+5zk0vSxihPO
	 KYVjDrnsAN9dQ==
Date: Mon, 24 Mar 2025 20:16:15 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
Message-ID: <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 389621328b72d358f474de1a56bb51cdd22e9db2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
> Lossin suggested I also look into `clippy::ptr_cast_constness` and I
> discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
> lints. It also enables `clippy::as_underscore` which ensures other
> pointer casts weren't missed. The first commit reduces the need for
> pointer casts and is shared with another series[1].
>
> The final patch also enables pointer provenance lints and fixes
> violations. See that commit message for details. The build system
> portion of that commit is pretty messy but I couldn't find a better way
> to convincingly ensure that these lints were applied globally.
> Suggestions would be very welcome.

I applied the patches to v6.14-rc7 and did a quick pass with

    rg -nC 3 -t rust ' as ' | bat -l rust

to see if there are any cases left that we could fix and I found a
couple:

* there are several cases of `number as int_type` (like `num as c_int`
  or `my_u32 as usize` etc.) not sure what we can do about these, some
  are probably unavoidable, but since the kernel doesn't support 16 bit
  systems (that is true, right?), we *could* have a `From<u32> for
  usize` impl...
* some instances of `'|' as u32` (samples/rust/rust_misc_device.rs:112).
  There is a `From<char> for u32` impl, so this can just be replaced
  with `.into()` (or maybe by using a byte literal `b'|'`?).
* `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
  rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
  replace with `let ptr: *const ... =3D shared_ref;`. Don't know if there
  is a clippy lint for this.
* some pointer casts in rust/kernel/list/impl_list_item_mod.rs:{253,254}
  not sure if they can be converted though (maybe they are unsizing the
  pointer?)
  Another pointer cast in rust/kernel/driver.rs:81 (I'm pretty sure this
  one can be replaced by a `.cast()`)

Some clippy lints that we could also enable that share the spirit of
this series:

* `char_lit_as_u8` (maybe that also covers the `'|' as u32` case from
  above?)
* `cast_lossless` (maybe this catches some of the `num as int_type`
  conversions I mentioned above)

I'll leave it up to you what you want to do with this: add it to this
series, make a new one, or let someone else handle it. If you don't want
to handle it, let me know, then I'll create a good-first-issue :)

> ---
> Tamir Duberstein (6):
>       rust: retain pointer mut-ness in `container_of!`
>       rust: enable `clippy::ptr_as_ptr` lint
>       rust: enable `clippy::ptr_cast_constness` lint
>       rust: enable `clippy::as_ptr_cast_mut` lint
>       rust: enable `clippy::as_underscore` lint
>       rust: use strict provenance APIs
>
>  Makefile                               |   4 ++
>  init/Kconfig                           |   3 +
>  rust/bindings/lib.rs                   |   1 +
>  rust/kernel/alloc.rs                   |   2 +-
>  rust/kernel/alloc/allocator_test.rs    |   2 +-
>  rust/kernel/alloc/kvec.rs              |   4 +-
>  rust/kernel/block/mq/operations.rs     |   2 +-
>  rust/kernel/block/mq/request.rs        |   7 +-
>  rust/kernel/device.rs                  |   5 +-
>  rust/kernel/device_id.rs               |   2 +-
>  rust/kernel/devres.rs                  |  19 +++---
>  rust/kernel/error.rs                   |   2 +-
>  rust/kernel/firmware.rs                |   3 +-
>  rust/kernel/fs/file.rs                 |   2 +-
>  rust/kernel/io.rs                      |  16 ++---
>  rust/kernel/kunit.rs                   |  15 ++---
>  rust/kernel/lib.rs                     | 113 +++++++++++++++++++++++++++=
+++++-
>  rust/kernel/list/impl_list_item_mod.rs |   2 +-
>  rust/kernel/miscdevice.rs              |   2 +-
>  rust/kernel/of.rs                      |   6 +-
>  rust/kernel/pci.rs                     |  15 +++--
>  rust/kernel/platform.rs                |   6 +-
>  rust/kernel/print.rs                   |  11 ++--
>  rust/kernel/rbtree.rs                  |  23 +++----
>  rust/kernel/seq_file.rs                |   3 +-
>  rust/kernel/str.rs                     |  18 ++----
>  rust/kernel/sync/poll.rs               |   2 +-
>  rust/kernel/uaccess.rs                 |  12 ++--
>  rust/kernel/workqueue.rs               |  12 ++--
>  rust/uapi/lib.rs                       |   1 +
>  30 files changed, 218 insertions(+), 97 deletions(-)
> ---
> base-commit: 498f7ee4773f22924f00630136da8575f38954e8

Btw I didn't find this commit anywhere I usually check, where is it
from?

---
Cheers,
Benno

> change-id: 20250307-ptr-as-ptr-21b1867fc4d4


