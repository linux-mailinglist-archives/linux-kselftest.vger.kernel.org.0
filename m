Return-Path: <linux-kselftest+bounces-45759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D51C64F9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72F414E1C2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B2299ABF;
	Mon, 17 Nov 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUxkpQRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98B1FDA8E;
	Mon, 17 Nov 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394746; cv=none; b=n+Y7JvXnhgRqIK8oQfB0suLag8ER5Mh8SuU3DZE9QWZKYo6aUzM/T8nekwYa30Ug2B2Tqu4DPvwbSXNtShTVMz4XhCdopcCA3u56wYOeUnmcbu6/N4vmvqX3815UKYSSgN0IEMHIaBMTGcxxIOkJ/4k4Q57V6LRz0XzAn02K4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394746; c=relaxed/simple;
	bh=h86l60bKnZ/x/7tUOQYfFlRch3iSkW8o7ez2iOx5cQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=a46sxftrcTC0L/GuXzCDfm6kD8iazF4sOaR3RHIyXecAfsfj33pnM1qOtsFNM7uESgO0t8hI9C6qzokwoyicPyF/UQ5I8bWRjLBpkTQBKXXDZzwYBkeUACv7cnna1OPhuI6DlMzrEfoGZ1fXdlB2Gwh+rOfH+HLq5hW76M9nY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUxkpQRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86C9C113D0;
	Mon, 17 Nov 2025 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394745;
	bh=h86l60bKnZ/x/7tUOQYfFlRch3iSkW8o7ez2iOx5cQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUxkpQREbP2QOS9x8Iyj114TlA2hs00nkAg2KnFwM9o1WuwxWkeaKKqrjZWpWp+3v
	 x3FuRWhzsbc8X9+Hp5p4jsyhrFbTijF1pW5smYZxL5Vs4yN2gbjciGsUkH2cawsrA9
	 G8WYAPbU8mZjLZYJg/vSWcR398br00BvDexxpeujdT09vmbC7iYuUFewumiEkjekB/
	 OClrqHiS5kI680AF6FXj/XBT0fpe2HLkQDZG4v5/uspIjJ4ubzlDg9LQmyqfTiF902
	 VNRQ5g2ih9/SZsB9alvSj3qw5zQNSAUMZDWsIsKiZfXH8OQKhGVkQY5jL2ZBgz6UMZ
	 R9fMF9nF/N6IQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Nov 2025 16:52:19 +0100
Message-Id: <DEB39JY2VH7G.2D1WAPTNN94MQ@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>
Cc: <rust-for-linux@vger.kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Rae Moar" <raemoar63@gmail.com>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH] rust: allow `clippy::disallowed_names` for doctests
X-Mailer: aerc 0.21.0
References: <20251117080714.876978-1-ojeda@kernel.org>
In-Reply-To: <20251117080714.876978-1-ojeda@kernel.org>

On Mon Nov 17, 2025 at 9:07 AM CET, Miguel Ojeda wrote:
> Examples (i.e. doctests) may want to use names such as `foo`, thus the
> `clippy::disallowed_names` lint gets in the way.
>
> Thus allow it for all doctests.
>
> In addition, remove it from the existing `expect`s we have in a few
> doctests.
>
> This does not mean that we should stop trying to find good names for
> our examples, though.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRHSLChi5HYXW4-9@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/kernel/init.rs         | 3 +--
>  rust/kernel/types.rs        | 1 -
>  scripts/rustdoc_test_gen.rs | 2 +-
>  3 files changed, 2 insertions(+), 4 deletions(-)

