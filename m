Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2116627D88A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgI2UhC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 16:37:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2631 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgI2Ugc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 16:36:32 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f739ac30002>; Tue, 29 Sep 2020 13:36:19 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 20:36:31 +0000
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
 <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
 <9372727e-1a79-913b-5391-e0c4a85bf5a7@linuxfoundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <da9047fa-d1f8-9710-04a3-0308606bb1e9@nvidia.com>
Date:   Tue, 29 Sep 2020 13:36:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9372727e-1a79-913b-5391-e0c4a85bf5a7@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601411779; bh=n1mhQyb3EairzkA8SLPi4ID9Etv8RANKs+TlCUc3N/s=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=bVgMFrvChQ8jKDMZFKWE07OUOuPnvJ1XnygiwxMR+P7cfn7CqeOvNC7snuRyxGl9L
         hKUVZcYvc+GQmpMWeAwnRbTZBjEdCyvznKysMqU5MjLz7fyciAYeutCL4lCmVCcVig
         PjiVEIpB075drNakFXOJzPBWzJUFtYVy+KI9+5WKwyTjsCuXAwHh+9ZHhp+RpjHQ23
         TaI26yNFfoNnSvJ1N82K13yqn+bbv/XIEAwqlO7ddkhOi4yJ5C2l89ahva6/8r36gU
         ai34rj5N978gUpWIyiU0UNXo+Nh2ZAHACQFZobLb6ulODmitUVF5FqRxug1yzdgGQL
         wAETj0J8xeKFg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 1:20 PM, Shuah Khan wrote:
> On 9/29/20 2:11 PM, John Hubbard wrote:
...
>> Do you have a link or two for that? Especially about the pushback, and
>> conclusions reached, if any.
>>
> 
> Unfortunately no. A I recall it was workflow related issues and ease of
> running individual subsystem tests and backwards compatibility with
> stables.
> 
> Let's start a new discussion and see where we land.
> 
OK, sure. I can take a quick pass at converting just the selftests/vm
directory to kbuild, and post that as an RFC to start the discussion.


thanks,
-- 
John Hubbard
NVIDIA
