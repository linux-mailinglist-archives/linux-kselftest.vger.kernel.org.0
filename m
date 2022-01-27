Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC049D951
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 04:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiA0Dhq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 22:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiA0Dhq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 22:37:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F39C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:37:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso5007997wmj.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7Yfdd/9hFQUnA6nIuJDN3HjbLQ4BcpXzeTNQx2T/6Q=;
        b=aLgMx6151pR0phggn9dWcxEp7UBNHx7Kzc8wyBpjngCPGx3sGAbKeZrAso7mr/fHYL
         2STYT2whequsx1lFvX8aBDoW/hOtDEfr8jiskmdPHHp5/U+0gY+gAqY8K57R7wnuNhN+
         IGLQFn+Mt8wwf2YzLKszKuEwUONfAQStjs0QqlMqdRjABIuuPpPPAw8mnihgpfn5Ys2r
         NcA44W00Sma7A4uBzjxmMkME3YgoJk8OsRTLX02cxvblOayMn57oLg8/sdYUZtOTQzRJ
         qRczPkFNsBWQCr5ArJre4DffDFMcQd4ozenginpevzLma3dBm5hmj4p4y+KfpTI6PL4A
         Ma7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7Yfdd/9hFQUnA6nIuJDN3HjbLQ4BcpXzeTNQx2T/6Q=;
        b=YWX58HkZbEAesiqeUwYF9cieOkFQ4KjWh0v2DJXSoERXdPbRGOYIDC5bdN5e97UG2B
         90uM+PtQMrGwJUf+h2SCZPQkhNA0aCfhYU1rn9c8ckXdgGhKvwarj1d6qu64KIKwicBP
         yy54ibS6gSYGvfPQyA5zQK3q0SYglIutKqnBTP55Kv/HTEaz58KK7wVLHLqAzwb/GtPb
         wEC/tIylDRZ+BpFd93WqGzREX2XZ3/TXmmenNB8eLQ/XFLWpHcIkGq/W9qctSwwrMyYc
         k3MtSFsx9ureTeI/tF0AahL/s+xXoI8045uAYSVmCGuKQeK/M9tGyCbth50ad4KEK6ZA
         GJdg==
X-Gm-Message-State: AOAM530Colj2eHlQYbCN3rY1i+vk/LIvnydXhma6vPS0HO9uH828xyTN
        di3149dJCVyl9HDseFMppASoW70AOFZz3Lb4q3oNdQ==
X-Google-Smtp-Source: ABdhPJwXB4i9vcE4LRUXxVoJOO4ePL09+K3lOhD6R1uAi7PTItCBhsdXO8mvFEMZp6FqSwwAzHu/co8HWbMFWMwklsQ=
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr1474557wmq.8.1643254664899;
 Wed, 26 Jan 2022 19:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-3-dlatypov@google.com>
 <CABVgOSmESbi9Cm6GqGn+G1vD8qmX8wwPwtCxzUOZp-qRpBKQYA@mail.gmail.com>
In-Reply-To: <CABVgOSmESbi9Cm6GqGn+G1vD8qmX8wwPwtCxzUOZp-qRpBKQYA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 11:37:33 +0800
Message-ID: <CABVgOSk1fz+KaGyKZ_4kQdAZgUpyXUnqdx0364aHEc3JemhGyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: consolidate KUNIT_INIT_BINARY_ASSERT_STRUCT macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 11:36 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, Jan 26, 2022 at 5:00 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > We currently have 2 other versions of KUNIT_INIT_BINARY_ASSERT_STRUCT.
> > The only differences are that
> > * the format funcition they pass is different
> Minor nit: s/funcition/function/
> > * the types of left_val/right_val should be different (integral,
> > pointer, string).
> >
> > The latter doesn't actually matter since these macros are just plumbing
> > them along to KUNIT_ASSERTION where they will get type checked.
> >
> > So combine them all into a single KUNIT_INIT_BINARY_ASSERT_STRUCT that
> > now also takes the format function as a parameter.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Makes sense to me.
>
> One minor spelling nit: probably not worth a whole new version over,
> but if v2 ever happens, worth fixing at the same time...
>

Oops, forgot to add the Reviewed-by!

Reviewed-by: David Gow <davidgow@google.com>

> -- David
>
