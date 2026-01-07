Return-Path: <linux-kselftest+bounces-48430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9CCFFACC
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39EF9301BCE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00759350295;
	Wed,  7 Jan 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UATx2u1U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09633D4EE
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806604; cv=none; b=iJ/NkReKm/NLiLN66oTdB6PejliMkzsWO8Y2eKh4D7Q1fja1FaF4KeqnFalat3x/v7yjgEMN3wR7cQuKFqjBZL5o0zGNgVDFnAG+5WcTXJVdASdgX0jTx/9uQEfjVmsJ9oWKib3lI++zIa7k51SeUIP9qNp7VDRpQEnVxJXlKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806604; c=relaxed/simple;
	bh=YYQnkwKkEEn5jTW3JSu6zePRbnJJVi0FUbQlVNSTlik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJr0LDMVQ/P+z//BPC/4Vd+PimOp49T/scN4+CDrtWtINzcG2XbqRZzeivMjwkETID2W1KdFSu0Ty5Al0EBBUvPUOZMkFIcuuLSTPHMi3hPgSorvuI42qhv9JFjzkj9m1y9EoN1nDuwliLy22WiEl+8uAhh3nnSxdzZhnOrgeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UATx2u1U; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37fccf7035aso18858451fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767806595; x=1768411395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PoMba0V10FrYfHUADPpJLjMxgOIiUkQHKblhTygy/Q=;
        b=UATx2u1UfnJWScaNrMeeoRP8GT46pZnhVblveg6OzdLeME4izazG9mUmIGY2FZ34dI
         cmGfrTYmG8bd2tpv0Dw4Ea/dMiiO3wwlBbCO734oJpkPh2sPQMuvfyBqDJmHdaGNdkDf
         /O7XOAeOtd6gu/WL3BYeD/9E0xm5DENwVIrG3Pjj5c6o1cz/E6a/YQzwLerrV1yLpYXh
         8bMsFSdiJHsNUDC1m3EtI6vKi1ZL062YV0NumjYY8tmWGH+qGVsbE7JcknO2MhIFK14u
         D3mIgJdB505/bwZgdc5EA0OOGoC+8TH0xHRRmtUBaOWhTQGPu8488hatuw+QXwaP9zYV
         eF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767806595; x=1768411395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PoMba0V10FrYfHUADPpJLjMxgOIiUkQHKblhTygy/Q=;
        b=ZXz6XBDzdDys9hnfYlYdsDd3fcOXr6OUHKndpMIBzCQtw5mslFuADegjFZnBnirJXl
         I9tZgfy5svIhmFLfxJ07Ln8q5RxbpbDGW+gZE6V/DUp82X+3yB3ooF9Y22neNh4ztzHY
         2hfOezc/qA92f7hXoMgq9QfYm4w6XY8SwjR8joNaU9+QXQseZlc8llc0g2FUXPgBYj+K
         2/PEV8v5SQAzQQKZc4qNZ7o1JDzfSD79BMoZU5GHLaUmANkMOhacQZsei13qYdp/y0ID
         FOD9IqFxspV3YaAAvypw29nDJ9y+nrqvqaakPQ4pM38uarHdH5tOt+j5wnb99i+JgryI
         iMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4XjlESsjJo7y3H4PGm7AlXfn5TF2DNtO18naW011bE2J45htVfoD4SXHYAZEg+1Ww0mueKas1kB2kSpxT10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Rlqa2vzBTy6y+9jkvxE7E4J2/NZdyJGT0l4azaEuXavo8d3M
	e3wC2VIZ6Gk1sfI/sc3FXZNNf0ERQb+5wPT0xvi4quP0LtZavXmKmZs2PbX78Tn7vcM9Ujvp9Lr
	MbZqEj4tYMYgbIvL49TRNY6+FleRxuUI=
X-Gm-Gg: AY/fxX79wSmA2H/FyaB4kSCtC+pYY0dvgQgBYvAiG9oH83zyJjiFh681EjD7jwOudOb
	1g3nwW6+yLMY6UEB1r90dvuJ34R26aVYJOtdtBVK5fXonlZ1DU37WYcqMt6qCiOCdHb6bjwsdRF
	XOVTrUhY1dr282ALPIYYq1SbNwIXd6APtBu4GI+/M4MHxfxp/H8eioEeBJcN339QnI0hpSf2wze
	/daa1LwvaFNeGe5Ik79jfzolhFCtLjATUHa6OAuYUJ9+DQVVUi0DCAOiKkHusIj2en2SRy+IF+E
	6WX3oOAf330lcFuB3oapYuJgcGcDYjcWyrApm+FCDxlRBFRMYDW/eYBDRjhV8KPSEODjIs7CkUH
	6yPwGOrogafgpnhBZ
