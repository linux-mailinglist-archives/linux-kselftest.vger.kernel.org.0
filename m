Return-Path: <linux-kselftest+bounces-33824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9241AC455F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 01:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE5189DBED
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E91F2C44;
	Mon, 26 May 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puXbdJh4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A14A0A;
	Mon, 26 May 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748300487; cv=none; b=HsxTwaF50rtJ4Hq5dVv9o3zsS9Mxi24vE5n7cg5L4K/8bd8cgThTCb0OnY8+nN2P5r6MeKlDu3WYTJKZUJriVFTXYQrLJNOnprTGAnSbffgAZVs4IveZjh0PWEn1ejk8X11qUnkWrAF8Aw8dnv/vb80ztaJEdWA22wIrIBkZS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748300487; c=relaxed/simple;
	bh=gdWkCW3i85a9802OvEhuaRRO+l5Arqi+Um0dBRzUNBo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=B8QYVxM3MFM9+CAvt8XKIKBzjoNo3pzvatd6aHHUnEKNmr909el/MrSr/Ya7T9CUdnw7piDQNIJ3My8IoCswPw6Jo8K3UD7aqti1mcypZ/b//hlKXaYdjFrh83lQxrbNA9X6sooaIqUKkFgjPR3pb1jx1bW85Si5/QAb/lwM88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puXbdJh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B074AC4CEE7;
	Mon, 26 May 2025 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748300487;
	bh=gdWkCW3i85a9802OvEhuaRRO+l5Arqi+Um0dBRzUNBo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=puXbdJh458H0ytsMXEcTP/8nhEUde8SJB6WzylGroMZ6hCcBpaVnAQgPjw3Ba6THW
	 2bEZV6eR7/oelzU2j90iDDau89ONRz9VQG8CsAvxFw0ovmww9V5UzoRYwAxLLTf2i/
	 /+9fxqggnETjGr1uR7Qofzo46xdCQTOkJwp63TtuZfCewMe5BRyXtHAuokwPCPHXBx
	 wv2WkLw9lhqw5jbL9rqGBmZkQ2mPmv9NQRGOmhlPWhgXPSxR5wIugqQXfD7SJesRa+
	 A/DN8SB2g+JpgIy/AfXmNDfK6t1P90z/59Gnc+/JGUVDV6myXkMSOWHJ+NmKdzXJUQ
	 qSUvmspelBZAA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 01:01:15 +0200
Message-Id: <DA6GSMHMLRFM.YH9RGZWLY2X4@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v10 2/5] rust: support formatting of foreign types
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-2-6412a94d9d75@gmail.com>
 <DA66BBX1PDGI.10NHLG3D4CIT7@kernel.org>
 <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>
In-Reply-To: <CAJ-ks9m48gmar0WWP9WknV2JLqkKNU0X4nwXaQ+JdG+b-EcVxA@mail.gmail.com>

On Tue May 27, 2025 at 12:17 AM CEST, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 10:48=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
>> > Introduce a `fmt!` macro which wraps all arguments in
>> > `kernel::fmt::Adapter` This enables formatting of foreign types (like
>> > `core::ffi::CStr`) that do not implement `fmt::Display` due to concern=
s
>> > around lossy conversions which do not apply in the kernel.
>> >
>> > Replace all direct calls to `format_args!` with `fmt!`.
>> >
>> > In preparation for replacing our `CStr` with `core::ffi::CStr`, move i=
ts
>> > `fmt::Display` implementation to `kernel::fmt::Adapter<&CStr>`.
>> >
>> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> > Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-Gene=
ral/topic/Custom.20formatting/with/516476467
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  drivers/block/rnull.rs      |   2 +-
>> >  rust/kernel/block/mq.rs     |   2 +-
>> >  rust/kernel/device.rs       |   2 +-
>> >  rust/kernel/fmt.rs          |  77 +++++++++++++++++++++++++++++
>> >  rust/kernel/kunit.rs        |   6 +--
>> >  rust/kernel/lib.rs          |   1 +
>> >  rust/kernel/prelude.rs      |   3 +-
>> >  rust/kernel/print.rs        |   4 +-
>> >  rust/kernel/seq_file.rs     |   2 +-
>> >  rust/kernel/str.rs          |  23 ++++-----
>> >  rust/macros/fmt.rs          | 118 +++++++++++++++++++++++++++++++++++=
+++++++++
>> >  rust/macros/lib.rs          |  19 +++++++
>> >  scripts/rustdoc_test_gen.rs |   2 +-
>> >  13 files changed, 235 insertions(+), 26 deletions(-)
>>
>> Can you split this into creating the proc-macro, forwarding the display
>> impls and replacing all the uses with the proc macro?
>
> Can you help me understand why that's better?

