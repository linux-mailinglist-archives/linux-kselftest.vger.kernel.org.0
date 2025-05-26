Return-Path: <linux-kselftest+bounces-33800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54FAC41BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B03B6F20
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D7202C4E;
	Mon, 26 May 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAKgDeOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00E8632E;
	Mon, 26 May 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270922; cv=none; b=Wee+g+EJe4+4BiHsKcU337aNBBhRW3uJBlebSn7k2lipm1+ulT7Bd0MesgBH778GU2g+8rf2ekN2OoGB4mGEQ5YmGORAVfo0LFzBDZ5/kF4RpDbrJftn1yIDpxFYXvXwDLm2je+YQsj3vPF6xUFmNwrVyICRnYQiwUnlMosXiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270922; c=relaxed/simple;
	bh=wBSjlHGNRQDRqB+ma/+xuxNLxRPRajk9mKyWstlLURE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ozLvFa1caXEDgjNcUmOb+hlYZIUFeY6MCaE/preVr3wi3bVdkuUzHWzjfTxFdxff+NiQT0RYd5/wMtwq/N8Uo6OTCa+z1jGZSBquABcDQa8Y/4nzQlKCWtd2hnjoQIL+wL17dsYbI2rHFLV1xHFToUK3Q4Bb5TJoT3aT0iezUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAKgDeOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70502C4CEE7;
	Mon, 26 May 2025 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748270920;
	bh=wBSjlHGNRQDRqB+ma/+xuxNLxRPRajk9mKyWstlLURE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qAKgDeOeLFHIiUNqjpfbXYoBZHqonFRvnmlNWDQZwM0QMTP3uXgOV/ZP+/6xn7w4f
	 9UUnDZRJI4TFF4BCJ6USYMFF3NZOTd+cBXKdx0G6iE8k8iGJiM5L/rsUMGuoPEjA52
	 dqoLEYVTv5wsTw3u1vuptCfigjPD499q8Y+z8VTF2XQp2LsaBaiaVIbogmgFy3IAC1
	 SWHkbzfltFYl+AXuXOW18w0Ajb+j9SMPfUjtSmZBpIyDbNEMlGWIZGF7TJbxoP7XW7
	 17czPeU/xr6arHkwez+aYbulUKx3Jrms7mTjbZRTyRd+lLbbGz9WZpKTTMchimC4St
	 YVO6vIZf2xSaw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 16:48:28 +0200
Message-Id: <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
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
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com>
In-Reply-To: <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com>

On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> Introduce a `fmt!` macro which wraps all arguments in
> `kernel::fmt::Adapter` This enables formatting of foreign types (like
> `core::ffi::CStr`) that do not implement `fmt::Display` due to concerns
> around lossy conversions which do not apply in the kernel.
>
> Replace all direct calls to `format_args!` with `fmt!`.
>
> In preparation for replacing our `CStr` with `core::ffi::CStr`, move its
> `fmt::Display` implementation to `kernel::fmt::Adapter<&CStr>`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General=
/topic/Custom.20formatting/with/516476467
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/block/rnull.rs      |   2 +-
>  rust/kernel/block/mq.rs     |   2 +-
>  rust/kernel/device.rs       |   2 +-
>  rust/kernel/fmt.rs          |  77 +++++++++++++++++++++++++++++
>  rust/kernel/kunit.rs        |   6 +--
>  rust/kernel/lib.rs          |   1 +
>  rust/kernel/prelude.rs      |   3 +-
>  rust/kernel/print.rs        |   4 +-
>  rust/kernel/seq_file.rs     |   2 +-
>  rust/kernel/str.rs          |  23 ++++-----
>  rust/macros/fmt.rs          | 118 ++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/macros/lib.rs          |  19 +++++++
>  scripts/rustdoc_test_gen.rs |   2 +-
>  13 files changed, 235 insertions(+), 26 deletions(-)

Can you split this into creating the proc-macro, forwarding the display
impls and replacing all the uses with the proc macro?

> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
> index d07e76ae2c13..6366da12c5a5 100644
> --- a/drivers/block/rnull.rs
> +++ b/drivers/block/rnull.rs
> @@ -51,7 +51,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<S=
elf, Error> {
>                  .logical_block_size(4096)?
>                  .physical_block_size(4096)?
>                  .rotational(false)
> -                .build(format_args!("rnullb{}", 0), tagset)
> +                .build(fmt!("rnullb{}", 0), tagset)
>          })();
> =20
>          try_pin_init!(Self {
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> index fb0f393c1cea..842be88aa1cf 100644
> --- a/rust/kernel/block/mq.rs
> +++ b/rust/kernel/block/mq.rs
> @@ -82,7 +82,7 @@
>  //!     Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
>  //! let mut disk =3D gen_disk::GenDiskBuilder::new()
>  //!     .capacity_sectors(4096)
> -//!     .build(format_args!("myblk"), tagset)?;
> +//!     .build(fmt!("myblk"), tagset)?;
>  //!
>  //! # Ok::<(), kernel::error::Error>(())
>  //! ```
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 5c372cf27ed0..99d99a76934c 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -240,7 +240,7 @@ impl DeviceContext for Normal {}
>  macro_rules! dev_printk {
>      ($method:ident, $dev:expr, $($f:tt)*) =3D> {
>          {
> -            ($dev).$method(core::format_args!($($f)*));
> +            ($dev).$method($crate::prelude::fmt!($($f)*));
>          }
>      }
>  }
> diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
> new file mode 100644
> index 000000000000..12b08debc3b3
> --- /dev/null
> +++ b/rust/kernel/fmt.rs
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Formatting utilities.
> +
> +use core::fmt;
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
> +macro_rules! impl_display_forward {
> +    ($(
> +        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?

You don't need `{}` around the `where` clause, as a `where` keyword can
follow a `ty` fragment.

> +    ),* $(,)?) =3D> {
> +        $(
> +            impl$($($generics)*)? fmt::Display for Adapter<&$ty>
> +            $(where $($where)*)? {
> +                fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result=
 {
> +                    let Self(t) =3D self;
> +                    fmt::Display::fmt(t, f)
> +                }
> +            }
> +        )*
> +    };
> +}
> +
> +impl<T: ?Sized> fmt::Display for Adapter<&&T>
> +where
> +    for<'a> Adapter<&'a T>: fmt::Display,
> +{
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        let Self(t) =3D self;
> +        Adapter::<&T>(**t).fmt(f)
> +    }
> +}
> +
> +impl_display_forward!(
> +    bool,
> +    char,
> +    core::panic::PanicInfo<'_>,
> +    crate::str::BStr,
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

If we use `{}` instead of `()`, then we can format the contents
differently:

    impl_display_forward! {
        i8, i16, i32, i64, i128, isize,
        u8, u16, u32, u64, u128, usize,
        bool, char, str,
        crate::str::BStr,
        fmt::Arguments<'_>,
        core::panic::PanicInfo<'_>,
        {<T: ?Sized>} crate::sync::Arc<T> {where Self: fmt::Display},
        {<T: ?Sized>} crate::sync::UniqueArc<T> {where Self: fmt::Display},
    }

> diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
> new file mode 100644
> index 000000000000..6b6bd9295d18
> --- /dev/null
> +++ b/rust/macros/fmt.rs
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use proc_macro::{Delimiter, Group, Ident, Punct, Spacing, Span, TokenStr=
eam, TokenTree};
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
> +                })
> +            }
> +            _ =3D> None,
> +        }) else {
> +            return first_opt.into_iter().chain(input).collect();
> +        };

This usage of let-else + match is pretty confusing and could just be a
single match statement.

> +        while let Some((_, rest)) =3D first_str.split_once('{') {
> +            first_str =3D rest;
> +            if let Some(rest) =3D first_str.strip_prefix('{') {
> +                first_str =3D rest;
> +                continue;
> +            }
> +            while let Some((name, rest)) =3D first_str.split_once('}') {
> +                first_str =3D rest;
> +                if let Some(rest) =3D first_str.strip_prefix('}') {

This doesn't make sense, we've matched a `{`, some text and a `}`. You
can't escape a `}` that is associated to a `{`.

> +                    first_str =3D rest;
> +                    continue;
> +                }
> +                let name =3D name.split_once(':').map_or(name, |(name, _=
)| name);
> +                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_=
digit()) {
> +                    names.insert(name);
> +                }
> +                break;
> +            }
> +        }
> +        first_lit

`first_lit` is not modified, so could we just the code above it into a
block instead of keeping it in the expr for `first_lit`?

