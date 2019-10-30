Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E45EA3EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfJ3TQo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:16:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41008 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJ3TQn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:16:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id p26so2249249pfq.8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SkNeb7N/RtOHBRU9IGeZjCb9lUHhzMvIRm1lPkdmY94=;
        b=Wmz4BN9I7WolTdUk59TZOxzjMRRja95bL9zO5kOJ57UJdIVxIrDaZMbHW4erd4Fros
         2hPOZirzIw1BFU5a69eAT/lwCab1RZEA7hAgyA5U3O0Nm8S/HI/c6oEUtgJbTHYu6Fbg
         su7wV2pd4MglPXtDzkpNzhd21Spi3W0VbfdXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkNeb7N/RtOHBRU9IGeZjCb9lUHhzMvIRm1lPkdmY94=;
        b=T0j1J+iR2hCxCZzEtHvTHDQsYojks/LFahxlStSdFWpNAFJPlnmpoeoiZKe7dxe2dZ
         qMQZN6tv9KexLLAbYABkulvni6EPiEGRKdBnGsZTw3z71ySp5tWmJObI/BAZ0S42Gl+i
         trc1vHe83J7bqFcAGi5eUYb0RYKMWWjCFVukxICEMyzF8aqXMJduVdjyYi4SyShV6L04
         1290AmRqlIlvZi/LaaEjCTjMusQTkKp/r+bP3mc5Oxv3a9CosgaQ91soEW4dk4M33edV
         gRafql9aKBUVfq5jUM01JsBO4jYPiwuB3NVhMdQG9jvlFbZQFRYi/o+iJ4vQ0PCzSHGg
         5vDw==
X-Gm-Message-State: APjAAAXHublEPeh3DLVf38oKOkwz1b1JhBHOgxlPl9jnEHliKizZD26A
        ZRMYBM0Yk7d5K5gnBvHuXfKvYw==
X-Google-Smtp-Source: APXvYqxfh9ztLk2WfEQDJ7irJePRmGVvoJEr3DPY5+qzc1/dbiyg9erl6+par2Vm529nXY8KHdViig==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr982679pfi.73.1572463001813;
        Wed, 30 Oct 2019 12:16:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17sm719419pfh.121.2019.10.30.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:16:41 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:16:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-hardening@lists.openwall.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] kselftest: Add test runner creation script
Message-ID: <201910301216.5C3F9BA010@keescook>
References: <20190405015859.32755-1-tobin@kernel.org>
 <20190405015859.32755-3-tobin@kernel.org>
 <CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 06:15:22PM +0530, Naresh Kamboju wrote:
> Hi Tobin,
> 
> On Fri, 5 Apr 2019 at 07:30, Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > Currently if we wish to use kselftest to run tests within a kernel
> > module we write a small script to load/unload and do error reporting.
> > There are a bunch of these under tools/testing/selftests/lib/ that are
> > all identical except for the test name.  We can reduce code duplication
> > and improve maintainability if we have one version of this.  However
> > kselftest requires an executable for each test.  We can move all the
> > script logic to a central script then have each individual test script
> > call the main script.
> >
> > Oneliner to call kselftest_module.sh courtesy of Kees, thanks!
> >
> > Add test runner creation script.  Convert
> > tools/testing/selftests/lib/*.sh to use new test creation script.
> >
> > Testing
> > -------
> >
> > Configure kselftests for lib/ then build and boot kernel.  Then run
> > kselftests as follows:
> >
> >   $ cd /path/to/kernel/tree
> >   $ sudo make O=$output_path -C tools/testing/selftests TARGETS="lib" run_tests
> 
> We are missing "kselftest_module.sh" file when we do "make install"
> and followed by generating a tar file "gen_kselftest_tar.sh" and
> copying that on to target device and running tests by using
> "run_kselftest.sh" script file on the target.

Yikes -- there's a problem with gen_kselftest_tar.sh using the wrong
directory. I'll send a patch...

-Kees

> 
> Could you install the supporting script file "kselftest_module.sh" ?
> 
> Error log,
> -------------
> # selftests lib printf.sh
> lib: printf.sh_ #
> # ./printf.sh line 4 ./../kselftest_module.sh No such file or directory
> line: 4_./../kselftest_module.sh #
> [FAIL] 1 selftests lib printf.sh # exit=127
> selftests: lib_printf.sh [FAIL]
> # selftests lib bitmap.sh
> lib: bitmap.sh_ #
> # ./bitmap.sh line 3 ./../kselftest_module.sh No such file or directory
> line: 3_./../kselftest_module.sh #
> [FAIL] 2 selftests lib bitmap.sh # exit=127
> selftests: lib_bitmap.sh [FAIL]
> # selftests lib prime_numbers.sh
> lib: prime_numbers.sh_ #
> # ./prime_numbers.sh line 4 ./../kselftest_module.sh No such file or directory
> line: 4_./../kselftest_module.sh #
> [FAIL] 3 selftests lib prime_numbers.sh # exit=127
> selftests: lib_prime_numbers.sh [FAIL]
> # selftests lib strscpy.sh
> lib: strscpy.sh_ #
> # ./strscpy.sh line 3 ./../kselftest_module.sh No such file or directory
> line: 3_./../kselftest_module.sh #
> [FAIL] 4 selftests lib strscpy.sh # exit=127
> selftests: lib_strscpy.sh [FAIL]
> 
> - Naresh

-- 
Kees Cook
