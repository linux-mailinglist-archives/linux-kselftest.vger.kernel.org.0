Return-Path: <linux-kselftest+bounces-29122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE4A62A2A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84417A4708
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C321F561B;
	Sat, 15 Mar 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lLYkVZ7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529141F4734;
	Sat, 15 Mar 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031296; cv=none; b=ZroaIuDrXZcg+iQUF0RcopMeeV1YU/vLtFAi7B/EnGMmqEB8PQKtQm2ojS/07nEhpXltx/HM5KeK5OKFuMsYAyoR2RVy5A3LG08u80ZLucCY6ihSD6WLBvDgs4ZjjmVJ7IWxqhYIdNapiIUcmDdY9M0pQ8fCajuNQu6lEdx7BUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031296; c=relaxed/simple;
	bh=hNzSGeM9w6XNPYNUplk+W0RxLfc6Ek9uwsXvUt0eEuQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgCI2bpoCz76cYskXm33uTOxQBs7lHjyn7rOXKXWIxp9OKfr4/suqbp4Qsaid9Cj4AWB2AfmJpu8bz5U7tT2Hi0yfJ8IK33/mWtc66TyqKD0u+4if5FjPAvkFdX1iaqCVbEV617J/20PfZFo9tDosvaYnD07fNr1g7uCDF7h4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lLYkVZ7W; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742031287; x=1742290487;
	bh=2YpOaSrR4hSpqfGZqahP1NQlMMYBu1x+CopCGLc8TCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lLYkVZ7WsxbKWWPw215MDyByXyYk2sMT04se/nnfaXXROFTTQ2IrlSeAE0ztiAqqn
	 OAJMwAJKmCPp7LzaOH3hgyMk2JpZ5qM7ODp9RHPOETqJBtRgGmfxmM6jSPhWW2dBum
	 QdU/uZrPPrxz19dkDlwNQyB4lOvKT939syCP5SzdMyrqHac41JwAmDEz0W9IsFOj2u
	 G/OcKTUAbrQ2BBAKsmalD23hOSXZpRBnaHqNPvE2yLBp7VKj9cXBjPwthnAoQecDmX
	 qSzdOY1s8MdTQOTACXkRtiPRb/ZJv1Viox8Of0hdoBQlaeVTq6grwpXwBwJu9Bl6oM
	 1Q/HO8GpE0V+A==
Date: Sat, 15 Mar 2025 09:34:42 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me>
In-Reply-To: <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com> <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5e603b89734b66f978da35e7885d24202eac65c5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 10:54 PM CET, Boqun Feng wrote:
> On Fri, Mar 14, 2025 at 08:28:10AM -0400, Tamir Duberstein wrote:
> [...]
>> --- a/rust/kernel/alloc.rs
>> +++ b/rust/kernel/alloc.rs
>> @@ -217,7 +217,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
>> =20
>>  /// Returns a properly aligned dangling pointer from the given `layout`=
.
>>  pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
>> -    let ptr =3D layout.align() as *mut u8;
>> +    let ptr =3D crate::with_exposed_provenance_mut(layout.align());
>
> Dangling pointers don't have provenance, neither has its provenance been
> exposed. I think should use `without_provenance_mut()` here:
>
> =09https://doc.rust-lang.org/std/ptr/fn.without_provenance_mut.html
>
> see also the source of core::ptr::dangling().

Good catch.

> The rest Rust code changes look good to me. Although I would suggest you
> to split this patch into several patches: you can do the conversion from
> "as" pattern to provenance API one file by one file, and this make it
> easier for people to review. And after the conversions are done, you can
> introduce the Makefile changes.

I think it's fine to do several of the `as` conversions in a single
patch, but splitting off the makefile changes is a good idea.

---
Cheers,
Benno


