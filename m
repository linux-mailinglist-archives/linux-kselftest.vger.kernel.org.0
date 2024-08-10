Return-Path: <linux-kselftest+bounces-15114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D601394DD62
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7993F281E0D
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3371607A1;
	Sat, 10 Aug 2024 14:57:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E1C28E;
	Sat, 10 Aug 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301841; cv=none; b=dRaGkKobbRx2oM9EhSa6nsiPeG7n7r/km8LtPWOedJhqb13GMUYW0hTu1dOOjHMpqNyt3d8iGCpsSmhDvMFk0RlalPeWmN3ri54wOe1ZuT+tzI7WxQFcHyoDeAaBeY5xd3di7XzoBe9RiEEXAUveZJXSMeCnZbf+q3XgJ7N7BBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301841; c=relaxed/simple;
	bh=6XYSJ2mZrjHZt8VI4dBSBoz2Kw0t5F1Trt0QbRAoIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCEe8XV5tMQpYjneX5u9IGcizTG88dT2ygjf2bT6lBLzUytlJFAvex0qdHLnJBYDSSOkq3eQg8HOJB0CfMj6VTwGNHca5HTMoCfCp3Pk+0FuR4pJP0PKDVx+ao7/mPIsstpjzQbbBYAuE8XcSMOufQA12+yMeTtmghkFfmurJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 47AEvDFj009492;
	Sat, 10 Aug 2024 16:57:13 +0200
Date: Sat, 10 Aug 2024 16:57:13 +0200
From: Willy Tarreau <w@1wt.eu>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/15] tools/nolibc: improve LLVM/clang support
Message-ID: <20240810145713.GC9168@1wt.eu>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
 <dc3b8c77-8051-4232-9feb-753ea0b44f4f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc3b8c77-8051-4232-9feb-753ea0b44f4f@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 07, 2024 at 04:09:41PM -0600, Shuah Khan wrote:
> On 8/7/24 15:51, Thomas Weiﬂschuh wrote:
> > The current support for LLVM and clang in nolibc and its testsuite is
> > very limited.
> > 
> > * Various architectures plain do not compile
> > * The user *has* to specify "-Os" otherwise the program crashes
> > * Cross-compilation of the tests does not work
> > * Using clang is not wired up in run-tests.sh
> > 
> > This series extends this support.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> > Changes in v2:
> > - Add support for all architectures
> >    - powerpc: "selftests/nolibc: don't use libgcc when building with clang"
> >    - mips: "tools/nolibc: mips: load current function to $t9"
> >    - s390: "selftests/nolibc: use correct clang target for s390/powerz"
> > - Expand commit messages
> > - Use __nolibc_ prefix for custom macros
> > - Link to v1: https://lore.kernel.org/r/20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net
> > 
> > ---
> > Thomas Weiﬂschuh (15):
> >        tools/nolibc: arm: use clang-compatible asm syntax
> >        tools/nolibc: mips: load current function to $t9
> >        tools/nolibc: powerpc: limit stack-protector workaround to GCC
> >        tools/nolibc: compiler: introduce __nolibc_has_attribute()
> >        tools/nolibc: move entrypoint specifics to compiler.h
> >        tools/nolibc: compiler: use attribute((naked)) if available
> >        selftests/nolibc: report failure if no testcase passed
> >        selftests/nolibc: avoid passing NULL to printf("%s")
> >        selftests/nolibc: determine $(srctree) first
> >        selftests/nolibc: add support for LLVM= parameter
> >        selftests/nolibc: add cc-option compatible with clang cross builds
> >        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
> >        selftests/nolibc: don't use libgcc when building with clang
> >        selftests/nolibc: use correct clang target for s390/powerz
> >        selftests/nolibc: run-tests.sh: allow building through LLVM
> > 
> >   tools/include/nolibc/arch-aarch64.h          |  4 +--
> >   tools/include/nolibc/arch-arm.h              |  8 +++---
> >   tools/include/nolibc/arch-i386.h             |  4 +--
> >   tools/include/nolibc/arch-loongarch.h        |  4 +--
> >   tools/include/nolibc/arch-mips.h             |  8 ++++--
> >   tools/include/nolibc/arch-powerpc.h          |  6 ++--
> >   tools/include/nolibc/arch-riscv.h            |  4 +--
> >   tools/include/nolibc/arch-s390.h             |  4 +--
> >   tools/include/nolibc/arch-x86_64.h           |  4 +--
> >   tools/include/nolibc/compiler.h              | 24 +++++++++++-----
> >   tools/testing/selftests/nolibc/Makefile      | 41 +++++++++++++++++++---------
> >   tools/testing/selftests/nolibc/nolibc-test.c |  4 +--
> >   tools/testing/selftests/nolibc/run-tests.sh  | 16 ++++++++---
> >   13 files changed, 83 insertions(+), 48 deletions(-)
> > ---
> > base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
> > change-id: 20240727-nolibc-llvm-3fad68590d4c
> > 
> > Best regards,
> 
> Looks good to me. For selftests patches:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

And all the series looks good to me as well (modulo that tiny "powerz"
vs "systemz" mentioned in the 14th patch's commit message). The commit
messages are now way more detailed and more pleasant to go through,
thanks for that!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

