Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111AC36BB38
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Apr 2021 23:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhDZVcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Apr 2021 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhDZVcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Apr 2021 17:32:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6EC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 14:31:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s9so7929740ljj.6
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Apr 2021 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRra/jPCviRQtIjxwlgYvRcZtIqfcfIxl/QCOhP8XqM=;
        b=EP90p7ehHJgY9KOuBLpqwJgUuPk26rDZaLsYDOARIyfUD1fUzFTxEvCMTbbvLT/eAQ
         /HofzxErUfyaUxu42mnvT3eSHi++IydOeLXKom0EquNHllzWRxGw4GtTPFehG/4g46k3
         c2/HfzLw0vSVk3MS7Bq014JfUDcTKiYbBYaI6rKuJ4L4NuNzyLythel33HovI4hZxYZ2
         sJKdHi+Co5GRMFTNYxjJFMnu86wlEPZmkjHgDttNoiNENZXZiuNV2+2SnAfVO8ZfTOZX
         8yjobRRjFIwTisT3sTYTPem40ksdqpTx/RO7h+1uRqhfRJMAl+PhGwfIcYX6z2QkFRHc
         kjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRra/jPCviRQtIjxwlgYvRcZtIqfcfIxl/QCOhP8XqM=;
        b=MeUtd0P3KKmpFQbodXY7Q+FTRKN8RmU8SQrkPwW/+jYwqBk7oKXS+J2MfW531L2hV2
         RWIWX2/9IZhbSPezSE6dvX5yS0jek1/u1yZMczrH+JubAtvWQgRxDgNaMd79kTAmczAC
         +6f6ONhFS39fvwQiLm7nYX/Qt99Eogu67L9R0IodOZXxNqf0kT9h2CgobUepoUy3WK5A
         A/CxcrcmaYo+tsNJRFEYIF6ls7u7pwwGOaoR7SshIVWq0+QG6KVWF21/dCNBcQF55qwt
         LrDtvXlJIPa6eEiuCvB2OYZHZnw+/EZJkRpvmdN8QaKXDoDJu+JnVLX+UBcPKj2oSjhL
         hVTg==
X-Gm-Message-State: AOAM532YjUeCgaTLQzhCeF9S4FRwZkEl1KIcg2PU5IlH9GiPVoKLTTUs
        fIiwvE7VSfiEVoYpOf8ebheNjnY5xAorbPj5YrsuzrVC2s8pcNcL
X-Google-Smtp-Source: ABdhPJwb6noPMEQT7PFHLLDX/Wj/+CQ5T7aiSIwPoaMBKaaARccUgY4lxKlabFJX+twK0ijxUkBKZjoGrmU1D5Tq7BE=
X-Received: by 2002:a05:651c:1102:: with SMTP id d2mr13553294ljo.490.1619472696085;
 Mon, 26 Apr 2021 14:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <YIRryUf6noodWiqe@smtp.gmail.com> <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
In-Reply-To: <CAK7LNATsbkhYHk6NCZJCDrtT0NFfBwe_n9GRSrEvURaXaW+gfg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 27 Apr 2021 05:31:27 +0800
Message-ID: <CABVgOSmxdQJKgWpXNuuPX=KLaqb4BqdndMRkJ6wpXvLdhieppw@mail.gmail.com>
Subject: Re: Running kunit_tool on unclean trees
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andersonreisrosa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 26, 2021 at 3:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sun, Apr 25, 2021 at 4:05 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hi, a friend and I were chasing bug 205219 [1] listed in Bugzilla.
> > We step into something a little bit different when trying to reproduce
> > the buggy behavior. In our try, compilation failed with a message form
> > make asking us to clean the source tree. We couldn't run kunit_tool
> > after compiling the kernel for x86, as described by Ted in the
> > discussion pointed out by the bug report.
> >
> > Steps to reproduce:
> >
> > 0) Run kunit_tool
> > $ ./tools/testing/kunit/kunit.py run
> > Works fine with a clean tree.
> >
> > 1) Compile the kernel for some architecture (we did it for x86_64).
> >
> > 2) Run kunit_tool again
> > $ ./tools/testing/kunit/kunit.py run
> > Fails with a message form make asking us to clean the source tree.
>
> This is probably because
> tools/testing/kunit/kunit_kernel.py
> runs make with O= option.
>
>
>

Yes: KUnit's tooling has started setting O=.kunit by default[1]. If
you'd rather build KUnit in-tree, you can use the "kunit.py run
--build_dir=." option, which should work.

-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/testing/kunit?id=ddbd60c779b4ddaa87173a160ce90146933fb8f9
