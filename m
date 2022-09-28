Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE005EE30B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiI1R00 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiI1R0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 13:26:22 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7948564FF;
        Wed, 28 Sep 2022 10:26:20 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1319cf91d8aso4192649fac.5;
        Wed, 28 Sep 2022 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=PxNaDeF78j51lFfkEadsKMLXI6VN8WO63ACpoLyrqAc=;
        b=BMH+foBeGZ0fT1YqRY6YhuE+yCJl0PVTMuhsDCZrdLLygiTQi+LziyJTd/8zgvDFwb
         1DLKN627LNM33uU0L4iAwTJWeyYNUO9jUYEzJEcAOg+tQxaQMgUqsPlm9gvCnkzga7m7
         yQQy3C1Pwo39TEsXD5LiIwdaCT+Tgv3gr3hg3A3nLNINcqoYpuP7eFWAPCt6+zfPfbp0
         PE9Ce/mzWP0bpeCh0kjYTQl5xxM7skkOc7iX/qdQSgB5FLLV+lFw8PMgDk34pRRz0iGb
         bDPEYPrc36hZgwnSlTt0ID4hvoZ/N2lSYymNA84/bJAggcSGKVw6OMBuFO8u1d+0TLj4
         YGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PxNaDeF78j51lFfkEadsKMLXI6VN8WO63ACpoLyrqAc=;
        b=RMPmGJAWEnqyIOSaWDgL1SemppErHp6sP7ryJJ7GUPK5i40lYkcRb6xg4IN+zlyQH/
         xViKIItA1udWJb8Kk/h8/IaPV4ey4MbWN0IyHXeWyG9idXQ2P65trhFB2MYyRhXbbN9s
         gwU+HfDFP8ZQDPc/+VeBowEe4Kie2sRo1OqMdsN++rfSGohTYNooHxlhS/ksuXQxrKku
         Zpq8gsVrp7JjNKPr1iAiJ9OGS/Hfr0Ifh9XIhynrWtj5OR+iDUr+uQr0FoccAN1gms7Y
         rInQXyiXlGIiTi2deNl/h2cMhZWUqysIwF3YP2fbvijU2e4VrjSjbByHmSbdxoMi1O6x
         vfFQ==
X-Gm-Message-State: ACrzQf3daVKoB84J/QPct2x8x1BjGQSisGeFMFFFm/dtPczsaPkiwa53
        fxk5lBFCx7pbMuDwiIU06Z2tMU8eMsHsR/pv
X-Google-Smtp-Source: AMsMyM5zT85D/7aPruPMVZWLo1j6CLq62YJzQEB6Ux1aR2+YMtJUEDF5SmsBqDOMq1WaKNFizKNoxQ==
X-Received: by 2002:a05:6870:eaa9:b0:131:65bc:e475 with SMTP id s41-20020a056870eaa900b0013165bce475mr5880425oap.15.1664385979703;
        Wed, 28 Sep 2022 10:26:19 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202:7121:ae72:af3b:9956? ([2804:14c:4c2:8202:7121:ae72:af3b:9956])
        by smtp.gmail.com with ESMTPSA id q42-20020a056871082a00b0012796e8033dsm2702795oap.57.2022.09.28.10.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:26:19 -0700 (PDT)
Message-ID: <9024bdb2-4460-0424-42f4-b280983f3146@gmail.com>
Date:   Wed, 28 Sep 2022 14:26:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Tales Aparecida <tales.aparecida@gmail.com>
Subject: Re: [PATCH v2 0/2] kunit: add boot time parameter to enable KUnit
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20220823142456.3977086-1-joefradley@google.com>
 <10f97a94-ab35-fbc7-4dd7-98586a027c8b@gmail.com>
 <CAF-60z2huZ0scPzrV8mrZGzH0Ha6-c+iszOdcpVV7y020m4arw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAF-60z2huZ0scPzrV8mrZGzH0Ha6-c+iszOdcpVV7y020m4arw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28/09/2022 10:58, Joe Fradley wrote:
