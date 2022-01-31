Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767C54A4CB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380211AbiAaRFB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 12:05:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51302 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAaRFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 12:05:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48BB4B82BB2;
        Mon, 31 Jan 2022 17:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4484AC340E8;
        Mon, 31 Jan 2022 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643648699;
        bh=pDzbp6f0HP5rjgsIA8RZqs5AWAal0sGi8t9sZ7151Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ud05AO+Wt0B90QaIuKiHIlCDF6SHbATDdBwqlME+y9LXrtMGCOjXXLG1HUR0atKj6
         InX1i8qd/ncc5zTu3HbkqsfnNJH8Shdu5L51WU2C3V1GuWCdIkbpgAemzUgZupF3Ny
         5V7qinsghUyczMvgU0z8TbZzCPP5UdaOd3pPJ8DEYV4xUIC2fB5zxuYIyiqWYGcl7z
         yBofYT362EJp5VA/u3OTHqKQ9vjMuc/0pUa4DkoAwTvokpwectqOhMJuXxMxygBBha
         GDswlJLD1PLIk83PPDvTiINzXB8NpsExENQ+moaHpcD6ncPj1V6duAhbCAUB67EyeJ
         ju1PBCQFLO+xQ==
Date:   Mon, 31 Jan 2022 10:04:53 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, ndesaulniers@google.com, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] tools: Help cross-building with clang
Message-ID: <YfgWtQkTj69zPZY/@dev-arch.archlinux-ax161>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
 <20211216163842.829836-2-jean-philippe@linaro.org>
 <YfSUAPnZX/wP8U+p@archlinux-ax161>
 <Yfft1sqfXGTAjwJ8@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfft1sqfXGTAjwJ8@myrica>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 31, 2022 at 02:10:30PM +0000, Jean-Philippe Brucker wrote:
> Hi Nathan,
> 
> On Fri, Jan 28, 2022 at 06:10:24PM -0700, Nathan Chancellor wrote:
> > > diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> > > index 071312f5eb92..b0be5f40a3f1 100644
> > > --- a/tools/scripts/Makefile.include
> > > +++ b/tools/scripts/Makefile.include
> > > @@ -87,7 +87,18 @@ LLVM_STRIP	?= llvm-strip
> > >  
> > >  ifeq ($(CC_NO_CLANG), 1)
> > >  EXTRA_WARNINGS += -Wstrict-aliasing=3
> > > -endif
> > > +
> > > +else ifneq ($(CROSS_COMPILE),)
> > > +CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
> > 
> > Apologies for noticing this so late, I only ran into this recently.
> > 
> > This line causes a warning when running 'make clean' when
> > '$(CROSS_COMPILE)gcc' does not exist in PATH. For example:
> > 
> > $ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- LLVM=1 LLVM_IAS=0 clean
> > which: no powerpc-linux-gnu-gcc in ($PATH)
> > 
> > I only have powerpc-linux-gnu binutils in my PATH, not GCC, as I am only
> > working with clang.
> > 
> > This happens because of the 'resolve_btfids_clean target', which always
> > runs when running the 'clean' target on an in-tree build (since
> > $(objtree) = $(srctree)).
> > 
> > I tried looking into the best way to fix this but I am not at all
> > familiar with the tools/ build system; would you mind taking a look?
> > I see some machinery at the top of tools/bpf/Makefile for avoiding
> > running some commands under certain commands but I am unsure how to
> > shuffle that around to make everything work.
> 
> I think it's simpler than that, we should just suppress the errors from
> 'which'. It's fine that $(CROSS_COMPILE)gcc doesn't exist and
> $(GCC_TOOLCHAIN_DIR) is empty, but 'which' should keep quiet about it.

Ha, that's what I get for looking into something at the very end of a
long work week because that is a great and simple solution I probably
would not have seen :)

> I did test this patch with cross-build and no gcc, but Debian's 'which' is
> quiet by default so I missed the error. I'll send a fix shortly.

Ah, that is an interesting observation. TIL that Debian rolls their own
which [1], versus most other distros, which use GNU which [2].

I will keep an eye out for your patch so I can review it.

[1]: https://salsa.debian.org/debian/debianutils/-/blob/de14223e5bffe15e374a441302c528ffc1cbed57/which
[2]: https://savannah.gnu.org/projects/which/

Cheers,
Nathan
