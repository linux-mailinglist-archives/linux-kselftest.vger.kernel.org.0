Return-Path: <linux-kselftest+bounces-29125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF48A62A74
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A619C1B07
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D41F866A;
	Sat, 15 Mar 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="huhRdlgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B51F3FC2;
	Sat, 15 Mar 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032080; cv=none; b=RTMhy6mYJ5WfCnhOl3pEkt0Zih9mNbxxiE0dc/Kj3yt5O8muyxTc3zaSo06Tn/g9b6Ok0X95871LoPk7Lj7veWBhIf/URmseatQbbRPH48hnbsFrMrzY9JJxRmhQUcLhFukyocvogNuJt0nIiUrW06QpUOEiqYWUoxSWhj+qLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032080; c=relaxed/simple;
	bh=7CqIO2/a0U9+oy6kNqO6XNpT52/jDsv0DiXJpmmUevA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQSQ2uBp7JLDG3Hs+CLsZ19SPV1Q5MkRh9QpoBKhgHutMrmjM8y/VsSIsjEUAZWaG9dJjcZr68lDHRX26a1lmpW9w2OtLMaK8mh0e7UsixkbBtN7NHunjzEQuO9l5F76puoLzePuYquaHLwBSJURwfTxuss9WN9IIch0wWCUuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=huhRdlgp; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742032075; x=1742291275;
	bh=YpMrKdCi6avddH9GQIVObLt9iwLl9bTrbYaJbhO6aWs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=huhRdlgpk0zebEQhrgVrn61dI92d0m27GER/kzfWLJ8X2bK9QJPTc/zEU3l6MM8PE
	 msflN1IByzbQOCx08jmvjixBLTxEHezv+d/ex8q5RTv5oOpStFdobWgHZnpCglf+GW
	 4SrFNcTURHgHO2DOyu9KgU6JUp4WH0S0V0LGOcJr/gD6p8t94++9hTf7fNYNC91dud
	 fRB4ASTPQxXB1mizw+ZsaimzeDbgp2NQqN4i3LI2Ts5UbBTcnoJUOZAb6rNlz9T6VS
	 YM/iPt0GO2hfhA+6BwNtjMhQvGBMWTgrhImtggYdXQfKctdtaPspGUlbxHQNj18xLZ
	 OWuYN4da9wX6g==
Date: Sat, 15 Mar 2025 09:47:51 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Antonio Hickey <contact@antoniohickey.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Message-ID: <D8GQTTOG3YEA.L56HVS2ZWZMK@proton.me>
In-Reply-To: <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
References: <20250314234148.599196-1-contact@antoniohickey.com> <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com> <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f41ba0e3cf90358c69c91d746250ed35f9c78c43
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 1:23 AM CET, Boqun Feng wrote:
> On Fri, Mar 14, 2025 at 11:41:55PM +0000, Antonio Hickey wrote:
> [...]
>> @@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
>>  ///
>>  /// ```rust
>>  /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
>> -/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>> +/// # use core::marker::PhantomPinned;
>>  /// #[pin_data]
>>  /// #[derive(Zeroable)]
>>  /// struct Buf {
>> @@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
>>  /// pin_init!(&this in Buf {
>>  ///     buf: [0; 64],
>>  ///     // SAFETY: TODO.
>> -///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
>> +///     ptr: unsafe { &raw mut (*this.as_ptr()).buf.cast() },
>
> This should be:
>
>
> ///     ptr: unsafe { &raw mut ((*this.as_ptr()).buf).cast() },
>
> , right?

I'd say it has to be `ptr: unsafe { (&raw mut ((*this.as_ptr()).buf)).cast(=
) }

---
Cheers,
Benno


