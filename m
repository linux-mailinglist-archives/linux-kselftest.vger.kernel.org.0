Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1F564004
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiGBL4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiGBL4e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 07:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 488E113F3C
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwZGWyzbjndeRVONcRo/Y/Xi6a7qOfJRRZZ6iABpQ64=;
        b=PLwNShmg41MeYHWwlaHWngpK4TdhD4DCpRPT43Esyl+gM8LEF+3NqUdg7QPriyhqFgWFLr
        VBlooAUUyaEwn7GO9otG/RA1kkVX7T1URcCeTxNUT7ptnbRIHIRJG1IA5aSemOSJrsurPV
        t/9zRd2r6xyudmYpxuE9+7PLV8jGR6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-QlDH1YiWPvixbkY0kus3aw-1; Sat, 02 Jul 2022 07:56:31 -0400
X-MC-Unique: QlDH1YiWPvixbkY0kus3aw-1
Received: by mail-wm1-f70.google.com with SMTP id 130-20020a1c0288000000b003a18127d11aso1349132wmc.6
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 04:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwZGWyzbjndeRVONcRo/Y/Xi6a7qOfJRRZZ6iABpQ64=;
        b=KI+wcJhubm3w6t41QH4kG4vbqAqZLUcW1xMiNNFOLw9ThcDQNlK+nEaSAV7FPTDdBy
         86rjtCxTwzdjP6laMt4k2P1cPQyZCJ52LARWWX/bwuGCHX7OkXGT5gCNMs5BRc6igk5m
         dLEOLJ8DXWILl/uwcZ5uQoLkE2fPyQH/NTOuXb+jR7j3conV2PUhad+0VWvwZulOfEfy
         c6B7lgQrfPkQW1oZBFnDf8ItGgK2hMD60U4QE9AJNzMfK08RoJ/zfNea+l8txAaQDRjc
         klo6yG2XK2XRwpnNCQdAmgHbwbVTZO/2daZVzLFdT/0LJ1IIN0iMrNnmCa3ZNOc/cjUV
         QcFQ==
X-Gm-Message-State: AJIora8lfdKqZN/l+6Jp09HNuYKkmaDqKpF09UqNd3w/xL+CR/Tj1Ej+
        keCH3oRKmwrgVJI4gh3V/hg5+GUmQ3dNxsJMYmA4clfRKcnltr3IZ4kYVlSaTLTLo6LTBJ94u6S
        3f5/VLYjVyRAti9FWYVB+x/5cNLTs
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr22390005wms.93.1656762989838;
        Sat, 02 Jul 2022 04:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uk1mCSCBDnIRoFf17fUzrFaDhgaShQwBHJ3hzA8TaQPISsd83pmv8uOjG8mUc6UBeHaesGRw==
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr22389983wms.93.1656762989620;
        Sat, 02 Jul 2022 04:56:29 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c19d400b0039c4f53c4fdsm12403602wmq.45.2022.07.02.04.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:56:29 -0700 (PDT)
Message-ID: <9185aadb-e459-00fe-70be-3675f6f3ef4c@redhat.com>
Date:   Sat, 2 Jul 2022 13:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/9] drm: selftest: Convert to KUnit
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/30/22 02:46, Maíra Canal wrote:
> Hi everyone,
> 
> Here is the v3 of the conversion of selftests to KUnit. Since the v2, there
> have been minor fixes. drm_format_test received the biggest change: the
> KUNIT_EXPECT_FALSE and KUNIT_EXPECT_TRUE macros were changed to KUNIT_EXPECT_EQ,
> as suggested by Daniel.
> 
> Most of all, the patches were rebased on top of the recently applied patches
> for drm_format_helper tests (8f456104915f), in order to avoid conflicts when
> applying the tests.
> 
> Thanks for your attention and any feedback is welcomed!
> 
> Best Regards,
> - Maíra Canal
>

Thanks a lot for working on this! The patches look good to me, I just had some
minor comments. If you re-spin, I think that we can just push the whole series
to drm-misc since the patches have been in the mailing list for some time and
have already been tested/reviewed.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

