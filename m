Return-Path: <linux-kselftest+bounces-28841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF7A5E58D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E388F189BE47
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239A1E260A;
	Wed, 12 Mar 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VelFmMpe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00441EE7A7;
	Wed, 12 Mar 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812169; cv=none; b=eKdnAa/94VKWdZZi7KK4330GzY+Nnyl1zeWEBm0cYzkzwQX21ybtfjwg04sduZWuGdPxrwD4HS39p7oo3rUCO8wl96W2+nyonvYDYK95UatluQPnnSqOP0OojWWXWpqZj9pmhHOAgJVjPmm7IGs5BWdOOoesDuw1APoTIkFDOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812169; c=relaxed/simple;
	bh=NMh8CTxUGVQ0l/gw/OVK0SrJW3sz8Ziz94+4OJ9KoKY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM9Ujjqx58r+YufCRd457rSsVWfpOjB2UK7W2Kx0rXHgAwnx5Kbmw+RjO8p6cOGICLxUdOd2A1nZANlwEP68FXRzysIBaMKQo/383Hp868ALZwVMpcPv0Z+iRl4P1cBzS+o7P53hDNOlikYkl+HY6l6T3edRZXXffzJZKUC00vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VelFmMpe; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741812164; x=1742071364;
	bh=pMyYkR71+rR/3IuQOyjfnVcyWj2u+Jv42qBbxPyFNk0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VelFmMpeP25sjUu55fJ3fZ/avXxduntwL86jqVLCxygBCN58CDnlUkusQKUHigO9d
	 DCF+SAwKWkIhg+B+aDAjVeujKhr8J2ryFYG7orE98Bz5dzi19hM1mZeT4xQndGC++7
	 i9uhZzkd7Wb/eBw78EQIaFdrshvQggx0tKm7YCRgmT81gjpFpt0Mrc3JaUD3MWNsZZ
	 tfXbetviLzsF64nYStyTJyGszyfDITZqGQphnnR1Wet6PnNnHw1wyuyUJMxTl9ZAwT
	 2NDASusiGVP233cBxNLD0kgjT5fREUwt4Xch3uNrzyVf2TvZRmXdi+FyR1LHMva0R0
	 FXNIJ4Cp3En9w==
Date: Wed, 12 Mar 2025 20:42:39 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8EKVM1OP7O5.1GCGYWTV5RBTX@proton.me>
In-Reply-To: <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me> <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com> <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com> <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com> <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 899ceb5f8eb0289fe15b927f74e6d074ac1145f5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
>> > I tried using the strict provenance lints locally and I think we can't
>> > until we properly bump MSRV due to `clippy::incompatible_msrv`:
>> >
>> > warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but
>> > this item is stable since `1.84.0`
>> >    --> ../rust/kernel/str.rs:696:22
>> >     |
>> > 696 |             pos: pos.expose_provenance(),
>> >     |                      ^^^^^^^^^^^^^^^^^^^
>> >     |
>> >     =3D help: for further information visit
>> > https://rust-lang.github.io/rust-clippy/master/index.html#incompatible=
_msrv
>>
>> Oh this is annoying...
>>
>> > This is with `#![feature(strict_provenance)]`. I can file the issue
>> > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of a
>> > path forward :)
>>
>> I think we should be able to just `allow(clippy::incompatible_msrv)`,
>> since Miguel & other maintainers will test with 1.78 (or at least are
>> supposed to :).
>
> Alright, you've sniped me.

Sorry about that :)

> This is coming in v3.

Thanks a lot!

---
Cheers,
Benno


