Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3F52BF09
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiERPjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbiERPjb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:39:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BBA88B6
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:39:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n13so2722194ejv.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZSb0554f2n8IO9cffG87Gnp2j/skjs0bnuEFWLNgIY=;
        b=WHvW2VBAWCKNirykCIyA6YptIU6wNsv9VCGN8wOYMmKaMjRzSeTzXVb1yHCgJS+KT7
         1iBphXfPCXXOwa29DMSIMcAMmGjG8XAxYg0yESaZ83dzWTSHThvUF7Awts9WtGe1UXkQ
         u+KC4dhFZQIfEZT5XqXaYWB0g9xywDTEvSxLMidkGpJW8RvyqiIbXdoIe8VuclRnRBe6
         Zyi83obCclcurYrIGkGydvwcoHGmgg4wOe9VeN/cl6Y9X7AiFpBJUPlA0XAX6OJytvOC
         hoGJ15W7z3GtBPR8QN/WDMIjmt9VCNCvTSRfHoHe2/LswP0YKhOYhCPyslKJ8vbjxb2x
         Gniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZSb0554f2n8IO9cffG87Gnp2j/skjs0bnuEFWLNgIY=;
        b=B2Fm/Y8X20ZT3NPTgbu1DoGv0f6wfkC3abNrOsbI5cedasAbVA4ndyxfk3xplppHNL
         zhMfRZ65gWwcHvOpVTOuKnKPPjVUyEkuvhNQQw1kzjSV/BpdbHkH+7DawUd9Qls5nunm
         pJL5bRHuDLs157cnLKDokhNbZs1odDGHOw+1bq+WezU/Rsyi6f1OFoh4NI+qK264HZXC
         a/IWQxfqTyOI/CKavBnkoqXfBA+dNjJQi0uajSwfqtQ5V01f4hDyj16p+leowYX/ZkTW
         2Oxi8weVlCxEIRXYVGdMfLXoqJbkhuh2ZAxy4gJFv97nI+RgpfDZx/jr+jvvAK9beWME
         ab9w==
X-Gm-Message-State: AOAM531rWaw/B0vjmOVZTPoQSSJTRy4oDOORb1C7xA1NDcvnG+l0Oj9h
        ZWr/YiCQjH0GIwkOkWlxIUL9MssccTuCaCKpJJYupw==
X-Google-Smtp-Source: ABdhPJzYpWouIziad7D8nl6r5roTQa4hx5zFTiFU4Z1KMkPe481kLhzDmKMeDJHNd638PlKuV4hsYIx8MUM4+EatzPk=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr139397ejc.631.1652888367981; Wed, 18
 May 2022 08:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
 <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com>
In-Reply-To: <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 08:39:16 -0700
Message-ID: <CAGS_qxr4vTSEtcGGFyoZibga2Q_Avp9pFD78GOA3W9o6F9RVRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Add x86_64-smp architecture for SMP testing
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 18, 2022 at 8:36 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 18 May 2022 at 17:31, Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Wed, May 18, 2022 at 12:32 AM 'David Gow' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > Add a new QEMU config for kunit_tool, x86_64-smp, which provides an
> > > 8-cpu SMP setup. No other kunit_tool configurations provide an SMP
> > > setup, so this is the best bet for testing things like KCSAN, which
> > > require a multicore/multi-cpu system.
> > >
> > > The choice of 8 CPUs is pretty arbitrary: it's enough to get tests like
> > > KCSAN to run with a nontrivial number of worker threads, while still
> > > working relatively quickly on older machines.
> > >
> >
> > Since it's arbitrary, I somewhat prefer the idea of leaving up
> > entirely to the caller
> > i.e.
> > $ kunit.py run --kconfig_add=CONFIG_SMP=y --qemu_args '-smp 8'
> >
> > We could add CONFIG_SMP=y to the default qemu_configs/*.py and do
> > $ kunit.py run --qemu_args '-smp 8'
> > but I'd prefer the first, even if it is more verbose.
> >
> > Marco, does this seem reasonable from your perspective?
>
> Either way works. But I wouldn't mind a sane default though, where
> that default can be overridden with custom number of CPUs.
>

Ack.
Let me clean up what I have for --qemu_args and send it out for discussion.

One downside I see to adding more qemu_configs is that --arch now
becomes more kunit-specific.
Before, a user could assume "oh, it's just what I pass in to make ARCH=...".
This new "--arch=x86_64-smp" violates that. I don't personally see it
being that confusing, but I still worry.
