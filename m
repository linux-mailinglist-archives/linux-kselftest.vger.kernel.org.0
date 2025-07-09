Return-Path: <linux-kselftest+bounces-36878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42EAFF2D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A757BDBF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA62239E8D;
	Wed,  9 Jul 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe4a+AP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E245661;
	Wed,  9 Jul 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092303; cv=none; b=J1lPhZfhBf+yKy5Sz5cP3ha2BUZLpUx3Mqusovo8ppusftf0n0NongsHDeAU3Hi076mk/1JHLEBy6jnFf19gicOvpFSlkphQSm9ShDPkIBy0cdaqLrLXTWWA0dXT6QqEEWU6dyNz0qAvxUqcnTON3HjjUAzZQFNpjw2FGDGvcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092303; c=relaxed/simple;
	bh=6CR39NgMbcKd+hNEk754/31daJAAsaoy5EewA9veMuM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j9XiYBtrX6Vy3P5BRWHoo8IkFJdQX3e+vc8LrlvpEwUS4CskfcYdzRbE36+yIVmnzXgivhOsmErApzOGGMPXwRUZTntdgRPRqQF6P+9SyOfu+WGks6r1UTGXh9yd5t/g2TeWcbkbQNyewspdwCWz7zmgCn3BAExPpkLYEbog7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe4a+AP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC1EC4CEEF;
	Wed,  9 Jul 2025 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092303;
	bh=6CR39NgMbcKd+hNEk754/31daJAAsaoy5EewA9veMuM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Pe4a+AP/AhHZk8t3rcsQ/1og7b4y1QwCzYv9LFgXa2mAX2gu6d7A0Xs9OyPXQZy7K
	 5VFRoHNeV9ZcKEPC0jgo5/NfIB64qHe7+tT6ijzH57rfE3sDK03oZ/8iyee9gBS+yr
	 36Ec820desW6oCWxV8dvLg1756m/lIaPWuxkVrYiTiAK42zKPeN36M7nJINbjJ3yGp
	 PgOhN82d0Z/wsQV2oDvoi3wwkO2m0XjGEGDumc49dZ3z026mBGcsBAbGEXOaYp9Xg8
	 vwR/AFk/vyVRa/PRYs22GULSAX62oY0DYSNTQ0wO/QLVUKLTWGLhBuX3st95jJNXNu
	 Olt8kO8GVPGcA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 22:18:16 +0200
Message-Id: <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
Subject: Re: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Jens Axboe" <axboe@kernel.dk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>
X-Mailer: aerc 0.20.1
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
 <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com>

On Wed Jul 9, 2025 at 10:00 PM CEST, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/init.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I usually prefix patches to init.rs with `rust: init`. I'll fix it up
when picking the patch or Miguel can do it if he takes it:

Acked-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

