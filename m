Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF58B832F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbfISVRO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 17:17:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32924 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389206AbfISVRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 17:17:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so871995pls.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2019 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xj8/5rMbJMvQLHdvqTpGAyaZkQ0QmWr6aPMc+dirhyE=;
        b=QXarkbJ94PPe/jDAampPvBpRv6YtJTBdHfaF9OoeyZUYDf/2GIlOfga8FszHtRrdxo
         Ywau71UlNDGyKBjInwec8HhZYERnCxZaRSkaY9U/ZtX8ZDTvXZaRGCf/qsI/E9679ffX
         N9GrXRSzw7XDn9WvdyLV/nwAZ3tXC+jin9CiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xj8/5rMbJMvQLHdvqTpGAyaZkQ0QmWr6aPMc+dirhyE=;
        b=rh2uaqeRkcDLw+nWhfgnAT0koBvwUGOfCo2RA2j1TswkNw4tlst8bR7afqMT2oFT/c
         tA3JO1HRg+G5LNCugnKJ5iyhOGTBPSiBcWwgbfJukLmr9GvXVYKjmgLGkmNousgH4HZr
         00vQyXw5A/LmMZicwJUMO1E94kKkWPrBssDL0DaBQORnCZ6+mR5GtRimMqOkAO0/eP3K
         +0NItemdz/iaMsNULzVWf9DyJ4t55YkihI841bKweSMN6DBvGj0AVWsJ89V0lph61aGh
         6YGU72owHPiECARuNSbu1X1FSoVEUmiaLKFIb5Wlas39ZPvtfMBL2MuroU5OvIjR5n+P
         U2uA==
X-Gm-Message-State: APjAAAUh9h+fAjQ3nOGFvmYZToJfqpUCrtpjNj1978hH7V6j91uZR+K0
        LURs5YlfmI8HALlhNvIIyg9jwA==
X-Google-Smtp-Source: APXvYqz2PSO7y+O/A1ytcHFtxVA1uYd2UOVylwoYJopRhmw3YJGhHI5WmIvCzkcOQrtdO8V9Md5dFA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr12221663plz.101.1568927833530;
        Thu, 19 Sep 2019 14:17:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j23sm11856902pfn.75.2019.09.19.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:17:12 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:17:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout per
 test
Message-ID: <201909191411.3FA57CBCF3@keescook>
References: <201909191102.97FA56072@keescook>
 <20190919185525.GD21254@piout.net>
 <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 19, 2019 at 02:09:37PM -0600, shuah wrote:
> On 9/19/19 12:55 PM, Alexandre Belloni wrote:
> > On 19/09/2019 11:06:44-0700, Kees Cook wrote:
> > > Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per
> > > test") solves the problem of kselftest_harness.h-using binary tests
> > > possibly hanging forever. However, scripts and other binaries can still
> > > hang forever. This adds a global timeout to each test script run.
> > > 
> 
> Timeout is good, but really tests should not hang. So we have to somehow
> indicate that the test needs to be fixed.

Totally agreed, which is why I changed the reporting to call out a
"TIMEOUT" instead of just having it enter the general failure noise.

> This timeout is a band-aid and not real solution for the problem. This
> arbitrary value doesn't take into account that the test(s) in that
> particular directory (TARGET) could be running normally and working
> through all the tests.

Even something that looks like it's making progress may still be hung or
won't finish in a reasonable amount of time.

> We need some way to differentiate the two cases.

I don't think it's unreasonable to declare that no test should take
longer than some default amount of time that can be tweaked via a
"settings" file. It gives the framework the option of easily removing
tests that take "too long", etc. If the "timeout=..." value was made
mandatory for each test directory, then the framework could actually
filter based on expected worst-case run time.

> > > To make this configurable (e.g. as needed in the "rtc" test case),
> > > include a new per-test-directory "settings" file (similar to "config")
> > > that can contain kselftest-specific settings. The first recognized field
> > > is "timeout".
> > > 
> > 
> > Seems good to me. I was also wondering whether this is actually
> > reasonable to have tests running for so long. I wanted to discuss that
> > at LPC but I missed the session.
> > 
> 
> There is the individual test times and overall kselftest run time. We
> have lots of tests now and it does take long.

This patch seeks to implement a "timeout for a single test from
kselftest's perspective". Some "individual" tests have many subtests
(e.g. anything built with kselftest_harness.h) giving us the whole
subtest issue. I think my solution here is a good middle ground: we
specify the max run time for each executed test binary/script.

It's not clear to me if a v2 is needed? Is this patch fine as-is?

Thanks!

-- 
Kees Cook
