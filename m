Return-Path: <linux-kselftest+bounces-42923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D7BC83B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506FC3B74CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AF82D5940;
	Thu,  9 Oct 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUDKqvG+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53423536C;
	Thu,  9 Oct 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001262; cv=none; b=Ysf3Saz4l+hTg+/zeZYrnaEb9URvDTACRFEjOn+BvO9nOJM/nAyEd4SOJork1dYYzddbZSJ/OrHmM+bxrTN/OqYXmQAAzOYucWho+KFOzcEBbeqs2BecES1IrX+CCPMqbNUaLVcjY46uAg927tX5paV++ZuMWRsi117lj2LCEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001262; c=relaxed/simple;
	bh=9Ik0kN9Yu9ry9H+3ds88Xi4woQD3TR5StlszajbefC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9nuDHOuSZ3a/mYNZdxvzGs2x+QLrAeeIjKqoqsdKnH+PQxfshLM73U1H6c+bdYt9eEnyvCjW4wGcZS32yqsBoPnVvZqYR7HTSRgqz3c3xkW2xf9xWcKLThLVUKbpG+SW8MPP8Homt5XaaOmkxkZYlAf3llMj++lwLxivo7PBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUDKqvG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2CC4CEE7;
	Thu,  9 Oct 2025 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760001262;
	bh=9Ik0kN9Yu9ry9H+3ds88Xi4woQD3TR5StlszajbefC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUDKqvG+kHlaSvgxTmarq0ZLh8ExRuZOzRl0PvmZxbcPZIwzS7tCdk5jC7DyptN0S
	 QMN5LUt3V/04uUnyGKEYknE7JwRYCIS88RNIoqRuPWqObqtfy80EHn6KsQuGiY0W/+
	 1nRNxRfg/6sFWzsG5f2KlTuEn0xfDdMadcaI9EijQ5jNmXrxEz3yAFeDW497MmAeh/
	 QkxMAjQXG9rDKOs40tW9wl9L+Dg1FWLWIh8D2QkveiTh9bQCfQizaYWTAhx77rUS0Z
	 jDL3WXcgb+6C1RAIBl6SbF/JvYph2dzND6fbb2nhmm9BsJCBCmaN6mV1SdNomXorTm
	 3umnvCwgeTT3g==
From: Miguel Ojeda <ojeda@kernel.org>
To: Guillaume Gomez <guillaume1.gomez@gmail.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/1] Use new `--output-format=doctest` rustdoc command line flag to improve doctest handling
Date: Thu,  9 Oct 2025 11:14:10 +0200
Message-ID: <20251009091410.756800-1-ojeda@kernel.org>
In-Reply-To: <20250617140032.1133337-2-guillaume1.gomez@gmail.com>
References: <20250617140032.1133337-2-guillaume1.gomez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Jun 2025 16:00:33 +0200 Guillaume Gomez <guillaume1.gomez@gmail.com> wrote:
>
> The goal of this patch is to remove the use of 2 unstable
> rustdoc features (`--no-run` and `--test-builder`) and replace it with a
> stable feature: `--output-format=doctest`, which was added in
> https://github.com/rust-lang/rust/pull/134531.
>
> Before this patch, the code was using very hacky methods in order to retrieve
> doctests, modify them as needed and then concatenate all of them in one file.
>
> Now, with this new flag, it instead asks rustdoc to provide the doctests
> code with their associated information such as file path and line number.
>
> Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>
> ---

(Procedural bit: normally we provide a changelog between versions after
this `---` line so that reviewers now what changed so far.)

I finally took a look at this again, so I rebased it and got:

    thread 'main' panicked at scripts/rustdoc_test_gen.rs:92:15:
    No path candidates found for `rust_kernel_alloc_allocator.rs`.This is likely a bug in the build system, or some files went away while compiling.

which brings me to the bigger point: the main reason to have the new
output format is to avoid all these hacks, including the "find the real
path back to the original file" hack here. More generally, to avoid the
2 scripts approach.

So now we can finally get rid of all that and simplify. That is, we can
just merge it all in a single script that reads the JSON and builds the
result directly, since now we have everything we need (originally I
needed the 2 scripts approach since `rustdoc` executed the test builder
once per test so I had to somehow collect the results).

i.e. no more hundreds of generated files/processes, just a simple pipe.

Anyway, just to check we had everything we needed, I did a quick try --
please see the draft patch below.

