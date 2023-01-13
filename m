Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2053566A1DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jan 2023 19:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAMSWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Jan 2023 13:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjAMSWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Jan 2023 13:22:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFC7EC9F
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 10:15:25 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d10so11128750ilc.12
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jan 2023 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu+0Yl41eoFyIhv8VuC2fbUgUNGvpyTO1MGhXQXnzok=;
        b=JMAjgxWn6lb6jLu668oSCaWHZWTkfiO68I+SjKa+pSk5HTK/+eFNNlqjQfnGjVFCEx
         FCFuh2xLTAlRsQVLHnxf6ZEPFfKGgEM2jZTJjEK5fPAlWV4j6LNw1pHp8wr8s7Vg+gqV
         r9NKrdrbMqEnyC2oxXkilMoSkbP2LSq0OQDfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu+0Yl41eoFyIhv8VuC2fbUgUNGvpyTO1MGhXQXnzok=;
        b=t+4VqqU/HRhJNOLcFHYHSqajBpaqL+HD4cqxu9tY5NdpASQbMw1zxuAW7106AZ1dNx
         CPSg0kYwhq/+w8ue64hjQtsZBveADkQJgB/4CvkEFr+dMt+LdxuIpDeagR7Z9poxsnc5
         zsgFVEkeTU/adC6Wvtp66zzKVAEheuvSmjdBpvoTc2+2PLCv2mWaCtwd8W77Yqj129uu
         UW5nvipjY8ax2lWvjxyI4cvrCp3OM7bEWKyUcemJcK+H6Qlmh6H+7urZz9h0KVA+3CJ5
         eBRyOv3Lg4+tiiwveZX59gcZjO8gdBgOZfKTzeC4rAjRBM1sDBiPZncKEpfPzWGncutw
         56lQ==
X-Gm-Message-State: AFqh2kqyzFufD3F+8/4FLDuX4ihAzt/ADtQfI6itvp8gUG6/t+2QUj30
        MdE9m4IQQ2YU5IDx75U4QQsXVg==
X-Google-Smtp-Source: AMrXdXsMA3BoeJsq3+v8W3+bT41hlN/pFvcYijFT9/lZA7WHUOm0H6e5LPSVVodtHkFNCaZLeiHSyQ==
X-Received: by 2002:a05:6e02:20e7:b0:30d:9eea:e51 with SMTP id q7-20020a056e0220e700b0030d9eea0e51mr4736932ilv.1.1673633724779;
        Fri, 13 Jan 2023 10:15:24 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k15-20020a02334f000000b0039d71c46577sm5466207jak.21.2023.01.13.10.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 10:15:24 -0800 (PST)
Message-ID: <ecfeafbc-9f5e-68a8-3a4a-9fce17bde77f@linuxfoundation.org>
Date:   Fri, 13 Jan 2023 11:15:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests:dma: Fix compile error in user-space tool
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230109180721.187324-1-gbayer@linux.ibm.com>
 <a01b5643-3373-d5a0-a3d7-4fa845725dbd@linuxfoundation.org>
 <9d824f0b3642d3b3e8e92fe7a34522f334b003f7.camel@linux.ibm.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9d824f0b3642d3b3e8e92fe7a34522f334b003f7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/13/23 09:52, Gerd Bayer wrote:
> On Thu, 2023-01-12 at 13:36 -0700, Shuah Khan wrote:
>> On 1/9/23 11:07, Gerd Bayer wrote:
>>> With this change dma_map_benchmark compiles with just the obvious
>>> warning
>>> about uapi usage on ARCH=x86, arm64, and s390 and runs on
>>> ARCH=s390.
>>
>> On Linux 6.2-rc3, dma_map_benchmark compiles just fine. You do
>> have to do "make headers_install" first as kselftest depends
>> on headers being installed in the repo.
>>
>> Please let me know if you are seeing compile problems even after
>> installing headers.
>>
>> thanks,
>> -- Shuah
> 
> Hi Shuah,
> 
> thank you for this clarification. Once I run "make headers_install"
> before attempting to build the dma_benchmark_test executable with
>    make -C tools/testing/selftests/ TARGETS="dma"
> everything works out nicely - even w/o my patch.
> 
> I have to apologize for creating this fuzz. I was not aware that one of
> the dependencies for "make kselftest" was "make headers_install", since
> I was going straight for the interactive "dma_benchmark_test" control
> tool of the test that is implemented in kernel/dma/benchmark_test.c.
> I didn't intend to run the full "make kselftest" suite, primarily since
> I have distinct test and build systems - most often building cross-
> arch, even.
> 

No worries. The reason for this dependency is to ensure kselftest can
test the kernel properly. Tests for new or enhanced kernel features
depend on mew headers. headers_install has been dependency for kselftest
from the beginning and some individual tests depend on it.

The main Makefile (make kselftest) enforces the dependency  and installs
headers first. You can use the following commands to compile/run dma test.
This will install the headers and then compile/run dma test.

make kselftest-all TARGETS=dma (compile)
make kselftest TARGETS=dma (compile and run)


> So please, disregard the PATCH.

Done.

thanks,
-- Shuah
