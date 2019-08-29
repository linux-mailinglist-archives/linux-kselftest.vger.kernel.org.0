Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26E1A2285
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfH2Rjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 13:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfH2Rje (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 13:39:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEF221726;
        Thu, 29 Aug 2019 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567100373;
        bh=EuCHrvEvdbp8z1/Lg/yUsnYZ4GrW13AmJ1Li6JNqah4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BEbe7vu3O2sPbUB/hlCQ+OPAVVFF8f+DR6DPd61XoLB4O+eAAYvUXJoZm32wJqset
         yxsZmnwdOOrWMfl+wg/blme7nNlg3D6Rf6WA6v7dhWhhO7MJxAv2SHJcSgHmbkIjBt
         mqaQ58iB+xIRLRCcOHMc3VukpwfZNmtc56tKMgN4=
Subject: Re: [PATCH v2] doc: kselftest: update for clarity on running
 kselftests in CI rings
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dan.rue@linaro.org, anders.roxell@linaro.org,
        shuah <shuah@kernel.org>
References: <20190827003709.26950-1-skhan@linuxfoundation.org>
 <CAFd5g47jeZGqdhOUEOFGwHqHQ1O0=99Ce+bFhZ-7PCyFT1YO1Q@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f328adad-7559-a459-fd56-b46795d882c6@kernel.org>
Date:   Thu, 29 Aug 2019 11:39:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g47jeZGqdhOUEOFGwHqHQ1O0=99Ce+bFhZ-7PCyFT1YO1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/19 11:30 AM, Brendan Higgins wrote:
> On Mon, Aug 26, 2019 at 5:37 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Update to add clarity and recommendations on running newer kselftests
>> on older kernels vs. matching the kernel and kselftest revisions.
>>
>> The recommendation is "Match kernel revision and kselftest."
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> One minor comment below.
> 
>> ---
>> Changes since v1: Fixed "WARNING: Title underline too short."
>>
>>   Documentation/dev-tools/kselftest.rst | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index 25604904fa6e..308506c5e8fa 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -12,6 +12,31 @@ write new tests using the framework on Kselftest wiki:
>>
>>   https://kselftest.wiki.kernel.org/
>>
>> +Recommendations on running kselftests in Continuous Integration test rings
>> +==========================================================================
>> +
>> +It is recommended that users run Kselftest from the same release. Running
>> +newer Kselftest on older kernels isn't recommended for the following
>> +reasons:
>> +
>> +- Kselftest from mainline and linux-next might not be stable enough to run
>> +  on stable kernels.
>> +- Kselftests detect feature dependencies at run-time and skip tests if a
>> +  feature and/or configuration they test aren't enabled. Running newer
>> +  tests on older kernels could result in a few too many skipped/failed
>> +  conditions. It becomes difficult to evaluate the results.
>> +- Newer tests provide better coverage. However, users should make a judgement
>> +  call on coverage vs. run to run consistency and being able to compare
>> +  run to run results on older kernels.
>> +
>> +Recommendations:
> 
> I think this should be the "note" directive. You already have a list
> of recommendations above; this seems like a TLDR section, or an
> important note or tip.
> 
>> +
>> +Match kernel revision and kselftest. Especially important for LTS and
>> +Stable kernel Continuous Integration test rings.
>> +
>> +Hot-plug tests
>> +==============
>> +
>>   On some systems, hot-plug tests could hang forever waiting for cpu and
>>   memory to be ready to be offlined. A special hot-plug target is created
>>   to run the full range of hot-plug tests. In default mode, hot-plug tests run
>> --
>> 2.20.1
>>
> 

Thanks Brendan. I am holding off on this patch for now. I will have
to make some updates. I will fold your comment in when I send an
updated patch.

thanks,
-- Shuah
