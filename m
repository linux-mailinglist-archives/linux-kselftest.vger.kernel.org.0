Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AFE57E077
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGVLFZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiGVLFH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 07:05:07 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736ABB8FB
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 04:05:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w204so5226152oie.7
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ClcvuyoVSKPNIGPC6XYZgGXhO5C2e/zHEXJEcPjU7bs=;
        b=HlbFIggBd1enoF0DBBJXL25iYInfB8KMOgRSOH0Gm/0Rnz/tw3zcqpPOaVNvCo8dbi
         PMBfY8aZfcU8Opx4xl7RRmXkJY2X4ARJnb7rpmW7Q4n+joakPxlqp0QDoSlHgbgk/BFE
         DIBwHFIawJ4pXB6oknmtXtXa7zUdC2/n6RZCL/wKNzQj5UeOV58unRrdzWPKcKl7Zet/
         XiPt/FqWvisQxBNGpdiBKjjyTxE0DRKd/fvm1v36PCjK48TQ2RlYJtmcvJHh1FysUzOg
         bstiUMl2kzKm9MTcMzOhx9TSs4vVQlBAGqboNRugdoK0CuvQow1/npjvp4Y4PsuSc64y
         qBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ClcvuyoVSKPNIGPC6XYZgGXhO5C2e/zHEXJEcPjU7bs=;
        b=W8/C+WcEGQQs+z6neBgybCQ6Np6kRFK5zWx/0zDR7ON3jolD8XTAF+Cu+XCoSbggZ+
         kHs79ciqrTx2tx6aP4mImqBqWNWtI8h8SvbUHOh58dzcMRMOi3YehT2d/O1FCyD7j/dA
         G7/nS+lKMxMAqSedCoGNg49yCy2zKbxOeKL8DTMraqX1/v1H1TlbRDtYDWtd/re4vBIz
         9DCK+R29SK+p7iJefm+jGU/OroExi9nFlTnDU2ce7C6/+2SyoWt720HEHUOIcLwPz3P9
         bjxpHDDem3lXc/kFQGFFhceVOjXbymhjAowFTXSVqFsptNch/cPGsuyFRyQstv8cPh7u
         WfjA==
X-Gm-Message-State: AJIora8usvHzl/OfjcfDsVLfVaNLdfeq5NIrZRwAvPNUuKYQbk99UeJi
        0hRT/kpnWkMrh0Hp8ZK4H283oQ==
X-Google-Smtp-Source: AGRyM1sOPgZ02x9KlIIK2eI9XwQtYb3a0w3MvEex17vJsjkcLOrRvD2nqiMuPMVayW1gZY+Usy1kiw==
X-Received: by 2002:a05:6808:201c:b0:33a:a038:ea8b with SMTP id q28-20020a056808201c00b0033aa038ea8bmr1184432oiw.98.1658487902053;
        Fri, 22 Jul 2022 04:05:02 -0700 (PDT)
Received: from [192.168.1.195] ([187.36.234.139])
        by smtp.gmail.com with ESMTPSA id u21-20020a056870421500b001019fb71e4bsm2105289oac.17.2022.07.22.04.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 04:05:01 -0700 (PDT)
Message-ID: <b1ae4f77-4e24-24c9-fd87-abcd612a3533@usp.br>
Date:   Fri, 22 Jul 2022 08:04:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
Content-Language: en-US
To:     Matthew Auld <matthew.william.auld@gmail.com>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Arthur Grillo <arthur.grillo@usp.br>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
 <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
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

On 7/22/22 07:35, Matthew Auld wrote:
> On Fri, 8 Jul 2022 at 21:32, Maíra Canal <maira.canal@usp.br> wrote:
>>
>> From: Arthur Grillo <arthur.grillo@usp.br>
>>
>> Considering the current adoption of the KUnit framework, convert the
>> DRM mm selftest to the KUnit API.
> 
> Is there a plan to convert the corresponding selftest IGT that was
> responsible for running this (also drm_buddy) to somehow work with
> kunit? Previously these IGTs were always triggered as part of
> intel-gfx CI, but it looks like they are no longer run[1].
> 
> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6433

Hi Matthew,

Isabella sent a while ago a patch to IGT adding KUnit compatibility to
IGT [1], but there wasn't any feedback on the patch. I believe that soon
she will resend the series in order to make all KUnit DRM tests run on IGT.

Any feedback on the patch is welcomed so that we can fix this issue as
soon as possible.

[1] https://patchwork.freedesktop.org/patch/489985/

Best Regards,
- Maíra Canal
