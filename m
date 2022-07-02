Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87A563FD7
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGBLmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBLmF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A872BDFE3
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/E75hYHnDmeoMvjyYpzgfBvleWEuDkid2Zmq4jEV8k=;
        b=PGYdJuqCaa8J1j6QpkG74Q0SHpN4W2PxXHcoYvQ+LNCp3r7BfHQQNGmTn2WSmakKCWTsts
        DyPyZiKh8ddA1aG985TOJDtDiWhZGCl0MPCU49epxwWt5bqufVhE2Ci+w3hq96VeniekMU
        SobBJSPMJZ5z5BlN7YhUfKcCUkyixkM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-VIa8Z1HXPySY2ez2CDUnEA-1; Sat, 02 Jul 2022 07:42:02 -0400
X-MC-Unique: VIa8Z1HXPySY2ez2CDUnEA-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so2666225wmj.0
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U/E75hYHnDmeoMvjyYpzgfBvleWEuDkid2Zmq4jEV8k=;
        b=WSV0ZbIV1x/agHT2luMvhGzFe77CWXUb3mlnEPS8SJrc927CIfY3+nT0tT0+v3bzO7
         ZmiXHrx/qONNcLIvIHb7zDDd7U3FoUEiqPHTDmhH2oKsix7nA8ARH3CkICTe1i/m4emU
         yvzCn0MPmbm+ow1LGlyrjE8uets0zcHgpDmxlWiIZAXASin20yTAaWpLnlQTiVvgGfWe
         d1W7oXvCbloxpnsKbY9Ert+VdekLGhf1adWJI4DfuvDegrtEZNtBHJiSOrnraMtg3jzG
         7VPjZqqZ4c/ani3dUwsQCE45NOtJQi/fihVOqlLR0zItNytGgGXSOL+FQnzigrQWELCG
         vOwg==
X-Gm-Message-State: AJIora+4e6Wmd3Mm7jDS6+kxqBwChUDJ4O+64bRHxLf2+g5zwKKfyQRa
        GUazO4VjTNf1tue36GGkkU3jk+P4l2TV60Y6PCnIBPCvW1GikDr3Vqam0izy5YU4njGY4MkYuSk
        o/c76DTrUHHS0/Qa2Wa2KMopCXJEV
X-Received: by 2002:a05:600c:19cc:b0:3a1:99b7:524 with SMTP id u12-20020a05600c19cc00b003a199b70524mr22923wmq.37.1656762121608;
        Sat, 02 Jul 2022 04:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tBQ3B3FAODT/Ald/2hl3TmPSH2nx4GxQVOeZWV3poSwjCXGzwimr+qiULYTSJ8jvIi1ip5hA==
X-Received: by 2002:a05:600c:19cc:b0:3a1:99b7:524 with SMTP id u12-20020a05600c19cc00b003a199b70524mr22894wmq.37.1656762121389;
        Sat, 02 Jul 2022 04:42:01 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm29564696wrr.63.2022.07.02.04.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:42:00 -0700 (PDT)
Message-ID: <00bb12a1-de3c-7a29-109e-ee0faa900b66@redhat.com>
Date:   Sat, 2 Jul 2022 13:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/9] drm: selftest: convert drm_rect selftest to KUnit
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
        Carlos Veras <carlos.craveiro@usp.br>,
        Matheus Vieira <matheus.vieira.g@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-4-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-4-maira.canal@usp.br>
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

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM rect selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Carlos Veras <carlos.craveiro@usp.br>
> Signed-off-by: Carlos Veras <carlos.craveiro@usp.br>
> Co-developed-by: Matheus Vieira <matheus.vieira.g@usp.br>
> Signed-off-by: Matheus Vieira <matheus.vieira.g@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

