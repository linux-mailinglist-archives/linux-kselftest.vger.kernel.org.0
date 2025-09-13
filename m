Return-Path: <linux-kselftest+bounces-41437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD495B55E36
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 06:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E317C1C24218
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC001DE3AC;
	Sat, 13 Sep 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKgq0z3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F2013AD05
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Sep 2025 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757736793; cv=none; b=uME6BrZshdDTEMb9e2M/d8l4+sIuZWOvrRZI7IXLJw99akhW+S5fjeed5UC59Cos7UH8kSNFytf9dtc4vArsGBxNpcawXY7saOfNd6rYX7gIBAeHsl1ryojt18JVwSq1/lxxdjPYA/GojnjScnIYzz0kn10M0b8nDjg0NlTGRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757736793; c=relaxed/simple;
	bh=6Wv2HIN7vUW7BDwatkGfyIrEwGjkldeub3pyvlc0eVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZRTgfgR2A+LcYYwhkuhznJldD06ISV/6z6TxdzFEMHrHURQUrm0hB7vKwbH4MwpYhyhQGiQ/j3teqBNJeWzz1fAJvkHLCSrTe0jqnTU0ehDlVLWHRm5M5azxqW0dBXWWt6alDXMbGsdxBzgN36Gx2bCBqVb+YACuKE1+VrXIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKgq0z3i; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-76ce24d1dcaso9314676d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 21:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757736790; x=1758341590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WaF7o0RRlJLnLEo33jbMbEqykYIDx6ByziHakyovt0=;
        b=VKgq0z3iwwXWN7J+o3FLnj01ipIwk7ZZQa2ydqGiL6eWMNE1j5LiYqhtUsS0i3u5Aa
         VEi9K8dk0kpeso5Fd0tfJ3VqOHG3K94yiqybc4/OpMlymyi7kySg45Lqb1tV4CDPW67i
         6HTrfmm8vti+xjdZIrHWkCfAdZeUyBHB+x+oUnJPN9EcC8h9Ncg9givLBx0gokriOg1L
         HoKaQuWS6a75MKB4lQnIpUcwcmgbURHOpl5Kf0YJQNE4X9gDPji2M0Pjgfo40NZaWlN/
         Jouv2Om5eywaR7+xOc1k0YwXU165RHHEiKeEyzklKj32Y/sGbZEDH1J01yjIgov/tN8v
         7Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757736790; x=1758341590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WaF7o0RRlJLnLEo33jbMbEqykYIDx6ByziHakyovt0=;
        b=EHO+8HKdp9R+oinUwCaSawYi5Bj6A4frb1WD5Y96AVpL9jnWBtDvrNCauHm5PjbViH
         bUzCd4jpZlmtKeQ54qGNNZr67H1ctP6Qj5EkkxsQpGxNohPB7DIKYZ3rBFmdN6YGbrYn
         mvCLg0F/IKLl+MpaD6cQQTx7U8WVykGyVb7QH+EimRqMuEQhKuJL74aye0a5OmgZKnQs
         gN66oqAGPPsBh/9x6ZZ1wRTqc8BR4jBUW7XBbqaouwyNN7TMMxA/rVjwpdhMwhM5vATs
         td2D4qf7QnVuPxab5WX4ogid0n4zyPO3uXs5lLLnHz2VFxmMyWo+zUpzpkIUBgapYC/f
         29Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWdy4bwu1DEjX2HTIv5kZtE0Pbz4qg7ZepobHhTYAhlIXwPgRBW04ecMrYqmREiOgrGDVx6ML2+UcoizwsIwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEW3zS3RTdjQplaHVKufQJ3sxwPEr2oa1nmZeWuqMUzsuvbYc
	wikyQKSOc4JgEvou8c24vP12h09IDHmxNxgRbTANmFz3LyvqEnz/NEBcLDECVTDnPpStAKyoH/L
	MWmmrifDACmd1r0nyljG1KR3QbnA9K9zHJD3B0oL3
