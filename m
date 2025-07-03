Return-Path: <linux-kselftest+bounces-36454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ED3AF7A51
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91408173631
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E82EE97A;
	Thu,  3 Jul 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqiylDDl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439915442C;
	Thu,  3 Jul 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555316; cv=none; b=XzJnIY2NPr2wHXqiVaAsV4Fk8JURykD9k9T/GKZydB/5g5yMpuKpZH8VJQnOdl8uQXSfdxpTBV4KNstEAICXvcD1qyHiccZPTL9JZoBmbSvjx0juVL9vk8s0XMJe11s9q13hattYb+0mAf5It4tdRSSInsjqDTv0gYhuRLlhMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555316; c=relaxed/simple;
	bh=8GljKLrHpe9kEXKa3hqzrNoCIsl56DSFqDvkVIih/VM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Sc6/BQoNQNdwu8w7Zaiq/Wgo6+QgxsmVrSHskkbAz8z/XeRykUsLOjFL/eCeLlCNyfUsnGlFS/lXU/E3dm5ZQ8qNJyI/7MhxATTCWnBpfsQQFcbNnRh5QJ6ZXJp9lArg5E5Uwk/jKxYHEHw/ryPDgcv/c1oA1ERgLMM+lS5aRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqiylDDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D734DC4CEED;
	Thu,  3 Jul 2025 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751555315;
	bh=8GljKLrHpe9kEXKa3hqzrNoCIsl56DSFqDvkVIih/VM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sqiylDDl2AA2H7oObOdp9HnXMvLCM5hmnb6+/+MaxrqmX3gDy8ZShwCyGlfIyap/G
	 +7azaRN8FrYZT4oKRXiUCRfO+CqSSXm5T9GXI84E6Pa2TuJkvuZQwAROBV5FE5VJ8h
	 g9dT/h6I7czTQp/Rlz02Tp07mpnCYSt4Eoe/Po/8s6XjPEA6/2nULo6w+IShgITWpv
	 9t/P2XvQXr9RVsxQdIg4h7R0n2vQk0Uai3C/J2zSGKxlJvqemQBwkQmFj6KwoFCxVz
	 CBILc4T0vMxDj5eEIfvb3CzXrE1KOadGjHOtdX4cfhY9147utvIV7umZv8Jf5AgeeF
	 vnxs7Lkq8KyeQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 17:08:22 +0200
Message-Id: <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
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
In-Reply-To: <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>

