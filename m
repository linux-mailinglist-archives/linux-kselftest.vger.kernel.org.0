Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73467D8B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 23:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjAZWny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 17:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjAZWnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 17:43:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEED45F79
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 14:43:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso3161334pjp.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFmyaM0qz+rP4yApBEttqduj7Z0OhMB/DfI8H+Cxm7o=;
        b=ToCn803vC3/2IxDu/GKQ6uEKkfLf2ohR1BjDYu1h0dj3Onrq4G1F98z67g0wI5qure
         cybGG3OUv832mfxhdAGnSR7dBnUYoYyl/immJn2lYF4rIHeuptoGaxV8+3a4Gj3GBPH2
         UBmo3T+2eUf+EBzbSsTCZH4WxmiaOKIIatcrWffs6f4NFML9Okq/MyoOWxhcox5B285d
         570yYtFEo2a4zwD2PLJeiudaTFyJ3MRKPNwzBB/Z9UZyvECXEkqNn9SJu5f5BlQV/oS4
         4YzHO+9nfo3JRqRw9p9ruu2O67PxCpQyzIk2j68wlkwHs18dUOLF9JIPdWmEg9Rsz1Lg
         1o6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFmyaM0qz+rP4yApBEttqduj7Z0OhMB/DfI8H+Cxm7o=;
        b=gzT+xG9XBoNAJJ5HavP0QjRTyCemwEzyHzzjry8A4HkEVgFPOhQ15L6uoWKIaW9ovT
         6uKm1dWAeAOD+Flc7/3v+bM9H+QFXtMH3KjbNeD/gd7ImMsx5z4un7gHHlMb9kmFLWQK
         uUPMRq+ykDRmZfeTdyKoJnvhwBsd6tgKqZlgfF4yQuAtT/tcEin6ktnj7RHsd2d0lOJP
         VsQJiif06LCeWbwYaExVic0p6ndRMJTPCwsmKmkrES9HcbRfwrRJj5Hxh42EE3FjWvhD
         u29VnU4qDQGwoXVayjX6RljEihMQXtBzc77MjvhViod+kjcUX3UfIUZc//Z4H85F0LTw
         nD9A==
X-Gm-Message-State: AFqh2kr01VCbCwCqtOL68ecWf+LYDxVF6j1ZWpQjdhwk0KXBwNawCpXI
        bGNg9SND8mYoepP9ahCqpJbBeQ==
X-Google-Smtp-Source: AMrXdXuTdeV/8t6XkbnhsD07G5vLYy6Ac3Q2DyKs0AFTVHK8sWOYASSvfvHGsHkc+/vbp9e+OsjJww==
X-Received: by 2002:a05:6a20:3d09:b0:b8:6fe8:5ed7 with SMTP id y9-20020a056a203d0900b000b86fe85ed7mr53553747pzi.44.1674773031010;
        Thu, 26 Jan 2023 14:43:51 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a001c8f00b0059260f01115sm165090pfw.76.2023.01.26.14.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 14:43:50 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Shuah Khan'" <skhan@linuxfoundation.org>,
        "'Huang Rui'" <ray.huang@amd.com>, <li.meng@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>, <sedat.dilek@gmail.com>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net> <000601d92db7$39e9d0b0$adbd7210$@telus.net> <c38ba6b9-b748-cf84-92bd-d29211b10f24@linuxfoundation.org>
In-Reply-To: <c38ba6b9-b748-cf84-92bd-d29211b10f24@linuxfoundation.org>
Subject: RE: [PATCH v2] selftests: amd-pstate: Don't delete source files via Makefile
Date:   Thu, 26 Jan 2023 14:43:53 -0800
Message-ID: <008501d931d7$aaba8360$002f8a20$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGd7wYRnyVvksQxjZQjWj1dK3j3EwMDsqvcAhOVwtSu/xNR8A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023.01.25 09:03 Shuah Khan wrote:
> On 1/21/23 09:41, Doug Smythies wrote:
>> Revert the portion of a recent Makefile change that incorrectly
>> deletes source files when doing "make clean".
>> 
>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> ---
>> v2: fix address list.
>> ---
>>   tools/testing/selftests/amd-pstate/Makefile | 5 -----
>>   1 file changed, 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
>> index 5f195ee756d6..5fd1424db37d 100644
>> --- a/tools/testing/selftests/amd-pstate/Makefile
>> +++ b/tools/testing/selftests/amd-pstate/Makefile
>> @@ -7,11 +7,6 @@ all:
>>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> 
>> -ifeq (x86,$(ARCH))
>> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> -endif
>> -
>
> This looks good - Do you need these files to run this test and if so
> do these need to installed when the test is run on a test system?

I do not know.
It is a question for the AMD people.

> Now applied to linux-kselftest fixes. I will send this up for the next
> rc.

Thank you
... Doug


