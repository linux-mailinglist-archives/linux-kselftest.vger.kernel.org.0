Return-Path: <linux-kselftest+bounces-28867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB25A5E62B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E01018898E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEB1EFFAC;
	Wed, 12 Mar 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwYIHqoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3D1EF38E;
	Wed, 12 Mar 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813492; cv=none; b=R4wZHN2zaHFkiSPbXKBPjqL9Mi6azWcMOfy5qYNlfHFGFp92Tq4gOdonQRakUZkayjFwC4DwWhEOaEP4oQkAkivppv/07xzBCGssae8zDTG7XWTCT3FuPJpoSYxSMQMT570PqwfCr6Urxmp97YM2vCUg0IfY7T6e9d0JYgfqv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813492; c=relaxed/simple;
	bh=+LGUaVivceWptpxAIWBUUKprgy/a0XLvVKd+sJ6qOOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA/wRZMA0jcw0ZZHAZnqnJoMLCcPzzY7es806h4y5mE/TsARKib6cQ63M3q23HiVBP8/EU+do0FlJPByH7/wdpZqG//6ZUSs+IzaKjOD9N+yXALQEaBxsOQRy2UXTpZ7Kyox7faRUxfcfyfwHU9VVl78MAoqH8nkBXuW5MbD8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwYIHqoG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfed67e08so3221361fa.2;
        Wed, 12 Mar 2025 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741813489; x=1742418289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kZxK/2Q5hehdq6vdu9VftqHSqPJSU1J/P2JUB6zgGk=;
        b=gwYIHqoGCNZTQ3ySiUpmlkDGm5v3Bo72Ya6/Rd3u1QBorCkX2IWzKnYlp4dj47RvGP
         aB7rOinDtkkV62F7ytA9Lk80zVrmUfsimJ69dA026UMl596Mjt9u0lJpZHYItojR3+WL
         w5gR8GjlJ+4zHiuCAsB92YoIXrFXqB/gOMjOJ9NPPmu5NElWf6qSVhVqLMhJ890VrcIV
         iSXHbjasrLqdxpy/C6l6uRcancWSlnXIwaJAeuyWSR/ZucGx2/5wzTkEj/M94ErucKgV
         bzQWiZOVtJzpC4s/LC9GP4Bi2+vvGYmxWfBlTWbPjGPf4WsMQagjB13pq53fEGPZaogQ
         wrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813489; x=1742418289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kZxK/2Q5hehdq6vdu9VftqHSqPJSU1J/P2JUB6zgGk=;
        b=mHu873MOhqThNcRCkvyWGC1FhPHqFM+y8k9+r26wDE1h7yNLEFFBzvVGdKGU7EJ/vu
         Uszl5AsS+83jlctj4gTRU0Gg3LnrYJrzPC6wu9XIDmsN5f1IlFs/efqPGhxBps4dtRXt
         DSDSx5SCMeBEHwR3mx31zYzcveu+4L2w9PZAvTIfI68OKPRJULZIkjn2wxhmyctQ5U9V
         A9C8DxDv9pYuHqOVPeux2tXB/HUv3ESIDwU8YQwCh6jCMVdiB2L/QhAUNJeClLGpLyV2
         pZYZJNmRsVtaQfkB0njRX63fgybfFcu3GPeh72piDGV5ANKGU6LycFQRWt0IVr774N0t
         X89g==
X-Forwarded-Encrypted: i=1; AJvYcCUGUfxqWuG+fqklSWn0JDsDTP0Gegd4kjvEopBeSYQVBtBmCUg4ngU1OgGTlheQzLzh6kP19uucTgYAFExg@vger.kernel.org, AJvYcCUss6GCPnWZVNZphHW7EI3uBYmRpqkXmJX7BTIwYy7T3MTsngPIIe0F8WKcUg/MQAwzIQbBwLZvdSgw@vger.kernel.org, AJvYcCVWKMGfa3xeBG7SkrJKaTqOwdc77kkssbP8L/CGmDG9gEp7IiwfuZWTFHVbftQ74qCKUlAjDO7n8s5F2yPTun5F@vger.kernel.org, AJvYcCW2LpMGEPjwNRkpZNJzYeGJysOEmMwko+xXaU5gutUrZX5VdmcHJHvcMsZfioNq/mNzVnDV3KXkpRzpV2cI@vger.kernel.org, AJvYcCXQLn1gcZUnQaIkLv0hCTxpuqqHWncBIyZVejW3zE5WtUC3rPlaofOAHqSUYgU22W464fbD+mScuu18@vger.kernel.org, AJvYcCXVsiuCWL03QaxapTbeNKJWph3uNTJ7jJmtMPus57/2ezpSrKTll3JxdF/hBuCLPr8GiFbsAZMDlj5+sZE=@vger.kernel.org, AJvYcCXmvohTbj7CLXUNAESuY2LEmnmaNcA7BOA9epM3WMCEzgJt9t4bYgy/cTgFR/abbX+udqaJX2pzM9tHjgWHkeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0Um29IRCcRoPXxikEgP0rNFIhlK3GzGM+cpiZBMZ0FPGHaLJ
	eA195Aa+zQFWVUMcQp+4GlJLPnC5/tEx3fqsGOoUqq/15qPa4ZgV9WZcACZk+QlX1kYD6RHbdC5
	42u/iWlB52b0v91lMaDeCq2C9PgA=
X-Gm-Gg: ASbGncuYvB22BMXbLhhimtkNsJofKKdgqP2DRWCE7NNnMk2rASLJHotB5t/ginuXFFM
	ZZw+bLIlBXKGhO5CHXoXgUWzm+M7F+HNVopXA5i3IIs6mlEyRaycLBiWYqtjb9yhVPxXVmiRdq9
	LzNHCNjQyCI70W9jk7ZbbiFZ87jmMOQG0/3rw8TZyz/g==
