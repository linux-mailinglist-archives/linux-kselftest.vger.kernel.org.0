Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C116117AD74
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 18:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCERmR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 12:42:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgCERmQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 12:42:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so3081673pgs.9
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WO9CL2c1w4olgPjEPwS6Ra/FLfu00HcXGcMtO9zfexo=;
        b=PIZuvBOBbK3Zt8CK4II7StLN9lnSky75gasV00eDluG4GZVnGAqsV8rtG2DADakRIV
         QwSayYbgDZLPql+x0FSzCZf58gV1W67fETimxIpXAEO0CASpdr9y1wzHwq8v9Rt81cES
         7eaM4UY2J/43MX9y2LuYLagFwi6m425NaHOEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WO9CL2c1w4olgPjEPwS6Ra/FLfu00HcXGcMtO9zfexo=;
        b=p3IS4QpSKx8JomZ9uVYLj2Xtztg06yN3Q5ju9mRvGSzw2OmVu9zkRJmOlvuyALrrTk
         ieqjGYOLaKDEWhq2MLi1fZtGlusa9pzFRkgbw05RpelZSNCSSlf9Kfnh3pki44Lxj0fK
         dK+wE+MPBQiBQ3e+W0KoDIPRuPOIXqvxWrcwMFkPGlyrkFfeASfe8uHL2Y4hOCDRURox
         n/4g2kdy3fRBWUwdYeE0Eew2KhxR4GGF9p1wTWheyL+33Xvw3W8HkdNtdX/RLCo6nQje
         UYAKP+6rnyjScXbT1o6adJTM6aHbKWI6D+ZKC90kHAsFIHAK/ZZbnx4EuiXNfFm3nWGT
         jVbw==
X-Gm-Message-State: ANhLgQ0MB1/fEAPsY9ALh+np4BD+HAraWd5dMQayMfOyfx5PdxNr46KW
        mNquS9TGQVtFoGVvTPI7rZgByg==
X-Google-Smtp-Source: ADFU+vtufGH9z7DYE4GsADQLUgiWusxt/h6jaf64E8QlBevYNQbgpzzrcR6B/vZM0EejVK/cGcN8Bw==
X-Received: by 2002:a63:4a58:: with SMTP id j24mr8860917pgl.166.1583430135757;
        Thu, 05 Mar 2020 09:42:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cq15sm6975221pjb.31.2020.03.05.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:42:14 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:42:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests: Fix seccomp to support relocatable
 build (O=objdir)
Message-ID: <202003050937.BA14B70DEB@keescook>
References: <20200305003627.31900-1-skhan@linuxfoundation.org>
 <202003041815.B8C73DEC@keescook>
 <f4cf1527-4565-9f08-a8a2-9f51022eac63@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4cf1527-4565-9f08-a8a2-9f51022eac63@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 05, 2020 at 09:41:34AM -0700, Shuah Khan wrote:
> On 3/4/20 7:20 PM, Kees Cook wrote:
> > Instead of the TEST_CUSTOM_PROGS+all dance, you can just add an explicit
> > dependency, with the final seccomp/Makefile looking like this:
> > 
> > 
> > # SPDX-License-Identifier: GPL-2.0
> > CFLAGS += -Wl,-no-as-needed -Wall
> > LDFLAGS += -lpthread
> > 
> > TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
> > 
> 
> TEST_CUSTOM_PROGS is for differentiating test programs that
> can't use lib.mk generic rules. It is appropriate to use
> for seccomp_bpf

I don't follow? This suggested Makefile works for me (i.e. it can use
the lib.mk generic rules since CFLAGS and LDFLAGS can be customized
first, and it just adds an additional dependency).

> > include ../lib.mk
> > 
> > # Additional dependencies
> > $(OUTPUT)/seccomp_bpf: ../kselftest_harness.h

BTW, I see a lot of other targets that use kselftest_harness.h appear to
be missing this Makefile dependency, but that's a different problem. :)

> > (Though this fails in the same way as above when run from the top-level
> > directory.)
> > 
> 
> I didn't see this because I have been the same directory I used
> for relocated cross-build kernel. :(
> 
> Thanks for testing this. I know the problem here. all is a dependency
> for install step and $(OUTPUT) is referencing the objdir before it
> gets created. It is a Makefile/lib.mk problem to fix.
> 
> I will do a separate patch for this. This will show up in any test
> that is using $(OUTPUT) to relocate objects mainly the ones that
> require custom build rule like seeccomp.

Okay, cool. It looked to me like it lost track of the top level source
directory (i.e. "make: entering $output" ... "can't find
../other/files")

Anyway, I look forward to the next version and I'll get it tested. :)
Thanks for fixing this! I really like having a top-level "make" command
that can extract a single selftest; that's very handy!

-- 
Kees Cook
