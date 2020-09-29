Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1BC27D7BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 22:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgI2ULf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 16:11:35 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10423 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgI2ULe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 16:11:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7394c40000>; Tue, 29 Sep 2020 13:10:44 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:11:34 +0000
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
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
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
 <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
 <20200929190816.GY9916@ziepe.ca>
 <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
 <20200929195356.GZ9916@ziepe.ca>
 <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
Date:   Tue, 29 Sep 2020 13:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601410244; bh=h1cShwScpls1cxoBr43dDhqnFtUnjOc7/H7Y8HWxAgM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Wl4BhHVXCxnN2MbBzLUijMKatEV4a+hk1x1KprGMe7sx2IRfHuUPwV1G8DK3/Uym7
         s1WqObC4zZUpHV8MazVJcK+ij9OSOyFSV41pcViWpH2droSzSXzO2B7YDNLd7btX+v
         haigRF8z6Y+X6YrXltTZ9sMTl2J2ov5VYW9wkM18+El91/tvCj5Q9/Yyibh8hkZjR/
         CCjieAzw/GA8k2JNpdvnBl+kTEbTLiCQ+v6NFpsRYWEhhojsy5RtmogBk/1lRFSKSG
         W6hQ8eoCKGbLEkWXVX9fTyH4pp+F5n6hM7dxRfUwgc7DOtOQ+6DX/0KZ6eB51vLh2d
         njiPyDcmUpJhw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 1:00 PM, Shuah Khan wrote:
> On 9/29/20 1:53 PM, Jason Gunthorpe wrote:
>> I only remarked because I didn't know it wasn't using kbuild. I
>> thought it would have used the existing HOSTCC stuff, not sure why it
>> is special.
>>
>> The only investment that seems worthwhile would be to switch it to use
>> the normal kbuild stuff??
>>
> 
> I explored switching to kbuild at the kernel summit last year during
> my kselftest where are we talk.
> 
> There was push back from several developers. We can definitely explore
> it as long as we can still support being able to build and run
> individual subsystem tests and doesn't break workflow for developers.
> 

Do you have a link or two for that? Especially about the pushback, and
conclusions reached, if any.



thanks,
-- 
John Hubbard
NVIDIA
