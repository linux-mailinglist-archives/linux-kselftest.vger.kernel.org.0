Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2220E735CE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFSRRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjFSRQy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 13:16:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC3E7A;
        Mon, 19 Jun 2023 10:16:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a2c60c529so4602276a12.3;
        Mon, 19 Jun 2023 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687195008; x=1689787008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8uyxIA6YTeOQGNVnnrzm50nIEz0Hb8qxoycU5orv+E=;
        b=UlzMvzD594V++rorkm+Mzmc7UB+IGz1c7UjzTZ/8jVwoI/g4Yggyz2M6jTvdf2bshv
         GsRKoco8gEcbIPVppPmnqWDVYmOJZxGzmM0/shU/NI2TZtQCAsFBu0bkoH3kLHZ2+ECH
         wumrMVaMRaDW1XNO2KSiaF+CiK/o0I84YppO+PprVNs9EOtz4q61ifNTjr9StXrwkpJK
         ZlKNQSwcHe66M14q24qsEl+UIoUJTEgiYuJVXtoBeWgfHxp12vZuG7GxK0B+/1FpuxjG
         zdZzr/u5/5MbGgAEggE20ewgB2qLEaMQV2Cx+taGPrGE1vPbu1fxbzzPqF+dK6+mntm8
         gqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195008; x=1689787008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8uyxIA6YTeOQGNVnnrzm50nIEz0Hb8qxoycU5orv+E=;
        b=HsAiUiW63Bh+LW6iv4RiUFn8lZuac0xNqhERXSSAhQa4A7t47gqEHzR91aIpwi/BkB
         jy7Z4vQ15IJFQLysyzNEGWzGk+stai2UsdTgXzcXmU+BkOvK9kR6stgK+ZgQxDgF14iJ
         /INFlS8XX4mm0TXcqR3J7Bx6XhlXewxUIBXBbntd+lbqqx6LofMzUQCFSqfJXOQOgxQW
         f431OI/6nUEKcNk8typlGlAr/plZaZkfFpTAjI5t1tWssbyvLwTla2/iNRQGTDxCjviY
         B53eL93TVagddIScErmrya4mfWA0WrLjZF5aMX20Z0opaoC2Eh0c8yBgpALbLkNVZRt6
         guMw==
X-Gm-Message-State: AC+VfDzcnH4sa4e8P+j9He6mL03MH5ShbNU5Gy7nI5IQ03jSnLtGVlQc
        OBpiiipy6VmLRQKW4R3xuWuzTiWcvwcBgygUV+A=
X-Google-Smtp-Source: ACHHUZ57IMcRZf/jihejM46EK7848YMQfb4LIryFlU7dKo4ufY0+1k+YZFei4zv3IHnA2aQTZNKVTciKjDJHX/RYohs=
X-Received: by 2002:aa7:cd7a:0:b0:518:7c47:bda2 with SMTP id
 ca26-20020aa7cd7a000000b005187c47bda2mr7146126edb.5.1687195007592; Mon, 19
 Jun 2023 10:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-6-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Mon, 19 Jun 2023 19:16:11 +0200
