Return-Path: <linux-kselftest+bounces-36172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D5AEF2F6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21451627EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8E26D4E1;
	Tue,  1 Jul 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tu05Qvcx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7C26A0B3;
	Tue,  1 Jul 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361375; cv=none; b=lSbTFpXcZw9Cw9m8QLYOJsUNtIyqq9yRQxs8i3JbDY1mNiGwwcyeGXSzoTTY6RM7VScgPJxUrq9fAS5q0M12BYITwWYCOUnQYR6+SEJwT/qbtmas+BJfVkMtoT+cf6hy8jP+ucHFKLMaxHluAncWUXlNR1JhB5R7oluLkuv/BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361375; c=relaxed/simple;
	bh=ur4i4yzLkviKWu6sBni8onG/o9Yhcc21MCL8Xl7R2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4iAmr5MpuRPUgw3pUoO036XGKLDLr5zn2JTVQWUr8qJ/4zkGA/gEW5hZrZVFAThRuJIEVfsszr+jxIZRM38qSANBEsGCnfsPBICI5tbxV1h66IjI9yaWUL4rNBBsCPZmgmeKEEch+V0gf9FDxGtwbcTfhJ29NcW84a1hoBt68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tu05Qvcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC6C4CEEB;
	Tue,  1 Jul 2025 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751361374;
	bh=ur4i4yzLkviKWu6sBni8onG/o9Yhcc21MCL8Xl7R2bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu05QvcxTTryu1orfNafIVyr6I4lmoos32qmVZHcsOqY/nYUfrJ4sPOMm8sUI2o8p
	 9NWWkvV6adHPBOBlJloHS7DmtmB6GYiis9n70ZimT9DrwMMjCVqh5tDMYtOUyHZwwk
	 Yo021tkT5ABHUMteNtDEgI3HJhP5nQ+W9MqJdt7o=
Date: Tue, 1 Jul 2025 11:16:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v12 0/5] rust: replace kernel::str::CStr w/
 core::ffi::CStr
Message-ID: <2025070102-pantry-siamese-905f@gregkh>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>

On Thu, Jun 19, 2025 at 11:06:24AM -0400, Tamir Duberstein wrote:
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
> 
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

