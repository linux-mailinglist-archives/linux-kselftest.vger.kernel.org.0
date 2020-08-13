Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA6224400D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMUto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMUto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 16:49:44 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC0CC061757
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 13:49:43 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q9so5943522oth.5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icwPTzlOzlLq94sgyZZU9ElTfcuw2eVVedKrZCYX64A=;
        b=CiD03k6nzQTEW7iZEhNO/BAlUPZ+kTO8GZS9ZykH2f7VJvoLeYKKtoAsEgIqb6J18H
         7rCLU+ZjZKQPhaNflNoc0frGFbQmkQht9N/kHKRK76cnASqVbNYfmf7W/DZPSzqR/Cn9
         g1fLiFqOXxjWz9K9a2xJRE25UVnQiQ+3UHvsFdwYeHSQ3A3kcRw9zKCVJURFOrxgm1PC
         T6goTWX7LaQIyalyBCGCT0z5wCgUlLFB/Dd0Np9bpYk7NMgGFOpwsTgO51tQ7XlEV4v0
         eyXQxSOxZY+qzcV/Y8Un3JjisENXDUfeT7X79tB0s08qlJ/vf8HOQmXgUtBlLcqse3sp
         +Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icwPTzlOzlLq94sgyZZU9ElTfcuw2eVVedKrZCYX64A=;
        b=tsvpWGN0N3Fr2H3YeaFtM+N5+RcDfxoXHOO5mQusOmZTlIR2HJJ+eGX7z+owokiWA8
         OVzuDgwdiGqwgR2ZgjpnvO/+rjRhedtI+q0zPt2EXDQpG4/SPWurRD7hV3dlQUloUatC
         TBji3ZMVMYTf8WKopOisa7+2mbyS3msN9Os8hrNmkEJ91CnBwRYu9iFsApuhZI12RbEW
         CoJJTWOgKK/dNsRFz6z2eptKJOmQ3WE3bcZU03EbMfHIYolskyCZGa2EEPAh8nN220lO
         9fRNo4lurg5F77B3H3wHMDAa6VgNAJd1nm3JLAuNBSSf0E+1TWIhk15QK4gSJ7oSjfmq
         sduA==
X-Gm-Message-State: AOAM533bO3F69ammPV/rzx8uadYm57kdFVULfb7bBx44VDtg2Yqs/9ny
        AM66FyQy3MHeERXbRz3hKKolSFM0ZwpWq05WRDnbqg==
X-Google-Smtp-Source: ABdhPJySUMbmOi8682FCf9k0rtc40K/rMkthT8G3y5DkT35881HaaKNvapQkArVfY7QS4LZKhTQ7ilhXunWdFsRafQs=
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr6050894oti.283.1597351783206;
 Thu, 13 Aug 2020 13:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
 <20200806174326.3577537-2-urielguajardojr@gmail.com> <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
In-Reply-To: <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 13 Aug 2020 15:49:31 -0500
Message-ID: <CAG30EeeL9m7fcvZVj+6_d2v17e1P1vSSK6qBof2Gkvq7APp33w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: ubsan integration
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 10, 2020 at 3:43 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 10:43 AM Uriel Guajardo
> <urielguajardojr@gmail.com> wrote:
> >
> > Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
> > whenever it reports undefined behavior.
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
>
> You should resend this to the UBSAN maintainers as well; they will
> need to sign off on this.
>
> In the future, make sure to run get_maintainers.pl

There are no listed UBSAN maintainers. Will instead resend to the
suggestions from get_maintainers.

>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> > ---
> >  lib/ubsan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/ubsan.c b/lib/ubsan.c
> > index cb9af3f6b77e..1460e2c828c8 100644
> > --- a/lib/ubsan.c
> > +++ b/lib/ubsan.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <linux/sched.h>
> >  #include <linux/uaccess.h>
> > +#include <kunit/test.h>
> >
> >  #include "ubsan.h"
> >
> > @@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
> >  {
> >         current->in_ubsan++;
> >
> > +       kunit_fail_current_test();
> >         pr_err("========================================"
> >                 "========================================\n");
> >         pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
