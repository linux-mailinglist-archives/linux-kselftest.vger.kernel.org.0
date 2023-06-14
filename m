Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790E730725
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbjFNSLs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbjFNSLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 14:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6381270A;
        Wed, 14 Jun 2023 11:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A7B645A7;
        Wed, 14 Jun 2023 18:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBB2C433CA;
        Wed, 14 Jun 2023 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686766183;
        bh=dAry38HwQqO2PU4cvP48WChrQuS+8IqI/4qxj484H2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HK5ymU1RRuVIXN+EnYXTBzUiNVXPgPfr7cRryPhPBW65Xz1ryA5kbzICbOQb8GPnB
         Fjn/8R3z7cD8CAb4sAYf8Kka4sF5KCwvqK02iHj7UIrb2yuX6Od9AbgA3dkROLDtHa
         k2rQG3TNhznu+NF4ACjep73KEqGhzXbvg6uQc1j/mnuKaOqEjj1R+LLIBZtwYWzcUG
         0+zlzWJXI4Lto/e/ZF8hvbcSIzG8hkejVkpQA/BMJGccGNRQhMuUu7tA+CrvWpxkSi
         V/ECF0tt8lLTxpVZkOKqo6r+aMewqc3TwRIiE4SoRC3IoWN8tqPPAj8GjNTBY0suB2
         IPWEoawlQNyJA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 5/6] rust: support running Rust documentation tests as KUnit ones
Date:   Wed, 14 Jun 2023 20:08:29 +0200
Message-ID: <20230614180837.630180-6-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-1-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rust has documentation tests: these are typically examples of
usage of any item (e.g. function, struct, module...).

They are very convenient because they are just written
alongside the documentation. For instance:

    /// Sums two numbers.
    ///
    /// ```
    /// assert_eq!(mymod::f(10, 20), 30);
    /// ```
    pub fn f(a: i32, b: i32) -> i32 {
        a + b
    }

In userspace, the tests are collected and run via `rustdoc`.
Using the tool as-is would be useful already, since it allows
to compile-test most tests (thus enforcing they are kept
in sync with the code they document) and run those that do not
depend on in-kernel APIs.

However, by transforming the tests into a KUnit test suite,
they can also be run inside the kernel. Moreover, the tests
get to be compiled as other Rust kernel objects instead of
targeting userspace.

On top of that, the integration with KUnit means the Rust
support gets to reuse the existing testing facilities. For
instance, the kernel log would look like:

    KTAP version 1
    1..1
        KTAP version 1
        # Subtest: rust_doctests_kernel
        1..59
        # Doctest from line 13
        ok 1 rust_doctest_kernel_build_assert_rs_0
        # Doctest from line 56
        ok 2 rust_doctest_kernel_build_assert_rs_1
        # Doctest from line 122
        ok 3 rust_doctest_kernel_init_rs_0
        ...
        # Doctest from line 150
        ok 59 rust_doctest_kernel_types_rs_2
    # rust_doctests_kernel: pass:59 fail:0 skip:0 total:59
    # Totals: pass:59 fail:0 skip:0 total:59
    ok 1 rust_doctests_kernel

Therefore, add support for running Rust documentation tests
in KUnit. Some other notes about the current implementation
and support follow.

The transformation is performed by a couple scripts written
as Rust hostprogs.

Tests using the `?` operator are also supported as usual, e.g.:

    /// ```
    /// # use kernel::{spawn_work_item, workqueue};
    /// spawn_work_item!(workqueue::system(), || pr_info!("x"))?;
    /// # Ok::<(), Error>(())
    /// ```

The tests are also compiled with Clippy under `CLIPPY=1`, just like
normal code, thus also benefitting from extra linting.

The names of the tests are currently automatically generated.
This allows to reduce the burden for documentation writers,
while keeping them fairly stable for bisection. This is an
improvement over the `rustdoc`-generated names, which include
the line number; but ideally we would like to get `rustdoc` to
provide the Rust item path and a number (for multiple examples
in a single documented Rust item).

In order for developers to easily see from which original line
a failed doctests came from, a KTAP diagnostic line is printed
to the log. In the future, we may be able to use a proper KUnit
facility to append this sort of information instead.

