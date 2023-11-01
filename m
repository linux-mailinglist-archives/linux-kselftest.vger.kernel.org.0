Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA917DDE23
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 10:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjKAJIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjKAJIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 05:08:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C086102
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Nov 2023 02:08:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso10831701a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Nov 2023 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829684; x=1699434484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/U0/4Zp074LQCHLOPGw0y7Rk5ZQHkrZnxdbMLDRkzg=;
        b=lvJrhrll+gvD+M6wGbJBSmHy1aSyYOGVuMJTJ2gdXBcSLGPTWGVJutLDvpaA6enOB/
         BF5sDYPJkB0QfL92zR6KSrd3xYn7z2EVIK17ix5CuzJRc8LuLbXoktQ3IUll3AgdiW3n
         XBGGpA3dO9LwzanJsPpxPzwinuWlXy6tQ29lsb5LOl9WJarizmKHcqvuUDcGbTbHpfNP
         oF4xEND1sTLlnMxOh/oFUiqfvI5HK7FYVHQA+h3eWmA8iSd8ADJHyttIAqrLS3HC+T38
         Swv2m2ON4ufsUUra7Xm0dJBmZByTtqTcDf/p9m6pivlDbiJYj+Fb8DhOV1oUyNbc5Hjj
         3UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829684; x=1699434484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/U0/4Zp074LQCHLOPGw0y7Rk5ZQHkrZnxdbMLDRkzg=;
        b=w/GbRxzvQ+Fb28Z7sLD85s9e3yDW3hL0bhfa2jujWsy1ks3K4o1xM2CDrDJcPIrBvC
         rVLqvy+2Skbqzm7qGoojLVcnBRRpzgVorGL1TvJ5YS325m8xrpm42lH8RRahWkFMctK2
         LJr7toj3xwNawg/nWNGjg74xwahLRQZZitvJcF3msbZLXX8fxB6Th0+e9DJ2ldf3LIKN
         VMleneE1MFyYKYAg1URa44QCrXjJQs/HkITio0K/ajI/84SSQs9JwmfvT9uigLOULa83
         +SqWoo9XpVjKoRR47hMn4TVapq8JPQ12k0ZSKnsgvw0le7fv+LDS52JxXygg2nX0qEHI
         wjnA==
X-Gm-Message-State: AOJu0YwN2NggOK/pp9BE5pXIdvNTCb2KegkejxD5IkO8iRotPDMH/A3g
        WblUZM7+iklXnXETGt4BDK4Zqj7fHusTiYRAb1M=
X-Google-Smtp-Source: AGHT+IEkFDGkW54r0Ia2H+xR2vSsVr8SXlt4hH1CjQgcbJiO9brVXLFjPPYe9xJEUR1RVJrrvuPydg==
X-Received: by 2002:a17:906:c107:b0:9bf:b022:dc7 with SMTP id do7-20020a170906c10700b009bfb0220dc7mr1204358ejc.48.1698829683706;
        Wed, 01 Nov 2023 02:08:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709065f8c00b0099bd5d28dc4sm2161031eju.195.2023.11.01.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:08:02 -0700 (PDT)
Date:   Wed, 1 Nov 2023 12:08:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, kv-team <kv-team@linaro.org>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
 <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let me add Richard to the CC list.  See lore for more details.
https://lore.kernel.org/all/CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com/

On Tue, Oct 31, 2023 at 09:57:48PM +0530, Naresh Kamboju wrote:
> On Mon, 30 Oct 2023 at 14:33, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > We have started printing more and more intentional stack traces.  Whether
> > it's testing KASAN is able to detect use after frees or it's part of a
> > kunit test.
> >
> > These stack traces can be problematic.  They suddenly show up as a new
> > failure.  Now the test team has to contact the developers.  A bunch of
> > people have to investigate the bug.  We finally decide that it's
> > intentional so now the test team has to update their filter scripts to
> > mark it as intentional.  These filters are ad-hoc because there is no
> > standard format for warnings.
> >
> > A better way would be to mark it as intentional from the start.
> >
> > Here, I have marked the beginning and the end of the trace.  It's more
> > tricky for things like lkdtm_FORTIFY_MEM_MEMBER() where the flow doesn't
> > reach the end of the function.  I guess I would print a different
> > warning for stack traces that can't have a
> > "Intentional warning finished\n" message at the end.
> >
> > I haven't actually tested this patch...  Daniel, do you have a
> > list of intentional stack traces we could annotate?
> 
> [My two cents]
> 
> I have been noticing following kernel warnings / BUGs

Some are intentional and some are not.  I had a similar thing happen to
me last week where I had too many Smatch false positives in my devel
code so I accidentally sent a patch with a stupid bug.  I've since
updated my QC process to run both the devel and released versions of
Smatch.

But a similar thing is happening here where we have so many bogus
warnings that we missed a real bug.

> These are starting happening from next-20231009.
> I am not sure which are "Intentional warnings" or real regressions.
> 
> [   37.378220] BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xc4/0x300
> [   37.645506] BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xec/0x300
> ..
> [  632.407425] BUG: KASAN: null-ptr-deref in kobject_namespace+0x3c/0xb0
> 
> 
> Logs: [Sorry for sharing long logs ]

Not your fault.  These long warnings are the issue at hand.

> ==========
> 
> ------------[ cut here ]------------
> [  629.699281] WARNING: CPU: 0 PID: 2834 at
> drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_hscale+0xbc/0xe8

Deliberate.

> [  629.914458] WARNING: CPU: 5 PID: 2836 at
> drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_hscale+0xbc/0xe8
> [drm_kms_helper]

Deliberate.

> [  630.172564] WARNING: CPU: 5 PID: 2846 at
> drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_vscale+0xbc/0xe8
> [drm_kms_helper]

Deliberate.
> ------------[ cut here ]------------
> [  630.388003] WARNING: CPU: 3 PID: 2848 at
> drivers/gpu/drm/drm_rect.c:138 drm_rect_calc_vscale+0xbc/0xe8
> [drm_kms_helper]

Deliberate.

> ------------[ cut here ]------------
> [  631.679963] kobject: '(null)' (00000000f512f33b): is not
> initialized, yet kobject_get() is being called.

Not deliberate.  This seems like a straight forward bug to fix.

Failing a kobject_get() seems like it would obviously lead to a
refcounting underflow and a use after free so I suspect some of the
other warnings that follow are caused by this issue.  We should fix it
first and see which warnings disappear.

So testing the Linux Kernel Dump Test Module is always going to create
warnings.  So intentional warnings are a part of life.  We should
annotate them.

But having too many warnings is bad and has caused this kobject_get()
bug.  We should delete the warning in drm_calc_scale() or make it a
WARN_ONCE() and mark it as intentional in the kunit test.

regards,
dan carpenter

