Return-Path: <linux-kselftest+bounces-36483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037DAF81FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 22:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2B73B1D5A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA652BD005;
	Thu,  3 Jul 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUnuMd3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2325A333;
	Thu,  3 Jul 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574999; cv=none; b=nh7JWb7F08oAm0z+fR2U+L2ON9DV3v/EVpKZ9iTe2kocaklpJ0ZxBwkLTkpIOdEPXU97krjvveGvnEtRasu1rkqbSfs8QQstg3rgvGXH8as+FhmhJyKeVEf3L4qX3uswW85/ze+pLPT8P0b0ckfseX/HrsOkfGmB1Ef3EV3F1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574999; c=relaxed/simple;
	bh=2saPPEn9425FFhvGNMi4caxWoimFmbNxhrNrgWcW1xo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ss+AVcWIbD8qRQ98ZUqYkZytm1EQL5vL5u9B0h0/sy88zX6MElKoraWLhMk9bb7/7qCiCCDev6PqCupntVMBotT7NwugcSrVgn43HoBGJ7TwIbYzH5JGHjFv096UcNlOxfVvy4hFrTx1SSltKDbwmW2B+UUaNz/QfFNVGqGWYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUnuMd3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E8C4CEE3;
	Thu,  3 Jul 2025 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751574999;
	bh=2saPPEn9425FFhvGNMi4caxWoimFmbNxhrNrgWcW1xo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aUnuMd3lAzNVdHKmsSOkvyHqWUVDyN6+5VbON6S2ighNhr4Tqjp9O3PhBDDj2sMad
	 nqxCBeHK5NzhhRVBPjYzNndcgZ/kccpdZAdcJWBV0o9saMIsKJAWtx1ZkxONmMjsdr
	 Udb4YVLk7WBZhm6YqdnYo3NrMhiTwycvAl2TEYwhBHH1wcp24c1oCYgr5FJhsvYWLt
	 1A7y65+nZaib48GBOEWOV35upeNutd7vyU0IEd94P3uJ8clcVdtjcPpjKfd75HpyQw
	 ZTiOSvUP4VLDscuViykR0Ij4TSTNCChDAd0OR28SQwH0lJd3J8F6FFoacf3Y1B8Imb
	 NEJPgnffMTCAQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 22:36:26 +0200
Message-Id: <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org>
Cc: "Michal Rostecki" <vadorovsky@protonmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Jens Axboe" <axboe@kernel.dk>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Dave
 Ertman" <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
 <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
 <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>

