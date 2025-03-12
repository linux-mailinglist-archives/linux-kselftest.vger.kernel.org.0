Return-Path: <linux-kselftest+bounces-28866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F460A5E630
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FE217889B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB331FAC4F;
	Wed, 12 Mar 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AgsmBmqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2C1F7919;
	Wed, 12 Mar 2025 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813281; cv=none; b=sUSklFH1vIKxAlTP9P3xUxf4eHb1C7AwjSChULZzACAzKCl31meBv1K8qe9r4iytSpAoadFIX2wM+Aaew49i9WRLma1YA6leTJX1Q+9bc9gZkm4Hoyo33pIBUGltzSbiw7FlzIYqKhTpV47AtCXLHEbjYBR8R1bK54QXBIss/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813281; c=relaxed/simple;
	bh=EUV+7ueFa4wuC2yYXN5Qxx8JPkLuf5A/I+HBCJ2HIVI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxwtpmOLununQFl3yHyvXDwFPBVkxPgorzN9fVAg6o9h5sOGLH70jkYZWF415tiCrGjvMPH53Vih3D+gNtqnpKekidveaYqYCdpCPKJv1/iXdvCd1RyhzHdzfx6n6U9dtxe2x6fTMTJn8wKz4t8slMUXRaiezadbxFyxQ2rUed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AgsmBmqt; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2r56xdogl5dwrazvon4xbvu2zu.protonmail; t=1741813277; x=1742072477;
	bh=e/HeNz8Swq56+LxdIGu4AcrscDU2ITHyNAwvMErqWQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AgsmBmqtPtEBMtZCUR9m3W5Qa924plNy2S/omSFiwwggDCgLWjLDL5b59jUf4Ym+Y
	 4HmornF6q0oKShU3PWvl+jO+yl16fZFfF01o2dxAQs3yST5ZFvAbvkUp99QrwmVxfe
	 QgY3e5QHChwoZiNuBnAfMK2IbnX0R4gFXUxpKJ52/Wex8tCqUcXMaasi7sMj68m9yW
	 LZLCVEJM5aLvMG597vBZbfo8oQDVugFbiExu+OtshCy2HeHJ4+uv2a87e1mohgjARe
	 IClgABETHHwXtr/mfE7tdJvKtSHaghlRZdfVMjdLMOQ7e+wEhSJlDFwV+RlA1iaGPv
	 eWD63TtHW3AKw==
Date: Wed, 12 Mar 2025 21:01:11 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me>
In-Reply-To: <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com> <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com> <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com> <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com> <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 179dfb60e06f78a42b6b24975cc212ea1bfde903
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 9:41 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 4:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> >
>> > On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
>> > > I tried using the strict provenance lints locally and I think we can=
't
>> > > until we properly bump MSRV due to `clippy::incompatible_msrv`:
>> > >
>> > > warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` b=
ut
>> > > this item is stable since `1.84.0`
>> > >    --> ../rust/kernel/str.rs:696:22
>> > >     |
>> > > 696 |             pos: pos.expose_provenance(),
>> > >     |                      ^^^^^^^^^^^^^^^^^^^
>> > >     |
>> > >     =3D help: for further information visit
>> > > https://rust-lang.github.io/rust-clippy/master/index.html#incompatib=
le_msrv
>> >
>> > Oh this is annoying...
>> >
>> > > This is with `#![feature(strict_provenance)]`. I can file the issue
>> > > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of =
a
>> > > path forward :)
>> >
>> > I think we should be able to just `allow(clippy::incompatible_msrv)`,
>> > since Miguel & other maintainers will test with 1.78 (or at least are
>> > supposed to :).
>>
>> Alright, you've sniped me. This is coming in v3.
>
> I just realized I only covered the kernel crate. In order to cover all
> Rust code, I need to move the lints and the features out to the root
> Makefile. I tried something like this:
>
>> diff --git a/Makefile b/Makefile
>> index 2af40bfed9ce..10af1e44370b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -466,13 +466,21 @@ KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototy=
pes -Wstrict-prototypes \
>>  KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
>>  KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
>>
>> +# Lints were moved to `strict_provenance_lints` when `strict_provenance=
` was stabilized.
>> +#
>> +# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f888e=
33dd52a13d3ecb64.
>> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE =3D $(if $(CONFIG_RUSTC_HAS_STABL=
E_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
>> +
>>  # These flags apply to all Rust code in the tree, including the kernel =
and
>>  # host programs.
>>  export rust_common_flags :=3D --edition=3D2021 \
>>      -Zbinary_dep_depinfo=3Dy \
>> +     -Zcrate-attr=3D"feature($(KBUILD_RUST_STRICT_PROVENANCE_FEATURE))"=
 \
>>      -Astable_features \
>>      -Dnon_ascii_idents \
>>      -Dunsafe_op_in_unsafe_fn \
>> +     -Wfuzzy_provenance_casts \
>> +     -Wlossy_provenance_casts \
>>      -Wmissing_docs \
>>      -Wrust_2018_idioms \
>>      -Wunreachable_pub \
>> diff --git a/rust/Makefile b/rust/Makefile
>> index ea3849eb78f6..d7d5be741245 100644
>> --- a/rust/Makefile
>> +++ b/rust/Makefile
>> @@ -435,8 +435,10 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c =
$(recordmcount_source) FORCE
>>  # symbol versions generated from Rust objects.
>>  $(obj)/exports.o: private skip_gendwarfksyms =3D 1
>>
>> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE :=3D $(if $(CONFIG_RUSTC_HAS_STAB=
LE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
>> +
>>  $(obj)/core.o: private skip_clippy =3D 1
>> -$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
>> +$(obj)/core.o: private skip_flags =3D -Zcrate-attr=3D"feature($(KBUILD_=
RUST_STRICT_PROVENANCE_FEATURE))" -Wunreachable_pub -Wfuzzy_provenance_cast=
s -Wlossy_provenance_casts
>>  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intri=
nsics),--redefine-sym $(sym)=3D__rust$(sym))
>>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
>>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
>
> but this doesn't work because
> `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE` is not yet defined when I
> read it in the root Makefile. I can read it lower down and then append
> the feature flag to `KBUILD_RUSTFLAGS` but by then the rustdoc flags
> have been copied from `rust_common_flags` and so rustdoc doesn't get
> the feature flag, resulting in unknown lint warnings in rustdoc and
> kunit tests.
>
> Any ideas?

Always enable the features, we have `allow(stable_features)` for this
reason (then you don't have to do this dance with checking if it's
already stable or not :)

---
Cheers,
Benno