On Thu Jul 3, 2025 at 3:55 PM CEST, Tamir Duberstein wrote:
> On Thu, Jul 3, 2025 at 5:32=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>> On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
>> > Introduce a `fmt!` macro which wraps all arguments in
>> > `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enable=
s
>> > formatting of foreign types (like `core::ffi::CStr`) that do not
>> > implement `core::fmt::Display` due to concerns around lossy conversion=
s which
>> > do not apply in the kernel.
>> >
>> > Replace all direct calls to `format_args!` with `fmt!`.
>> >
>> > Replace all implementations of `core::fmt::Display` with implementatio=
ns
>> > of `kernel::fmt::Display`.
>> >
>> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-Gene=
ral/topic/Custom.20formatting/with/516476467
>> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  drivers/block/rnull.rs       |  2 +-
>> >  drivers/gpu/nova-core/gpu.rs |  4 +-
>> >  rust/kernel/block/mq.rs      |  2 +-
>> >  rust/kernel/device.rs        |  2 +-
>> >  rust/kernel/fmt.rs           | 89 +++++++++++++++++++++++++++++++++++=
++++
>> >  rust/kernel/kunit.rs         |  6 +--
>> >  rust/kernel/lib.rs           |  1 +
>> >  rust/kernel/prelude.rs       |  3 +-
>> >  rust/kernel/print.rs         |  4 +-
>> >  rust/kernel/seq_file.rs      |  2 +-
>> >  rust/kernel/str.rs           | 22 ++++------
>> >  rust/macros/fmt.rs           | 99 +++++++++++++++++++++++++++++++++++=
+++++++++
>> >  rust/macros/lib.rs           | 19 +++++++++
>> >  rust/macros/quote.rs         |  7 ++++
>> >  scripts/rustdoc_test_gen.rs  |  2 +-
>> >  15 files changed, 236 insertions(+), 28 deletions(-)
>>
>> This would be a lot easier to review if he proc-macro and the call
>> replacement were different patches.
>>
>> Also the `kernel/fmt.rs` file should be a different commit.
>
> Can you help me understand why? The changes you ask to be separated
> would all be in different files, so why would separate commits make it
> easier to review?

It takes less time to go through the entire patch and give a RB. I can
take smaller time chunks and don't have to get back into the entire
context of the patch when I don't have 30-60min available.

In this patch the biggest problem is the rename & addition of new
things, maybe just adding 200 lines in those files could be okay to go
together, see below for more.

> I prefer to keep things in one commit because the changes are highly
> interdependent. The proc macro doesn't make sense without
> kernel/fmt.rs and kernel/fmt.rs is useless without the proc macro.

I think that `Adapter`, the custom `Display` and their impl blocks
don't need to be in the same commit as the proc-macro. They are related,
but maybe someone is not well-versed in proc-macros and thus doesn't
want to review that part.

>> > diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
>> > new file mode 100644
>> > index 000000000000..348d16987de6
>> > --- /dev/null
>> > +++ b/rust/kernel/fmt.rs
>> > @@ -0,0 +1,89 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +//! Formatting utilities.
>> > +
>> > +use core::fmt;
>>
>> I think we should pub export all types that we are still using from
>> `core::fmt`. For example `Result`, `Formatter`, `Debug` etc.
>>
>> That way I can still use the same pattern of importing `fmt` and then
>> writing
>>
>>     impl fmt::Display for MyType {
>>         fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {}
>>     }
>
> Great idea, done for the next spin. It would be nice to be able to
> lint against references to `core::fmt` outside of kernel/fmt.rs.

I think there was something in clippy that can do that globally and we
could allow that in this file?

>> > +
>> > +/// Internal adapter used to route allow implementations of formattin=
g traits for foreign types.
>> > +///
>> > +/// It is inserted automatically by the [`fmt!`] macro and is not mea=
nt to be used directly.
>> > +///
>> > +/// [`fmt!`]: crate::prelude::fmt!
>> > +#[doc(hidden)]
>> > +pub struct Adapter<T>(pub T);
>> > +
>> > +macro_rules! impl_fmt_adapter_forward {
>> > +    ($($trait:ident),* $(,)?) =3D> {
>> > +        $(
>> > +            impl<T: fmt::$trait> fmt::$trait for Adapter<T> {
>> > +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Res=
ult {
>> > +                    let Self(t) =3D self;
>> > +                    fmt::$trait::fmt(t, f)
>> > +                }
>> > +            }
>> > +        )*
>> > +    };
>> > +}
>> > +
>> > +impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, P=
ointer, LowerExp, UpperExp);
>> > +
>> > +/// A copy of [`fmt::Display`] that allows us to implement it for for=
eign types.
>> > +///
>> > +/// Types should implement this trait rather than [`fmt::Display`]. T=
ogether with the [`Adapter`]
>> > +/// type and [`fmt!`] macro, it allows for formatting foreign types (=
e.g. types from core) which do
>> > +/// not implement [`fmt::Display`] directly.
>> > +///
>> > +/// [`fmt!`]: crate::prelude::fmt!
>> > +pub trait Display {
>> > +    /// Same as [`fmt::Display::fmt`].
>> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
>> > +}
>> > +
>> > +impl<T: ?Sized + Display> Display for &T {
>> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> > +        Display::fmt(*self, f)
>> > +    }
>> > +}
>> > +
>> > +impl<T: ?Sized + Display> fmt::Display for Adapter<&T> {
>> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> > +        let Self(t) =3D self;
>> > +        Display::fmt(t, f)
>>
>> Why not `Display::fmt(&self.0, f)`?
>
> I like destructuring because it shows me that there's only one field.
> With `self.0` I don't see that.

And what is the benefit here?

>> > +
>> > +    let mut args =3D TokenStream::from_iter(first_opt);
>> > +    {
>> > +        let mut flush =3D |args: &mut TokenStream, current: &mut Toke=
nStream| {
>>
>> You don't need to pass `args` as a closure argument, since you always
>> call it with `&mut args`.
>
> This doesn't work because of the borrow checker. If I wrote what you
> suggest, then `args` is mutably borrowed by the closure, which
> prohibits the mutable borrow needed for the .extend() call here:

Ahh right... Well then it's fine.

---
Cheers,
Benno

