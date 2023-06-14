Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8F73093A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjFNUiS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFNUiS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 16:38:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383B2686
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:38:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce829aca1bso1245606276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686775095; x=1689367095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjFmDqpqLW0HcC1b58cnyObSPX9FvJpnYK2XTM45p+o=;
        b=0RWKAmlv+IbBEDMKDjow617VR1dRtJbYpih6AW+P1LtLyQQ4QU06PoKn502VwJwwTb
         ziVKWVe4Mb2SKITJETJxGl8kCLuPfnB72w6UxKQOqTIutMpOkNZ9V4vLGmIbM16zNS1P
         20s1STkQZKZW17lw8067ZXq5fLtqbropC26rtFKw2fCpAdvuwjEIlF6fXHDr8MFg8tcs
         MYdKY6ohadhA95boezqxsY2dylYQDpF7ygzkuwwp2PK/izXs0mTN0ILfbcE8LWL6qq2o
         009oWBH4Iv8mdIr6XfdN0r3t2LPnmpOmsB97KeUuA1p8Zzk83d4ZVfqKYt5iA0wUXEq3
         Hv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686775095; x=1689367095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjFmDqpqLW0HcC1b58cnyObSPX9FvJpnYK2XTM45p+o=;
        b=NTjVSVsQpvGfBgimyXRdUGJQHnYYH9mkPoi9a9ROS7ugwPmvQqXhEMfSNa93F15IB8
         QXh34o7siuNdu39hVeZwv6THtSDCRP/JVml36ICUvwoT86Hzugv8U0Joiu7ZjnJ8vKI4
         BG2Di3aqAymg4yVFrdr4/EEkZ9Frk45yhjaOWOuH1vQtMarUYf+COp4v4zcRef1AbU9b
         7AcCXODtewKuqoD1fnlpkQjtSIyKKA5DqhDj3MkepGCKwNDEW/PlnHtpQ8ndJoNpAQ0j
         WzvoxTJAKHUluvWKCaA/t1Dp0D+DSrt6KHpUTPFY+g0dRnqbTCW/AIU7ig+VUuo9ena2
         jmrw==
X-Gm-Message-State: AC+VfDzKiR60Zf8uu0Z71/cljvvuSWLexqtVYfBISB0Dv64PeVVRJW/h
        M+YVcJDz/Id/9Rewnu60DvfHNBwS2LKcKTU=
X-Google-Smtp-Source: ACHHUZ6e2VRWpSJEw4jxsGLTnXcsj60gdEG1Ser3v50dEAGXD9HlO5Vf7W2I9/DNQHGLQ4fIr5+ck36a2uItX1s=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:ab2e:0:b0:bc9:98aa:b0ec with SMTP id
 u43-20020a25ab2e000000b00bc998aab0ecmr483591ybi.1.1686775095575; Wed, 14 Jun
 2023 13:38:15 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:38:03 +0000
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-6-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203803.2910957-1-aliceryhl@google.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
From:   Alice Ryhl <aliceryhl@google.com>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brendan.higgins@linux.dev,
        davidgow@google.com, gary@garyguo.net, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        nmi@metaspace.dk, patches@lists.linux.dev, philip.li@intel.com,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:
