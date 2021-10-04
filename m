Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78BC421989
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Oct 2021 23:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhJDWBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Oct 2021 18:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhJDWBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Oct 2021 18:01:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C8C061745
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Oct 2021 14:59:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a73so14946176pge.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Oct 2021 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oR9FHMJEaE13BkBpbWUGvIfigwsE0vr7a2ZHshK3wS8=;
        b=Uoo+1ct0QV2Ux4fbTZVkWV8nryL5oetajREzRreulNaUhqlC127gIysHH7lp/i5knd
         STWX/oNrsWN/HniF6cnQextBItaxCNwuRcpx/leW+XanjTZULZlAs1FdmzN6w1oGLTks
         XjkB8WL/XqvKW/Hu2cBqEIKC2JRFf+GWKDb+4fy1w94BjAyYTUi9F7X9dDKeM9RpNPHv
         8oDAUbv2tcX08n7EstQAwWAjsLm8S5P1VbkOYlcEmBBGcLBIooCZpHd/6G03TqPmJGX+
         8WY2gFAXuya754SoO6LK5JOY9kqfXXHGCMesZ1NCfhngY0kKQfSLeHz9HL+zFEfmIuGV
         ZJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oR9FHMJEaE13BkBpbWUGvIfigwsE0vr7a2ZHshK3wS8=;
        b=Jcaiul9gqw4Nju/gGuJqp+hNQ7etuCaMkdx4LdOUNpdQDc/tBRUYuY/L5bzh25eEal
         WG6NQo6FyLhSsQgO8y8ST2nyJRDCZjud5XyVSg3rm1tHQUPxDJAzW9nygy79pBmMHSYm
         azpIePBlFgAbfDQxMPTyDqdfG1BAo1fxccLzSs5Wr+Iso+YufOU595OqI37nQG+XHB44
         /Kg3YyPct9RuPxJ9C48y2lfojy6ngla1V151BCftss2nHfheDZRH2djuW2lNLgCtBkFU
         EQWI+pg9NkzANr/m59+fkz5lWfgtBHKsk2DaguCKDfmz7V89Rmw5BId/vVQJ7S8jDWBu
         w/FA==
X-Gm-Message-State: AOAM532qFUT0DRGHVSYxOrS4c1uuuqzv1u+8ww6fu8MKzcBsti9nQAxD
        Oj9gHI8e7ijKDUxWJGw2s3nJTX907coO8yIeshRLmg==
X-Google-Smtp-Source: ABdhPJx/IYfNIgTxZHkDt7sZz13R0PuKORGcEsg8RwW6O6NXtMs8sbqqQu2exzbVt+/skIEmvc8fcdL37FQ4z7F3MlQ=
X-Received: by 2002:a65:6658:: with SMTP id z24mr13092905pgv.266.1633384750068;
 Mon, 04 Oct 2021 14:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211002013635.2076371-1-dlatypov@google.com>
In-Reply-To: <20211002013635.2076371-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Oct 2021 14:58:59 -0700
Message-ID: <CAFd5g45Cnyt0nJ9d8KwAYO8jZu_5YdGkXT6XLcbJQWG1V4PP1Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix too small allocation when using suite-only kunit.filter_glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 1, 2021 at 6:36 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When a user filters by a suite and not a test, e.g.
> $ ./tools/testing/kunit/kunit.py run 'suite_name'
>
> it hits this code
>   const int len = strlen(filter_glob);
>   ...
>   parsed->suite_glob = kmalloc(len, GFP_KERNEL);
> which fails to allocate space for the terminating NULL.
>
> Somehow, it seems like we can't easily reproduce this under UML, so the
> existing `parse_filter_test()` didn't catch this.
>
> Fix this by allocating `len + 1` and switch to kzalloc() just to be a
> bit more defensive. We're only going to run this code once per kernel
> boot, and it should never be very long.
>
> Also update the unit tests to be a bit more cautious.
> This bug showed up as a NULL pointer dereference here:
> >  KUNIT_EXPECT_STREQ(test, (const char *)filtered.start[0][0]->name, "suite0");
> `filtered.start[0][0]` was NULL, and `name` is at offset 0 in the struct,
> so `...->name` was also NULL.
>
> Fixes: 3b29021ddd10 ("kunit: tool: allow filtering test cases via glob")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
