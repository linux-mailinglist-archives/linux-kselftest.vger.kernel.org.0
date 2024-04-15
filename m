Return-Path: <linux-kselftest+bounces-7983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B768A541C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E847DB22A7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582F82D8E;
	Mon, 15 Apr 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EznNHSgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37F82D83;
	Mon, 15 Apr 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191470; cv=none; b=Cdi4x1ErCaihaXdm/HDrU5Goraix37B+mAo6N+grOdoHLHmGt+srW/ldnU659rGOZETweNOO9OXdvg9VjAs0ejZsFyn2w/orlcnnwKcZ8Gchpa4pAdNT+R15KLTe10I5HU+T+2gqlE4Wlb2eidq4DWJEGQBHXDwyTcw+tonS1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191470; c=relaxed/simple;
	bh=dQuoOPLDUre5qwCxXwBna/2X/qog5wf02zbWEBGe7x8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulDt9hHeHRphWpJd+XRf8QAmSMVcYK2Qf8DPhwtvvhYVCN3uNSe3hZrXZbNUgR8jqo6BFcBuVgCg817K8F6H8hBuecoYdkE/Dk2SPne9ye48vr+3qzKjCHH3pOUL5uVU7nqKde1O9MavcMUXUgrh10BisyWpgJQUFxEXhkZRsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EznNHSgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11405C113CC;
	Mon, 15 Apr 2024 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191470;
	bh=dQuoOPLDUre5qwCxXwBna/2X/qog5wf02zbWEBGe7x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EznNHSgUy8w7kxNEUMeWVqguT1snbXYVg1Z6z0P8yaqzHWeXPdHw8L0sCLEqxjgxS
	 UFsf92m3QZGPmfnClN0bd352fDg3UnEvtCUZNU5Y8h62qlfc0ycPgXqADCQK6U36xR
	 a6UqaNFjRiXSo1JXw52qOVomlMYcxGaO3fKTphAAcYf9WGPWaVXyP8Rb7cl2atnnct
	 Sa+ByjYOEfjaeJ6BYs27mPIwI1Sjex3KktHi8MYys34EnuquJfxz0rIJ+K79+SKZO7
	 heJ9SFVk1OwFDLhsE3W+e+bfsTTua6q+/+2B057naNK7MAP6ZGuPMmKCQxKksehFO7
	 FTk3xDTagk+EQ==
Date: Mon, 15 Apr 2024 07:31:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: construct environment
 for running tests which require an endpoint
Message-ID: <20240415073109.57629e54@kernel.org>
In-Reply-To: <661c0837eb5a6_3e773229499@willemb.c.googlers.com.notmuch>
References: <20240412233705.1066444-1-kuba@kernel.org>
	<20240412233705.1066444-5-kuba@kernel.org>
	<661c0837eb5a6_3e773229499@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 12:45:43 -0400 Willem de Bruijn wrote:
> Overall, this is really cool stuff (obviously)!
> 
> REMOTE instead of EP?

If I have to (:
Endpoint isn't great.
But remote doesn't seem much better, and it doesn't have a nice
abbreviation :(

> Apparently I missed the earlier discussion. Would it also be possible
> to have both sides be remote. Where the test runner might run on the
> build host, but the kernel under test is run on two test machines.
> 
> To a certain extent, same for having two equivalent child network
> namespaces isolated from the runner's environment.

I was thinking about it (and even wrote one large test which uses
2 namespaces [1]). But I could not convince myself that the added
complication is worth it.

[1] https://github.com/kuba-moo/linux/blob/psp/tools/net/ynl/psp.py

Local namespace testing is one thing, entering the namespace from
python and using the right process abstraction to make sure garbage
collector doesn't collect the namespace before the test exits it
(sigh) is all doable. But we lose the ability interact with the local
system directly when the endpoint is remote. No local FW access with
read/write, we have to "cat" and "echo" like in bash. No YNL access,
unless we ship specs and CLI over.

So I concluded that we're better off leaning on kselftest for
remote/remote. make install, copy the tests over, run them remotely.
I may be biased tho, I don't have much use for remote/remote in my
development env.

> Use FC00::/7 ULA addresses?

Doesn't ULA have some magic address selection rules which IETF 
is just trying to fix now? IIUC 0100:: is the documentation prefix,
so shouldn't be too bad?