> Rust has documentation tests: these are typically examples of
> usage of any item (e.g. function, struct, module...).
> 
> They are very convenient because they are just written
> alongside the documentation. For instance:
> 
>     /// Sums two numbers.
>     ///
>     /// ```
>     /// assert_eq!(mymod::f(10, 20), 30);
>     /// ```
>     pub fn f(a: i32, b: i32) -> i32 {
>         a + b
>     }
> 
> In userspace, the tests are collected and run via `rustdoc`.
> Using the tool as-is would be useful already, since it allows
> to compile-test most tests (thus enforcing they are kept
> in sync with the code they document) and run those that do not
> depend on in-kernel APIs.
> 
> However, by transforming the tests into a KUnit test suite,
> they can also be run inside the kernel. Moreover, the tests
> get to be compiled as other Rust kernel objects instead of
> targeting userspace.
> 
> On top of that, the integration with KUnit means the Rust
> support gets to reuse the existing testing facilities. For
> instance, the kernel log would look like:
> 
>     KTAP version 1
>     1..1
>         KTAP version 1
>         # Subtest: rust_doctests_kernel
>         1..59
>         # Doctest from line 13
>         ok 1 rust_doctest_kernel_build_assert_rs_0
>         # Doctest from line 56
>         ok 2 rust_doctest_kernel_build_assert_rs_1
>         # Doctest from line 122
>         ok 3 rust_doctest_kernel_init_rs_0
>         ...
>         # Doctest from line 150
>         ok 59 rust_doctest_kernel_types_rs_2
>     # rust_doctests_kernel: pass:59 fail:0 skip:0 total:59
>     # Totals: pass:59 fail:0 skip:0 total:59
>     ok 1 rust_doctests_kernel
> 
> Therefore, add support for running Rust documentation tests
> in KUnit. Some other notes about the current implementation
> and support follow.
> 
> The transformation is performed by a couple scripts written
> as Rust hostprogs.
> 
> Tests using the `?` operator are also supported as usual, e.g.:
> 
>     /// ```
>     /// # use kernel::{spawn_work_item, workqueue};
>     /// spawn_work_item!(workqueue::system(), || pr_info!("x"))?;
>     /// # Ok::<(), Error>(())
>     /// ```
> 
> The tests are also compiled with Clippy under `CLIPPY=1`, just like
> normal code, thus also benefitting from extra linting.
> 
> The names of the tests are currently automatically generated.
> This allows to reduce the burden for documentation writers,
> while keeping them fairly stable for bisection. This is an
> improvement over the `rustdoc`-generated names, which include
> the line number; but ideally we would like to get `rustdoc` to
> provide the Rust item path and a number (for multiple examples
> in a single documented Rust item).
> 
> In order for developers to easily see from which original line
> a failed doctests came from, a KTAP diagnostic line is printed
> to the log. In the future, we may be able to use a proper KUnit
> facility to append this sort of information instead.
> 
> A notable difference from KUnit C tests is that the Rust tests
> appear to assert using the usual `assert!` and `assert_eq!`
> macros from the Rust standard library (`core`). We provide
> a custom version that forwards the call to KUnit instead.
> Importantly, these macros do not require passing context,
> unlike the KUnit C ones (i.e. `struct kunit *`). This makes
> them easier to use, and readers of the documentation do not need
> to care about which testing framework is used. In addition, it
> may allow us to test third-party code more easily in the future.
> 
> However, a current limitation is that KUnit does not support
> assertions in other tasks. Thus we presently simply print an
> error to the kernel log if an assertion actually failed. This
> should be revisited to properly fail the test, perhaps saving
> the context somewhere else, or letting KUnit handle it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

(One nit later below.)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +fn main() {
> +    let mut stdin = std::io::stdin().lock();
> +    let mut body = String::new();
> +    stdin.read_to_string(&mut body).unwrap();
> +
> +    // Find the generated function name looking for the inner function inside `main()`.
> +    //
> +    // The line we are looking for looks like one of the following:
> +    //
> +    // ```
> +    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_28_0() {
> +    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl core::fmt::Debug> {
> +    // ```
> +    //
> +    // It should be unlikely that doctest code matches such lines (when code is formatted properly).
> +    let rustdoc_function_name = body
> +        .lines()
> +        .find_map(|line| {
> +            Some(
> +                line.split_once("fn main() {")?
> +                    .1
> +                    .split_once("fn ")?
> +                    .1
> +                    .split_once("()")?
> +                    .0,
> +            )
> +            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c == '_'))
> +        })
> +        .expect("No test function found in `rustdoc`'s output.");
> +
> +    // Qualify `Result` to avoid the collision with our own `Result` coming from the prelude.
> +    let body = body.replace(
> +        &format!("{rustdoc_function_name}() -> Result<(), impl core::fmt::Debug> {{"),
> +        &format!("{rustdoc_function_name}() -> core::result::Result<(), impl core::fmt::Debug> {{"),
> +    );
> +
> +    // For tests that get generated with `Result`, like above, `rustdoc` generates an `unwrap()` on
> +    // the return value to check there were no returned errors. Instead, we use our assert macro
> +    // since we want to just fail the test, not panic the kernel.
> +    //
> +    // We save the result in a variable so that the failed assertion message looks nicer.
> +    let body = body.replace(
> +        &format!("}} {rustdoc_function_name}().unwrap() }}"),
> +        &format!("}} let test_return_value = {rustdoc_function_name}(); assert!(test_return_value.is_ok()); }}"),
> +    );
> +
> +    // Figure out a smaller test name based on the generated function name.
> +    let name = rustdoc_function_name.split_once("_rust_kernel_").unwrap().1;
> +
> +    let path = format!("rust/test/doctests/kernel/{name}");
> +
> +    write!(BufWriter::new(File::create(path).unwrap()), "{body}").unwrap();

This could just be

std::fs::write(path, body.as_bytes());

Alice