It makes reviewing significantly easier.

>> > +macro_rules! impl_display_forward {
>> > +    ($(
>> > +        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } =
)?
>>
>> You don't need `{}` around the `where` clause, as a `where` keyword can
>> follow a `ty` fragment.
>
> This doesn't work:
> ```
> error: local ambiguity when calling macro `impl_display_forward`:
> multiple parsing options: built-in NTs tt ('r#where') or 2 other
> options.
>   --> rust/kernel/fmt.rs:75:78
>    |
> 75 |     {<T: ?Sized>} crate::sync::Arc<T> where crate::sync::Arc<T>:
> fmt::Display,
>    |
>            ^
> ```

Ah right that's a shame, forgot about the `tt`s at the end...

>> > +impl_display_forward!(
>> > +    bool,
>> > +    char,
>> > +    core::panic::PanicInfo<'_>,
>> > +    crate::str::BStr,
>> > +    fmt::Arguments<'_>,
>> > +    i128,
>> > +    i16,
>> > +    i32,
>> > +    i64,
>> > +    i8,
>> > +    isize,
>> > +    str,
>> > +    u128,
>> > +    u16,
>> > +    u32,
>> > +    u64,
>> > +    u8,
>> > +    usize,
>> > +    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: fmt=
::Display},
>> > +    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::Uniqu=
eArc<T>: fmt::Display},
>> > +);
>>
>> If we use `{}` instead of `()`, then we can format the contents
>> differently:
>>
>>     impl_display_forward! {
>>         i8, i16, i32, i64, i128, isize,
>>         u8, u16, u32, u64, u128, usize,
>>         bool, char, str,
>>         crate::str::BStr,
>>         fmt::Arguments<'_>,
>>         core::panic::PanicInfo<'_>,
>>         {<T: ?Sized>} crate::sync::Arc<T> {where Self: fmt::Display},
>>         {<T: ?Sized>} crate::sync::UniqueArc<T> {where Self: fmt::Displa=
y},
>>     }
>
> Is that formatting better? rustfmt refuses to touch it either way.

Yeah rustfmt doesn't touch macro parameters enclosed in `{}`. I think
it's better.

