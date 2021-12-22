Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC247CA7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 01:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhLVAkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 19:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhLVAkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 19:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983BC061574;
        Tue, 21 Dec 2021 16:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C7CB81A27;
        Wed, 22 Dec 2021 00:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E929CC36AEA;
        Wed, 22 Dec 2021 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640133605;
        bh=j4fxKQ/pouRbRKesqGWj6oRpvgQjCFuPocDWspHDWpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRC3wHdIBRa9zy6jEt4GCTd215IEdJ/k4UtFLWcIj2jlorNj6GVId8YsRxmMGNGmN
         YyMt1XPuejBfKSGlrrm3izZpwt/Iy2gRCgVoLpRM41gh3arsmDEiGbq93SAQrzTf+8
         UZnOVYj6t8QxTdcqCXiQRCaHayo32eN5y0EvAtpA4eSzwk0EJkplxDk6i2DTivuYpj
         PfH8nv4g94XPwhss/aQC1oorYc4niFtTVjkKCVjZF8SoT/T+qSl8gZew9XH+h48jo6
         TkosmWaF1zZ3Us/kTR3ka/WaqlNiBui/hl/isRseDkYayWhVM1k+gddIpOsJQemsLc
         Xmyn4tE8XX66w==
Date:   Wed, 22 Dec 2021 02:40:04 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH] selftests/sgx: Fix corrupted cpuid macro invocation
Message-ID: <YcJz5HScqjAiWUBk@iki.fi>
References: <20211204202355.23005-1-jarkko@kernel.org>
 <1eefe8b4-feec-3f2a-7eae-c10e49fbedf0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eefe8b4-feec-3f2a-7eae-c10e49fbedf0@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:24PM -0800, Reinette Chatre wrote:
> Hi Dave and Jarkko,
> 
> On 12/4/2021 12:23 PM, Jarkko Sakkinen wrote:
> > Compilation results:
> > 
> > $ make -C tools/testing/selftests/sgx/
> > make: Entering directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> > gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c main.c -o /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o
> > main.c: In function ‘get_total_epc_mem’:
> > main.c:296:17: error: implicit declaration of function ‘__cpuid’ [-Werror=implicit-function-declaration]
> >    296 |                 __cpuid(&eax, &ebx, &ecx, &edx);
> >        |                 ^~~~~~~
> > cc1: all warnings being treated as errors
> > make: *** [Makefile:33: /home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx/main.o] Error 1
> > make: Leaving directory '/home/jarkko/Projects/linux-sgx/tools/testing/selftests/sgx'
> > 
> > Include to cpuid.h is missing and the macro usage is incorrect.
> > 
> > Include cpuid.h and use __cpuid_count() macro in order to fix the
> > compilation issue.
> > 
> > Fixes: f0ff2447b861 ("selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   tools/testing/selftests/sgx/main.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 7e912db4c6c5..370c4995f7c4 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -1,6 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /*  Copyright(c) 2016-20 Intel Corporation. */
> > +#include <cpuid.h>
> >   #include <elf.h>
> >   #include <errno.h>
> >   #include <fcntl.h>
> > @@ -291,9 +292,7 @@ static unsigned long get_total_epc_mem(void)
> >   	int section = 0;
> >   	while (true) {
> > -		eax = SGX_CPUID;
> > -		ecx = section + SGX_CPUID_EPC;
> > -		__cpuid(&eax, &ebx, &ecx, &edx);
> > +		__cpuid_count(SGX_CPUID, section + SGX_CPUID_EPC, eax, ebx, ecx, edx);
> >   		type = eax & SGX_CPUID_EPC_MASK;
> >   		if (type == SGX_CPUID_EPC_INVALID)
> 
> 
> Shuah confirmed ([1]) that there is no problem including cpuid.h and that
> this is the preferred fix.
> 
> Thank you very much Jarkko.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette
> 
> [1] https://lore.kernel.org/linux-kselftest/63293c72-55ca-9446-35eb-74aff4c8ba5d@linuxfoundation.org/

OK, cool, thanks!

/Jarkko
