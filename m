Return-Path: <linux-kselftest+bounces-49330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7122D39F6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05479303D6A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B192DB780;
	Mon, 19 Jan 2026 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7xfl25C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5B2D9EC8
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806617; cv=pass; b=jmZROed0JMQXasTX/Bc6XaM44xWnngpCH04TrUPkex64Mi8yX2kLBwEeWsnnVtbg9FBJx44xzoJarYCkY59xMU4m8OpiAolvCByvM1ksEIQBJIP8PEhTR4vmMMz6bRzF3/RltTI29EPnin2L+KQpJYOg8hxYOUFBTNfnWzxl6vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806617; c=relaxed/simple;
	bh=/YmGnO7rf/Na+WcpsioZ/yrjoIT2bpaNws0lmMq4ezI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sb3TipsYC+vOX9Ppqi4UgtUgHte7LKHRYYX2vbLIzJM0gP01oosNuDnYr8OeyRNOWE8+WG7lPioE8EpuNnfVO+AAKLp2leI6dV6m2Kh8gOQ/8TWwoye5mxzBE+9qnRWzlc6R2hwIas93BP+bWU2ZUHozgJc3JzlMAQP9tz6fw5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7xfl25C; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so44976055e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 23:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768806613; cv=none;
        d=google.com; s=arc-20240605;
        b=RyZl5XINImQ/L5qpMS146YeAD9p/oGrb/VxIOSjCzFsdd34LjQKzgbThE5/Ap/RUtY
         Gdz+hUysPMiKFrKPUowrhRtbAnM/ruJ54Y8GdPa8A0M7ZeoaBn+cjgt+UvbRXqwbSQ8j
         SjOZidgHaJPR2L8OfOEnWT2IfPsVVvkD8G/sebnoxJvHnMTfZfAJvaWyzX84YtJg7j3e
         aKC2jgS1+OAe7LskDdpkQVc4e/dTExxJYWou34APgLjvGzXQmFdGT/GivizvVnKUOlNh
         tjZ02p7n11Hmeofiuz0dj1BbQcTEslGpLbPaDVGEg99ZRM1cGp/w6DDguMii0vwG4mBG
         fy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4XUBLJ/8dkfq4Jyx5tGudy5UZdqF3pY1KAGq4m7Eoqc=;
        fh=qT10MwoeMCvRDLLe/3Omgvq9Pn9s6JsgWpI2pYeGKnU=;
        b=BD7jiQMRS+TiXB5pqHe12Os4ywvEz7LZIQ5AMX78TO3ZPsfkscQMU6ybyd7Tp67pl4
         6Lb2ryzFvqr8AHHG6w4FPNIZJvAoWvXofmcxatLcB43Hz3P4pwhqInHWAELsd3tyK8E5
         zusxjzpXgVOLRk7SCU/Ohs1ii0OB9aHcD3vSybxj4Nm6cw+WOniY69iM7BVXokD6TLDn
         IK5N90fk3JfllK7S4+RMOzx4ogfyR+KT7TOhXOAkImwXf5HMAnsVCcpN2bqU4KCILbKX
         P+zzKdKeNMp1DHDxIAygCpDV4Ub+SrEHqw+a5L5MiF9/RH3opMBp8/7RN4fAhPllvGBk
         XQ7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768806613; x=1769411413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4XUBLJ/8dkfq4Jyx5tGudy5UZdqF3pY1KAGq4m7Eoqc=;
        b=V7xfl25Cg42dLNBqod9h1UuhnTpccqvFeolNhNtkOcpG5iuu5hdfe7H9cgCjJqSe8G
         C2QaZZ97AYBrXA9o05wyZ4jXFYuHCTAZ7acXx7aSZBThHednfXKuZJtcJKCOmPL02Wgj
         h57jC9alq2k9GphR0Y4vI4pk/OGnh/KfAyUZWxhxAClEsTd8xSsGTg72F3ssyTQBZrVo
         7GrBkCSTy5hFwVZmXe5ZHE833vGrTkpmc94D4IapicTVnaxryCQlzQRTz7MX78H18mKR
         U6VsHXTpu0j36SgHWKTPaX78dHyAIOTKizV1tN6VYG7zsD/f98S3Cy/qKwHp5PcXAwaM
         Q88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806613; x=1769411413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XUBLJ/8dkfq4Jyx5tGudy5UZdqF3pY1KAGq4m7Eoqc=;
        b=hIz5QRCHvfivMLs2wOG6qSFr9zCyAekIDaaySHuFOLwx8hSW+hsUdcGE8jrykA0Pa3
         snNGoJSDA1tydWDRdO2EwLieFyINuWUaObYElMivtdIHBLiSSAku5nn9XhKo4nmRGeNg
         oYtJ7u5uxMFdeIpyOaYFcB13oEKqBN4WFnwYBIBG1n2AQb6wLxJofVHgrDQTzH3gC2Vu
         kLhMlkyDP75RdRah7ARF+ST5IyZzgJACpGp40y0YKk5V/G2MT4wj7R53/PLgPx02qT1Q
         AUcvnQGCpS4rM/7lK7Yz1B1W0HYI5FPvENFNZOll67d02Igm17ZpAw0hQ20ykYWrPG5y
         taBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCIbqBlcTtZ2fd8QMMbVK1Rq+LVEgxi9WKPffcfnM0+Ug/JS1Ovzl15sAhvEIUW3AQydueqhll4YAQC4QFCxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ODj7svJUQoFcIP2cZjDy3w9hM5ZqZ8fXMSCT2tzdY1Lt7kMN
	6bhl6iZo9YsnhVV6wO5suMfoQMxpNbRHEvnxQOBxik0yL7XkFRxUnZ2pkokeUVK5MhOYThMMECX
	hGbNAUXGbckgv3/ntYbCIXzpNpbmRCXOemluQXVnB
