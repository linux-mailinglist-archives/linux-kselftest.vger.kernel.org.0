Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C1563FF0
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiGBLwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiGBLwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E27DD1275C
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBlcdffUKRXsc9PEk6nABXGbXc001CdXE7OJZsMlP8k=;
        b=Yo/2BY3/ZtYu3zdzlWUpHFe/TKyj2MGLnMuZP0sISm00vfWPYjMyRzOzmA6DX+ZZcL7Y9c
        Kbuzz2wb9JnoPi9YooqzaP9CeM88BS/eqHwQ2ZLPHfshyvElRQHzLeAvyEj1ygso46WyTg
        UonlpJbuumwOFy5x3ACKxC5HgTXZPM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-2-9OolGrOuCa07bJMAJcmg-1; Sat, 02 Jul 2022 07:52:00 -0400
X-MC-Unique: 2-9OolGrOuCa07bJMAJcmg-1
Received: by mail-wm1-f69.google.com with SMTP id t20-20020a1c7714000000b003a032360873so4416358wmi.0
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aBlcdffUKRXsc9PEk6nABXGbXc001CdXE7OJZsMlP8k=;
        b=f7rlVrPqQJmU9rT3yyWPdtwcgGHeedLVWp2TKkqC5S998qdtLysPkCZ1ywXu5yStd7
         JCPxCArJd/uIBhy+1Gwpqq7UuzVYROhECzXFJsCPKcN/msVVantbPLUxQ1cqCj1wOfJU
         DBl+Or6ogTFBpzltTSl8AxZgQpGZOnnGlL9MjO94dHiWL60+KOI2tarqo2wcecLSCJAh
         DSd0shVwXLbkatumXfLmqv3HcfAci07s5T50XmTfVGm3BSAHx8f0dUMWP8iRsPPmavrK
         JjKEHp564x4jk3rk+dSbTjOefIEjxcwecCcikKJbLGVmwNQL+m5RzQgDKwPFDrKl3taC
         1x7A==
X-Gm-Message-State: AJIora9AzbhqGq9ojvjKI7BcvQwebG7wbkp+BYt0M9WG+yNygBYOwjwx
        QjIgcyk0l1L3WzwiQeQ2+6+cpp6e+RjtQrefPJrSw67EHk0GaYv9awyMAHk+NuO3cnTII/HKHNH
        y3YJ7t5jcaujzkX5MLARAOLzvgfwa
X-Received: by 2002:a5d:64cc:0:b0:21b:ba06:4d4d with SMTP id f12-20020a5d64cc000000b0021bba064d4dmr18344056wri.157.1656762719669;
        Sat, 02 Jul 2022 04:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMLyiRwowUy7DUksqJ/vVSe40CQaqIn/NcAmSSiFjb9qPtH8jDU3mm/OgbP9QtaipFYcRWBw==
X-Received: by 2002:a5d:64cc:0:b0:21b:ba06:4d4d with SMTP id f12-20020a5d64cc000000b0021bba064d4dmr18344033wri.157.1656762719467;
        Sat, 02 Jul 2022 04:51:59 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i30-20020a1c541e000000b003a032c88877sm9399422wmb.15.2022.07.02.04.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:51:59 -0700 (PDT)
Message-ID: <cd7137ea-16b6-dd0a-2a09-93185d874c73@redhat.com>
Date:   Sat, 2 Jul 2022 13:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 9/9] drm: selftest: convert drm_mm selftest to KUnit
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
 <20220630004611.114441-10-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-10-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/30/22 02:46, Maíra Canal wrote:
> From: Arthur Grillo <arthur.grillo@usp.br>
> 
> Considering the current adoption of the KUnit framework, convert the
> DRM mm selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

