Return-Path: <linux-kselftest+bounces-45228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C3C47412
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0144EA574
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA153126C5;
	Mon, 10 Nov 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQhzOK8s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3701B6CE9;
	Mon, 10 Nov 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785549; cv=none; b=bBdighcRGE4h5mFpnasZ8tZlOs9z7LErn22iJ1yp5C3MftNwkAUjHdYnc5ouSbNRIfF30yyk5HNsDORHy07Ti7ADR2eXL5gZszkJM0WzF/VUSDrrd8SFMaRwsbna8mmcUd8kqgqPDrIi6xTYT/aYl4y9hwCvexbdZqDT+A3q74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785549; c=relaxed/simple;
	bh=UfZIIURxKG02GFYs3TglXy1N8g+Xmh2JJT+tt4nBTVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qoZMNIS/UhhnlTlXIqQ8SDHsWnTn7JLwKjtkaSZtAJfNpwQtGoM1qa0EGCr2/yAqVHqrMtf/CUY6bqTR5YMM/81wj1DwGQ/vNx7MFvwvGr6kv4Zma+nCjkNdKKgJjf9Jj4GhO/KFW5B5sPQWMoWrJ47PrTQ39Bl3mXso4QMpaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQhzOK8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A28C4CEF5;
	Mon, 10 Nov 2025 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762785547;
	bh=UfZIIURxKG02GFYs3TglXy1N8g+Xmh2JJT+tt4nBTVs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=mQhzOK8s/s49v5TaSnR5d5ICY8q9ff+8mRzFyNvkAlhRdiDH3F6AhQtQexwshSaKi
	 ReveQogDQr7jLYtb388kxmjmGA+OlYUKecb/hNFXMF0lByKsKBf7bUo0Qw0ZE3mtLo
	 yesMpZIv/zK8xC17OxIG3C6Oz7xT8GPHz6TkYTZMXVaTVjaRxBZxLShfp8uPsA47+s
	 21LnIwZ/VY0/aOCk1scjaQ6wYMC1jXsEZYCelzurBdu7+T7D5ZTHyBwXu2V6SWQjpD
	 JtASMzUDzdxzdIF73xvM9RbMfNvP0K8IsjXWGuKwGkt4HAAVYCLKUdGIzdRt3iGWUu
	 xSqpJk0iMHqSg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Nov 2025 15:39:01 +0100
Message-Id: <DE53BMEA2TXG.115SFKG1ZHPB@kernel.org>
Cc: "Rae Moar" <raemoar63@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <patches@lists.linux.dev>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Alex
 Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251110113528.1658238-1-ojeda@kernel.org>
In-Reply-To: <20251110113528.1658238-1-ojeda@kernel.org>

On Mon Nov 10, 2025 at 12:35 PM CET, Miguel Ojeda wrote:
> Examples (i.e. doctests) may want to show public items such as structs,
> thus the `unreachable_pub` warning is not very helpful.
>
> Thus allow it for all doctests.
>
> In addition, remove it from the existing `expect`s we have in a couple
> doctests.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/kernel/init.rs         | 2 +-
>  rust/kernel/types.rs        | 2 +-
>  scripts/rustdoc_test_gen.rs | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)

