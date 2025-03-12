Return-Path: <linux-kselftest+bounces-28868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85DA5E64B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2057D1636C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F61EE7A7;
	Wed, 12 Mar 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3c0qq1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048B1EC012;
	Wed, 12 Mar 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813856; cv=none; b=kXHCAr9xKCpkz2pGJDF9DzrUp/aQH/Ez7D0AJNJ0fNucKbLH/eQl6SJTHTAZYoQknOobsAZgCY704seE60f8BYdnx9cQpYimZ0GudysgaaH1TC0/x8v5q+MBn8AhQmU+s/TivzNT+EY4psqh+l+10Sqy+RQvq98iBoQVWA7l3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813856; c=relaxed/simple;
	bh=5/h6FqQKgL174BJV4eP7Pk0hVtYQClxNuHqv9ecubic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Canrm3DI2e8bJ/Vxtd4mz0N8M9DqptMrtWh8KmOniDy2ygl4lEYoyuPTSrgdx+YA+ppvuJcurRlE/wbxrZ5XPxTAcJDrVtL8ykDTxVBwoBMDsaZ5CTelZbOeWkgxZTJh70iQUJjk1OqPJkugMwuck0BosBxIL4VpltkdHvPr3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3c0qq1S; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso3477901fa.1;
        Wed, 12 Mar 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741813852; x=1742418652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfD67Ry3D8oF/uIr1l6p83q/D8mjwCghpe8PzLaAzQg=;
        b=D3c0qq1S3p7pwINhCz3tjY2/VV+SKxuTy0Z0mZamFs/l+4S3IRaA3yA50DmjJ/hC9w
         C9TY1HE3Lvs4Y4IWxr6qU2zaC0moRetfMi0OSmqgte7e8uHU+f+VsGP5C6CeLuBfgwsh
         drMxvfXA4os+FLHzONM4M1CLyWFuijm6U6ufi4IsIHOeElBR4c1BrTrrR8uAfKGc8Phv
         cBQQ42Qc2MkzxUqlHaqWyuyA4zzRsSqdlFIMPnZaau8BD++lRj6HGQ6RhkAE7YDUNMSO
         rOnI2c8rVETG2dBs4C7ejDTrdIp9B/2T0SY2eUp/YVd4itmo5km1A/4q9kvdNpc219V7
         jXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813852; x=1742418652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfD67Ry3D8oF/uIr1l6p83q/D8mjwCghpe8PzLaAzQg=;
        b=TvNkOK2Ymit9jeXhUslt6st0SngCbQ0yaFcs+qFGNizxlfYG1s6CX/45qjTp3a5Qeo
         oPeQm9zZym/hy6/z7JZtb1LUHmWsPNllEVsWHDlY5Nrn8zhs/mVRKDsDnl6yzNiiawhP
         xD4K2H47QPIi7AefFt3EJlCuNmldBI7v93Jrpd45EqBewMVhjrmJ2UfIXnLAnUfw/6LO
         8e+o+99dw2dR8nnzasVJ61LOExQWdts8sJP76lJYapSuNdx8G7+yZvEJzj/xS4exxADl
         P3oic9QbyOolb5AKTLSlOdyvwjh5lZES+iyGiARJDeqLvI14QMcX0fxTqJ/Qvj4PgN6b
         sCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI/jSk1+ssQQJ/kvr6O8/F/z9DybAjUKNWqix+cSuwn1c8svPvk44MMKVlDBnNmhGhLhyfGSmEigQv@vger.kernel.org, AJvYcCUjrIxIvXpYoZbWXkzZ2fW8HNEPrYeILDUav1bT0rxWjqYe8y6Ih1OjST440ZYdwzFujkoO0q76aux6zL4=@vger.kernel.org, AJvYcCWWfZEVLnHdMnJs060j0w0iXX205s2dtHB0weoAHPEgiNTfZAS2YEp2aUsn9y+Pc4WspQWATOidafZ6sN8t+/w=@vger.kernel.org, AJvYcCX0XTgZU1bO0IFzxV2z0nTW8Ldv00hvaj4WDSueRWsjDtop/ofs5D7vS16cA/qvW9aqA7fKW0kAiJMvn20Yfxo+@vger.kernel.org, AJvYcCXHvU74d3ipH1nwW94GkSoGWSNMGHw/Kcj/4z6K0FcA3LfNRW+hUYX+Lr1AaGalXG/RPMLkh8EkysubDylE@vger.kernel.org, AJvYcCXK7TVLYTJ7gyh7Z9QT57AknBhYuNAIHrIzcrhXpw9wGsz3N2laO6CAJvAnazoteG5DmdZcyOMLlEos@vger.kernel.org, AJvYcCXO4U6LCkRD6l1Px399/UpIdt2iTrtITCk/I38z6IN+79kdtQEG/TbhvFMAfLQg5D1dkZR9YDme4LhGwbbX@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGuU+bXpGIpMoZyhJkmO0oieHg1s7gFfddqOC/+C2LMeWQJ7t
	C9O9dBeysxy6+HCY1LWrVIKzeb/qlQuLPGO8GOnWCuNyCgPHgBil8N5NgSpp977f5pgrYruqsgZ
	P1vzgpGMYiVEeO4LpgxAVB711yXE=
