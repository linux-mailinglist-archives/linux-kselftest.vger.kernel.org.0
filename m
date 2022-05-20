Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85E52F5B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiETWf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 18:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiETWf1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 18:35:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA316F925
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:35:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c12so12393757eds.10
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hc2DTzkdvmY5/H2+h1fYLqdWLOpbPYQU4WUrtguKfK8=;
        b=YcQ0Hu0u3oUtOd9K6qAjIrCzfi7ako/V39ndwIxJG58KfcKA6mHEbr02iQKhS+icJ7
         AWTF2PJV9YsGtctpG00VQ2dF159kSsPOUXUfYAgkjXoXbsftFK+R0lncDH8FpSfgueC+
         7RzlTU+Diyl/K6STYoJjnz/brTfG73icT2DNlhlm+lmO827D6BhSScD//biiZGRO05QL
         q3RnvLZwT6mcTsisMw8lRJ7Epy1rFcyBbvwAnyHXaGG2Yn/MikvesKpcqYFXNKUh/3QK
         RcGUiDblIarbhgeIP7M/68tM41h18GHneABwFEDjCDltu8G3/5wCeHdcVOkSrsvu+uB6
         +cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hc2DTzkdvmY5/H2+h1fYLqdWLOpbPYQU4WUrtguKfK8=;
        b=p53wBR39VrvBydo8TJClUPmsqFiTE3ZSoPF8yqKa6YmbzjM8orJt+8OJ5Br3YUw74F
         q7nJ6iBDm4W+uRXgX60bYFFemwFmceUNBRZsPYDYDcNbW0qrkWB/ANfkiEV1Pu3KUpr0
         3BPROB17hse8NYFWgb2IIDYESdj/84qjkjeXNoK+7Ttvbxf9NlgcT9Njk0zX416gayPd
         l9F95N9d45XciEwRIF6/cNe0lSOcpJzvjOKfJhR5wFCJVhDDA6AKSaotOC+1A7Co/eVe
         ebsQ6D5sQyjTyLqKwqHqCpUviIz00sBP8Zu6v9u7rcqK0IzG96Kt+FTXJ3JsLazNmN2O
         P/qg==
X-Gm-Message-State: AOAM532gVmD6HVJFwpySfyEa4ffXF9RDfpHFwq5ZmNihVg0mc+y0EevS
        lElZmVyO8dzrs9LmUQr3p2CR0kd+2P5mpVfh5iSV9w==
X-Google-Smtp-Source: ABdhPJz7+9WUFMLkPO5qjQRZ4cQTpghpM2BlJvmMqQmZrSUEytXCmKRqFwOg9PAc+vapCevWMtNPVvcpFn9X9SbxdiM=
X-Received: by 2002:a05:6402:3047:b0:42a:fbe9:4509 with SMTP id
 bs7-20020a056402304700b0042afbe94509mr11941788edb.159.1653086125167; Fri, 20
 May 2022 15:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com> <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
 <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com> <CAGS_qxrvR+xxfmzz92rYYW=VzG1kyycn1EuaJxdNSMd_L5afFQ@mail.gmail.com>
In-Reply-To: <CAGS_qxrvR+xxfmzz92rYYW=VzG1kyycn1EuaJxdNSMd_L5afFQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 20 May 2022 15:35:13 -0700
Message-ID: <CAGS_qxpF338dvbB+6QW1n8_agddeS10+nkTQNmT+0UcvoE1gBw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: refactor internal kconfig handling, allow overriding
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

On Fri, May 20, 2022 at 3:13 PM Daniel Latypov <dlatypov@google.com> wrote:
> Talking offline with David, we've come up with a small example.
>
> If we add this kconfig somewhere
> +config X
> +       bool "X"
> +       default y
> +
> +config Y
> +       bool "Y"
> +       default y
> +       depends on X
> +
>
> Then running this will fail
> $ ./tools/testing/kunit/kunit.py config --kunitconfig xy_kunitconfig
> --kconfig_add=CONFIG_X=n --kconfig_add=CONFIG_Y=n
>
> It will fail with this
> This is probably due to unsatisfied dependencies.
> Missing: # CONFIG_Y is not set
>
> The problem is that kunit.py is looking for an explicit line saying
> CONFIG_Y is not set.
> But CONFIG_Y's dependencies are not met, so Kconfig doesn't write it out.
>
> I assume we can treat the absence of it in the file as proof that it's not set.
> I.e. the bug lies in the is_subset() logic we have in kunit.py?

Ah no, this is just me trying to be clever and avoid a call to this logic.
I tried to use set_diff() and check if that's empty as an alternative.
But the set_diff() logic is not aware of how to treat the absence of
options properly.

I'll send a v2 w/ a fix.
