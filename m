Return-Path: <linux-kselftest+bounces-28870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D043A5E6A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9E1176AE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02911E9B27;
	Wed, 12 Mar 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="db7SZWhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB278C9C;
	Wed, 12 Mar 2025 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815045; cv=none; b=jMvCpGE6IP6i8ghO6okIL+Mv4RaXdiKEg3mjOWoB/+LdqDE8BNf2jgnTt3IT0YgzVp59mGcwa8yGN3srWEgL3kEcjlVXVql04BM8zAXEQGiF4QFDodfm6q7nPvxlJQduLJ5HY/rkP2Xk48IcZkz7PpH8jFQ0URziz6QlkziRpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815045; c=relaxed/simple;
	bh=LO60XXggN+anABLteCj5yJ/uveuP5Rf8+hxgh8hVLs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb1AgegdDQAZ+cbcpfU7OdMX+0Jm4fa9pdtN75abGM/2gB+syWzR/ceagBvneBNMKjfepbYEEPibHDIZgfGBC3UGQOCDKFc4nimJUCXrZ2OFA+9GKjoRUouAhwQ4ze2TGYwmAClTsSgOOkvKWvpEcNxtFNhCjlZ45BA4uwtIAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=db7SZWhO; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741815041; x=1742074241;
	bh=778zYe9Aon21nmGzdiX6oN8GbRWrDQ7vfoMY5NS12F0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=db7SZWhOzUaLlMzOnZl+tAVoX7Ywpf6RTPMLoaDvI8GIG4p8DrUwaR/a6/Dnreeqp
	 Nu7j1wKrKLhikHuS/8DeqczefnRuHDH9jvByDQK0OBlScdU/xH/dwFotYy9YjJ+SdI
	 VX+EXyGto6Ux00AviB5J7HU5riEBB0ASYa1qrADkr64rcloHoLwkAsUCOTixugCBSg
	 99Gz5RI11wiwzrdeYAG+h9ki6LQ6ya1INqrFCUYV0dVCmbAENvyRJEKTPk1fpZ1xNE
	 nS4WtSgFpv/MYcelYvI+SD0dnvWoF7pDzZQVnFF6kMq8NclmHvAh9qZtu8iNRITMgl
	 6OqWA6SEDI/oA==
Date: Wed, 12 Mar 2025 21:30:33 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me>
In-Reply-To: <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com> <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com> <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com> <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com> <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f8edbb297efc28dbae0cc848a6fd0bf94b85de3d
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> > Always enable the features, we have `allow(stable_features)` for this
>> > reason (then you don't have to do this dance with checking if it's
>> > already stable or not :)
>>
>> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
>> provenance APIs are behind `feature(strict_provenance)`. In rustc >=3D
>> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So you
>> need to read the config to learn that you need to enable
>> `feature(strict_provenance_lints)`.

I see... And `strict_provenance_lints` doesn't exist in <1.84? That's a
bit of a bummer...

But I guess we could have this config option (in `init/Kconfig`):

    config RUSTC_HAS_STRICT_PROVENANCE
=09    def_bool RUSTC_VERSION >=3D 108400

and then do this in `lib.rs`:

    #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_provenan=
ce_lints))]

> Actually this isn't even the only problem. It seems that
> `-Astable_features` doesn't affect features enabled on the command
> line at all:
>
> error[E0725]: the feature `strict_provenance` is not in the list of
> allowed features
>  --> <crate attribute>:1:9
>   |
> 1 | feature(strict_provenance)
>   |         ^^^^^^^^^^^^^^^^^

That's because you need to append the feature to `rust_allowed_features`
in `scripts/Makefile.build` (AFAIK).

---
Cheers,
Benno


