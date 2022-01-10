Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9636248A288
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbiAJWOM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242582AbiAJWOL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:14:11 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07CC06173F
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:14:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h1so14169817pls.11
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cA2thSnMklXMw+C+WIsLavgyTwzV8Vdb/bSFnlNQwlM=;
        b=rQo7NJxkM8KSvltDFE8GiXYv60OUEUM2J1ohMj7zFv7ZuLy58cRM1J64tGLqvvptdN
         KtuNx53gLu0ZiTUP7um0L149waLwiWZABvP5fzn6qujudn24ZnfXze0Ww8agJR5jIIeV
         2Gg3+NApiDyVBx4M7iZTnjGiEXTGr2/U+c5/Iyox8OJHJM1dIFo32rrAsl0fgqDri2sz
         8Ee+z1dZjPoLIJD0Ml/3u559JlsoEB+eCDbZk4ypyCQ7Uwee/FVRRP5Zyda5GGiKxjPY
         MkJTBOcFU089N4qpuSCQ7vxZgXH8fxomG/TCH9XlwK5/jR3mkOoIC85Axn7J5JaXU4mC
         u3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cA2thSnMklXMw+C+WIsLavgyTwzV8Vdb/bSFnlNQwlM=;
        b=D6hhTSRECVTB63asJ3YA+H9ZG/7a9jFMsKlp56m4hfdPSSEtjVk49AuXA84y5nAPKJ
         O3iZgjh8p76oFwrXZG22BdcDz0FfCatxaCpfZ04GmSa7nKgA7UyulH0Hy0von9DJZ+6D
         PFstHwZUyxVuLW3CMoxN+KC1H6ujgRysFTvvhhR4YecWwArJi3ZWahkWZLuPHq3Gr16+
         4sww0xyQbC+t3NYnqz9JABeaSKbHlKRGnpATmPJajlLlICOrvbU5dmEtK6NknpHY2DpE
         /r/3xVGEcYZvDE10JRbESzIZG6Mx0ZczVHsbYcLq4xBGCL2VnT2Z0nLvNUx+8S0GxmFx
         pRhg==
X-Gm-Message-State: AOAM531vQ4y1Qps6uzC9pAtnG18Kkzdjivlg105Z7odcm6feoQYfnpwY
        5KTVLQP4xMEu+DuZ9zqtUjew1eGNrb/a7fy+ABdddDxvoQvwFTiA
X-Google-Smtp-Source: ABdhPJxGAPmnACRpzvskeA1k94inIqs7IJ349+gdQuK0t3OXSPON/CbiapdM0r/dMcIM/PeoesOnRffvBEG3J/49Dig=
X-Received: by 2002:a63:b942:: with SMTP id v2mr1472907pgo.407.1641852850858;
 Mon, 10 Jan 2022 14:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-2-dlatypov@google.com>
In-Reply-To: <20220108012304.1049587-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Jan 2022 17:13:59 -0500
Message-ID: <CAFd5g46RUc-v0GmjAEFggmgMxE7Ya_MCwMPO4YMEuFac49XLAw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add example test case showing off all the
 expect macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, these macros are only really documented near the bottom of
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.
>
> E.g. it's likely someone might just not realize that
> KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
> or similar.
>
> This can also serve as a basic smoketest that the KUnit assert machinery
> still works for all the macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I still don't like how much this bloats the example test; aside from
that, this looks good.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
