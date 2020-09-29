Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A224727D4BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgI2Roc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 13:44:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16614 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2Roc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 13:44:32 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7372730000>; Tue, 29 Sep 2020 10:44:19 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 17:44:32 +0000
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
Date:   Tue, 29 Sep 2020 10:44:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929163507.GV9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601401459; bh=uNB6W6VUgOF7PVI0O4uW24Wk0Hp70vGOsM51NQ2J+Xo=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=T25zSwWnUbC5wggeyQkeiG3SpY0bF9dllCWrcl9qmeMPam+QqfE5yXi725BbPimLw
         uMGGWVg+kObDn3P6CVyIiiSpdYQhkt19mBrUU49eM9Xygp1gpM++3NMGhCgpYRy9Ax
         6AtHWa8ndJVmvWK2H+hmkTRX8ePqTzQ9AfDAglOnTtB4qSJa+v1KWKsiienZfPvO2f
         Da5doU60TAsENipzY0Owwuuso8AjyDBo/akCrdDwvx7CuL/T0U2hIVYX8wCo9tdFu6
         ogkDtq1tLCiKr0kvhN3cQ73Svdd7FPVnYHnshz7+mQ8u9UgeVb0DC1jcRrmOJzaf2H
         ZCBlQv0MjQf7g==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
>> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
>>> On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
>>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>>>> index d1ae706d9927..9cc6bc087461 100644
>>>> +++ b/tools/testing/selftests/vm/Makefile
>>>> @@ -130,3 +130,5 @@ endif
>>>>    $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
>>>>    $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
>>>> +
>>>> +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
>>>
>>> There is no reason to do this, the auto depends will pick up header
>>> files, and gup_test.h isn't a generated file
>>>

Oh, I misread your comment! You were talking about this Makefile
dependency that I'm adding, rather than the ../'s in the path.

Well, for that though, it also has to stay as shown in this patch,
because of this:

I don't see any "gcc -m" type of dependency generation pass happening
in this relatively simple Make system. And so, without including an
explicit header file dependency (at least, that's the simplest way),
changes to gup_test.h are not detected. Both the Makefile code and the
observed behavior back this up. (I expect that this is because there is
less use of header files in this area, because most unit tests are
self-contained within a single .c file.)


>>
>> It is less capable than you might think. Without the admittedly ugly technique
>> above, it fails to build, and as you can see, the include paths that are fed to
>> gcc are just a single one: usr/include:
>>
>> $ make
>> make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
>> gcc -Wall -I ../../../../usr/include     gup_test.c
>> /kernel_work/linux-next-github/tools/testing/selftests/kselftest_harness.h
>> /kernel_work/linux-next-github/tools/testing/selftests/kselftest.h
>> ../../../../mm/gup_test.h -lrt -o
>> /kernel_work/linux-next-github/tools/testing/selftests/vm/gup_test
>> make[1]: Entering directory '/kernel_work/linux-next-github'
>> gup_test.c:10:10: fatal error: gup_test.h: No such file or directory
>>     10 | #include "gup_test.h"
>>        |          ^~~~~~~~~~~~
> 
> You are supposed to use
> 
>    #include "../../../../mm/gup_test.h"

Good, I'll leave it as I had it.


> I have no idea what weird behavior the makefile is triggering that the
> above include works
> 

See the commit description for yet another Makefile weird behavior point. :)

thanks,
-- 
John Hubbard
NVIDIA
