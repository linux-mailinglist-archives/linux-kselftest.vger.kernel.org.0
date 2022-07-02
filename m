Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549B6563FEA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGBLsl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGBLsk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9DA012083
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsk5LtoJ5L3Sna553tYxn8C/ppvSkfs3ONiQ9booEt0=;
        b=JBVGClo7E9Sfe6jfq3kQlQZ07/hSDJJlmkDFQ0D1xKN7BiWcXJOW8NQbohfRze4QBzhCNZ
        Fk8tAOUuhvi+zufc4GeRD4DAoPBAzHyMSU0e2NpecntDqV+vIGAuZM2CFuGEOzSXfDmXdU
        Jmbhh0prGNR2XbXq0Gn8arI3ZsRFYDI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-8UVpPsu3Mv-4J65NEOc69Q-1; Sat, 02 Jul 2022 07:48:37 -0400
X-MC-Unique: 8UVpPsu3Mv-4J65NEOc69Q-1
Received: by mail-wm1-f70.google.com with SMTP id be8-20020a05600c1e8800b003a069fe18ffso4383299wmb.9
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wsk5LtoJ5L3Sna553tYxn8C/ppvSkfs3ONiQ9booEt0=;
        b=O1YHWqJdNGJKPKuaWSoUS1s/O4feaSDW276AYmJb2oM6Yj3wvDGYjdCB62vBRturc5
         rTD8z/+w7ZA55DqUMNCtI48r7FVDbfe5YmYPTnuvqlkFFyTBzahWsn9fCjv/NkxjxTnY
         3/IqUhI1PYNeyfXSHvyPJJXmm9/VDhdPD12mC8WSQ4Tkwn2Sm8OzS8MjtZ+07xxB0fEP
         8LNfY2JKI4zPk7HHWXZtJpB9wVeiW0rLOcgeSqm1Fbd4/0fsvhT/rsuGW0/BjFXoxSKg
         AbfPyeGPxIdkEVr8b1TLq54aWF9FafxORFvbaZdqEer6ZG+7iyFNPe+foVtujneIaHTU
         kD+w==
X-Gm-Message-State: AJIora/zh2dMUpxpVWP2GqM6fq3cHwQ7dqNchiyAwXD4JV3akJbUf6C/
        1NWnpB6K7L0eoCBzo6geiHhUWRapeI7V5OeqgtM5lU1oyhk3zjZSpZZMx9z17qxyK0wJnDf2G2E
        WIPzKkh6yR8epIEiMm7meL4frH82F
X-Received: by 2002:a5d:598c:0:b0:21d:26b6:ee94 with SMTP id n12-20020a5d598c000000b0021d26b6ee94mr17887653wri.457.1656762516668;
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttlfskSCAotB8xeeIXxHixn2sjYEgxtb1ckGEMA1lPqvwqnqGgGkPjbHj3Rl/IhS7i3ZNuuA==
X-Received: by 2002:a5d:598c:0:b0:21d:26b6:ee94 with SMTP id n12-20020a5d598c000000b0021d26b6ee94mr17887631wri.457.1656762516436;
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm13621989wmq.1.2022.07.02.04.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
Message-ID: <7ebde68e-7710-d0da-dff8-a06e1b6ba870@redhat.com>
Date:   Sat, 2 Jul 2022 13:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/9] drm: selftest: convert drm_plane_helper selftest
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
        "Djakson C . G . Filho" <djakson.filho@gmail.com>,
        Anderson Fraga <aaafraga@gmail.com>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-6-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-6-maira.canal@usp.br>
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

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM plane helper selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Djakson C. G. Filho <djakson.filho@gmail.com>
> Signed-off-by: Djakson C. G. Filho <djakson.filho@gmail.com>
> Co-developed-by: Anderson Fraga <aaafraga@gmail.com>
> Signed-off-by: Anderson Fraga <aaafraga@gmail.com>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

