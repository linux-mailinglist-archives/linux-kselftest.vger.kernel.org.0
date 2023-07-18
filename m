Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4E757668
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGRIRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGRIRs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 04:17:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00201137
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 01:17:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so66155e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 01:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689668259; x=1692260259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=09jdsWuxTk020XSrpEwrTpSOYZqG/UPtd5KQINmfVy0=;
        b=NPQ1VpzzkENv2rzrFQTZ0HRZBold+quDR59IJ/e40Yggl/2OcuQm2TLWkwujwC6fY9
         51a4mQhiH8Vt8h5O8I9AgB6Pe18VTGJnrYJqmFVU8GBWj6TmA/qwmAzbEw4+9F2gBtTJ
         s6xzHNqpLmEeXy/424lIklcuk9QEHyVVWzGppFNEXXbyYDIDteFtiy/rynz/fgF+lgkg
         Qna2gslqrPzqdEOzoA8+hMq6+OTkZXge+hgmhrLjPJ2AUMe/5fXGX6eWcv7/nqRdfHPG
         wS2NeyyjDHmkww24TBos6xq5qDPcq8JLoMJzxEqREWhq/4Q1o321JPJ8UBot7P3s5Kxo
         vFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689668259; x=1692260259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09jdsWuxTk020XSrpEwrTpSOYZqG/UPtd5KQINmfVy0=;
        b=lOMI7loxVCSONsase4g8slSmZZyfYzYVIeNSHjnyn7dwxpVBPmvcoltspu4BYDbagV
         LU+5FoRbP0yuuOxGgLikDJirLhqJbOe6P0GFBox1iQSzpSlNvbZdj7k2W7YYiSl3Vghp
         8Y3VuVg4xf0X4r5bLdznvuVfL2Yzm5+0qz65HgSX/wBcQwaeBA0RoS8s35ksulNGy9Jv
         5e/FaX+JJXo+N1+DtnkN8SMjxvfTmRR+daGnm20o2LGS/IVoddx1WGd5aqDV7lm0OWtu
         6zgPkBVsRtewd3oSLKZteeC4GHul2ldUlCgXdOzUTEV2HLm4RSfLz7Kz+7zYdAVfw4wM
         D99Q==
X-Gm-Message-State: ABy/qLZTHSI0tWV64/AbUeqN/S9ACJ0lTMV5oJzld6EhXXUtfjAkkt0k
        8jQj7bHze84GEGE0KgUZf+FIt1wXIMcCcnED/0qEow==
X-Google-Smtp-Source: APBJJlEVrOa0RQfLgrzvdlXhovdOcXmooAjAfCYaCEDQeGFuBgG0rfPrst/hRufmAbn2t9xDVwjfzsDv7qkbc++8Y+c=
X-Received: by 2002:a05:600c:a39e:b0:3fb:ccae:cd4b with SMTP id
 hn30-20020a05600ca39e00b003fbccaecd4bmr76572wmb.2.1689668259064; Tue, 18 Jul
 2023 01:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org> <20230718052752.1045248-7-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-7-ojeda@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 16:17:27 +0800