I gave it a go -- please see the draft patch below. The diff w.r.t. your
patch would be something like +217 -341, i.e. we get rid of quite a lot
of lines. I added as well some more context in the commit message, and
put the right docs in the unified script. This also improves the sorting
of the tests (it now follows the line number better).

We still have to preserve the support for the old compilers, so what I
think I will do is just have the new script separately, keeping the old
ones as-is until we can remove them when we upgrade the minimum for e.g.
the next Debian Stable.

Cc'ing David and KUnit, since this is closer to getting ready -- please
let me know if this raises alarms for anyone.

Thanks!

Cheers,
Miguel

From 4aa4581e9004cb95534805f73fdae56c454b3d1d Mon Sep 17 00:00:00 2001
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Tue, 17 Jun 2025 16:00:33 +0200
Subject: [PATCH] [TODO] rust: use new `rustdoc`'s `--output-format=doctest`

The goal of this patch is to remove the use of 2 unstable `rustdoc`
features (`--no-run` and `--test-builder`) and replace it with a future
stable feature: `--output-format=doctest` [1].

Before this patch, the KUnit Rust doctests generation needed to employ
several hacks in order to retrieve doctests, modify them as needed and
then concatenate all of them in one file. In particular, it required
using two scripts: one that got run as a test builder by `rustdoc` in
order to extract the data and another that collected the results of all
those processes.

We requested upstream `rustdoc` a feature to get `rustdoc` to generate
the information directly -- one that would also be designed to eventually
be made stable. This resulted in the `--output-format=doctest` flag,
which makes all the information neatly available as a JSON output,
including filenames, line numbers, doctest test bodies and so on.

Thus take advantage of the new flag, which in turn allows to just use
a single script that gets piped that JSON output from the compiler and
uses it to directly build the generated files to be run by KUnit.

Link: https://github.com/rust-lang/rust/issues/134529 [1]
Signed-off-by: Guillaume Gomez <guillaume1.gomez@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile                   |  12 +-
 scripts/.gitignore              |   1 -
 scripts/Makefile                |   2 -
 scripts/json.rs                 | 235 +++++++++++++++++++++++++
 scripts/remove-stale-files      |   2 +
 scripts/rustdoc_test_builder.rs | 300 ++++++++++++++++++++++++++------
 scripts/rustdoc_test_gen.rs     | 265 ----------------------------
 7 files changed, 485 insertions(+), 332 deletions(-)
 create mode 100644 scripts/json.rs
 delete mode 100644 scripts/rustdoc_test_gen.rs

diff --git a/rust/Makefile b/rust/Makefile
index 23c7ae905bd2..93bc456e3576 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -57,7 +57,6 @@ RUST_LIB_SRC ?= $(rustc_sysroot)/lib/rustlib/src/rust/library
 ifneq ($(quiet),)
 rust_test_quiet=-q
 rustdoc_test_quiet=--test-args -q
-rustdoc_test_kernel_quiet=>/dev/null
 endif

 core-cfgs = \
@@ -224,21 +223,20 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) --test $(filter-out --remap-path-prefix=%,$(rust_flags)) \
+	$(RUSTDOC) $(filter-out --remap-path-prefix=%,$(rust_flags)) \
 		-L$(objtree)/$(obj) --extern ffi --extern pin_init \
 		--extern kernel --extern build_error --extern macros \
 		--extern bindings --extern uapi \
-		--no-run --crate-name kernel -Zunstable-options \
+		--crate-name kernel -Zunstable-options \
 		--sysroot=/dev/null \
+		--output-format=doctest \
 		$(rustdoc_modifiers_workaround) \
-		--test-builder $(objtree)/scripts/rustdoc_test_builder \
-		$< $(rustdoc_test_kernel_quiet); \
-	$(objtree)/scripts/rustdoc_test_gen
+		$< | $(objtree)/scripts/rustdoc_test_builder

 %/doctests_kernel_generated.rs %/doctests_kernel_generated_kunit.c: \
     $(src)/kernel/lib.rs $(obj)/kernel.o \
     $(objtree)/scripts/rustdoc_test_builder \
-    $(objtree)/scripts/rustdoc_test_gen FORCE
+    FORCE
 	+$(call if_changed,rustdoc_test_kernel)

 # We cannot use `-Zpanic-abort-tests` because some tests are dynamic,
diff --git a/scripts/.gitignore b/scripts/.gitignore
index c2ef68848da5..6e6ab7b8f496 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -7,7 +7,6 @@
 /module.lds
 /recordmcount
 /rustdoc_test_builder
