Return-Path: <linux-kselftest+bounces-28811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1835A5DED3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D5E17A718
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164424E019;
	Wed, 12 Mar 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AELYw4fM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74024A062;
	Wed, 12 Mar 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789370; cv=none; b=JbSxd1u7G2/7na9VXoTl26AtgtUsj/Gr5LLePhDwRgWhuaPLVNxzmiVezESZiAnEgiGqtPxeZj5XRxJAB6r79ZCAWud5smWWhbxzP9fscFLwlKe6bVaHAxEX/B65CzCO7IlaqTdcioiQKPtHMobCagmgzfBhVWbPMGtahrghFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789370; c=relaxed/simple;
	bh=5zIB9aP4MjZVZbVwkvtMy8bZT0SBYH8T7xQXJLwcGRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIufARffDV5POpuvfWywAMBk7krPz2hp1LGa9hghTh6ImfMIReQIX1mvVHVn3y12lX4Nk0Ed5c7LwZC/pgvXS/fbkIaFspl/7Bbimj7ueFAnya9RloKzzYF4Z2kUAzCFymOKG94UgCPgFLlo5iD1WgMlkxXEET/Hd9nBPFkJnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AELYw4fM; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bqwn6hkv25epfihij5ctljfsnu.protonmail; t=1741789360; x=1742048560;
	bh=lpMoYYhCby2+h930TAwepOJMN45pAXmhdXKYFNY3rBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AELYw4fMwrmf0lwSNSt1YDmhebSHR9WcORDIYt0JUDXOt4hlNwtokvjC+7uebmJ34
	 i9XkNLKy2r83wsepgZTQ3Mhy88Ptt9tWqegrUtliRiz4vFOaqH3rtlEcIrPUXxOjG3
	 BTvPbiX9AT31ZUqxdc6KQJx+hCinuSSFlwVc6Ui5p3hGnKsw2/EfF/O6xwVCPm9KD+
	 YiWEHOkwRt88tMvA3ksF3WfXM31SqGUcdqWnnxv8hAdQcRXlYA3DJKfOPkVC4GQSeZ
	 1cY1Vhd1HXWvQyUoCM++3MlIe6eM57VYkXZbVGxAle5cIo37MNE2bYw65EBh6Xknyn
	 jLIB5LpcyZ+/A==
Date: Wed, 12 Mar 2025 14:22:31 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] rust: retain pointer mut-ness in `container_of!`
Message-ID: <D8ECSHQTFGM5.E4N1XJBDTJUY@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-1-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-1-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: da106fb69e93b9a459d540ee0cf6831ad932bfee
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> Avoid casting the input pointer to `*const _`, allowing the output
> pointer to be `*mut` if the input is `*mut`. This allows a number of
> `*const` to `*mut` conversions to be removed at the cost of slightly
> worse ergonomics when the macro is used with a reference rather than a
> pointer; the only example of this was in the macro's own doctest.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

One tiny nit below, but even without that:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/lib.rs      |  5 ++---
>  rust/kernel/pci.rs      |  2 +-
>  rust/kernel/platform.rs |  2 +-
>  rust/kernel/rbtree.rs   | 23 ++++++++++-------------
>  4 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7697c60b2d1a..9cd6b6864739 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -187,7 +187,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>  /// }
>  ///
>  /// let test =3D Test { a: 10, b: 20 };
> -/// let b_ptr =3D &test.b;
> +/// let b_ptr: *const _ =3D &test.b;

You could also use `&raw test.b` to get a pointer instead of relying on
the pointer coercion. That syntax is stable since 1.82.0, so older
compilers would need to enable the `raw_ref_op` feature.

I created an orthogonal good-first-issue for changing uses of
`addr_of[_mut]!` to `&raw [mut]`, so maybe that can also be done there:

    https://github.com/Rust-for-Linux/linux/issues/1148

---
Cheers,
Benno