Message-ID: <CABVgOSnCY66C5wza-ZXb8c8UHg8ydbFv4U_7A14UU_gXeESKZg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] rust: support running Rust documentation tests as
 KUnit ones
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006996f40600be8cd1"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000006996f40600be8cd1
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jul 2023 at 13:28, Miguel Ojeda <ojeda@kernel.org> wrote:
>
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
>         # rust_doctest_kernel_build_assert_rs_0.location: rust/kernel/build_assert.rs:13
>         ok 1 rust_doctest_kernel_build_assert_rs_0
>         # rust_doctest_kernel_build_assert_rs_1.location: rust/kernel/build_assert.rs:56
>         ok 2 rust_doctest_kernel_build_assert_rs_1
>         # rust_doctest_kernel_init_rs_0.location: rust/kernel/init.rs:122
>         ok 3 rust_doctest_kernel_init_rs_0
>         ...
>         # rust_doctest_kernel_types_rs_2.location: rust/kernel/types.rs:150
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
> The tests are also compiled with Clippy under `CLIPPY=1`, just
> like normal code, thus also benefitting from extra linting.
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
> to the log, containing the location (file and line) of the
> original test (i.e. instead of the location in the generated
> Rust file):
>
>     # rust_doctest_kernel_types_rs_2.location: rust/kernel/types.rs:150
>
> This line follows the syntax for declaring test metadata in the
> proposed KTAP v2 spec [1], which may be used for the proposed
> KUnit test attributes API [2]. Thus hopefully this will make
> migration easier later on (suggested by David [3]).
>
> The original line in that test attribute is figured out by
> providing an anchor (suggested by Boqun [4]). The original file
> is found by walking the filesystem, checking directory prefixes
> to reduce the amount of combinations to check, and it is only
> done once per file. Ambiguities are detected and reported.
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
> Link: https://lore.kernel.org/lkml/20230420205734.1288498-1-rmoar@google.com/ [1]
> Link: https://lore.kernel.org/linux-kselftest/20230707210947.1208717-1-rmoar@google.com/ [2]
> Link: https://lore.kernel.org/rust-for-linux/CABVgOSkOLO-8v6kdAGpmYnZUb+LKOX0CtYCo-Bge7r_2YTuXDQ@mail.gmail.com/ [3]
> Link: https://lore.kernel.org/rust-for-linux/ZIps86MbJF%2FiGIzd@boqun-archlinux/ [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

This is looking good and working well here.