-/rustdoc_test_gen
 /sign-file
 /sorttable
 /target.json
diff --git a/scripts/Makefile b/scripts/Makefile
index 46f860529df5..71c7d9dcd95b 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -10,7 +10,6 @@ hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
-hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen

 ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 always-$(CONFIG_RUST)					+= target.json
@@ -23,7 +22,6 @@ endif
 hostprogs += generate_rust_target
 generate_rust_target-rust := y
 rustdoc_test_builder-rust := y
-rustdoc_test_gen-rust := y

 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
diff --git a/scripts/json.rs b/scripts/json.rs
new file mode 100644
index 000000000000..aff24bfd9213
--- /dev/null
+++ b/scripts/json.rs
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! JSON parser used to parse rustdoc output when retrieving doctests.
+
+use std::collections::HashMap;
+use std::iter::Peekable;
+use std::str::FromStr;
+
+#[derive(Debug, PartialEq, Eq)]
+pub(crate) enum JsonValue {
+    Object(HashMap<String, JsonValue>),
+    String(String),
+    Number(i32),
+    Bool(bool),
+    Array(Vec<JsonValue>),
+    Null,
+}
+
+fn parse_ident<I: Iterator<Item = char>>(
+    iter: &mut I,
+    output: JsonValue,
+    ident: &str,
+) -> Result<JsonValue, String> {
+    let mut ident_iter = ident.chars().skip(1);
+
+    loop {
+        let i = ident_iter.next();
+        if i.is_none() {
+            return Ok(output);
+        }
+        let c = iter.next();
+        if i != c {
+            if let Some(c) = c {
+                return Err(format!("Unexpected character `{c}` when parsing `{ident}`"));
+            }
+            return Err(format!("Missing character when parsing `{ident}`"));
+        }
+    }
+}
+
+fn parse_string<I: Iterator<Item = char>>(iter: &mut I) -> Result<JsonValue, String> {
+    let mut out = String::new();
+
+    while let Some(c) = iter.next() {
+        match c {
+            '\\' => {
+                let Some(c) = iter.next() else { break };
+                match c {
+                    '"' | '\\' | '/' => out.push(c),
+                    'b' => out.push(char::from(0x8u8)),
+                    'f' => out.push(char::from(0xCu8)),
+                    't' => out.push('\t'),
+                    'r' => out.push('\r'),
+                    'n' => out.push('\n'),
+                    _ => {
+                        // This code doesn't handle codepoints so we put the string content as is.
+                        out.push('\\');
+                        out.push(c);
+                    }
+                }
+            }
+            '"' => {
+                return Ok(JsonValue::String(out));
+            }
+            _ => out.push(c),
+        }
+    }
+    Err(format!("Unclosed JSON string `{out}`"))
+}
+
+fn parse_number<I: Iterator<Item = char>>(
+    iter: &mut Peekable<I>,
+    digit: char,
+) -> Result<JsonValue, String> {
+    let mut nb = String::new();
+
+    nb.push(digit);
+    loop {
+        // We peek next character to prevent taking it from the iterator in case it's a comma.
+        if matches!(iter.peek(), Some(',' | '}' | ']')) {
+            break;
+        }
+        let Some(c) = iter.next() else { break };
+        if c.is_whitespace() {
+            break;
+        } else if !c.is_ascii_digit() {
+            return Err(format!("Error when parsing number `{nb}`: found `{c}`"));
+        }
+        nb.push(c);
+    }
+    i32::from_str(&nb)
+        .map(|nb| JsonValue::Number(nb))
+        .map_err(|error| format!("Invalid number: `{error}`"))
+}
+
+fn parse_array<I: Iterator<Item = char>>(iter: &mut Peekable<I>) -> Result<JsonValue, String> {
+    let mut values = Vec::new();
+
+    'main: loop {
+        let Some(c) = iter.next() else {
+            return Err("Unclosed array".to_string());
+        };
+        if c.is_whitespace() {
+            continue;
+        } else if c == ']' {
+            break;
+        }
+        values.push(parse(iter, c)?);
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c == ',' {
+                break;
+            } else if c == ']' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"));
+            }
+        }
+    }
+    Ok(JsonValue::Array(values))
+}
+
+fn parse_object<I: Iterator<Item = char>>(iter: &mut Peekable<I>) -> Result<JsonValue, String> {
+    let mut values = HashMap::new();
+
+    'main: loop {
+        let Some(c) = iter.next() else {
+            return Err("Unclosed object".to_string());
+        };
+        let key;
+        if c.is_whitespace() {
+            continue;
+        } else if c == '"' {
+            let JsonValue::String(k) = parse_string(iter)? else {
+                unreachable!()
+            };
+            key = k;
+        } else if c == '}' {
+            break;
+        } else {
+            return Err(format!("Expected `\"` when parsing Object, found `{c}`"));
+        }
+
+        // We then get the `:` separator.
+        loop {
+            let Some(c) = iter.next() else {
+                return Err(format!("Missing value after key `{key}`"));
+            };
+            if c.is_whitespace() {
+                continue;
+            } else if c == ':' {
+                break;
+            } else {
+                return Err(format!(
+                    "Expected `:` after key, found `{c}` when parsing object"
+                ));
+            }
+        }
+        // Then the value.
+        let value = loop {
+            let Some(c) = iter.next() else {
+                return Err(format!("Missing value after key `{key}`"));
+            };
+            if c.is_whitespace() {
+                continue;
+            } else {
+                break parse(iter, c)?;
+            }
+        };
+
+        if values.contains_key(&key) {
+            return Err(format!("Duplicated key `{key}`"));
+        }
+        values.insert(key, value);
+
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else if c == ',' {
+                break;
+            } else if c == '}' {
+                break 'main;
+            } else {
+                return Err(format!("Unexpected `{c}` when parsing array"));
+            }
+        }
+    }
+    Ok(JsonValue::Object(values))
+}
+
+fn parse<I: Iterator<Item = char>>(iter: &mut Peekable<I>, c: char) -> Result<JsonValue, String> {
+    match c {
+        '{' => parse_object(iter),
+        '"' => parse_string(iter),
+        '[' => parse_array(iter),
+        't' => parse_ident(iter, JsonValue::Bool(true), "true"),
+        'f' => parse_ident(iter, JsonValue::Bool(false), "false"),
+        'n' => parse_ident(iter, JsonValue::Null, "null"),
+        c => {
+            if c.is_ascii_digit() || c == '-' {
+                parse_number(iter, c)
+            } else {
+                Err(format!("Unexpected `{c}` character"))
+            }
+        }
+    }
+}
+
+impl JsonValue {
+    pub(crate) fn parse(input: &str) -> Result<Self, String> {
+        let mut iter = input.chars().peekable();
+        let mut value = None;
+
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            }
+            value = Some(parse(&mut iter, c)?);
+            break;
+        }
+        while let Some(c) = iter.next() {
+            if c.is_whitespace() {
+                continue;
+            } else {
+                return Err(format!("Unexpected character `{c}` after content"));
+            }
+        }
+        if let Some(value) = value {
+            Ok(value)
+        } else {
+            Err("Empty content".to_string())
+        }
+    }
+}
diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index 6e39fa8540df..190dee6b50e8 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -26,3 +26,5 @@ rm -f scripts/selinux/genheaders/genheaders
 rm -f *.spec

 rm -f lib/test_fortify.log
