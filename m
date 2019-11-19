Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9C102BC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 19:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSSg3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 13:36:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40166 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSSg2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 13:36:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so12221875plt.7
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2019 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqd1PZl4Bd7PEGTyuVkaWzR8dbBXh+gC15PgfLfD0Zw=;
        b=vVGW3EfTq7IwmL6p+BTaKa+qb54m/uF752AGPg8O3AB19vr2fJ/XiITO6xRm37/htM
         wgspP/qnrZ1knIUwpY9LkcSAxvEW7iwhMFr5lE+KUXiSfqUzYWgLg9s2yaZu0etKbwbl
         4vPlCLufd/3gzStPsWsGMNY7I1o6en96LUpHN/Y0QlKwMSABDJk/uQmFIVMjQ0F1eiNk
         1DXuJ4+1FQK3UILFjofyOz+sf4XqFrOkSyZVopEKE/90f1tx+zZBAwopmSMT6fJUCUmt
         iuodJG/jzNR98u9s3lij09Ql46xDCZn8QZ5zpDUnSXzbMtU9uA7PJrsByrH5UVZbeSrQ
         FI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqd1PZl4Bd7PEGTyuVkaWzR8dbBXh+gC15PgfLfD0Zw=;
        b=LSOobC08OKbnXrNNzc6faR4XiC0kNVeGK8bLXjjCCExyefIajYX/3Ip57nGfN1Zzzz
         +7bkTHR2YVyZM67B8ocGlUfwNupgwWiWsxiC2KGrH3wIXcO8w/8xfBUTnToqIQ/FHlDq
         AQx67EtcuPE/9yJcnoxPQLBAg4HpYh39gRUJhNdHC1dwxqDkUa2u8xMK+ZB7QU58Rd1E
         dQk3eMyKj7Siifls+pglh41gq/q5UHAb12SiBJJcuV/NwAbPovSqnegKotSH3knt/Evk
         qQA1G3LgWoMc+gpGCcXdRQd5bV0+rjM6TEREFen7Utc6xp9EfYxKW+PirXBjKdjRvcia
         nO9Q==
X-Gm-Message-State: APjAAAWgpe6UTleuv/4fNqO/anmp1hRGELVHGofINHl4hDLHlG+XTuq4
        DAZexXTuSFQrEnGr5g+3M0qYDbWGAY9jYEGdhQ1asg==
X-Google-Smtp-Source: APXvYqwntEoFXFSkd8roeQK4Vfw0pBJCXkLH0R0JAgVf2MFOls4Cp8WPWrVjsoHG2ZZbgV3p9gNovSTX97zEa+suatw=
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr8032255pjw.84.1574188587517;
 Tue, 19 Nov 2019 10:36:27 -0800 (PST)
MIME-Version: 1.0
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
 <1573812972-10529-2-git-send-email-alan.maguire@oracle.com> <20191117013336.F23F820730@mail.kernel.org>
In-Reply-To: <20191117013336.F23F820730@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Nov 2019 10:36:15 -0800
Message-ID: <CAFd5g44115hPDMJNWPnyLZ_3zJMBzA+6MHxCLCA1ddkYipDtkA@mail.gmail.com>
Subject: Re: [PATCH v4 linux-kselftest-test 1/6] kunit: move string-stream.h
 to lib/kunit
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Luis Chamberlain <mcgrof@kernel.org>, changbin.du@intel.com,
        linux-ext4@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 16, 2019 at 5:33 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Alan Maguire (2019-11-15 02:16:07)
> > string-stream interfaces are not intended for external use;
> > move them from include/kunit to lib/kunit accordingly.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
>
> The sign off chain is incorrect here. Is Knut tag supposed to be
> Co-developed-by?

I am not sure what the relationship between Alan and Knut on this
patch. Nevertheless, Signed-off-by is required either way, but it
seems that Co-developed-by is optional depending on how Alan and Knut
would like to share credit for this patch, at least that is based on
my reading of the submitting patches guide:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> > diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> > index db6a0fc..ad889b5 100644
> > --- a/include/kunit/assert.h
> > +++ b/include/kunit/assert.h
> > @@ -9,10 +9,11 @@
> >  #ifndef _KUNIT_ASSERT_H
> >  #define _KUNIT_ASSERT_H
> >
> > -#include <kunit/string-stream.h>
> >  #include <linux/err.h>
> > +#include <linux/kernel.h>
>
> Why is this included now?

Nice catch! I think I would have missed that.

> >
> >  struct kunit;
> > +struct string_stream;
> >
> >  /**
> >   * enum kunit_assert_type - Type of expectation/assertion.

Cheers!