X-Google-Smtp-Source: AGHT+IHa+R1rvAMaQooEb8PCVQbXlUkUJjsQQodlQM3HWgy+TunL6fhJjqkj5E6QZhONq/5o1zkY/uhUY13Bk/SqCNg=
X-Received: by 2002:a2e:7015:0:b0:30b:ee81:9622 with SMTP id
 38308e7fff4ca-30bf466ce80mr71528251fa.31.1741813488633; Wed, 12 Mar 2025
 14:04:48 -0700 (PDT)
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
 <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com> <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me>
In-Reply-To: <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 17:04:12 -0400
X-Gm-Features: AQ5f1JqqQd3v2xiRI6ykASVSL1cdIxLsCz3uQjlsEDwmvIguhgD94ZHee5gDvtY
Message-ID: <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 9:41 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 12, 2025 at 4:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> >>
> >> On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >> >
> >> > On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
> >> > > I tried using the strict provenance lints locally and I think we c=
an't
> >> > > until we properly bump MSRV due to `clippy::incompatible_msrv`:
> >> > >
> >> > > warning: current MSRV (Minimum Supported Rust Version) is `1.78.0`=
 but
> >> > > this item is stable since `1.84.0`
> >> > >    --> ../rust/kernel/str.rs:696:22
> >> > >     |
> >> > > 696 |             pos: pos.expose_provenance(),
> >> > >     |                      ^^^^^^^^^^^^^^^^^^^
> >> > >     |
> >> > >     =3D help: for further information visit
> >> > > https://rust-lang.github.io/rust-clippy/master/index.html#incompat=
ible_msrv
> >> >
> >> > Oh this is annoying...
> >> >
> >> > > This is with `#![feature(strict_provenance)]`. I can file the issu=
e
> >> > > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know o=
f a
> >> > > path forward :)
> >> >
> >> > I think we should be able to just `allow(clippy::incompatible_msrv)`=
,
> >> > since Miguel & other maintainers will test with 1.78 (or at least ar=
e
> >> > supposed to :).
> >>
> >> Alright, you've sniped me. This is coming in v3.
> >
> > I just realized I only covered the kernel crate. In order to cover all
> > Rust code, I need to move the lints and the features out to the root
> > Makefile. I tried something like this:
> >
> >> diff --git a/Makefile b/Makefile
> >> index 2af40bfed9ce..10af1e44370b 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -466,13 +466,21 @@ KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-proto=
types -Wstrict-prototypes \
> >>  KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> >>  KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
> >>
> >> +# Lints were moved to `strict_provenance_lints` when `strict_provenan=
ce` was stabilized.
> >> +#
> >> +# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f88=
8e33dd52a13d3ecb64.
> >> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE =3D $(if $(CONFIG_RUSTC_HAS_STA=
BLE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> >> +
> >>  # These flags apply to all Rust code in the tree, including the kerne=
l and
> >>  # host programs.
> >>  export rust_common_flags :=3D --edition=3D2021 \
> >>      -Zbinary_dep_depinfo=3Dy \
> >> +     -Zcrate-attr=3D"feature($(KBUILD_RUST_STRICT_PROVENANCE_FEATURE)=
)" \
> >>      -Astable_features \
> >>      -Dnon_ascii_idents \
> >>      -Dunsafe_op_in_unsafe_fn \
> >> +     -Wfuzzy_provenance_casts \
> >> +     -Wlossy_provenance_casts \
> >>      -Wmissing_docs \
> >>      -Wrust_2018_idioms \
> >>      -Wunreachable_pub \
> >> diff --git a/rust/Makefile b/rust/Makefile
> >> index ea3849eb78f6..d7d5be741245 100644
> >> --- a/rust/Makefile
> >> +++ b/rust/Makefile
> >> @@ -435,8 +435,10 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.=
c $(recordmcount_source) FORCE
> >>  # symbol versions generated from Rust objects.
> >>  $(obj)/exports.o: private skip_gendwarfksyms =3D 1
> >>
> >> +KBUILD_RUST_STRICT_PROVENANCE_FEATURE :=3D $(if $(CONFIG_RUSTC_HAS_ST=
ABLE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> >> +
> >>  $(obj)/core.o: private skip_clippy =3D 1
> >> -$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
> >> +$(obj)/core.o: private skip_flags =3D -Zcrate-attr=3D"feature($(KBUIL=
D_RUST_STRICT_PROVENANCE_FEATURE))" -Wunreachable_pub -Wfuzzy_provenance_ca=
sts -Wlossy_provenance_casts
> >>  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-int=
rinsics),--redefine-sym $(sym)=3D__rust$(sym))
> >>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
> >>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
> >
> > but this doesn't work because
> > `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE` is not yet defined when I
> > read it in the root Makefile. I can read it lower down and then append
> > the feature flag to `KBUILD_RUSTFLAGS` but by then the rustdoc flags
> > have been copied from `rust_common_flags` and so rustdoc doesn't get
> > the feature flag, resulting in unknown lint warnings in rustdoc and
> > kunit tests.
> >
> > Any ideas?
>
> Always enable the features, we have `allow(stable_features)` for this
> reason (then you don't have to do this dance with checking if it's
> already stable or not :)

It's not so simple. In rustc < 1.84.0 the lints *and* the strict
provenance APIs are behind `feature(strict_provenance)`. In rustc >=3D
1.84.0 the lints are behind `feature(strict_provenance_lints)`. So you
need to read the config to learn that you need to enable
`feature(strict_provenance_lints)`.

