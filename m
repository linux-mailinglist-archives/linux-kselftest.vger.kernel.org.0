Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB74562BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhKRSqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 13:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhKRSqP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 13:46:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E3C061748
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 10:43:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bj13so16296886oib.4
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 10:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsHgrt3f1EilcZuTcpPj1Uibbk6NZSW0KCEvWuPSgaA=;
        b=dfb4NHDvEkj3BC0fHWPSnJOucM9uBQPYun5TISX7bpUpB0jCAJwUVcP5N9FTAKhQe5
         3bT/dFWcq+5RZJY8na+AdpyJt6bvMK3CAxHElXXCraHes83ilGYVcaIw0NRDLjZllGME
         9rOj5iWZgQF1lvJ0+c/c2AgdOds4WnUYGL6/jE9MNLmiSKbBexf7yej741WRfqi/sHie
         1ROChNXPDL1LLWq+RrR1gHEwwfTy1kh4+KGx1workcrW3ZpqK/gz5TTnrr2Y9dgVeLBo
         +bUq6ZnYvYiMFnye2VqGFtkt+RF8fWOG6fE8xtDUWqe6OgLEhg6tMN6/GcBDZOoGwx5d
         8Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsHgrt3f1EilcZuTcpPj1Uibbk6NZSW0KCEvWuPSgaA=;
        b=pL3RDWIPHiGXgLHu5/XmU75vVyNQQO76IXkOPlDBqJli4k39uLWSkIz8d5DEhEc7im
         ywLX7m/buDqTamkg9ghnSY43Xiy34pjy7uE2qSjHnSjLnCYrJtpv8MCa9KXFRwtJXKsY
         v1XqLwm5e4xExTXgSB5wgha23NqaSNnkb5wo7Fs1QuChnP+GheGTC1HZGxZFGXoH/ap8
         cAndGqiUDh29UeSe3S8NRJA9zRwuAbg9cwVQVmw7IhujcBaO1YNOrARBvrTzhhLc06sS
         L5lRMXNp2f4QJQ8Gu3ixQfVybN/hQ6LYEXhzFB4IyilX8AUBlrCyq6Hy35aCf2ZokEVi
         PAAA==
X-Gm-Message-State: AOAM531AtSRVmgcj8L+SHIrZbvx66M0gdrn1lU9sC0ZAReEqjYPXxuzv
        ataGPtEic3UJnp/ukmkNwQhu2J32Y3RAZaNEkWnczw==
X-Google-Smtp-Source: ABdhPJw6w0Zi8W9bt5228Ldv0ZCK8SRbrpkPWfvrUH89RTZAP9oilxdXqZv6iwBHs+Ol+3+gMO/PVdwFbqZjbjRk+f4=
X-Received: by 2002:a05:6808:3012:: with SMTP id ay18mr10076246oib.88.1637260994768;
 Thu, 18 Nov 2021 10:43:14 -0800 (PST)
MIME-Version: 1.0
References: <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
 <20211118095852.616256-1-anders.roxell@linaro.org> <20211118095852.616256-2-anders.roxell@linaro.org>
 <CADYN=9+drOj6rVjBhB-jVQ+UXgw3ue0tz04ejHih7qRhL6Km1A@mail.gmail.com>
In-Reply-To: <CADYN=9+drOj6rVjBhB-jVQ+UXgw3ue0tz04ejHih7qRhL6Km1A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Nov 2021 10:43:02 -0800
Message-ID: <CAKwvOdmKebwN436byQd4FY=wCBmrHdE=R4g-y=1ENKV5Mdw7MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests: clone3: simplify return logic in clone3_set_tid()
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 2:03 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Thu, 18 Nov 2021 at 10:58, Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Use ksft_exit_* and exit instead of using goto.
> >
>
> I'm sorry, I should have added Nick to this patch, since he suggested it.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Cheers,
> Anders
>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> > ---
> >  tools/testing/selftests/clone3/clone3_set_tid.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> > index a755fcd3af89..1b950c3c3b7c 100644
> > --- a/tools/testing/selftests/clone3/clone3_set_tid.c
> > +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> > @@ -250,7 +250,8 @@ int main(int argc, char *argv[])
> >                  * that all those tests are skipped as non-root.
> >                  */
> >                 ksft_cnt.ksft_xskip += ksft_plan - ksft_test_num();
> > -               goto out;
> > +               ksft_exit_skip(
> > +                       "Please run the remaining tests as root - Exiting.\n");
> >         }
> >
> >         /* Find the current active PID */
> > @@ -371,9 +372,7 @@ int main(int argc, char *argv[])
> >         close(pipe_2[1]);
> >
> >         if (waitpid(ns_pid, &status, 0) < 0) {
> > -               ksft_print_msg("Child returned %s\n", strerror(errno));
> > -               ret = -errno;
> > -               goto out;
> > +               ksft_exit_fail_msg("Child returned %s\n", strerror(errno));
> >         }
> >
> >         if (!WIFEXITED(status))
> > @@ -390,10 +389,6 @@ int main(int argc, char *argv[])
> >                 ksft_test_result_fail(
> >                         "PIDs in all namespaces not as expected (%d,%d,%d)\n",
> >                         ns3, ns2, ns1);
> > -out:
> > -       ret = 0;
> >
> > -       if (ret)
> > -               ksft_exit_fail();
> >         ksft_exit_pass();
> >  }
> > --
> > 2.33.0
> >



-- 
Thanks,
~Nick Desaulniers
