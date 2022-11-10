Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39C62468B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiKJQE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 11:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKJQEZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 11:04:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD0192A2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 08:04:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f27so6215787eje.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFaoVWX3RPLpACkyedBV3PTT5TMZWxPD/ZAqJUgyn/4=;
        b=sU5cwCgeyQCJm0kHPrAsrs7Abf5eyH0+ZHOohF8AwyBR3OR5Q/Q/dIs3vmXOLPvREJ
         4UJycZDcZp2evi0vIe3xVNlCLbfVKshwTqBnn/XK/641byYkNJro75KmRnYnkdyCybQ8
         9TPHT0EqAXOxN/OoC0ONxvHuKAbLnRtWsPx6L0ro6hf78bh4kH8PKbfpa+yJOidv7UBN
         lidi3qlCaPmmgY08f7H+Ugp45YwfktAF8FJc5OheO4wuJN1B4s26RcfGk3rJHKJFbyHC
         m9KBpXPdr6UPU+exj5Of6FOmoTQ7OhAwNoDdY3gVy7r7rYuTKYdNvOkUER7i0aNIyLdN
         1/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFaoVWX3RPLpACkyedBV3PTT5TMZWxPD/ZAqJUgyn/4=;
        b=F1Yl6mtKfjR8+pzOTmvzIVGMGdA1NbI47ju/tIBJ5ad0rtbIGtZyM3cJBtXTPN37ox
         9KDiLX/LbRMoyueW+fRQlP+m08EDFptOW8ktAAOmg54pxMXkEUfrpluLPVjGobyec7XM
         GI8BSwDQRx5/FLP7AZSDEg8AMz4yMP4yJomEjVvIR/K7x/bSYNF5+7NEyrT2DwGgPIQO
         jBntyQkdF2wpnvCyWV2PQKf7jpJiovtT+fkd4p7UIW0VJbdJhYjk2MilMIt823K3FTkT
         TJWhqD+Ws5LKbVcOeT/R1Je2Y75htaWgTSab4hzmxKFv172yjslmI6xWZsvrr3K8khTI
         4ekQ==
X-Gm-Message-State: ACrzQf3EqzNVTkTBZQxB18TMFUMHdhbi5G2PwPD8NRnNV6wbQn9iGdhI
        quAT5/6gIZHnEXyjd1d/1ePYzKH7UL9+JTkYApYEPg==
X-Google-Smtp-Source: AMsMyM6LZ8JNPCa+UcFxwSnLJws0uMTCDx0ty9yOsqIGpd7DCq+IG97vb7GoLiUbIifxDJ2i0xjUniuW8Ul5KhiI+iI=
X-Received: by 2002:a17:906:3bc1:b0:78d:8cf3:6ae with SMTP id
 v1-20020a1709063bc100b0078d8cf306aemr3101932ejf.173.1668096263221; Thu, 10
 Nov 2022 08:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com> <20221109003618.3784591-2-dlatypov@google.com>
 <CAO2JNKUTiVM8YPgy0nz7W1GJtSVURhc1YkMgUWgs-rShNY0Zaw@mail.gmail.com>
In-Reply-To: <CAO2JNKUTiVM8YPgy0nz7W1GJtSVURhc1YkMgUWgs-rShNY0Zaw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 10 Nov 2022 08:04:12 -0800
Message-ID: <CAGS_qxqPUHWyJ4nNQRdm79sMwHwysHV=99WXzMsY=g_WzSjZaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: KUnit: reword description of assertions
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 9, 2022 at 9:07 PM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> On Wed, Nov 9, 2022 at 6:06 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > The existing wording implies that kunit_kmalloc_array() is "the method
> > under test". We're actually testing the sort() function in that example.
> > This is because the example was changed in commit 953574390634
> > ("Documentation: KUnit: Rework writing page to focus on writing tests"),
> > but the wording was not.
> >
> > Also add a `note` telling people they can use the KUNIT_ASSERT_EQ()
> > macros from any function. Some users might be coming from a framework
> > like gUnit where that'll compile but silently do the wrong thing.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thank you, Daniel. This looks fine to me except for a small typo in
> this line "to abort
> the test if we there's an allocation error". Also, I have reworded
> that paragraph a bit
> as below. Please feel free to ignore, if you do not agree:
>
> In this example, to test the ``sort()`` function, we must be able to
> allocate an array.
> If there is an allocation error, the test is terminated using the function
> ``KUNIT ASSERT NOT ERR OR NULL()``.

Thanks for catching that.

Hmm, I slightly prefer the current structure since I like having the
<thing> being described near the start of the sentence as opposed to
the very end.
I'll wait a bit before sending a v3 to give time for anyone else to
chime in, if they want.

Snipping the email to the block in question:

> > +In this example, we need to be able to allocate an array to test the ``sort()``
> > +function. So we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()`` to abort the test if
> > +we there's an allocation error.
