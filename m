Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F452C09F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiERRFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiERRFO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 13:05:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F120B555
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:05:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd25so3850860edb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 May 2022 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGAntEp7VsrLOr9oJK5iuS5kORmPqq6P0c1ahFe/D8o=;
        b=NOHuR58P7UEw77Nstwjd1anEL7123NzoKqqXJhWJ93UpmIdu/IBnFdHCznT249ezIm
         UUxZ4ViAQmjrDqR2b4SYAHEgwjjSa+JDxBTVFW7lKT3pSLZ8t4BwcEWh2N+JT2hSIgkj
         wYT/SbAq37iUlVSvKsOvhCjSZB0Tgqd7D0pmMsBSnDy1wtwdFeracZFXkRpumUoq9gOL
         Qlz5TUTRFVm5K+y7l2OTYvxl4azvGVq4ot2pU7BqimzIcf3it6UbBmgU3LgbFbnl1G1z
         +4oEX/zUYVIy2bB3n7fJrHw2AtoLoSr+jMu2uEIZA1QxQBgrjIsgoA6Yy8w/s9O2kEjL
         WLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGAntEp7VsrLOr9oJK5iuS5kORmPqq6P0c1ahFe/D8o=;
        b=Apu4voSX672oR/VIlFQ4w1i/tTP1ugHJK07RWJJJUdq169zoWy23ukIrCEgZmIV6BJ
         lNZ+dwmHjgf/6l4br3IaE+I2KbmihJ1DTjTHGGChNXs2Kkq0p3oSuTKx0v1F6AUudug6
         uHwsEqqtar6XRMLtRwUyxAx+3NYOGGX1v7+8jcFa+v8qtODA9kW72bNfRPRrXOz3Hj8r
         fcJpExIof7WodrBGpHFqvWtOapy9rcykKeC1+deoCZHbNQdWGbfXO0wAhl422/tHA2D5
         MbOJXRwFnV29bqGafSGK7w7+ofDo5jA25maq7moyY6O1AcWse7V0ns8KvX/R101HG17O
         WT1w==
X-Gm-Message-State: AOAM531fACwonxXDoLZ9ENBD767TCESfXT9ZMJwhYQFO+eBO7XPQgF/J
        f/OjshIUwnGM22tQCyH9odOJ8jpkVNbPjmxmdQ9ixg==
X-Google-Smtp-Source: ABdhPJyRynvfcdjaYd0uH0UVh6xTRNO4SHqkECs5n73xe/7fWJ5XV4uKzmGvFQGUoT7N6Iu/8CjQikRk5Xc+3bT14Ac=
X-Received: by 2002:a05:6402:3787:b0:42a:ea83:ad25 with SMTP id
 et7-20020a056402378700b0042aea83ad25mr754096edb.233.1652893511663; Wed, 18
 May 2022 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <CAGS_qxrOUYC5iycS436Rb-gEoEnYDa2OJLkQhEVXcDN0BEJ4YA@mail.gmail.com>
 <CANpmjNPSm8eZX7nAJyMts-4XdYB2ChXK17HApUpoHN-SOo7fRA@mail.gmail.com> <CAGS_qxr4vTSEtcGGFyoZibga2Q_Avp9pFD78GOA3W9o6F9RVRQ@mail.gmail.com>
In-Reply-To: <CAGS_qxr4vTSEtcGGFyoZibga2Q_Avp9pFD78GOA3W9o6F9RVRQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 18 May 2022 10:05:00 -0700
Message-ID: <CAGS_qxqb+pKeKBVxzFFTss5QLSWo6nVAajwQTMB2fWbMnMHvgg@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 8:39 AM Daniel Latypov <dlatypov@google.com> wrote:
> > Either way works. But I wouldn't mind a sane default though, where
> > that default can be overridden with custom number of CPUs.
> >
>
> Ack.
> Let me clean up what I have for --qemu_args and send it out for discussion.

Sent out as https://lore.kernel.org/linux-kselftest/20220518170124.2849497-1-dlatypov@google.com
