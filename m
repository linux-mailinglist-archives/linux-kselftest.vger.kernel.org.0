Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16182CB3E1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 05:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgLBEWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 23:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLBEWH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 23:22:07 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873AC0613CF;
        Tue,  1 Dec 2020 20:21:27 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id ms7so265869pjb.4;
        Tue, 01 Dec 2020 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p54tA3Lh3qw5So+dcm5tNyopOVZr/DLkJyUNEV6tO9o=;
        b=LMnJyfctexJAuMIUke4jgBIAem+9sVrKh+vo3s3684SWnoMoJO2xeS8G3jzxXl39AV
         D6jAwkwAHRZe/jdIjYFhhOAxUG5Nwlyg6g3MH2gLI0cnWY5GuZ/wGx3fA8iAuYe7PXpj
         WVXZHMSgCxQvTNtyP/pPYN80cBcWKbL3GoVUjWQMop979Vr1oRkeokmgqX6TkuVcRgn0
         0uVjyOs/4eqhQeynHqFZECN7D7oNONyXt/eSKJ7if5C4SJiyeH99VmucQKYwewcEaW1i
         qkui7AgwcAj3g5sHaBof5tMCc25z3AjtadbNWip94A/kQvPNDNd4pIbjzq9NEh3m38Se
         hsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p54tA3Lh3qw5So+dcm5tNyopOVZr/DLkJyUNEV6tO9o=;
        b=k3VaGpFCTBHSk4YmtLsCgS0raVNmgoGOt8CLm9IR0fgQH9MqOvGnewWmd3C+QtUQJ0
         zezL2byq5UVvBUKmR5FlRnAhXlCyEJTTVX7gh9KdXKKsamb1x6ACTaG5A2EJsIs1+4NR
         DXI8J2MZ2I8cChndodWvK+JcDNfZl54l6EiGhLs9sCcCUZu0VFI6cxuXHv9rLjSbYOZ5
         wlp0D99CpbpD7yn92U/kgw6smzMKJkFkmNuADMp7MiCmwi2IeeESk1wsgvZkuztStZtP
         ZF5TovudncWGPi160gxBlhwoqVpztWDOVmIDT/h+bw0fWgbDqaN71XuT9i0NwrXizoHP
         Ir9A==
X-Gm-Message-State: AOAM531Vpx1iXXsqY83vMGmAmgWw9GRnCz4T8/LwdbWr3a+ZLgQfszWg
        iJ+x363HvolXkeeqepSwJEs=
X-Google-Smtp-Source: ABdhPJxn31eckifthLwsRg2hL2izLl2wR2myRosOg/r3h/C4dih/qs9kA/Qi23NyS/9sdC+arQHGAQ==
X-Received: by 2002:a17:902:a415:b029:d9:ef8:afa1 with SMTP id p21-20020a170902a415b02900d90ef8afa1mr830554plq.66.1606882887032;
        Tue, 01 Dec 2020 20:21:27 -0800 (PST)
Received: from [192.168.86.81] ([106.51.140.48])
        by smtp.gmail.com with ESMTPSA id x28sm461455pfr.186.2020.12.01.20.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 20:21:26 -0800 (PST)
Subject: Re: [PATCH v3] lib: Convert test_hexdump.c to KUnit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201201071632.68471-1-98.arpi@gmail.com>
 <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <e10ef8d3-f22b-db10-3784-c94ee425af46@gmail.com>
Date:   Wed, 2 Dec 2020 09:51:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 01/12/20 4:36 pm, Andy Shevchenko wrote:
> On Tue, Dec 1, 2020 at 9:21 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>> Convert test lib/test_hexdump.c to KUnit. More information about
>> KUnit can be found at:
>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>> KUnit provides a common framework for unit tests in the kernel.
>> KUnit and kselftest are standardizing around KTAP, converting this
>> test to KUnit makes this test output in KTAP which we are trying to
>> make the standard test result format for the kernel.
> 
> Below doesn't suit commit message, perhaps adding it after '---' line
> would be good. In the commit message you can choose one failed case
> followed by all OK and show the difference.
> 

Okay, I will make this change.

>> I ran both the original and converted tests as is to produce the
>> output for success of the test in the two cases. I also ran these
>> tests with a small modification to show the difference in the output
>> for failure of the test in both cases. The modification I made is:
>>  static const char * const test_data_4_le[] __initconst = {
>> -       "7bdb32be", "b293180a", "24c4ba70", "9b34837d",
>> +       "7bdb32be", "b293180a", "24c4ba70", "9b3483d",
>>
>> The difference in outputs can be seen here:
>> https://gist.github.com/arpi-r/38f53a3c65692bf684a6bf3453884b6e
> 
> Looks pretty much good, what I'm sad to see is the absence of the test
> statistics. Any ideas if we can get it back?
> 

I could again include variable total_tests as was in the original test.
Would that be fine?

Thanks!
