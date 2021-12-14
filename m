Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E49474D57
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLNVol (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 16:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbhLNVol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 16:44:41 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD6C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:44:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u80so18914969pfc.9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THxExHrYQURfkbRhwNTeSsNawMahB6ZzIhBW5VwbCz8=;
        b=Hi26RILjCjVTH05HqzLFaqMSw0rNSQ0+0z7rtvpA4aUVKJ2BEAH8tKz50eXKEuTo5p
         ojCqEyvrgh4r91X1ifkHklF/64ARzBfbP1D0iU9RMqgbQPUaM5pGDKecP6u+q2Z9J5od
         tqOXHgmlFVhHPdDuFh0urhabR1bkwZK6bE28jT3Ucgngdz/DXx9pt2cTzmK2SPm6ETOq
         H1uEPjlhDVtjfzdchS92K3aZvLSmlLRLnVH7RgsbqMKzhSt1LxvvwoSSiZKVLKcwG8N9
         I22d5AVgwcqjWcaYYHSqyV7wk+GsMGt3B3ZuzQGxbWv+C67ubV+fk6kIG5l766IX/DD2
         EqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THxExHrYQURfkbRhwNTeSsNawMahB6ZzIhBW5VwbCz8=;
        b=evvq/2nZsPOXj6qNZuqvcXNPEQYCOUrIf5nu0YIQV8wZJG+p1c3AxgySnI43j1W1xb
         mRqNIYt/F+3HbPuh+kN8ZKrbLguKWNSrxg7U1Eses6jsH0oN2pYLtaYKC/y1aIJDTRj2
         jbkkyt06siJJ6MVXCR/M95GOrPauKaTX/4jThn7z9auH0XmXO7MUzgy3f6vX5EBKu02N
         j0Swviqxuk3WrBGcjNxyts/jWXScYOYO9J1O7zep60vb5P4iX1iMgaalM7itcBqsDZuu
         NJxpRT7JV6Hp1QNt9cdzFj49Y48Rh1NweLpJUl1KPmZh8x5C8OepkDVz1Khf2UmY3tv8
         5cfQ==
X-Gm-Message-State: AOAM531M4qNvpHBwtTcLY2kB9vHcICqxHmEH+RO9nl+ptVypdgMFNB74
        t7eC33fOxQB+1uDmVOcHNuuu0xUgoqjx1GcrXSPnVA==
X-Google-Smtp-Source: ABdhPJwELAfVoYCnTMr+UNfbuTuFkjTNGyP6zlMgqmFaPs6bjaOxUR0h3dukSOn02ZhkE8SFVBYr/ukf+xBjU5N7KjQ=
X-Received: by 2002:aa7:96b7:0:b0:49f:df90:e4ae with SMTP id
 g23-20020aa796b7000000b0049fdf90e4aemr6263532pfk.24.1639518280544; Tue, 14
 Dec 2021 13:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20211214192612.134306-1-dlatypov@google.com> <20211214192612.134306-2-dlatypov@google.com>
In-Reply-To: <20211214192612.134306-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:44:29 -0500
Message-ID: <CAFd5g44qB7emcsV_QCtddUcFdoxVUpzoY_fgmRARfDwS3byNMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: tool: delete kunit_parser.TestResult type
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 2:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The `log` field is unused, and the `status` field is accessible via
> `test.status`.
>
> So it's simpler to just return the main `Test` object directly.
>
> And since we're no longer returning a namedtuple, which has no type
> annotations, this hopefully means typecheckers are better equipped to
> find any errors.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Looks good. Thanks for the rebase!
