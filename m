Return-Path: <linux-kselftest+bounces-16808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF74596659E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7510D1F22421
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570221B1D7C;
	Fri, 30 Aug 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LbxW5qED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F416EEC9;
	Fri, 30 Aug 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031813; cv=none; b=gnBessskoJZH0mhqzDOK9IcIP36mwVZ5zLQwdbMqPB7eD9cyW/GTz3WOVK/2vREPX7xOGHV+G6GxU/dSsmMWRLzx7Osw6OYNxn//0b/QOxuFSdUP0PcSTe6n9ICE4wHmIzl+dEuZr/uXFKOzB70thpslcJ8riRCr26lFjUSs5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031813; c=relaxed/simple;
	bh=V2VJ12EQT4i6n4aeoiaDxyllMlqthEmdNScFeTWz9Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DidCtSRXUgZCD8vExuRJcAsHq06qlPcytioR/apsCMtDr6/ZVQrZJJ6f76wV89gBzUn627Zs92skUw94IdcjmClV/1Q0hL7ByK1qX5fprZ56Vq7VGTtDPNPRjko3ZsEj2O/BzjV3a3NIxVoglRAn15UOQP3uJqjWeXx87emSMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=LbxW5qED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FF2C4CEC2;
	Fri, 30 Aug 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LbxW5qED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725031809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TS8nVZqiFVKrs+/FUWrxZIU1v/CNzMC33eCO9K4Uobg=;
	b=LbxW5qED90WneHoVKo5ut0ooOGXlLEj23y8j28oyQWipIBHXkNhAIM49N7cmXW0Hkisq5N
	TFD4fpf81DjgHrnNfCYxWzYevM8hxURnHSdCM8PP04dXHbuwmfKmkr04uddwZ0x0Z2WHfO
	94jHWbtd+dSV66NG2XRR8RUnhz6W0X8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 044db95b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 15:30:09 +0000 (UTC)
Date: Fri, 30 Aug 2024 17:30:07 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/vDSO: Fix cross build for the random tests
Message-ID: <ZtHlf1qaXTPwJQkJ@zx2c4.com>
References: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-vdso-chacha-build-v1-1-78f93d2a142f@kernel.org>

On Fri, Aug 30, 2024 at 03:06:35PM +0100, Mark Brown wrote:
> Unlike the check for the standalone x86 test the check for building the
> vDSO getrandom and chacaha tests looks at the architecture for the host
> rather than the architecture for the target when deciding if they should
> be built. Since the chacha test includes some assembler code this means
> that cross building with x86 as either the target or host is broken. Use
> a check for ARCH instead.
> 
> Fixes: 4920a2590e91 ("selftests/vDSO: add tests for vgetrandom")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for the patch. Seems reasonable; I'll queue it up.

> ---
> The x86_64 build is still broken for me because nothing installs
> tools/arch/x86_64/vdso/vgetrandom-chacha.S (I beleive it's supposed to
> be copied from ./arch/x86/entry/vdso/vgetrandom-chacha.S but I don't see
> how?) but this at least fixes all the other architectures.

There should be a symlink installed for that. Are you using this tree?

https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

That's where all these fixups are going for 6.12. (And yea, there are a
lot.)