X-Gm-Gg: ASbGnculRCvsFhiL9TJldZF16NkJlxI/YFDJSQA4Q/ucsDDRnMhoZAE1llJaHgi46T4
	RIkeLOIR0khCMRpl8KdWh0AGih8jCNDfCBJWWRU4EgLsJzUvco5aHfjM3g/0rNHb3ZfxV4G7foF
	aw5Xb32YjIaj6LLpcw8in08kwqgeg0aC/buOJuX0g6+w==
X-Google-Smtp-Source: AGHT+IE99Cgae9i1cKsHFe4hFnhIMT+bPZYluTYdlh5CjMWiOSRdhqz3fwyXx87eF9IFkTo2tBLPcJaV/Xm9rcKjsgk=
X-Received: by 2002:a05:651c:2224:b0:30a:44ca:7e74 with SMTP id
 38308e7fff4ca-30bf451e2b3mr86628931fa.12.1741813852226; Wed, 12 Mar 2025
 14:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
 <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com>
 <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
 <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
 <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
 <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 17:10:16 -0400
X-Gm-Features: AQ5f1JolYjDdvkLYdrRaBs_MWEHWFs368x0yvzxjblRLlAQh7ZNaGnGnWi_mMhc
Message-ID: <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Wed Mar 12, 2025 at 9:41 PM CET, Tamir Duberstein wrote:
> > > On Wed, Mar 12, 2025 at 4:07=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com> wrote:
> > >>
> > >> On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> > >> >
> > >> > On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
> > >> > > I tried using the strict provenance lints locally and I think we=
 can't
> > >> > > until we properly bump MSRV due to `clippy::incompatible_msrv`:
> > >> > >
> > >> > > warning: current MSRV (Minimum Supported Rust Version) is `1.78.=
0` but
> > >> > > this item is stable since `1.84.0`
> > >> > >    --> ../rust/kernel/str.rs:696:22
> > >> > >     |
> > >> > > 696 |             pos: pos.expose_provenance(),
> > >> > >     |                      ^^^^^^^^^^^^^^^^^^^
> > >> > >     |
> > >> > >     =3D help: for further information visit
> > >> > > https://rust-lang.github.io/rust-clippy/master/index.html#incomp=
atible_msrv
> > >> >
> > >> > Oh this is annoying...
> > >> >
> > >> > > This is with `#![feature(strict_provenance)]`. I can file the is=
sue
> > >> > > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know=
 of a