> +    };
> +
> +    let first_span =3D first_lit.span();
> +    let adapt =3D |expr| {
> +        let mut borrow =3D
> +            TokenStream::from_iter([TokenTree::Punct(Punct::new('&', Spa=
cing::Alone))]);
> +        borrow.extend(expr);
> +        make_ident(first_span, ["kernel", "fmt", "Adapter"])
> +            .chain([TokenTree::Group(Group::new(Delimiter::Parenthesis, =
borrow))])

This should be fine with using `quote!`:

    quote!(::kernel::fmt::Adapter(&#expr))

> +    };
> +
> +    let flush =3D |args: &mut TokenStream, current: &mut TokenStream| {
> +        let current =3D std::mem::take(current);
> +        if !current.is_empty() {
> +            args.extend(adapt(current));
> +        }
> +    };
> +
> +    let mut args =3D TokenStream::from_iter(first_opt);
> +    {
> +        let mut current =3D TokenStream::new();
> +        for tt in input {
> +            match &tt {
> +                TokenTree::Punct(p) =3D> match p.as_char() {
> +                    ',' =3D> {
> +                        flush(&mut args, &mut current);
> +                        &mut args
> +                    }
> +                    '=3D' =3D> {
> +                        names.remove(current.to_string().as_str());
> +                        args.extend(std::mem::take(&mut current));
> +                        &mut args
> +                    }
> +                    _ =3D> &mut current,
> +                },
> +                _ =3D> &mut current,
> +            }
> +            .extend([tt]);
> +        }

This doesn't handle the following code correctly ):

    let mut a =3D 0;
    pr_info!("{a:?}", a =3D a =3D a);

Looks like we'll have to remember what "kind" of an equals we parsed...

> +        flush(&mut args, &mut current);
> +    }
> +
> +    for name in names {
> +        args.extend(
> +            [
> +                TokenTree::Punct(Punct::new(',', Spacing::Alone)),
> +                TokenTree::Ident(Ident::new(name, first_span)),
> +                TokenTree::Punct(Punct::new('=3D', Spacing::Alone)),
> +            ]
> +            .into_iter()
> +            .chain(adapt(TokenTree::Ident(Ident::new(name, first_span)).=
into())),
> +        );

This can probably be:

    let name =3D Ident::new(name, first_span);
    let value =3D adapt(name.clone());
    args.extend(quote!(, #name =3D #value));

> +    }
> +
> +    TokenStream::from_iter(make_ident(first_span, ["core", "format_args"=
]).chain([
> +        TokenTree::Punct(Punct::new('!', Spacing::Alone)),
> +        TokenTree::Group(Group::new(Delimiter::Parenthesis, args)),
> +    ]))

This can be:

    quote!(::core::format_args!(#args))

(not sure if you need `#(#args)*`)

> +}
> +
> +fn make_ident<'a, T: IntoIterator<Item =3D &'a str>>(
> +    span: Span,
> +    names: T,
> +) -> impl Iterator<Item =3D TokenTree> + use<'a, T> {
> +    names.into_iter().flat_map(move |name| {
> +        [
> +            TokenTree::Punct(Punct::new(':', Spacing::Joint)),
> +            TokenTree::Punct(Punct::new(':', Spacing::Alone)),
> +            TokenTree::Ident(Ident::new(name, span)),
> +        ]
> +    })
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d31e50c446b0..fa956eaa3ba7 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -10,6 +10,7 @@
>  mod quote;
>  mod concat_idents;
>  mod export;
> +mod fmt;
>  mod helpers;
>  mod kunit;
>  mod module;
> @@ -196,6 +197,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) ->=
 TokenStream {
>      export::export(attr, ts)
>  }
> =20
> +/// Like [`core::format_args!`], but automatically wraps arguments in [`=
kernel::fmt::Adapter`].
> +///
> +/// This macro allows generating `core::fmt::Arguments` while ensuring t=
hat each argument is wrapped
> +/// with `::kernel::fmt::Adapter`, which customizes formatting behavior =
for kernel logging.
> +///
> +/// Named arguments used in the format string (e.g. `{foo}`) are detecte=
d and resolved from local
> +/// bindings. All positional and named arguments are automatically wrapp=
ed.
> +///
> +/// This macro is an implementation detail of other kernel logging macro=
s like [`pr_info!`] and
> +/// should not typically be used directly.
> +///
> +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
> +/// [`pr_info!`]: ../kernel/macro.pr_info.html
> +#[proc_macro]
> +pub fn fmt(input: TokenStream) -> TokenStream {

I'm wondering if we should name this `format_args` instead in order to
better communicate that it's a replacement for `core::format_args!`.

---
Cheers,
Benno

> +    fmt::fmt(input)
> +}
> +
>  /// Concatenate two identifiers.
>  ///
>  /// This is useful in macros that need to declare or reference items wit=
h names
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index ec8d70ac888b..22ed9ee14053 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -197,7 +197,7 @@ macro_rules! assert_eq {{
>      // This follows the syntax for declaring test metadata in the propos=
ed KTAP v2 spec, which may
>      // be used for the proposed KUnit test attributes API. Thus hopefull=
y this will make migration
>      // easier later on.
> -    kernel::kunit::info(format_args!("    # {kunit_name}.location: {real=
_path}:{line}\n"));
> +    kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{=
line}\n"));
> =20
>      /// The anchor where the test code body starts.
>      #[allow(unused)]


