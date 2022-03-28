Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A64E9DB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiC1RmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244624AbiC1RmI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 13:42:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17D5D1A2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:40:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so30214374ejb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jt/2KJODcgfg0427B2D9EMe8ii/7j8vJOFClANb3PD0=;
        b=AIx7uFeBO7lezvIfbwU6IX2xiruO53nNSMLWYwdOxDucBEV2PxHLFJojbplpKiVB1C
         aDvZnIIrbYCYvNyDBBdDhSsPJE0TG1vXL/+ARJ+2Wv7EHWJ+54rlhXes03XZRTHacBA4
         cfEQX5YLfQaiQqYbkIR27B7WnvXwhz/7RenoWcJ3158WT3DMMKcNnAkJH7GPN525P7hj
         J9cUBslhYZwxudBmBR/Lh/PJPKw2MDBebfYmCdZZqh8xjsiP1PUozNicgLb0d2EXpLyu
         oyo9tBgeDNfEl9eVVi5PwPqBUaBTbJws67i5wjUo4V9mQHOvbF8OMIc28rGvLBpV84cX
         xkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jt/2KJODcgfg0427B2D9EMe8ii/7j8vJOFClANb3PD0=;
        b=KPnhKHJJ5LsZBYFjNXDtmlO7jWCObRSU7v9j5N/v3J466I7/oHfnYFGmPufzQPuCA4
         uYKjt2AbMOQPe20IExBH8DkeXlYdsB5c/ePnaHsWo49pjsxLzMHuQxvK55F4T8zC7Mxn
         BllD/oeyHSqWBxoBXsgUF0D7VHT/d9kZ5PAKK23oinBKtGQzqPipZ+V4XZIgqFK6eNLo
         2JfJyDK5Aa6pS2cER+BCPznlBlsMBjFF4uc49hignbEPH7fK5uwLr4OzGkbqCX31O8Tm
         tq5MMgb1EFJFmmI9KwxYUlMC3o6ax0Zjwd/w1d9+cPXN7l5oiCiraS6mKO5FQIQ9DKaN
         WTzw==
X-Gm-Message-State: AOAM531jxZjlEsfiLjF4vqOffiuhOs1s57qz/UFK8dL2vCodLoqGdZvt
        aCaiALLC+zKAGgEPwYBFsBz34A5U7pts1mtRJDPSmw==
X-Google-Smtp-Source: ABdhPJwsOs66+UXvMtZ/P41ZXdOJx64Q6ugDoNZ7WVGczKBfExknstGF3U0wlEmtO6Rzb3z7Wv0hB75cIK9CqpLelOA=
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id
 r2-20020a170906c28200b006ce369d03d5mr29674650ejz.425.1648489225178; Mon, 28
 Mar 2022 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220326002013.483394-1-dlatypov@google.com> <20220326002013.483394-2-dlatypov@google.com>
 <CABVgOSm+o=t=8hgR=T676rHJjWp0p-VXeoZt28G0kVqURqCGMg@mail.gmail.com>
In-Reply-To: <CABVgOSm+o=t=8hgR=T676rHJjWp0p-VXeoZt28G0kVqURqCGMg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Mar 2022 12:40:14 -0500
Message-ID: <CAGS_qxrx-ZMUhTqkfOEGsA5O0cZW13mNmo4YV-2n7-wiUAeHkA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: split resource API impl from test.c into
 new resource.c
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 25, 2022 at 11:27 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Mar 26, 2022 at 8:20 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > We've split out the declarations from include/kunit/test.h into
> > resource.h.
> > This patch splits out the definitions as well for consistency.
> >
> > A side effect of this is git blame won't properly track history by
> > default, users need to run
> > $ git blame -L ,1 -C13 lib/kunit/resource.c
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Looks good and works fine here. I'm going to try to rebase most of the
> other resource system stuff I'm working on on top of these (which will
> likely end up moving a bunch of code _again_, but is probably the
> least terrible of all the available options).
>
> One nitpick (newline at end of file) below, otherwise this is good.

Huh, I had thought checkpatch --strict would catch this.
I guess not.

Fixing this and sending out a v3.

>
> Reviewed-by: David Gow <davidgow@google.com>