> > >> > > path forward :)
> > >> >
> > >> > I think we should be able to just `allow(clippy::incompatible_msrv=
)`,
> > >> > since Miguel & other maintainers will test with 1.78 (or at least =
are
> > >> > supposed to :).
> > >>
> > >> Alright, you've sniped me. This is coming in v3.
> > >
> > > I just realized I only covered the kernel crate. In order to cover al=
l
> > > Rust code, I need to move the lints and the features out to the root
> > > Makefile. I tried something like this:
> > >
> > >> diff --git a/Makefile b/Makefile
> > >> index 2af40bfed9ce..10af1e44370b 100644
> > >> --- a/Makefile
> > >> +++ b/Makefile
> > >> @@ -466,13 +466,21 @@ KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-pro=
totypes -Wstrict-prototypes \
> > >>  KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> > >>  KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
> > >>
> > >> +# Lints were moved to `strict_provenance_lints` when `strict_proven=
ance` was stabilized.
> > >> +#
> > >> +# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f=
888e33dd52a13d3ecb64.
> > >> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE =3D $(if $(CONFIG_RUSTC_HAS_S=
TABLE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> > >> +
> > >>  # These flags apply to all Rust code in the tree, including the ker=
nel and
> > >>  # host programs.
> > >>  export rust_common_flags :=3D --edition=3D2021 \
> > >>      -Zbinary_dep_depinfo=3Dy \
> > >> +     -Zcrate-attr=3D"feature($(KBUILD_RUST_STRICT_PROVENANCE_FEATUR=
E))" \
> > >>      -Astable_features \
> > >>      -Dnon_ascii_idents \
> > >>      -Dunsafe_op_in_unsafe_fn \
> > >> +     -Wfuzzy_provenance_casts \
> > >> +     -Wlossy_provenance_casts \
> > >>      -Wmissing_docs \
> > >>      -Wrust_2018_idioms \
> > >>      -Wunreachable_pub \
> > >> diff --git a/rust/Makefile b/rust/Makefile
> > >> index ea3849eb78f6..d7d5be741245 100644
> > >> --- a/rust/Makefile
> > >> +++ b/rust/Makefile
> > >> @@ -435,8 +435,10 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helper=
s.c $(recordmcount_source) FORCE
> > >>  # symbol versions generated from Rust objects.
> > >>  $(obj)/exports.o: private skip_gendwarfksyms =3D 1
> > >>
> > >> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE :=3D $(if $(CONFIG_RUSTC_HAS_=
STABLE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> > >> +
> > >>  $(obj)/core.o: private skip_clippy =3D 1
> > >> -$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
> > >> +$(obj)/core.o: private skip_flags =3D -Zcrate-attr=3D"feature($(KBU=
ILD_RUST_STRICT_PROVENANCE_FEATURE))" -Wunreachable_pub -Wfuzzy_provenance_=
casts -Wlossy_provenance_casts
> > >>  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-i=
ntrinsics),--redefine-sym $(sym)=3D__rust$(sym))
> > >>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
> > >>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
> > >
> > > but this doesn't work because
> > > `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE` is not yet defined when I
> > > read it in the root Makefile. I can read it lower down and then appen=
d
> > > the feature flag to `KBUILD_RUSTFLAGS` but by then the rustdoc flags
> > > have been copied from `rust_common_flags` and so rustdoc doesn't get
> > > the feature flag, resulting in unknown lint warnings in rustdoc and
> > > kunit tests.
> > >
> > > Any ideas?
> >
> > Always enable the features, we have `allow(stable_features)` for this
> > reason (then you don't have to do this dance with checking if it's
> > already stable or not :)
>
> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
> provenance APIs are behind `feature(strict_provenance)`. In rustc >=3D
> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So you
> need to read the config to learn that you need to enable
> `feature(strict_provenance_lints)`.

Actually this isn't even the only problem. It seems that
`-Astable_features` doesn't affect features enabled on the command
line at all:

error[E0725]: the feature `strict_provenance` is not in the list of
allowed features
 --> <crate attribute>:1:9
  |
1 | feature(strict_provenance)
  |         ^^^^^^^^^^^^^^^^^

