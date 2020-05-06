Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B301C7371
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgEFO5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 May 2020 10:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEFO5B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 May 2020 10:57:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B638208D5;
        Wed,  6 May 2020 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588777021;
        bh=7C6pHtIOO/mW2MrxUY1Taq3Qq5X5LTmUKk0FYRD6PYw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bAA4PqKfZ9uLbGLt1/9zt3akXtoBysrDhHUZaNjF1oTu6GWzdPEqoHdraaSN3edwB
         7T73Ra+iPyLb5eFKOhErIn4k10SQfsZiFZ90BrEhHdy+qLHUaj2MZmJkyuSN37oEhA
         s+CwpL/zEqulFnl/o5HDdQPPbsDMoTAIcbpK7mS0=
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     Veronika Kabatova <veronicca114@gmail.com>, sbrivio@redhat.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200428123841.2953099-1-vkabatov@redhat.com>
 <529c2308-0840-a794-fc09-d44272066b08@kernel.org>
 <687583033.21650764.1588593000351.JavaMail.zimbra@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <492228e8-9762-dfe9-8cb6-534c8e6171b9@kernel.org>
Date:   Wed, 6 May 2020 08:56:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <687583033.21650764.1588593000351.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/20 5:50 AM, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
>> From: "shuah" <shuah@kernel.org>
>> To: "Veronika Kabatova" <veronicca114@gmail.com>
>> Cc: sbrivio@redhat.com, linux-kselftest@vger.kernel.org, "Veronika Kabatova" <vkabatov@redhat.com>, "shuah"
>> <shuah@kernel.org>
>> Sent: Friday, May 1, 2020 4:49:34 PM
>> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
>>
>> Hi Veronica,
>>
> 
> Hi,
> 
>> On 4/28/20 6:38 AM, Veronika Kabatova wrote:
>>> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
>>> pass along any variables to `make install` to influence what should be
>>> built. This can result in an early error on the command line ("Unknown
>>> tarball format TARGETS=XXX"), or unexpected test failures as the
>>> tarball contains tests people wanted to skip on purpose.
>>>
>>> Since the makefile already contains all the logic, we can add a target
>>> for packaging. Keep the default .gz target the script uses, and actually
>>> extend the supported formats by using tar's autodetection.
>>>
>>
>> Thanks for working on this. gen_kselftest_tar.sh  a while back before a
>> lot of the install features went in and Makefile supports it fully. It
>> makes perfect sense to use Makefile drive this.
>>
>>> To not break current workflows, keep the gen_kselftest_tar.sh script as
>>> it is, with an added suggestion to use the makefile target instead.
>>>
>>
>> Not sure how many people use this. It is a good idea keeping it around
>> for now.
>>
>>> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
>>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>>> ---
>>>    Documentation/dev-tools/kselftest.rst        | 23 ++++++++++++++++++++
>>>    tools/testing/selftests/Makefile             |  9 +++++++-
>>>    tools/testing/selftests/gen_kselftest_tar.sh |  5 +++++
>>>    3 files changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/dev-tools/kselftest.rst
>>> b/Documentation/dev-tools/kselftest.rst
>>> index 61ae13c44f91..3fc559bcb597 100644
>>> --- a/Documentation/dev-tools/kselftest.rst
>>> +++ b/Documentation/dev-tools/kselftest.rst
>>> @@ -151,6 +151,29 @@ note some tests will require root privileges::
>>>       $ cd kselftest
>>>       $ ./run_kselftest.sh
>>>    
>>> +Packaging selftests
>>> +===================
>>> +
>>> +In some cases packaging is desired, such as when tests need to run on a
>>> +different system. To package selftests, run::
>>> +
>>> +   $ make -C tools/testing/selftests gen_tar
>>> +
>>
>> Does this work in the case of relocatable build.cross-build cases?
>>
>>> +This generates a tarball in the `INSTALL_PATH/kselftest-packages`
>>> directory. By
>>> +default, `.gz` format is used. The tar format can be overriden by
>>> specifying
>>> +a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_
>>> option
>>> +is supported, such as::
>>> +
>>> +    $ make -C tools/testing/selftests gen_tar FORMAT=.xz
>>> +
>>> +`make gen_tar` invokes `make install` so you can use it to package a
>>> subset of
>>> +tests by using variables specified in `Running a subset of selftests`_
>>> +section::
>>> +
>>> +    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
>>
>> Does this work in the case of relocatable build.cross-build cases?
>>
> 
> The command only adds a "tar" call on top of "make install" and doesn't
> reach outside of INSTALL_PATH. If the cases you mention are supported by
> the regular "make install" then they should work with "gen_tar" as well.
> 

Sounds good. I will queue this up for 5.8-rc1

thanks,
-- Shuah
