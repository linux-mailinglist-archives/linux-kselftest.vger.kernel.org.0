Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A964D6818
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiCKR5i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiCKR5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 12:57:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107031C1ED3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 09:56:34 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x5so11795582edd.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6uqrZCjfvTCf0vt8DbhYIoNyBdrnrfGnyWV6ShUB2vU=;
        b=Np8v8rOaTexwZ9CowsixK98xvDVR/E2HeNEE9G8HenWAgLG2yemAxpgvVci5J5M9E/
         ww2D8EpkdwkrLH/I0vWWh9u7qyWvZ4VZaOSsPpHkxHjzl2SNgKnjo/HqG83j30EfsRFV
         PD3gWWPF3jC2guzLSofGcoOW71gHVlrFct9bgSM6bGnCNsPr1FSNzwngi/ElmXVsS9AG
         JQq1PLSXqweRV+CbnOgPPQllnqthJEE3BHdv4zqiCfrzRk7z2K5hyu6MUYHRMoNNXeqe
         XdUc3gi649tmmAnRsMMVQzCJvADluc2wizuISjw8kNhajMhuJQpWa9hsWmwVPWyAC0p0
         4m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6uqrZCjfvTCf0vt8DbhYIoNyBdrnrfGnyWV6ShUB2vU=;
        b=GQs4FXH3+9idtCrosqJXkqqlbKmzAcXAR3LlX3rxqW3O0VKR1NnAfwShyfj/+ypRcj
         MqzvYI3hXjmTHtXYerZjPOykCGSVE1ZlKBcuKvEqYSETTsXtWZgCh/aG/b1IpisMSytY
         QWHSCgzNtUkDjY9oc36hUia8mhRKE9IoZtHw8jvuCL5FJzQelQPylOnw5VTKgdV4OQ7m
         59uUH78mDepo4ah3/VoxoLxWwXWvgxjmvYHGhHB/TNlDEUqhp/b+5tOB3eJyWR0UGRvo
         im2P+RT7W2Apdj041wAlEy32RKf12QRmAI66I0F51fEGbNmOt8EIbl0CZGqm4Oq5aqMu
         Q4fw==
X-Gm-Message-State: AOAM530osVYTggIMGYeSHXHS6N80I9Rzdvr3Pn+7S/WOS+GkLUmW6UZh
        UNtPi5WQ6AMBFHGRj1GlS3BoLMFMR45S2FPTrHpwXw==
X-Google-Smtp-Source: ABdhPJwYY3OG4OM3NNI/L0bMert1EmCD8hdhav4/Wgf4KNE3snW+GGxbN3UYDTLUSIImyQRJ8LcMXpAFS/L8po/gON4=
X-Received: by 2002:a05:6402:3490:b0:416:8b97:b1f7 with SMTP id
 v16-20020a056402349000b004168b97b1f7mr9808627edc.36.1647021392341; Fri, 11
 Mar 2022 09:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20220310210210.2124637-1-brendanhiggins@google.com>
 <Yirz/hbo4K9zN9Ht@google.com> <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
In-Reply-To: <CAFmMkTFa9xVt314WEGd0nNx+ovc=aGB_yN1LorP7WrBga9quxw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 11 Mar 2022 11:56:20 -0600
Message-ID: <CAGS_qxqHhGEYS_4C-gTmPt_d3Fm==VOTEzQGggWh6MWppTHtZQ@mail.gmail.com>
Subject: Re: [RFC v1] kunit: add support for kunit_suites that reference init code
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 11, 2022 at 4:14 AM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
>
>
> El vie., 11 mar. 2022 4:02 a. m., David Gow <davidgow@google.com> escribi=
=C3=B3:
>>
>> On Thu, Mar 10, 2022 at 01:02:10PM -0800, Brendan Higgins wrote:
>> > Add support for a new kind of kunit_suite registration macro called
>> > kunit_test_init_suite(); this new registration macro allows the
>> > registration of kunit_suites that reference functions marked __init an=
d
>> > data marked __initdata.
>> >
>> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> > ---
>> >
>> > This patch is in response to a KUnit user issue[1] in which the user w=
as
>> > attempting to test some init functions; although this is a functional
>> > solution as long as KUnit tests only run during the init phase, we wil=
l
>> > need to do more work if we ever allow tests to run after the init phas=
e
>> > is over; it is for this reason that this patch adds a new registration
>> > macro rather than simply modifying the existing macros.
>> >
>> > [1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ
>> >
>> > ---
>>
>> I'm a little concerned that this is just removing the warnings, but do
>> agree that this is safe enough for the moment. At least the information
>> about which tests need __init is preserved by the use of a different
>> macro.
>>
>> I guess one day we'll need a second list of 'init' tests or something...
>
>
> Hi, could you please detail about this? Why a second list?
>

I assume this is referring to a future where we want to run tests
_after_ the init phase.
In that case, we'd need to be able to separately register tests that
run during and those that run after.
(Or we could have one list and just tag each suite as init/post-init.
If we ever had >2 "phases" where we run tests, this might be the more
scalable option)

Is it likely we'd have tests run after?
Not in the near future, I don't think. But it could be asked for.

For context, here's where built-in KUnit tests currently run:
https://elixir.bootlin.com/linux/v5.17-rc7/source/init/main.c#L1615
That'd probably become kunit_run_init_tests() and then we'd have
another kunit_run_post_init_tests() called later, or something.
