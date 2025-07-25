Return-Path: <linux-kselftest+bounces-37964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD8B115BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 03:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76C5587595
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF311D5CEA;
	Fri, 25 Jul 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1Rk3hWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057B1C84C6;
	Fri, 25 Jul 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406486; cv=none; b=VIY9bi0fY3z7vS0b6dygttK8ggww4GzQ3TaXREfv50GhHiEVYC821sPKdhbbiR3qxv/fFsp8OVRUUbWcDp6olIu5b7sY+liHALx7OjpxIhi5HJoWk9giHA/Ro+PmjC0nearC8hloMxIe1ChgjPmr1sRl+oed4yIzBEhyt7ynKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406486; c=relaxed/simple;
	bh=MwqHEfaufpCZenjp6i2XUuWCEA4wM5dG9Nbu1j4rcuc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EREiUA2lS2/oW8Jq09nz02i7qWhKZ8f8iLB586oOHaFB7MRTOYoteb+WjjRbu0JprjcHEEE4IZTKg6cwlE666c16rbXRG2EvIw9OEx32M0PbXQzGor3zA90klGz8pbIAEhvuewNwW64Dq+H/aEWhYOi6HZLRJ97iGSu4wEa0Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1Rk3hWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D7C4CEF6;
	Fri, 25 Jul 2025 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753406486;
	bh=MwqHEfaufpCZenjp6i2XUuWCEA4wM5dG9Nbu1j4rcuc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=m1Rk3hWsOdacTaqRQmyKq2WcAz4JOiCCmafCCpJZccGewpWk5tGPQ8vUmkzPGQNtx
	 Nae3LJoRHEwKyp1nMtsPRvccMrdF64rL2Kwoq4uUk9osiNEPUvWp858ZzH2tvAnyKp
	 L57gcyS169BmwAj5aTWef7sjQKz2aikszYiwkniZivAlFvilRhoL07uCJePxeU0z7D
	 6mediv7gl4GjUtxouU0P4vAmIV3kWOuq+zyrSkJWTedoI/jwOQxK2WKce1EjRxufSD
	 UdcrsM6goolXixPwQPkVuanLvYRSH+rGkJrILKsKqPPuKKhZkRK51RqEMAWbC+nVoY
	 t8BHUQy0d00Lw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250710-core-cstr-cstrings-v1-4-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com> <20250710-core-cstr-cstrings-v1-4-027420ea799e@gmail.com>
Subject: Re: [PATCH 04/17] rust: clk: replace `kernel::c_str!` with C-Strings
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
To: Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Benno Lossin <lossin@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun.feng@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, Breno Leitao <leitao@debian.org>, Danilo Krummrich <dakr@kernel.org>, Dave Ertman <david.m.ertman@intel.com>, David Airlie <airlied@gmail.com>, David Gow <davidgow@google.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>, Ira Weiny <ira.weiny@intel.com>, Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, Krzysztof =?utf-8?q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Leon Romanovsky <leon@kernel.or
 g>, Luis Chamberlain <mcgrof@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rae Moar <rmoar@google.com>, Rafael J. Wysocki <rafael@kernel.org>, Russ Weight <russ.weight@linux.dev>, Russell King <linux@armlinux.org.uk>, Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Trevor Gross <tmgross@umich.edu>, Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 24 Jul 2025 18:21:24 -0700
Message-ID: <175340648493.3513.9465215631125389438@lazor>
User-Agent: alot/0.11

Quoting Tamir Duberstein (2025-07-10 08:31:07)
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

