Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF726564050
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiGBNR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBNR7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B79D82E0
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656767875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wQWnDeTi8uNY3ltPnFoch0K9/rDLf1kzMqZRJMA7Nw=;
        b=jUL/xrKZ/5z3WzRoNVE38XIZ/M+o7MCBClN0GR4ZZB9RpoNAvftyOCybiZmSM/wmhKL9n0
        EZm4iPZ0PfV1gL2FQ4FQ3u7b1sAI2ult6jsBjGLcsofFjeASNjco1hf1CE+BmwyGXXcJ1X
        qoqsH1xTOeckMrUrmwWeoIXb2KWUwR4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-g-Y2Mg3WO_K0O8C6CswsBw-1; Sat, 02 Jul 2022 09:17:54 -0400
X-MC-Unique: g-Y2Mg3WO_K0O8C6CswsBw-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so2118048wmr.7
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7wQWnDeTi8uNY3ltPnFoch0K9/rDLf1kzMqZRJMA7Nw=;
        b=G2IcUyk/292tsaXFDkLJHEBxZfQhknGG9lkk2ihIcT4SAe/2xXNlqDdjlbqielp24C
         ZfVqd395jTH4JvzvVNE6kjElRyCtGJ4aIw9Dc60Ynx4Lmm4qvjOpvHVyioTWAuEA2I2G
         bNiZmmyhLVjPpSYT9dppddyKOTygb1ld+TL/gCSUThy0kRjpR8MGGHkbn9bDN3CshPDC
         k2JCZ0vS/FXBx0riA/xVZ/qk04wPsv5bRHVKmUEBMwmHfocdbf6bkhtgo8MExLQjFxO7
         7KSwUkuw+fQvuh2J9ikaC8dyjtzzb0AJVJiAKV2YMcskzzwF04RsxmXBC/JJbWskXmIK
         FSiQ==
X-Gm-Message-State: AJIora+lr1rVWcjZtDYuHLDFQKkNKNc6exgPd29lS+gTEf5V04lGHkvV
        vsFoG9d16V7daStOp+5zzOS0SUlHoe149/t7GD9LPmj1umQCJnL8pgIPz1K/6mgVB9pjVBRDPi9
        bd8ir+LKaLvG8xEjKC6iWu+DLKKWf
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr21754899wmb.199.1656767873496;
        Sat, 02 Jul 2022 06:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vu2EJ+eqiyEMxGUkvKkZOQdhu9zVQtQLZAzTQirdJVvvl4MeRJd20akcdE/RUh+2SrmUL0sA==
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr21754878wmb.199.1656767873173;
        Sat, 02 Jul 2022 06:17:53 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm24999260wrp.57.2022.07.02.06.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 06:17:52 -0700 (PDT)
Message-ID: <4c2dc8cd-56c4-6e15-d76e-429dba87407c@redhat.com>
Date:   Sat, 2 Jul 2022 15:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/9] drm: selftest: Convert to KUnit
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220702131116.457444-1-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220702131116.457444-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Maíra,

On 7/2/22 15:11, Maíra Canal wrote:
> Hi everyone,
> 
> Here is the v4 of the conversion of selftests to KUnit. Since the v3, there
> have been minor fixes, asked by Javier. Basically, fixes on the SoB chain and
> addition of Copywrites.
> 
> Thanks for your attention and any feedback is welcomed!
>

Thanks a lot for the quick re-spin of the series! I'll wait a few days in case
someone else has additional feedback and then push to drm-misc (drm-misc-next).
 
> Best Regards,
> - Maíra Canal
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

