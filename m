Return-Path: <linux-kselftest+bounces-29041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA04A61146
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E3A3B9B6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470D201264;
	Fri, 14 Mar 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OanZg6Pw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E11FECAB;
	Fri, 14 Mar 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955311; cv=none; b=IwDoJJNztXVPi76/8nQxI/z8o3ErgkbAV6bI4eQyQ1TUdXFaTTbW+q8d5r+xHz8zkR4xGfZSojob3t5xlutnRqGWvCT+5SLzb+UcdwU+ON6BDXv9vm3VRDFQR/8KG6iSrvdA9OXiUa+UgK3Iir6FPbQpOa8wMp0olj+6MGvQWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955311; c=relaxed/simple;
	bh=rOWTqSBnOHc6IDPBsYyRsgKp+cpfeolF8QarU1TTCOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOgsgSzdlcEfu7Dx+m+Ev6yj/VxP2yWchV+4emLuXTgGoCRDo3xCxy38Fk1iIv3S7pw/CgAar4LjKZJdSIRGzX0jnCEaCCN75wC028a+KssNNgI5I1KDus2EWrXeY0qDckkE3126e63RwA4LLN8PsZAw0OXvXrO5KlNl3hEBCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OanZg6Pw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769b16d4fbso11188341cf.2;
        Fri, 14 Mar 2025 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955308; x=1742560108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x+348pV7oi6B5w9S1Eh0UBsSC3i45j8n4Uv1nPTXgY=;
        b=OanZg6Pw7OUliOFAEmVgdL4CSOfY3hoMT1BgBIrQVsTAmiG2BddGm+sGCKFBqcCcR1
         o4Rkksw60OJIx+dcX7A+Ip9VH8CZBaz/MkUq6EzJs0DnSE6uWc/dqfetZ3CvF5gmqZGN
         ca0rBWP87oVnqKK3vnlnbn+qikuISQ+sZmDHBIyb1StXQcS15bbVkG6C3BNqtz19ZebA
         Sb9diY2ifiOpHr8vu9HfYmh/DYtzt08GVLwQ9L+it8wfrg5WwPFRwHOHyhycKj5LcG6G
         C4shJB12InfuCSUUSCuXr/RA0uF8aUEuv9JvrobG4y2uXfa1Go3JExfD/yIsrF/D6/zG
         mxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955308; x=1742560108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x+348pV7oi6B5w9S1Eh0UBsSC3i45j8n4Uv1nPTXgY=;
        b=XM+QDiIf9eV+BuLlNt5YpGBOckWzZMYfWzRV/cfy6CXt/4xBz7NEQYuNibvqs+wWpl
         0azE2GXWaeg19dBu2AxSFXUIJPw/1lPQsuNZWUoyP5AQWZwSKwLLylRpRs/lzNx1FUcN
         0A1Zdac87A75VhnzmRt15j5Ap4oqY1QwocQj6H00w7RpqLFa+AANaRP0yNrunPmFMAg1
         qk9s7lknoWAlzMtKAR4SODmgt5SCtpbEdwclRRKJg9plc17UduiB81jAnNOk9lLa33nF
         YaXKxlN7NDE2x49AphBp/kVK2yn2G6bcQu79ciWH1hBmrMzNa1mENdthzZiVazd/AseB
         TBJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKJdSsBDsYDCv+Is1oDI53lMQkn/GOlRyxr8rLVBKTy45XXww33HUI2OLYvmE/AW98dWa0/4GNs6Uq@vger.kernel.org, AJvYcCUdpSju72C42Mv9w+h/I7p2AidjASLvhZpCgTuTB1GRMbn/8VFSeVo2v/Ts1jhuKCmjWDPDmUBJQG5QFnY=@vger.kernel.org, AJvYcCUmy9txlnd0PScQ18BDMBWrHmiFzEz4DGqJvZSxUL5uUAc8bDR1592iUGkM2YK1mh5GjwDgmgU9I9uT3qePJugS@vger.kernel.org, AJvYcCUoSnEkIw5boO5uBV/n034t3hSQbeoJtqF8ijtDXB/eYQXUNtbwovLvP0sAUhN9Ea39n7a/SF/J6FqvJHuSV5U=@vger.kernel.org, AJvYcCUxqFXUol98j4U54uEmEwIB2T0H0G6A0A5XaW3zJL+4SuzLG5VueA6iX01C9jP4aOF4H/g/5jPvGsj5TVZ+@vger.kernel.org, AJvYcCXM29epBdKl87nwoF+Oy0QyIQSarGpvLU4zgP3RH1uPt6YF7YfdSWKhoOCxjoq+i7nc4F76EeikcyrS@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOwLpgg9QVPs1UpjnHBx0m3QULeidP5mHgY+GttfGHlWx+awT
	Jq2fGz3Cu0pBM1tTWnDAg9tUfaMOK+9jvkxlGEQ6mjKjjn2kHJFq
