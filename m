Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD59563FE9
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiGBLvh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBLvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F0D11262F
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX7NhBgu11gdEXWnivkjv4CHtCkCUVCWljnJciBNVYk=;
        b=hK4DNIoqvJXeFnQ0vM1uZ/lUgUb7IkMX7RO/fX/pnxUirxbSpNHk8V/q4BS1AA0sUeGVyb
        TBlnx6OIOzyFsI1MB6JsJEGn4FRWho+UO0Vy5FH0zPw6y4xhDi6lC7DG9v8PHdwvAt4WKo
        UutYxVHD0ZlwtM6wGTaFST1QcymCya4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-AqT5QZ8JOD-T-zr5RLZpeQ-1; Sat, 02 Jul 2022 07:51:34 -0400
X-MC-Unique: AqT5QZ8JOD-T-zr5RLZpeQ-1
Received: by mail-wm1-f69.google.com with SMTP id az40-20020a05600c602800b003a048edf007so2063914wmb.5
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lX7NhBgu11gdEXWnivkjv4CHtCkCUVCWljnJciBNVYk=;
        b=DgZpNCgyPXRYwblctZaWn8+4eN/L4JvFT/LFT/OiFrVewHxfEWeYN7042kqFBFWRaQ
         ZUuAAd+UN7IWOFns8zlgVmvzgBtdKihQdTVSYGOnDaK6tzyKouD4PkiC0jjfvb5Epxyl
         xCM1B/yuDKzJLxD5HHt4aTOh3g63fYjagSSWayIOIP4OANSYBPKfj8K9eFPK/DrYebO4
         ghlVlj+h2dpisTQeRIHY7lzxXHJn3uAX8BnbSsi5ci93Q1dqM8muNORufZNmrMZ+VAAo
         03zD2rusGaSTk7DpyLV+h4WHFQhI5TdJtMMYPdJxESEk+pIc6l9T8iJWMUwd7go8Xbdt
         IrTQ==
X-Gm-Message-State: AJIora/H5B4GIOFeVb7NGgjznrVn/Y1TU3jOQOE9DW9/ZBRrJmWhNcWM
        7K1aav6LyjBD/ht4JZ7UIe2sk3L4ynlM16wYRo0HzPEUmrEYOPtSGFHjyBYskIRUt3X/7SDIuZZ
        L4bDTw/HnD5Y4nNCUaAd+OHMgO6YJ
X-Received: by 2002:a5d:4304:0:b0:21b:9b2c:be34 with SMTP id h4-20020a5d4304000000b0021b9b2cbe34mr19190948wrq.577.1656762693112;
        Sat, 02 Jul 2022 04:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1suwBX9nluN5Fdjy1P3/ahvuZQQTgj5PLCla2XhR4/ZWQ/N9EQ/EXtH9IU3XKP12IYsUHFEEQ==
X-Received: by 2002:a5d:4304:0:b0:21b:9b2c:be34 with SMTP id h4-20020a5d4304000000b0021b9b2cbe34mr19190909wrq.577.1656762692846;
        Sat, 02 Jul 2022 04:51:32 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c4605000000b0039db31f6372sm9573473wma.2.2022.07.02.04.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:51:32 -0700 (PDT)
Message-ID: <b3939861-692b-4bc9-5cb4-e50aabb04917@redhat.com>
Date:   Sat, 2 Jul 2022 13:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/9] drm: selftest: convert drm_buddy selftest to KUnit
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
 <20220630004611.114441-9-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-9-maira.canal@usp.br>
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
> Considering the current adoption of the KUnit framework, convert the
> DRM buddy selftest to the KUnit API.
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

