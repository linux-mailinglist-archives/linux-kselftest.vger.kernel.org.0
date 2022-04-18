Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23C6505E2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Apr 2022 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiDRS5H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Apr 2022 14:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbiDRS5G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Apr 2022 14:57:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568882E9D2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 11:54:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so28479599ejb.6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QGbAt7FqzrbpTv/n51B3Z6/0bd+lcDV2V2eKLni8zo=;
        b=IuE4ssFXtlEcJ+zZqWTmEb+4bHaWkQLmNM931wGQ6o83URXG989L2IEDKlKOX4YsWu
         ZyMA1cpRPICnTD4ePi8p/FbiyQxIrCL+0SgqYBy6y8soFjFDz7JsHtl7aKxxjEgoYnf9
         o01uJGUz38yya8+NlKuBnZFoetdy8tMdB+5Y+L2W4DOfyA9AXJ1gMh18PdFWxJ6cvq44
         XGMcE6cZohSVdJlkYQC7i0Q2/l4XaX2lYCqp5IBtNhfsVR0G4ZhQ1h3LpP6PF/gjhEYv
         kepBdjW5vFoy279VO5k0g1dWBGyoc8zm7UAPxomXZMyLUgiAJ9gf5bDtvTCbkgLzsOGe
         RwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QGbAt7FqzrbpTv/n51B3Z6/0bd+lcDV2V2eKLni8zo=;
        b=Z0oKJ6VP6BmI+wWqyiiBtvT02E7wvRbYpxHTUCL+5UTDkpH/7bmtziDKZXkURkFxkK
         c1D4BNFl9Llo+enMnOb177SxGl79g+h5H1FK01rVgCZLb11DzUZP63M1y8e6Li4kdPNQ
         NkgFQz1ldqYRwq8Yj5NmGNlll1mW4RnRbsd5AZS396qngAIbjXXz4cYgL+2cNcjFWeW8
         FMdsZ9GoKXXHrO2KZOKWvaboegXApHdcy8KO+bgUYvNh/3F68XblSZ4mYlnXur0awuNx
         abR08UoKi25diK4wRO11MBhaq4imtnO3jhQm93N+vcuoW42E2VGKUSIudiyNefdPLjTa
         6cZg==
X-Gm-Message-State: AOAM533Zv+CKaFe0tuNMaYieitL4xJ7ldVeoQwxpofACn2wKa4zxqtsQ
        7JzWqTGhrj+SQj6WP43zBoNuOhyY2NKFn1+4M/jrJjEQDxM=
X-Google-Smtp-Source: ABdhPJxwYXie8oTEuzmUOLcCEWK9RrfrzY4Rc5T0c9iK67wNPu/3BoRmK50VPIoiHQ5T6Tz8/wzP6Vvy9+umKpTzUUg=
X-Received: by 2002:a17:907:6d90:b0:6ec:9e1:865 with SMTP id
 sb16-20020a1709076d9000b006ec09e10865mr9924132ejc.369.1650308062748; Mon, 18
 Apr 2022 11:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com> <06087446-c053-7099-b8f1-40a467781186@redhat.com>
In-Reply-To: <06087446-c053-7099-b8f1-40a467781186@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 18 Apr 2022 13:54:11 -0500
Message-ID: <CAGS_qxqFqM=4w1xEB_bmznMAh3r19Ou9TjYR8gGetG1ypo7W5A@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
To:     Nico Pache <npache@redhat.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Mon, Apr 18, 2022 at 1:43 PM Nico Pache <npache@redhat.com> wrote:
>

<snip>

> I have tried posting something similar in the past!
> https://lore.kernel.org/lkml/f427ed5cbc08da83086c504fbb3ad1bab50340cd.1618388989.git.npache@redhat.com/

Aha, so that's why I vaguely thought someone had already done this.

>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Acked-by: Nico Pache <npache@redhat.com>

Thanks!
