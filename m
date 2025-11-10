Return-Path: <linux-kselftest+bounces-45219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA553C464CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 460993480C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569863093D8;
	Mon, 10 Nov 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EayCZC8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8E3081C5;
	Mon, 10 Nov 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774550; cv=none; b=nFk1CHUm1t1TWGceLgghGxzhwgZ/up42ABVH04Wy5si+MGuj4W7ICvhrwgtM0q5BibF34U5kKflwuR/eOxfn+lACI+uT1lko0ZmMzjxJCLVRYxtFlHAf13YNxe6m3nvSYFJa4gS+JHX+1ojyJZjNM/RiFls8nFoawKFpWs7fnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774550; c=relaxed/simple;
	bh=tfPkJpL+aB+8sFcfxxCCqoXe/9nLFGDcyl5TPFG8KC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjTPZGpIbgVx6+r92jN/aoFQUa1TfWlShlSJJnLxImJEn3NoBL+ZFJsELy/5aCHbcWLgOmPowQ703/Wud6Gpr0N1mOJZTaq/cLQiUzwsBhEowi3nis1yaErGLtxcp1/NY6sCGIyM/Cx3MonovToC98lEdrLEIPJFcoFy7TW5D4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EayCZC8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07132C116B1;
	Mon, 10 Nov 2025 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774546;
	bh=tfPkJpL+aB+8sFcfxxCCqoXe/9nLFGDcyl5TPFG8KC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EayCZC8ULJyxXRl8iT6e8aCFzY7CSCrl34MEdw/Z7CDqCitIOdrJrgz80MQ5yM1GK
	 MMkRUK2sQMNVTzlSuTV6u0hpU7cbPXEYLO/qr7gKL6gI+mgHj3Jmw7gTm6+LbQ7Yza
	 Nht9YUwxSLNlkcqioXTHDSZStxEq4wQP4lLy9+c/547gag7RUpiRvVgzx2A95LnuSU
	 KFdvDNg9W/wZoJ7sMKAh25aM05qt8cN7YfKFkQw7sdnVAuauErsQqYWUDqNSG6S/Kv
	 iez6PAIsacQUgYDHZYSLjSVpJucwp8MfCo1W6xp1DNCPNupk3BVqjEUEYqmtWq1rV1
	 WYKnH7WlDNZPQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 2/2] rust: device: make example buildable
Date: Mon, 10 Nov 2025 12:35:28 +0100
Message-ID: <20251110113528.1658238-2-ojeda@kernel.org>
In-Reply-To: <20251110113528.1658238-1-ojeda@kernel.org>
References: <20251110113528.1658238-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This example can easily be made buildable, thus do so.

It would have triggered an `unreachable_pub` warning without the previous
commit.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/device.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index a849b7dde2fd..d00f4af507db 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -67,7 +67,16 @@
 ///
 /// A bus specific device should be defined as follows.
 ///
-/// ```ignore
+/// ```
+/// # use core::marker::PhantomData;
+/// # use kernel::{
+/// #     device,
+/// #     types::Opaque, //
+/// # };
+/// # mod bindings {
+/// #     #[expect(non_camel_case_types)]
+/// #     pub struct bus_device_type;
+/// # }
 /// #[repr(transparent)]
 /// pub struct Device<Ctx: device::DeviceContext = device::Normal>(
 ///     Opaque<bindings::bus_device_type>,
-- 
2.51.2


