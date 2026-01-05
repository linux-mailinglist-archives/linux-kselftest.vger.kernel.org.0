Return-Path: <linux-kselftest+bounces-48175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C05D5CF25D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4C533017EC6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1A31195A;
	Mon,  5 Jan 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h7AzS7qo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087D2D7DC0;
	Mon,  5 Jan 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601160; cv=none; b=jjgnZi4ziBUgSbA3TzkWRh6YUmSkT8XaMdwNop8RNvR96TzmT+xDxs1ta4AGNFC34mbaQmwDn7l3Cp+wlj8ZtCQoOXrrSZZqxUMal24mnZ03Ng3uLPlsiOpAZv07uI1WDOM4zd9/uR3Z/x3aH9PcOZjlDKtv8JQ8Xy769plxlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601160; c=relaxed/simple;
	bh=5Et5O4k8R6D2A0JgenhoCqPWqFdxraazS7v6gcAY+bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVe+2ntbvDQxjhZKmXHjIbuQRjsdES6E38EFXTgDmEem57rGPYHY8LJYVUzfAUPED/fjK9pw2A0lpDf84J2tdMM58UIrhnkT8v1bsNq93j5NT0DeHuLlysMTXQVjpACF3RZOaykja2n0NtuyWo1AZPonVtVFycqSn5/QMNH+vWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h7AzS7qo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767601156;
	bh=5Et5O4k8R6D2A0JgenhoCqPWqFdxraazS7v6gcAY+bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7AzS7qoGFcj+ic52KkWYUtRBsGNK0I2cqOygLbsevhFWWtSy0TnYV/66iUzoshpW
	 dr3Na6sM5eXnXlbffNKyGxmcbZA9Unsj9morI4DOwl/SBrbl2a38slJNAZjB8U6tf9
	 ri2zKwuETlEe8bxN/WLj8JqFCmNNqOCUlbqcQod8=
Date: Mon, 5 Jan 2026 09:19:16 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Message-ID: <a1bfcb7c-7fe8-4206-ba17-4ed68493de7c@t-8ch.de>
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <aVtr8vJd_683mqUO@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVtr8vJd_683mqUO@1wt.eu>

On 2026-01-05 08:44:50+0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Sun, Jan 04, 2026 at 11:14:13PM +0100, Thomas Weißschuh wrote:
> > Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
> > 32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
> > SPARC builds. -mcpu=v9 generates instructions which are not recognized
> > by qemu-sparc and qemu-system-sparc. Instead qemu-sparc32plus and
> > qemu-system-sparc64 with a 64-bit kernel and CONFIG_COMPAT are needed.
> >
> > Rework the test setup so that -mcpu=v9 also works correctly.
> 
> Hmmm doesn't this mean that we're now unable to emit proper sparc32
> instructions with this compiler ?

That depends on the definition of "proper" sparc32 :-)
Jokes aside, that compiler still supports -mcpu=v8 just fine,
only the default has changed.

> I don't know which CPUs the kernel
> still supports, but if it still supports these old SS-5, maybe we
> should instead pass the correct -mcpu to clang so that it emits the
> expected instructions, otherwise we're just hiding the regressing by
> upgrading the test machine beyond what the kernel supports ?

The 32-bit kernel also runs just fine on QEMU SS-5.
My reasoning was more that we now test both the v8 and v9 code paths in
nolibc. But in the end it doesn't really matter, as it is the same
kernel interface for v8 and v9. We can also just specify -mcpu=v8.
I'll do that for v2.

(...)


Thomas

