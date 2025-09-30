Return-Path: <linux-kselftest+bounces-42619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C6BAC2DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B37F172043
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC425BF18;
	Tue, 30 Sep 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovgb9sSn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10672147FB;
	Tue, 30 Sep 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223348; cv=none; b=AKL2nwZsg7jy3s9Jg+pW9q6Q0wcrQufVGm2YN2woZ4fqMgRM8607QyNvg0nqRdPIoPtDYmTkqGhKI2TJEmu3EM3SzRzK+pjlfjOR6rAdX2/NJUQp0+/sf4UlHIUxvKhWkakkjNB8NL3hLW/WcPXxQjqgx9NMu6qCd+JXlTnFwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223348; c=relaxed/simple;
	bh=1TypGX/cTzJD9kx3Mbj0TYYoI7zzRjlYiUdYBg+4JVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmU+hthOoSlALI1bVpRrW6QHdaVBrMQlWS1fVAoHecYmWrV00I/oe720nvMud6AR02rmiVAitoAb4EJ9qFB00aqLvd/qJyFAx+tVVfnPgbv6nr1rWI0J3aG7zBAGiAN/gLoNQxMcXHmVanMAhHYte3zbMDlB2dem0Fe3YzlRvtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovgb9sSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F021C4CEF0;
	Tue, 30 Sep 2025 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759223347;
	bh=1TypGX/cTzJD9kx3Mbj0TYYoI7zzRjlYiUdYBg+4JVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ovgb9sSntYNrTvjX2qMv+VyzZhVdHH9hRwOaZ5rztICEHlaG+rVq3Jk3watrult+Z
	 SnuXOlpTYIYJEt1ikl6yiBA5ZwFVqcJSVoJN84hGILw0VFUcc5slaqeJn7iJBvkujE
	 Dj6IX5vXrm/gMgg5ET/q02XjaDClI6LiPsVJe4E4lxNjrhwWDbQEfoExIw1wwXqeDX
	 Bcs1yJTt1cvXGXkiIAvmeFSOfHExVPDysBMquZP71kjVjzOiaTDTzrSAlH88fEnOeB
	 MzRUC4BgmBCcOHBGccvaQ4emYBAV3IU+lbR1wFpwb6y1RwFTlY8fsyZm7QbG+1H/zN
	 vfcLGGCVev8dg==
Date: Tue, 30 Sep 2025 10:09:02 +0100
From: Simon Horman <horms@kernel.org>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH net v3] selftest:net: Fix uninit return values
Message-ID: <aNueLn3Wy-2X_GeE@horms.kernel.org>
References: <20250929211241.55701-2-sidharthseela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929211241.55701-2-sidharthseela@gmail.com>

On Tue, Sep 30, 2025 at 02:42:42AM +0530, Sidharth Seela wrote:
> Fix functions that return undefined values. These issues were caught by
> running clang using LLVM=1 option; and are as follows:
> --

Hi,

I don't want to block progress.
But there are some format problems with the commit message.

Locally, git truncates the commit message at the line above ('--').
Which, omits a lot of useful information.
Most critically your Signed-off-by line.

There is also another '--' below. Just above the fixes tag.
Which would cause a similar problem.

And the v2/v3 information should go below the scissors ('---'),
below your signed-off by line.

Maybe the maintainers can fix this when applying,
given how close we are to the pull for v6.18-rc1.
And that I believe there has already been some
discussion of this patch with the maintainers.

> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  1587 |         if (!sock) {
>       |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>  1635 |         return ret;
>       |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>  1587 |         if (!sock) {
>       |         ^~~~~~~~~~~~
>  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1589 |                 goto err_free;
>       |                 ~~~~~~~~~~~~~~
>  1590 |         }
>       |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>  1584 |         int mcid, ret;
>       |                      ^
>       |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>  2107 |         case CMD_INVALID:
>       |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>  2111 |         return ret;
>       |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>  1939 |         int n, ret;
>       |                   ^
>       |
> --
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")
> 
> v3:
> 	- Use prefix net.
> 	- Remove so_txtime fix as default case calls error().
> 	- Changelog before sign-off.
> 	- Three dashes after sign-off
> 
> v2:
> 	- Use subsystem name "net".
> 	- Add fixes tags.
> 	- Remove txtimestamp fix as default case calls error.
> 	- Assign constant error string instead of NULL.
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
> 

This is where the v2/v3 information should go.

...

