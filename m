Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298F575719
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 23:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiGNVlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 17:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbiGNVla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 17:41:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB39E2C10C
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 14:41:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c8a1e9e33so30327657b3.5
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrLJ6t8ylgvZSQuZlmobmLCnVlZPRzZJ+MdpYtHUOJI=;
        b=Xosv3ScUfv21//1t7/kb8Wskbr5g/+WLejRea8X/qIg4fcT6osyLtoFWd1q65TrZxz
         feesD9cIQ72VczWllJBOl77MkiNJmE+/vXXrwJbIARFcs7H4HWsl0JvmJvI5JmzTyN3U
         meKwZc6FIVNI5r3igtveG+zCZ1j1ojRwPdhq0ES07Nfv4SzSwQkHmjd8eu8KL6xOi/fI
         LRi3I2xpRJ1KhOGYQW0t3TrGtTfQ0unWzgEbvygAc1GceVzHXPM/aZ/jAK7d4Y44MtL6
         sW1lpoijWw5+VMCETqp+N8fw1Tk56Ozgw2WXd2wlnHobOp2GtLGRpppxH0EVDLF89dQE
         6bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrLJ6t8ylgvZSQuZlmobmLCnVlZPRzZJ+MdpYtHUOJI=;
        b=xLcL/DHjm3cwjCMpP07rj0ZTgfKoovXpGXypGkmU/uPdWVKMmX3Jwez+ZiktWdrxqQ
         brNMbY0RdcTXsbwUdJ2tw8shNVCzxz+/qJxkl0BZfuXbKlm1N2YLvUVj+nBw3sO2Qgav
         ys8J0S/wm3nUdMZgZQD/VpwWZarJXwmvz6+DRZHioyCHLljkKYmJEHOOZI8SmP+wUtGW
         lrrPC5of4lLM2a7AGPEC0yWcNjqE9aCNQKN1LbkAYRx4LW1h2u3TxrfEsKIHntnCzj+9
         sDx2FpVYhlZJJaNqaVuh1fIz0vx68J+hJS5WZX8oW10Jh1kIqISDl7MRJgLsd7INmnKk
         VgzA==
X-Gm-Message-State: AJIora9+cDHevjhdIVYrTban5dSwR0bXgPznamn2fq8RunM5vv2TdmsW
        FPQOdfgevAAXviIn2B4tp7cO1ffk2/VV3bb5ZBRHAw==
X-Google-Smtp-Source: AGRyM1vy8aVzUOhf/QXtZSH2ZHZaYwjbY3A577lPtx9AZ7Gv/zhEApvhp+lI7PzWDsJz53NTrxobz5jH80xVUG689vA=
X-Received: by 2002:a81:e17:0:b0:31c:a24c:9ee6 with SMTP id
 23-20020a810e17000000b0031ca24c9ee6mr12223353ywo.362.1657834888937; Thu, 14
 Jul 2022 14:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com> <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
In-Reply-To: <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Jul 2022 23:40:53 +0200
Message-ID: <CANpmjNP-YYB05skVuJkk9CRB=KVvS+5Yd+yTAzXC7MAkKAe4jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, 14 Jul 2022 at 22:23, Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, May 19, 2022 at 6:24 AM Marco Elver <elver@google.com> wrote:
> > I'd keep it simple for now, and remove both lines i.e. make non-strict
> > the default. It's easy to just run with --kconfig_add
> > CONFIG_KCSAN_STRICT=y, along with other variations. I know that
> > rcutoruture uses KCSAN_STRICT=y by default, so it's already getting
> > coverage there. ;-)
>
> David decided to drop the parent patch (the new QEMU config) now
> --qemu_args was merged into the kunit tree.
> Did we want a standalone v2 of this patch?
>
> Based on Marco's comments, we'd change:
> * drop CONFIG_KCSAN_STRICT=y per this comment [1]
> * drop CONFIG_KCSAN_WEAK_MEMORY per previous comments
> Then for --qemu_args changes:
> * add CONFIG_SMP=y explicitly to this file
> * update the comment to show to include --qemu_args="-smp 8"
>
> Does this sound right?

Yes, sounds good to me, and thanks for remembering this. I'd prefer a
close-to-default config.

> [1] Note: there's also patches in kunit now so you could do
> --kconfig_add=CONFIG_KCSAN_STRICT=n to explicitly disable it. This
> wasn't possible before. Does that change what we want for the default?

I'd just have KCSAN_STRICT=n by default, and if desired it can be
added per kconfig_add just the same way.

Thanks,
-- Marco
