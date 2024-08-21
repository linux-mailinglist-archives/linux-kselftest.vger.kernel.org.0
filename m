Return-Path: <linux-kselftest+bounces-15902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DEA95A510
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A281C21B92
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C240716DED2;
	Wed, 21 Aug 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VMRw2/hr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D616DC20;
	Wed, 21 Aug 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267290; cv=none; b=Ms5Wb6fd12PXAz8CgdHbXYxpXm2bFuciZwvehNy89/p3+U4ykFQ5Olw4sylERVnvjh+Q3YRcBO9Qi5q57ckMS93meKfa95v5OWPhFmj+Q58xynTpuLmYFV2ijRF7KxAnuc7F5f9KTiHl0iwao9+ORTeRxUqZyiwuBz0mOkpqMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267290; c=relaxed/simple;
	bh=eSnoDkOEETH/kxtFM7c/k2wcmWasyCaFGRLbcCH8WoI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o00L/cX1GBulUsbKqPqJwHAGJoBs7ywHv9GxXZ015qkf57q0GnAN9cGFV/bMZpbKR0Ly/22Xm8geaySWJg3zUl170EXEIutAX0rpmUR4FvH2trA3GAdsD+ZhcVLUe0jWY7faViKXJVwlwJU/1rwHL4VhxriA8YyxZo064S5im8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VMRw2/hr; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724267285; x=1724526485;
	bh=rCxvXIb781j8vgc7b5+8ypCKkI7TCpYuwsGqlM6QVlA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VMRw2/hrzKuIyrcdl8eDGZtonj2CAkv7xBuOWt7+VdSYXcKbf549YeoR7d70TzNAh
	 1gA3Fnc9diVQV5Xx8LlIHFtCQaIKF5hzqQ7RvwD0Q1/aecmw2g9yGBW0gS87+VUnud
	 KfUrjYt5eWVPO+RzaQiQ1tJ+ajMrS0T66+3WBBP6qA4wMzNfNggLPzdRKpSR5hKegQ
	 +xJ3tLaiznGJWin24YsbEbDQqLow7oJe2eyFFMBFK/G2ne79BDz76ny+9M2oCT2/LO
	 /JcTSjIAhLwby6rlMFE7OucobGaoWY+ipOO3AAHXmKIhDLS9FPTrRyLHrokRFg3u1L
	 8oLSrpLamConQ==
Date: Wed, 21 Aug 2024 19:07:58 +0000
To: Alice Ryhl <aliceryhl@google.com>, Michal Rostecki <vadorovsky@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>,
	Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
Message-ID: <9f55bb2d-f963-44f6-941c-2bf9923c8beb@proton.me>
In-Reply-To: <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
References: <20240819153656.28807-2-vadorovsky@protonmail.com> <CAH5fLghOFYxwCOGrk8NYX0V9rgrJJ70YOa+dY1O0pbNB-CoK=w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 356fd5e2a98d52a6d72da75783ff7c3df57197fe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.08.24 14:08, Alice Ryhl wrote:
> On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Michal Rostecki <vadorovsky@gmail=
.com> wrote:
>>
>> From: Michal Rostecki <vadorovsky@gmail.com>
>>
>> `CStr` became a part of `core` library in Rust 1.75. This change replace=
s
>> the custom `CStr` implementation with the one from `core`.
>>
>> `core::CStr` behaves generally the same as the removed implementation,
>> with the following differences:
>>
>> - It does not implement `Display`.
>> - It does not provide `from_bytes_with_nul_unchecked_mut` method.
>> - It has `as_ptr()` method instead of `as_char_ptr()`, which also return=
s
>>   `*const c_char`.
>>
>> The first two differences are handled by providing the `CStrExt` trait,
>> with `display()` and `from_bytes_with_nul_unchecked_mut()` methods.
>> `display()` returns a `CStrDisplay` wrapper, with a custom `Display`
>> implementation.
>>
>> `DerefMut` implementation for `CString` is removed here, as it's not
>> being used anywhere.
>>
>> Signed-off-by: Michal Rostecki <vadorovsky@gmail.com>
>=20
> A few comments:
>=20
> * I would probably add CStrExt to the kernel prelude.
> * I would probably remove `from_bytes_with_nul_unchecked_mut` and keep
> `DerefMut for CString` instead of the other way around.
> * Perhaps we should remove the `c_str!` macro and use c"" instead?

Read [1], it is needed, because there is no `c_stringify!` macro.

[1]: https://lore.kernel.org/rust-for-linux/52676577-372c-4a7f-aace-4cf100f=
93bfb@gmail.com/

---
Cheers,
Benno