X-Gm-Gg: AY/fxX4CHfjUJAIlcxY+GjqOShT0GkiBY7j501K7JZYOAf/JSawY/U+O1K1BKmGBj8O
	gCxUuzFbseXtpKq63wHT3B1pcAg/EMdhXJ/caw9QuK29TLi3PZJSN3I/63h8+MF3TKpqDIj6RP5
	qyacWRPGIQexaFDynMvz4vbL22fyfv8D6/FAwyUWM6ioefmziXfeadSDP8DCNwM1O8I38mRArKj
	7xt1QH9+pkR55s9oRetSS9ptoSWrx8TOLW/MYycoWAl1mxk9L+XZF+EHFhlaL1qBFANRw==
X-Received: by 2002:a05:6000:250c:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-43569bbb0c4mr13052366f8f.33.1768806613048; Sun, 18 Jan 2026
 23:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112170919.1888584-1-gary@kernel.org> <20260112170919.1888584-9-gary@kernel.org>
In-Reply-To: <20260112170919.1888584-9-gary@kernel.org>
From: David Gow <davidgow@google.com>
Date: Mon, 19 Jan 2026 15:10:01 +0800
X-Gm-Features: AZwV_QgWLaAQn2xn1c-eq25u-hYUJQ_jCFHm8UeefZZMfqiCIWTXh1QxlO15W-A
Message-ID: <CABVgOSk3WcSPOQp4fKqgzdFKC_Eh9ENOtie7HLzExmQa+yYvcw@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] rust: macros: convert `#[kunit_tests]` macro to
 use `syn`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Tamir Duberstein <tamird@gmail.com>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	rust-for-linux@vger.kernel.org, 
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e46a660648b861b4"

--000000000000e46a660648b861b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jan 2026 at 01:11, Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> Make use of `syn` to parse the module structurally and thus improve the
> robustness of parsing.
>
> String interpolation is avoided by generating tokens directly using
> `quote!`.
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Sorry this took so long to review: it's taken a while for me to wrap
my head around `syn`.

I'm pretty happy with this overall, though, and think I understand it
well enough now.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

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

I'm assuming it's okay for us to get rid of this as we get an
"unexpected end of input" error instead.


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

--000000000000e46a660648b861b4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgLlZeuyiHFr+ElD2m/Hy/g/yxRNzU
f0fDOePSJb3ybf4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTE5MDcxMDEzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAU+bHWxlCA5C7Hv9QK0fNbb9cYhjr6Ev33TZTho6Lb6HnjrGniHBF74jZ7WAmhHIU
V/kHdW3145TcSWzgB0Rmq+1Yd0UEzU1tOyS7HLQFZt4UtZvPjZSwNXHsUHqGMBPFvYoSPWHHxcKl
w8HRaMb2RxtmS3dBrVfoEvdSQmLR0O3//TPufj2mMkqGUamOrEnGDUnJ/WHSXlfSu/LEG2p/V2Hh
XLNhxeuwwTvLCu5whUqefEkd80/AA91hkg7sx5NJidXCtRA8nmLNV2WCxoZ8dSGAgPbnh56oX1/d
cZOrZV8CHdZSDeuiN1+wxg1ksF7Haw6Gu2Oyk24/JhErK/ld9Q==
--000000000000e46a660648b861b4--

