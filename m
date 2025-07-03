Return-Path: <linux-kselftest+bounces-36416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B300AF6EC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 11:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB64A06F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367E2D8782;
	Thu,  3 Jul 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdPt2XDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C81E8338;
	Thu,  3 Jul 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535141; cv=none; b=QdlQs2Ws0Wmug/kDdgXRrlW23jFPjrbgrSFRLi6TjUAB5f9cluP3YatoBEpFiwm5ltFD+x5WpTMQv797cEUxnZvPxxmogeyXj81BR1lPMhZvc1xLEZvmBoR9J7TpSzB9xYuE9fAcnZVUYV4695diHRHQnqikufFs/S9O8GToc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535141; c=relaxed/simple;
	bh=WtO1DgUxyix8oDOSgjZfMtxXQjswM3LI+TSs1gDywZg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l8GvH7Pdrtd4fJCoduqVchA49aHq03u5vBVzfqc5JkCBPapnlo+3Vk7ey0PBwRn1C9EUJ8cLDzZcp4QisnjwGKCJPpV3+EV1qQOZqq6b16ew+cYwtJ1c2FJadMiNicbETT8LWrda9mDjgF5tbdMC/XnqNf6I7WsBQNwFMw7n+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdPt2XDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD0DC4CEE3;
	Thu,  3 Jul 2025 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751535139;
	bh=WtO1DgUxyix8oDOSgjZfMtxXQjswM3LI+TSs1gDywZg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PdPt2XDhT93ntXTcvbBpnFi+Vp43qWrOTV8apH25X/OTbnhL7q3cDHTb+eEs1S6FN
	 byoaUU84MkJoHRtB6frTgxrNxHJ07pzp7FkepC9If0jj/Woeiz8HWUFkxHC7CeQlR5
	 T/5Iea4mPe/5Xf5+6YfdT7aRrUFon4wI1LeIJqR2/5nJvKSN9y/8Z+w5av1BnrjGCj
	 inULlHQYluATDD3nWJfOJsLTnNmVB5K0jK8xLINhcQhHyS96/X5NCTLbc17DFX3OjI
	 ay5ZRmAGoY67ktEqCeRBECvTPRbAc9Qcj4ukGwQrIHoHeiKjak6hbo3yOo4Cm8P9Gt
	 LyMUdqnzaTcPw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 11:32:05 +0200
Message-Id: <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Michal Rostecki"
 <vadorovsky@protonmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Waiman Long" <longman@redhat.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Arnd Bergmann" <arnd@arndb.de>, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
In-Reply-To: <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>