> On Sat, Sep 24, 2022 at 5:42 PM Tales Aparecida
> <tales.aparecida@gmail.com> wrote:
>>
>> Hi,
>>
>>
>> This series is
>> Tested-by: Tales Aparecida <tales.aparecida@gmail.com>
>>
>> 1. Tested using kunit_tool: running tests and showing output as expected.
>>
>> 2. Tested further by running QEMU through virtme-run with:
>>    $ ../virtme/virtme-run --show-command --kdir ../linux/.for-amd/ --mods=auto --kopt kunit.enable=1
>>
>> 2.a. "KUNIT_DEFAULT_ENABLED" works as expected when "kunit.enable" is omitted
>> 2.b. kunit.enable=0 results in printing "kunit: disabled" on boot and on loading test modules, as expected
>> 3.c. kunit.enable=1 runs tests on boot and allows them to run when loading test modules
>>
>> 3. Regarding taint
>> 3.a. /proc/sys/kernel/tainted is 0 when kunit.enable=0 and does not change when trying to load test modules.
>> 3.b. /proc/sys/kernel/tainted is 0 when kunit.enable=1 until the first test runs, then it becomes 262144 (2^18) as expected.
> 
> Tales, thank you for doing this testing.
> 
>>
>>
>> On other note, there's something I would like to delve into below.
>>
>>
>> On 23/08/2022 11:24, Joe Fradley wrote:
>>> v2:
>>>  - Added enable check in executor.c to prevent wrong error output from
>>>    kunit_tool.py when run against a KUnit disabled kernel
>>>  - kunit_tool.py now passes kunit.enable=1
>>>  - Flipped around logic of new config to KUNIT_DEFAULT_ENABLED
>>>  - Now load modules containing tests but not executing them
>>>  - Various message/description text clean up
>>>
>>> There are some use cases where the kernel binary is desired to be the same
>>> for both production and testing. This poses a problem for users of KUnit
>>> as built-in tests will automatically run at startup and test modules
>>> can still be loaded leaving the kernel in an unsafe state. There is a
>>> "test" taint flag that gets set if a test runs but nothing to prevent
>>> the execution.
>>
>> Do you have any info on whether these use cases would have something against writing tests for static functions using the documented approach of including the tests into the actual runtime code?
>> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
>>
>> Otherwise, would them agree to export the symbols that need to be tested?
>>
>> I would really like to understand better what are these use cases :)
> 
> I feel using the static functions as described in your link is a good
> alternative to
> modules with embedded KUnit tests. However, this is a different use case then
> I refer to, which is the ability to have the framework embedded in the
> kernel for
> both production and test with the control of test execution gated on a kernel
> command line parameter.
> 

I have another question regarding the compilation in this use case.

Does it have a strict requirement to minimize the kernel size?
That is, is there any requirement around built-in test modules
and/or a plan to load test modules on demand when booting with
kunit.enable=1?


I would also like to know whether the use case includes running
unit tests for AMDGPU or DRM, just so we can be aware of it when
writing more tests for static functions using the approach shown
in that link. 

>>
>>>
>>> This patch adds the kunit.enable module parameter that will need to be
>>> set to true in addition to KUNIT being enabled for KUnit tests to run.
>>> The default value is true giving backwards compatibility. However, for
>>> the production+testing use case the new config option KUNIT_DEFAULT_ENABLED
>>> can be set to N requiring the tester to opt-in by passing kunit.enable=1 to
>>> the kernel.
>>>
>>> Joe Fradley (2):
>>>   kunit: add kunit.enable to enable/disable KUnit test
>>>   kunit: no longer call module_info(test, "Y") for kunit modules
>>>
>>>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>>>  include/kunit/test.h                          |  3 ++-
>>>  lib/kunit/Kconfig                             | 11 +++++++++
>>>  lib/kunit/executor.c                          |  4 ++++
>>>  lib/kunit/test.c                              | 24 +++++++++++++++++++
>>>  tools/testing/kunit/kunit_kernel.py           |  1 +
>>>  6 files changed, 48 insertions(+), 1 deletion(-)
>>>
>>
>> Great work!
>>
>> Kind regards,
>> Tales
