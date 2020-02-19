Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9E163930
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 02:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBSBSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 20:18:55 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36391 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgBSBSz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 20:18:55 -0500
Received: by mail-yb1-f196.google.com with SMTP id u26so7986149ybd.3;
        Tue, 18 Feb 2020 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3P5cz57t37xwJenchSTYFOFaqISpD+NLl5dWuTR5us=;
        b=tuQ/QLWSMTHNxnuMpdJSRv/XURC6oUM8Pjuua84ym07G7E7qlw+3cghRMcEATEwYGM
         8IqfkwbFoSIcCT0pYfHrMgv3IELwIwY2bz30DnqmL49LEPhBzqgFixWCEVb7bIhCzS3J
         JYSLUPk9E9S9aC4tDeMcPvWC4dSmCquHrM+Nz65YYKOt1Wof/DbEDjQKJc3EqwUBPPeK
         odSg04UHK7N8b40lC+9p8s/JBvYoyQ9liEfLdRt8rglKKy0JPZ4/UBgHAmeDWgvbuGLh
         +qHjP3jJu49Uzsr6fHQ5PGvYoCU/4OHxl3yXsiPNoKmdqTqYh+VeguR59ip2SVvdbo1L
         9y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3P5cz57t37xwJenchSTYFOFaqISpD+NLl5dWuTR5us=;
        b=N9QTwfSIPSHWadxKlhPST4uGeGA4PcG2B7nVp8I7GcIpr+s2jUktlfLf+usOOAUvbr
         6mo7VxyznSsHoA02Qxrl9GGZ3qN76dsIHgfDJlqnn41B3H1taItTLYqtTUk4xl3lqok/
         fvU/KkPL90LpJFB/ub77J97PEwfyFbFud86tytRd0FS1TLox7vT7GoZIWfzMaLDZRd3K
         rLAjALRaWQXYmZf5Fn3jYg8V0MpUCnEWGYXdLNn5cooeRoLBc4a/7diBUEsYtB+G1h8q
         lO+cs4v99GprEi0Kavnjd4hlAqV/Anx969V66aQerZpPPG8ezKfAAbAfH/rOmQMH6tBr
         0n9g==
X-Gm-Message-State: APjAAAU//lXJJisRMjG0CWKLeOgaXCI5LLxR/aaToYvpKtx55n4kV9/Y
        Iwg5sHKv7FK+3BgDou6Q2uA=
X-Google-Smtp-Source: APXvYqxal5g0abulMEnQ2qIUU7f2LwlhQja5hx62UdLp1BNno67EDTOWLZriKk9fSHISH+QDUVnmkw==
X-Received: by 2002:a25:250c:: with SMTP id l12mr21156867ybl.162.1582075133872;
        Tue, 18 Feb 2020 17:18:53 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a202sm248553ywe.8.2020.02.18.17.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 17:18:53 -0800 (PST)
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
 <c42ac237-476a-526f-b445-61e7a63bc101@gmail.com>
 <CAFd5g47p9wnbz=HrNh0U2bbc=0ZaJ7n0U+_=E8yp8yPMrqwzaA@mail.gmail.com>
 <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f0d102a8-6501-88d8-d47d-202fd36e55a5@gmail.com>
Date:   Tue, 18 Feb 2020 19:18:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/20 2:49 PM, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From:  Brendan Higgins
>>
>> On Wed, Feb 12, 2020 at 7:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 2/7/20 10:58 AM, Alan Maguire wrote:
> 
> ...
> 
>>>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>>>> index 9242f93..aec607f 100644
>>>> --- a/lib/kunit/test.c
>>>> +++ b/lib/kunit/test.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/sched/debug.h>
>>>>
>>>> +#include "debugfs.h"
>>>>  #include "string-stream.h"
>>>>  #include "try-catch-impl.h"
>>>>
>>>> @@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
>>>>       }
>>>>  }
>>>>
>>>> -static size_t kunit_test_cases_len(struct kunit_case *test_cases)
>>>> +size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>>>>  {
>>>>       struct kunit_case *test_case;
>>>>       size_t len = 0;
>>>>
>>>> -     for (test_case = test_cases; test_case->run_case; test_case++)
>>>> +     kunit_suite_for_each_test_case(suite, test_case)
>>>>               len++;
>>>>
>>>>       return len;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>>>>
>>>>  static void kunit_print_subtest_start(struct kunit_suite *suite)
>>>>  {
>>>>       kunit_print_tap_version();
>>>> -     pr_info("\t# Subtest: %s\n", suite->name);
>>>> -     pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
>>>> +     kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
>>>> +     kunit_log(KERN_INFO, suite, "1..%zd",
>>>> +               kunit_suite_num_test_cases(suite));
>>>
>>> The subtest 'is a TAP stream indented 4 spaces'.  (So the old code was
>>> also incorrect since it indented with a tab.)
>>
>> Whoops.
>>
>> I agree that fixing tabs to spaces is probably the easiest thing to do
>> here; nevertheless, I think this might be a good time to talk about
>> other deviations from the spec and what to do about it. This might
>> also be a good time to bring up Tim's comment at LPC last year about
>> forking TAP. Arguably I already have given that TAP14 is still under
>> review and is consequently subject to change.
>>
>> Additionally, the way I report expectation/assertion failures are my
>> own extension to the TAP spec. I did this because at the time I wasn't
>> ready to open the can of worms that was adding a YAML serializer to
>> the Linux kernel; I mentioned adding a YAML serializer at LPC and
>> people didn't seem super thrilled with the idea.
> 
> I'm not sure I follow.  Are you talking about writing YAML or interpreting
> YAML.  You don't need a serializer to write YAML.  It can be done 
> with straight text output.  I guess it depends on the scope of what you
> envision.  Even if you want to do more than trivial structured output,
> I don't think you'll need a full serializer.  (IOW, I think you could sneak
> something in and just call it a test output formatter.  Just don't call it YAML
> and most people won't notice. :-)

A serializer is a red herring.  Just drop the entire label and concept.
What is already in KUnit is the equivalent, printing out (eg through
printk() or however printk() is wrapped) simple text of the form (by
example) of

  label: value
  label: value
  label:
    label: value
    label: value
  label:
     label:
       label: value
       label: value

So basically
  - label/value pairs
  - label without value indicating a node or block (another level)
  - some rules about the format of value
  - indentation indicating a node or block

That is something really simple.  No need for any fancy coding to
encapsulate.

-Frank

> 
>>
>> Further both the TAP implementation here as well as what is in
>> kselftest have arbitrary kernel output mixed in with TAP output, which
>> seems to be a further deviation from the spec.
> Well that's a different kettle of worms, and really argues for staying
> with something that is strictly line-based.
> 
>>
>> In an effort to do this, and so that at the very least I could
>> document what I have done here, I have been looking into getting a
>> copy of TAP into the kernel. Unfortunately, TAP appears to have some
>> licensing issues. TAP says that it can be used/modified "under the
>> same terms as Perl itself" and then provides a dead link. I filed a
>> pull request to update the licence to the Perl Artistic Licence 1.0
>> since I believe that is what they are referencing; however, I have not
>> heard back from them yet.
> 
> When you say "getting a copy of TAP into the kernel", I presume you mean
> an existing implementation to produce TAP output?  Or are you talking about
> a TAP interpreter?  I'm not sure the former needs to use an existing implementation.
> 
> I previously volunteered (in Lisbon) to write up the TAP deviations,
> and never got around to it.   Sorry about that. I can try to work on it now if
> people are still interested.
>  -- Tim
> 
> [rest of patch omitted]
> 
> 

