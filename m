Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916D4563FE5
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiGBLtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiGBLs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D09812628
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBzEfGWVygyiM8W1L6ivraoo44EoMnZSdZ7RWUgjnqY=;
        b=NsRfwjfsPRUVFhra/nuC7xWrMGJcmWP/pZh8vnXpc5HTU+SVCYdOZ0MInxO96szN8nMa0c
        3tUmPq0QTZScthxTZplGadaYbcK4O4nwGdLpOPmVKwh5DL7YwETgsXWSyG9XALlW6lPYNs
        uRPMuuAcKHQzItHrXztBdkBQuh0Pybo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-ohIFtGZuOLOY6S6vz_2JSg-1; Sat, 02 Jul 2022 07:48:56 -0400
X-MC-Unique: ohIFtGZuOLOY6S6vz_2JSg-1
Received: by mail-wm1-f70.google.com with SMTP id c185-20020a1c35c2000000b0039db3e56c39so4391537wma.5
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kBzEfGWVygyiM8W1L6ivraoo44EoMnZSdZ7RWUgjnqY=;
        b=vFyqbEUF3gNZYrWgqhydR1oyBN4BuvcZaC2BqNoKIfpsQ/iEHmjBEEH9peOyUOzcpv
         QZZn19FLtA0eVn5TYnKhAINHZ7s8PbzBaw08ECQHCQG5zpt4svVOdQc7P3JJ/kgUg79m
         PmD7sX0LiV60Tmxr0dKttaiZBqaIwp1eyMSnOlpLa7AGcTzPcihKufcDF5OTyk1N8mgj
         W4dOLAgZv/V9vNAeR505H0H6ORuSV/PHhYmwzEtX9tBUL5cjNc9Lm/wswiZ1GwjPWx5S
         Zq5t81a2gWeY2CEYv/efJc3G4vi1r1jRJJo7dqMXK/U+lJBWeSfI2ku3DwybS8KtdMuD
         QPiQ==
X-Gm-Message-State: AJIora+1U5OyZRGSaIbSVdjDJQA6BN01qk3tSdVxJMXhRgQr7xkxuIlf
        jhK6gGXyf13OKAXcMXwl9liWIBefT4g95accL5SqwUah0zeFKespRTF01khzLS7d8uM99VgTuIl
        i6GVU+L/SLKCIwa8atak6/gb6HePC
X-Received: by 2002:a05:600c:4fc8:b0:3a1:987c:82d4 with SMTP id o8-20020a05600c4fc800b003a1987c82d4mr1515604wmq.26.1656762535556;
        Sat, 02 Jul 2022 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swi8yT8lpV7nvJfPgVektW9uU61vfUOnnidEB+Xc2gOSrZeoWzU44iyITMmphx0FKxo3RADw==
X-Received: by 2002:a05:600c:4fc8:b0:3a1:987c:82d4 with SMTP id o8-20020a05600c4fc800b003a1987c82d4mr1515575wmq.26.1656762535333;
        Sat, 02 Jul 2022 04:48:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e3-20020adfef03000000b0021bbd525b8esm25724496wro.45.2022.07.02.04.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:48:54 -0700 (PDT)
Message-ID: <5e612797-3506-527c-46c5-cae9045c69e4@redhat.com>
Date:   Sat, 2 Jul 2022 13:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/9] drm: selftest: convert drm_dp_mst_helper selftest
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
        Rubens Gomes Neto <rubens.gomes.neto@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-7-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-7-maira.canal@usp.br>
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
> DRM DP MST helper selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
> Signed-off-by: Rubens Gomes Neto <rubens.gomes.neto@usp.br>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