One super-minor thought below (the generated C file seems to be using
4-space indentation, not tabs), but it's not something that worries me
enough to hold the patch up if there are no other issues.

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  lib/Kconfig.debug               |  13 ++
>  rust/.gitignore                 |   2 +
>  rust/Makefile                   |  29 ++++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers.c                  |   7 +
>  rust/kernel/kunit.rs            | 163 ++++++++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  scripts/.gitignore              |   2 +
>  scripts/Makefile                |   4 +
>  scripts/rustdoc_test_builder.rs |  72 +++++++++
>  scripts/rustdoc_test_gen.rs     | 260 ++++++++++++++++++++++++++++++++
>  11 files changed, 555 insertions(+)
>  create mode 100644 rust/kernel/kunit.rs
>  create mode 100644 scripts/rustdoc_test_builder.rs
>  create mode 100644 scripts/rustdoc_test_gen.rs
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index fbc89baf7de6..550cb967b668 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3010,6 +3010,19 @@ config RUST_BUILD_ASSERT_ALLOW
>
>           If unsure, say N.
>
> +config RUST_KERNEL_DOCTESTS
> +       bool "Doctests for the `kernel` crate" if !KUNIT_ALL_TESTS
> +       depends on RUST && KUNIT=y
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the documentation tests of the `kernel` crate
> +         as KUnit tests.
> +
> +         For more information on KUnit and unit tests in general,
> +         please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  endmenu # "Rust"
>
>  endmenu # Kernel hacking
> diff --git a/rust/.gitignore b/rust/.gitignore
> index 21552992b401..d3829ffab80b 100644
> --- a/rust/.gitignore
> +++ b/rust/.gitignore
> @@ -2,6 +2,8 @@
>
>  bindings_generated.rs
>  bindings_helpers_generated.rs
> +doctests_kernel_generated.rs
> +doctests_kernel_generated_kunit.c
>  uapi_generated.rs
>  exports_*_generated.h
>  doc/
> diff --git a/rust/Makefile b/rust/Makefile
> index 7c9d9f11aec5..92482144c0bb 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -27,6 +27,12 @@ endif
>
>  obj-$(CONFIG_RUST) += exports.o
>
> +always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
> +always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
> +
> +obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.o
> +obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
> +
>  # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
>  ifdef CONFIG_RUST
>
> @@ -39,9 +45,11 @@ ifeq ($(quiet),silent_)
>  cargo_quiet=-q
>  rust_test_quiet=-q
>  rustdoc_test_quiet=--test-args -q
> +rustdoc_test_kernel_quiet=>/dev/null
>  else ifeq ($(quiet),quiet_)
>  rust_test_quiet=-q
>  rustdoc_test_quiet=--test-args -q
> +rustdoc_test_kernel_quiet=>/dev/null
>  else
>  cargo_quiet=--verbose
>  endif
> @@ -157,6 +165,27 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
>                 -L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>                 --crate-name $(subst rusttest-,,$@) $<
>
> +quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
> +      cmd_rustdoc_test_kernel = \
> +       rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
> +       mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
> +       OBJTREE=$(abspath $(objtree)) \
> +       $(RUSTDOC) --test $(rust_flags) \
> +               @$(objtree)/include/generated/rustc_cfg \
> +               -L$(objtree)/$(obj) --extern alloc --extern kernel \
> +               --extern build_error --extern macros \
> +               --extern bindings --extern uapi \
> +               --no-run --crate-name kernel -Zunstable-options \
> +               --test-builder $(objtree)/scripts/rustdoc_test_builder \
> +               $< $(rustdoc_test_kernel_quiet); \
> +       $(objtree)/scripts/rustdoc_test_gen
> +
> +%/doctests_kernel_generated.rs %/doctests_kernel_generated_kunit.c: \
> +    $(src)/kernel/lib.rs $(obj)/kernel.o \
> +    $(objtree)/scripts/rustdoc_test_builder \
> +    $(objtree)/scripts/rustdoc_test_gen FORCE
> +       $(call if_changed,rustdoc_test_kernel)
> +
>  # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
>  # so for the moment we skip `-Cpanic=abort`.
>  quiet_cmd_rustc_test = RUSTC T  $<
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..0f8d37c31ac2 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,6 +6,7 @@
>   * Sorted alphabetically.
>   */
>
> +#include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..49a5e1a4f0ae 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -18,6 +18,7 @@
>   * accidentally exposed.
>   */
>
> +#include <kunit/test-bug.h>
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
> @@ -135,6 +136,12 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>
> +struct kunit *rust_helper_kunit_get_current_test(void)
> +{
> +       return kunit_get_current_test();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> new file mode 100644
> index 000000000000..722655b2d62d
> --- /dev/null
> +++ b/rust/kernel/kunit.rs
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! KUnit-based macros for Rust unit tests.
> +//!
> +//! C header: [`include/kunit/test.h`](../../../../../include/kunit/test.h)
> +//!
> +//! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
> +
> +use core::{ffi::c_void, fmt};
> +
> +/// Prints a KUnit error-level message.
> +///
> +/// Public but hidden since it should only be used from KUnit generated code.
> +#[doc(hidden)]
> +pub fn err(args: fmt::Arguments<'_>) {
> +    // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
> +    // are passing.
> +    #[cfg(CONFIG_PRINTK)]
> +    unsafe {
> +        bindings::_printk(
> +            b"\x013%pA\0".as_ptr() as _,
> +            &args as *const _ as *const c_void,
> +        );
> +    }
> +}
> +
> +/// Prints a KUnit info-level message.
> +///
> +/// Public but hidden since it should only be used from KUnit generated code.
> +#[doc(hidden)]
> +pub fn info(args: fmt::Arguments<'_>) {
> +    // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
> +    // are passing.
> +    #[cfg(CONFIG_PRINTK)]
> +    unsafe {
> +        bindings::_printk(
> +            b"\x016%pA\0".as_ptr() as _,
> +            &args as *const _ as *const c_void,
> +        );
> +    }
> +}
> +
> +/// Asserts that a boolean expression is `true` at runtime.
> +///
> +/// Public but hidden since it should only be used from generated tests.
> +///
> +/// Unlike the one in `core`, this one does not panic; instead, it is mapped to the KUnit
> +/// facilities. See [`assert!`] for more details.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! kunit_assert {
> +    ($name:literal, $file:literal, $diff:expr, $condition:expr $(,)?) => {
> +        'out: {
> +            // Do nothing if the condition is `true`.
> +            if $condition {
> +                break 'out;
> +            }
> +
> +            static FILE: &'static $crate::str::CStr = $crate::c_str!($file);
> +            static LINE: i32 = core::line!() as i32 - $diff;
> +            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
> +
> +            // SAFETY: FFI call without safety requirements.
> +            let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
> +            if kunit_test.is_null() {
> +                // The assertion failed but this task is not running a KUnit test, so we cannot call
> +                // KUnit, but at least print an error to the kernel log. This may happen if this
> +                // macro is called from an spawned thread in a test (see
> +                // `scripts/rustdoc_test_gen.rs`) or if some non-test code calls this macro by
> +                // mistake (it is hidden to prevent that).
> +                //
> +                // This mimics KUnit's failed assertion format.
> +                $crate::kunit::err(format_args!(
> +                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
> +                    $name
> +                ));
> +                $crate::kunit::err(format_args!(
> +                    "    Expected {CONDITION} to be true, but is false\n"
> +                ));
> +                $crate::kunit::err(format_args!(
> +                    "    Failure not reported to KUnit since this is a non-KUnit task\n"
> +                ));
> +                break 'out;
> +            }
> +
> +            #[repr(transparent)]
> +            struct Location($crate::bindings::kunit_loc);
> +
> +            #[repr(transparent)]
> +            struct UnaryAssert($crate::bindings::kunit_unary_assert);
> +
> +            // SAFETY: There is only a static instance and in that one the pointer field points to
> +            // an immutable C string.
> +            unsafe impl Sync for Location {}
> +
> +            // SAFETY: There is only a static instance and in that one the pointer field points to
> +            // an immutable C string.
> +            unsafe impl Sync for UnaryAssert {}
> +
> +            static LOCATION: Location = Location($crate::bindings::kunit_loc {
> +                file: FILE.as_char_ptr(),
> +                line: LINE,
> +            });
> +            static ASSERTION: UnaryAssert = UnaryAssert($crate::bindings::kunit_unary_assert {
> +                assert: $crate::bindings::kunit_assert {},
> +                condition: CONDITION.as_char_ptr(),
> +                expected_true: true,
> +            });
> +
> +            // SAFETY:
> +            //   - FFI call.
> +            //   - The `kunit_test` pointer is valid because we got it from
> +            //     `kunit_get_current_test()` and it was not null. This means we are in a KUnit
> +            //     test, and that the pointer can be passed to KUnit functions and assertions.
> +            //   - The string pointers (`file` and `condition` above) point to null-terminated
> +            //     strings since they are `CStr`s.
> +            //   - The function pointer (`format`) points to the proper function.
> +            //   - The pointers passed will remain valid since they point to `static`s.
> +            //   - The format string is allowed to be null.
> +            //   - There are, however, problems with this: first of all, this will end up stopping
> +            //     the thread, without running destructors. While that is problematic in itself,
> +            //     it is considered UB to have what is effectively a forced foreign unwind
> +            //     with `extern "C"` ABI. One could observe the stack that is now gone from
> +            //     another thread. We should avoid pinning stack variables to prevent library UB,
> +            //     too. For the moment, given that test failures are reported immediately before the
> +            //     next test runs, that test failures should be fixed and that KUnit is explicitly
> +            //     documented as not suitable for production environments, we feel it is reasonable.
> +            unsafe {
> +                $crate::bindings::__kunit_do_failed_assertion(
> +                    kunit_test,
> +                    core::ptr::addr_of!(LOCATION.0),
> +                    $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
> +                    core::ptr::addr_of!(ASSERTION.0.assert),
> +                    Some($crate::bindings::kunit_unary_assert_format),
> +                    core::ptr::null(),
> +                );
> +            }
> +
> +            // SAFETY: FFI call; the `test` pointer is valid because this hidden macro should only
> +            // be called by the generated documentation tests which forward the test pointer given
> +            // by KUnit.
> +            unsafe {
> +                $crate::bindings::__kunit_abort(kunit_test);
> +            }
> +        }
> +    };
> +}
> +
> +/// Asserts that two expressions are equal to each other (using [`PartialEq`]).
> +///
> +/// Public but hidden since it should only be used from generated tests.
> +///
> +/// Unlike the one in `core`, this one does not panic; instead, it is mapped to the KUnit
> +/// facilities. See [`assert!`] for more details.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! kunit_assert_eq {
> +    ($name:literal, $file:literal, $diff:expr, $left:expr, $right:expr $(,)?) => {{
> +        // For the moment, we just forward to the expression assert because, for binary asserts,
> +        // KUnit supports only a few types (e.g. integers).
> +        $crate::kunit_assert!($name, $file, $diff, $left == $right);
> +    }};
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..3642cadc34b1 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -34,6 +34,8 @@
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> +#[cfg(CONFIG_KUNIT)]
> +pub mod kunit;
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 6e9ce6720a05..3dbb8bb2457b 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -5,6 +5,8 @@
>  /kallsyms
>  /module.lds
>  /recordmcount
> +/rustdoc_test_builder
> +/rustdoc_test_gen
>  /sign-file
>  /sorttable
>  /target.json
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 32b6ba722728..576cf64be667 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -9,6 +9,8 @@ hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)         += sorttable
>  hostprogs-always-$(CONFIG_ASN1)                                += asn1_compiler
>  hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)           += sign-file
>  hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)    += insert-sys-cert
> +hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)                += rustdoc_test_builder
> +hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)                += rustdoc_test_gen
>  always-$(CONFIG_RUST)                                  += target.json
>
>  filechk_rust_target = $< < include/config/auto.conf
> @@ -18,6 +20,8 @@ $(obj)/target.json: scripts/generate_rust_target include/config/auto.conf FORCE
>
>  hostprogs += generate_rust_target
>  generate_rust_target-rust := y
> +rustdoc_test_builder-rust := y
> +rustdoc_test_gen-rust := y
>
>  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
>  HOSTLDLIBS_sorttable = -lpthread
> diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
> new file mode 100644
> index 000000000000..e5894652f12c
> --- /dev/null
> +++ b/scripts/rustdoc_test_builder.rs
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Test builder for `rustdoc`-generated tests.
> +//!
> +//! This script is a hack to extract the test from `rustdoc`'s output. Ideally, `rustdoc` would
> +//! have an option to generate this information instead, e.g. as JSON output.
> +//!
> +//! The `rustdoc`-generated test names look like `{file}_{line}_{number}`, e.g.
> +//! `...path_rust_kernel_sync_arc_rs_42_0`. `number` is the "test number", needed in cases like
> +//! a macro that expands into items with doctests is invoked several times within the same line.
> +//!
> +//! However, since these names are used for bisection in CI, the line number makes it not stable
> +//! at all. In the future, we would like `rustdoc` to give us the Rust item path associated with
> +//! the test, plus a "test number" (for cases with several examples per item) and generate a name
> +//! from that. For the moment, we generate ourselves a new name, `{file}_{number}` instead, in
> +//! the `gen` script (done there since we need to be aware of all the tests in a given file).
> +
> +use std::io::Read;
> +
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
> +    std::fs::write(path, body.as_bytes()).unwrap();
> +}
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> new file mode 100644
> index 000000000000..5ebd42ae4a3f
> --- /dev/null
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generates KUnit tests from saved `rustdoc`-generated tests.
> +//!
> +//! KUnit passes a context (`struct kunit *`) to each test, which should be forwarded to the other
> +//! KUnit functions and macros.
> +//!
> +//! However, we want to keep this as an implementation detail because:
> +//!
> +//!   - Test code should not care about the implementation.
> +//!
> +//!   - Documentation looks worse if it needs to carry extra details unrelated to the piece
> +//!     being described.
> +//!
> +//!   - Test code should be able to define functions and call them, without having to carry
> +//!     the context.
> +//!
> +//!   - Later on, we may want to be able to test non-kernel code (e.g. `core`, `alloc` or
> +//!     third-party crates) which likely use the standard library `assert*!` macros.
> +//!
> +//! For this reason, instead of the passed context, `kunit_get_current_test()` is used instead
> +//! (i.e. `current->kunit_test`).
> +//!
> +//! Note that this means other threads/tasks potentially spawned by a given test, if failing, will
> +//! report the failure in the kernel log but will not fail the actual test. Saving the pointer in
> +//! e.g. a `static` per test does not fully solve the issue either, because currently KUnit does
> +//! not support assertions (only expectations) from other tasks. Thus leave that feature for
> +//! the future, which simplifies the code here too. We could also simply not allow `assert`s in
> +//! other tasks, but that seems overly constraining, and we do want to support them, eventually.
> +
> +use std::{
> +    fs,
> +    fs::File,
> +    io::{BufWriter, Read, Write},
> +    path::{Path, PathBuf},
> +};
> +
> +/// Find the real path to the original file based on the `file` portion of the test name.
> +///
> +/// `rustdoc` generated `file`s look like `sync_locked_by_rs`. Underscores (except the last one)
> +/// may represent an actual underscore in a directory/file, or a path separator. Thus the actual
> +/// file might be `sync_locked_by.rs`, `sync/locked_by.rs`, `sync_locked/by.rs` or
> +/// `sync/locked/by.rs`. This function walks the file system to determine which is the real one.
> +///
> +/// This does require that ambiguities do not exist, but that seems fair, especially since this is
> +/// all supposed to be temporary until `rustdoc` gives us proper metadata to build this. If such
> +/// ambiguities are detected, they are diagnosed and the script panics.
> +fn find_real_path<'a>(srctree: &Path, valid_paths: &'a mut Vec<PathBuf>, file: &str) -> &'a str {
> +    valid_paths.clear();
> +
> +    let potential_components: Vec<&str> = file.strip_suffix("_rs").unwrap().split('_').collect();
> +
> +    find_candidates(srctree, valid_paths, Path::new(""), &potential_components);
> +    fn find_candidates(
> +        srctree: &Path,
> +        valid_paths: &mut Vec<PathBuf>,
> +        prefix: &Path,
> +        potential_components: &[&str],
> +    ) {
> +        // The base case: check whether all the potential components left, joined by underscores,
> +        // is a file.
> +        let joined_potential_components = potential_components.join("_") + ".rs";
> +        if srctree
> +            .join("rust/kernel")
> +            .join(prefix)
> +            .join(&joined_potential_components)
> +            .is_file()
> +        {
> +            // Avoid `srctree` here in order to keep paths relative to it in the KTAP output.
> +            valid_paths.push(
> +                Path::new("rust/kernel")
> +                    .join(prefix)
> +                    .join(joined_potential_components),
> +            );
> +        }
> +
> +        // In addition, check whether each component prefix, joined by underscores, is a directory.
> +        // If not, there is no need to check for combinations with that prefix.
> +        for i in 1..potential_components.len() {
> +            let (components_prefix, components_rest) = potential_components.split_at(i);
> +            let prefix = prefix.join(components_prefix.join("_"));
> +            if srctree.join("rust/kernel").join(&prefix).is_dir() {
> +                find_candidates(srctree, valid_paths, &prefix, components_rest);
> +            }
> +        }
> +    }
> +
> +    assert!(
> +        valid_paths.len() > 0,
> +        "No path candidates found. This is likely a bug in the build system, or some files went \
> +        away while compiling."
> +    );
> +
> +    if valid_paths.len() > 1 {
> +        eprintln!("Several path candidates found:");
> +        for path in valid_paths {
> +            eprintln!("    {path:?}");
> +        }
> +        panic!(
> +            "Several path candidates found, please resolve the ambiguity by renaming a file or \
> +            folder."
> +        );
> +    }
> +
> +    valid_paths[0].to_str().unwrap()
> +}
> +
> +fn main() {
> +    let srctree = std::env::var("srctree").unwrap();
> +    let srctree = Path::new(&srctree);
> +
> +    let mut paths = fs::read_dir("rust/test/doctests/kernel")
> +        .unwrap()
> +        .map(|entry| entry.unwrap().path())
> +        .collect::<Vec<_>>();
> +
> +    // Sort paths.
> +    paths.sort();
> +
> +    let mut rust_tests = String::new();
> +    let mut c_test_declarations = String::new();
> +    let mut c_test_cases = String::new();
> +    let mut body = String::new();
> +    let mut last_file = String::new();
> +    let mut number = 0;
> +    let mut valid_paths: Vec<PathBuf> = Vec::new();
> +    let mut real_path: &str = "";
> +    for path in paths {
> +        // The `name` follows the `{file}_{line}_{number}` pattern (see description in
> +        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
> +        let name = path.file_name().unwrap().to_str().unwrap().to_string();
> +
> +        // Extract the `file` and the `line`, discarding the `number`.
> +        let (file, line) = name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
> +
> +        // Generate an ID sequence ("test number") for each one in the file.
> +        if file == last_file {
> +            number += 1;
> +        } else {
> +            number = 0;
> +            last_file = file.to_string();
> +
> +            // Figure out the real path, only once per file.
> +            real_path = find_real_path(srctree, &mut valid_paths, file);
> +        }
> +
> +        // Generate a KUnit name (i.e. test name and C symbol) for this test.
> +        //
> +        // We avoid the line number, like `rustdoc` does, to make things slightly more stable for
> +        // bisection purposes. However, to aid developers in mapping back what test failed, we will
> +        // print a diagnostics line in the KTAP report.
> +        let kunit_name = format!("rust_doctest_kernel_{file}_{number}");
> +
> +        // Read the test's text contents to dump it below.
> +        body.clear();
> +        File::open(path).unwrap().read_to_string(&mut body).unwrap();
> +
> +        // Calculate how many lines before `main` function (including the `main` function line).
> +        let body_offset = body
> +            .lines()
> +            .take_while(|line| !line.contains("fn main() {"))
> +            .count()
> +            + 1;
> +
> +        use std::fmt::Write;
> +        write!(
> +            rust_tests,
> +            r#"/// Generated `{name}` KUnit test case from a Rust documentation test.
> +#[no_mangle]
> +pub extern "C" fn {kunit_name}(__kunit_test: *mut kernel::bindings::kunit) {{
> +    /// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
> +    #[allow(unused)]
> +    macro_rules! assert {{
> +        ($cond:expr $(,)?) => {{{{
> +            kernel::kunit_assert!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond);
> +        }}}}
> +    }}
> +
> +    /// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
> +    #[allow(unused)]
> +    macro_rules! assert_eq {{
> +        ($left:expr, $right:expr $(,)?) => {{{{
> +            kernel::kunit_assert_eq!("{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right);
> +        }}}}
> +    }}
> +
> +    // Many tests need the prelude, so provide it by default.
> +    #[allow(unused)]
> +    use kernel::prelude::*;
> +
> +    // Unconditionally print the location of the original doctest (i.e. rather than the location in
> +    // the generated file) so that developers can easily map the test back to the source code.
> +    //
> +    // This information is also printed when assertions fail, but this helps in the successful cases
> +    // when the user is running KUnit manually, or when passing `--raw_output` to `kunit.py`.
> +    //
> +    // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
> +    // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
> +    // easier later on.
> +    kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
> +
> +    /// The anchor where the test code body starts.
> +    #[allow(unused)]
> +    static __DOCTEST_ANCHOR: i32 = core::line!() as i32 + {body_offset} + 1;
> +    {{
> +        {body}
> +        main();
> +    }}
> +}}
> +
> +"#
> +        )
> +        .unwrap();
> +
> +        write!(c_test_declarations, "void {kunit_name}(struct kunit *);\n").unwrap();
> +        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap();
> +    }
> +
> +    let rust_tests = rust_tests.trim();
> +    let c_test_declarations = c_test_declarations.trim();
> +    let c_test_cases = c_test_cases.trim();
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

As this is a C file, it might be better to indent this with a tab.

> +}};
> +
> +static struct kunit_suite test_suite = {{
> +    .name = "rust_doctests_kernel",
> +    .test_cases = test_cases,

As above, since this is a C file, it might be better to indent this with a tab.

> +}};
> +
> +kunit_test_suite(test_suite);
> +
> +MODULE_LICENSE("GPL");
> +"#
> +    )
> +    .unwrap();
> +}
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230718052752.1045248-7-ojeda%40kernel.org.

--0000000000006996f40600be8cd1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCl
pZWlaqUU2BPV4fifUXaAX4EeYjytXAVsQW55Q5ltLzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwODE3MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHJsSdldFN1OkDogewgSV
egr2y9Y9pMnGTMAD6qPssg6ULRfURZvQb7uST7v2G8yAGZ4b11NYXM/J5xyY5h30NvUY6vefPSaa
HKq+7GpfGE5kdyEc5AK8ReyLzV2bgFcR4FeTcmwCHi/KecLw25F4IFoAXp2WAniJdyRLBzYvzgu7
EFOcszrzgBLB58NNo4vTem3GMDAPCwS2t8WPUB7Vc/mhn2cCFGevNdZd4D8IFoNdJIMjUwCzd61l
OP3rbctZ7Ffh3Avlowfw7AG6zNua3/fn2myJwJAH83qcRWcl7pQVo/+aJ4fQq9QM9OYw3KBnAE3J
Rw9zufet3a2WlglifA==
--0000000000006996f40600be8cd1--
