Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92405524FF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348990AbiELO22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354970AbiELO2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 10:28:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADABE733D
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 07:28:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ch13so10543853ejb.12
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmldS1PJBhy2mvJ6Oe3Qm7P58BiPUBNHjcuuTI17eok=;
        b=Y5eGsc40VfAs6yQRfpkVe1LerATM1xgOoWPWc9TvDkF2QDRPjeVHrrIyGvcwhWBm8A
         /ggxdexCsVpwmzt+v2JjRzwIHVcooWFFWuwhq05mNu+NZsuqk13CiHsOWwqOfs30xN7U
         QUYAeLTSp1rPizdLmFujbcOCBejuHDO+Luv5wBhG9SW0MMUiNUKQ0shfi5qsySyyzipP
         //CXhLAUqZx+QOi9epw9dQqDeoANLO71X2CWrknrCRjDBdsq68wi3JPoqbgCg0TzSldv
         gDpCF3fR+EslvoKz/gX+6tcjkhsnnjdAuPzBSEkghPnI89nVtpgbp/XMsHv0AV7FLE3J
         sCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmldS1PJBhy2mvJ6Oe3Qm7P58BiPUBNHjcuuTI17eok=;
        b=p1QuWdLAI+arLWbruFa26JLnkpQLdIxorJlUgnHiIdk4RlVgcJAsuMQFp2pH+rRszg
         cJHxFhJqCM7VdDdAT/t8Tm9JkNrmNDHUVC7WgzzFo4HPd/nSsTI0dEfliiQRWZXgR9he
         vCQWm0YG71ao6nb4YA1sn0Ni/ztU8hJ0B357FbLgKY9WH6dlM7G0MjNfAxRUX6cc6p4R
         dnsYCXFT6HNO0aEdkWiScRUmJTQMjlW95umnGl0WbZXE1iPKJM5B/e08qd2FlAil82iI
         nUCq2XDQlMpHWGKlqOSRMx7E0X6se6KGrRK/k2Jo9ZAF8NYmKAd/hdj/ZP5kOrjzBJW3
         iUQg==
X-Gm-Message-State: AOAM533b2hoWFYW6Uz+i50J64nS0SZX18mnDsbLVnGtrcD/zB3tkmQNM
        xMY13HgK1K5JhUah8mSub43xZun9YmJRJiLxcddp8j1h6Vckeg==
X-Google-Smtp-Source: ABdhPJwt9Mc/2cPGpYDcYXrtvB2oLWzuEZ8fomYcWJcpLCQZM47ZwEE3P5bnvCC9WfeBTgeuzBqu45cJvO/2qrb6xiU=
X-Received: by 2002:a17:907:72ce:b0:6f4:5a57:320c with SMTP id
 du14-20020a17090772ce00b006f45a57320cmr165344ejc.75.1652365700615; Thu, 12
 May 2022 07:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220420203020.1412886-1-dlatypov@google.com> <CAFd5g454KM9-45NEjUN3JWTZmpajHY9to=CW7Ecg6z_5xorU+w@mail.gmail.com>
In-Reply-To: <CAFd5g454KM9-45NEjUN3JWTZmpajHY9to=CW7Ecg6z_5xorU+w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 12 May 2022 07:28:09 -0700
Message-ID: <CAGS_qxro7Az_yJfjQYK0+0u2mu9E62xmRPD_8EKiq8ZNEd6qUg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: stop using a shell to run kernel under QEMU
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Wed, May 11, 2022 at 4:22 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
> > +                          extra_qemu_params=[])
> > diff --git a/tools/testing/kunit/qemu_configs/powerpc.py b/tools/testing/kunit/qemu_configs/powerpc.py
> > index 35e9de24f0db..6c901149726b 100644
> > --- a/tools/testing/kunit/qemu_configs/powerpc.py
> > +++ b/tools/testing/kunit/qemu_configs/powerpc.py
> > @@ -9,4 +9,4 @@ CONFIG_HVC_CONSOLE=y''',
> >                            qemu_arch='ppc64',
> >                            kernel_path='vmlinux',
> >                            kernel_command_line='console=ttyS0',
> > -                          extra_qemu_params=['-M pseries', '-cpu power8'])
> > +                          extra_qemu_params=['-M', ' pseries', '-cpu', 'power8'])
>
> This should be '-M', 'pseries', not '-M', ' pseries', (you left an
> extra space in.
>
> Note this actually breaks QEMU on my machine.

Thanks for catching this!

Ugh, I must have sent out a stale version of the .patch file.
My tree has the fix since I noticed it right as I was preparing to
send this out.

I have this locally:
-                          extra_qemu_params=['-M pseries', '-cpu power8'])
+                          extra_qemu_params=['-M', 'pseries', '-cpu',
'power8'])

Sent out as v2,
https://lore.kernel.org/linux-kselftest/20220512142555.3554396-1-dlatypov@google.com