A notable difference from KUnit C tests is that the Rust tests
appear to assert using the usual `assert!` and `assert_eq!`
macros from the Rust standard library (`core`). We provide
a custom version that forwards the call to KUnit instead.
Importantly, these macros do not require passing context,
unlike the KUnit C ones (i.e. `struct kunit *`). This makes
them easier to use, and readers of the documentation do not need
to care about which testing framework is used. In addition, it
may allow us to test third-party code more easily in the future.

However, a current limitation is that KUnit does not support
assertions in other tasks. Thus we presently simply print an
error to the kernel log if an assertion actually failed. This
should be revisited to properly fail the test, perhaps saving
the context somewhere else, or letting KUnit handle it.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 lib/Kconfig.debug               |  13 +++
 rust/.gitignore                 |   2 +
 rust/Makefile                   |  29 ++++++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |   7 ++
 rust/kernel/kunit.rs            | 156 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 scripts/.gitignore              |   2 +
 scripts/Makefile                |   4 +
 scripts/rustdoc_test_builder.rs |  73 ++++++++++++++
 scripts/rustdoc_test_gen.rs     | 162 ++++++++++++++++++++++++++++++++
 11 files changed, 451 insertions(+)
 create mode 100644 rust/kernel/kunit.rs
 create mode 100644 scripts/rustdoc_test_builder.rs
 create mode 100644 scripts/rustdoc_test_gen.rs

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..49f5e9c42200 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2911,6 +2911,19 @@ config RUST_BUILD_ASSERT_ALLOW
 
 	  If unsure, say N.
 
+config RUST_KERNEL_KUNIT_TEST
+	bool "KUnit test for the `kernel` crate" if !KUNIT_ALL_TESTS
+	depends on RUST && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the documentation tests of the `kernel` crate
+	  as KUnit tests.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 endmenu # "Rust"
 
 endmenu # Kernel hacking
diff --git a/rust/.gitignore b/rust/.gitignore
index 21552992b401..d3829ffab80b 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -2,6 +2,8 @@
 
 bindings_generated.rs
 bindings_helpers_generated.rs
+doctests_kernel_generated.rs
+doctests_kernel_generated_kunit.c
 uapi_generated.rs
 exports_*_generated.h
 doc/
diff --git a/rust/Makefile b/rust/Makefile
index 7c9d9f11aec5..e4e8b83752e2 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -27,6 +27,12 @@ endif
 
 obj-$(CONFIG_RUST) += exports.o
 
+always-$(CONFIG_RUST_KERNEL_KUNIT_TEST) += doctests_kernel_generated.rs
+always-$(CONFIG_RUST_KERNEL_KUNIT_TEST) += doctests_kernel_generated_kunit.c
+
+obj-$(CONFIG_RUST_KERNEL_KUNIT_TEST) += doctests_kernel_generated.o
+obj-$(CONFIG_RUST_KERNEL_KUNIT_TEST) += doctests_kernel_generated_kunit.o
+
 # Avoids running `$(RUSTC)` for the sysroot when it may not be available.
 ifdef CONFIG_RUST
 
@@ -39,9 +45,11 @@ ifeq ($(quiet),silent_)
 cargo_quiet=-q
 rust_test_quiet=-q
 rustdoc_test_quiet=--test-args -q
+rustdoc_test_kernel_quiet=>/dev/null
 else ifeq ($(quiet),quiet_)
 rust_test_quiet=-q
 rustdoc_test_quiet=--test-args -q
+rustdoc_test_kernel_quiet=>/dev/null
 else
 cargo_quiet=--verbose
 endif
@@ -157,6 +165,27 @@ quiet_cmd_rustdoc_test = RUSTDOC T $<
 		-L$(objtree)/$(obj)/test --output $(objtree)/$(obj)/doc \
 		--crate-name $(subst rusttest-,,$@) $<
 
+quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
+      cmd_rustdoc_test_kernel = \
+	rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
+	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
+	OBJTREE=$(abspath $(objtree)) \
+	$(RUSTDOC) --test $(rust_flags) \
+		@$(objtree)/include/generated/rustc_cfg \
+		-L$(objtree)/$(obj) --extern alloc --extern kernel \
+		--extern build_error --extern macros \
+		--extern bindings --extern uapi \
+		--no-run --crate-name kernel -Zunstable-options \
+		--test-builder $(objtree)/scripts/rustdoc_test_builder \
+		$< $(rustdoc_test_kernel_quiet); \
+	$(objtree)/scripts/rustdoc_test_gen
+
+%/doctests_kernel_generated.rs %/doctests_kernel_generated_kunit.c: \
+    $(src)/kernel/lib.rs $(obj)/kernel.o \
+    $(objtree)/scripts/rustdoc_test_builder \
+    $(objtree)/scripts/rustdoc_test_gen FORCE
+	$(call if_changed,rustdoc_test_kernel)
+
 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
 # so for the moment we skip `-Cpanic=abort`.
 quiet_cmd_rustc_test = RUSTC T  $<
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..0f8d37c31ac2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,6 +6,7 @@
  * Sorted alphabetically.
  */
 
+#include <kunit/test.h>
 #include <linux/errname.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index bb594da56137..49a5e1a4f0ae 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -18,6 +18,7 @@
  * accidentally exposed.
  */
 
