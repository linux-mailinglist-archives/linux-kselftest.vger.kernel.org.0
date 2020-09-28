Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0827B5FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1UK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:10:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2425 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1UKZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:10:25 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7242cd0001>; Mon, 28 Sep 2020 13:08:45 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 20:10:25 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
Date:   Mon, 28 Sep 2020 13:10:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928125739.GP9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601323725; bh=IAnhMRFhLfn/o6VnG/j9EvoCmqTmaObpHGzh20VLI9s=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Slv3IPRUCeDcWuWxM01TTCUoBJWicUemyGsxm/6RNDdcGQpHWQLGXDmIOGle6OOzh
         Z13TcLVKa9oyblsqo/g5IF/kN/sYc6kmWKe7ToJhj4aSX55bNSXnJAB9jmdf0RyPr5
         5xX62Yli3Gq/8uK34J0zfHHo9SfVNnknqzANpt3D1d7I11DTt0r7eJdimwfz4sKFci
         K+OJvAfBY4Him88DqKw3E1qgSea6y3oJ6KDyZtsKESoB4z7qAgbG2Xyrq55AJsp393
         QcOX6hxekpQouSt3/HCpYTYEdRbcU6DqhNUhQwALEnKykLFoG0r2GY7JAQUKfyzALi
         /UCG9d8kRPtFQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
> On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>> index d1ae706d9927..9cc6bc087461 100644
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -130,3 +130,5 @@ endif
>>   $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
>>   
>>   $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
>> +
>> +$(OUTPUT)/gup_test: ../../../../mm/gup_test.h
> 
> There is no reason to do this, the auto depends will pick up header
> files, and gup_test.h isn't a generated file
> 

It is less capable than you might think. Without the admittedly ugly technique
above, it fails to build, and as you can see, the include paths that are fed to
gcc are just a single one: usr/include:

$ make
make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
gcc -Wall -I ../../../../usr/include     gup_test.c 
/kernel_work/linux-next-github/tools/testing/selftests/kselftest_harness.h 
/kernel_work/linux-next-github/tools/testing/selftests/kselftest.h ../../../../mm/gup_test.h -lrt -o 
/kernel_work/linux-next-github/tools/testing/selftests/vm/gup_test
make[1]: Entering directory '/kernel_work/linux-next-github'
gup_test.c:10:10: fatal error: gup_test.h: No such file or directory
    10 | #include "gup_test.h"
       |          ^~~~~~~~~~~~


thanks,
-- 
John Hubbard
NVIDIA
