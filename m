Return-Path: <linux-kselftest+bounces-32236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5469AA7BAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2804E207F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09B219EA5;
	Fri,  2 May 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ueoh3jGQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE51212FBF;
	Fri,  2 May 2025 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222742; cv=none; b=nJrlyMx9N8q5CGpM2aGl7hlX6tQSW87R394OW4l/Hyo44YNQwBuPSdqM/g0H/NjgNfVaqsM/2X4zXNSRQzXVHmj6Tw094lFC2f9Wx/z38Pa9a9kSKEIgGVMy9bqWxSUmPrJobKY8sVm8d/NXMDIDuew79pGS5K67qhS/luMYezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222742; c=relaxed/simple;
	bh=0d+B6C4f5BhKibcwQvvX7AE1XP/6ykd4eiWYjI558WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq4q+dDij1x1ilL8qVPpGxwPLLfQu3WXMaUuY4RDM2iK1ZR+arNWlGbCXYMZgjxUnm86eBYn0WuVrJHJ68wGgSQq0N57ZpN0JakKha0BqE7QvWL1kKlZ6wwxss1mAaQxxrEdEMFrB7SxM3xJSmt2CJJGNDj1Yj9z8JxNTht1lnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ueoh3jGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCFEC4CEEB;
	Fri,  2 May 2025 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222740;
	bh=0d+B6C4f5BhKibcwQvvX7AE1XP/6ykd4eiWYjI558WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ueoh3jGQfdluiir5m9D+KAT0kCQ1LZDyRlD89g7UZTWIvS6/pC7RbnsMNMEqu/S1R
	 +I5+SO2EsYPlgBsnUKBSoPQHaCyFX0hBRFOGnQkRShOv/7jss6xnMjtpk5qUCzLO4m
	 0oia8FpH9TBUl9PPc8u1dVTSbDp8gAzZqZzwSayWu+h0S5o9jBcdhsSnWW8XYk5cG6
	 uDqytDKWPFiOcfEmxfM+ulVSx7L8za/KI2yH/+Dry7JvxSO/E8HoYNWfbfb4jVn1o5
	 HRUdWQo0Ad9kmCYPAG6g5zsC+1U4PTvwJ2it9VGdmdQnm5unWY9p8n+3HRLrfQOCC9
	 a72/tkdwZc84Q==
From: Miguel Ojeda <ojeda@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 7/7] Documentation: rust: testing: add docs on the new KUnit `#[test]` tests
Date: Fri,  2 May 2025 23:51:32 +0200
Message-ID: <20250502215133.1923676-8-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was no documentation yet on the KUnit-based `#[test]`s.

Thus add it now.

It includes an explanation about the `assert*!` macros being mapped to
KUnit and the support for `-> Result` introduced in these series.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/testing.rst | 71 ++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/rust/testing.rst b/Documentation/rust/testing.rst
index 6337b83815ab..f43cb77bcc69 100644
--- a/Documentation/rust/testing.rst
+++ b/Documentation/rust/testing.rst
@@ -130,6 +130,77 @@ please see:
 
 	https://rust.docs.kernel.org/kernel/error/type.Result.html#error-codes-in-c-and-rust
 
+The ``#[test]`` tests
+---------------------
+
+Additionally, there are the ``#[test]`` tests. Like for documentation tests,
+these are also fairly similar to what you would expect from userspace, and they
+are also mapped to KUnit.
+
+These tests are introduced by the ``kunit_tests`` procedural macro, which takes
+the name of the test suite as an argument.
+
+For instance, assume we want to test the function ``f`` from the documentation
+tests section. We could write, in the same file where we have our function:
+
+.. code-block:: rust
+
+	#[kunit_tests(rust_kernel_mymod)]
+	mod tests {
+	    use super::*;
+
+	    #[test]
+	    fn test_f() {
+	        assert_eq!(f(10, 20), 30);
+	    }
+	}
+
+And if we run it, the kernel log would look like::
+
+	    KTAP version 1
+	    # Subtest: rust_kernel_mymod
+	    # speed: normal
+	    1..1
+	    # test_f.speed: normal
+	    ok 1 test_f
+	ok 1 rust_kernel_mymod
+
+Like documentation tests, the ``assert!`` and ``assert_eq!`` macros are mapped
+back to KUnit and do not panic. Similarly, the
+`? <https://doc.rust-lang.org/reference/expressions/operator-expr.html#the-question-mark-operator>`_
+operator is supported, i.e. the test functions may return either nothing (i.e.
+the unit type ``()``) or ``Result`` (i.e. any ``Result<T, E>``). For instance:
+
+.. code-block:: rust
+
+	#[kunit_tests(rust_kernel_mymod)]
+	mod tests {
+	    use super::*;
+
+	    #[test]
+	    fn test_g() -> Result {
+	        let x = g()?;
+	        assert_eq!(x, 30);
+	        Ok(())
+	    }
+	}
+
+If we run the test and the call to ``g`` fails, then the kernel log would show::
+
+	    KTAP version 1
+	    # Subtest: rust_kernel_mymod
+	    # speed: normal
+	    1..1
+	    # test_g: ASSERTION FAILED at rust/kernel/lib.rs:335
+	    Expected is_test_result_ok(test_g()) to be true, but is false
+	    # test_g.speed: normal
+	    not ok 1 test_g
+	not ok 1 rust_kernel_mymod
+
+If a ``#[test]`` test could be useful as an example for the user, then please
+use a documentation test instead. Even edge cases of an API, e.g. error or
+boundary cases, can be interesting to show in examples.
+
 The ``rusttest`` host tests
 ---------------------------
 
-- 
2.49.0