X-Gm-Gg: ASbGnct1rGd+vGUznxE+6HaI3KJgCDHPohowcd4BtaQUNAALcEGY/RVYymNjh2QhxHg
	SOVLO+APZ7yafPpoCNytJ+8wBG8ea4PDSxgmczfgvxTac6jtKAmFrSgS2wqBUk+L0vnf5rmHttk
	T7POjXpaexFcIkw+mo0gs+nAiFuFfYxGLr8rxYMVcDytwQ9P/xrWdzJUZ2EtfdC5W89weqeCCdA
	IYDRtN+DRE7
X-Google-Smtp-Source: AGHT+IHKc+BIL8HoXt+AUZpO+zz3DYyjJLhkC0RgZhsdwqSW3JBqhrTUk4DXveLp59CE951IsU1IKqchh0/sEkjjWYQ=
X-Received: by 2002:ad4:4f05:0:b0:768:24e:734b with SMTP id
 6a1803df08f44-768027c3b96mr58195596d6.45.1757736790152; Fri, 12 Sep 2025
 21:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907201558.104566-2-ent3rm4n@gmail.com>
In-Reply-To: <20250907201558.104566-2-ent3rm4n@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 13 Sep 2025 12:12:58 +0800
X-Gm-Features: AS18NWA_OPADCOyEQRHmaGqDz6q8iqh-FKjck1YFOyZcNegh2IRpto0VgcRD95E
Message-ID: <CABVgOSnYnSz8cyZBk6U-bLrG23naqFBjAS-xVYe5OBFosASMxQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kunit: allow `cfg` on `test`s
To: Kaibo Ma <ent3rm4n@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 04:17, Kaibo Ma <ent3rm4n@gmail.com> wrote:
>
> The `kunit_test` proc macro only checks for the `test` attribute
> immediately preceding a `fn`. If the function is disabled via a `cfg`,
> the generated code would result in a compile error referencing a
> non-existent function [1].
>
> This collects attributes and specifically cherry-picks `cfg` attributes
> to be duplicated inside KUnit wrapper functions such that a test function
> disabled via `cfg` compiles and is ignored correctly.
>
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3D=3D48=3D69hYiDo132=
1pCzgn_n1_jg=3Dez5UYXX91c+g5JVQ@mail.gmail.com/ [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1185
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
> ---

Thanks very much: I think this is a great improvement over not having
'cfg' work at all.

I do think, though, that we need to handle disabled tests differently,
as it causes two issues:
1. Currently, disabled tests are still included in the suite which
contains them, and always pass. It'd be nice if they either were
missing from the suite, or were marked 'skipped' by default.
2. It's not possible to have several implementations of the same test
(or, depending on how you look at it, several tests with the same
name) with different #[cfg] attributes, even if all but one are
disabled.

My ideal solution to both of these issues would be to only include
tests (i.e., the wrapper function and the kunit_case struct) if
they're enabled. That's possibly more difficult than it looks, though:
my initial attempt at implementing this ran aground trying to
calculate num_tests.

Even if that's not feasible, we should at least make disabled tests be
marked 'skipped'. A quick way of doing this would be to mark the test
as skipped in the wrapper function:
(*_test).status =3D ::kernel::bindings::kunit_status_KUNIT_SKIPPED;
And then re-mark it as success (KUnit tests expect the initial state
to be success) within the {cfg_attr} block:
(*_test).status =3D ::kernel::bindings::kunit_status_KUNIT_SUCCESS;

That doesn't solve issue #2, but I suspect that's rare enough that we
can leave it until someone actually has a good reason to have two test
implementations.

Otherwise, this seems fine to me.

Thanks,
-- David

>  rust/kernel/kunit.rs |  7 +++++++
>  rust/macros/kunit.rs | 46 ++++++++++++++++++++++++++++++++------------
>  2 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 41efd8759..32640dfc9 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -357,4 +357,11 @@ fn rust_test_kunit_example_test() {
>      fn rust_test_kunit_in_kunit_test() {
>          assert!(in_kunit_test());
>      }
> +
> +    #[test]
> +    #[cfg(not(all()))]
> +    fn rust_test_kunit_always_disabled_test() {
> +        // This test should never run because of the `cfg`.
> +        assert!(false);
> +    }
>  }
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index 81d18149a..850a321e5 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -5,6 +5,7 @@
>  //! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.co=
m>
>
>  use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
> +use std::collections::HashMap;
>  use std::fmt::Write;
>
>  pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenSt=
ream {
> @@ -41,20 +42,32 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Toke=
nStream) -> TokenStream {
>      // Get the functions set as tests. Search for `[test]` -> `fn`.
>      let mut body_it =3D body.stream().into_iter();
>      let mut tests =3D Vec::new();
> +    let mut attributes: HashMap<String, TokenStream> =3D HashMap::new();
>      while let Some(token) =3D body_it.next() {
>          match token {
> -            TokenTree::Group(ident) if ident.to_string() =3D=3D "[test]"=
 =3D> match body_it.next() {
> -                Some(TokenTree::Ident(ident)) if ident.to_string() =3D=
=3D "fn" =3D> {
> -                    let test_name =3D match body_it.next() {
> -                        Some(TokenTree::Ident(ident)) =3D> ident.to_stri=
ng(),
> -                        _ =3D> continue,
> -                    };
> -                    tests.push(test_name);
> +            TokenTree::Punct(ref p) if p.as_char() =3D=3D '#' =3D> match=
 body_it.next() {
> +                Some(TokenTree::Group(g)) if g.delimiter() =3D=3D Delimi=
ter::Bracket =3D> {
> +                    if let Some(TokenTree::Ident(name)) =3D g.stream().i=
nto_iter().next() {
> +                        // Collect attributes because we need to find wh=
ich are tests. We also
> +                        // need to copy `cfg` attributes so tests can be=
 conditionally enabled.
> +                        attributes
> +                            .entry(name.to_string())
> +                            .or_default()
> +                            .extend([token, TokenTree::Group(g)]);
> +                    }
> +                    continue;
>                  }
> -                _ =3D> continue,
> +                _ =3D> (),
>              },
> +            TokenTree::Ident(i) if i.to_string() =3D=3D "fn" && attribut=
es.contains_key("test") =3D> {
> +                if let Some(TokenTree::Ident(test_name)) =3D body_it.nex=
t() {
> +                    tests.push((test_name, attributes.remove("cfg").unwr=
ap_or_default()))
> +                }
> +            }
> +
>              _ =3D> (),
>          }
> +        attributes.clear();
>      }
>
>      // Add `#[cfg(CONFIG_KUNIT=3D"y")]` before the module declaration.
> @@ -100,11 +113,20 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: To=
kenStream) -> TokenStream {
>      let mut test_cases =3D "".to_owned();
>      let mut assert_macros =3D "".to_owned();
>      let path =3D crate::helpers::file();
> -    for test in &tests {
> +    let num_tests =3D tests.len();
> +    for (test, cfg_attr) in tests {
>          let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{test}=
");
> -        // An extra `use` is used here to reduce the length of the messa=
ge.
> +        // Append any `cfg` attributes the user might have written on th=
eir tests so we don't
> +        // attempt to call them when they are `cfg`'d out. An extra `use=
` is used here to reduce
> +        // the length of the assert message.
>          let kunit_wrapper =3D format!(
> -            "unsafe extern \"C\" fn {kunit_wrapper_fn_name}(_test: *mut =
::kernel::bindings::kunit) {{ use ::kernel::kunit::is_test_result_ok; asser=
t!(is_test_result_ok({test}())); }}",
> +            r#"unsafe extern "C" fn {kunit_wrapper_fn_name}(_test: *mut =
::kernel::bindings::kunit)
> +            {{
> +                {cfg_attr} {{
> +                    use ::kernel::kunit::is_test_result_ok;
> +                    assert!(is_test_result_ok({test}()));
> +                }}
> +            }}"#,
>          );
>          writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
>          writeln!(
> @@ -139,7 +161,7 @@ macro_rules! assert_eq {{
>      writeln!(
>          kunit_macros,
>          "static mut TEST_CASES: [::kernel::bindings::kunit_case; {}] =3D=
 [\n{test_cases}    ::kernel::kunit::kunit_case_null(),\n];",
> -        tests.len() + 1
> +        num_tests + 1
>      )
>      .unwrap();
>
> --
> 2.50.1
>

