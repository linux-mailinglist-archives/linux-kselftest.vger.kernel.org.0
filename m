Return-Path: <linux-kselftest+bounces-38048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B069B14A0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BE17AB008
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8927F19F;
	Tue, 29 Jul 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRK9eF/F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442027A11E;
	Tue, 29 Jul 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777668; cv=none; b=aDez2NhjvIrYlzguh0LyHDDqTg/DfQM6+pT+O21DJWdYkiH4jwyRlvMDiXd5lk7D4M8ZoGq67+u9y0fUWTrXo3bluu7tlnlbemSzCxSJ+pA8yIfYMQqQRg4JQKX2g1UFIDnc+3JKJzGt0oOFXTvLJXvpS/IrDiM6wWOZBGE8k7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777668; c=relaxed/simple;
	bh=4HFDpDAKjo6FuyobbreMH/fIg2s9uow5bgfayZ9Nj7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=XH8HBy/rbL2ramwxMqMLMcF98W+GF8lmiN2VTeBYKNOexjxKolmzzqdup40SdNP19cCg72bcHKP+dDnUWH3LUgFXNFDFptw7sshIOOAu6ASWx0KBghOZJD0qkZM5wMX0An65FghXQTqCFgjoOogBi7OnbeHKoXGtkbvlpf3zTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRK9eF/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A571DC4CEEF;
	Tue, 29 Jul 2025 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777667;
	bh=4HFDpDAKjo6FuyobbreMH/fIg2s9uow5bgfayZ9Nj7g=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=NRK9eF/F05BQxKAd4WhDO21TK1RD5zSVwwud0GYwy9YPGd9MHbAHCycO6dd9y8HBT
	 5mbRlOzR3tU4bovs0Mbwc7wuZUjFbGrYkgNK1ijS2NyeKuVFm1YjUp52ygcookUOsu
	 NCxmGDxXoI7fqTMpSthTZ3Q/JJPImTjDIQynpKwdTWP9p+2/4aOyQ3wGICv96O/Y3K
	 A6lrNRiL89xHvZpRvHVMB2BOg6nLX97QhcZkzHYaqD9mHBaN+YjP1EVXMj+7nK5dMT
	 7021RzrNNuWgCf29lB10V+bBxbzvrcUKZP8Jqera7lcfbRxXoBezhVW9QDQ4FJacr/
	 aW/dIPiN5SCfg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 10:27:41 +0200
Message-Id: <DBOEANDMX1OU.2B47D7G6EQ38O@kernel.org>
Cc: "Alex Gaynor" <alex.gaynor@gmail.com>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>, "Rae
 Moar" <rmoar@google.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, <linux-kbuild@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
To: "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: kernel: remove support for unused host `#[test]`s
References: <20250726180750.2735836-1-ojeda@kernel.org>
In-Reply-To: <20250726180750.2735836-1-ojeda@kernel.org>

On Sat Jul 26, 2025 at 8:07 PM CEST, Miguel Ojeda wrote:
> Since commit 028df914e546 ("rust: str: convert `rusttest` tests into
> KUnit"), we do not have anymore host `#[test]`s that run in the host.
>
> Moreover, we do not plan to add any new ones -- tests should generally
> run within KUnit, since there they are built the same way the kernel
> does. While we may want to have some way to define tests that can also
> be run outside the kernel, we still want to test within the kernel too
> [1], and thus would likely use a custom syntax anyway to define them.
>
> Thus simplify the `rusttest` target by removing support for host
> `#[test]`s for the `kernel` crate.
>
> This still maintains the support for the `macros` crate, even though we
> do not have any such tests there.
>
> Link: https://lore.kernel.org/rust-for-linux/CABVgOS=3DAKHSfifp0S68K3jgNZ=
AkALBr=3D7iFb=3DniryG5WDxjSrg@mail.gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Nice! This should also allow us to remove the Cmalloc allocator subsequentl=
y.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

