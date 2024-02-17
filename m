Return-Path: <linux-kselftest+bounces-4892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E98D858BE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241DB1F21A60
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 00:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37845149DF1;
	Sat, 17 Feb 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty3Z39rX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F7149DE0;
	Sat, 17 Feb 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129881; cv=none; b=tLy2/oJ1LC59e2UjujiIkUMdN45e6+MhW7jmA4AOa7RazzSFCYim55O/ALtc8/y5JOJp79nEalnep/kWU+4+kf9qSyIkeOjtsat6JlvVljSrZpdk3j4K21YE8hZZuo2SsuIdYTQhuQtuqa8bE4Bhygpikrn/09UkID9Fp9QVng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129881; c=relaxed/simple;
	bh=HvM77pPF32OxhQ23lHNBZDBNs71j/4mwemMgXzX6VEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsqutlXCSQwjIdCJgTz1I/g0X41MmWhLVPHR1XI2WxN/9Q5+JsWE9FvlLAB6FJMkYU6kzDObYbUxczeeffU49AKZnhNuMObvYI0DKz240gSVMJBJDN6j+vDmCo9KMXETKiSkvvnLE16M3HYIolo7HEo2rScBrOSlI/Bc6UKSdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty3Z39rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51487C433F1;
	Sat, 17 Feb 2024 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129880;
	bh=HvM77pPF32OxhQ23lHNBZDBNs71j/4mwemMgXzX6VEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ty3Z39rXy053iHKcZ9u2YlqO9SjanNUyq5q3raiuppeTBMDHbV4dx0cF3AUtszZCg
	 pEknsQCtZCS/FtBX6YEzKt/LY/Rnqj2zyF0S8jelqplp8BC6LFJgiwPFRzAvXZM4EP
	 vJVc///ZELT/tW5Uo+Gy3dR4faauCyBpPFv833XdaltWrSD1GvATG3zbeARXuO0xt0
	 6D/06dx/k5XD6CZVkEKTJl1wwUOEG5Et/SkO8CB8h3T7JmoZkpW6zx7/okXRxyKkmk
	 YnsE6ls+eHxj9hzRPLLmbLRh5OoaEcEt7naYm/RbpvZqIOmK8SvcXMuXgD2mHUqjqz
	 f+xkjhhma9ktw==
Date: Fri, 16 Feb 2024 16:31:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: kselftest_harness: use common result
 printing helper
Message-ID: <20240216163119.7cc38231@kernel.org>
In-Reply-To: <202402161328.02EE71595A@keescook>
References: <20240216004122.2004689-1-kuba@kernel.org>
	<202402161328.02EE71595A@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 13:32:12 -0800 Kees Cook wrote:
> On Thu, Feb 15, 2024 at 04:41:15PM -0800, Jakub Kicinski wrote:
> > First 3 patches rearrange kselftest_harness to use exit code
> > as an enum rather than separate passed/skip/xfail members.  
> 
> One thought I was having here while porting other stuff to use XFAIL was
> that in the strictest sense, XFAIL isn't like SKIP, which can be used to
> avoid running a test entirely. XFAIL is about the expected outcome,
> which means that if we're going to support XFAIL correctly, we need to
> distinguish when a test was marked XFAIL but it _didn't_ fail.
> 
> The implicit expectation is that a test outcome should be "pass". If
> something is marked "xfail", we're saying a successful test is that it
> fails. If it _passes_ instead of failing, this is unexpected and should
> be reported as well. (i.e. an XPASS -- unexpected pass)
> 
> I think if we mix intent with result code, we're going to lose the
> ability to make this distinction in the future. (Right now the harness
> doesn't do it either -- it treats XFAIL as a special SKIP.)

Hm.

Let's call "case" the combination of fixture + variant + test.
Currently nothing identifies a single "case" in the harness.
We just recursively walk dimensions.

We can add a new registration list and let user register expected
failures. It should work nicely as long as the exceptions are very
rare. Which is hopefully the case.

Let's see if I can code this up in 30 min. While I do that can you 
ELI5 what XPASS is for?! We'll never going to use it, right?