X-Google-Smtp-Source: AGHT+IF7A2NmesxqONfw5GTgY8fStk56DqmGXrlZoaXN7TRDHPTuEY9m8uYucWuEn7U1frgJLkuK0vKNgcZ+IQdkw1Q=
X-Received: by 2002:a2e:bc88:0:b0:37b:af2d:13a3 with SMTP id
 38308e7fff4ca-382ff677518mr10636361fa.7.1767806594469; Wed, 07 Jan 2026
 09:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107161729.3855851-1-gary@kernel.org> <20260107161729.3855851-9-gary@kernel.org>
In-Reply-To: <20260107161729.3855851-9-gary@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 7 Jan 2026 12:22:37 -0500
X-Gm-Features: AQt7F2r_f6-4NK-Ei_46ub_Gcggt4iCH0IaHgRaPo4FcNrHxVizuOuqonnEXR40
Message-ID: <CAJ-ks9np_tHMiXqjiRKtSG=qvAtP=Ayy-MA9AFKfjqzg26YUnA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] rust: macros: convert `#[kunit_tests]` macro to
 use `syn`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	rust-for-linux@vger.kernel.org, Igor Korotin <igor.korotin.linux@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:31=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Make use of `syn` to parse the module structurally and thus improve the
> robustness of parsing.
>
> String interpolation is avoided by generating tokens directly using
> `quote!`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>


