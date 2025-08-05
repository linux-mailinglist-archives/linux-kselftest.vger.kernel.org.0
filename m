Return-Path: <linux-kselftest+bounces-38291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF44B1B1ED
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5AE189FE27
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D126FD9F;
	Tue,  5 Aug 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwoTVTx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261626F471;
	Tue,  5 Aug 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389571; cv=none; b=DyVTXxZeZKBziuL0zzmVKdH6LfWns+jJrX+nMEETqQwrmXn7yGPufH3c3YnBM/Uolc4Drs840/KaotHYFAIxUmKfGDfXvwsAMgrddIB7ccTrVxKIu55H1ZEqI71o5ZcHCcd2D303eKzd+QACi9FTUWbIc6K1iJSySjVKnXvJiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389571; c=relaxed/simple;
	bh=7rVCW8r3zVl85kYTCUUV6L2jUD/buUjnRV58z2gANgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8orTqS99KfBmbhWqAO0f9uITohPDK/TPjqa6km+P1jZ2YmeE1I/MxTo43dRSQbbHK1oWP6iaKEAHTMTkEYPAWAm6EHLBBD6SAiFhal1Mzv/FvB9goytU1Ym/BEo3osYUTtyEVAwsLE+bTzOyn+BRQv5EX5I0UzBdKbMSjz5g9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwoTVTx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B305C4CEF0;
	Tue,  5 Aug 2025 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754389569;
	bh=7rVCW8r3zVl85kYTCUUV6L2jUD/buUjnRV58z2gANgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IwoTVTx4oNSU7IOKbmF7O2xSfNdMOPq0wbdkfw4i7d5TfO5D3heN8DJqVZr1VEYnK
	 quER2OQsDmLwn1JObdmMN+13OmNTo4cX/uvdiDUuF/WOROEJb7q6/2gjIx0dmjIDv5
	 i3AP17v9diEQ9fP7XVQPphxJDAufssFw+w8vNEKubh5hIrSIDmlpODh1tI3bmm0ZtL
	 3/24lzJZyv0+rS7ImFsU+61TcSAlJ0Tmli5ZDZUwzwWKa6SpwNeJo4HksoiUnDAMK6
	 VoLVZbjkcQeazkEvm4Sy+OGtHKVdKZuHCyl0lktdkLpQk/m0BRI5Ddwk1C7KVosqm1
	 ytphFokTAMVfg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens
 Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH 05/17] rust: configfs: replace `kernel::c_str!` with
 C-Strings
In-Reply-To: <20250710-core-cstr-cstrings-v1-5-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
 <TL_feIg3npvj8WCrzUSpylClaDUBbZJFcZH8Z98hw2z7jzoH6u9Jbai8xtai6QsrTCDBbQD-cg_IpvXq1ZxqgQ==@protonmail.internalid>
 <20250710-core-cstr-cstrings-v1-5-027420ea799e@gmail.com>
Date: Tue, 05 Aug 2025 12:25:50 +0200
Message-ID: <878qjy9ia9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



