Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDC577797
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jul 2022 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGQRsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jul 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiGQRsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jul 2022 13:48:17 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26DE0E1
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Jul 2022 10:48:16 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso18636621fac.7
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Jul 2022 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wWo5nfiIszKM/pVy4I94cp8djYzE87GUS1z1+3Dj3X8=;
        b=saLG7Jfv/cpv45n+vut19GSIYCg0J4XcllVl0Aam+FMQb5sH5WDf/oZLHiJNqHixjZ
         ZZnTfYb2Hd5kBPab1/jtADZ9c+D5U9MuLSLVEc2VvkbWMsQ1wpldAj0rgGiLfKbsIfuI
         ilvDi6vtACVJ52c+rXIEEkQ7lJAKn/GP/oXoaxMU5wgT9ys2j3Y8FZ52sB+3db2fHGR0
         ssQ5PK1WKyH1pjuczTuP0UDSIp4/8LpF/bnWiAjuYhIAhGEoQKTknIFKukoY/OrSweo/
         ilSHXU4ccKOKQA0+tkx3/kVrglt2HndWhkm12mrJvsb/CBD5FIJeysiM651RUk/K+YPn
         SHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wWo5nfiIszKM/pVy4I94cp8djYzE87GUS1z1+3Dj3X8=;
        b=YU0GZ2nrjtJlq9ntbIwm0sHI/1ArBcywbGcZz/oso3MzOluOs+YfegytMbU8ebBKiB
         wGpPUlPh6rJooXwqWjWyEmcuae2qONE6pZywylcSgibh+wn8fHgQArOejSUeEy/RX3kY
         Uhkw5/yGutm3gwbiLCHou0vx2f4idKGRC842yj/X1gTJad++BWOf1NXyB3ewD7kC6bJ/
         Wwjxp9W0gJ4e7DrsCVcJ+s6V3NDRvygTAaV6YqGADZjfkjDBiptiT+WYVdCHQbPhiHaU
         960co7ISzdKTS9d2M/wL57HDnq4vQhe4sMWuM9RflxdB0tpgWnp5jdoqwsMkwYAOvEpb
         jI6A==
X-Gm-Message-State: AJIora/gnumm+tunQXuBbAXSwG5PN5kZVZWdHpXweCo8HeoIl/M5unQl
        BYlQtpP/GAfEiBt+3JvtOQAeLQ==
X-Google-Smtp-Source: AGRyM1sQBNoOS0lLk6GPha7ctC/wcB/G6Pai9TruWEuZD5rTUvN3LQo6MebMZgKUkaJTNbl4nz6TvQ==
X-Received: by 2002:a05:6871:b0d:b0:10c:10bf:1276 with SMTP id fq13-20020a0568710b0d00b0010c10bf1276mr12608104oab.185.1658080095178;
        Sun, 17 Jul 2022 10:48:15 -0700 (PDT)
Received: from [192.168.1.195] ([187.36.234.139])
        by smtp.gmail.com with ESMTPSA id x27-20020a9d459b000000b0061c68a35fdfsm2470857ote.9.2022.07.17.10.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 10:48:14 -0700 (PDT)
Message-ID: <99aedd6c-0254-9712-a7d7-d94c0be31086@usp.br>
Date:   Sun, 17 Jul 2022 14:48:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/9] drm: selftest: convert drm_format selftest to
 KUnit
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-5-maira.canal@usp.br>
 <20220714235137.GA485839@roeck-us.net>
 <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/22 21:03, Daniel Latypov wrote:
> On Thu, Jul 14, 2022 at 4:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Jul 08, 2022 at 05:30:47PM -0300, Maíra Canal wrote:
>>> Considering the current adoption of the KUnit framework, convert the
>>> DRM format selftest to the KUnit API.
>>>
>>> Tested-by: David Gow <davidgow@google.com>
>>> Acked-by: Daniel Latypov <dlatypov@google.com>
>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Signed-off-by: Maíra Canal <maira.canal@usp.br>
>>
>> This patch results in:
>>
>> Building powerpc:allmodconfig ... failed
>> --------------
>> Error log:
>> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
>> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3712 bytes is larger than 2048 bytes
>>
>> presumably due to function nesting.
> 
> This can happen when there's a lot of KUNIT_EXPECT_* calls in a single function.
> See [1] for some related context.
> There were a number of patches that went into 5.18 ([2] and others) to
> try and mitigate this, but it's not always enough.
> 
> Ideally the compiler would see that the stack-local variables used in
> these macros don't need to stick around, but it doesn't always
> happen...

As a matter of fact, for GCC 12, the warning -Wframe-larger-than=
doesn't show up due to compiler improvement, but for GCC 11.3, it does.

As I have GCC 12 on my machine, I didn't even get the warning.

Anyway, I'll separate the test into multiple functions to avoid any
problems related to stack size.

Best Regards,
- Maíra Canal

> One workaround would be to split up the test case functions into smaller chunks.
> 
> [1] https://lore.kernel.org/linux-kselftest/20210929212713.1213476-1-brendanhiggins@google.com/
> [2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-1-dlatypov@google.com/
> 
> Daniel
