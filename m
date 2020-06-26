Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE820BB4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgFZVU6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZVU5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:20:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27EEC03E979
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so5160753pfe.4
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3v+OF208XUrXXCW8iavBboKmEzUrVOLh/1qRIFYBNoU=;
        b=Nvb+ggfcnASyU5yhjpLMt6peljFaQfiHoHtcJLghh8SOevSBFghSaqeuZcJueBgfGg
         WZgC5DlW9UptaHMBha2Yi+d7BZxdIdIsRVIxr6sT/EGiBCa7riY2jk+3OoPm9Dm2cBgE
         Oe16AFCAHqXoIwIvcpbOh0WaehkQSk4CbVyto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3v+OF208XUrXXCW8iavBboKmEzUrVOLh/1qRIFYBNoU=;
        b=IU6lSEngPLu/AuRegmZLJf8LHnhU7VL3zBHZ9lmn7SweLmEiO0VuM3waiwLqamBBum
         Z0zcINLmiOhNm4MVGt938rcOwq8NXQnaET2af549akhWG0HRdlPdlSFfofkepTTR+q3e
         hK1u/l1H+Y8cH2U2Q8032bE78+Sw1AhvnmgWv7wqLMbEyqIG/EuedzfbQ4ULhfgr+Uq9
         G6RJO7wuLyczz+/j74ok3V2GHHr2W/hZXc9iszR/9zz5wzMrzE30OkvSxA3Rsf2+EoD5
         +Emj3C2ICle4ZSHQ+wbRxwT2rLIOK4G2ibqYe54l2+u3xhbDV2aSj9U17nbCXG0NTzIo
         QOLQ==
X-Gm-Message-State: AOAM530RbJvDwRx8aarVwVcPIDVk6SvyLf7EPpjKlirKzY/bFzvfr5FZ
        EVMlvzPS8IrVvPCVgV6bGnPODQ==
X-Google-Smtp-Source: ABdhPJwbIChL+NPgK/ZZynTiHBVtRn0Pm3+yrJJiDfCLTGOFZovkou+N1wtQIeNq/GeuCZhx4HWPUQ==
X-Received: by 2002:aa7:9e09:: with SMTP id y9mr4461464pfq.314.1593206457324;
        Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b71sm17221453pfb.125.2020.06.26.14.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:20:56 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:20:55 -0700
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
Subject: Re: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test
 suites
Message-ID: <202006261420.02E8E62@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-3-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:07PM -0700, Brendan Higgins wrote:
> Add a linker section to arm64 where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 6827da7f3aa54..a1cae9cc655d7 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -181,6 +181,9 @@ SECTIONS
>  		INIT_RAM_FS
>  		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
> +	.kunit_test_suites : {
> +		KUNIT_TEST_SUITES
> +	}

See my reply to 01/12. Then this patch can be dropped. :)

>  	.exit.data : {
>  		EXIT_DATA
>  	}
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

-- 
Kees Cook
