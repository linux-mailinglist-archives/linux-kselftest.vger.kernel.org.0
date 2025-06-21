Return-Path: <linux-kselftest+bounces-35568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E339BAE2CA3
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 23:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453C73A98DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A9273D6D;
	Sat, 21 Jun 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj21Cs9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142AE270559;
	Sat, 21 Jun 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750540735; cv=none; b=pSlV5hF+F08+DtqmYpX4jB0b+L+2sNB6z6onWmgd2abUgE4Zz+8iMxbHwOnqo8EEWn7X4QqpT0VKR3QZe6l2dAEiWCurO9Lqcf2AYo2BKxqX+zY/biFgLxdLwgsF7qjZdanGZzkMk402LlaS4BOYNhUzAmFC0slAr+78kcIQF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750540735; c=relaxed/simple;
	bh=Y442YX5hM85zpUXLCqKwJEt5Ke3jFuQq2IdIaKtfHnY=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=jptxHfifW0/NX1+JpIj8Jlx8F8UYuVgLMpQjFmkoGVaJTARZ2EQ9KmZJHT7XnbIN9KUQihS0KEBFL3EH9fX3DHAvJ+pNsqqh4ztBotUP+FrG4uoENWYyVymqsZQR1ZUm+3aJzQc5ShkFhrYKqVPEAuOQboVRHHn2lD3Cppy4BEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj21Cs9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE0C4CEE7;
	Sat, 21 Jun 2025 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750540733;
	bh=Y442YX5hM85zpUXLCqKwJEt5Ke3jFuQq2IdIaKtfHnY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Cj21Cs9vo16c9/agcI0xqrPisWhf971Q8Grpd5dNTcqDw+yAnjC9eGBk+ZgSSM6ml
	 WuLtpT48XOJTt1RgONS749wakxcv+P51epDks9uRM0XrRWkBF0mLImnsgqjZga29K9
	 tBN1elhcw/BPM6kH5WzBFbuY01NeDCwjuarrEoVU/RyPCLfPP3lIsnsWi/eQ1+7pC5
	 qdxytMND/2noNXE/IZOgLJnI3aN8UG3RFZcRSvVFgGx2kKH6nsnOhAzopPOHe2YYaN
	 yEm4OPMaxgQ05giQba8s4/NR1TRJwD0jwShSfHzc2uGL/zWGegpZDSgpbVSTId73I3
	 5stBWhNTlIWfA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250619-cstr-core-v12-5-80c9c7b45900@gmail.com>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com> <20250619-cstr-core-v12-5-80c9c7b45900@gmail.com>
Subject: Re: [PATCH v12 5/5] rust: remove core::ffi::CStr reexport
From: Stephen Boyd <sboyd@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, linux-block@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
To: Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Benno Lossin <lossin@kernel.org>, Bill Wendling <morbo@google.com>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, Breno Leitao <leitao@debian.org>, Danilo Krummrich <dakr@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, David Airlie <airlied@gmail.com>, David Gow <davidgow@google.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>, Ingo Molnar <mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, Justin Stitt <justinstitt@goo
 gle.com>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Leon Romanovsky <leon@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Rae Moar <rmoar@google.com>, Rafael J. Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Russ Weight <russ.weight@linux.dev>, Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Trevor Gross <tmgross@umich.edu>, Viresh Kumar <viresh.kumar@linaro.org>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Sat, 21 Jun 2025 14:18:52 -0700
Message-ID: <175054073280.4372.1963514562501935667@lazor>
User-Agent: alot/0.11

Quoting Tamir Duberstein (2025-06-19 08:06:29)
> Clean up references to `kernel::str::CStr`.
>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

For clk part

>  rust/kernel/clk.rs                    |  3 +--

Acked-by: Stephen Boyd <sboyd@kernel.org>