> ---
>  rust/macros/kunit.rs | 274 +++++++++++++++++++------------------------
>  rust/macros/lib.rs   |   6 +-
>  2 files changed, 123 insertions(+), 157 deletions(-)
>
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index 5cd6aa5eef07d..afbc708cbdc50 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -4,81 +4,50 @@
>  //!
>  //! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.co=
m>
>
> -use std::collections::HashMap;
> -use std::fmt::Write;
> -
> -use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
> -
> -pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenSt=
ream {
> -    let attr =3D attr.to_string();
> -
> -    if attr.is_empty() {
> -        panic!("Missing test name in `#[kunit_tests(test_name)]` macro")
> -    }
> -
> -    if attr.len() > 255 {
> -        panic!("The test suite name `{attr}` exceeds the maximum length =
of 255 bytes")
> +use std::ffi::CString;
> +
> +use proc_macro2::TokenStream;
> +use quote::{
> +    format_ident,
> +    quote,
> +    ToTokens, //
> +};
> +use syn::{
> +    parse_quote,
> +    Error,
> +    Ident,
> +    Item,
> +    ItemMod,
> +    LitCStr,
> +    Result, //
> +};
> +
> +pub(crate) fn kunit_tests(test_suite: Ident, mut module: ItemMod) -> Res=
ult<TokenStream> {
> +    if test_suite.to_string().len() > 255 {
> +        return Err(Error::new_spanned(
> +            test_suite,
> +            "test suite names cannot exceed the maximum length of 255 by=
tes",
> +        ));
>      }
>
> -    let mut tokens: Vec<_> =3D ts.into_iter().collect();
> -
> -    // Scan for the `mod` keyword.
> -    tokens
> -        .iter()
> -        .find_map(|token| match token {
> -            TokenTree::Ident(ident) =3D> match ident.to_string().as_str(=
) {
> -                "mod" =3D> Some(true),
> -                _ =3D> None,
> -            },
> -            _ =3D> None,
> -        })
> -        .expect("`#[kunit_tests(test_name)]` attribute should only be ap=
plied to modules");
> -
> -    // Retrieve the main body. The main body should be the last token tr=
ee.
> -    let body =3D match tokens.pop() {
> -        Some(TokenTree::Group(group)) if group.delimiter() =3D=3D Delimi=
ter::Brace =3D> group,
> -        _ =3D> panic!("Cannot locate main body of module"),
> +    // We cannot handle modules that defer to another file (e.g. `mod fo=
o;`).
> +    let Some((module_brace, module_items)) =3D module.content.take() els=
e {
> +        Err(Error::new_spanned(
> +            module,
> +            "`#[kunit_tests(test_name)]` attribute should only be applie=
d to inline modules",
> +        ))?
>      };
>
> -    // Get the functions set as tests. Search for `[test]` -> `fn`.
> -    let mut body_it =3D body.stream().into_iter();
> -    let mut tests =3D Vec::new();
> -    let mut attributes: HashMap<String, TokenStream> =3D HashMap::new();
> -    while let Some(token) =3D body_it.next() {
> -        match token {
> -            TokenTree::Punct(ref p) if p.as_char() =3D=3D '#' =3D> match=
 body_it.next() {
> -                Some(TokenTree::Group(g)) if g.delimiter() =3D=3D Delimi=
ter::Bracket =3D> {
> -                    if let Some(TokenTree::Ident(name)) =3D g.stream().i=
nto_iter().next() {
> -                        // Collect attributes because we need to find wh=
ich are tests. We also
> -                        // need to copy `cfg` attributes so tests can be=
 conditionally enabled.
> -                        attributes
> -                            .entry(name.to_string())
> -                            .or_default()
> -                            .extend([token, TokenTree::Group(g)]);
> -                    }
> -                    continue;
> -                }
> -                _ =3D> (),
> -            },
> -            TokenTree::Ident(i) if i =3D=3D "fn" && attributes.contains_=
key("test") =3D> {
> -                if let Some(TokenTree::Ident(test_name)) =3D body_it.nex=
t() {
> -                    tests.push((test_name, attributes.remove("cfg").unwr=
ap_or_default()))
> -                }
> -            }
> -
> -            _ =3D> (),
> -        }
> -        attributes.clear();
> -    }
> +    // Make the entire module gated behind `CONFIG_KUNIT`.
> +    module
> +        .attrs
> +        .insert(0, parse_quote!(#[cfg(CONFIG_KUNIT=3D"y")]));
>
> -    // Add `#[cfg(CONFIG_KUNIT=3D"y")]` before the module declaration.
> -    let config_kunit =3D "#[cfg(CONFIG_KUNIT=3D\"y\")]".to_owned().parse=
().unwrap();
> -    tokens.insert(
> -        0,
> -        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
> -    );
> +    let mut processed_items =3D Vec::new();
> +    let mut test_cases =3D Vec::new();
>
>      // Generate the test KUnit test suite and a test case for each `#[te=
st]`.
> +    //
>      // The code generated for the following test module:
>      //
>      // ```
> @@ -110,98 +79,93 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Tok=
enStream) -> TokenStream {
>      //
>      // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CAS=
ES);
>      // ```
> -    let mut kunit_macros =3D "".to_owned();
> -    let mut test_cases =3D "".to_owned();
> -    let mut assert_macros =3D "".to_owned();
> -    let path =3D crate::helpers::file();
> -    let num_tests =3D tests.len();
> -    for (test, cfg_attr) in tests {
> -        let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{test}=
");
> -        // Append any `cfg` attributes the user might have written on th=
eir tests so we don't
> -        // attempt to call them when they are `cfg`'d out. An extra `use=
` is used here to reduce
> -        // the length of the assert message.
> -        let kunit_wrapper =3D format!(
> -            r#"unsafe extern "C" fn {kunit_wrapper_fn_name}(_test: *mut =
::kernel::bindings::kunit)
> -            {{
> -                (*_test).status =3D ::kernel::bindings::kunit_status_KUN=
IT_SKIPPED;
> -                {cfg_attr} {{
> -                    (*_test).status =3D ::kernel::bindings::kunit_status=
_KUNIT_SUCCESS;
> -                    use ::kernel::kunit::is_test_result_ok;
> -                    assert!(is_test_result_ok({test}()));
> +    //
> +    // Non-function items (e.g. imports) are preserved.
> +    for item in module_items {
> +        let Item::Fn(mut f) =3D item else {
> +            processed_items.push(item);
> +            continue;
> +        };
> +
> +        // TODO: Replace below with `extract_if` when MSRV is bumped abo=
ve 1.85.
> +        let before_len =3D f.attrs.len();
> +        f.attrs.retain(|attr| !attr.path().is_ident("test"));
> +        if f.attrs.len() =3D=3D before_len {
> +            processed_items.push(Item::Fn(f));
> +            continue;
> +        }
> +
> +        let test =3D f.sig.ident.clone();
> +
> +        // Retrieve `#[cfg]` applied on the function which needs to be p=
resent on derived items too.
> +        let cfg_attrs: Vec<_> =3D f
> +            .attrs
> +            .iter()
> +            .filter(|attr| attr.path().is_ident("cfg"))
> +            .cloned()
> +            .collect();
> +
> +        // Before the test, override usual `assert!` and `assert_eq!` ma=
cros with ones that call
> +        // KUnit instead.
> +        let test_str =3D test.to_string();
> +        let path =3D crate::helpers::file();
> +        processed_items.push(parse_quote! {
> +            #[allow(unused)]
> +            macro_rules! assert {
> +                ($cond:expr $(,)?) =3D> {{
> +                    kernel::kunit_assert!(#test_str, #path, 0, $cond);
> +                }}
> +            }
> +        });
> +        processed_items.push(parse_quote! {
> +            #[allow(unused)]
> +            macro_rules! assert_eq {
> +                ($left:expr, $right:expr $(,)?) =3D> {{
> +                    kernel::kunit_assert_eq!(#test_str, #path, 0, $left,=
 $right);
>                  }}
> -            }}"#,
> +            }
> +        });
> +
> +        // Add back the test item.
> +        processed_items.push(Item::Fn(f));
> +
> +        let kunit_wrapper_fn_name =3D format_ident!("kunit_rust_wrapper_=
{test}");
> +        let test_cstr =3D LitCStr::new(
> +            &CString::new(test_str.as_str()).expect("identifier cannot c=
ontain NUL"),
> +            test.span(),
>          );
> -        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> -        writeln!(
> -            test_cases,
> -            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"=
), {kunit_wrapper_fn_name}),"
> -        )
> -        .unwrap();
> -        writeln!(
> -            assert_macros,
> -            r#"
> -/// Overrides the usual [`assert!`] macro with one that calls KUnit inst=
ead.
> -#[allow(unused)]
> -macro_rules! assert {{
> -    ($cond:expr $(,)?) =3D> {{{{
> -        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
> -    }}}}
> -}}
> -
> -/// Overrides the usual [`assert_eq!`] macro with one that calls KUnit i=
nstead.
> -#[allow(unused)]
> -macro_rules! assert_eq {{
> -    ($left:expr, $right:expr $(,)?) =3D> {{{{
> -        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
> -    }}}}
> -}}
> -        "#
> -        )
> -        .unwrap();
> -    }
> +        processed_items.push(parse_quote! {
> +            unsafe extern "C" fn #kunit_wrapper_fn_name(_test: *mut ::ke=
rnel::bindings::kunit) {
> +                (*_test).status =3D ::kernel::bindings::kunit_status_KUN=
IT_SKIPPED;
>
> -    writeln!(kunit_macros).unwrap();
> -    writeln!(
> -        kunit_macros,
> -        "static mut TEST_CASES: [::kernel::bindings::kunit_case; {}] =3D=
 [\n{test_cases}    ::kernel::kunit::kunit_case_null(),\n];",
> -        num_tests + 1
> -    )
> -    .unwrap();
> -
> -    writeln!(
> -        kunit_macros,
> -        "::kernel::kunit_unsafe_test_suite!({attr}, TEST_CASES);"
> -    )
> -    .unwrap();
> -
> -    // Remove the `#[test]` macros.
> -    // We do this at a token level, in order to preserve span informatio=
n.
> -    let mut new_body =3D vec![];
> -    let mut body_it =3D body.stream().into_iter();
> -
> -    while let Some(token) =3D body_it.next() {
> -        match token {
> -            TokenTree::Punct(ref c) if c.as_char() =3D=3D '#' =3D> match=
 body_it.next() {
> -                Some(TokenTree::Group(group)) if group.to_string() =3D=
=3D "[test]" =3D> (),
> -                Some(next) =3D> {
> -                    new_body.extend([token, next]);
> -                }
> -                _ =3D> {
> -                    new_body.push(token);
> +                // Append any `cfg` attributes the user might have writt=
en on their tests so we
> +                // don't attempt to call them when they are `cfg`'d out.=
 An extra `use` is used
> +                // here to reduce the length of the assert message.
> +                #(#cfg_attrs)*
> +                {
> +                    (*_test).status =3D ::kernel::bindings::kunit_status=
_KUNIT_SUCCESS;
> +                    use ::kernel::kunit::is_test_result_ok;
> +                    assert!(is_test_result_ok(#test()));
>                  }
> -            },
> -            _ =3D> {
> -                new_body.push(token);
>              }
> -        }
> -    }
> +        });
>
> -    let mut final_body =3D TokenStream::new();
> -    final_body.extend::<TokenStream>(assert_macros.parse().unwrap());
> -    final_body.extend(new_body);
> -    final_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
> -
> -    tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, final_body=
)));
> +        test_cases.push(quote!(
> +            ::kernel::kunit::kunit_case(#test_cstr, #kunit_wrapper_fn_na=
me)
> +        ));
> +    }
>
> -    tokens.into_iter().collect()
> +    let num_tests_plus_1 =3D test_cases.len() + 1;
> +    processed_items.push(parse_quote! {
> +        static mut TEST_CASES: [::kernel::bindings::kunit_case; #num_tes=
ts_plus_1] =3D [
> +            #(#test_cases,)*
> +            ::kernel::kunit::kunit_case_null(),
> +        ];
> +    });
> +    processed_items.push(parse_quote! {
> +        ::kernel::kunit_unsafe_test_suite!(#test_suite, TEST_CASES);
> +    });
> +
> +    module.content =3D Some((module_brace, processed_items));
> +    Ok(module.to_token_stream())
>  }
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 12467bfc703a8..75ac60abe6ffa 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -481,6 +481,8 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  /// }
>  /// ```
>  #[proc_macro_attribute]
> -pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> -    kunit::kunit_tests(attr.into(), ts.into()).into()
> +pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream=
 {
> +    kunit::kunit_tests(parse_macro_input!(attr), parse_macro_input!(inpu=
t))
> +        .unwrap_or_else(|e| e.into_compile_error())
> +        .into()
>  }
> --
> 2.51.2
>