+#include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/err.h>
@@ -135,6 +136,12 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+struct kunit *rust_helper_kunit_get_current_test(void)
+{
+	return kunit_get_current_test();
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
new file mode 100644
index 000000000000..3c94efcd7f76
--- /dev/null
+++ b/rust/kernel/kunit.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! KUnit-based macros for Rust unit tests.
+//!
+//! C header: [`include/kunit/test.h`](../../../../../include/kunit/test.h)
+//!
+//! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
+
+use core::{ffi::c_void, fmt};
+
+/// Prints a KUnit error.
+///
+/// Public but hidden since it should only be used from KUnit generated code.
+#[doc(hidden)]
+pub fn err(args: fmt::Arguments<'_>) {
+    // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
+    // are passing.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            b"\x013%pA\0".as_ptr() as _,
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Prints a KUnit error.
+///
+/// Public but hidden since it should only be used from KUnit generated code.
+#[doc(hidden)]
+pub fn info(args: fmt::Arguments<'_>) {
+    // SAFETY: The format string is null-terminated and the `%pA` specifier matches the argument we
+    // are passing.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            b"\x016%pA\0".as_ptr() as _,
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Asserts that a boolean expression is `true` at runtime.
+///
+/// Public but hidden since it should only be used from generated tests.
+///
+/// Unlike the one in `core`, this one does not panic; instead, it is mapped to the KUnit
+/// facilities. See [`assert!`] for more details.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! kunit_assert {
+    ($name:literal, $condition:expr $(,)?) => {
+        'out: {
+            // Do nothing if the condition is `true`.
+            if $condition {
+                break 'out;
+            }
+
+            static LINE: i32 = core::line!() as i32;
+            static FILE: &'static $crate::str::CStr = $crate::c_str!(core::file!());
+            static CONDITION: &'static $crate::str::CStr = $crate::c_str!(stringify!($condition));
+
+            // SAFETY: FFI call without safety requirements.
+            let kunit_test = unsafe { $crate::bindings::kunit_get_current_test() };
+            if kunit_test.is_null() {
+                // The assertion failed but this task is not running a KUnit test, so we cannot call
+                // KUnit, but at least print an error to the kernel log. This may happen if this
+                // macro is called from an spawned thread in a test (see
+                // `scripts/rustdoc_test_gen.rs`) or if some non-test code calls this macro by
+                // mistake (it is hidden to prevent that).
+                //
+                // This mimics KUnit's failed assertion format.
+                $crate::kunit::err(format_args!(
+                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
+                    $name
+                ));
+                $crate::kunit::err(format_args!(
+                    "    Expected {CONDITION} to be true, but is false\n"
+                ));
+                $crate::kunit::err(format_args!(
+                    "    Failure not reported to KUnit since this is a non-KUnit task\n"
+                ));
+                break 'out;
+            }
+
+            #[repr(transparent)]
+            struct Location($crate::bindings::kunit_loc);
+
+            #[repr(transparent)]
+            struct UnaryAssert($crate::bindings::kunit_unary_assert);
+
+            // SAFETY: There is only a static instance and in that one the pointer field points to
+            // an immutable C string.
+            unsafe impl Sync for Location {}
+
+            // SAFETY: There is only a static instance and in that one the pointer field points to
+            // an immutable C string.
+            unsafe impl Sync for UnaryAssert {}
+
+            static LOCATION: Location = Location($crate::bindings::kunit_loc {
+                file: FILE.as_char_ptr(),
+                line: LINE,
+            });
+            static ASSERTION: UnaryAssert = UnaryAssert($crate::bindings::kunit_unary_assert {
+                assert: $crate::bindings::kunit_assert {},
+                condition: CONDITION.as_char_ptr(),
+                expected_true: true,
+            });
+
+            // SAFETY:
+            //   - FFI call.
+            //   - The `kunit_test` pointer is valid because we got it from
+            //     `kunit_get_current_test()` and it was not null. This means we are in a KUnit
+            //     test, and that the pointer can be passed to KUnit functions and assertions.
+            //   - The string pointers (`file` and `condition` above) point to null-terminated
+            //     strings since they are `CStr`s.
+            //   - The function pointer (`format`) points to the proper function.
+            //   - The pointers passed will remain valid since they point to `static`s.
+            //   - The format string is allowed to be null.
+            //   - There are, however, problems with this: first of all, this will end up stopping
+            //     the thread, without running destructors. While that is problematic in itself,
+            //     it is considered UB to have what is effectively a forced foreign unwind
+            //     with `extern "C"` ABI. One could observe the stack that is now gone from
+            //     another thread. We should avoid pinning stack variables to prevent library UB,
+            //     too. For the moment, given that test failures are reported immediately before the
+            //     next test runs, that test failures should be fixed and that KUnit is explicitly
+            //     documented as not suitable for production environments, we feel it is reasonable.
+            unsafe {
+                $crate::bindings::kunit_do_failed_assertion(
+                    kunit_test,
+                    core::ptr::addr_of!(LOCATION.0),
+                    $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
+                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    Some($crate::bindings::kunit_unary_assert_format),
+                    core::ptr::null(),
+                );
+            }
+        }
+    };
+}
+
+/// Asserts that two expressions are equal to each other (using [`PartialEq`]).
+///
+/// Public but hidden since it should only be used from generated tests.
+///
+/// Unlike the one in `core`, this one does not panic; instead, it is mapped to the KUnit
+/// facilities. See [`assert!`] for more details.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! kunit_assert_eq {
+    ($name:literal, $left:expr, $right:expr $(,)?) => {{
+        // For the moment, we just forward to the expression assert because, for binary asserts,
+        // KUnit supports only a few types (e.g. integers).
+        $crate::kunit_assert!($name, $left == $right);
+    }};
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..3642cadc34b1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,8 @@
 pub mod error;
 pub mod init;
 pub mod ioctl;
+#[cfg(CONFIG_KUNIT)]
+pub mod kunit;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 6e9ce6720a05..3dbb8bb2457b 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -5,6 +5,8 @@
 /kallsyms
 /module.lds
 /recordmcount
+/rustdoc_test_builder
+/rustdoc_test_gen
 /sign-file
 /sorttable
 /target.json
diff --git a/scripts/Makefile b/scripts/Makefile
index 32b6ba722728..d5a5382e753c 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -9,6 +9,8 @@ hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
+hostprogs-always-$(CONFIG_RUST_KERNEL_KUNIT_TEST)	+= rustdoc_test_builder
+hostprogs-always-$(CONFIG_RUST_KERNEL_KUNIT_TEST)	+= rustdoc_test_gen
 always-$(CONFIG_RUST)					+= target.json
 
 filechk_rust_target = $< < include/config/auto.conf
@@ -18,6 +20,8 @@ $(obj)/target.json: scripts/generate_rust_target include/config/auto.conf FORCE
 
 hostprogs += generate_rust_target
 generate_rust_target-rust := y
+rustdoc_test_builder-rust := y
+rustdoc_test_gen-rust := y
 
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
new file mode 100644
index 000000000000..e3b7138fb4f9
--- /dev/null
+++ b/scripts/rustdoc_test_builder.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Test builder for `rustdoc`-generated tests.
+//!
+//! This script is a hack to extract the test from `rustdoc`'s output. Ideally, `rustdoc` would
+//! have an option to generate this information instead, e.g. as JSON output.
+//!
+//! The `rustdoc`-generated test names look like `{file}_{line}_{number}`, e.g.
+//! `...path_rust_kernel_sync_arc_rs_42_0`. `number` is the "test number", needed in cases like
+//! a macro that expands into items with doctests is invoked several times within the same line.
+//!
+//! However, since these names are used for bisection in CI, the line number makes it not stable
+//! at all. In the future, we would like `rustdoc` to give us the Rust item path associated with
+//! the test, plus a "test number" (for cases with several examples per item) and generate a name
+//! from that. For the moment, we generate ourselves a new name, `{file}_{number}` instead, in
+//! the `gen` script (done there since we need to be aware of all the tests in a given file).
+
+use std::fs::File;
+use std::io::{BufWriter, Read, Write};
+
+fn main() {
+    let mut stdin = std::io::stdin().lock();
+    let mut body = String::new();
+    stdin.read_to_string(&mut body).unwrap();
+
+    // Find the generated function name looking for the inner function inside `main()`.
+    //
+    // The line we are looking for looks like one of the following:
+    //
+    // ```
+    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_28_0() {
+    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl core::fmt::Debug> {
+    // ```
+    //
+    // It should be unlikely that doctest code matches such lines (when code is formatted properly).
+    let rustdoc_function_name = body
+        .lines()
+        .find_map(|line| {
+            Some(
+                line.split_once("fn main() {")?
+                    .1
+                    .split_once("fn ")?
+                    .1
+                    .split_once("()")?
+                    .0,
+            )
+            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c == '_'))
+        })
+        .expect("No test function found in `rustdoc`'s output.");
+
+    // Qualify `Result` to avoid the collision with our own `Result` coming from the prelude.
+    let body = body.replace(
+        &format!("{rustdoc_function_name}() -> Result<(), impl core::fmt::Debug> {{"),
+        &format!("{rustdoc_function_name}() -> core::result::Result<(), impl core::fmt::Debug> {{"),
+    );
+
+    // For tests that get generated with `Result`, like above, `rustdoc` generates an `unwrap()` on
+    // the return value to check there were no returned errors. Instead, we use our assert macro
+    // since we want to just fail the test, not panic the kernel.
+    //
+    // We save the result in a variable so that the failed assertion message looks nicer.
+    let body = body.replace(
+        &format!("}} {rustdoc_function_name}().unwrap() }}"),
+        &format!("}} let test_return_value = {rustdoc_function_name}(); assert!(test_return_value.is_ok()); }}"),
+    );
+
+    // Figure out a smaller test name based on the generated function name.
+    let name = rustdoc_function_name.split_once("_rust_kernel_").unwrap().1;
+
+    let path = format!("rust/test/doctests/kernel/{name}");
+
+    write!(BufWriter::new(File::create(path).unwrap()), "{body}").unwrap();
+}
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
new file mode 100644
index 000000000000..793885c32c0d
--- /dev/null
+++ b/scripts/rustdoc_test_gen.rs
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generates KUnit tests from saved `rustdoc`-generated tests.
+//!
+//! KUnit passes a context (`struct kunit *`) to each test, which should be forwarded to the other
+//! KUnit functions and macros.
+//!
+//! However, we want to keep this as an implementation detail because:
+//!
+//!   - Test code should not care about the implementation.
+//!
+//!   - Documentation looks worse if it needs to carry extra details unrelated to the piece
+//!     being described.
+//!
+//!   - Test code should be able to define functions and call them, without having to carry
+//!     the context.
+//!
+//!   - Later on, we may want to be able to test non-kernel code (e.g. `core`, `alloc` or
+//!     third-party crates) which likely use the standard library `assert*!` macros.
+//!
+//! For this reason, instead of the passed context, `kunit_get_current_test()` is used instead
+//! (i.e. `current->kunit_test`).
+//!
+//! Note that this means other threads/tasks potentially spawned by a given test, if failing, will
+//! report the failure in the kernel log but will not fail the actual test. Saving the pointer in
+//! e.g. a `static` per test does not fully solve the issue either, because currently KUnit does
+//! not support assertions (only expectations) from other tasks. Thus leave that feature for
+//! the future, which simplifies the code here too. We could also simply not allow `assert`s in
+//! other tasks, but that seems overly constraining, and we do want to support them, eventually.
+
+use std::io::{BufWriter, Read, Write};
+use std::{fs, fs::File};
+
+fn main() {
+    let mut paths = fs::read_dir("rust/test/doctests/kernel")
+        .unwrap()
+        .map(|entry| entry.unwrap().path())
+        .collect::<Vec<_>>();
+
+    // Sort paths for clarity.
+    paths.sort();
+
+    let mut rust_tests = String::new();
+    let mut c_test_declarations = String::new();
+    let mut c_test_cases = String::new();
+    let mut body = String::new();
+    let mut last_file = String::new();
+    let mut number = 0;
+    for path in paths {
+        // The `name` follows the `{file}_{line}_{number}` pattern (see description in
+        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
+        let name = path.file_name().unwrap().to_str().unwrap().to_string();
+
+        // Extract the `file` and the `line`, discarding the `number`.
+        let (file, line) = name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
+
+        // Generate an ID sequence ("test number") for each one in the file.
+        if file == last_file {
+            number += 1;
+        } else {
+            number = 0;
+            last_file = file.to_string();
+        }
+
+        // Generate a KUnit name (i.e. test name and C symbol) for this test.
+        //
+        // We avoid the line number, like `rustdoc` does, to make things slightly more stable for
+        // bisection purposes. However, to aid developers in mapping back what test failed, we will
+        // print a diagnostics line in the KTAP report.
+        let kunit_name = format!("rust_doctest_kernel_{file}_{number}");
+
+        // Read the test's text contents to dump it below.
+        body.clear();
+        File::open(path).unwrap().read_to_string(&mut body).unwrap();
+
+        let line = line.parse::<core::ffi::c_int>().unwrap();
+
+        use std::fmt::Write;
+        write!(
+            rust_tests,
+            r#"/// Generated `{name}` KUnit test case from a Rust documentation test.
+#[no_mangle]
+pub extern "C" fn {kunit_name}(__kunit_test: *mut kernel::bindings::kunit) {{
+    /// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
+    #[allow(unused)]
+    macro_rules! assert {{
+        ($cond:expr $(,)?) => {{{{
+            kernel::kunit_assert!("{kunit_name}", $cond);
+        }}}}
+    }}
+
+    /// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
+    #[allow(unused)]
+    macro_rules! assert_eq {{
+        ($left:expr, $right:expr $(,)?) => {{{{
+            kernel::kunit_assert_eq!("{kunit_name}", $left, $right);
+        }}}}
+    }}
+
+    // Many tests need the prelude, so provide it by default.
+    #[allow(unused)]
+    use kernel::prelude::*;
+
+    // Display line number so that developers can map the test easily to the source code.
+    kernel::kunit::info(format_args!("    # Doctest from line {line}\n"));
+
+    {{
+        {body}
+        main();
+    }}
+}}
+
+"#
+        )
+        .unwrap();
+
+        write!(c_test_declarations, "void {kunit_name}(struct kunit *);\n").unwrap();
+        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap();
+    }
+
+    let rust_tests = rust_tests.trim();
+    let c_test_declarations = c_test_declarations.trim();
+    let c_test_cases = c_test_cases.trim();
+
+    write!(
+        BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
+        r#"//! `kernel` crate documentation tests.
+
+const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
+
+{rust_tests}
+"#
+    )
+    .unwrap();
+
+    write!(
+        BufWriter::new(File::create("rust/doctests_kernel_generated_kunit.c").unwrap()),
+        r#"/*
+ * `kernel` crate documentation tests.
+ */
+
+#include <kunit/test.h>
+
+{c_test_declarations}
+
+static struct kunit_case test_cases[] = {{
+    {c_test_cases}
+    {{ }}
+}};
+
+static struct kunit_suite test_suite = {{
+    .name = "rust_doctests_kernel",
+    .test_cases = test_cases,
+}};
+
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
+"#
+    )
+    .unwrap();
+}
-- 
2.41.0

