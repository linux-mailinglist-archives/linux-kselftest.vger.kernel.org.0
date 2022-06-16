Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44B54E784
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiFPQn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiFPQn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7DB227CFD
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655397831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjMtM8OGnDrbMwcn+8vKnlZdrkOGRhE/5nADc7InRc4=;
        b=TSQFJkRBWy3mvIQerMvPzNPpML8zeT0oOJPe6Z6WXrAzfYtgo0XC38GHDJkICj+3i9k/ps
        8EzERBrf4TEe/rq3FmxDsc86RgyXxqLg1QyMeKB+nFZe8gNAeVoHRcN1ka5A7y1DkBF6u7
        xwdZ7fI3mYdQdGrwQICBt86RGeIjSW0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-d90u9gYZOUysfikrFbUKOQ-1; Thu, 16 Jun 2022 12:43:49 -0400
X-MC-Unique: d90u9gYZOUysfikrFbUKOQ-1
Received: by mail-wm1-f72.google.com with SMTP id 206-20020a1c02d7000000b0039c9a08c52bso851195wmc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AjMtM8OGnDrbMwcn+8vKnlZdrkOGRhE/5nADc7InRc4=;
        b=uvgjIuKULsUKGBL3GAwMR6zwbnkQD7x9qPypeVyGc77aFeWTgj0f7bK7R3nboTMQfi
         FWC8ck51FfbYj7UKa08mdb10fotYM6y84EuaDRgcx6qQD7zs1yxW7ptwIY8OkZ6zLYHa
         2PDejELR11AGAS2i8HnR6xYQgq1i1D86xRaboG+9pn3M7cZ9iD5cKHwoQQxuBq3IDj97
         /B9lXYCBj6n9HhosP9wqTGalBiPmrNDBQkW0Dv+MsnAjXVGBxQ1n2ScWcSZyxuhzarIM
         gjn5QVJRa1c1b+NzLU7/KLPBA76G3fR/e/iMCk8I2QR0avdQweq4DXWIRg4dZ0WNxFoL
         bTIQ==
X-Gm-Message-State: AOAM531djtWg5Ut1IQpRaEI5l/UOllujJQnLBrc2O9GQDJsRCxlOP91N
        MbUmnINIUJ5b7XXCf/uMivwiP/1usFWrNf+bH68DNVaonEsmCygK9E7SOvkBRyhY02kE+WCxuF+
        qWj2YAFonVhnVHrFHL1zgKJnsm2I6
X-Received: by 2002:a05:600c:10cf:b0:39c:8270:7b86 with SMTP id l15-20020a05600c10cf00b0039c82707b86mr16724436wmd.180.1655397828436;
        Thu, 16 Jun 2022 09:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8+fKsEXIAvNyB94ZpK27ofIlM12w0GekOLSDeZEFo92yryX6GxBCFSwKJr3GgRIgUlCaqhQ==
X-Received: by 2002:a05:600c:10cf:b0:39c:8270:7b86 with SMTP id l15-20020a05600c10cf00b0039c82707b86mr16724402wmd.180.1655397828203;
        Thu, 16 Jun 2022 09:43:48 -0700 (PDT)
Received: from [172.20.10.8] ([185.124.31.117])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b0020e63ab5d78sm2381222wrn.26.2022.06.16.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:43:47 -0700 (PDT)
Message-ID: <d6c00532-5546-ea4a-1927-9d4ea5e83741@redhat.com>
Date:   Thu, 16 Jun 2022 18:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/10] drm: selftest: Convert to KUnit
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        dri-devel@lists.freedesktop.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <20220615135824.15522-1-maira.canal@usp.br>
 <CABVgOSkVOKx1EEYtg-Os+kui-UivfFLT9OSEB9+sDxcgcxh5Mg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CABVgOSkVOKx1EEYtg-Os+kui-UivfFLT9OSEB9+sDxcgcxh5Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/16/22 16:55, David Gow wrote:
> On Wed, Jun 15, 2022 at 9:59 PM Maíra Canal <maira.canal@usp.br> wrote:
>>
>> KUnit unifies the test structure and provides helper tools that simplify
>> the development of tests. The basic use case allows running tests as regular
>> processes, which makes it easier to run unit tests on a development machine
>> and to integrate the tests into a CI system.
>>
>> That said, the conversion of selftests for DRM to KUnit tests is beneficial
>> as it unifies the testing API by using the KUnit API.
>>
>> KUnit is beneficial for developers as it eases the process to run unit tests.
>> It is possible to run the tests by using the kunit-tool on userspace with the
>> following command:
>>
>> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests --arch=x86_64
>>
>> For CI system, it is possible to execute during the build. But, we also think
>> about IGT: we are developing a patch to introduce KUnit to IGT.
>>
>> These patches were developed during a KUnit hackathon [0] last October. Now,
>> we believe that both the IGT side and the Kernel side are in good shape for
>> submission.
>>
>> If you are willing to check the output, here is the Pastebin with the output
>> and execution times [1].
>>
>> [0] https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
>> [1] https://pastebin.com/FJjLPKsC
>>
>> - Arthur Grillo, Isabella Basso, and Maíra Canal
> 
> Great to see these going upstream!
>

Indeed, this is pretty awesome!
 
I haven't reviewed the patches yet but just have a meta comment. There's a TODO
entry for this [0] in Documentation/gpu/todo.rst, so I think that you could add
a patch removing that as a part of this series.

[0]: https://cgit.freedesktop.org/drm/drm/tree/Documentation/gpu/todo.rst#n620

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

