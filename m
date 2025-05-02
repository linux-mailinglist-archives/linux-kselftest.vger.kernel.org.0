Return-Path: <linux-kselftest+bounces-32235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DBAA7BAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FD69E16E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BB22F761;
	Fri,  2 May 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TynLFFOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC7215783;
	Fri,  2 May 2025 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222736; cv=none; b=mx6m+aLsimO8iYiufoddLBT8jAwYIPdQOoe+llNOOtmbDdKGUd+s3ON+9yHIK5H+x1K1ejQWAcSTA5u6ZQcoLGxIKxbwIc3XZ87uIv5GqAOiF/Wyot8Nq0KnfH4wWUkNCPkRa4eXVgp4JlJ70Q9SEJTBOXiFiXgEvPVP06baFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222736; c=relaxed/simple;
	bh=6u8yOrDSOAkZwu2NCJXzUPUic0tTjwsBIeXknGukVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7XD3US8KSFmIUKoXD4+iGxi/mStduAJbLSIuBZd57k6KHxgtLoxdhzOJqcVAmXOMfGD4M9J0oLw3fFDsDAqtlvLjEIHoX7gG6WtV6Gz8uGCd0rehVWQFaUWRwe1MyXUcYZps1QrDyh8C1+hmFkVoKrOFjGsd9T4lWYrLMnVkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TynLFFOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C04C4CEE4;
	Fri,  2 May 2025 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222735;
	bh=6u8yOrDSOAkZwu2NCJXzUPUic0tTjwsBIeXknGukVb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TynLFFOmnbtENdtWpGLKw/ZQ2MA6OBNVW2iK6YzY0r7ao2Fnmg5cOzNeci0Frxk7t
	 LGJ01IrhEfDz4hXfkIMqSnSME1ATsAHkpq3I2rpWdeWdO4Y9Zbf8JZZR49rrrLCs14
	 2aoBZNp/ibRmME2zCWzWurMy2ch11bXFgjdm0Pd3pUXMGwUS/EOEEgKijVDh4qUNQm
	 VjQAfkV5KUJzr+ht/OtPReSAP5Py+o6GQWjHLvBKbAIHif6BmBV4Pg/i2AYS8TZq+A
	 I5oScAOscmi63kOLDDRDhR5CgjBiXWB1jz+Qp17ohZvV/PufKf+DZDD/BZ7xc+8+AD
	 WcgpvN2DXDUPg==
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
Subject: [PATCH 6/7] Documentation: rust: rename `#[test]`s to "`rusttest` host tests"
Date: Fri,  2 May 2025 23:51:31 +0200
Message-ID: <20250502215133.1923676-7-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that `rusttest`s are not really used much, clarify the section of
the documentation that describes them.

In addition, free the section name for the KUnit-based `#[test]`s that
will be added afterwards. To do so, rename the section into `rusttest`
host tests.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/testing.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/rust/testing.rst b/Documentation/rust/testing.rst
index f692494f7b74..6337b83815ab 100644
--- a/Documentation/rust/testing.rst
+++ b/Documentation/rust/testing.rst
@@ -130,16 +130,17 @@ please see:
 
 	https://rust.docs.kernel.org/kernel/error/type.Result.html#error-codes-in-c-and-rust
 
-The ``#[test]`` tests
----------------------
+The ``rusttest`` host tests
+---------------------------
 
-Additionally, there are the ``#[test]`` tests. These can be run using the
-``rusttest`` Make target::
+These are userspace tests that can be built and run in the host (i.e. the one
+that performs the kernel build) using the ``rusttest`` Make target::
 
 	make LLVM=1 rusttest
 
-This requires the kernel ``.config``. It runs the ``#[test]`` tests on the host
-(currently) and thus is fairly limited in what these tests can test.
+This requires the kernel ``.config``.
+
+Currently, they are mostly used for testing the ``macros`` crate's examples.
 
 The Kselftests
 --------------
-- 
2.49.0


