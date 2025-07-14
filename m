Return-Path: <linux-kselftest+bounces-37235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E10B03D1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C761916DF6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B3245006;
	Mon, 14 Jul 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPrC0iuc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543041DE892;
	Mon, 14 Jul 2025 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491803; cv=none; b=kxDTHSFasWh3CCvzTKqhRPUAxP6qrbK2gzSiPmB2ogjH1NnuIDGrxQz7C782Nnbk5LRKDpqrmD+JsxY0Q7FErYh+WBeqXeNefxZmDdDJgEDlnZ54mZzdVUJjkQ2sxLvSUlrrEdlxnriTU1Sn3CeDT8a+LU8CBPT59x0p+IVRVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491803; c=relaxed/simple;
	bh=0L97nO7zHcOuVigYKy/frMxIIrUYEkgLI3SYihpOnUY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=SC/gCCB6eS2nfYOnV3gy5GQCUVlV2PlQPN9mre7C8wIIt0PeQ8qTV2b0Gth+lBjcYBXvWOTeVUu6eMoEvme6Ijrz842t/Z0y9cN1/bNrzsGdqPQoCWVhZiq7o+fbZk5t3PhU6dBRNWUBwq7eMqqK3V8FDoWxZIgmd7Mx7H9Xdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPrC0iuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5252BC4CEF7;
	Mon, 14 Jul 2025 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491801;
	bh=0L97nO7zHcOuVigYKy/frMxIIrUYEkgLI3SYihpOnUY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=qPrC0iucYyymvL8G6yL+KJpjF2tnzLtMlhXYjdvtqJjXXlsGI11SJMAukM/aHPXUF
	 YOirxKN+/rWLrHxOYc2VJgFvoU1bKIRVvgOItZZZt5S3EW4U7h5HneZUG4b8uPGXGN
	 hKt1vH0moCffu/BBHCYHMoUrG+0n8wK4ssm6EDLbfRjLqPFm9mWkgHNIg5IrYLJPh5
	 mgi2f023qBhIJf+YS+/FB8ZXMAG5ZqA65wErzAk4/ikT9zJi5DIEJIT/PW5EL4CpTz
	 V1U+5mgSmOhtwmKuGX6UBQD5tLUwKGMgZHkWgOA7gyl/Wztk/DBxQUy7qiYrz/QygS
	 KZpCqhjS8yRfg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:16:35 +0200
Message-Id: <DBBQHSODN0Y3.2OS8U2NKNT9W7@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Jens
 Axboe" <axboe@kernel.dk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
To: "Tamir Duberstein" <tamird@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>

On Wed Jul 9, 2025 at 9:59 PM CEST, Tamir Duberstein wrote:
> This is series 2a/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

For nova-core, alloc and device,

	Acked-by: Danilo Krummrich <dakr@kernel.org>

