Return-Path: <linux-kselftest+bounces-28840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69FA5E588
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45BC17A8989
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509F1EE7BB;
	Wed, 12 Mar 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByN1BoAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17203136A;
	Wed, 12 Mar 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812141; cv=none; b=OHSuvjVW0+zluBqX0rzvr35w/sCZ4ZeDzM80mFZbBpOGu+X8nTIaip6I+x1kzkv+gyKwp+ejCY9feNCMXhY5bSWpGPQ1muOf916QlzjVCcpS6MaVd3Hqrk311yfKUuaPMm8WGLWr12AusdeyBTWSLVpumcnlrFbTdkhwwAKEljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812141; c=relaxed/simple;
	bh=mZDVkEu1yKAY5vVgLcnGtEsPEfl2TjjA8hxSeA3Gf9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN8ba1Yqg1CCGl7sN+HnSkAvVhPmniColXHE3eAayxEzA58uAxb65RaZi8t3rxb1icb/UTikK6SHNgs83Oj8W+l/XvaIVhQwgWplo5jAnxcsDs5aaWY0m552FfqPB74ZrbmTK8e0Qc9kHtR7mRsgZ/nMCK/2zYbpcscS2P5Vhgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByN1BoAA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso3117971fa.0;
        Wed, 12 Mar 2025 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741812137; x=1742416937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a269o+PCKHrxRSAWX4ZdJpzoFh9qJlw3C/Y2m1C+00Q=;
        b=ByN1BoAAtxJ7j/AUB1+Q/lrvhPn8qUnEqfXxr3WKpIH3f11gC+PUq9cX9tJgA1/qy2
         C1Nl5tX7PBa8vgIbc7/WSs2Kn8PExmMYl2CtuWjC451eIiKYbfpOYBfzSlOjFhtFxiqV
         MnO2pz7FQUGdhc+cGrhbARP9CxGA7iLMaeZQp6MBe1Kpp/XDUcYx2oggVftgBXr/FJU4
         lkbYPwMyLURaIzmYbXCLBx4LlUyB/6UbeId38OurhZsS/9SnImrllI/u1mr5dPKPsHYa
         TmmOVki7TVstEDosI9mQ3Qp4Fy/OxylKckJpPdxF/9t8zo8v6y2LOp/cLaIuD2rhcxCl
         YttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812137; x=1742416937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a269o+PCKHrxRSAWX4ZdJpzoFh9qJlw3C/Y2m1C+00Q=;
        b=cr0UoJmLfq85I4QQsyyUFusSGxXdS6aLDRqz8hYYQ564BuVdrTrHNr2BrwjTB9Jprr
         X3MK/UZbfExSTNlNsJF7Se4CqgeGjfH1k13keC6n1Aq/cME0kyc1UngBBjTpUKnHkg7u
         W//j+m9qKOarOdiW8/fJOM1Ot22OOQrCfdZVGg+nWYFDepteurEI67+MS/WkymP15P8z
         /q+ENj2mAmkNiDGdTeC2hGc10FGn4i3UiXS3EtExj4y5OHzt7rLD351tLr1slFPWUh4B
         1zdg60Ek7aqNWsWuCQPkYmWabkrQpKEvpLerO+nEZZeVzEBrupapkYO3IYagu+FF3DWh
         cU+g==
X-Forwarded-Encrypted: i=1; AJvYcCU1A590uWcdypCB3Zw+Q4qCgkECe27ImeAVtHYMm8yVquTUbSRXGixC1VgF1wtMeSI6lZpZtw9tGcDX3QrEQJY=@vger.kernel.org, AJvYcCU3aLL9icPIxBSCtw15Ks1EnpDmOq86ev03RMxYzLyfvchjJm8FbgbvNitN8jVb9qvRL04V8/B7GSNk2UEN@vger.kernel.org, AJvYcCUNK0ih3x+zXKGKdjTkNhZ2OE/m7es3B1kpgntZ9z9zXOIdF5bC3/Jd56zio9r99bpSsvYPx/Z0Ks7O@vger.kernel.org, AJvYcCV+r35tySD/qMmwDDdnPugQFiAzrJkzDGVDvaf6DAaMlTFOH1qtfrxhu2m+hdwyOPzjBJogE/66lrlGFq6A@vger.kernel.org, AJvYcCVRNuRnPH+m5eLYYQu+TZvKPCkJlRbKAtgko4+QR1B9yETWLrlo071WeO8teFYVkQBeWfvGqwE2kU+OLm8=@vger.kernel.org, AJvYcCVvcluxS+lYUpo63oXeobg0Ca4uX9ghZrVlsR6Jzrkqyb3lM/SwXeneoK1Cc2zI7WNWQG3vo/2QKMeC@vger.kernel.org, AJvYcCXQGtnFLivG75mvnokv4LYjFUf6EnhUrdpBntxU8uNekGKvJQbm8A7THRxrp9ai25uHNFmwxkFGQvMlj62O/wQr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3neNC2Wm0GHVW5iX0sKgwoVxDJdAJQ8Vw/SXz1HXgTJh17NVp
	ZAOjSK/+5d1Rtk5dFPoi4iKRdGK+WNOUan9VJGewvK8yLmIX0R59oem0T00RMka/JnMkWLiy253
	HdJoBHUEC7YgddIm20qsne0ApSxc=