+
+rm -f scripts/rustdoc_test_gen
diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder.rs
index f7540bcf595a..dd65bb670d25 100644
--- a/scripts/rustdoc_test_builder.rs
+++ b/scripts/rustdoc_test_builder.rs
@@ -1,74 +1,260 @@
 // SPDX-License-Identifier: GPL-2.0

-//! Test builder for `rustdoc`-generated tests.
+//! Generates KUnit tests from `rustdoc`-generated doctests.
 //!
-//! This script is a hack to extract the test from `rustdoc`'s output. Ideally, `rustdoc` would
-//! have an option to generate this information instead, e.g. as JSON output.
+//! KUnit passes a context (`struct kunit *`) to each test, which should be forwarded to the other
+//! KUnit functions and macros.
 //!
-//! The `rustdoc`-generated test names look like `{file}_{line}_{number}`, e.g.
-//! `...path_rust_kernel_sync_arc_rs_42_0`. `number` is the "test number", needed in cases like
-//! a macro that expands into items with doctests is invoked several times within the same line.
+//! However, we want to keep this as an implementation detail because:
 //!
-//! However, since these names are used for bisection in CI, the line number makes it not stable
-//! at all. In the future, we would like `rustdoc` to give us the Rust item path associated with
-//! the test, plus a "test number" (for cases with several examples per item) and generate a name
-//! from that. For the moment, we generate ourselves a new name, `{file}_{number}` instead, in
-//! the `gen` script (done there since we need to be aware of all the tests in a given file).
+//!   - Test code should not care about the implementation.
+//!
+//!   - Documentation looks worse if it needs to carry extra details unrelated to the piece
+//!     being described.
+//!
+//!   - Test code should be able to define functions and call them, without having to carry
+//!     the context.
+//!
+//!   - Later on, we may want to be able to test non-kernel code (e.g. `core` or third-party
+//!     crates) which likely use the standard library `assert*!` macros.
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

