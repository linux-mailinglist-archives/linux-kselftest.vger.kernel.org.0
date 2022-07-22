Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6557E450
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiGVQZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVQZe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 12:25:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA7574E17
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 09:25:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m12so7381249lfj.4
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hardline-pl.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2cHLZsYSzu3vlQWq2uTFZBxgK+nHwwF/vJBUwns59Ds=;
        b=n5bJ2manL/cCWuwR0ZJd2UvjhGDXg9VMCs+OvLl8bGyfqKipgVkFHueBbViZ2lEBA1
         6NKiKenhcTxri61yQIaTCHoiV6+sOqsgzuGab5gL8C3miq/ows4KAHWtKz6TrXJvEGmf
         j4Dffqm/p76WMCjN/vqMZ7AG/++q67fMOnnx7kbUwLmSYewy2QwjAYS4w5V8bf3xo54H
         4wkmllD15xq9EMw/cMlQcIe4twyMyi2w2808mTnrFhPlse51W3MSJ42rC9GL+9+wc0zQ
         88JuNMU3uUiozQmZoQhCNIpSzTJFN0MeFUMQJbKOOE6ZqdFbVJFwttBW/m5ZhwknQU6a
         4Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2cHLZsYSzu3vlQWq2uTFZBxgK+nHwwF/vJBUwns59Ds=;
        b=Z8LY7rgeoN4oID8FiVT41Hvk6WVa9mZIFm9qC0Z54gNFQ/qiJTHJ0USNI5H/j6yg7t
         lDAzmERaw2MeQzD7lvvM0tCcqgexW9QdAolmBSKejzZzvv3IRQ3v8CVJzZ9rbsBP53sx
         2VVwrfg4NuUzsc+vyjEpGlGwZcyiEX8tV0TYI+LbDZKgbDlG8zKQZNIaR8Wi2Nvb0Rk9
         r14HiGPADDtbi+ANiC2lx5bhUtHaSlKXszM3BD3XfD1VRo3zpSoJnjUfZbYZBXO9XRZn
         wjMEppbRVS3xUMZAkST6x39gGedeU+fP+qxne4BHcMPixHxHekUDQxxsfuzjRnaD5mqa
         x1Sw==
X-Gm-Message-State: AJIora9V/I/5pVleL6TaG6opMxl1TGgkd/9+dhkd/4ElMLiFKJfhwHoV
        zj7ufU76Revw7FTYOHI5cAe+ZQ==
X-Google-Smtp-Source: AGRyM1sPLTtJuvAxH41K5c4T5wV2zD6vvOVSwpXKE6dWwQy/OWWh7eYNR6Txk9u9vVFJK0Gagcmh7g==
X-Received: by 2002:a05:6512:3092:b0:489:dece:5539 with SMTP id z18-20020a056512309200b00489dece5539mr276918lfd.269.1658507130797;
        Fri, 22 Jul 2022 09:25:30 -0700 (PDT)
Received: from localhost (89-64-117-232.dynamic.chello.pl. [89.64.117.232])
        by smtp.gmail.com with ESMTPSA id b1-20020a2eb901000000b0025c8c3747bbsm1209127ljb.37.2022.07.22.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:25:30 -0700 (PDT)
Date:   Fri, 22 Jul 2022 18:25:29 +0200
From:   =?utf-8?Q?Micha=C5=82?= Winiarski <michal@hardline.pl>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     Matthew Auld <matthew.william.auld@gmail.com>,
        Arthur Grillo <arthur.grillo@usp.br>,
        siqueirajordao@riseup.net, David Airlie <airlied@linux.ie>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, n@nfraprado.net,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
        magalilemes00@gmail.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kunit-dev@googlegroups.com, mwen@igalia.com,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
        tales.aparecida@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
Message-ID: <20220722162529.wy4ox7pyjhno66lz@macragge.hardline.pl>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
 <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
 <b1ae4f77-4e24-24c9-fd87-abcd612a3533@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1ae4f77-4e24-24c9-fd87-abcd612a3533@usp.br>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 22, 2022 at 08:04:51AM -0300, Maíra Canal wrote:
> On 7/22/22 07:35, Matthew Auld wrote:
> > On Fri, 8 Jul 2022 at 21:32, Maíra Canal <maira.canal@usp.br> wrote:
> >>
> >> From: Arthur Grillo <arthur.grillo@usp.br>
> >>
> >> Considering the current adoption of the KUnit framework, convert the
> >> DRM mm selftest to the KUnit API.
> > 
> > Is there a plan to convert the corresponding selftest IGT that was
> > responsible for running this (also drm_buddy) to somehow work with
> > kunit? Previously these IGTs were always triggered as part of
> > intel-gfx CI, but it looks like they are no longer run[1].
> > 
> > [1] https://gitlab.freedesktop.org/drm/intel/-/issues/6433
> 
> Hi Matthew,
> 
> Isabella sent a while ago a patch to IGT adding KUnit compatibility to
> IGT [1], but there wasn't any feedback on the patch. I believe that soon
> she will resend the series in order to make all KUnit DRM tests run on IGT.
> 
> Any feedback on the patch is welcomed so that we can fix this issue as
> soon as possible.
> 
> [1] https://patchwork.freedesktop.org/patch/489985/
> 
> Best Regards,
> - Maíra Canal

Hi.

Instead of going back to using IGT for *unit* tests, it would be a better idea
to adjust the CI to just run the tests once at "build" time (just like e.g.
checkpatch).

We would then stop executing the same test multiple times on different machines
(note that both DRM selftests and i915 "mock" selftests are pure unit tests - in
other words, they don't need the hardware to be present), which would save some
(small) amount of machine-time that can be utilized to do something that
actually needs the hardware.

Plus there's no need to maintain the kunit-runner in IGT.
Note - we're currently going to lose "DMESG-WARN" detection if we go this route,
but this is something that can be improved on the kunit-side.

-Michał
