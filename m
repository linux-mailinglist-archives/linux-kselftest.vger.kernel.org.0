Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24C0CAFB8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfJCUDb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Oct 2019 16:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfJCUDa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Oct 2019 16:03:30 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CC42086A;
        Thu,  3 Oct 2019 20:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570133009;
        bh=XBddDCUireoaYr+xYMeD6iqD7GBHs65MFRQ0Q9jeTtI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JfVkKlqca7ULg91JsG7VMv30F4ycvAJJCsfpZYJ2h7zdalIVdrzas4ly5MfA2ShV2
         llX+Ic9sXJNit0ylNAa00hrrZTAILsRXcPLeGjmd7VIHz4mA4D/ZUU52DVdmgTqGBb
         btJK9flxnCm20ZgPpBG0+wX+UxqQkrPImNOzalTI=
Subject: Re: next-20191002 kselftest results
To:     Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     lkft-triage@lists.linaro.org, Dan Rue <dan.rue@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost>
 <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org>
 <CAEUSe7_+RQ9UPjJW1TzFwfCpcFuOv9ha7k_Lf46RJTg-=gVf_Q@mail.gmail.com>
 <CADYN=9LeWLqQ4cYAQ=Fk-xD_O4UxPN+GSwgqyB3UH3j=xH0KLA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <434b3683-77c0-0a11-80e5-3329b5d20069@kernel.org>
Date:   Thu, 3 Oct 2019 14:03:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LeWLqQ4cYAQ=Fk-xD_O4UxPN+GSwgqyB3UH3j=xH0KLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/19 8:47 PM, Anders Roxell wrote:
> On Thu, 3 Oct 2019 at 04:15, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>>
>> Hello!
>>
>> On Wed, 2 Oct 2019 at 20:52, shuah <shuah@kernel.org> wrote:
>>>
>>> On 10/2/19 7:00 AM, ci_notify@linaro.org wrote:
>>>> Summary
>>>> ------------------------------------------------------------------------
>>>> kernel: 5.4.0-rc1
>>>> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> git branch: master
>>>> git commit: a32db7e1172439240202b843642465618498170d
>>>> git describe: next-20191002
>>>> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
>>>>
>>>> Regressions (compared to build next-20191001)
>>>
>>> This report is nice for quick glance of test pass/fail/skip dashboard.
>>> I am finding very difficult to figure out why the test failed.
>>>
>>> Can you please save the test run logs and stash them for access?
>>
>> Logs are saved. You can click on the test details:
>>    https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
>> then opening "kselftests" in Test Results, choosing an environment
>> (say "x86_64"), and then (here's the tricky one) "job_url":
>>    https://lkft.validation.linaro.org/scheduler/job/948404
> 

Too many mouse click chasing these logs. Can you make this link on the
dashboard.

thanks,
-- Shuah
