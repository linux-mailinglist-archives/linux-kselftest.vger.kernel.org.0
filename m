Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0535340CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiEYP4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiEYP4T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 11:56:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0E1117E;
        Wed, 25 May 2022 08:56:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q203so21861479iod.0;
        Wed, 25 May 2022 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWTqeXZC8D6YtjtGAZs5ZXY5lGkGmqycfWxou9ZqxyY=;
        b=F75F5kEB3L9Vo76l2tFnO18BnVfeBJI5QUakq32KdOL772s9ifaDvEeYFWF+X09ZRr
         ue4pe8ZL7S0ma6GTc10AK0GvjDjSJGYUGA8mMsppBiyewozGpHuhZnywSl0zAaEgWljU
         6UltHubliITzBSB+HWZ4zhfUlawjmKeXDDxJizblYd0X89yR4ABQ9h9TiOL/yaXy9RrI
         8TXAK86YihXvmWElKUTz4id4PrNJF5vPy9e3LPKwykJLXr47S2WlXyGgWsmNQO8tY4B5
         7Xt+6PVUqX879tG8OQGyPHKNqOAuC008OZGFBkizJNZMcCiQ1jUKSA7AU1j6ahRKiuXK
         M/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWTqeXZC8D6YtjtGAZs5ZXY5lGkGmqycfWxou9ZqxyY=;
        b=svkMg4uC9KwPXYQaQXC9Izni8wNR6g9Crd6cvcy9S0a5tXy1DOWETyvFz06qi+QDaz
         QlG4C1QcLepRCG50jqPWYTU1kCXkVVlGh3D/76JtoGKnIilsUNg0L7RHiTu5ei1Zk6wN
         TuB3/Oor06UYLZ3Sjwdiz6+18DBS4Vs5I4TVMQfG+aKlYOQ93z9gC/xWaJAIKsXguZ5E
         o265houizv702nr2W7q63iwfQCQG7p7Oy2niTQKGmhEEWtRdXhv8pV5CI7JESPTZSnQV
         +hMy2VhQHYCSh1FDIus7xVdA/ZAfhY15A7GOTfstCpp3vN75MmMcfVQVe2Z7Zj/0/L18
         WbVg==
X-Gm-Message-State: AOAM532iiQRZdXNA1KfWVtrHOI+wjJcGPgrWsQq+/nDqaiMl0VYannXg
        5m1gIne6xPhv97Fo+7B4GTPLQ6dDg7ouCgnX8R/ImzbFfCU=
X-Google-Smtp-Source: ABdhPJx0nsTy7x/z3D7P4+MW7NBNmIiAAUjKUz14406W14FWGR/5GPTAA+C3B/HrIhGELqRot1gVa6mHN3MZspD9C5s=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr14600570iow.172.1653494177294; Wed, 25
 May 2022 08:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com>
In-Reply-To: <20220525154442.1438081-1-dlatypov@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 25 May 2022 17:56:06 +0200
Message-ID: <CANiq72=hRbmHE865bwxQnCn2+kwB5nTaQgGAM0nijJnEL=3TJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] kunit: more assertion reworking
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Daniel,

On Wed, May 25, 2022 at 5:44 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Note: this does change the function signature of
> kunit_do_failed_assertion, so we'd need to update the rust wrapper in https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs
> But otherwise, I don't think this series changes anything on the
> rust-side.

Thanks for the heads up! I can take care of that.

Cheers,
Miguel
