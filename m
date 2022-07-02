Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC30563FBC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGBLdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBLdA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10B0516595
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656761578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/CG7OlSvFtvPwBtKbOScoNNsNb5w33jEJ9roT+riGE=;
        b=VsUd/B49SlrdiGK42tiBiJpcMNKKBFJtato26awWSp3sZ31ctBiTvNdq9sKdlm8+/w5UqN
        sZYFO4w0YUQ4gyabDDKdCE1OpzqsqZrKHu9cNlIgvumrfeVU32IlUPy5EceaSrI32f/7lS
        TMS/0tpscPAFPPJ2gB1CM9lmGk/bCjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-a_DCUPPEPqeUvX_lbI_9gA-1; Sat, 02 Jul 2022 07:32:56 -0400
X-MC-Unique: a_DCUPPEPqeUvX_lbI_9gA-1
Received: by mail-wm1-f71.google.com with SMTP id i5-20020a1c3b05000000b003a02b027e53so4373589wma.7
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+/CG7OlSvFtvPwBtKbOScoNNsNb5w33jEJ9roT+riGE=;
        b=TMGPwzuMiq/RcMafKO3TMD/zLnFRO1VauSbHb2/5SUqoFSS2lgr5gz9vmSN+4fTyNU
         ZeGYuYr6qHEIiNIi/bRB+lnBipQ/oqIYBPj7S0Vbe4gG1YQFG1gphDD21fpA3E7CxNoC
         Vit+nqF3I1V0P6ewNUEO4lyf+ikH/9t7f9Bl4N9YxJDawvokHVzq2LQ2BGfPApl3qQNm
         lzQ1xxD98TyeIxKrv/F8AZBwSxYXrONRm0R/DBdgd8w5/1xzdLcx8gE3Obo8bp6ad+xm
         uBICUHyjCz/ty10tys/d2PRN9Fs1jPpQ+iXpMpjNlrkfNbItgedfJ8BP7dMxmreW2Ow2
         Y0Tg==
X-Gm-Message-State: AJIora96HHqxDxhcgCfEtKlqZ50RGYNYNotJL1G6W1zjJJe6tkJniAFH
        sNicygTgoJTROzaI2L/DdOFK2OwMqlph/fi853XajZLs4q9Slecdss2RB2nJQ+DoqervsqqCg9o
        lNyYuq8YYgUVTnDTJX5IevrS4Tsy5
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id p17-20020a05600c205100b003a03c586ff6mr22334051wmg.98.1656761575581;
        Sat, 02 Jul 2022 04:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uK7lyTTBd7+vx/Qhs8VIxakL50jdfDusliR+VYkqGsWVRmfyQsHe77h/XIU94xnlgnS61zoQ==
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id p17-20020a05600c205100b003a03c586ff6mr22334016wmg.98.1656761575330;
        Sat, 02 Jul 2022 04:32:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y15-20020adff14f000000b0021d2f322e50sm9308324wro.41.2022.07.02.04.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:32:54 -0700 (PDT)
Message-ID: <ff375c95-96e9-6bcf-66ea-f70a44d0a5d1@redhat.com>
Date:   Sat, 2 Jul 2022 13:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/9] drm: selftest: convert drm_damage_helper selftest
 to KUnit
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arthur Grillo <arthur.grillo@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-2-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-2-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Maíra,

Thanks a lot for your patch.

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM damage helper selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

I believe the order of the tags should be chronological. That is, Daniel and
David tags should be after your Co-developed-by and Signed-off-by tags.

[...]

> +++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
> @@ -0,0 +1,634 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test case for drm_damage_helper functions
> + */
> +
> +#include <kunit/test.h>

Please add a blank line here to separate non-DRM headers include from DRM headers.

> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_drv.h>
> +

I haven't looked at the KUnits tests in detail since Daniel and David already
reviewed them. But from a quick glance, the tests look good to me as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