-use std::io::Read;
+use std::{
+    fs::File,
+    io::{BufWriter, Read, Write},
+};
+
+use json::JsonValue;
+
+mod json;

 fn main() {
     let mut stdin = std::io::stdin().lock();
-    let mut body = String::new();
-    stdin.read_to_string(&mut body).unwrap();
+    let mut rustdoc_json = String::new();
+    stdin.read_to_string(&mut rustdoc_json).unwrap();

-    // Find the generated function name looking for the inner function inside `main()`.
-    //
-    // The line we are looking for looks like one of the following:
-    //
-    // ```
-    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_28_0() {
-    // fn main() { #[allow(non_snake_case)] fn _doctest_main_rust_kernel_file_rs_37_0() -> Result<(), impl ::core::fmt::Debug> {
-    // ```
-    //
-    // It should be unlikely that doctest code matches such lines (when code is formatted properly).
-    let rustdoc_function_name = body
-        .lines()
-        .find_map(|line| {
-            Some(
-                line.split_once("fn main() {")?
-                    .1
-                    .split_once("fn ")?
-                    .1
-                    .split_once("()")?
-                    .0,
-            )
-            .filter(|x| x.chars().all(|c| c.is_alphanumeric() || c == '_'))
-        })
-        .expect("No test function found in `rustdoc`'s output.");
-
-    // Qualify `Result` to avoid the collision with our own `Result` coming from the prelude.
-    let body = body.replace(
-        &format!("{rustdoc_function_name}() -> Result<(), impl ::core::fmt::Debug> {{"),
-        &format!(
-            "{rustdoc_function_name}() -> ::core::result::Result<(), impl ::core::fmt::Debug> {{"
-        ),
+    let JsonValue::Object(rustdoc) = JsonValue::parse(&rustdoc_json).unwrap() else {
+        panic!("Expected an object")
+    };
+
+    let Some(JsonValue::Number(format_version)) = rustdoc.get("format_version") else {
+        panic!("missing `format_version` field");
+    };
+    assert!(
+        *format_version == 2,
+        "unsupported rustdoc format version: {format_version}"
     );

-    // For tests that get generated with `Result`, like above, `rustdoc` generates an `unwrap()` on
-    // the return value to check there were no returned errors. Instead, we use our assert macro
-    // since we want to just fail the test, not panic the kernel.
+    let Some(JsonValue::Array(doctests)) = rustdoc.get("doctests") else {
+        panic!("`doctests` field is missing or has the wrong type");
+    };
+
+    let mut nb_generated = 0;
+    let mut number = 0;
+    let mut last_file = "";
+    let mut rust_tests = String::new();
+    let mut c_test_declarations = String::new();
+    let mut c_test_cases = String::new();
+    for doctest in doctests {
+        let JsonValue::Object(doctest) = doctest else {
+            unreachable!()
+        };
+
+        // We check if we need to skip this test by checking it's a rust code and it's not ignored.
+        if let Some(JsonValue::Object(attributes)) = doctest.get("doctest_attributes") {
+            if attributes.get("rust") != Some(&JsonValue::Bool(true)) {
+                continue;
+            }
+            if let Some(JsonValue::String(ignore)) = attributes.get("ignore") {
+                if ignore != "None" {
+                    continue;
+                }
+            }
+        }
+
+        let (
+            Some(JsonValue::String(file)),
+            Some(JsonValue::Number(line)),
+            Some(JsonValue::String(name)),
+            Some(JsonValue::Object(doctest_code)),
+        ) = (
+            doctest.get("file"),
+            doctest.get("line"),
+            doctest.get("name"),
+            doctest.get("doctest_code"),
+        )
+        else {
+            continue;
+        };
+
+        let (
+            Some(JsonValue::String(code)),
+            Some(JsonValue::String(crate_level_code)),
+            Some(JsonValue::Object(wrapper)),
+        ) = (
+            doctest_code.get("code"),
+            doctest_code.get("crate_level"),
+            doctest_code.get("wrapper"),
+        )
+        else {
+            continue;
+        };
+
+        let (Some(JsonValue::String(before)), Some(JsonValue::String(after))) =
+            (wrapper.get("before"), wrapper.get("after"))
+        else {
+            continue;
+        };
+
+        // For tests that get generated with `Result`, `rustdoc` generates an `unwrap()` on
+        // the return value to check there were no returned errors. Instead, we use our assert macro
+        // since we want to just fail the test, not panic the kernel.
+        //
+        // We save the result in a variable so that the failed assertion message looks nicer.
+        let after = if let Some(JsonValue::Bool(true)) = wrapper.get("returns_result") {
+            "\n} let test_return_value = _inner(); assert!(test_return_value.is_ok()); }"
+        } else {
+            after.as_str()
+        };
+
+        let body = format!("{crate_level_code}\n{before}\n{code}{after}\n");
+        nb_generated += 1;
+
+        // Generate an ID sequence ("test number") for each one in the file.
+        if file == last_file {
+            number += 1;
+        } else {
+            number = 0;
+            last_file = file;
+        }
+
+        // Generate a KUnit name (i.e. test name and C symbol) for this test.
+        //
+        // We avoid the line number, like `rustdoc` does, to make things slightly more stable for
+        // bisection purposes. However, to aid developers in mapping back what test failed, we will
+        // print a diagnostics line in the KTAP report.
+        let kunit_name = format!(
+            "rust_doctest_{}_{number}",
+            file.replace('/', "_").replace('.', "_")
+        );
+
+        // Calculate how many lines before `main` function (including the `main` function line).
+        let body_offset = body
+            .lines()
+            .take_while(|line| !line.contains("fn main() {"))
+            .count()
+            + 1;
+
+        use std::fmt::Write;
+        write!(
+            rust_tests,
+            r#"/// Generated `{name}` KUnit test case from a Rust documentation test.
+#[no_mangle]
+pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
+    /// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
+    #[allow(unused)]
+    macro_rules! assert {{
+        ($cond:expr $(,)?) => {{{{
+            ::kernel::kunit_assert!(
+                "{kunit_name}", "{file}", __DOCTEST_ANCHOR - {line}, $cond
+            );
+        }}}}
+    }}
+
+    /// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
+    #[allow(unused)]
+    macro_rules! assert_eq {{
+        ($left:expr, $right:expr $(,)?) => {{{{
+            ::kernel::kunit_assert_eq!(
+                "{kunit_name}", "{file}", __DOCTEST_ANCHOR - {line}, $left, $right
+            );
+        }}}}
+    }}
+
+    // Many tests need the prelude, so provide it by default.
+    #[allow(unused)]
+    use ::kernel::prelude::*;
+
+    // Unconditionally print the location of the original doctest (i.e. rather than the location in
+    // the generated file) so that developers can easily map the test back to the source code.
     //
-    // We save the result in a variable so that the failed assertion message looks nicer.
-    let body = body.replace(
-        &format!("}} {rustdoc_function_name}().unwrap() }}"),
-        &format!("}} let test_return_value = {rustdoc_function_name}(); assert!(test_return_value.is_ok()); }}"),
-    );
+    // This information is also printed when assertions fail, but this helps in the successful cases
+    // when the user is running KUnit manually, or when passing `--raw_output` to `kunit.py`.
+    //
+    // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
+    // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
+    // easier later on.
+    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {file}:{line}\n"));
+
+    /// The anchor where the test code body starts.
+    #[allow(unused)]
+    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
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
+    if nb_generated == 0 {
+        panic!("No test function found in `rustdoc`'s output.");
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

-    // Figure out a smaller test name based on the generated function name.
-    let name = rustdoc_function_name.split_once("_rust_kernel_").unwrap().1;
+static struct kunit_suite test_suite = {{
+    .name = "rust_doctests_kernel",
+    .test_cases = test_cases,
+}};

-    let path = format!("rust/test/doctests/kernel/{name}");
+kunit_test_suite(test_suite);

-    std::fs::write(path, body.as_bytes()).unwrap();
+MODULE_LICENSE("GPL");
+"#
+    )
+    .unwrap();
 }
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
deleted file mode 100644
index c8f9dc2ab976..000000000000
--- a/scripts/rustdoc_test_gen.rs
+++ /dev/null
@@ -1,265 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Generates KUnit tests from saved `rustdoc`-generated tests.
-//!
-//! KUnit passes a context (`struct kunit *`) to each test, which should be forwarded to the other
-//! KUnit functions and macros.
-//!
-//! However, we want to keep this as an implementation detail because:
-//!
-//!   - Test code should not care about the implementation.
-//!
-//!   - Documentation looks worse if it needs to carry extra details unrelated to the piece
-//!     being described.
-//!
-//!   - Test code should be able to define functions and call them, without having to carry
-//!     the context.
-//!
-//!   - Later on, we may want to be able to test non-kernel code (e.g. `core` or third-party
-//!     crates) which likely use the standard library `assert*!` macros.
-//!
-//! For this reason, instead of the passed context, `kunit_get_current_test()` is used instead
-//! (i.e. `current->kunit_test`).
-//!
-//! Note that this means other threads/tasks potentially spawned by a given test, if failing, will
-//! report the failure in the kernel log but will not fail the actual test. Saving the pointer in
-//! e.g. a `static` per test does not fully solve the issue either, because currently KUnit does
-//! not support assertions (only expectations) from other tasks. Thus leave that feature for
-//! the future, which simplifies the code here too. We could also simply not allow `assert`s in
-//! other tasks, but that seems overly constraining, and we do want to support them, eventually.
-
-use std::{
-    fs,
-    fs::File,
-    io::{BufWriter, Read, Write},
-    path::{Path, PathBuf},
-};
-
-/// Find the real path to the original file based on the `file` portion of the test name.
-///
-/// `rustdoc` generated `file`s look like `sync_locked_by_rs`. Underscores (except the last one)
-/// may represent an actual underscore in a directory/file, or a path separator. Thus the actual
-/// file might be `sync_locked_by.rs`, `sync/locked_by.rs`, `sync_locked/by.rs` or
-/// `sync/locked/by.rs`. This function walks the file system to determine which is the real one.
-///
-/// This does require that ambiguities do not exist, but that seems fair, especially since this is
-/// all supposed to be temporary until `rustdoc` gives us proper metadata to build this. If such
-/// ambiguities are detected, they are diagnosed and the script panics.
-fn find_real_path<'a>(srctree: &Path, valid_paths: &'a mut Vec<PathBuf>, file: &str) -> &'a str {
-    valid_paths.clear();
-
-    let potential_components: Vec<&str> = file.strip_suffix("_rs").unwrap().split('_').collect();
-
-    find_candidates(srctree, valid_paths, Path::new(""), &potential_components);
-    fn find_candidates(
-        srctree: &Path,
-        valid_paths: &mut Vec<PathBuf>,
-        prefix: &Path,
-        potential_components: &[&str],
-    ) {
-        // The base case: check whether all the potential components left, joined by underscores,
-        // is a file.
-        let joined_potential_components = potential_components.join("_") + ".rs";
-        if srctree
-            .join("rust/kernel")
-            .join(prefix)
-            .join(&joined_potential_components)
-            .is_file()
-        {
-            // Avoid `srctree` here in order to keep paths relative to it in the KTAP output.
-            valid_paths.push(
-                Path::new("rust/kernel")
-                    .join(prefix)
-                    .join(joined_potential_components),
-            );
-        }
-
-        // In addition, check whether each component prefix, joined by underscores, is a directory.
-        // If not, there is no need to check for combinations with that prefix.
-        for i in 1..potential_components.len() {
-            let (components_prefix, components_rest) = potential_components.split_at(i);
-            let prefix = prefix.join(components_prefix.join("_"));
-            if srctree.join("rust/kernel").join(&prefix).is_dir() {
-                find_candidates(srctree, valid_paths, &prefix, components_rest);
-            }
-        }
-    }
-
-    match valid_paths.as_slice() {
-        [] => panic!(
-            "No path candidates found for `{file}`. This is likely a bug in the build system, or \
-            some files went away while compiling."
-        ),
-        [valid_path] => valid_path.to_str().unwrap(),
-        valid_paths => {
-            use std::fmt::Write;
-
-            let mut candidates = String::new();
-            for path in valid_paths {
-                writeln!(&mut candidates, "    {path:?}").unwrap();
-            }
-            panic!(
-                "Several path candidates found for `{file}`, please resolve the ambiguity by \
-                renaming a file or folder. Candidates:\n{candidates}",
-            );
-        }
-    }
-}
-
-fn main() {
-    let srctree = std::env::var("srctree").unwrap();
-    let srctree = Path::new(&srctree);
-
-    let mut paths = fs::read_dir("rust/test/doctests/kernel")
-        .unwrap()
-        .map(|entry| entry.unwrap().path())
-        .collect::<Vec<_>>();
-
-    // Sort paths.
-    paths.sort();
-
-    let mut rust_tests = String::new();
-    let mut c_test_declarations = String::new();
-    let mut c_test_cases = String::new();
-    let mut body = String::new();
-    let mut last_file = String::new();
-    let mut number = 0;
-    let mut valid_paths: Vec<PathBuf> = Vec::new();
-    let mut real_path: &str = "";
-    for path in paths {
-        // The `name` follows the `{file}_{line}_{number}` pattern (see description in
-        // `scripts/rustdoc_test_builder.rs`). Discard the `number`.
-        let name = path.file_name().unwrap().to_str().unwrap().to_string();
-
-        // Extract the `file` and the `line`, discarding the `number`.
-        let (file, line) = name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
-
-        // Generate an ID sequence ("test number") for each one in the file.
-        if file == last_file {
-            number += 1;
-        } else {
-            number = 0;
-            last_file = file.to_string();
-
-            // Figure out the real path, only once per file.
-            real_path = find_real_path(srctree, &mut valid_paths, file);
-        }
-
-        // Generate a KUnit name (i.e. test name and C symbol) for this test.
-        //
-        // We avoid the line number, like `rustdoc` does, to make things slightly more stable for
-        // bisection purposes. However, to aid developers in mapping back what test failed, we will
-        // print a diagnostics line in the KTAP report.
-        let kunit_name = format!("rust_doctest_kernel_{file}_{number}");
-
-        // Read the test's text contents to dump it below.
-        body.clear();
-        File::open(path).unwrap().read_to_string(&mut body).unwrap();
-
-        // Calculate how many lines before `main` function (including the `main` function line).
-        let body_offset = body
-            .lines()
-            .take_while(|line| !line.contains("fn main() {"))
-            .count()
-            + 1;
-
-        use std::fmt::Write;
-        write!(
-            rust_tests,
-            r#"/// Generated `{name}` KUnit test case from a Rust documentation test.
-#[no_mangle]
-pub extern "C" fn {kunit_name}(__kunit_test: *mut ::kernel::bindings::kunit) {{
-    /// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
-    #[allow(unused)]
-    macro_rules! assert {{
-        ($cond:expr $(,)?) => {{{{
-            ::kernel::kunit_assert!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $cond
-            );
-        }}}}
-    }}
-
-    /// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
-    #[allow(unused)]
-    macro_rules! assert_eq {{
-        ($left:expr, $right:expr $(,)?) => {{{{
-            ::kernel::kunit_assert_eq!(
-                "{kunit_name}", "{real_path}", __DOCTEST_ANCHOR - {line}, $left, $right
-            );
-        }}}}
-    }}
-
-    // Many tests need the prelude, so provide it by default.
-    #[allow(unused)]
-    use ::kernel::prelude::*;
-
-    // Unconditionally print the location of the original doctest (i.e. rather than the location in
-    // the generated file) so that developers can easily map the test back to the source code.
-    //
-    // This information is also printed when assertions fail, but this helps in the successful cases
-    // when the user is running KUnit manually, or when passing `--raw_output` to `kunit.py`.
-    //
-    // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
-    // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
-    // easier later on.
-    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
-
-    /// The anchor where the test code body starts.
-    #[allow(unused)]
-    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
-    {{
-        {body}
-        main();
-    }}
-}}
-
-"#
-        )
-        .unwrap();
-
-        write!(c_test_declarations, "void {kunit_name}(struct kunit *);\n").unwrap();
-        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap();
-    }
-
-    let rust_tests = rust_tests.trim();
-    let c_test_declarations = c_test_declarations.trim();
-    let c_test_cases = c_test_cases.trim();
-
-    write!(
-        BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
-        r#"//! `kernel` crate documentation tests.
-
-const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
-
-{rust_tests}
-"#
-    )
-    .unwrap();
-
-    write!(
-        BufWriter::new(File::create("rust/doctests_kernel_generated_kunit.c").unwrap()),
-        r#"/*
- * `kernel` crate documentation tests.
- */
-
-#include <kunit/test.h>
-
-{c_test_declarations}
-
-static struct kunit_case test_cases[] = {{
-    {c_test_cases}
-    {{ }}
-}};
-
-static struct kunit_suite test_suite = {{
-    .name = "rust_doctests_kernel",
-    .test_cases = test_cases,
-}};
-
-kunit_test_suite(test_suite);
-
-MODULE_LICENSE("GPL");
-"#
-    )
-    .unwrap();
-}

base-commit: 0d97f2067c166eb495771fede9f7b73999c67f66
--
2.51.0

