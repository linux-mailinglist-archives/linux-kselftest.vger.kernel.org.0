Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D5287CCE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgJHUFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 16:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgJHUFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 16:05:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15130C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Oct 2020 13:05:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so5270996pgm.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Oct 2020 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kRozOJcU/8V0BnQ/n2Fog1pXhHDXJtLHefk6yYZwAN8=;
        b=bBDNCeAgq1I7erOfy25vjMcgnkKPvmMlPtfxklCapNKDiUnlbOFdutmLvIAdlyM7K5
         d/YzuPSsYdWgiIVw6M81k6GKubvBuUtqHWcxNneMwH8+3t5VdU89+kxsRx/0JWrl0X1v
         FfQIAC/NDJ752DsDg3F6aKUoHwGy1jHzB0Jgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kRozOJcU/8V0BnQ/n2Fog1pXhHDXJtLHefk6yYZwAN8=;
        b=bNso+QIC5WXUsWHksRU7BXrc1RbDmbhVJeB25D6E7lDJbAAHr9/Jr07ifXJhsER7Ii
         MkeVuONXQ5mNK3YK0rtpNrxoB81vLMaVb9RQRJxgK5DnIhorDvoz16/tFPLVQ9PIRRWg
         S6T6AffUzVqYlnxXIGqdfvF5g54vLXg7u04Eril3hhPKSyfdvHv2CQJjk64BXLwSEx2o
         iNfkKFzS7b+4vgXQyVzY4DSaUY1WshlE1JTLPUVtAcNl6MRA8KekgErzq+Ftd0mZACI+
         cuWq/taZpHPkhvcrFsZ/48BqcBl3t3toRnJU6Lmrb+Yl2WyVVvIpeAdbmr06A3z3ruTE
         K29w==
X-Gm-Message-State: AOAM5334czrOaagU0Z/zwTxTeg/1EHTkm0p1CtMIkZy1tBJtDV6Vtax+
        tHcMPSBQ/Fhd58D8z+i+1PaFQw==
X-Google-Smtp-Source: ABdhPJzAJp9mz1b2kvn/8cvjH2bFw3wc5OktyHnOltsWM0NhPa5ahuymaawPuutDX6+tJ4KwBfd8tA==
X-Received: by 2002:a63:584e:: with SMTP id i14mr451658pgm.329.1602187518509;
        Thu, 08 Oct 2020 13:05:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm8237222pfe.108.2020.10.08.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:05:16 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:05:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 01/13] selftests: filter kselftest headers from command
 in lib.mk
Message-ID: <202010081305.32C244AB5@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-2-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008122633.687877-2-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:21PM +0300, Tommi Rantala wrote:
> Commit 1056d3d2c97e ("selftests: enforce local header dependency in
> lib.mk") added header dependency to the rule, but as the rule uses $^,
> the headers are added to the compiler command line.
> 
> This can cause unexpected precompiled header files being generated when
> compilation fails:
> 
>   $ echo { >> openat2_test.c
> 
>   $ make
>   gcc -Wall -O2 -g -fsanitize=address -fsanitize=undefined  openat2_test.c
>     tools/testing/selftests/kselftest_harness.h tools/testing/selftests/kselftest.h helpers.c
>     -o tools/testing/selftests/openat2/openat2_test
>   openat2_test.c:313:1: error: expected identifier or ‘(’ before ‘{’ token
>     313 | {
>         | ^
>   make: *** [../lib.mk:140: tools/testing/selftests/openat2/openat2_test] Error 1
> 
>   $ file openat2_test*
>   openat2_test:   GCC precompiled header (version 014) for C
>   openat2_test.c: C source, ASCII text
> 
> Fix it by filtering out the headers, so that we'll only pass the actual
> *.c files in the compiler command line.
> 
> Fixes: 1056d3d2c97e ("selftests: enforce local header dependency in lib.mk")
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Ah yes, thanks!

Acked-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
