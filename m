Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32027D73D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgI2Tso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 15:48:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14827 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgI2Tso (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 15:48:44 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f738f8f0001>; Tue, 29 Sep 2020 12:48:31 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 19:48:43 +0000
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
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
 <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
 <20200929190816.GY9916@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
Date:   Tue, 29 Sep 2020 12:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929190816.GY9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601408911; bh=l1M2t5AaCh7Q282ookH1so6zr+gWgGpQ9555vW1BLhM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=iqPRvbyfsch0MrYEGsHqsW979RKlqiaKx6EVGkaR4G3LY6FTDkj5XSr5RZ0QBRBnW
         v5p2goSD6wIA509stcKeeb7ggMHIwFqxCph7Todye4Y85Ry/3hZ4wGhAEz3tq/2EWY
         gIDi8H03y8QBsTw3eZEz+Oe0yLxw5iSNy+fTvI+jJqlt6exlCUGQ21ocFEgmOK4Lhw
         2rH6elYyKsm3FNui1WhZlhMWSalOBEpbBm8d1NN2llucQhgGoGXZCA6xgl+npBADuI
         D+lyfsZjbNVvsZ3N9cPOKdaoffdLOIPZji03kkw8WkdKwu7lNW1elDySSaQrVzhkwl
         Bswjpi+Rjseew==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 12:08 PM, Jason Gunthorpe wrote:
> On Tue, Sep 29, 2020 at 11:59:55AM -0700, John Hubbard wrote:
>> On 9/29/20 10:55 AM, Jason Gunthorpe wrote:
>>> On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
>>>> On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
>>>>> On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
>>>>>> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
>>>>>>> On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
>> ...
>>>> I don't see any "gcc -m" type of dependency generation pass happening
>>>> in this relatively simple Make system.
>>>
>>> It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
>>> and sucked into the build.
>>
>> You are thinking of kbuild. This is not kbuild. There are no such artifacts
>> being generated.
> 
> Oh. Really? That's horrible.
> 

Well, yes, it's not a perfect build system down here in selftests/. Are you saying
that it is worth upgrading? I'm open to suggestions and ideas for improvements,
and at the moment, I have the miniature build system here mostly loaded into my
head. So for a brief shining moment I can probably understand it well enough to
work on it. :)


thanks,
-- 
John Hubbard
NVIDIA
