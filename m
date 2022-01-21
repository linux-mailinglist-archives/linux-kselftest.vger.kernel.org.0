Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0949680C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jan 2022 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiAUXBa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 18:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiAUXBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 18:01:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2ACC06173B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 15:01:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so4042708pgc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYphm4+4iS9SAoeVlv+LsUbA1aLD+SqyiCj3OPowf64=;
        b=Dq+SOs17hUZ7jkqGt87h5phHUHLlR8aLu0VIPmtsQs5G0niRVjhQWWCzA0PT3PBHkC
         hIqrPVaFJclYGYgRvAcvcwfZMELL7djjEB+faolNIABAFzb6gFJViRRb6EWaCaNmu+gp
         PSxWWshifVNbDTtYwW8YftBra40Lv4/nybtMfeH3c3gtE/Drgcg3h52JmtZT0plAlNsc
         Y7ptxf0oLZ3SeL9OdszF7OGeKKbhd/QdQFttVVOr0+a8z8qULGt96ELG1Sp2SFw/BucS
         0dRbAkS2SYhEegpCpH9t63PN8rr+O9YM5lCHRYQ2oYVxJHPUc3pRC9CHjcwrpATNhmHD
         yu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYphm4+4iS9SAoeVlv+LsUbA1aLD+SqyiCj3OPowf64=;
        b=nPaXXYCmvVgk5fAgDvlq5vKLezE7eOz0seR8NGU4ld/cZnVayKJL/Uk4YV8NgtIZvi
         qeLAI7mUgtC/N4k5R8Ao6yBX5QK5Zcm6VBWl62BBt4LKuyoajeL7FUC/9UEhfm5375FR
         6rPm/FkUXdVyXsBkoIPl64v69UP7F5ePbVwGvuOqCSc1KPMIzQ1GCE++WJeIdBhMNEXg
         dDTkU4XeAM6gRiZ5/EAWsLGs2vYi6u3bohl6YxzECDnWENaSdUor8KypBa0vnbRDg7NW
         Z1T5dx3LYNvgnvfSIsfstTX4kWqsp9jsXjqoMzohfB7iHBcHrS4lBQCzYtO2aDsszfer
         5y3w==
X-Gm-Message-State: AOAM5325XlnhtwCUWTONC++dEqY5Qp4P/6o6R+fEvJdSKruQ3D8x7DIJ
        uj1qLZ3/xTPn0v4IDJD1KaPiVvGJbo0QhTPmJiz9RA==
X-Google-Smtp-Source: ABdhPJxaAdubDugrQEvvUGVtqIvv7Vu9kGzTezzTWcrI90O9URb2rxf/ZBKjDWIah6IuL4jcNuk30fOtzpDTtBP17Rw=
X-Received: by 2002:a63:1157:: with SMTP id 23mr4319202pgr.12.1642806089188;
 Fri, 21 Jan 2022 15:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com> <20220113165931.451305-5-dlatypov@google.com>
In-Reply-To: <20220113165931.451305-5-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jan 2022 18:01:18 -0500
Message-ID: <CAFd5g47Ae31FZBnF84Mv=WK9-7kYyODVDAfU03qQSP_O-qfmkA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] kunit: factor out kunit_base_assert_format() call
 into kunit_fail()
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 13, 2022 at 11:59 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We call this function first thing for all the assertion `format()`
> functions.
> This is the part that prints the file and line number and assertion type
> (EXPECTATION, ASSERTION).
>
> Having it as part of the format functions lets us have the flexibility
> to not print that information (or print it differently) for new
> assertion types, but I think this we don't need that.
>
> And in the future, we'd like to consider factoring that data (file,
> line#, type) out of the kunit_assert struct and into a `static`
> variable, as Linus suggested [1], so we'd need to extract it anyways.
>
> [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
