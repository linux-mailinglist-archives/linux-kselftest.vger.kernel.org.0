Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066F4E5C12
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 00:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiCWXyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 19:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiCWXyS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 19:54:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16766403EF
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:52:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dr20so5964729ejc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9PW9Nmnmr8RhfFTGsfhk5R8Ok1BoFEzWy/OLdaXZC8=;
        b=rkRQcr0d4T7zR/olQuh3T4SdIaLIAkHjZGpFRFEb708iY/NkXbWAL8EcHV49uIe4ld
         seQzgeMdW6imJGSyWfIa3pZv7elk2l3u6sipIZVVcSVd1mCfmVUHz4c5TE1yhqQZSeuX
         BafityQ00e8cWUUJYFcWsFVmI3i/rlfE1lfxEknZ+KtzVZpze3YprOlNI0kULaxgfp9m
         UQ0+Ad53FCIwNNmymP0IByTH1X+L1XW1OBnmbi7uCXlfgy4oOPXqEPX8jRbWCfB6q4vi
         vGUV8EWGPkS/OgbHP5Cife+cgyR4Ms1DKEWDSORi1/ueTOQnhyaaNGgy7DNtWq4z2cx0
         eJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9PW9Nmnmr8RhfFTGsfhk5R8Ok1BoFEzWy/OLdaXZC8=;
        b=nPCQEmuZzf+FZ8ZP0NsOr2XiravY97bU7scRJva268hqhszPt61zkd+gVsTjbccbRs
         V8GxJdm/vAc96JBFon0beOZpPVpaQpj843Rip7kmQEg31hn4ZdzHkE5Xl8Oef7VkbncH
         dVIfetkgLK6caTXY/HnPmPR4nUx/x4K2qgilPnHpgRB6m7J9XyyOk1ZAs+UexAH+AYw1
         Cy5uBoR6IiUn8r4jHyuV+tYqEyFF7DI3h0lYz7dOz0NK+xs6rlLBVRmxDACkaLs4/6ib
         QARgTdA5W2579LwXZ39HnKwvCd+Zpxp57fNEZYhizA3043lSMmbog0gkII+AQzCyX1bb
         QZlw==
X-Gm-Message-State: AOAM532ipqR8ewcJ49RcQZ6wTnpcOlQbAvx+C0sJ05QdYPH/mi4gOP4D
        p3+hM/+lplROXtLKAU76/GdHbZE4yKPddsE+IgmA8AxnIcs+gQ==
X-Google-Smtp-Source: ABdhPJyPYDcIfFcE3a+3ekD9mUX6WYtGpKh6FSzIJcg5D0H3fkbHAyxgBOC6MCU+xA/BmEC9TO2X25SAfOx3KdqGxwE=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2861056ejc.196.1648079566471; Wed, 23
 Mar 2022 16:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com>
In-Reply-To: <20220316024432.1454366-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:52:35 -0400
Message-ID: <CAFd5g44hMjdy9u-m-StRe8UyJPdKkft3i5yn8ciuVHxU3KSSLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 15, 2022 at 10:44 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Background:
> Currently, a reader looking at kunit/test.h will find the file is quite
> long, and the first meaty comment is a doc comment about struct
> kunit_resource.
>
> Most users will not ever use the KUnit resource API directly.
> They'll use kunit_kmalloc() and friends, or decide it's simpler to do
> cleanups via labels (it often can be) instead of figuring out how to use
> the API.
>
> It's also logically separate from everything else in test.h.
> Removing it from the file doesn't cause any compilation errors (since
> struct kunit has `struct list_head resources` to store them).
>
> This commit:
> Let's move it into a kunit/resource.h file and give it a separate page
> in the docs, kunit/api/resource.rst.
>
> We include resource.h at the bottom of test.h since
> * don't want to force existing users to add a new include if they use the API
> * it accesses `lock` inside `struct kunit` in a inline func
>   * so we can't just forward declare, and the alternatives require
>     uninlining the func, adding hepers to lock/unlock, or other more
>     invasive changes.
>
> Now the first big comment in test.h is about kunit_case, which is a lot
> more relevant to what a new user wants to know.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C17 include/kunit/resource.h
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Aside from the discussion below,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
