Return-Path: <linux-kselftest+bounces-28980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A664CA5FEFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8629E7AEFA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12361F4196;
	Thu, 13 Mar 2025 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Vjde6D3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97071F03E0;
	Thu, 13 Mar 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889540; cv=none; b=ZiSrpbH0Un9g3MsvEUq0c98gwICfJz2TYfZlyhQ8h63tsmIr6MlusVXP2g1AqCkStK4Gen9zJ3lkJEA8B7yhSvoxe+If3tEK++VeB28mqEvr518Uv/4VDiWmf4pro2b/HdCImmefpsNjr8N/jf91FWRawR4vrTMNyE1dIdis3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889540; c=relaxed/simple;
	bh=8Zqt9zi/FnC7k8GuHDy1ukGq3CUt3k0moSNlURadgLI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vf0W4VqmZg8ccsN0PnXjSRWgZwVrJUxqaLclrYApKMMmjBfj8tEzWK8yltW5ELM5e0/Y/lhuzcfYEd9HK1hEOfuPrVhhbQh8ER1wtHOoKBFogNnFPpQXMz90RkGXcz04lZEcBJB++JLMlQJqZWP3F9WdQoTZqshDBAK8/iYaSc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Vjde6D3e; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741889533; x=1742148733;
	bh=srZ9dMa1whdbkDsfnTWuQVdrHW1c6weSBgLs5X2xzXk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Vjde6D3es+FZD2i6nszzd+Hgukt8o27vgDDfWp2jm96W+oLCnogjSWy9m1JzHPVJX
	 1irYvVn3fp2UlTepZj4LPqame5PkF1jsA/iUl3OWvTXt9hYSi8UiXKaUQ99JEn/DEz
	 fo2oDRmOFgswdoLgpDm5x+Ei8G2KeWGyHF3tYcWIgv8mZVR3cvzX8aEGShpo2vcghX
	 vN6eboR5Md26RDXfVYE5uFKUhR/68AYzFJsEnXn97LUFJnEnlo1zgi4n1lY2E+/sIC
	 QJaAeDw3MssC1B7ZprfH0fReKBb8747T8wWsl/TQKPc4bW24dWbtRN3QQ4SzLYD6Vz
	 ZekcLQszuPFXg==
