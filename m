Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C5424549
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJFRxz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhJFRxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 13:53:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444FC061753
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 10:52:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 133so3189918pgb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQNWDrCnQF/tr5+mIHlRRgV+bRRUZairo48aO2ea71I=;
        b=q7BEViEUtZC0fsj/hRrovxearhhejH4hSRYb81gV41uhbWG/84EMYc1v83IcjCgjk4
         ZzMczjyMPorgO73J6tSZ+N+D0702liLAbC/KYH9HtEtSPZiy9MdzbGkNet2A8zJeHiUD
         bkkVZkr61jfcfMruEvyoDAUPpufcVUQbndDMZ/OS367H4cJsJyX9RHgX0rUoI8Oj/Hc7
         2cAdvWGa7G4BC7MRbNec5Pbj2mlJBnOG4EYpRzp/SNDDJcfVQfcA3ARqEnVFwFOE92V9
         AIftIfVSeE6tf3wkW/HTfy22wK7AtihevU7NvBuYutsgVA8n0sVlx+VUHvJ+E2V9Gk6/
         gFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQNWDrCnQF/tr5+mIHlRRgV+bRRUZairo48aO2ea71I=;
        b=q7du9+0S+8CJYjPdF8QNNPzG8ouse5QVZJ/JHVQh+Prr0DSt3e+LtzQCujnCJcZwQv
         dN9m7/g3mVhLTrrpdYNUzCCpZtEIuXHkUJ1Md17t4Sa2InsIDGe7r6o6YRNK2O/4kOn+
         9rUsdoD9TE7SNexAVd6ipNm8+TF5tRP8I0o0eyM1Yknc9rRwq/eoe9jTYPGvTL/IpuWL
         WTwMrJoIXKn9RzO2BXXA0DbCtEz+6Y3Ry3ueG1vDmlQioD461COQejt1wiojYdrwojx5
         IBTxE1kai/6AyLI0bnzIyEkxoYXbcKo8c4/FdlvGomChhY5kTn4SkUU6w/MzAT/zLhEU
         jP6Q==
X-Gm-Message-State: AOAM53181RP/9uOlG3gmLQmFKTgUxB9N6BvZvr7j+uSx7RMxu0Sipe2F
        uPjcEdpuhv0Z5Deu22LrppNsQ4xYIrDVghYQAxTg7A==
X-Google-Smtp-Source: ABdhPJy3f1QMT405K93zxHsRbpK5JAHC3pdOPfeSRR3MlWH6+VLWHudcNGLQwY/7sGYkqFUwzCyQWwWs2KDo8g7mL/A=
X-Received: by 2002:aa7:824b:0:b0:44c:22ad:2763 with SMTP id
 e11-20020aa7824b000000b0044c22ad2763mr27694293pfn.63.1633542722198; Wed, 06
 Oct 2021 10:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211005204632.3132652-1-dlatypov@google.com>
In-Reply-To: <20211005204632.3132652-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 10:51:51 -0700
Message-ID: <CAFd5g44rj627arBcrUsPfTCNzK8+LaV_kqYjvdP8b77=iGVvug@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix kernel-doc warnings due to mismatched arg names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 5, 2021 at 1:46 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 7122debb4367 ("kunit: introduce
> kunit_kmalloc_array/kunit_kcalloc() helpers") added new functions but
> called last arg `flags`, unlike the existing code that used `gfp`.
> This only is an issue in test.h, test.c still used `gfp`.
>
> But the documentation was copy-pasted with the old names, leading to
> kernel-doc warnings.
>
> Do s/flags/gfp to make the names consistent and fix the warnings.
>
> Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
