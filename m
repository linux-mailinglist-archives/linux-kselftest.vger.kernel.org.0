Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C609D3B473A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYQNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFYQNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 12:13:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9DC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 09:11:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h2so13090644iob.11
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JtgY0n59q1tx+fNR/p97CokvvcooLuw5v54/bKgT7rw=;
        b=fAtADPy5FgOFszhL67dMa3mnew1zEdsDxhzn/677t100TxxAfifwQAP1vEZASjeROI
         zRCJHe2tg4SqNKjzLAQUvmSgVWGLahxHbds+MCRctu1CF+ZjRbjzfURdfFg46RD5YJSa
         cBQrnRUvvairhk/FRMD0+a2izP1keM8X7X+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtgY0n59q1tx+fNR/p97CokvvcooLuw5v54/bKgT7rw=;
        b=dRH5b7+60EJeSATiow0+sleJv+h9RJEJ0oQkXlk+eQxpdjhLZP0wN5zqUdzrZOjEVS
         x7jlp7nVvHqFnugS1aO89iZ3MOpMIhXpYidkgD2VUErP9lvOkRVltzjap4xizp+EWybb
         qfYadQA2qQo33mSBoO2nEZv9wXSpUntM+1xglwqUcFGLdleCm0sU5yHSbTxVaHExByvG
         rQubahIJ7ijTU3yEPQgyFlfO+u9pjQm2H3syrevkmJnc/F9CL/IpqmM7Ax/Fn+9DfS14
         kxskS9tdSdX/RmCHtp/m0gO/R0S/3ca9c6G1I6SIY6nur4CIL+PIkh2mSyAUr3tZlAb2
         tpJw==
X-Gm-Message-State: AOAM530n/GkdA5qnSVprd6wJAqwJi0HKi/n9S29sABnFFmfC4YaroM9n
        qy+Y2ZR+XYKzptiz2NsD+wYbsA==
X-Google-Smtp-Source: ABdhPJz2xxRRobusj36f4+k4VDOmedqH/Sce+3lN0J/PPd28HDi27zCwx183pTyNvjqKKDnoof+qpw==
X-Received: by 2002:a02:ccab:: with SMTP id t11mr10239274jap.1.1624637490553;
        Fri, 25 Jun 2021 09:11:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c10sm1546469ild.72.2021.06.25.09.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 09:11:30 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix merge issue in suite filtering test
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210625111603.358518-1-davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <99c2564c-4175-7e3e-84c3-3bcb6d4f9d58@linuxfoundation.org>
Date:   Fri, 25 Jun 2021 10:11:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625111603.358518-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/25/21 5:16 AM, David Gow wrote:
> There were a couple of errors introuced when
> "kunit: add unit test for filtering suites by names"[1] was merged in
> c9d80ffc5a.
> 
> An erroneous '+' was introduced in executor.c, and the executor_test.c
> file went missing. This causes the kernel to fail to compile if
> CONFIG_KUNIT is enabled, as reported in [2,3].
> 
> As with the original, I've tested by running just the new tests using
> itself:
> $ ./tools/testing/kunit/kunit.py run '*exec*'
> 
> [1]: https://lore.kernel.org/linux-kselftest/20210421020427.2384721-1-dlatypov@google.com/
> [2]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/6IKQX5JXZF7I3NFH4IAWUMHXEQSCPNDP/
> [3]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/EKY7ZH5YDCCTSJF2G7XFPMGIXQSUVD3Y/
> 
> Fixes: c9d80ffc5a ("kunit: add unit test for filtering suites by names")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This is another fix for the kunit-fixes branch, where there seems to
> have been an issue merging the "kunit: add unit test for filtering
> suites by names" patch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=c9d80ffc5a0a30955de0b8c5c46a05906d417800
> 
> Again, feel free to squash this into the original patch if that works
> better.
> 

Thank you. My bad. Applied to kunit-fixes now.



thanks,

-- Shuah