X-Gm-Gg: ASbGnctNMOzh8BvYNZro66pRBaQ40wGDVkBg1cLV8Fe5N/fqFq6juh6KzAKWtuJ25Io
	v4nN19ZYXrOP2pLXX9KvKCnCo25ALg++iUE9exG0EwDgfudKoBE42vJ40CP7lMpj63EtSTLH6nQ
	c8SNnUeQ9Pt6+D5hwv0VIA8PzjlygMM/Ptu08hx0zRhg==
X-Google-Smtp-Source: AGHT+IF+OA8YqdyK4ZJMpRuZPMEPjntJ/OUhr9voAba56zFvEuUXWcwpkf/yVdtsUJUfwMDanX2c7ip5klyCQlfZAks=
X-Received: by 2002:a2e:92c6:0:b0:30b:f775:bb25 with SMTP id
 38308e7fff4ca-30bf775c0eamr66477421fa.36.1741812136717; Wed, 12 Mar 2025
 13:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
 <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com>
 <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
 <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
In-Reply-To: <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 16:41:39 -0400
X-Gm-Features: AQ5f1JqujO9ylXL_xMHdghF1OiWn2FsV0sPBJZ-JFxTzYk7Zv67UQeQMGQjzt40
Message-ID: <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 4:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
> > > I tried using the strict provenance lints locally and I think we can'=
t
> > > until we properly bump MSRV due to `clippy::incompatible_msrv`:
> > >
> > > warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` bu=
t
> > > this item is stable since `1.84.0`
> > >    --> ../rust/kernel/str.rs:696:22
> > >     |
> > > 696 |             pos: pos.expose_provenance(),
> > >     |                      ^^^^^^^^^^^^^^^^^^^
> > >     |
> > >     =3D help: for further information visit
> > > https://rust-lang.github.io/rust-clippy/master/index.html#incompatibl=
e_msrv
> >
> > Oh this is annoying...
> >
> > > This is with `#![feature(strict_provenance)]`. I can file the issue
> > > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of a
> > > path forward :)
> >
> > I think we should be able to just `allow(clippy::incompatible_msrv)`,
> > since Miguel & other maintainers will test with 1.78 (or at least are
> > supposed to :).
>
> Alright, you've sniped me. This is coming in v3.

I just realized I only covered the kernel crate. In order to cover all
Rust code, I need to move the lints and the features out to the root
Makefile. I tried something like this:

> diff --git a/Makefile b/Makefile
> index 2af40bfed9ce..10af1e44370b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -466,13 +466,21 @@ KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototyp=
es -Wstrict-prototypes \
>  KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
>  KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
>
> +# Lints were moved to `strict_provenance_lints` when `strict_provenance`=
 was stabilized.
> +#
> +# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f888e3=
3dd52a13d3ecb64.
> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE =3D $(if $(CONFIG_RUSTC_HAS_STABLE=
_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> +
>  # These flags apply to all Rust code in the tree, including the kernel a=
nd
>  # host programs.
>  export rust_common_flags :=3D --edition=3D2021 \
>      -Zbinary_dep_depinfo=3Dy \
> +     -Zcrate-attr=3D"feature($(KBUILD_RUST_STRICT_PROVENANCE_FEATURE))" =
\
>      -Astable_features \
>      -Dnon_ascii_idents \
>      -Dunsafe_op_in_unsafe_fn \
> +     -Wfuzzy_provenance_casts \
> +     -Wlossy_provenance_casts \
>      -Wmissing_docs \
>      -Wrust_2018_idioms \
>      -Wunreachable_pub \
> diff --git a/rust/Makefile b/rust/Makefile
> index ea3849eb78f6..d7d5be741245 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -435,8 +435,10 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $=
(recordmcount_source) FORCE
>  # symbol versions generated from Rust objects.
>  $(obj)/exports.o: private skip_gendwarfksyms =3D 1
>
> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE :=3D $(if $(CONFIG_RUSTC_HAS_STABL=
E_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> +
>  $(obj)/core.o: private skip_clippy =3D 1
> -$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
> +$(obj)/core.o: private skip_flags =3D -Zcrate-attr=3D"feature($(KBUILD_R=
UST_STRICT_PROVENANCE_FEATURE))" -Wunreachable_pub -Wfuzzy_provenance_casts=
 -Wlossy_provenance_casts
>  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intrin=
sics),--redefine-sym $(sym)=3D__rust$(sym))
>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \

but this doesn't work because
`CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE` is not yet defined when I
read it in the root Makefile. I can read it lower down and then append
the feature flag to `KBUILD_RUSTFLAGS` but by then the rustdoc flags
have been copied from `rust_common_flags` and so rustdoc doesn't get
the feature flag, resulting in unknown lint warnings in rustdoc and
kunit tests.

Any ideas?