X-Gm-Gg: ASbGnct+D3NmfHgVyKvb6oDEnHaCBHY4/NORq7c51L4BaQV2ZboCvdJet45jDNhmkPt
	HWuoTiq6LEgQ83UvT3KQ+H//kIbuQqGCVfIVnhHYnWq3Hz7TPT/qrEB+1jkJYMS8q+1gMqC/HxD
	0MdflA94SXR2J4yBRnuLYijh2nFIJAHF+6J6VTJ3GML3LVFb6h0CCqrCHpI9efiLgJaaAdaiJPp
	nwts3RH2hcm8VxJiH+CA5iuT5yORMk1Idd/t4VCbpIRNHT3j3IjJ/H9xkHcd6bkkJc5yTGlHxnj
	N9kpdkjjrbzDmRn99niAKfpR/k27yy2WMWUW1fvzHocszlBm/zQuAXeBwRkXaNGJk64w
X-Google-Smtp-Source: AGHT+IFOfiEw5hXuhHbVnbxveXSLeygbqDKk/XnDxUimxItj6YBy+IGtKAZGTtOKPHIEDtPeXUZvhQ==
X-Received: by 2002:a05:622a:5d4:b0:476:b783:c94b with SMTP id d75a77b69052e-476c81c33bemr26738101cf.40.1741955307511;
        Fri, 14 Mar 2025 05:28:27 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:28:10 -0400
Subject: [PATCH v3 6/6] rust: use strict provenance APIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
In-Reply-To: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Rust 1.84.0 stabilized the strict provenance APIs[1].

This patch enables the (unstable) lints `fuzzy_provenance_casts` and
`lossy_provenance_casts` (available since Rust 1.61.0[2]) and uses
strict provenance APIs where these lints triggered. The `kernel` crate
is kept backwards-compatible by introducing forwarding functions at the
root which are marked `#[allow(clippy::incompatible_msrv)]` to avoid
warnings on rustc < 1.84.0.

The discussion in the tracking Issue for strict_provenance_lints[3]
seems to be nearing resolution with the only open question being:

> do we really want two separate lints for the two directions?

which seems minor enough that this is unlikely to cause significant
churn when stabilized.

This is limited to the `kernel` crate because adding these lints in the
root `Makefile` causes `core` itself to be compiled with them, which in
turn causes warnings on the implementations of the strict provenance
APIs themselves.

Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-provenance-apis [1]
Link: https://github.com/rust-lang/rust/blob/e71f9a9a98b0faf423844bf0ba7438f29dc27d58/compiler/rustc_feature/src/unstable.rs#L605 [2]
Link: https://github.com/rust-lang/rust/issues/130351 [3]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
---
 Makefile               |  9 ++++++++-
 init/Kconfig           |  3 +++
 rust/Makefile          | 26 ++++++++++++++++++++------
 rust/kernel/alloc.rs   |  2 +-
 rust/kernel/devres.rs  |  4 ++--
 rust/kernel/io.rs      | 14 +++++++-------
 rust/kernel/lib.rs     | 20 ++++++++++++++++++++
 rust/kernel/of.rs      |  2 +-
 rust/kernel/pci.rs     |  4 ++--
 rust/kernel/str.rs     | 16 ++++++----------
 rust/kernel/uaccess.rs | 12 ++++++++----
 scripts/Makefile.build |  2 +-
 scripts/Makefile.host  |  4 ++++
 13 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index 2af40bfed9ce..bc12650783f1 100644
