Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F89F3998
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKGUhN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 15:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGUhM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 15:37:12 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575D920869;
        Thu,  7 Nov 2019 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573159031;
        bh=75YpB4uf0nzMSpOPvkzELVfwj7NE/qR9Gand9Yj5AU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F/1iA7QtUstbZVtk14NJ3IZFD14mMiGtv5kS7mxKYfXec07tzFSpieAkRabKcHDh3
         YiDJZwtl2kHOcTFP9sZcflnjegpaLYhpAzSZc/40MlFsHPEygrsRgUjhkSEmzjE+XC
         WXHez5p1T/oN+WOHOjqNU6p39Mb4319MzMYupCqY=
Subject: Re: [PATCH] kselftests/dmabuf-heaps: Fix compiler error in one
 condition
To:     Xiao Yang <ice_yangxiao@163.com>, john.stultz@linaro.org
Cc:     linux-kselftest@vger.kernel.org, philip.li@intel.com,
        shuah <shuah@kernel.org>
References: <20191101020450.12948-1-ice_yangxiao@163.com>
 <e343dbf7-323f-c513-50ca-feda4f0ab6ec@163.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1386a7d3-1114-d0e5-65b0-d81c032ac657@kernel.org>
Date:   Thu, 7 Nov 2019 13:37:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e343dbf7-323f-c513-50ca-feda4f0ab6ec@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/31/19 8:25 PM, Xiao Yang wrote:
> Hi,
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
Do you plan to send another patch? I don't understand
if this meant you think this patch doesn't fix the
problem?

> On 11/1/19 10:04 AM, Xiao Yang wrote:
>> Compiling dmabuf-heaps cannot locate headers and then gets the following
>> error when kernel source code instead of system provides headers:
>> -------------------------------------------
>> dmabuf-heap.c:16:10: fatal error: drm/drm.h: No such file or directory
>> -------------------------------------------
>>
>> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>> ---
>>   tools/testing/selftests/dmabuf-heaps/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile 
>> b/tools/testing/selftests/dmabuf-heaps/Makefile
>> index 8c4c36e2972d..9043e0b5a432 100644
>> --- a/tools/testing/selftests/dmabuf-heaps/Makefile
>> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
>> +CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
>>   #LDLIBS += -lrt -lpthread -lm
>>   # these are all "safe" tests that don't modify
> 
> 

thanks,
-- Shuah
