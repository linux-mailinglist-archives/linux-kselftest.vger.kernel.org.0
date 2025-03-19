Return-Path: <linux-kselftest+bounces-29459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEFA699F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E2A19C3B4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63242144A6;
	Wed, 19 Mar 2025 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I3/wO4k6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357701CAA89;
	Wed, 19 Mar 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414607; cv=none; b=ljtN6prnIVYXD0tGC85C52Qj/XF3tdQ/9NUOmNKvwtfWnU+epQeNcvhyMUcTcCOBJM3VTUbhXFJo+hcGr7vsYkrf0/bdNYruoNmHTBfon3Yp4vus5Hzcw4Z63KbR25/cdGdP2GemtMHX1DlJAxD9AH7b7OrHC/NayA2zEuyNhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414607; c=relaxed/simple;
	bh=NmBfb3kfyCaMXucIOGHltxi/cWXIihe8+QkjNjON1Sw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QydL+iwJQPTWQ+wh82yHecyl4dcPVqcXB7jWiJqaa3w0AV9g8DxO0CYIYbQJnrLuDGoySFVXieDO/GYiJGtwAJKBic0CqtzikAH9UeYDvBB27jekY7jZWyuTNrUsy20ZzsQK5p0+bpdqGqtz5zxQ3rfOAh2ywMYmXx/IEhjBFhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I3/wO4k6; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742414597; x=1742673797;
	bh=ZQQj7Au7md2avN8A1/Dk2LhzDRdh0Szlk+xdTu8q4os=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=I3/wO4k64m7znUY3bPzNmDzmXvwwrWn4az+9zwXxZQgRAISXRI61jbyX/GaObwTJV
	 7A+yCQJ9royiixwemFXWbYuqNoniXKCRDcLqSUgCC+WZ4qAqaWUeBmxfWMYB1JEEJI
	 TWWeIfmGc/VuICVNuEuTAtqYOK1lWrhnCD465wNmySSlhFL7fhTRjclEZm74SxGycq
	 AXEO41H7zYK4oOga9GigR6qn0F9nLY2mdyMT3lEL7PwIpU+qXZ3X6aTQhbAGoa3CzX
	 +hR+r1ViDACoihGN346cU/EXm6FUilvTGLnAVxHcdG/InDIgVOH8l5nbKyMZp0XCPZ
	 ZRdRIUYdccPUQ==
Date: Wed, 19 Mar 2025 20:03:11 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8KIF51E9UVO.1AUMFW98R1SW1@proton.me>
In-Reply-To: <67dae1ff.0c0a0220.1a88e4.f740@mx.google.com>
References: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <67d885ff.0c0a0220.111215.5644@mx.google.com> <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com> <67d88a1d.050a0220.2cdacf.4adf@mx.google.com> <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com> <67d895cc.050a0220.99d33.5adc@mx.google.com> <67d8ba3e.050a0220.39b3b5.753c@mx.google.com> <D8JA6Z142FKY.4RRGIN0PDDYQ@proton.me> <67dae1ff.0c0a0220.1a88e4.f740@mx.google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a27ad6ee4b8e75f284662ac233e0ec6637c95d5a
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 4:25 PM CET, Boqun Feng wrote:
> On Tue, Mar 18, 2025 at 09:23:42AM +0000, Benno Lossin wrote:
> [..]
>> > +#![allow(clippy::incompatible_msrv)]
>> > =20
>> > -#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
>> > +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
>> >  mod strict_provenance {
>>=20
>> Since there is only a single trait and impl in here, I think we don't
>> need a module.
>
> We still need to provide stubs for with_exposed_provenance() and its
> friends for rustc =3D=3D 1.78, so there are a few more functions in this
> module.

Ah I see, that's okay then.

---
Cheers,
Benno