On Tue Jul 1, 2025 at 6:49 PM CEST, Tamir Duberstein wrote:
> Introduce a `fmt!` macro which wraps all arguments in
> `kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enables
> formatting of foreign types (like `core::ffi::CStr`) that do not
> implement `core::fmt::Display` due to concerns around lossy conversions w=
hich
> do not apply in the kernel.
>
> Replace all direct calls to `format_args!` with `fmt!`.
>
> Replace all implementations of `core::fmt::Display` with implementations
> of `kernel::fmt::Display`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General=
/topic/Custom.20formatting/with/516476467
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/block/rnull.rs       |  2 +-
>  drivers/gpu/nova-core/gpu.rs |  4 +-
>  rust/kernel/block/mq.rs      |  2 +-
>  rust/kernel/device.rs        |  2 +-
>  rust/kernel/fmt.rs           | 89 ++++++++++++++++++++++++++++++++++++++=
+
>  rust/kernel/kunit.rs         |  6 +--
>  rust/kernel/lib.rs           |  1 +
>  rust/kernel/prelude.rs       |  3 +-
>  rust/kernel/print.rs         |  4 +-
>  rust/kernel/seq_file.rs      |  2 +-
>  rust/kernel/str.rs           | 22 ++++------
>  rust/macros/fmt.rs           | 99 ++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/macros/lib.rs           | 19 +++++++++
>  rust/macros/quote.rs         |  7 ++++
>  scripts/rustdoc_test_gen.rs  |  2 +-
>  15 files changed, 236 insertions(+), 28 deletions(-)

This would be a lot easier to review if he proc-macro and the call
replacement were different patches.

Also the `kernel/fmt.rs` file should be a different commit.

> diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
> new file mode 100644
> index 000000000000..348d16987de6
> --- /dev/null
> +++ b/rust/kernel/fmt.rs
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Formatting utilities.
> +
> +use core::fmt;

I think we should pub export all types that we are still using from
`core::fmt`. For example `Result`, `Formatter`, `Debug` etc.

That way I can still use the same pattern of importing `fmt` and then
writing

    impl fmt::Display for MyType {
        fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {}
    }

> +
> +/// Internal adapter used to route allow implementations of formatting t=
raits for foreign types.
> +///
> +/// It is inserted automatically by the [`fmt!`] macro and is not meant =
to be used directly.
> +///
> +/// [`fmt!`]: crate::prelude::fmt!
> +#[doc(hidden)]
> +pub struct Adapter<T>(pub T);
> +
> +macro_rules! impl_fmt_adapter_forward {
> +    ($($trait:ident),* $(,)?) =3D> {
> +        $(
> +            impl<T: fmt::$trait> fmt::$trait for Adapter<T> {
> +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result=
 {
> +                    let Self(t) =3D self;
> +                    fmt::$trait::fmt(t, f)
> +                }
> +            }
> +        )*
> +    };
> +}
> +
> +impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, Poin=
ter, LowerExp, UpperExp);
> +
> +/// A copy of [`fmt::Display`] that allows us to implement it for foreig=
n types.
> +///
> +/// Types should implement this trait rather than [`fmt::Display`]. Toge=
ther with the [`Adapter`]
> +/// type and [`fmt!`] macro, it allows for formatting foreign types (e.g=
. types from core) which do
> +/// not implement [`fmt::Display`] directly.
> +///
> +/// [`fmt!`]: crate::prelude::fmt!
> +pub trait Display {
> +    /// Same as [`fmt::Display::fmt`].
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
> +}
> +
> +impl<T: ?Sized + Display> Display for &T {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        Display::fmt(*self, f)
> +    }
> +}
> +
> +impl<T: ?Sized + Display> fmt::Display for Adapter<&T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        let Self(t) =3D self;
> +        Display::fmt(t, f)

Why not `Display::fmt(&self.0, f)`?

> +    }
> +}
> +
> +macro_rules! impl_display_forward {
> +    ($(
> +        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?
> +    ),* $(,)?) =3D> {
> +        $(
> +            impl$($($generics)*)? Display for $ty $(where $($where)*)? {
> +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result=
 {
> +                    fmt::Display::fmt(self, f)
> +                }
> +            }
> +        )*
> +    };
> +}
> +
> +impl_display_forward!(
> +    bool,
> +    char,
> +    core::panic::PanicInfo<'_>,
> +    fmt::Arguments<'_>,
> +    i128,
> +    i16,
> +    i32,
> +    i64,
> +    i8,
> +    isize,
> +    str,
> +    u128,
> +    u16,
> +    u32,
> +    u64,
> +    u8,
> +    usize,
> +    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: fmt::D=
isplay},
> +    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::UniqueAr=
c<T>: fmt::Display},
> +);

> diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
> new file mode 100644
> index 000000000000..edc37c220a89
> --- /dev/null
> +++ b/rust/macros/fmt.rs
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use proc_macro::{Ident, TokenStream, TokenTree};
> +use std::collections::BTreeSet;
> +
> +/// Please see [`crate::fmt`] for documentation.
> +pub(crate) fn fmt(input: TokenStream) -> TokenStream {
> +    let mut input =3D input.into_iter();
> +
> +    let first_opt =3D input.next();
> +    let first_owned_str;
> +    let mut names =3D BTreeSet::new();
> +    let first_lit =3D {
> +        let Some((mut first_str, first_lit)) =3D (match first_opt.as_ref=
() {
> +            Some(TokenTree::Literal(first_lit)) =3D> {
> +                first_owned_str =3D first_lit.to_string();
> +                Some(first_owned_str.as_str()).and_then(|first| {
> +                    let first =3D first.strip_prefix('"')?;
> +                    let first =3D first.strip_suffix('"')?;
> +                    Some((first, first_lit))

You're only using first_lit to get the span later, so why not just get
the span directly here?

> +                })
> +            }
> +            _ =3D> None,
> +        }) else {
> +            return first_opt.into_iter().chain(input).collect();
> +        };
> +        while let Some((_, rest)) =3D first_str.split_once('{') {

Let's put a comment above this loop mentioning [1] and saying that it
parses the identifiers from the format arguments.

[1]: https://doc.rust-lang.org/std/fmt/index.html#syntax

> +            first_str =3D rest;
> +            if let Some(rest) =3D first_str.strip_prefix('{') {
> +                first_str =3D rest;
> +                continue;
> +            }
> +            if let Some((name, rest)) =3D first_str.split_once('}') {
> +                first_str =3D rest;
> +                let name =3D name.split_once(':').map_or(name, |(name, _=
)| name);
> +                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_=
digit()) {
> +                    names.insert(name);
> +                }
> +            }
> +        }
> +        first_lit
> +    };
> +
> +    let first_span =3D first_lit.span();
> +    let adapter =3D quote_spanned! {
> +        first_span =3D> ::kernel::fmt::Adapter
> +    };

I think we should follow the formatting convention from the quote crate:

    let adapter =3D quote_spanned!(first_span=3D> ::kernel::fmt::Adapter);

> +
> +    let mut args =3D TokenStream::from_iter(first_opt);
> +    {
> +        let mut flush =3D |args: &mut TokenStream, current: &mut TokenSt=
ream| {

You don't need to pass `args` as a closure argument, since you always
call it with `&mut args`.

> +            let current =3D std::mem::take(current);
> +            if !current.is_empty() {
> +                let (lhs, rhs) =3D (|| {
> +                    let mut current =3D current.into_iter();
> +                    let mut acc =3D TokenStream::new();
> +                    while let Some(tt) =3D current.next() {
> +                        // Split on `=3D` only once to handle cases like=
 `a =3D b =3D c`.
> +                        if matches!(&tt, TokenTree::Punct(p) if p.as_cha=
r() =3D=3D '=3D') {
> +                            names.remove(acc.to_string().as_str());
> +                            // Include the `=3D` itself to keep the hand=
ling below uniform.
> +                            acc.extend([tt]);
> +                            return (Some(acc), current.collect::<TokenSt=
ream>());
> +                        }
> +                        acc.extend([tt]);
> +                    }
> +                    (None, acc)
> +                })();
> +                args.extend(quote_spanned! {
> +                    first_span =3D> #lhs #adapter(&#rhs)
> +                });
> +            }
> +        };
> +
> +        let mut current =3D TokenStream::new();

Define this before the closure, then you don't need to pass it as an
argument.

---
Cheers,
Benno

> +        for tt in input {
> +            match &tt {
> +                TokenTree::Punct(p) if p.as_char() =3D=3D ',' =3D> {
> +                    flush(&mut args, &mut current);
> +                    &mut args
> +                }
> +                _ =3D> &mut current,
> +            }
> +            .extend([tt]);
> +        }
> +        flush(&mut args, &mut current);
> +    }
> +
> +    for name in names {
> +        let name =3D Ident::new(name, first_span);
> +        args.extend(quote_spanned! {
> +            first_span =3D> , #name =3D #adapter(&#name)
> +        });
> +    }
> +
> +    quote_spanned! {
> +        first_span =3D> ::core::format_args!(#args)
> +    }
> +}

