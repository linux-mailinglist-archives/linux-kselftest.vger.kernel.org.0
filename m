Return-Path: <linux-kselftest+bounces-36509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49556AF8B15
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45CE7B40BDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE0326A60;
	Fri,  4 Jul 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jTK77Tij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8894326A58;
	Fri,  4 Jul 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615865; cv=none; b=cDaMhBwWbO1DNHBi08PTmAI5q1r0TrfsEVn1pJge7w+07gJmfg5AdS54ZBvDCgfAE+cVBROpQNKXvbSPLJooufNB78vOB4ShfaMpZfPYw9Yh5JLvGJjuaVsznCRLAIbCMjQ1hwRu1opQ971XplUT5a1GBuqOAO6Gcv5n1Hkspbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615865; c=relaxed/simple;
	bh=bPS2JYksrIppycfYjPG2JSlEWAOe/ZXoQROBn/MlDBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+n42N1qAmQGfEgKQU7fEUxmTehC3RfmxKXaQl2hQ4PhipArRBasdEAUpdP+S1MVIZLYvViSi+GrQIh5qMQS8FtqOTI2DWKNeB6+ERR8KEj5jT+velnKS0+92nmktO5vRACuY3wMTqAuEbF8RiqfQcNmmehFeByDHPQQrOm+K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jTK77Tij; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5qrkD9bX+jI4ab6c+XtoSydd7j+KnW2OaBzeTTEC/QE=; b=jTK77Tij9gZIa4yFat5vka5xRz
	zxo2K3t3N98K2N9r3t0x1GzxeIxrNCnwCWaXoIAcYUClezLp6LYgcNldRMWVG6g9Wl76TbfZVdEJo
	8webAKr8ryhcY5PYw6AJiDWHNqoMr5QS+4SvlL1Zc3qnZ4gKNAd4lQYtfsMSWHxyzqpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXbIH-000BBm-4J; Fri, 04 Jul 2025 09:57:13 +0200
Date: Fri, 4 Jul 2025 09:57:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Michal Rostecki <vadorovsky@protonmail.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Justin Stitt <justinstitt@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
Message-ID: <efe97ed7-dd60-4f1c-ac5c-b700300f0390@lunn.ch>
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com>
 <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org>
 <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org>
 <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>

> Yes, it probably can. As you say, some subsystems might interact - the
> claimed benefit of doing this subsystem-by-subsystem split is that it
> avoids conflicts with ongoing work that will conflict with a large
> patch, but this is also the downside; if ongoing work changes the set
> of interactions between subsystems then a maintainer may find
> themselves unable to emit the log message they want (because one
> subsystem is using kernel::fmt while another is still on core::fmt).

This sounds like an abstraction problem. As a developer, i just want
an API to print stuff. I don't care about what happens underneath.

Could you add an implementation of the API which uses core:fmt
underneath. Get that merged. You can then convert each subsystem one
by one to use the new API. Since all you are changing is the API, not
the implementation, there is no compatibility issues. Then, once all
users are converted to the API, you can have one patch which flips the
implementation from core:fmt to kernel:fmt. It might take you three
kernel cycles to get this done, but that is relatively fast for a tree
wide change, which sometimes takes years.

	Andrew

