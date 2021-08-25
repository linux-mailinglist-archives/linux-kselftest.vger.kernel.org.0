Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573603F6D32
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhHYBt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 21:49:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60252 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbhHYBt3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 21:49:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UlfaEaR_1629856121;
Received: from 30.21.164.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UlfaEaR_1629856121)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Aug 2021 09:48:42 +0800
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     shuah@kernel.org, Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
 <20210824112129.2t6lzqyf2dxllw4a@senku>
 <20210824113619.a3gyxlerst7tumzn@wittgenstein>
 <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
 <15672b09-e4fc-78ec-7415-1ff7b777cc15@linuxfoundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <b9c0725e-8261-77d3-2f73-434f64bf6468@linux.alibaba.com>
Date:   Wed, 25 Aug 2021 09:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <15672b09-e4fc-78ec-7415-1ff7b777cc15@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2021/8/25 0:50, Shuah Khan wrote:
> On 8/24/21 8:33 AM, Shuah Khan wrote:
>> On 8/24/21 5:36 AM, Christian Brauner wrote:
>>> On Tue, Aug 24, 2021 at 09:21:29PM +1000, Aleksa Sarai wrote:
>>>> On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>> Hi Baolin,
>>>>>
>>>>> On 8/22/21 8:40 PM, Baolin Wang wrote:
>>>>>> Hi Shuah,
>>>>>>
>>>>>> On 2021/7/28 20:32, Baolin Wang wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>>> When running the openat2 test suite on ARM64 platform, we got 
>>>>>>>> below failure,
>>>>>>>> since the definition of the O_LARGEFILE is different on ARM64. 
>>>>>>>> So we can
>>>>>>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>>>>>>
>>>>>>> Sorry, I forgot to copy the failure log:
>>>>>>>
> 
> Please send me v2 with failure log included in the commit log.

Sure. Thanks for reviewing.