Date: Thu, 13 Mar 2025 18:12:08 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8FCATTC479L.BDRZBC6TJ51Q@proton.me>
In-Reply-To: <CAJ-ks9n1oGAGSrXYWjvR+_raw8h+skkdfSYpeSuQZ9jEs5q-6Q@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com> <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com> <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com> <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me> <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com> <D8F76A4JSEXO.2OKKJLAU5OZN@proton.me> <CAJ-ks9n1oGAGSrXYWjvR+_raw8h+skkdfSYpeSuQZ9jEs5q-6Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d74d9f9fe6f44074994f0914e725607f21a3708b
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 6:50 PM CET, Tamir Duberstein wrote:
> On Thu, Mar 13, 2025 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On Thu Mar 13, 2025 at 11:47 AM CET, Tamir Duberstein wrote:
>> > On Wed, Mar 12, 2025 at 6:38=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >>
>> >> On Wed Mar 12, 2025 at 11:24 PM CET, Tamir Duberstein wrote:
>> >> > On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@=
proton.me> wrote:
>> >> >>
>> >> >> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
>> >> >> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird=
@gmail.com> wrote:
>> >> >> >>
>> >> >> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.los=
sin@proton.me> wrote:
>> >> >> >> > Always enable the features, we have `allow(stable_features)` =
for this
>> >> >> >> > reason (then you don't have to do this dance with checking if=
 it's
>> >> >> >> > already stable or not :)
>> >> >> >>
>> >> >> >> It's not so simple. In rustc < 1.84.0 the lints *and* the stric=
t
>> >> >> >> provenance APIs are behind `feature(strict_provenance)`. In rus=
tc >=3D
>> >> >> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`.=
 So you
>> >> >> >> need to read the config to learn that you need to enable
>> >> >> >> `feature(strict_provenance_lints)`.
>> >> >>
>> >> >> I see... And `strict_provenance_lints` doesn't exist in <1.84? Tha=
t's a
>> >> >> bit of a bummer...
>> >> >>
>> >> >> But I guess we could have this config option (in `init/Kconfig`):
>> >> >>
>> >> >>     config RUSTC_HAS_STRICT_PROVENANCE
>> >> >>             def_bool RUSTC_VERSION >=3D 108400
>> >> >>
>> >> >> and then do this in `lib.rs`:
>> >> >>
>> >> >>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict=
_provenance_lints))]
>> >> >
>> >> > Yep! That's exactly what I did, but as I mentioned up-thread, the
>> >> > result is that we only cover the `kernel` crate.
>> >>
>> >> Ah I see, can't we just have the above line in the other crate roots?
>> >
>> > The most difficult case is doctests. You'd have to add this to every
>> > example AFAICT.
>> >
>> >> >> > Actually this isn't even the only problem. It seems that
>> >> >> > `-Astable_features` doesn't affect features enabled on the comma=
nd
>> >> >> > line at all:
>> >> >> >
>> >> >> > error[E0725]: the feature `strict_provenance` is not in the list=
 of
>> >> >> > allowed features
>> >> >> >  --> <crate attribute>:1:9
>> >> >> >   |
>> >> >> > 1 | feature(strict_provenance)
>> >> >> >   |         ^^^^^^^^^^^^^^^^^
>> >> >>
>> >> >> That's because you need to append the feature to `rust_allowed_fea=
tures`
>> >> >> in `scripts/Makefile.build` (AFAIK).
>> >> >
>> >> > Thanks, that's a helpful pointer, and it solves some problems but n=
ot
>> >> > all. The root Makefile contains this bit:
>> >> >
>> >> >> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebugi=
nfo \
>> >> >> -Zallow-features=3D $(HOSTRUSTFLAGS)
>> >> >
>> >> > which means we can't use the provenance lints against these host
>> >> > targets (including e.g. `rustdoc_test_gen`). We can't remove this
>> >> > -Zallow-features=3D either because then core fails to compile.
>> >> >
>> >> > I'm at the point where I think I need more involved help. Want to t=
ake
>> >> > a look at my attempt? It's here:
>> >> > https://github.com/tamird/linux/tree/b4/ptr-as-ptr.
>>
>> With doing `allow(clippy::incompatible_msrv)`, I meant doing that
>> globally, not having a module to re-export the functions :)
>
> Yeah, but I think that's too big a hammer. It's a useful warning, and
> it doesn't accept per-item configuration.

Hmm, I don't think it's as useful. We're going to be using more unstable
features until we eventually bump the minimum version when we can
disable `RUSTC_BOOTSTRAP=3D1`. From that point onwards, it will be very
useful, but before that I don't think that it matters too much. Maybe
the others disagree.

>> >> I'll take a look tomorrow, you're testing my knowledge of the build
>> >> system a lot here :)
>> >
>> > We're guaranteed to learn something :)
>>
>> Yep! I managed to get it working, but it is rather janky and
>> experimental. I don't think you should use this in your patch series
>> unless Miguel has commented on it.
>>
>> Notable things in the diff below:
>> * the hostrustflags don't get the *provenance_casts lints (which is
>>   correct, I think, but probably not the way I did it with filter-out)
>> * the crates compiler_builtins, bindings, uapi, build_error, libmacros,
>>   ffi, etc do get them, but probably shouldn't?
>
> Why don't we want host programs to have the same warnings applied? Why
> don't we want it for all those other crates?

I have never looked at the rust hostprogs before, so I'm missing some
context here.

I didn't enable them, because they are currently being compiled without
any unstable features and I thought we might want to keep that. (though
I don't really see a reason not to compile them with unstable features
that we also use for the kernel crate)

> I'd expect we want uniform diagnostics settings throughout which is
> why these things are in the Makefile rather than in individual crates
> in the first place.
>
> Your patch sidesteps the problems I'm having by not applying these
> lints to host crates, but I think we should.

We're probably working on some stuff that Miguel's new build system will
do entirely differently. So I wouldn't worry too much about getting it
perfect, as it will be removed in a couple cycles.

---
Cheers,
Benno