Message-ID: <CAA76j90Qfe7e0nOTTk=jWAoHOm6-EXf7Vvg+axqhUQ_LmZfVRA@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 14 Jun 2023 at 20:12, Miguel Ojeda <ojeda@kernel.org> wrote:
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
> The tests are also compiled with Clippy under `CLIPPY=3D1`, just like
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
>  lib/Kconfig.debug               |  13 +++
>  rust/.gitignore                 |   2 +
>  rust/Makefile                   |  29 ++++++
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers.c                  |   7 ++
>  rust/kernel/kunit.rs            | 156 ++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   2 +
>  scripts/.gitignore              |   2 +
>  scripts/Makefile                |   4 +
>  scripts/rustdoc_test_builder.rs |  73 ++++++++++++++
>  scripts/rustdoc_test_gen.rs     | 162 ++++++++++++++++++++++++++++++++
>  11 files changed, 451 insertions(+)
>  create mode 100644 rust/kernel/kunit.rs
>  create mode 100644 scripts/rustdoc_test_builder.rs
>  create mode 100644 scripts/rustdoc_test_gen.rs
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ce51d4dc6803..49f5e9c42200 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2911,6 +2911,19 @@ config RUST_BUILD_ASSERT_ALLOW
>
>           If unsure, say N.
>
> +config RUST_KERNEL_KUNIT_TEST
> +       bool "KUnit test for the `kernel` crate" if !KUNIT_ALL_TESTS
> +       depends on RUST && KUNIT=3Dy
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the documentation tests of the `kernel` crate
> +         as KUnit tests.
> +
> +         For more information on KUnit and unit tests in general,
> +         please refer to the KUnit documentation in Documentation/dev-to=
ols/kunit/.
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
> index 7c9d9f11aec5..e4e8b83752e2 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -27,6 +27,12 @@ endif
>
>  obj-$(CONFIG_RUST) +=3D exports.o
>
> +always-$(CONFIG_RUST_KERNEL_KUNIT_TEST) +=3D doctests_kernel_generated.r=
s
> +always-$(CONFIG_RUST_KERNEL_KUNIT_TEST) +=3D doctests_kernel_generated_k=
unit.c
> +
> +obj-$(CONFIG_RUST_KERNEL_KUNIT_TEST) +=3D doctests_kernel_generated.o
> +obj-$(CONFIG_RUST_KERNEL_KUNIT_TEST) +=3D doctests_kernel_generated_kuni=
t.o
> +
>  # Avoids running `$(RUSTC)` for the sysroot when it may not be available=
.
>  ifdef CONFIG_RUST
>
> @@ -39,9 +45,11 @@ ifeq ($(quiet),silent_)
>  cargo_quiet=3D-q
>  rust_test_quiet=3D-q
>  rustdoc_test_quiet=3D--test-args -q
> +rustdoc_test_kernel_quiet=3D>/dev/null
>  else ifeq ($(quiet),quiet_)
>  rust_test_quiet=3D-q
>  rustdoc_test_quiet=3D--test-args -q
> +rustdoc_test_kernel_quiet=3D>/dev/null
>  else
>  cargo_quiet=3D--verbose
>  endif
> @@ -157,6 +165,27 @@ quiet_cmd_rustdoc_test =3D RUSTDOC T $<
>                 -L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
>                 --crate-name $(subst rusttest-,,$@) $<
>
> +quiet_cmd_rustdoc_test_kernel =3D RUSTDOC TK $<
> +      cmd_rustdoc_test_kernel =3D \
> +       rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
> +       mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
> +       OBJTREE=3D$(abspath $(objtree)) \
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
>  # so for the moment we skip `-Cpanic=3Dabort`.
>  quiet_cmd_rustc_test =3D RUSTC T  $<
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
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
> @@ -135,6 +136,12 @@ void rust_helper_put_task_struct(struct task_struct =
*t)
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
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> new file mode 100644
> index 000000000000..3c94efcd7f76
> --- /dev/null
> +++ b/rust/kernel/kunit.rs
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! KUnit-based macros for Rust unit tests.
> +//!
> +//! C header: [`include/kunit/test.h`](../../../../../include/kunit/test=
.h)
> +//!
> +//! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
> +
> +use core::{ffi::c_void, fmt};
> +
> +/// Prints a KUnit error.
> +///
> +/// Public but hidden since it should only be used from KUnit generated =
code.
> +#[doc(hidden)]
> +pub fn err(args: fmt::Arguments<'_>) {
> +    // SAFETY: The format string is null-terminated and the `%pA` specif=
ier matches the argument we
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
> +/// Prints a KUnit error.
> +///
> +/// Public but hidden since it should only be used from KUnit generated =
code.
> +#[doc(hidden)]
> +pub fn info(args: fmt::Arguments<'_>) {
> +    // SAFETY: The format string is null-terminated and the `%pA` specif=
ier matches the argument we
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
> +/// Unlike the one in `core`, this one does not panic; instead, it is ma=
pped to the KUnit
> +/// facilities. See [`assert!`] for more details.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! kunit_assert {
> +    ($name:literal, $condition:expr $(,)?) =3D> {
> +        'out: {
> +            // Do nothing if the condition is `true`.
> +            if $condition {
> +                break 'out;
> +            }
> +
> +            static LINE: i32 =3D core::line!() as i32;
> +            static FILE: &'static $crate::str::CStr =3D $crate::c_str!(c=
ore::file!());
> +            static CONDITION: &'static $crate::str::CStr =3D $crate::c_s=
tr!(stringify!($condition));
> +
> +            // SAFETY: FFI call without safety requirements.
> +            let kunit_test =3D unsafe { $crate::bindings::kunit_get_curr=
ent_test() };
> +            if kunit_test.is_null() {
> +                // The assertion failed but this task is not running a K=
Unit test, so we cannot call
> +                // KUnit, but at least print an error to the kernel log.=
 This may happen if this
> +                // macro is called from an spawned thread in a test (see
> +                // `scripts/rustdoc_test_gen.rs`) or if some non-test co=
de calls this macro by
> +                // mistake (it is hidden to prevent that).
> +                //
> +                // This mimics KUnit's failed assertion format.
> +                $crate::kunit::err(format_args!(
> +                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
> +                    $name
> +                ));
> +                $crate::kunit::err(format_args!(
> +                    "    Expected {CONDITION} to be true, but is false\n=
"
> +                ));
> +                $crate::kunit::err(format_args!(
> +                    "    Failure not reported to KUnit since this is a n=
on-KUnit task\n"
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
> +            // SAFETY: There is only a static instance and in that one t=
he pointer field points to
> +            // an immutable C string.
> +            unsafe impl Sync for Location {}
> +
> +            // SAFETY: There is only a static instance and in that one t=
he pointer field points to
> +            // an immutable C string.
> +            unsafe impl Sync for UnaryAssert {}
> +
> +            static LOCATION: Location =3D Location($crate::bindings::kun=
it_loc {
> +                file: FILE.as_char_ptr(),
> +                line: LINE,
> +            });
> +            static ASSERTION: UnaryAssert =3D UnaryAssert($crate::bindin=
gs::kunit_unary_assert {
> +                assert: $crate::bindings::kunit_assert {},
> +                condition: CONDITION.as_char_ptr(),
> +                expected_true: true,
> +            });
> +
> +            // SAFETY:
> +            //   - FFI call.
> +            //   - The `kunit_test` pointer is valid because we got it f=
rom
> +            //     `kunit_get_current_test()` and it was not null. This =
means we are in a KUnit
> +            //     test, and that the pointer can be passed to KUnit fun=
ctions and assertions.
> +            //   - The string pointers (`file` and `condition` above) po=
int to null-terminated
> +            //     strings since they are `CStr`s.
> +            //   - The function pointer (`format`) points to the proper =
function.
> +            //   - The pointers passed will remain valid since they poin=
t to `static`s.
> +            //   - The format string is allowed to be null.
> +            //   - There are, however, problems with this: first of all,=
 this will end up stopping
> +            //     the thread, without running destructors. While that i=
s problematic in itself,
> +            //     it is considered UB to have what is effectively a for=
ced foreign unwind
> +            //     with `extern "C"` ABI. One could observe the stack th=
at is now gone from
> +            //     another thread. We should avoid pinning stack variabl=
es to prevent library UB,
> +            //     too. For the moment, given that test failures are rep=
orted immediately before the
> +            //     next test runs, that test failures should be fixed an=
d that KUnit is explicitly
> +            //     documented as not suitable for production environment=
s, we feel it is reasonable.
> +            unsafe {
> +                $crate::bindings::kunit_do_failed_assertion(
> +                    kunit_test,
> +                    core::ptr::addr_of!(LOCATION.0),
> +                    $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
> +                    core::ptr::addr_of!(ASSERTION.0.assert),
> +                    Some($crate::bindings::kunit_unary_assert_format),
> +                    core::ptr::null(),
> +                );
> +            }
> +        }
> +    };
> +}
> +
> +/// Asserts that two expressions are equal to each other (using [`Partia=
lEq`]).
> +///
> +/// Public but hidden since it should only be used from generated tests.
> +///
> +/// Unlike the one in `core`, this one does not panic; instead, it is ma=
pped to the KUnit
> +/// facilities. See [`assert!`] for more details.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! kunit_assert_eq {
> +    ($name:literal, $left:expr, $right:expr $(,)?) =3D> {{
> +        // For the moment, we just forward to the expression assert beca=
use, for binary asserts,
> +        // KUnit supports only a few types (e.g. integers).
> +        $crate::kunit_assert!($name, $left =3D=3D $right);
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
> index 32b6ba722728..d5a5382e753c 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -9,6 +9,8 @@ hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)         +=
=3D sorttable
>  hostprogs-always-$(CONFIG_ASN1)                                +=3D asn1=
_compiler
>  hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)           +=3D sign-file
>  hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)    +=3D insert-sys-c=
ert
> +hostprogs-always-$(CONFIG_RUST_KERNEL_KUNIT_TEST)      +=3D rustdoc_test=
_builder
> +hostprogs-always-$(CONFIG_RUST_KERNEL_KUNIT_TEST)      +=3D rustdoc_test=
_gen
>  always-$(CONFIG_RUST)                                  +=3D target.json
>
>  filechk_rust_target =3D $< < include/config/auto.conf
> @@ -18,6 +20,8 @@ $(obj)/target.json: scripts/generate_rust_target includ=
e/config/auto.conf FORCE
>
>  hostprogs +=3D generate_rust_target
>  generate_rust_target-rust :=3D y
> +rustdoc_test_builder-rust :=3D y
> +rustdoc_test_gen-rust :=3D y
>
>  HOSTCFLAGS_sorttable.o =3D -I$(srctree)/tools/include
>  HOSTLDLIBS_sorttable =3D -lpthread
> diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_build=
er.rs
> new file mode 100644
> index 000000000000..e3b7138fb4f9
> --- /dev/null
> +++ b/scripts/rustdoc_test_builder.rs
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Test builder for `rustdoc`-generated tests.
> +//!
> +//! This script is a hack to extract the test from `rustdoc`'s output. I=
deally, `rustdoc` would
> +//! have an option to generate this information instead, e.g. as JSON ou=
tput.
> +//!
> +//! The `rustdoc`-generated test names look like `{file}_{line}_{number}=
`, e.g.
> +//! `...path_rust_kernel_sync_arc_rs_42_0`. `number` is the "test number=
", needed in cases like
> +//! a macro that expands into items with doctests is invoked several tim=
es within the same line.
> +//!
> +//! However, since these names are used for bisection in CI, the line nu=
mber makes it not stable
> +//! at all. In the future, we would like `rustdoc` to give us the Rust i=
tem path associated with
> +//! the test, plus a "test number" (for cases with several examples per =
item) and generate a name
> +//! from that. For the moment, we generate ourselves a new name, `{file}=
_{number}` instead, in
> +//! the `gen` script (done there since we need to be aware of all the te=
sts in a given file).
> +
> +use std::fs::File;
> +use std::io::{BufWriter, Read, Write};
> +
> +fn main() {
> +    let mut stdin =3D std::io::stdin().lock();
> +    let mut body =3D String::new();
> +    stdin.read_to_string(&mut body).unwrap();
> +
> +    // Find the generated function name looking for the inner function i=
nside `main()`.
> +    //
> +    // The line we are looking for looks like one of the following:
> +    //
> +    // ```
> +    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel=
_file_rs_28_0() {
> +    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel=
_file_rs_37_0() -> Result<(), impl core::fmt::Debug> {
> +    // ```
> +    //
> +    // It should be unlikely that doctest code matches such lines (when =
code is formatted properly).
> +    let rustdoc_function_name =3D body
> +        .lines()
> +        .find_map(|line| {
> +            Some(
> +                line.split_once("fn main() {")?Tested-by: Sergio Gonz=C3=
=A1lez Collado <sergio.collado@gmail.com>
> +                    .1
> +                    .split_once("fn ")?
> +                    .1
> +                    .split_once("()")?
> +                    .0,
> +            )
> +            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c =3D=
=3D '_'))
> +        })
> +        .expect("No test function found in `rustdoc`'s output.");
> +
> +    // Qualify `Result` to avoid the collision with our own `Result` com=
ing from the prelude.
> +    let body =3D body.replace(
> +        &format!("{rustdoc_function_name}() -> Result<(), impl core::fmt=
::Debug> {{"),
> +        &format!("{rustdoc_function_name}() -> core::result::Result<(), =
impl core::fmt::Debug> {{"),
> +    );
> +
> +    // For tests that get generated with `Result`, like above, `rustdoc`=
 generates an `unwrap()` on
> +    // the return value to check there were no returned errors. Instead,=
 we use our assert macro
> +    // since we want to just fail the test, not panic the kernel.
> +    //
> +    // We save the result in a variable so that the failed assertion mes=
sage looks nicer.
> +    let body =3D body.replace(
> +        &format!("}} {rustdoc_function_name}().unwrap() }}"),
> +        &format!("}} let test_return_value =3D {rustdoc_function_name}()=
; assert!(test_return_value.is_ok()); }}"),
> +    );
> +
> +    // Figure out a smaller test name based on the generated function na=
me.
> +    let name =3D rustdoc_function_name.split_once("_rust_kernel_").unwra=
p().1;
> +
> +    let path =3D format!("rust/test/doctests/kernel/{name}");
> +
> +    write!(BufWriter::new(File::create(path).unwrap()), "{body}").unwrap=
();
> +}
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> new file mode 100644
> index 000000000000..793885c32c0d
> --- /dev/null
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generates KUnit tests from saved `rustdoc`-generated tests.
> +//!
> +//! KUnit passes a context (`struct kunit *`) to each test, which should=
 be forwarded to the other
> +//! KUnit functions and macros.
> +//!
> +//! However, we want to keep this as an implementation detail because:
> +//!
> +//!   - Test code should not care about the implementation.
> +//!
> +//!   - Documentation looks worse if it needs to carry extra details unr=
elated to the piece
> +//!     being described.
> +//!
> +//!   - Test code should be able to define functions and call them, with=
out having to carry
> +//!     the context.
> +//!
> +//!   - Later on, we may want to be able to test non-kernel code (e.g. `=
core`, `alloc` or
> +//!     third-party crates) which likely use the standard library `asser=
t*!` macros.
> +//!
> +//! For this reason, instead of the passed context, `kunit_get_current_t=
est()` is used instead
> +//! (i.e. `current->kunit_test`).
> +//!
> +//! Note that this means other threads/tasks potentially spawned by a gi=
ven test, if failing, will
> +//! report the failure in the kernel log but will not fail the actual te=
st. Saving the pointer in
> +//! e.g. a `static` per test does not fully solve the issue either, beca=
use currently KUnit does
> +//! not support assertions (only expectations) from other tasks. Thus le=
ave that feature for
> +//! the future, which simplifies the code here too. We could also simply=
 not allow `assert`s in
> +//! other tasks, but that seems overly constraining, and we do want to s=
upport them, eventually.
> +
> +use std::io::{BufWriter, Read, Write};
> +use std::{fs, fs::File};
> +
> +fn main() {
> +    let mut paths =3D fs::read_dir("rust/test/doctests/kernel")
> +        .unwrap()
> +        .map(|entry| entry.unwrap().path())
> +        .collect::<Vec<_>>();
> +
> +    // Sort paths for clarity.
> +    paths.sort();
> +
> +    let mut rust_tests =3D String::new();
> +    let mut c_test_declarations =3D String::new();
> +    let mut c_test_cases =3D String::new();
> +    let mut body =3D String::new();
> +    let mut last_file =3D String::new();
> +    let mut number =3D 0;
> +    for path in paths {
> +        // The `name` follows the `{file}_{line}_{number}` pattern (see =
description in
> +        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
> +        let name =3D path.file_name().unwrap().to_str().unwrap().to_stri=
ng();
> +
> +        // Extract the `file` and the `line`, discarding the `number`.
> +        let (file, line) =3D name.rsplit_once('_').unwrap().0.rsplit_onc=
e('_').unwrap();
> +
> +        // Generate an ID sequence ("test number") for each one in the f=
ile.
> +        if file =3D=3D last_file {
> +            number +=3D 1;
> +        } else {
> +            number =3D 0;
> +            last_file =3D file.to_string();
> +        }
> +
> +        // Generate a KUnit name (i.e. test name and C symbol) for this =
test.
> +        //
> +        // We avoid the line number, like `rustdoc` does, to make things=
 slightly more stable for
> +        // bisection purposes. However, to aid developers in mapping bac=
k what test failed, we will
> +        // print a diagnostics line in the KTAP report.
> +        let kunit_name =3D format!("rust_doctest_kernel_{file}_{number}"=
);
> +
> +        // Read the test's text contents to dump it below.
> +        body.clear();
> +        File::open(path).unwrap().read_to_string(&mut body).unwrap();
> +
> +        let line =3D line.parse::<core::ffi::c_int>().unwrap();
> +
> +        use std::fmt::Write;
> +        write!(
> +            rust_tests,
> +            r#"/// Generated `{name}` KUnit test case from a Rust docume=
ntation test.
> +#[no_mangle]
> +pub extern "C" fn {kunit_name}(__kunit_test: *mut kernel::bindings::kuni=
t) {{
> +    /// Overrides the usual [`assert!`] macro with one that calls KUnit =
instead.
> +    #[allow(unused)]
> +    macro_rules! assert {{
> +        ($cond:expr $(,)?) =3D> {{{{
> +            kernel::kunit_assert!("{kunit_name}", $cond);
> +        }}}}
> +    }}
> +
> +    /// Overrides the usual [`assert_eq!`] macro with one that calls KUn=
it instead.
> +    #[allow(unused)]
> +    macro_rules! assert_eq {{
> +        ($left:expr, $right:expr $(,)?) =3D> {{{{
> +            kernel::kunit_assert_eq!("{kunit_name}", $left, $right);
> +        }}}}
> +    }}
> +
> +    // Many tests need the prelude, so provide it by default.
> +    #[allow(unused)]
> +    use kernel::prelude::*;
> +
> +    // Display line number so that developers can map the test easily to=
 the source code.
> +    kernel::kunit::info(format_args!("    # Doctest from line {line}\n")=
);
> +
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
> +        write!(c_test_declarations, "void {kunit_name}(struct kunit *);\=
n").unwrap();
> +        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap()=
;
> +    }
> +
> +    let rust_tests =3D rust_tests.trim();
> +    let c_test_declarations =3D c_test_declarations.trim();
> +    let c_test_cases =3D c_test_cases.trim();
> +
> +    write!(
> +        BufWriter::new(File::create("rust/doctests_kernel_generated.rs")=
.unwrap()),
> +        r#"//! `kernel` crate documentation tests.
> +
> +const __LOG_PREFIX: &[u8] =3D b"rust_doctests_kernel\0";
> +
> +{rust_tests}
> +"#
> +    )
> +    .unwrap();
> +
> +    write!(
> +        BufWriter::new(File::create("rust/doctests_kernel_generated_kuni=
t.c").unwrap()),
> +        r#"/*
> + * `kernel` crate documentation tests.
> + */
> +
> +#include <kunit/test.h>
> +
> +{c_test_declarations}
> +
> +static struct kunit_case test_cases[] =3D {{
> +    {c_test_cases}
> +    {{ }}
> +}};
> +
> +static struct kunit_suite test_suite =3D {{
> +    .name =3D "rust_doctests_kernel",
> +    .test_cases =3D test_cases,
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

Tested-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
