Return-Path: <linux-kselftest+bounces-28940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93771A5F41D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A47D17DB0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1702673BA;
	Thu, 13 Mar 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GK71GE4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C263266B5D;
	Thu, 13 Mar 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868421; cv=none; b=sWjBBsEHjWW6eY+NsovhRElRYFz/H9oEql8tAdv7rRJE/m/YJ0jwWn65UcU5ZQA4wzJh8m5HnBOt8kHjzMAzS4Neh3z7IJvGCHhHmUyWErTOUPkjw7AP8w5OgiVOASCxrH2Ds1Pp/WqqcW3apffSig79LfduC5Wr5GmmUkrqKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868421; c=relaxed/simple;
	bh=3iGZSwuLq3yrknLL5RySYUSMhsg9VkT40uzIPuymtTY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=maICDNhW4rWL+nUmSYmJ7AOFGGloATEYI203GxGa5SOGl9SWxXOr+JGa2Uz4vUiDHLc/FnVk2GUY+Jp8LBRCpah8oeWDhGj66p5Vkji1DdzochbgjZpN1Ds5JEMP5K/Im9fnffr0K7JzWG+nXTBmS37D8xPaZe6x6COpGPovc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GK71GE4t; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7xxo62i6crbnlchhsuekovtiea.protonmail; t=1741868416; x=1742127616;
	bh=TathujLwFVMTye6lELcmgVbrxs57jJ//7gvzSyvksPM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=GK71GE4ti4a71r/hc0+htbUWiwqKzC9yioxtJahuey4bUugslOMvEztwq+bQ0lfHa
	 gi5l8l2xFIoGcpOrJDgreVJ3qFVQq7Oq2POsTU38znOQvgAs4MR2y8ZgDbKf95uAEh
	 z1PqPpePqBL4RM8zRvqo8eQBKWR8iOMHKSR9Raz2HKZwGHefGNRoTDaMby3f7dY1vY
	 uDGgnfbycgdXNIuMNgx5SGMHGdMqejzOd/fqhI0XkWPz2HNTD7m6lnF+rUuPDkcTZl
	 uk+xy+ZkylddaxdRx9U44x1m+x5f09eOh5pedWWQwJ/uSQv4GJLKMKztpXs8eQtWIf
	 r0BzW3/UhN5+g==
Date: Thu, 13 Mar 2025 12:20:11 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Benno Lossin <y86-dev@protonmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Message-ID: <D8F4TDZXEN5K.10OKB62YV8AKT@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f64ae2ea4dbafc85decddca94ca7eebb4bcd48cf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 6:33 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` with `&raw place`, and
> all occurrences of `addr_of_mut!(place)` with `&raw mut place`.
>
> Utilizing the new feature will allow us to reduce macro complexity, and
> improve consistency with existing reference syntax as `&raw`, `&raw mut`
> is very similar to `&`, `&mut` making it fit more naturally with other
> existing code.
>
> Depends on: Patch 1/3 0001-rust-enable-raw_ref_op-feature.patch

This information shouldn't be in the commit message. You can put it
below the `---` (that won't end up in the commit message). But since you
sent this as part of a series, you don't need to mention it.

> Suggested-by: Benno Lossin <y86-dev@protonmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  rust/kernel/block/mq/request.rs        |  4 ++--
>  rust/kernel/faux.rs                    |  4 ++--
>  rust/kernel/fs/file.rs                 |  2 +-
>  rust/kernel/init.rs                    |  8 ++++----
>  rust/kernel/init/macros.rs             | 28 +++++++++++++-------------
>  rust/kernel/jump_label.rs              |  4 ++--
>  rust/kernel/kunit.rs                   |  4 ++--
>  rust/kernel/list.rs                    |  2 +-
>  rust/kernel/list/impl_list_item_mod.rs |  6 +++---
>  rust/kernel/net/phy.rs                 |  4 ++--
>  rust/kernel/pci.rs                     |  4 ++--
>  rust/kernel/platform.rs                |  4 +---
>  rust/kernel/rbtree.rs                  | 22 ++++++++++----------
>  rust/kernel/sync/arc.rs                |  2 +-
>  rust/kernel/task.rs                    |  4 ++--
>  rust/kernel/workqueue.rs               |  8 ++++----
>  16 files changed, 54 insertions(+), 56 deletions(-)

[...]

> diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
> index 4e974c768dbd..05d4564714c7 100644
> --- a/rust/kernel/jump_label.rs
> +++ b/rust/kernel/jump_label.rs
> @@ -20,8 +20,8 @@
>  #[macro_export]
>  macro_rules! static_branch_unlikely {
>      ($key:path, $keytyp:ty, $field:ident) =3D> {{
> -        let _key: *const $keytyp =3D ::core::ptr::addr_of!($key);
> -        let _key: *const $crate::bindings::static_key_false =3D ::core::=
ptr::addr_of!((*_key).$field);
> +        let _key: *const $keytyp =3D &raw $key;

This should be `&raw const $key`. I wrote that wrongly in the issue.

> +        let _key: *const $crate::bindings::static_key_false =3D &raw (*_=
key).$field;

Same here.

>          let _key: *const $crate::bindings::static_key =3D _key.cast();
> =20
>          #[cfg(not(CONFIG_JUMP_LABEL))]
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 824da0e9738a..18357dd782ed 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -128,9 +128,9 @@ unsafe impl Sync for UnaryAssert {}
>              unsafe {
>                  $crate::bindings::__kunit_do_failed_assertion(
>                      kunit_test,
> -                    core::ptr::addr_of!(LOCATION.0),
> +                    &raw LOCATION.0,

And here.

>                      $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
> -                    core::ptr::addr_of!(ASSERTION.0.assert),
> +                    &raw ASSERTION.0.assert,

Lastly here as well.

---
Cheers,
Benno


