Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B22A570898
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiGKQ4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKQ4r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 12:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82D164AD7F
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657558605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adXNKimZqOqTZafXK0kK9fx2kRZLSBE0wAzA1vGBEIY=;
        b=A+MtCKo/hQoyiSq/hqMpquYKCYw8VQE2ognnsNHc0FF6/xsA5e+Eu2ENZntdp6h6oq2hAj
        6Nar2ZzqP/+CY0LwvXv3jl9sstXr2OKIfZmsxYmF6VyV7bgzXdTLsuKZFuZ0mzzkTdwdvw
        1l5Bli9ibrz00kfn7qdXBRtl1ZRDpug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-NXVX6azXMGWsyemEX1v9lA-1; Mon, 11 Jul 2022 12:56:40 -0400
X-MC-Unique: NXVX6azXMGWsyemEX1v9lA-1
Received: by mail-wm1-f69.google.com with SMTP id r206-20020a1c44d7000000b003a2cfab0839so2600653wma.5
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 09:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=adXNKimZqOqTZafXK0kK9fx2kRZLSBE0wAzA1vGBEIY=;
        b=tQ9yZLCVHU7jphaXnIVs/BeO2e/A5VIvvSQt5Exf9xSY4cnTRkBriGnxevMvYstw15
         kSJ52+t95JPZhKKtQc00YNb26Sow1P0T5G/OSRh7GL6WhettMKTk5H9TpF8x95N4gAHH
         n1EJC2h0AaMR0m7FzfoTDfIqj97CEHfP5DwlvT6UjfgrGJt4ZLbcB4YyOOS8mcSeWfzB
         XqYK2Aw2QLceqMHr1Sye1LkwRuLQPA+uucR4796i7Y4H0MABFDy90Vni1LkB28DkqJpD
         CiLT+cQd6TD5iLhyB2mUi+VADCdT4PLwLl091QHcdZO6xrrGn9WYh8aNEW/3EfGwROTb
         AqzA==
X-Gm-Message-State: AJIora9mhfmhAg8Y2HVMfOulkKjsiVc+d01QU3Q9UE79PV/5jerVhI60
        eCwBk/J8Utg5uiaduAWYj6j9mPgD9ElKVGKX+ZV5b2pra7J7AVK2jsE4nYgOYd2H+H341yPOBO4
        g3H1WzEr65WidvPeAogpaLWOu7YhR
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id f12-20020a05600c154c00b003a1884e72acmr17702757wmg.23.1657558599111;
        Mon, 11 Jul 2022 09:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4/0yhpTv1pIJ7WGyqp3/Z7Pg+YEcmGi6GZFGQcW7Ca5cmu4BMZCEZ2evn2eYQWjVSeZ5D2A==
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id f12-20020a05600c154c00b003a1884e72acmr17702736wmg.23.1657558598929;
        Mon, 11 Jul 2022 09:56:38 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003a1980d55c4sm10143057wmp.47.2022.07.11.09.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:56:38 -0700 (PDT)
Message-ID: <7b13d811-08bd-1370-dbaf-b37f2cc728dd@redhat.com>
Date:   Mon, 11 Jul 2022 18:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/9] drm: selftest: Convert to KUnit
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
References: <20220708203052.236290-1-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220708203052.236290-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Maíra,

On 7/8/22 22:30, Maíra Canal wrote:
> Hi everyone,
> 
> Here is the v5 of the conversion of selftests to KUnit. Since the v4, the only
> fix was checking the checkpatch warnings and checks (Thank you Javier).
> 
> Thanks for your attention and any feedback is welcomed!
> 
> Best Regards,
> - Maíra Canal
> 

Thanks for the quick respin. I've pushed this to drm-misc (drm-misc-next).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

