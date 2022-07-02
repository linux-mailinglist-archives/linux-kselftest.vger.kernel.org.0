Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535A8563FDA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGBLnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiGBLne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25AC265EC
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbzjeP733JJcvTiFZgcVN9MLGyXZoHJ3An9xaE9Mer0=;
        b=IY8dqthGRmYre1Y4W7Sp9QSypJh2QhGu3ScRfwggBQ0IGOGWRgdzS5sR0uHOdGm1pudPJq
        BD8L2x5PGWzI4+69do8kNdr8CVzsSR4R6PGJL5TXM9Y6RTBJjpvDUkoDtGq23dW7HXRoWO
        WQW7f1lPozQs+TigX/jUQtWUUfjftac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-b_S-RUeQMYuRbdELmtC81g-1; Sat, 02 Jul 2022 07:43:31 -0400
X-MC-Unique: b_S-RUeQMYuRbdELmtC81g-1
Received: by mail-wm1-f71.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so2652869wmb.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PbzjeP733JJcvTiFZgcVN9MLGyXZoHJ3An9xaE9Mer0=;
        b=T4Z8dZD7UxvPW/K+8uZ+uJ5WUetfx9eKrtKdlMw3n3H71rGXuW88qO8iEyQy0E5J+j
         qh6PHCFrTYj7wnswcEaxHiHEx96S6zYQAjh9bTD2jZGeOR/hS79tGspOnx4R3khvX/SF
         scNfngCqZbQ11tQq/U8ila2Q/AH9wbk0KX9SsJJOkgkscNue1J6I5ZvVQ4/Z4ykIEL0K
         aU0A4nUQOKN24BbYC3bJrgGOQMxNjVGqe68mPuFnIr1vPfdqcUuSTMd083duC4RppMrB
         xE/C7yC5gheDEngdQPwTgrN50FR/1PCnJwaUigTzJxrpPsnaq7/WFGuOLqd8P6hljY3t
         ZTiA==
X-Gm-Message-State: AJIora9uuu1dDpwdmPYUV7x2/GCSfKDZEmljqsi++Pp3I5/utRqMdk7B
        WnlDI2a2+jP8FOUBadVZw3l348Gzwp5tjiOuj8gfDl930FJNfEdV5ASoH2uTbTKi9Ml03TwaQ6m
        o4/mQkequ6Sd79+OzokMbQTWjJSgM
X-Received: by 2002:a05:600c:4fcc:b0:3a1:987c:82c9 with SMTP id o12-20020a05600c4fcc00b003a1987c82c9mr1512514wmq.73.1656762209852;
        Sat, 02 Jul 2022 04:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQcHugUEZ9KO1/nr+/RF7l5XX6tPDRbcp0l1WhZlrP6E+q6SRGmu/furjWiHWsdioaZ4tj0Q==
X-Received: by 2002:a05:600c:4fcc:b0:3a1:987c:82c9 with SMTP id o12-20020a05600c4fcc00b003a1987c82c9mr1512497wmq.73.1656762209598;
        Sat, 02 Jul 2022 04:43:29 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b003a03e63e428sm12286686wms.36.2022.07.02.04.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:43:29 -0700 (PDT)
Message-ID: <b6ea63c2-afa0-6310-dcbb-0ca29c864963@redhat.com>
Date:   Sat, 2 Jul 2022 13:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/9] drm: selftest: convert drm_format selftest to
 KUnit
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
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-5-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-5-maira.canal@usp.br>
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
> DRM format selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

