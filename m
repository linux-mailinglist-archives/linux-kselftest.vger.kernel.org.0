Return-Path: <linux-kselftest+bounces-34115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25878AC9F5F
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DC3B5D9C
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309F19ABDE;
	Sun,  1 Jun 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdDYm3ma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C72BD11;
	Sun,  1 Jun 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748795072; cv=none; b=Blqcyl0AQa4S2kpAEN7hcQl5GYxP1qhKpbIiwWcWksymffqGY/Gi8r383anyEnDesw92Gb6SHJ2+41BeZytuFZCRDKp40TznnM/b9izfI+GBPxB1BEsf0zCN9QMzbi0bODV92MZjIL1M8tluWQUAMi3a1kvIKD6adPz2mCS42Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748795072; c=relaxed/simple;
	bh=PMAkhQy/Nj8Qt7aS/e+j9Xv4t7buO1RGFex1w+i2gQo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f03FB8NvQFzHf8HUFxW9cAoW1Y5rxgsrZIOPy6dFcvNfxlUsS5x0OL915mcowajxNFUazWyjE2/BnPiN/f3KDqv2VsbOmRkHFZaIKi+b9Jp2jNkj8dIxo6XCzLHY0FpUVTyKGzVlgz9Y9IKp5l8oEnQg0lQx8anychF1jSO/+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdDYm3ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0113C4CEE7;
	Sun,  1 Jun 2025 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748795071;
	bh=PMAkhQy/Nj8Qt7aS/e+j9Xv4t7buO1RGFex1w+i2gQo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BdDYm3makofis/Ax9rM0GzHSjQ+tNLU+f0PbFUOY9BF9dLvdOuyAKODKHjXLDjvbP
	 5lIXeyJX1Xl+VIqXf9pDgFbbwa+bXMlhD/l8wRETbbNVaTT0/++1IFmhMG/96JI24o
	 cNiilVHw+p2wn++Q3SnqEDr8/FVMKw5nODG2riXGlUux6OwYxsqNRKvlhJsCDxkYzF
	 ssijqz3/s6CQP9JL+AzW9YgvNLlsseQ8OJKw+7qVKg+DVx3cTb2bFgptyZfSejssMM
	 uW5xwVxTdstNKC4LvO4wJIsDsux0vx/2U2FLofXrHXcGfGKkW/IeXYjmdwSCap6h7B
	 mPzWDuxHoh+Qw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Jun 2025 18:24:19 +0200
Message-Id: <DABC3ZAQ01GG.1VT5NL7PIMTEO@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v11 1/5] rust: macros: reduce collections in `quote!`
 macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Michal Rostecki"
 <vadorovsky@protonmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Russ Weight" <russ.weight@linux.dev>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Waiman Long" <longman@redhat.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Arnd Bergmann" <arnd@arndb.de>, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
 <20250530-cstr-core-v11-1-cd9c0cbcb902@gmail.com>
In-Reply-To: <20250530-cstr-core-v11-1-cd9c0cbcb902@gmail.com>

On Fri May 30, 2025 at 2:27 PM CEST, Tamir Duberstein wrote:
> Remove a handful of unncessary intermediate vectors and token streams;
> mainly the top-level stream can be directly extended with the notable
> exception of groups.

What's the motivation for this? I wouldn't spend much effort on this
file, as it'll go away when we add the `quote` crate.

---
Cheers,
Benno

> Remove an unnecessary `#[allow(dead_code)]` added in commit dbd5058ba60c
> ("rust: make pin-init its own crate").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/macros/quote.rs | 104 ++++++++++++++++++++++++---------------------=
------
>  1 file changed, 49 insertions(+), 55 deletions(-)