--- a/Makefile
+++ b/Makefile
@@ -473,6 +473,8 @@ export rust_common_flags := --edition=2021 \
 			    -Astable_features \
 			    -Dnon_ascii_idents \
 			    -Dunsafe_op_in_unsafe_fn \
+			    -Wfuzzy_provenance_casts \
+			    -Wlossy_provenance_casts \
 			    -Wmissing_docs \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
@@ -498,7 +500,7 @@ KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) \
 KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS) \
 		       -I $(srctree)/scripts/include
 KBUILD_HOSTRUSTFLAGS := $(rust_common_flags) -O -Cstrip=debuginfo \
-			-Zallow-features= $(HOSTRUSTFLAGS)
+			$(HOSTRUSTFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 KBUILD_PROCMACROLDFLAGS := $(or $(PROCMACROLDFLAGS),$(KBUILD_HOSTLDFLAGS))
@@ -870,6 +872,11 @@ KBUILD_CFLAGS += -Os
 KBUILD_RUSTFLAGS += -Copt-level=s
 endif
 
+# Lints were moved to `strict_provenance_lints` when `strict_provenance` was stabilized.
+#
+# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f888e33dd52a13d3ecb64.
+export rustc_strict_provenance_feature := $(if $(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
+
 # Always set `debug-assertions` and `overflow-checks` because their default
 # depends on `opt-level` and `debug-assertions`, respectively.
 KBUILD_RUSTFLAGS += -Cdebug-assertions=$(if $(CONFIG_RUST_DEBUG_ASSERTIONS),y,n)
diff --git a/init/Kconfig b/init/Kconfig
index 324c2886b2ea..04df2893348c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -132,6 +132,9 @@ config CC_HAS_COUNTED_BY
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 
+config RUSTC_HAS_STABLE_STRICT_PROVENANCE
+	def_bool RUSTC_VERSION >= 108400
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/Makefile b/rust/Makefile
index ea3849eb78f6..dad47bea19f3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -57,10 +57,12 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
+rustc_strict_provenance_flags = -Zcrate-attr='feature($(rustc_strict_provenance_feature))'
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
+	$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags)) $(rustc_strict_provenance_flags)) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
@@ -99,7 +101,7 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
 
 # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` should
 # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
-rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks
+rustdoc-core: private skip_flags = -Wrustdoc::unescaped_backticks $(rustc_strict_provenance_flags)
 rustdoc-core: private rustc_target_flags = $(core-cfgs)
 rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	+$(call if_changed,rustdoc)
@@ -122,6 +124,7 @@ quiet_cmd_rustc_test_library = $(RUSTC_OR_CLIPPY_QUIET) TL $<
       cmd_rustc_test_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
+		$(rustc_strict_provenance_flags) \
 		@$(objtree)/include/generated/rustc_cfg $(rustc_target_flags) \
 		--crate-type $(if $(rustc_test_library_proc),proc-macro,rlib) \
 		--out-dir $(objtree)/$(obj)/test --cfg testlib \
@@ -155,11 +158,19 @@ rusttestlib-uapi: private rustc_target_flags = --extern ffi
 rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi FORCE
 	+$(call if_changed,rustc_test_library)
 
+# `rustdoc --test` doesn't respect `-Zcrate-attr`, which means we can't use
+# `rustc_strict_provenance_flags` below. Instead we filter out those lints to avoid unknown lint
+# warnings.
+#
+# See https://github.com/rust-lang/rust/issues/138491.
+rustc_strict_provenance_lints = -Wfuzzy_provenance_casts -Wlossy_provenance_casts
+
 quiet_cmd_rustdoc_test = RUSTDOC T $<
       cmd_rustdoc_test = \
 	RUST_MODFILE=test.rs \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) --test $(rust_common_flags) \
+	$(RUSTDOC) --test \
+		$(filter-out $(rustc_strict_provenance_lints),$(rust_common_flags)) \
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) $(rustdoc_test_target_flags) \
 		$(rustdoc_test_quiet) \
@@ -171,7 +182,8 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	rm -rf $(objtree)/$(obj)/test/doctests/kernel; \
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) --test $(rust_flags) \
+	$(RUSTDOC) --test \
+		$(filter-out $(rustc_strict_provenance_lints),$(rust_flags)) \
 		-L$(objtree)/$(obj) --extern ffi --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
