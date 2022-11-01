Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08032614C2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAOE7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAOE6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:04:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3B1740D
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:04:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so37312197ejr.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbwy8ITCoA5pOVbLQJbEcT2GDetN5uvf+3GbTAUDrCE=;
        b=miyy9c9glmyzfufEN5otSKVrH8Sh29yFZ1xv03E4kPsejTjmnT272cRWCp5OvjvP4x
         MphFAonTt/sh2ROc7RuhjUQRf+ujJcwu0Pl9aUGMLh8HqQWh8CVBUd/eNRFGvpTppP6F
         yCGeN+9xLm/BJ/yaOc7eAIpzWCLrMTgvgu1AHRYZXyZkc0RHbI4a2IVVsngKmgUF70Wa
         lHP4JpVBq3+VSpKO7sTGyWDwruOcC03qrcdq19rHA2booqkm1A7FqFkW4b/gIGb9MxXC
         18Oq0CpjitQmwHPVq1WJ35uwTaExIjMooXlfHdHjBZopoWXVM7V7fGG4e0V7Wl0dXLRb
         6DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbwy8ITCoA5pOVbLQJbEcT2GDetN5uvf+3GbTAUDrCE=;
        b=GkSQp/fJdsz0OYNQr3sZLuekdpHvYe7+KzZxYrUjpNZKCApIuEOZE8mU0xKeueNNoj
         8Oe6t0zPJ89fkWepu2SP5Zx8GykB38oXfoNiCmnxCi74Bc2Ch9od6puJUoPKrcmon8dO
         iFeRphAvDa6VOsZebLhVS6edAgVT65KExoozFFxNgMblBbmjfkLLBD/VaH4JGjsivm7W
         0NAOOMVqv0kavxKCP4eI5WYr7LMZFgqV8ventOVr+9BEhTkpv/w3qguSHPUBj8xmG5sB
         UyoA4jGGscfd+ETpJvq8nTQJOTEzBfp/MRlJLj7Kn7f9UUA7dkSTy4tXqz5SLOTHKoqp
         Uyyg==
X-Gm-Message-State: ACrzQf2+qLHDp0ly0w7DADvUrIVcTrMZu7G7Wjz+Hu5t5GvaAeTHyeeJ
        rwfTMb6vwVS/jDfEldIvNkyn3bSgQM3tVj8gRa6cl4eAMr81bg==
X-Google-Smtp-Source: AMsMyM7RW6jeJsoZd4AqGMeCd5kgJTnDjjqPbSsmg4NAhClfu6VJBlQwlILNHLvLzV1lKjtc1/O0DJXswzJDkG1MZ8k=
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e1 with SMTP id
 xc10-20020a170907074a00b0077e9455b4e1mr18364523ejb.462.1667311495135; Tue, 01
 Nov 2022 07:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-5-isabbasso@riseup.net>
 <Yyl3UXvLd3Jyr9uP@platvala-desk.ger.corp.intel.com> <20221101135425.3ee12c9c@maurocar-mobl2>
 <Y2EcEnAzkt1Qn341@platvala-desk.ger.corp.intel.com> <20221101145333.5960e6e7@maurocar-mobl2>
In-Reply-To: <20221101145333.5960e6e7@maurocar-mobl2>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 1 Nov 2022 07:04:43 -0700
Message-ID: <CAGS_qxr+xzr1Ea6Y+xr+hBrGqx6rFSh_Q3xHi=ND1aPoQd+jtA@mail.gmail.com>
Subject: Re: [igt-dev] [PATCH i-g-t v2 4/4] tests: DRM selftests: switch to KUnit
To:     Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
Cc:     Petri Latvala <petri.latvala@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Trevor Woerner <twoerner@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com, igt-dev@lists.freedesktop.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        KUnit Development <kunit-dev@googlegroups.com>
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

On Tue, Nov 1, 2022, 6:53 AM Mauro Carvalho Chehab
<mauro.chehab@linux.intel.com> wrote:
> > Ah, the selection is in kunit.ko itself. kunit.filter_glob, set from
> > kunit.py with
> >
> > positional arguments:
> >   filter_glob           Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test
> > \
>
> Gah, permissions are 0:
>
>         module_param_named(filter_glob, filter_glob_param, charp, 0);
>
> You can't even see what filters were set via sysfs:
>
>         $ ls /sys/module/kunit/parameters/
>         stats_enabled
>
> So, once set, there's no way to change it.
>
> I wonder why this isn't 0x644.
>
> It sounds that, if we want to control it at runtime, we'll need to
> build with kunit as module, and unload/reload it every time if/when
> we want to run IGT with a different filtering ruleset.

kunit.filter_glob only works on built-in tests, which is why you can
only set it once atm.
There is no currently no way for KUnit to run a subset of tests in modules.

The module init code is here:
https://elixir.bootlin.com/linux/v6.0/source/lib/kunit/test.c#L620
As you can see, that func it calls just initializes and runs all the
suites: https://elixir.bootlin.com/linux/v6.0/source/lib/kunit/test.c#L589

This can of course be changed, just needs some work on the KUnit-side.

Daniel
