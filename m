Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3746C767
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbhLGW33 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 17:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbhLGW33 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 17:29:29 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5CC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:25:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 133so312753pgc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuH82+ew3+yPVR9xOzW+SMm8iqzMQQtfOT6/YUqMGeA=;
        b=kkpZwYns3974F+bLnTR6ILVo1es+v+akrRSHuTsgisePDZuGX0G25M3ZEnkse5rxOG
         fYYVxU/f5i8ttBIUNAoAvmLw0r/HTbJBtWlbgd9mHd9J9p/5VXceWvFIPBSJmUDw9ct3
         wp1LngdHK/7VDlxBSrGKeFSCsjQTWrbVH+1hjos4obJO1iTPMs2JaCkbmrDbnxwUm7Kc
         ftlJFoObGB4pDq/FYPJSczsoF04fL04JzknxdRAn0YA4tCTEVMzqWYmzrv1iqjd/+h1n
         W1dagniRX5PD1vMdej8TWUYyaA0ECMuKk/znTEXtBBw2UmRf7FcZfmjk8KIWOxQ1z6is
         rMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuH82+ew3+yPVR9xOzW+SMm8iqzMQQtfOT6/YUqMGeA=;
        b=uI+M3UPC+oZNp0A2yZGeeQm1d4auQakRPp6As2H6o0eRw9lxzlos37hF27FWyNZLte
         J9dDjhueZrYmIYelfQT8jCAKA7DIz9OFe7zVImWxuP4/JUfsz4Jz/2QbhwJESygg4RHO
         rgrOXq3Y23EeiW/1Bsw8EUBVa9howa6WzwEhZOtjJbqn9W8a3drqVixpmbX73iPMJPxb
         +icNjJSvValrh58CDMZBhpWS+iPHR7AWBGrfF7FSpvrfitfbTPmC9AU0C+PFD0MAOAqN
         G9FtK9IdQEXfQ2surOo+gx4AC+wkUeQ4S408IhPgTLB8e1xHcrbun0ZZCcA0iJ1H9GNl
         N7WA==
X-Gm-Message-State: AOAM531bqB3obwqv7mVhvuIsP0AMSLOfqqhpiVOyk0VmCzxw0aEgFY5n
        EL9zjuiiY3/69kRB8rv80o4YoKaT+nDN+kKlpty6Bw0enc9jiw==
X-Google-Smtp-Source: ABdhPJym4dUs9mLJvXhYatZ40eFah3Dfu8FvKlJ1ZajQ32OBu5WswZmU4UkYRkhYQrPZNoc+QtVpUSbrCJnCnm37rK8=
X-Received: by 2002:a63:3fcb:: with SMTP id m194mr17504499pga.407.1638915958124;
 Tue, 07 Dec 2021 14:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com>
In-Reply-To: <20211106013058.2621799-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:25:46 -0500
Message-ID: <CAFd5g47Bm6v=HWZuHTHokAHFL98JLE-949BQbcf47ckGfa1rSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: move Kconfig read_from_file/parse_from_string
 to package-level
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 5, 2021 at 9:31 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> read_from_file() clears its `self` Kconfig object and parses a config
> file.
>
> It is a way to construct Kconfig objects more so than an operation on
> Kconfig objects. This is reflected in the fact its only ever used as:
>   kconfig = kunit_config.Kconfig()
>   kconfig.read_from_file(path)
>
> So clean this up and simplify callers by replacing it with
>   kconfig = kunit_config.parse_file(path)
>
> Do the same thing for the related parse_from_string() function as well.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