>> > +/// Please see [`crate::fmt`] for documentation.
>> > +pub(crate) fn fmt(input: TokenStream) -> TokenStream {
>> > +    let mut input =3D input.into_iter();
>> > +
>> > +    let first_opt =3D input.next();
>> > +    let first_owned_str;
>> > +    let mut names =3D BTreeSet::new();
>> > +    let first_lit =3D {
>> > +        let Some((mut first_str, first_lit)) =3D (match first_opt.as_=
ref() {
>> > +            Some(TokenTree::Literal(first_lit)) =3D> {
>> > +                first_owned_str =3D first_lit.to_string();
>> > +                Some(first_owned_str.as_str()).and_then(|first| {
>> > +                    let first =3D first.strip_prefix('"')?;
>> > +                    let first =3D first.strip_suffix('"')?;
>> > +                    Some((first, first_lit))
>> > +                })
>> > +            }
>> > +            _ =3D> None,
>> > +        }) else {
>> > +            return first_opt.into_iter().chain(input).collect();
>> > +        };
>>
>> This usage of let-else + match is pretty confusing and could just be a
>> single match statement.
>
> I don't think so. Can you try rewriting it into the form you like?

    let (mut first_str, first_lit) match first_opt.as_ref() {
        Some(TokenTree::Literal(lit)) if lit.to_string().starts_with('"') =
=3D> {
            let contents =3D lit.to_string();
            let contents =3D contents.strip_prefix('"').unwrap().strip_suff=
ix('"').unwrap();
            ((contents, lit))
        }
        _ =3D> return first_opt.into_iter().chain(input).collect(),
    };

>> > +        while let Some((_, rest)) =3D first_str.split_once('{') {
>> > +            first_str =3D rest;
>> > +            if let Some(rest) =3D first_str.strip_prefix('{') {
>> > +                first_str =3D rest;
>> > +                continue;
>> > +            }
>> > +            while let Some((name, rest)) =3D first_str.split_once('}'=
) {
>> > +                first_str =3D rest;
>> > +                if let Some(rest) =3D first_str.strip_prefix('}') {
>>
>> This doesn't make sense, we've matched a `{`, some text and a `}`. You
>> can't escape a `}` that is associated to a `{`.
>
> Sure, but such input would be malformed, so I don't think it's
> necessary to handle it "perfectly". We'll get a nice error from
> format_args anyhow.

My suggestion in this case would be to just remove this if-let. The
search for `{` above would skip the `}` if it's correct.

> https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2024&=
gist=3D5f529d93da7cf46b3c99ba7772623e33

Yes it will error like that, but if we do the replacement only when the
syntax is correct, there also will be compile errors because of a
missing `Display` impl, or is that not the case?

I'm a bit concerned about the ergonomics that this change will
introduce, but I guess there really isn't anything that we can do about
except not do it.

>> > +                    first_str =3D rest;
>> > +                    continue;
>> > +                }
>> > +                let name =3D name.split_once(':').map_or(name, |(name=
, _)| name);
>> > +                if !name.is_empty() && !name.chars().all(|c| c.is_asc=
ii_digit()) {
>> > +                    names.insert(name);
>> > +                }
>> > +                break;
>> > +            }
>> > +        }
>> > +        first_lit
>>
>> `first_lit` is not modified, so could we just the code above it into a
>> block instead of keeping it in the expr for `first_lit`?
>
> As above, can you suggest the alternate form you like better? The
> gymnastics here are all in service of being able to let malformed
> input fall through to core::format_args which will do the hard work of
> producing good diagnostics.

I don't see how this is hard, just do:

    let (first_str, first_lit) =3D ...;

    while ...

>> > +    };
>> > +
>> > +    let first_span =3D first_lit.span();
>> > +    let adapt =3D |expr| {
>> > +        let mut borrow =3D
>> > +            TokenStream::from_iter([TokenTree::Punct(Punct::new('&', =
Spacing::Alone))]);
>> > +        borrow.extend(expr);
>> > +        make_ident(first_span, ["kernel", "fmt", "Adapter"])
>> > +            .chain([TokenTree::Group(Group::new(Delimiter::Parenthesi=
s, borrow))])
>>
>> This should be fine with using `quote!`:
>>
>>     quote!(::kernel::fmt::Adapter(&#expr))
>
> Yeah, I have a local commit that uses quote_spanned to remove all the
> manual constructions.

I don't think that you need `quote_spanned` here at all. If you do, then
let me know, something weird with spans is going on then.

>> > +    };
>> > +
>> > +    let flush =3D |args: &mut TokenStream, current: &mut TokenStream|=
 {
>> > +        let current =3D std::mem::take(current);
>> > +        if !current.is_empty() {
>> > +            args.extend(adapt(current));
>> > +        }
>> > +    };
>> > +
>> > +    let mut args =3D TokenStream::from_iter(first_opt);
>> > +    {
>> > +        let mut current =3D TokenStream::new();
>> > +        for tt in input {
>> > +            match &tt {
>> > +                TokenTree::Punct(p) =3D> match p.as_char() {
>> > +                    ',' =3D> {
>> > +                        flush(&mut args, &mut current);
>> > +                        &mut args
>> > +                    }
>> > +                    '=3D' =3D> {
>> > +                        names.remove(current.to_string().as_str());
>> > +                        args.extend(std::mem::take(&mut current));
>> > +                        &mut args
>> > +                    }
>> > +                    _ =3D> &mut current,
>> > +                },
>> > +                _ =3D> &mut current,
>> > +            }
>> > +            .extend([tt]);
>> > +        }
>>
>> This doesn't handle the following code correctly ):
>>
>>     let mut a =3D 0;
>>     pr_info!("{a:?}", a =3D a =3D a);
>>
>> Looks like we'll have to remember what "kind" of an equals we parsed...
>
> Hmm, good point. Maybe we can just avoid dealing with `=3D` at all until
> we hit the `,` and just split on the leftmost `=3D`. WDYT? I'll have
> that in v11.

Sounds good, if there is no `=3D`, then ignore it.

>> > +/// Like [`core::format_args!`], but automatically wraps arguments in=
 [`kernel::fmt::Adapter`].
>> > +///
>> > +/// This macro allows generating `core::fmt::Arguments` while ensurin=
g that each argument is wrapped
>> > +/// with `::kernel::fmt::Adapter`, which customizes formatting behavi=
or for kernel logging.
>> > +///
>> > +/// Named arguments used in the format string (e.g. `{foo}`) are dete=
cted and resolved from local
>> > +/// bindings. All positional and named arguments are automatically wr=
apped.
>> > +///
>> > +/// This macro is an implementation detail of other kernel logging ma=
cros like [`pr_info!`] and
>> > +/// should not typically be used directly.
>> > +///
>> > +/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
>> > +/// [`pr_info!`]: ../kernel/macro.pr_info.html
>> > +#[proc_macro]
>> > +pub fn fmt(input: TokenStream) -> TokenStream {
>>
>> I'm wondering if we should name this `format_args` instead in order to
>> better communicate that it's a replacement for `core::format_args!`.
>
> Unfortunately that introduces ambiguity in cases where
> kernel::prelude::* is imported because core::format_args is in core's
> prelude.

Ahh that's unfortunate.

---
Cheers,
Benno

