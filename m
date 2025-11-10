Return-Path: <linux-kselftest+bounces-45262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB03C49706
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701361889A1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ADD32ED35;
	Mon, 10 Nov 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTB/W/EN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF641FF61E;
	Mon, 10 Nov 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811034; cv=none; b=Ef2A0CwJsBOgkLiZ+eVZnLfr/34G6u3KohW/FGlkWkXhxB1dE9UURKCs+8L89ljwN25dGS9YzyLT8hPfiU9GN3lC1NzBWeVWNLOYnd2ZiHVBm9sfUqlY/pV6fuzue1Msb9BD9/w1pSVP3kVU7ByRu5NY0QenFMnF0zcDua2H84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811034; c=relaxed/simple;
	bh=qLsh4xwJFcm7ZBPTELrv5HlI3dadasyJWn9EEI6vM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLGQk0v9qRF0JTdCZbAHa9igEn7tE9qsJSCVKaQGXfTjf4BheyDWhZ3aqQGLAy0QbVIVgs0zQh/Yup5ACiEW17k5Nzk4JZ3sAgiGK1jK4zpkGEp0rHkuVa4oIohCdY5sG25Ask76OBmq+z+9oKPXOAhtMqSH3IO3u9PpLiOSVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTB/W/EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC532C116B1;
	Mon, 10 Nov 2025 21:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762811034;
	bh=qLsh4xwJFcm7ZBPTELrv5HlI3dadasyJWn9EEI6vM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTB/W/ENaZyWqwN3+1JS39b2RHZU0mVzd+iX5zXnJ6OoHc80SN0wrgaz/WIvM6Y77
	 0dYcTeQlruQ7+v0pSvqoEsOHFlc4fXmZIMPBFmrz8H3LqzxQen+v/v8WRHWMNqmQb8
	 2LiRM0jBjhSRh584eNaIXPZRqftXWByMhTDaIH7Rk7LitC1Gy1RRsBSREWb3SQPP3c
	 YljSbH+HHxNKJvBbpjkbRilCUSwqwsOME1fxIuh3C3gwyanU/PhpkLlsuNEma24Pww
	 uMGlOkYblxl+rwD8gC0QEGBRFsfHSVzFaVMrfAoc4BgVm7yuqOKEcg6+TOoj1h9LoD
	 f85WUmDtXeziA==
Date: Mon, 10 Nov 2025 14:43:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <20251110214349.GC302594@ax162>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
 <aQyOZ6eYng-IjxS_@fedora>
 <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
 <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
 <aRA6lEQmmrvmj2DX@kernel.org>
 <a7034e0c-a2ab-425a-8472-ef0a87a17681@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7034e0c-a2ab-425a-8472-ef0a87a17681@suse.cz>

On Sun, Nov 09, 2025 at 08:11:09PM +0100, Vlastimil Babka wrote:
> >> > >>> Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> >> > >>> triggers following warning:
> >> > >>>
> >> > >>> mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> >> > >>> false [-Wtautological-compare]
> >> > >>>    1035 |                 if (addr + c.dest_alignment < addr) {
> >> > >>>         |                                             ^
> >> > >>>
> >> > >>> typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
...
> >> I must say, applying this would be an unhappy life event.
> >> 
> >> 	if (void* + ulong < void*)
> >> 
> >> makes perfect sense in a world which permits void* arithmetic (ie,
> >> ours).  So what the heck is clang doing??
> 
> My (not very informed) guess would be something about undefined behavior
> because pointer arithmetic is strictly speaking only valid within an array,
> so void* + ulong is also still in the same array, and thus can't become
> smaller by an overflow, because overflow can't happen if we're still within
> the same valid array...

It is indeed due to undefined behavior but more so that without
-fwrapv-pointer (set via -fno-strict-overflow for the kernel build), the
addition of an unsigned index and a pointer cannot wrap. This warning is
a result of the following change in clang-20:

https://github.com/llvm/llvm-project/commit/6d34cfac53b993a6cdf3d6669e017eac3a2296c8
https://godbolt.org/z/hvMoPYb17

which I made sure respected the value of -fwrapv-pointer in

https://github.com/llvm/llvm-project/commit/f0dcf3240dffe3767c7f3a2e2da5b92ae9fd1bef

But it looks like the mm selftests do not build with
-fno-strict-overflow. Maybe it should?

> But I don't know if this strictness is only applied to the warning itself or
> to the actual compilation too (does it eliminate everything as dead code then?)

Yes, it would turn that

  if (addr + c.dest_alignment < addr) {

into just

  if (false) {

based on the above Godbolt link.

> >> If we do
> >> 
> >> 	void *addr2 = addr + c.dest_alignment;
> >> 	if (addr2 < addr)
> >> 		...
> >> 
> >> then which statement warns, and why?
> 
> As the answer was that nothing warns, I'd think it just isn't able to warn
> if it's no longer part of the same statement. Whether it also means it's not
> eliminated as dead code anymore, dunno.

Based on the above Godbolt link, it appears it will be optimized the
same way, just without the warning letting you know something is up.

Cheers,
Nathan

