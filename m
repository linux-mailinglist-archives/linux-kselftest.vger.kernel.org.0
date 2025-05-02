Return-Path: <linux-kselftest+bounces-32228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99BAA7B92
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B37D18924E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAB2135B9;
	Fri,  2 May 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb1JuoYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F57211276;
	Fri,  2 May 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222708; cv=none; b=nUUO8FxbBKNm57+n9ldo7ud1OEvoCNWDZUVpKqDlXT/efOZbvYua+1o+8eHBvThPyEZZmremZLPHjCSY94YxaBBj7EvQVGkZAjlLffiOXPdRMweJD3BjoqUZTT+eS0GF5ekvtaivnHxQnvR93ncboYijCo/0rw7IAJ1wbDzmrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222708; c=relaxed/simple;
	bh=Fo/4cY/h3GvmA3zO6jclmLkwEdMV0ZBDksm5s1DKwPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btdYD9YUGYIT0udOvPNGDkAqe8qEKWn/eNxAegSdzLeCjvtvlB4pz8GNoysWtqUXpVlj4fCIyjybhSHwziEhrFEob8HXx4FWMI6HTO3VBPoKRe8ex5JnxjTkiYRb3DzLiENfH4j2mgp2lA4qrTXVwFiV37jTnqnuehAwUxNwrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb1JuoYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06292C4CEED;
	Fri,  2 May 2025 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222708;
	bh=Fo/4cY/h3GvmA3zO6jclmLkwEdMV0ZBDksm5s1DKwPk=;
	h=From:To:Cc:Subject:Date:From;
	b=Eb1JuoYWRHzLob+ECoIY41s36dHljuiKyKVggSYRWHwNJhW1hmaGU+0VLpRYZGlW1
	 PeOEfovxIQMxPmnyux7TMHtGiKAd4yC78VM0PUdy7v9dhSlW6US44I0l+/Im/ev1Lq
	 aeZ9B0aOExdK9OFUKwhm7wIKJa3khrYHXllXM8uVASkVHwW9zdDz4/5i5ToBPlYRYw
	 1vhbls6ikTY5ALCoCbELh46oWdVKZ8ytKbFZ+StvKaff9OuMElLMtxsztNWSIcP8xs
	 ljZQFpFCD5HuyQacGEI/gvG5D/QnxFjpAeLIvX7rEWLTmHSl7NisOOXSGgFJc251eC
	 7pUEeYFiLL0Ew==
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
Subject: [PATCH 0/7] Rust KUnit `#[test]` support improvements
Date: Fri,  2 May 2025 23:51:25 +0200
Message-ID: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improvements that build on top of the very basic `#[test]` support merged in
v6.15.

They are fairly minimal changes, but they allow us to map `assert*!`s back to
KUnit, plus to add support for test functions that return `Result`s.

In essence, they get our `#[test]`s essentially on par with the documentation
tests.

I also took the chance to convert some host `#[test]`s we had to KUnit in order
to showcase the feature.

Finally, I added documentation that was lacking from the original submission.

I hope this helps.

Miguel Ojeda (7):
  rust: kunit: support KUnit-mapped `assert!` macros in `#[test]`s
  rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
  rust: add `kunit_tests` to the prelude
  rust: str: convert `rusttest` tests into KUnit
  rust: str: take advantage of the `-> Result` support in KUnit
    `#[test]`'s
  Documentation: rust: rename `#[test]`s to "`rusttest` host tests"
  Documentation: rust: testing: add docs on the new KUnit `#[test]`
    tests

 Documentation/rust/testing.rst | 80 ++++++++++++++++++++++++++++++++--
 init/Kconfig                   |  3 ++
 rust/Makefile                  |  3 +-
 rust/kernel/kunit.rs           | 29 ++++++++++--
 rust/kernel/prelude.rs         |  2 +-
 rust/kernel/str.rs             | 76 ++++++++++++++------------------
 rust/macros/helpers.rs         | 16 +++++++
 rust/macros/kunit.rs           | 31 ++++++++++++-
 rust/macros/lib.rs             |  6 ++-
 9 files changed, 191 insertions(+), 55 deletions(-)


base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
--
2.49.0