@@ -193,6 +205,7 @@ quiet_cmd_rustc_test = $(RUSTC_OR_CLIPPY_QUIET) T  $<
       cmd_rustc_test = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTC_OR_CLIPPY) --test $(rust_common_flags) \
+		$(rustc_strict_provenance_flags) \
 		@$(objtree)/include/generated/rustc_cfg \
 		$(rustc_target_flags) --out-dir $(objtree)/$(obj)/test \
 		-L$(objtree)/$(obj)/test \
@@ -362,6 +375,7 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
+		$(rustc_strict_provenance_flags) \
 		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
@@ -376,7 +390,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
       cmd_rustc_library = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
-		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
+		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags) $(rustc_strict_provenance_flags)) \
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
@@ -436,7 +450,7 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
 $(obj)/exports.o: private skip_gendwarfksyms = 1
 
 $(obj)/core.o: private skip_clippy = 1
-$(obj)/core.o: private skip_flags = -Wunreachable_pub
+$(obj)/core.o: private skip_flags = -Wunreachable_pub -Wlossy_provenance_casts $(rustc_strict_provenance_flags)
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index fc9c9c41cd79..59199a6da2ed 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -217,7 +217,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
 
 /// Returns a properly aligned dangling pointer from the given `layout`.
 pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
-    let ptr = layout.align() as *mut u8;
+    let ptr = crate::with_exposed_provenance_mut(layout.align());
 
     // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
     unsafe { NonNull::new_unchecked(ptr) }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 34571f992f0d..e8232bb771b2 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -64,14 +64,14 @@ struct DevresInner<T> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(kernel::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9d2aadf40edf..0a018ad7478a 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use crate::error::{code::EINVAL, Result};
-use crate::{bindings, build_assert, ffi::c_void};
+use crate::{bindings, build_assert};
 
 /// Raw representation of an MMIO region.
 ///
@@ -75,14 +75,14 @@ pub fn maxsize(&self) -> usize {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?))
 ///     }
 /// }
 ///
 /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
 ///     fn drop(&mut self) {
 ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
+///         unsafe { bindings::iounmap(kernel::with_exposed_provenance_mut(self.0.addr())); };
 ///     }
 /// }
 ///
@@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(addr as *const c_void) }
+            unsafe { bindings::$name(crate::with_exposed_provenance(addr)) }
         }
 
         /// Read IO data from a given offset.
@@ -131,7 +131,7 @@ pub fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$name(addr as *const c_void) })
+            Ok(unsafe { bindings::$name(crate::with_exposed_provenance(addr)) })
         }
     };
 }
@@ -148,7 +148,7 @@ pub fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as *mut c_void) }
+            unsafe { bindings::$name(value, crate::with_exposed_provenance_mut(addr)) }
         }
 
         /// Write IO data from a given offset.
@@ -160,7 +160,7 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
             // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$name(value, addr as *mut c_void) }
+            unsafe { bindings::$name(value, crate::with_exposed_provenance_mut(addr)) }
             Ok(())
         }
     };
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9cd6b6864739..ebf7db3ad9ee 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -25,6 +25,26 @@
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
 
+#[allow(clippy::incompatible_msrv)]
+mod strict_provenance {
+    #[doc(hidden)]
+    pub fn expose_provenance<T>(addr: *const T) -> usize {
+        addr.expose_provenance()
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
+        core::ptr::with_exposed_provenance(addr)
+    }
+
+    #[doc(hidden)]
+    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
+        core::ptr::with_exposed_provenance_mut(addr)
+    }
+}
+
+pub use strict_provenance::*;
+
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
 #[cfg(not(CONFIG_RUST))]
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..f9459694cbdc 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
     const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
 
     fn index(&self) -> usize {
-        self.0.data as usize
+        crate::expose_provenance(self.0.data)
     }
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index a925732f6c7a..bb38d83e2608 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -287,7 +287,7 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
         // `pdev` is valid by the invariants of `Device`.
         // `num` is checked for validity by a previous call to `Device::resource_len`.
         // `name` is always valid.
