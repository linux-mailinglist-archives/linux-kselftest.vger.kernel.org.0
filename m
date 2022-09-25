Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB065E9087
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Sep 2022 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIYAm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Sep 2022 20:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIYAm2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Sep 2022 20:42:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934353AB19;
        Sat, 24 Sep 2022 17:42:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n124so4308191oih.7;
        Sat, 24 Sep 2022 17:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NLPGK2dhZd36/mfkFKWxu94hqYVc7jjJmvv/jvdRUG4=;
        b=oX4dh7dMyuBvlOkvn9SX5ZOzdYiQREBVydJXVyaeY21t2bxstZ/kWGVuUAH3ZgSp00
         CZxHCHxrZDizejbsuNMXQCCb+9RNZWraWyk2ZVoijye3+e9glFWaC5oRGfKVkvG6jJ9o
         Fl29AdaxaLlPoF1qmLom3Ssl/o5tcqC+UDFIRCBHknavFnIMMHTVAf9LDKwgSHOqoqrY
         J8KU6Q5DAvS2smQtnhV9a6nm8bo9At8hSbACLa5d0Skzlb4JvCfiz3p582Pes4WJOToq
         Q3tEdOzMXa6ZCW1gL9hDCEIoLJKRjvgBUG2yntGcXo+2NFILalp/lSYNjaGatxjkVz82
         uggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NLPGK2dhZd36/mfkFKWxu94hqYVc7jjJmvv/jvdRUG4=;
        b=CKqDqh/Br6/4FRnrNzDCRO/9zFO2v4x6HOj4kobZdQ/ByouOO0ZMok2ghgYx3qK749
         5y6ru1CP3Zr3/GpgZfDezEiyxXGS1rZigH75hbz0p38pvxb305PZft2kGZtwdt6uM9n3
         GhIPJVG07lx7jar4F1v64eAzEByQfKDw3vI3ZN5PMobSnE6vBSWVGgRpNG6rEeKor6ht
         F6AvJEOzKG0pi3+/U7cJtWMSJPLnPyyOfO9e8U06xzjGrqLI/EwPLd7PA0608VQZx9hf
         VUTz/t0K3DvNAhLbCYw/YEMbLkG6TqM8rOMiPCJvMP9n7JiG3D0rKFZqZHqrfuEl6f7x
         4Ewg==
X-Gm-Message-State: ACrzQf312b3g7nuREGLcjCOly0k2jWakiBqAnN2lYnf+W67XDf6sK7Kp
        2NpB3009pSnjU3HfoKtrlYA=
X-Google-Smtp-Source: AMsMyM51J5ZjJT0N1G4n1zyTetQ/ko5/tbFz4H0PQiFNH+PvXHPSfKSrxMto/xKR+BZ4MSKCGbqs6g==
X-Received: by 2002:a05:6808:689:b0:344:d744:de36 with SMTP id k9-20020a056808068900b00344d744de36mr12111590oig.81.1664066546160;
        Sat, 24 Sep 2022 17:42:26 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202:d17c:3071:d072:e85b? ([2804:14c:4c2:8202:d17c:3071:d072:e85b])
        by smtp.gmail.com with ESMTPSA id e3-20020a9d5603000000b006558e6ff971sm5817129oti.39.2022.09.24.17.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 17:42:25 -0700 (PDT)
Message-ID: <10f97a94-ab35-fbc7-4dd7-98586a027c8b@gmail.com>
Date:   Sat, 24 Sep 2022 21:42:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] kunit: add boot time parameter to enable KUnit
Content-Language: en-US
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20220823142456.3977086-1-joefradley@google.com>
From:   Tales Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <20220823142456.3977086-1-joefradley@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,


This series is
Tested-by: Tales Aparecida <tales.aparecida@gmail.com>

1. Tested using kunit_tool: running tests and showing output as expected.

2. Tested further by running QEMU through virtme-run with:
   $ ../virtme/virtme-run --show-command --kdir ../linux/.for-amd/ --mods=auto --kopt kunit.enable=1

2.a. "KUNIT_DEFAULT_ENABLED" works as expected when "kunit.enable" is omitted
2.b. kunit.enable=0 results in printing "kunit: disabled" on boot and on loading test modules, as expected
3.c. kunit.enable=1 runs tests on boot and allows them to run when loading test modules

3. Regarding taint
3.a. /proc/sys/kernel/tainted is 0 when kunit.enable=0 and does not change when trying to load test modules.
3.b. /proc/sys/kernel/tainted is 0 when kunit.enable=1 until the first test runs, then it becomes 262144 (2^18) as expected.


On other note, there's something I would like to delve into below.


On 23/08/2022 11:24, Joe Fradley wrote:
> v2:
>  - Added enable check in executor.c to prevent wrong error output from
>    kunit_tool.py when run against a KUnit disabled kernel
>  - kunit_tool.py now passes kunit.enable=1
>  - Flipped around logic of new config to KUNIT_DEFAULT_ENABLED
>  - Now load modules containing tests but not executing them
>  - Various message/description text clean up
> 
> There are some use cases where the kernel binary is desired to be the same
> for both production and testing. This poses a problem for users of KUnit
> as built-in tests will automatically run at startup and test modules
> can still be loaded leaving the kernel in an unsafe state. There is a
> "test" taint flag that gets set if a test runs but nothing to prevent
> the execution.

Do you have any info on whether these use cases would have something against writing tests for static functions using the documented approach of including the tests into the actual runtime code? 
https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions

Otherwise, would them agree to export the symbols that need to be tested?

I would really like to understand better what are these use cases :)

> 
> This patch adds the kunit.enable module parameter that will need to be
> set to true in addition to KUNIT being enabled for KUnit tests to run.
> The default value is true giving backwards compatibility. However, for
> the production+testing use case the new config option KUNIT_DEFAULT_ENABLED
> can be set to N requiring the tester to opt-in by passing kunit.enable=1 to
> the kernel.
> 
> Joe Fradley (2):
>   kunit: add kunit.enable to enable/disable KUnit test
>   kunit: no longer call module_info(test, "Y") for kunit modules
> 
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  include/kunit/test.h                          |  3 ++-
>  lib/kunit/Kconfig                             | 11 +++++++++
>  lib/kunit/executor.c                          |  4 ++++
>  lib/kunit/test.c                              | 24 +++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py           |  1 +
>  6 files changed, 48 insertions(+), 1 deletion(-)
> 

Great work!

Kind regards,
Tales
