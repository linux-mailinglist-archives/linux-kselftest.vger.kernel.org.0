Return-Path: <linux-kselftest+bounces-8602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FB8AC89F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 11:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AA1F247D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969A12FB18;
	Mon, 22 Apr 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfkMItuY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F26A357;
	Mon, 22 Apr 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777199; cv=none; b=Y01sCbZ2dkCWLuKleejDo3IbE4ENMsM1fj6+JLOVyX0gyNnWeluyjI7L5Wzg5CRDPuphWWEI7xrDUXaED2W1oHUHLHYohfpNKjLpw4HVw6Kxk6D5J75nR3mUAhsxlLuJpvOPK9p6Wp3V10aRyjgYPLui9YWbVKs5YEFeJ6TVxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777199; c=relaxed/simple;
	bh=h+0TdiOoBIhL8Yk6uDMcMRBFY0m2Momhy8WVqNP3frk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eP5k9eb6R735UYu4eulnIgYg+XknniG/zdALyegtGyC2shrrLxOHpBCrTHoo4CMO36g+IH286xpt2CP3jk0YX4p8H1Pwvd/EE0E1EKYeZUCXSyO+Fm83xNpfr+wLhM2H/mjcgaxmF9FJYaqYJitj8LrrV2Kb8TF5aWW68k2LcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfkMItuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8EBC2BD11;
	Mon, 22 Apr 2024 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713777198;
	bh=h+0TdiOoBIhL8Yk6uDMcMRBFY0m2Momhy8WVqNP3frk=;
	h=From:To:Cc:Subject:Date:From;
	b=hfkMItuYFVqGqwq4VadYltIuthdj7v5gWhLUfhDXfGVa/HIMXN9razQLhYRbiThlz
	 7ACC5+FyRTVUt7mEhQ3mVeyWpofHQur7EbbNgat5FwOBNntjn620iowPglbRAhWhJR
	 NqBox5hVrh9KfjdZvhojrGa7w6W4TQ0AnELUVi2ehvzL0dz0yXWd58iI6sF+hHOOGQ
	 W5BXOc4ZCqgf85QpKwQO+7nhWBWs81RiCkVRWtfs+Cb0wLqnLfiE2qZgUkc3EvcrI1
	 81jfC/t3PLZlf2lYWwAl0Z7twglj4Wr/TVo5INKhcyQnZvkyTPMOPbAw0FBb9xViFl
	 6ODxp68gvQ8gg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
Date: Mon, 22 Apr 2024 11:12:15 +0200
Message-ID: <20240422091215.526688-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KUnit tests are enabled, under very big kernel configurations
(e.g. `allyesconfig`), we can trigger a `rustdoc` ICE [1]:

      RUSTDOC TK rust/kernel/lib.rs
    error: the compiler unexpectedly panicked. this is a bug.

The reason is that this build step has a duplicated `@rustc_cfg` argument,
which contains the kernel configuration, and thus a lot of arguments. The
factor 2 happens to be enough to reach the ICE.

Thus remove the unneeded `@rustc_cfg`. By doing so, we clean up the
command and workaround the ICE.

The ICE has been fixed in the upcoming Rust 1.79 [2].

Cc: stable@vger.kernel.org
Fixes: a66d733da801 ("rust: support running Rust documentation tests as KUnit ones")
Link: https://github.com/rust-lang/rust/issues/122722 [1]
Link: https://github.com/rust-lang/rust/pull/122840 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 846e6ab9d5a9..86a125c4243c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -175,7 +175,6 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_flags) \
-		@$(objtree)/include/generated/rustc_cfg \
 		-L$(objtree)/$(obj) --extern alloc --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


