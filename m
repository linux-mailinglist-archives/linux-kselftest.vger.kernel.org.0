Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2855F1E7A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 19:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJARsr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJARsq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 13:48:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D5E31DDF
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Oct 2022 10:48:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 29so9695429edv.7
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Oct 2022 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c7ClxOVX9/fTWh7RF9ZwpQ6vCvgaYcvgX8ui5h36zLw=;
        b=mk74V/+RqSnFY+c8okVl5tWdA9y2JDjEu+ZChC4UJ8UPHDQWf45g+AjBU59kzZEszF
         8dQwl1pAvBY8rm+9GKnL5hP4KuF8Ffn0pyr/Sc7IDwnbWtY/wAdMI/MpVgrOU+FetnIz
         WmXLDxsCyhkqcyfmYZmOtiRHggmsRK18Cv3J3ZMCuEcvmpHQmp8sr5EVBi8x0XOq2S/p
         hDccOEEbesbAbwazZaK7z21XS5+H2JmV6h8/qBdY6sLAV9rLL1hgKNf76kZ2iGkgunyd
         p2QgSLOqew5T5xgRBs+r54wDDMFI6dhWkxE/KeCr2NHYMVxlSMUk71X48HpiK8sihnDF
         Xsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c7ClxOVX9/fTWh7RF9ZwpQ6vCvgaYcvgX8ui5h36zLw=;
        b=cXEYhc0u5iDMVlG8DYz3BCOj1aEIojeF1+6abwTxsgvNP6a4lfyDmmi3BMsBA+S7+T
         eIzqCtWIprpZmm/EjGiKUw1G8y8NsILHguslCQjubby3DmxMeTUSEcPag/u2QgeR6Joi
         jyXeecNikGtAqLa2cCxKK8eDmIzX9Dyem4iMOnmYdeNZ2VQc+mI/lJdqROPmNJU5iEKw
         ikWGBhUzpZmBotaAug35uDgR+v88B3LjwjN0/kkfWBpM3xUg5VLSy6NhEIfQO04JGCN6
         rcMavFyib5rdCa3y/H31oL5VEQHrZcvujHFhF/Y47wr4n9dxTWz9dhPP7eAgeshZiWzn
         dHMQ==
X-Gm-Message-State: ACrzQf0vhBWEsoYRf4dqcHHK/kBGy1zqdKMpAc/lxtckQUlkhpczg4BP
        IHwvmt2FTPIh6kXgPc7FD1QgNYXEVpnRCzwqo6tkzA==
X-Google-Smtp-Source: AMsMyM7HypsGCtGwX3FxtKtIGc7+9dBKBWCGfn6+4lUOJYG/BvyZ0yhYOcX4mu3QAc5qVPq0R+H765Ju0VHIOz8nwt0=
X-Received: by 2002:aa7:d39a:0:b0:458:a612:f805 with SMTP id
 x26-20020aa7d39a000000b00458a612f805mr4014103edq.49.1664646524412; Sat, 01
 Oct 2022 10:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-4-dlatypov@google.com>
 <CANiq72=H-HkE6FQrPFC9s83VW9sPPQbiZ7+iCqjrsvUkkW0MVw@mail.gmail.com>
In-Reply-To: <CANiq72=H-HkE6FQrPFC9s83VW9sPPQbiZ7+iCqjrsvUkkW0MVw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 1 Oct 2022 10:48:33 -0700
Message-ID: <CAGS_qxrJJTdJwXej0mEyyX2vpP__D-UBB8=zvxccMeROy=B3tw@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT macros
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Sat, Oct 1, 2022 at 3:12 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 1, 2022 at 2:26 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > But we can work around this with the following generic macro
> >   #define KUNIT_INIT_ASSERT(initializers...) { initializers }
>
> Is it intended to be internal, right? Should be prefixed by `_` then?

Yeah, 100% internal.

We don't have such a convention in KUnit yet, see the discussion in
https://lore.kernel.org/linux-kselftest/CABVgOSmcheQvBRKqc-0ftmbthx=EReoQ-910QV0QMNuxLWjTUQ@mail.gmail.com/T/#u
I'd be personally fine with _s, but this patch just tried to keep
things consistent with what was there before.

Daniel
