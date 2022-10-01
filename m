Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581D5F19B3
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiJADu4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJADuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:50:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD59F188
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:50:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a13so8270188edj.0
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 20:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WaLUflGp+ER8JMdsZF7pCLBibmoeeQM/rsP1Z13Gn/s=;
        b=Nkepc4X+DwRlUjX0pNAaDvA66nrZjfktHdRUo3S5Es09y57c6hoaxg6lszGWscW+YL
         fZA4KM0SbHyvozPdxVU1mliYgT2wYlWUlWHIu4+Xd9mwkDrVdoMF98CTmzVxWtkhUfqn
         hvdeCmSJzg1tabw5HqZu777zkGsmdHRk+xnWCklVUWYdrwNulem77ZEa11050Z605rnw
         Q/XOeSgRcL6qgw50baGvkzLINiinYl6UK0uo9cgZ2ShOwR47BNZQTtV85rywxT9KpJsx
         Ch8IsZ0aTqBXzDHMTdLNIojWV/lrmMmOTbUzkkFMzSPwRy5ixzVz117xcItu4jlrAuYD
         jFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WaLUflGp+ER8JMdsZF7pCLBibmoeeQM/rsP1Z13Gn/s=;
        b=CUGfmbpprY58O2hpC2rQ4zqWwy/WdmFEI2IC7nAqX+BuzcT8B4129j0Kl44A8B1fM/
         vZBwsTtM5LWhdCs1v2vbA/QPDEtYazRxYkDAdi/dqyfK32goBJ4onvQZGZD/WKUHQwf1
         IG7tbkhU5lEuZ4yN5SwmFy0TOAN6PgaG8Ir75GjAAMvej1+wt8DOIe+ycAi5N7WIlPkG
         fxT6eJ5+o0ItVkj0d1vJkH2FKkGLPpNS61vPV+7GzGtvMjXfxkp8W5yboge1sF5qhCDU
         elMm/e/9fGBoFk6bnyWREdDWxdKzU7YL9+/OCxDxBbtWxpYEyaKjuKJbFfHjLhD5Nkht
         Wd6Q==
X-Gm-Message-State: ACrzQf0UkDtbtnAyRzGsciaHti8pvDxisodMsBYxqeLzhvkpwZGUzq9k
        eQ3ABq7wHAX8dEyR5eANf/J/BCc+h7gehAzsGAIbcQ==
X-Google-Smtp-Source: AMsMyM4L2ATWaw7x4q4WHBrCRiQl6x/DFppAgC7Hq3QQSN5wHQbUqcA/PKAbp3utMNvE41U7QNCWwyqFgLrUNiVOOzU=
X-Received: by 2002:a05:6402:11d0:b0:44e:ec42:e0b8 with SMTP id
 j16-20020a05640211d000b0044eec42e0b8mr10118434edw.131.1664596251814; Fri, 30
 Sep 2022 20:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-3-dlatypov@google.com>
 <CABVgOSn3SupF_z84FghxX-yK-CLx_RQMkUxF_hGUw6a3w7h-7Q@mail.gmail.com>
In-Reply-To: <CABVgOSn3SupF_z84FghxX-yK-CLx_RQMkUxF_hGUw6a3w7h-7Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 30 Sep 2022 20:50:40 -0700
Message-ID: <CAGS_qxpDdAz6DZxojhnh_XRuJ4MR-oQkQNCES_Lpe1OEO8QTUQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 8:26 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Oct 1, 2022 at 8:26 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Context:
> > Currently this macro's name, KUNIT_ASSERTION conflicts with the name of
> > an enum whose values are {KUNIT_EXPECTATION, KUNIT_ASSERTION}.
> >
> > It's hard to think of a better name for the enum, so rename this macro.
> > It's also a bit strange that the macro might do nothing depending on the
> > boolean argument `pass`. Why not have callers check themselves?
> >
> > This patch:
> > Moves the pass/fail checking into the callers of KUNIT_ASSERTION, so now
> > we only call it when the check has failed.
> > Then we rename the macro the _KUNIT_FAILED() to reflect the new
> > semantics.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good to me. I can't say the name _KUNIT_FAILED() feels perfect
> to me, but I can't think of anything better, either. We've not used a
> leading underscore for internal macros much thus far, as well, though
> I've no personal objections to starting.

Yeah, I also didn't add a leading underscore on the new
KUNIT_INIT_ASSERT() macro elsewhere in this series.
So I'm not necessarily proposing that we should start doing so here.

It feels like that KUNIT_FAILED is far too similar to the enum
    55 enum kunit_status {
    56         KUNIT_SUCCESS,
    57         KUNIT_FAILURE,
    58         KUNIT_SKIPPED,
    59 };

I.e. we'd be remove one naming conflict between a macro and enum, but
basically introducing a new one in its place :P
Tbh, I was originally going to have this patch just be
s/KUNIT_ASSERTION()/_KUNIT_ASSERTION() to reduce the conflict.
But I figured we could reduce the number of arguments to the macro
(drop `pass`) and have a reason to give it a different name.

I'm also not entirely convinced about _KUNIT_FAILED(), but I haven't
had any significantly better ideas since I sent the RFC in May.

Daniel
