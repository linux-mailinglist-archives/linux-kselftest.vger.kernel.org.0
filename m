Return-Path: <linux-kselftest+bounces-11426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D078B900B11
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D3B22267
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEF19AA4B;
	Fri,  7 Jun 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM8NZo7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FD199EBB;
	Fri,  7 Jun 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780537; cv=none; b=g0K7xWJSP9VKUOPNRZ/2X60TZBLEFnbg3Ly8/60pXRhWLIiGCklJewcMEnFsqOlWI5OEzsZbFXvyKGmdDgGnGV+191pauyWE69dQ82H882DIK5SK29ZyMb5CWSy14jucKB9i9xyCodV75Uvd253JfmEE/SL5N3j13TlguRz0VK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780537; c=relaxed/simple;
	bh=+1C+CfkaqQH+43CNlS0hRJijJsoUJkiaCU9L0PzDf6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCHwS0EOFcmY7gm/PTIN974tuGbsCG4c4+S9F2/WRZ6X+6E6ZftpKYVaVcBSnsXzCZGL7LriFKBYMgYAA/ppTo4q2xU4f7LKJlwb8rIpINgmISb5sORKv5NCLomgrHGOshIxry43MDj4ypkm+ihiTcBOGJuMDx1hE88kks/swHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM8NZo7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA0C2BBFC;
	Fri,  7 Jun 2024 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717780536;
	bh=+1C+CfkaqQH+43CNlS0hRJijJsoUJkiaCU9L0PzDf6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM8NZo7QiMbiOjncaSHQmkLJcdUUvEjs7fAgxeEAEARDTOCBwcXIckBlzncP7EjUx
	 UZ+Bbz06enLZ/mz/hq3naYTZsM/3p45Sec3xumZ+RCS7O4ZIxE0l5Exglb9+K/JFCZ
	 TJhmBS+xUrpvhQMMxa2Au/rTd1im+oYbDZxLohejJbj53UBEs1wFhpMZMhDIKtvCH+
	 iM5RvUOD8s0UjbH/LU/TJrebaFV9fUpf3F2GFm5NysD7+6zQzc0qWL+dXpvOInnM4G
	 9mnMhpeVCTayhdwqPnTIqxzA7XY3W7pwR/fJkuphGrzWukf34BXjshkq2AQ2idH26p
	 xbLQK98LGFaKg==
Date: Fri, 7 Jun 2024 10:15:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>, sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
Message-ID: <20240607171533.GA2636750@thelio-3990X>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <20240603224706.GA245774@thelio-3990X>
 <2c57be33-77b8-419b-a708-e99aa9b44395@nvidia.com>
 <0d3fd536-5036-40e7-9783-80533914e32d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3fd536-5036-40e7-9783-80533914e32d@arm.com>

On Fri, Jun 07, 2024 at 12:12:19PM +0100, Ryan Roberts wrote:
> On 04/06/2024 05:55, John Hubbard wrote:
> > On 6/3/24 3:47 PM, Nathan Chancellor wrote:
> >> Does CC=clang even work for the selftests? lib.mk here uses 'CC :=' so
> >> won't CC=clang get overridden to CC=$(CROSS_COMPILE)gcc?
> >>
> > 
> > I received a report that someone (I forget who or what) was definitely
> > attempting to just set CC=clang. But yes, it definitely doesn't work
> > properly for CROSS_COMPILE.
> 
> This history as I recall, is that I got a bug report [1] stating that:
> 
> # tools/testing/selftests/fchmodat2$ make CC=clang
> 
> and
> 
> # tools/testing/selftests/openat2$ make CC=clang
> 
> were both failing due to the -static-libsan / -static-libasan difference between
> gcc and clang. I attempted to fix that with [2], which used cc-option to
> determine which variant to use. That never got picked up, and John
> coincidentally did a similar fix, but relying on LLVM=1 instead.
> 
> If we are concluding that CC=clang is an invalid way to do this, then I guess we
> should report that back to [1]?
> 
> [1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
> [2]
> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/

I can only speak from the perspective of the main kernel build, as I
don't really know much if anything about the selftests, but I think
CC=clang and LLVM=1 should both be valid. Ideally, they would behave as
they do for the main kernel build (i.e., CC=clang just uses clang for
the compiler and LLVM=1 uses the entire LLVM tools). I realize that for
the selftests, there is probably little use for tools other than the
compiler, assembler, and linker but I think consistency is desirable
here.

I am not at all familiar with the selftests build system, which is
completely different from Kbuild, but I would ack a patch that does
that. Otherwise, I think having a different meaning or handling of
CC=clang or LLVM=1 is the end of the world, but I do think that it
should be documented.

Cheers,
Nathan