-        let ioptr: usize = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) } as usize;
+        let ioptr = crate::expose_provenance(unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) });
         if ioptr == 0 {
             // SAFETY:
             // `pdev` valid by the invariants of `Device`.
@@ -320,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
         // `ioptr` is valid by the safety requirements.
         // `num` is valid by the safety requirements.
         unsafe {
-            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::ffi::c_void);
+            bindings::pci_iounmap(pdev.as_raw(), crate::with_exposed_provenance_mut(ioptr));
             bindings::pci_release_region(pdev.as_raw(), num);
         }
     }
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 0b80a119d5f0..6bc6357293e4 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -692,9 +692,9 @@ fn new() -> Self {
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
         // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
-            beg: pos as usize,
-            pos: pos as usize,
-            end: end as usize,
+            beg: crate::expose_provenance(pos),
+            pos: crate::expose_provenance(pos),
+            end: crate::expose_provenance(end),
         }
     }
 
@@ -705,7 +705,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
     /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
     /// for the lifetime of the returned [`RawFormatter`].
     pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
-        let pos = buf as usize;
+        let pos = crate::expose_provenance(buf);
         // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
         // guarantees that the memory region is valid for writes.
         Self {
@@ -719,7 +719,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     ///
     /// N.B. It may point to invalid memory.
     pub(crate) fn pos(&self) -> *mut u8 {
-        self.pos as *mut u8
+        crate::with_exposed_provenance_mut(self.pos)
     }
 
     /// Returns the number of bytes written to the formatter.
@@ -741,11 +741,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
             // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
             // yet, so it is valid for write per the type invariants.
             unsafe {
-                core::ptr::copy_nonoverlapping(
-                    s.as_bytes().as_ptr(),
-                    self.pos as *mut u8,
-                    len_to_copy,
-                )
+                core::ptr::copy_nonoverlapping(s.as_bytes().as_ptr(), self.pos(), len_to_copy)
             };
         }
 
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..96393bcf6bd7 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
         }
         // SAFETY: `out_ptr` points into a mutable slice of length `len`, so we may write
         // that many bytes to it.
-        let res = unsafe { bindings::copy_from_user(out_ptr, self.ptr as *const c_void, len) };
+        let res = unsafe {
+            bindings::copy_from_user(out_ptr, crate::with_exposed_provenance(self.ptr), len)
+        };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
         let res = unsafe {
             bindings::_copy_from_user(
                 out.as_mut_ptr().cast::<c_void>(),
-                self.ptr as *const c_void,
+                crate::with_exposed_provenance(self.ptr),
                 len,
             )
         };
@@ -330,7 +332,9 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         }
         // SAFETY: `data_ptr` points into an immutable slice of length `len`, so we may read
         // that many bytes from it.
-        let res = unsafe { bindings::copy_to_user(self.ptr as *mut c_void, data_ptr, len) };
+        let res = unsafe {
+            bindings::copy_to_user(crate::with_exposed_provenance_mut(self.ptr), data_ptr, len)
+        };
         if res != 0 {
             return Err(EFAULT);
         }
@@ -357,7 +361,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
         // is a compile-time constant.
         let res = unsafe {
             bindings::_copy_to_user(
-                self.ptr as *mut c_void,
+                crate::with_exposed_provenance_mut(self.ptr),
                 (value as *const T).cast::<c_void>(),
                 len,
             )
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d11874..34575f3be0fc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -226,7 +226,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons
+rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,$(rustc_strict_provenance_feature)
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index c1dedf646a39..7e2f35bff59c 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -87,10 +87,14 @@ hostcxx_flags  = -Wp,-MMD,$(depfile) \
                  $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(target-stem).o)
 
+rust_allowed_features := $(rustc_strict_provenance_feature)
+
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
 # modules case.
 hostrust_flags = --out-dir $(dir $@) --emit=dep-info=$(depfile) \
+		 -Zallow-features=$(rust_allowed_features) \
+		 -Zcrate-attr='feature($(rust_allowed_features))' \
 		 -Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		 -Clink-args='$(call escsq,$(KBUILD_HOSTLDFLAGS))' \
                  $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \

-- 
2.48.1


