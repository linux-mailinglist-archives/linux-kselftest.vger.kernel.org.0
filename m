Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFC166B67
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 01:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgBUAQE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 19:16:04 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33169 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgBUAQE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 19:16:04 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so1625168pjs.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSOXy59NaxNEGkVUjyIUAzgGlKx0xSBMnajwRhUlBTg=;
        b=oZBFAmZGwNpWsKFxlgvf0mX4lmV48p5sBFBFmkb2qY6JOGXSZchINliLWhfrC0TSPH
         iXbmiJf/r0fGxptXI0Y1O+CIU1KGPjXLE+pqPw3xWLyGNqbzxhQ8vR5Bm1+ZWRNYo4xx
         FjnYi/0OovC17X8MrsPBCFUf3oa4HURWyd09w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSOXy59NaxNEGkVUjyIUAzgGlKx0xSBMnajwRhUlBTg=;
        b=aI4UZAuAG86Q3vJPN4SvlWr29LIajJmC38cOLZgCz3tMgnM62uXqcc+pOT3JiEUJ/y
         n89I/NvWol2+3wWGIDvOBGxT/HtT7mF2mMiA9t43horWkd469J7NTd+4FNO/kvQLk/9q
         lFNPYGaMrTYdDTpRS6Y8b6fk4HJ8PaXQrFm0VBgbWmLXawoMhGS3er66UquiLMfZ1y0U
         zEmnIfMmK+c4crWzPlJlB4LvX0iWRGXLgUGuq07ILGzeX6StfDe9RVILlGyKncNZdSRp
         f8Z5ONjudAoWQkjIXWXQ/bYQl1IvpJXYvfue4UfQjxA+kcDN8ziTvnpF7AmjwXX/q36v
         H3kw==
X-Gm-Message-State: APjAAAXnUU0IR5BwFEvvba5lytbhQqyV8Gcz1LpdA9ouoHfhUUEkkVWu
        RPvDHv2C1Ia3e/pxH2Oe/vb/hg==
X-Google-Smtp-Source: APXvYqyF2qNqnrPkSbjfbjdMr5QKa3bRBq5Ixq8bcwoCyGhS3AdmZJfxbkBEwtliGl9osRgA4SNgIw==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr33566822plr.280.1582244163881;
        Thu, 20 Feb 2020 16:16:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fz21sm523554pjb.15.2020.02.20.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 16:16:03 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:16:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
Message-ID: <202002201610.2B149A6D@keescook>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
 <31b066c2-d1c9-1592-48cd-bccb4b3a624a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b066c2-d1c9-1592-48cd-bccb4b3a624a@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 19, 2020 at 09:16:03AM -0700, shuah wrote:
> On 2/17/20 8:36 AM, Cristian Marussi wrote:
> > Hi
> > 
> > n 17/02/2020 11:09, Naresh Kamboju wrote:
> > > The selftest lkdtm test failed on x86_64 and arm64.
> > > am I missing any pre-requisite?
> > > 
> > > Boot log:
> > > [    3.297812] lkdtm: No crash points registered, enable through debugfs
> > > 
> > 
> > from your logs I cannot deduce anything useful, but in our CI I've got similar issues
> > since the 10/12th of Feb...
> > 
> > TAP version 13
> > 1..71
> > # selftests: lkdtm: PANIC.sh
> > # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> > not ok 1 selftests: lkdtm: PANIC.sh # SKIP
> > # selftests: lkdtm: BUG.sh
> > # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> > 
> > so I suppose this and a bunch of other (probably new) tests are simply
> > missing a bit of CONFIGs... (but I have still to look into this properly)
> > (not sure if this also is your case either...)
> > 
> > Regards
> > 
> > Cristian
> > 
> 
> Hi Kees,
> 
> Any ideas on what this is about? Missing config or something else?

In the first case, I'm not sure what's happening -- the logs don't seem
to show anything, but the lkdtm should be available (from the boot log).

In the second case, yes, it looks like missing CONFIG_LKDTM (the test
even has a "config" file). Either CONFIG_LKDTM=y or CONFIG_LKDTM=m will
work (the test running will attempt to load the lkdtm module if it's
missing).

A final option is that either the debug filesystem isn't mounted, or is
mounted somewhere "non-standard"? (I'd expect a lot of things to fail...)

-Kees

-- 
Kees Cook
