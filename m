Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3D753FC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjGNQVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjGNQVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:21:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89D211F
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:21:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-780c89d1998so15212839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689351682; x=1689956482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/cGtvz8XeWSeI/2ga1OjJQj7bUnENfy64USXIaMRls=;
        b=RTwPA+NsI6EAvbf0dITS+kJ/8I1AiDxT76aDhGrwVCcUXQHiHHE4v6UFSNUq+aSCGz
         ToMxIEC7pWGZ+ZkD9fJRjfauM1HZR7/7FeFewmmlGFuMG/RV7V2idZaUWL/l5TVTJhye
         aU3ntOHO9Kgu0L7KelkSP4IN/giRFc4qwLS5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351682; x=1689956482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/cGtvz8XeWSeI/2ga1OjJQj7bUnENfy64USXIaMRls=;
        b=aguOK13iiG5tXghwQntKmue2X5ncy4qEqNrnWhiSQYcj5y/IONO1Qen8ZDJzJjXm/e
         5LHaGztIpqowVertD5e6OBevx9k11VIT+HZ9x2q057CLn5rhZqhml5Bx1iaIrPUpYXFv
         Z1yL+cBiVX1JgU3KCb21TIzCeqOnrqbLVZYdlS2koQYqBZCn8CA7fI3tbvZvCgZVfgBm
         TD68PAwbRDxMyVrlgErPpqnaFUraFh2vznHe5K3Gmr1R2FCANAp563hfyxGwd55hV2jQ
         tdwB9ffszOoldq93MCA7TvFxyRr0fIwg40n2DH+OMUkOTGatJEbQlll/vklUgR9c6q1e
         9zww==
X-Gm-Message-State: ABy/qLafQBUK1QzPniNbl6DE2iVzsOmkG7cZ3n8apuug8HFAF4zeUGlb
        6dWUa5GlKHD7n9c7mZCK8GIwjg==
X-Google-Smtp-Source: APBJJlErVRJu0xQzt35AjSZhJIyGKrlyeOor51Wp+cBkXt8k2AEbxMVRN9RtunAybX6H+lLgyy/vbQ==
X-Received: by 2002:a05:6602:3ce:b0:780:c6bb:ad8d with SMTP id g14-20020a05660203ce00b00780c6bbad8dmr5651673iov.0.1689351681771;
        Fri, 14 Jul 2023 09:21:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f9-20020a056602038900b007862a536f21sm2745024iov.14.2023.07.14.09.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:21:21 -0700 (PDT)
Message-ID: <ecf66ba7-6e63-5ee3-acce-b2da9327b76f@linuxfoundation.org>
Date:   Fri, 14 Jul 2023 10:21:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607153600.15816-1-osmtendev@gmail.com>
 <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
 <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
 <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
 <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/26/23 12:36, Osama Muhammad wrote:
> Hi Shuah,
> 
> Any feedback on this patch?.
> 
> Thanks,
> Osama
> 
> 

Please don't top post when you are responding on kernel
mailing lists. It gets very difficult to follow the
comments in the email thread.

> On Sat, 17 Jun 2023 at 18:01, Osama Muhammad <osmtendev@gmail.com> wrote:
>>
>> Hi,
>>
>> Yes, I did install the latest kernel headers and TASK_COMM_LEN is not
>> accessible in userspace.
>>
>> I looked into the test which uses TASK_COMM_LEN but the test defines
>> it in its own header file.
>>
>> Example:  https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/pyperf.h#L13

bfp test does things differently because its dependencies
on run-time environment.

>>
>> TASK_COMM_LEN is defined in include/linux/sched.h, but this header
>> file is not exposed to userspace.

Correct. you can include linux/sched.h like other tests do
Take a look at tools/testing/selftests/clone3

thanks,
-- Shuah
