Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB33C194B92
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCZWdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 18:33:49 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42047 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZWdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 18:33:49 -0400
Received: by mail-il1-f194.google.com with SMTP id f16so6990113ilj.9
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjtLmei14Aqe6drnic5xmk3O+peLFqdWaisNXVkXGdU=;
        b=LDp1HOz4HRDcpEUE/IODV5zUi8p4m/bTmt+Due8jI4CRWUH08jE3IOL0+gMN7atpoA
         gTRYN4GEg+beygpKEJUpyOj5DLy7Aya6zVDZFacmvFjxr0x8yaK+xuZefyLMLtVSCXHQ
         lDcPSqUMxCawAdciC6sGGZPl5FsLBpvCs/cuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjtLmei14Aqe6drnic5xmk3O+peLFqdWaisNXVkXGdU=;
        b=ZwwX3hkb/Po058KIYkME9RSnyikCsL9RsYT6Os1J8q5rSQMnm8dQ1qOVGbcz/+jNE/
         OjEr9GRGC5Tbo8xJH7bLkS4Aoa87dNvDxgzBXE9ZHeQ1FtrqjWmil7kV7kvqybLjksG0
         b5eaVWYjmwJ+MYvRaEDUj4INXtZCNdfU9L3oqv8exGA8700mXhDm8vnSE/R0DD9IfG+Y
         LcBBpb1eeqYwPc7slDnNNM4RwZqx4khELJGzi5MyObm3h4FN6myJOwb1oZlIhumQcPlr
         M6aYlpF9JGmh6lqQgeRCL/BOkDIroR6I9mQB7Hd9MIL0u9vfvRW+OyYzTUxvcEgJneS7
         eOow==
X-Gm-Message-State: ANhLgQ1a5KBCrPhiuR2Uq043fUVExWwGTbShvE45CW2vfQevSDRJoXm1
        rI6V4/YDksCf3JixtWUk8Fm/iA==
X-Google-Smtp-Source: ADFU+vtMO7/dx04DcpOtgDV7w5GSmDnkphd5lBOQl2I1jSMmN1W9RaTneGmqZD3lGbRVl2wtOisAng==
X-Received: by 2002:a92:359b:: with SMTP id c27mr10690452ilf.148.1585262026859;
        Thu, 26 Mar 2020 15:33:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j84sm1238655ili.65.2020.03.26.15.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 15:33:46 -0700 (PDT)
Subject: Re: [PATCH] selftests: Fix memfd to support relocatable build
 (O=objdir)
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200325231709.13122-1-skhan@linuxfoundation.org>
 <MWHPR13MB08955F0F8C5D0B07CA86DA92FDCF0@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fa8af77-4b4b-c1e2-2467-fb7b9adb3f66@linuxfoundation.org>
Date:   Thu, 26 Mar 2020 16:33:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB08955F0F8C5D0B07CA86DA92FDCF0@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/26/20 4:23 PM, Bird, Tim wrote:
>> -----Original Message-----
>> From: Shuah Khan
>>
>> Fix memfd to support relocatable build (O=objdir). This calls out
>> source files necessary to build tests and simplfies the dependency
>> enforcement.
>>
>> Tested the following:
>>
>> Note that cross-build for fuse_mnt has dependency on -lfuse.
>>
>> make all
>> make clean
>> make kselftest-install O=/arm64_build/ ARCH=arm64 HOSTCC=gcc \
>> CROSS_COMPILE=aarch64-linux-gnu- TARGETS=memfd
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/memfd/Makefile | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
>> index 53a848109f7b..0a15f9e23431 100644
>> --- a/tools/testing/selftests/memfd/Makefile
>> +++ b/tools/testing/selftests/memfd/Makefile
>> @@ -4,9 +4,8 @@ CFLAGS += -I../../../../include/uapi/
>>   CFLAGS += -I../../../../include/
>>   CFLAGS += -I../../../../usr/include/
>>
>> -TEST_GEN_PROGS := memfd_test
>> +TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
>>   TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
>> -TEST_GEN_FILES := fuse_mnt fuse_test
>>
>>   fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
>>
>> @@ -14,7 +13,7 @@ include ../lib.mk
>>
>>   $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
> 
> Sorry to interject here.  This comment doesn't have to do with this patch,
> but the above line is problematical for cross-compilation.
> $(shell pkg-config fuse --libs) will use pkg-config from the host
> machine, and may produce something different from what's
> installed on the target.  For most enterprise and desktop systems
> library paths for are mostly standardized.  The effect is that if
> you're doing 'simple' embedded, the pkg-config output on the
> host will match that of the target board.  However, in some
> embedded products the partition and filesystem setups are
> often quite complicated (e.g. I recently worked on a TV set with 14
> partitions) and things are not in the locations preferred by the
> Filesystem Hierarchy Standard.
> 
> When cross-compiling for our products, we tend to use the pkg-config
> from the filesystem of the target (a copy of which is on the host), rather
> than the host's pkg-config.
> 
Thanks for bringing attention to the issue. This is an existing
issue. Thankfully this is one of the two tests that use pkg-config.

The problem is limited to just two tests that are included in the
Makefile TARGETS.

> I don't have a board in my test lab where this shows up, nor a
> proposed solution at the moment, but I'm just mentioning it as a
> potential host-environment build contamination issue.  Maybe I
> should start keeping a list, and start thinking of possible solutions for
> more of these types of issues.


Thanks for bringing attention to the issue. I will keep an eye out for
this kind of usage during my reviews.

> 
> P.S. I'd ignore this issue for approving this patch.  I'm just bringing
> it up as a red flag for future work.

Thanks. This is an existing problem that can be addressed in a separate
page.

thanks,
-- Shuah
