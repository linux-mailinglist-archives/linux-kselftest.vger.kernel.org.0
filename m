Return-Path: <linux-kselftest+bounces-28872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB9A5E794
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 23:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A493189BE77
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D541F0E38;
	Wed, 12 Mar 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Y1PKVIOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6A1EF08D;
	Wed, 12 Mar 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819095; cv=none; b=GvkdxHDueCFsVFsiJd20W2742kvnZnS2tQPiElI7Sy5jzDlu8+9dNWiiGh0GBAKa099/bYov/4TKw8P0Gq/j8QDjoTlqunhPLdhM2ScPCRcONOqCKDoAig8ZP51dF3MMOSfzcE3Vkc4+n1ZVEnwWwpXu1icJLCMEDjJFCSoCQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819095; c=relaxed/simple;
	bh=hqMCxV3hHW8yDcWjXKSWU9xjhmxeTFtHqSjy4t4/WAU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHQUT7lU8ONnqTAHclG4gUUytr7U9vlosnrGcx7+T6vOE7k7q/USIQ0ExExXhpOGS0VCrLjVchaujNJ8UnayXYi88IcVQepvBTjNS4e/2tKzu68BftLReQAEz39L3pMPrMGS2qu3uFKOjwe4TtYNEChvyQ/eRMCAu403iOax4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Y1PKVIOv; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741819090; x=1742078290;
	bh=ptExWFO1L9HF5KrYQKciiDZUKN13vD4sMJnJuckn30M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Y1PKVIOvKC6EhKkRWZAjDEctvB7RmPNDKkXLW0wv0zkA9TPc7rLcFEzyyjRhf1MAJ
	 PdCafG9+otGQHW2FGh9pOE5RsLlMfX7fSD4pEZoV0txxlIcNzyfUgpmNfG5oUfjp+T
	 i/qcbs7aFEZMZ8O40xI9u3n+i4qUKo1Rb8/Yd4HZdpAWVm6h7+be7TdT4Sj6las1+N
	 8JBX9zRHlFZlQvlLutfADOKxSGjJIAYuN0IPcLJFzN2NUcTNcGenlIrs7ylh5Uehfj
	 mRmmCP9FOzR0xBLTxBseRHp6sAwiyNl/4m1KPHz05xOcr6F0F7QqtcUMkkNVGiI7KV
	 8epgMAgAKtEUw==
Date: Wed, 12 Mar 2025 22:38:03 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me>
In-Reply-To: <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com> <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com> <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com> <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com> <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e5e352a766bd924d3132436297fc212a44299c51
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 11:24 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
>> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
>> >>
>> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
>> >> > Always enable the features, we have `allow(stable_features)` for th=
is
>> >> > reason (then you don't have to do this dance with checking if it's
>> >> > already stable or not :)
>> >>
>> >> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
>> >> provenance APIs are behind `feature(strict_provenance)`. In rustc >=
=3D
>> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So yo=
u
>> >> need to read the config to learn that you need to enable
>> >> `feature(strict_provenance_lints)`.
>>
>> I see... And `strict_provenance_lints` doesn't exist in <1.84? That's a
>> bit of a bummer...
>>
>> But I guess we could have this config option (in `init/Kconfig`):
>>
>>     config RUSTC_HAS_STRICT_PROVENANCE
>>             def_bool RUSTC_VERSION >=3D 108400
>>
>> and then do this in `lib.rs`:
>>
>>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_prove=
nance_lints))]
>
> Yep! That's exactly what I did, but as I mentioned up-thread, the
> result is that we only cover the `kernel` crate.

Ah I see, can't we just have the above line in the other crate roots?

>> > Actually this isn't even the only problem. It seems that
>> > `-Astable_features` doesn't affect features enabled on the command
>> > line at all:
>> >
>> > error[E0725]: the feature `strict_provenance` is not in the list of
>> > allowed features
>> >  --> <crate attribute>:1:9
>> >   |
>> > 1 | feature(strict_provenance)
>> >   |         ^^^^^^^^^^^^^^^^^
>>
>> That's because you need to append the feature to `rust_allowed_features`
>> in `scripts/Makefile.build` (AFAIK).
>
> Thanks, that's a helpful pointer, and it solves some problems but not
> all. The root Makefile contains this bit:
>
>> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
>> -Zallow-features=3D $(HOSTRUSTFLAGS)
>
> which means we can't use the provenance lints against these host
> targets (including e.g. `rustdoc_test_gen`). We can't remove this
> -Zallow-features=3D either because then core fails to compile.
>
> I'm at the point where I think I need more involved help. Want to take
> a look at my attempt? It's here:
> https://github.com/tamird/linux/tree/b4/ptr-as-ptr.

I'll take a look tomorrow, you're testing my knowledge of the build
system a lot here :)

---
Cheers,
Benno