On Thu Jul 3, 2025 at 8:55 PM CEST, Tamir Duberstein wrote:
> On Thu, Jul 3, 2025 at 11:08=E2=80=AFAM Benno Lossin <lossin@kernel.org> =
wrote:
>> On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
>> > On Thu, Jul 3, 2025 at 5:32=E2=80=AFAM Benno Lossin <lossin@kernel.org=
> wrote:
>> >> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
>> >> > Introduce a `fmt!` macro which wraps all arguments in
>> >> > `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This ena=
bles
>> >> > formatting of foreign types (like `core::ffi::CStr`) that do not
>> >> > implement `core::fmt::Display` due to concerns around lossy convers=
ions which
>> >> > do not apply in the kernel.
>> >> >
>> >> > Replace all direct calls to `format_args!` with `fmt!`.
>> >> >
>> >> > Replace all implementations of `core::fmt::Display` with implementa=
tions
>> >> > of `kernel::fmt::Display`.
>> >> >
>> >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> >> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-G=
eneral/topic/Custom.20formatting/with/516476467
>> >> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> >> > ---
>> >> >  drivers/block/rnull.rs       |  2 +-
>> >> >  drivers/gpu/nova-core/gpu.rs |  4 +-
>> >> >  rust/kernel/block/mq.rs      |  2 +-
>> >> >  rust/kernel/device.rs        |  2 +-
>> >> >  rust/kernel/fmt.rs           | 89 ++++++++++++++++++++++++++++++++=
+++++++
>> >> >  rust/kernel/kunit.rs         |  6 +--
>> >> >  rust/kernel/lib.rs           |  1 +
>> >> >  rust/kernel/prelude.rs       |  3 +-
>> >> >  rust/kernel/print.rs         |  4 +-
>> >> >  rust/kernel/seq_file.rs      |  2 +-
>> >> >  rust/kernel/str.rs           | 22 ++++------
>> >> >  rust/macros/fmt.rs           | 99 ++++++++++++++++++++++++++++++++=
++++++++++++
>> >> >  rust/macros/lib.rs           | 19 +++++++++
>> >> >  rust/macros/quote.rs         |  7 ++++
>> >> >  scripts/rustdoc_test_gen.rs  |  2 +-
>> >> >  15 files changed, 236 insertions(+), 28 deletions(-)
>> >>
>> >> This would be a lot easier to review if he proc-macro and the call
>> >> replacement were different patches.
>> >>
>> >> Also the `kernel/fmt.rs` file should be a different commit.
>> >
>> > Can you help me understand why? The changes you ask to be separated
>> > would all be in different files, so why would separate commits make it
>> > easier to review?
>>
>> It takes less time to go through the entire patch and give a RB. I can
>> take smaller time chunks and don't have to get back into the entire
>> context of the patch when I don't have 30-60min available.
>
> Ah, I see what you mean. Yeah, the requirement to RB the entire patch
> does mean there's a benefit to smaller patches.
>
>> In this patch the biggest problem is the rename & addition of new
>> things, maybe just adding 200 lines in those files could be okay to go
>> together, see below for more.
>
> After implementing your suggestion of re-exporting things from
> `kernel::fmt` the diffstat is
>
> 26 files changed, 253 insertions(+), 51 deletions(-)
>
> so I guess I could do all the additions in one patch, but then
> *everything* else has to go in a single patch together because the
> formatting macros either want core::fmt::Display or
> kernel::fmt::Display; they can't work in a halfway state.

I don't understand, can't you just do:

* add `rust/kernel/fmt.rs`,
* add `rust/macros/fmt.rs`,
* change all occurrences of `core::fmt` to `kernel::fmt` and
  `format_args!` to `fmt!`.

The last one could be split by subsystem, no? Some subsystems might
interact and thus need simultaneous splitting, but there should be some
independent ones.

>> > I prefer to keep things in one commit because the changes are highly
>> > interdependent. The proc macro doesn't make sense without
>> > kernel/fmt.rs and kernel/fmt.rs is useless without the proc macro.
>>
>> I think that `Adapter`, the custom `Display` and their impl blocks
>> don't need to be in the same commit as the proc-macro. They are related,
>> but maybe someone is not well-versed in proc-macros and thus doesn't
>> want to review that part.
>
> Sure, I guess I will split them. But as noted above: changing the
> formatting macros and all the types' trait implementations has to be a
> "flag day" change.

See above.

>> >> > +impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary=
, Pointer, LowerExp, UpperExp);
>> >> > +
>> >> > +/// A copy of [`fmt::Display`] that allows us to implement it for =
foreign types.
>> >> > +///
>> >> > +/// Types should implement this trait rather than [`fmt::Display`]=
. Together with the [`Adapter`]
>> >> > +/// type and [`fmt!`] macro, it allows for formatting foreign type=
s (e.g. types from core) which do
>> >> > +/// not implement [`fmt::Display`] directly.
>> >> > +///
>> >> > +/// [`fmt!`]: crate::prelude::fmt!
>> >> > +pub trait Display {
>> >> > +    /// Same as [`fmt::Display::fmt`].
>> >> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
>> >> > +}
>> >> > +
>> >> > +impl<T: ?Sized + Display> Display for &T {
>> >> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> >> > +        Display::fmt(*self, f)
>> >> > +    }
>> >> > +}
>> >> > +
>> >> > +impl<T: ?Sized + Display> fmt::Display for Adapter<&T> {
>> >> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> >> > +        let Self(t) =3D self;
>> >> > +        Display::fmt(t, f)
>> >>
>> >> Why not `Display::fmt(&self.0, f)`?
>> >
>> > I like destructuring because it shows me that there's only one field.
>> > With `self.0` I don't see that.
>>
>> And what is the benefit here?
>
> In general the benefit is that the method does not ignore some portion
> of `Self`. A method that uses `self.0` would not provoke a compiler
> error in case another field is added, while this form would.

Yeah, but why would that change happen here? And even if it got another
field, why would that invalidate the impl of `fn fmt`?

---
Cheers,
Benno

