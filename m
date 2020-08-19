Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8719C24A828
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHSVGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHSVGv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 17:06:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2596C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:06:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q93so292284pjq.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Aug 2020 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1fpazQzH5RzZYR8qQqnmyk9zH8WRFTB4V0IGSi9KdM=;
        b=n3gXik2Qgwut2dnhopHSM0ZTpUHIi6gVTF4XJRmDIngPNixlUNtHw0BoOxGRErlh+A
         NEUpm5nS07FYpoIukKItm8njOq+7W7HIDGDyeNyMu9V6y77m0BVMDgF60gWCiJ/yhILr
         rNBZhONTRkFZP0avtwKAX2L2fx7u95liCYCVGJy1fUyFFO6kG470mjAaO9JnjSrhlg4E
         LOqr5LEaNL9zO47CAFdHNfn0m79qaXwsCP0VcKQpsHDPRQN34/mBhVJpm+X+wCPQM7fE
         H/4G3VkM0prcDUokq+cvOa2llDTOpuWhWTPHey8eqP0ZulPhWDigdy6rWy4IJigjzjUo
         OeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1fpazQzH5RzZYR8qQqnmyk9zH8WRFTB4V0IGSi9KdM=;
        b=DtJDQ6QEJUbvwa3t9/ZUrGU7UHDGEQRm0atvVYOCZCDoqUNftQ4JeIrI48W95Z1zHG
         Vj5w+Hwbh7Z1bnVsyf1BSRvdeg6WVUjfcuuZYRohTyE8V3iOktj2FVKkjXKrIv20Lp5c
         Ytemvtvp4oxt0vXMLzfbaigWmAW3Syx2bRdWAr2BXxH4qqmyN62PnYj4wFwz5ujf9Fq9
         kQeio0/O/AubUj4FvN0ch3ma7cjeLHWuM4XjkiA4tmYGAkmNta4IEfBX7JCU8/nIIySI
         taEdWRH/3vrGI07ocsUTdz55iQ0VCeLI0I1kPQV7V+75l4mnuIsDC2GP4KmeCTte5cak
         KGoQ==
X-Gm-Message-State: AOAM530NDBMZcVDuRetCsxsdDQxNtk69FcwLC+jand8+xT7HksW/3odZ
        jkMlqAMfG8Fbfd7i9j+aEVtN3n73iQ7TNO9gZ2jdbw==
X-Google-Smtp-Source: ABdhPJzzCiHuuzGcxULeosyTXBOlK4ZIt+/tGPvNknk5TvX+B4AW7O4jdcVufduouBXWPpOhHI87w0ZcR36cvNaGFFs=
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr305146pll.325.1597871210318;
 Wed, 19 Aug 2020 14:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200718005141.440405-1-vitor@massaru.org>
In-Reply-To: <20200718005141.440405-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:06:39 -0700
Message-ID: <CAFd5g47orvwzPOnFepDCjkv0nd08Ad2mmVp+XZgVmpGr5C2HwA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: Convert test_user_copy to KUnit test
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 17, 2020 at 5:51 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_user_copy fuctions,
> from `lib/test_user_copy.c` to KUnit tests.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
