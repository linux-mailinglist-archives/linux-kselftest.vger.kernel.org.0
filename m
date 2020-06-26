Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20920BB4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgFZVUQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFZVUQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:20:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7FC03E97B
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:20:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so4709457plo.7
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRqRadojwuG0TG7LIG7vreVHmh8dDyxVABNeNVIB/fI=;
        b=fTouV6uau5MrWNpKLBIlplSK4yTsQr8vqkatlxEFGVAIO5/btu/+Y99/2O5JB2z2XB
         0kip19LO2KxaHV2afumDNH48XY2qSD9F6oCsUOcLORAd/9N7qTzU9HoDp25R4vEa6OPQ
         jxl5SwiNpmF8rxPqXZdgmxh0OqDpkM/65iCs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRqRadojwuG0TG7LIG7vreVHmh8dDyxVABNeNVIB/fI=;
        b=rSKXWFpvczlGG1zS4D4BUBoXIkpYa/4Xw6G4dT/72LVDjs59g/xCfWAuv27woKGfMU
         t1IyijBN+Pvqfi6fS/16YLsFAoxC7Jljovua9wXqZ718mxcchniqZU87kU4JBVDfit/T
         6MkhJlWeqfsWdxcbXKOhb4WSSmuZxEtr3aJ+CIWKHfkXlUhiWBuX8bG2jbZzSdmHgYyT
         oSFVBurlRduisvPVNvH/Gl+ZmjQG/JWxtJ2gmFfGn6N8YtfsCkazr8y7dX6znVVmVcAD
         gCgCrrgNuk738XEgc9lD29WbfdmEtQb5u9XahM2/DJek4kWlZT1Fx4Tv2PPTHOGzec9D
         QrFw==
X-Gm-Message-State: AOAM5314hXt1NkQ1tP9WJh77ewXyU4caisKlD9atX303oZmqPdd7SR6E
        aVOYsJC9BtjnYdpyAUXhAlHPgA==
X-Google-Smtp-Source: ABdhPJzanFCPjbVP6IP78jIA22FsZ8y83mQsxAnBAhwVFXPMMilrtj09ty+spenAUXCHEiznsVyZsA==
X-Received: by 2002:a17:90a:2b8f:: with SMTP id u15mr3731333pjd.98.1593206415418;
        Fri, 26 Jun 2020 14:20:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o22sm26668076pfd.114.2020.06.26.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:20:14 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:20:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit
 test suites
Message-ID: <202006261416.F4EAAE47E3@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-2-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
> 
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index db600ef218d7d..4f9b036fc9616 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -881,6 +881,13 @@
>  		KEEP(*(.con_initcall.init))				\
>  		__con_initcall_end = .;
>  
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */

Nit on naming:

> +#define KUNIT_TEST_SUITES						\

I would call this KUNIT_TABLE to maintain the same names as other things
of this nature.

> +		. = ALIGN(8);						\
> +		__kunit_suites_start = .;				\
> +		KEEP(*(.kunit_test_suites))				\
> +		__kunit_suites_end = .;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS							\
>  	. = ALIGN(4);							\
> @@ -1056,6 +1063,7 @@
>  		INIT_CALLS						\
>  		CON_INITCALL						\
>  		INIT_RAM_FS						\
> +		KUNIT_TEST_SUITES					\
>  	}

Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
uses INIT_DATA.


-- 
Kees Cook
