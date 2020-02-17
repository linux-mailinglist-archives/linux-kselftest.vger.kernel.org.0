Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF90D161870
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2020 18:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBQREp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Feb 2020 12:04:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43475 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgBQREo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Feb 2020 12:04:44 -0500
Received: by mail-yb1-f193.google.com with SMTP id b141so8989226ybg.10;
        Mon, 17 Feb 2020 09:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vPLpeSe0bKkS49okauHP5fVKtMg3RhIDXruX05dtGX8=;
        b=LfOX4D/PTIGCnYfTvq+ADMCpaVrTm8vspeWtE6AWPdFAZKq2T9anP5EHCU3J6vE5rX
         O+IBBqXFskHMzEU8qcTz4DaLOCRGheG+BF21M0S/Ru4mislM/hvcUN418f8gXkFdaje7
         ZHc6ZhfNcKnewUFnVsbPAiCiPXe38lJKDoiLLXPlb0IVP5ZTd+Erw255U12Ba6nz/kO+
         cksC6T/fpsD6w3ONjsjGdDuLbi6AZuJ4UC3x5yrLVOolpNR4QgXEHW6xQ2zNC/mVqVC6
         CcPjTObHWyPJsfIUhH6BvhuobWLjrOzrDiSLZwyKI0eCDCnGXq3NeAMB6e+rrpDS/KDE
         UkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPLpeSe0bKkS49okauHP5fVKtMg3RhIDXruX05dtGX8=;
        b=YLNtukE6l72hyN/yG3pd7/ufptgywO83mC8hzp/CGgSIg1zm3UIWAkJ4KIfGcgD73/
         PWf3fvLSEAPSQ0LBZgf7pCgT/ilbfrlQ+S7jeGOzdPpkRboxNCGEHE9G6OWfW2lkDMmm
         Y/AiKKhj8W18sFbhCANC3oEO2BvEA+wIqc+qaZ6HP2fmBfUC4/bqtA0dJdBd1h6Ma8IE
         mcWZn5cps6ariwHcv2gpDR1MEO+Yv80/w9OqaVLf+gTTn9+hvChKtWWvDmW4/j6e+ElI
         tj3psjnn1g+50tx77CfZD6YpuGvcd500/J8fZbvvkFdKQ40mVW/Jgd4X7OLO1C9mdJlk
         oWDw==
X-Gm-Message-State: APjAAAVqjXqS2ec7XmnOZ0H9yHd8r83jGQTGMmpDR3364AMvawURuJY1
        VhSN/iGqBE3UveCchqeOMzk=
X-Google-Smtp-Source: APXvYqzGlUZIsYYiKriIz2BhmO+hg4HO/NIKKz6IDfn53XLaaE1DGqXWxL9gY+5u8szaTp/bERwFkQ==
X-Received: by 2002:a5b:885:: with SMTP id e5mr15959811ybq.449.1581959083612;
        Mon, 17 Feb 2020 09:04:43 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a74sm475022ywe.42.2020.02.17.09.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:04:43 -0800 (PST)
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, davidgow@google.com
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
 <c42ac237-476a-526f-b445-61e7a63bc101@gmail.com>
 <alpine.LRH.2.20.2002171539210.21685@dhcp-10-175-161-198.vpn.oracle.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <51e1d60c-a232-bbef-7e6a-8695df684ae6@gmail.com>
Date:   Mon, 17 Feb 2020 11:04:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.2002171539210.21685@dhcp-10-175-161-198.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/20 9:45 AM, Alan Maguire wrote:
> On Wed, 12 Feb 2020, Frank Rowand wrote:
> 
>> On 2/7/20 10:58 AM, Alan Maguire wrote:
>>> add debugfs support for displaying kunit test suite results; this is
>>> especially useful for module-loaded tests to allow disentangling of
>>> test result display from other dmesg events.
>>>
>>> As well as printk()ing messages, we append them to a per-test log.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---

< snip >

>>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>>> index 9242f93..aec607f 100644
>>> --- a/lib/kunit/test.c
>>> +++ b/lib/kunit/test.c
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/sched/debug.h>
>>>  
>>> +#include "debugfs.h"
>>>  #include "string-stream.h"
>>>  #include "try-catch-impl.h"
>>>  
>>> @@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
>>>  	}
>>>  }
>>>  
>>> -static size_t kunit_test_cases_len(struct kunit_case *test_cases)
>>> +size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>>>  {
>>>  	struct kunit_case *test_case;
>>>  	size_t len = 0;
>>>  
>>> -	for (test_case = test_cases; test_case->run_case; test_case++)
>>> +	kunit_suite_for_each_test_case(suite, test_case)
>>>  		len++;
>>>  
>>>  	return len;
>>>  }
>>> +EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>>>  
>>>  static void kunit_print_subtest_start(struct kunit_suite *suite)
>>>  {
>>>  	kunit_print_tap_version();
>>> -	pr_info("\t# Subtest: %s\n", suite->name);
>>> -	pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
>>> +	kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
>>> +	kunit_log(KERN_INFO, suite, "1..%zd",
>>> +		  kunit_suite_num_test_cases(suite));
>>
>> The subtest 'is a TAP stream indented 4 spaces'.  (So the old code was
>> also incorrect since it indented with a tab.)
>>
>> kunit_print_ok_not_ok() has a similar indentation issue.
>>
> 
> I'll defer to Brendan on the TAP format stuff if you don't
> mind; the aim here is to preserve existing behaviour.  I
> think it might be better to tackle TAP format issues in
> a separate patchset.

My first attempt to respond started with "That is a reasonable approach".
But on reflection, the patch is adding code that is incorrect (even if
the new code is replacing existing code that is incorrect).

If you don't want to change the spacing in patch 1/2, then please add
patch 3/3 that corrects the spacing.  That allows patches 1/3 and 2/3
to preserve existing behaviour.

Thanks,

Frank

> 
> I also updated the documentation patch in v4 (patch 3)
> to incorporate the suggested wording.
> 
> Thanks for the careful review!
> 
> Alan
>  
>>

< snip >
