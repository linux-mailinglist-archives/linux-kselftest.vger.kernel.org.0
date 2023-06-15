Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B992D730DBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbjFODxC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbjFODwi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:52:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485BB271B;
        Wed, 14 Jun 2023 20:52:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39c84863e7cso4525671b6e.1;
        Wed, 14 Jun 2023 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801151; x=1689393151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spaaVbjiBdTlaLp097AQ1jobvAghV0KKc7Xk2bn+bUg=;
        b=qgBlk7f7Lj8nZKadPLr19Hu3xpdOt2yYPRbVsDJC4gItJ+IXLtByomvtFByBxqD2bO
         s37vlyup3Cs/V7hnLnosOsges6236vXWdBZSKHgOGofMTVlt8MwU7wFAWofWgbz6aWCz
         XCpCOfgITbhqB7aEMwJwNa9Mhzx2rWpsvM21EH8vOWAlo7WnKEunT4VHBgVEXukzeqs3
         HdjBN1HoAS8nsMI2LbMhs7ZJ13ZJyOaaccJCfiJWL0NruT7KCKCjWig3mdm+57MhwgU7
         fnPfBFSTcejcOnHhO8iR+YB+T4AUNC2/xJ2ADV1M6tREPkiBXPTNyXXD1mrEzIWX1xQU
         ojQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801151; x=1689393151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spaaVbjiBdTlaLp097AQ1jobvAghV0KKc7Xk2bn+bUg=;
        b=I4o4aUwBkNNvVxosM1MLLZ08y38KtUcvNKJOs5giYz4ydlQMyqGxvBECISaMVHiYpI
         7COubHrvJO/2SRmi/3lThEys4CkhhYnXn3iQJBcOzkTlaTryv2yqVPAK6hqmO8en83uU
         ZXfs1FUJ0pZ35LbmvS+dRYYIC72q3y6k7UCeGnHV7isy1pENucWbRtJUEKsX6gU6IES9
         2VxTSr7vOZW0p3gnTPBkVvN3FI5GsnzpbuylVIwNBF60G8z/STUzAiQ5aRjCITH/B0Mz
         rcrVBnJ00of/yq5524Gkfklmw22f8/W0wlxQfx39TD3IjsLQlkwXVP2Ey4FI7Bvy5leC
         G5kA==
X-Gm-Message-State: AC+VfDyXZnBjKHLyIvkAg9WSrJFkNDIvhNXxJnH9GeyWgQjINMt6rEoK
        rbvMaJHjPTwM/+CfkNT2gS8=
X-Google-Smtp-Source: ACHHUZ5Xv8IWe1XuMU4Rd3aBfZYhp1veoFch0A4sL+zXRvWjx2J3BCBqC1VVMXW5TyNU0I7ZPGs+ig==
X-Received: by 2002:a05:6808:208a:b0:39a:bf0:4fe0 with SMTP id s10-20020a056808208a00b0039a0bf04fe0mr14308216oiw.15.1686801151129;
        Wed, 14 Jun 2023 20:52:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l3-20020a544503000000b0039aab5cee6csm6495019oil.11.2023.06.14.20.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 20:52:30 -0700 (PDT)
Message-ID: <49dad8fe-c509-6c43-559e-13a82563d3d0@gmail.com>
Date:   Thu, 15 Jun 2023 00:49:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-6-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/23 15:08, Miguel Ojeda wrote:
> Rust has documentation tests: these are typically examples of
> usage of any item (e.g. function, struct, module...).
> 
> They are very convenient because they are just written
> alongside the documentation. For instance:
> 
>      /// Sums two numbers.
>      ///
>      /// ```
>      /// assert_eq!(mymod::f(10, 20), 30);
>      /// ```
>      pub fn f(a: i32, b: i32) -> i32 {
>          a + b
>      }
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
>      KTAP version 1
>      1..1
>          KTAP version 1
>          # Subtest: rust_doctests_kernel
>          1..59
>          # Doctest from line 13
>          ok 1 rust_doctest_kernel_build_assert_rs_0
>          # Doctest from line 56
>          ok 2 rust_doctest_kernel_build_assert_rs_1
>          # Doctest from line 122
>          ok 3 rust_doctest_kernel_init_rs_0
>          ...
>          # Doctest from line 150
>          ok 59 rust_doctest_kernel_types_rs_2
>      # rust_doctests_kernel: pass:59 fail:0 skip:0 total:59
>      # Totals: pass:59 fail:0 skip:0 total:59
>      ok 1 rust_doctests_kernel
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
>      /// ```
>      /// # use kernel::{spawn_work_item, workqueue};
>      /// spawn_work_item!(workqueue::system(), || pr_info!("x"))?;
>      /// # Ok::<(), Error>(())
>      /// ```
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
> ---
> [...]
> diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
> new file mode 100644
> index 000000000000..e3b7138fb4f9
> --- /dev/null
> +++ b/scripts/rustdoc_test_builder.rs
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> [...]
> +
> +fn main() {
> [...]
> +
> +    write!(BufWriter::new(File::create(path).unwrap()), "{body}").unwrap();

I can't remember that if this panic it will mention the path on it.
Though if it does, then use something more explicit than
`.unwrap()`.

> +}
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> new file mode 100644
> index 000000000000..793885c32c0d
> --- /dev/null
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> [...]
> +
> +use std::io::{BufWriter, Read, Write};
> +use std::{fs, fs::File};
> +
> +fn main() {
> +    let mut paths = fs::read_dir("rust/test/doctests/kernel")
> +        .unwrap()
> +        .map(|entry| entry.unwrap().path())
> +        .collect::<Vec<_>>();
> +
> +    // Sort paths for clarity.
> +    paths.sort();
> +
> +    let mut rust_tests = String::new();
> +    let mut c_test_declarations = String::new();
> +    let mut c_test_cases = String::new();
> +    let mut body = String::new();
> +    let mut last_file = String::new();
> +    let mut number = 0;
> +    for path in paths {
> +        // The `name` follows the `{file}_{line}_{number}` pattern (see description in
> +        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
> +        let name = path.file_name().unwrap().to_str().unwrap().to_string();
> +
> +        // Extract the `file` and the `line`, discarding the `number`.
> +        let (file, line) = name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();

Please do not use unwrap here, one can easily create a path that
it's not compliant under `rust/test/doctests/kernel` and get no
clue about where this script has failed. Use `.expect()` or
something else instead.

> +
> [...]
> +
> +    write!(
> +        BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
> +        r#"//! `kernel` crate documentation tests.
> +
> +const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
> +
> +{rust_tests}
> +"#
> +    )
> +    .unwrap();
> +
> +    write!(
> +        BufWriter::new(File::create("rust/doctests_kernel_generated_kunit.c").unwrap()),
> +        r#"/*
> + * `kernel` crate documentation tests.
> + */
> +
> +#include <kunit/test.h>
> +
> +{c_test_declarations}
> +
> +static struct kunit_case test_cases[] = {{
> +    {c_test_cases}
> +    {{ }}
> +}};
> +
> +static struct kunit_suite test_suite = {{
> +    .name = "rust_doctests_kernel",
> +    .test_cases = test_cases,
> +}};
> +
> +kunit_test_suite(test_suite);
> +
> +MODULE_LICENSE("GPL");
> +"#
> +    )
> +    .unwrap();

Same from `scripts/rustdoc_test_builder.rs` applies here.

> +}
