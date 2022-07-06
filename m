Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF9569238
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGFSzK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGFSzJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:55:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0814D1B
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:55:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so28610844eja.8
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+PQw8bgTsUWzLK2GyjEyXbBw4GPBQs2jHRw73nMgOg=;
        b=g18FQLbTBsNJjQwfyzkFrrOYV6TBFs7GbkjeeMRyNJjXBoYZvwu3B4Re8aLNhkahpW
         hcR+X5y/BYoQAL2WXhtq46FOiY3YG9EVE6CGxGWwYEP528MEY+IgAgrK7Yb5mqbYTLgJ
         BXbgNkGke93r0Uqpvmx8f6bBqk7gOEVp4fke2+8LQ0KiebBIkNrkf7kgTGJa635Nm5A9
         jGKxl0kTgh7vdm0Kq6Xlbt7pCZnn1NO1/bPCqS61niSmnKHxitacAKycaE09axAHEddu
         PPtg4s1FFaHvHkuqB4jDEKVupA22T1z8FPzNfOWsJ38uo7sE2hTYUSLdoi1PlRJQHkAV
         W7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+PQw8bgTsUWzLK2GyjEyXbBw4GPBQs2jHRw73nMgOg=;
        b=ZDMXHVbtEoKNS9CqvnFSh11j1e7zHPa9wrYjsctGMUyuyTTGXT/WGPb4xROuZAGSk1
         Vq7CCdibCxujXF8m2tKWznA7PW3jXU+HE9QuXxfBvTqiaKV1Xp/0IeuR+2F5yXgUStdm
         FBa3Rgo54Jbw2AKb/H/r9m+PPj2LKlXCFS2wf8p0l3HqXT1KS+BRzD7QjaFMoy1wL5GX
         SYaHetb0by4LZ5DT/qwRrJHXzqTivne5aubGP+hbhNehFqSo+s0fzLlcp3O7ZW2xCV9u
         pZhnLaYgUxBO2W2+GiPLs+gY+ZMiywuDIuNxLbBQUIHGv/aJjqLe8v136eyTFLTAPBal
         ueog==
X-Gm-Message-State: AJIora/lG85sckyR/47MuqFocwZN4rtX71pu3QwnzfYLgTojQcT0ReDy
        GUtRKqAmtzVjvIFCBgfEaFXh0cYd/f1GqQpxK7znkg==
X-Google-Smtp-Source: AGRyM1u90NXMAv1ydDCibLoqD+x9HtXFKYTRwcMsYvL2w9tVOBh1Fcw27ysjsuqLJ8Som+OskOKQKiPo8p5u1+0tWEg=
X-Received: by 2002:a17:906:ce2a:b0:723:1587:9021 with SMTP id
 sd10-20020a170906ce2a00b0072315879021mr41894495ejb.725.1657133707087; Wed, 06
 Jul 2022 11:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165446.1246262-1-dlatypov@google.com>
In-Reply-To: <20220516165446.1246262-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:54:55 -0400
Message-ID: <CAFd5g46Dmo_9aPF1h-vuAi8tbFuzm6nCOkX2bFBVd6V0foyiSA@mail.gmail.com>
Subject: Re: [PATCH] kunit: use kmemdup in kunit_filter_tests(), take suite as const
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, kernel test robot <lkp@intel.com>
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

On Mon, May 16, 2022 at 12:54 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> kmemdup() is easier than kmalloc() + memcpy(), per lkp bot.
>
> Also make the input `suite` as const since we're now always making
> copies after commit a127b154a8f2 ("kunit: tool: allow filtering test
> cases via glob").
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
