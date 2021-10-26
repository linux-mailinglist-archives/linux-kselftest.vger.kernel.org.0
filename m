Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1B43B8A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 19:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhJZR53 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 13:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhJZR52 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 13:57:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1130C061745;
        Tue, 26 Oct 2021 10:55:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so69093plg.13;
        Tue, 26 Oct 2021 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=225l4SA1OGtdUSNrI/zTvcHrB7dEaQw3+UttA1rDb8E=;
        b=BZFrlCMj/rV6HcmWYv8j/HdU0pdqvvR1cBDAoJhSUU3QKaCbApIPAdOIBovnSdIszu
         mpLhbZcAy+S+AKwZtafdpdwfyex82nE9S/EL+ALUkZFCE/H6F5dEWzr2xOFiWcB5jETw
         zJNM0H9wgriHQSZSHhAwY67pYq1dPiNKZfZDsWLpvnmwIMkpq+IgrZn+nMYQ1QfDosJN
         wnd648K6iDkOfuJNDHALSLeQ2HFmad/7sLL5OPieaCnBLvT2yWh2MZ+/z02lJOJBWYyj
         Jj8lCcbPczk93iKvd4CfVje1Uw7njLUSFXFrI/IhGgG2fjLsWvW20RpeqFDC8kABnWo8
         BO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=225l4SA1OGtdUSNrI/zTvcHrB7dEaQw3+UttA1rDb8E=;
        b=pWlBohf9hoUYcZ6qg6WaGClgRI9Fr0GqjJVNwHFAHcA2zkAS3R5tUaFf4rdAVhXO0Y
         PqGvDb65iNrEaKvVY4GaaRdcDjmTmfhgKUQFLimbTt6o06KzGsjLfR/213iM5hR5p4zj
         9F47jAewwMApXlHH5OPuVlQqT7SIeoHVl6MNr860vIR7uvq7cMweQXK3g066wNr0Zufp
         9Oilt26XhIvarqENu1p5IuIgFO6r3X9kwXVV/sgg3/efjtfh8Gs0Bfhn2lh0Lh+7XwBU
         ugwPr2vpBbclsZScbfl+xsh7GeRICrJ2BxUzfkRbbg+0sL9WJsBNWCOYNhMGeevlNP5y
         2EBw==
X-Gm-Message-State: AOAM530LjWusczm9uAriRVzZvSRiCd9c/X3RfMtiHTlYbCkqfU/f0Kyg
        jK0QXM0VtqvzPvB+mNeK9LvjgKcEiDIkGEesnrlE170/z38=
X-Google-Smtp-Source: ABdhPJxgeIN2LvtNpZZLac6UfKv3uZ72O0a4OseZVAu4guZ5UKoE5Pg9rL/JeVT/0beVAo//wgKjPGPUQIv6I7RQhNU=
X-Received: by 2002:a17:902:8211:b0:13f:afe5:e4fb with SMTP id
 x17-20020a170902821100b0013fafe5e4fbmr23969092pln.20.1635270904246; Tue, 26
 Oct 2021 10:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211026143409.42666-1-andrea.righi@canonical.com> <ce41c5da-2952-e800-54be-51cbcc7a0ada@linuxfoundation.org>
In-Reply-To: <ce41c5da-2952-e800-54be-51cbcc7a0ada@linuxfoundation.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 10:54:53 -0700
Message-ID: <CAADnVQK_LWcafdVwB+7aFr2Ow3yOd03e8D6-d13JbMB8=a+QQw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix fclose/pclose mismatch
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 10:47 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/26/21 8:34 AM, Andrea Righi wrote:
> > Make sure to use pclose() to properly close the pipe opened by popen().
> >
> > Fixes: 81f77fd0deeb ("bpf: add selftest for stackmap with BPF_F_STACK_BUILD_ID")
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >   tools/testing/selftests/bpf/test_progs.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index cc1cd240445d..e3fea6f281e4 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -370,7 +370,7 @@ int extract_build_id(char *build_id, size_t size)
> >
> >       if (getline(&line, &len, fp) == -1)
> >               goto err;
> > -     fclose(fp);
> > +     pclose(fp);
> >
> >       if (len > size)
> >               len = size;
> > @@ -379,7 +379,7 @@ int extract_build_id(char *build_id, size_t size)
> >       free(line);
> >       return 0;
> >   err:
> > -     fclose(fp);
> > +     pclose(fp);
> >       return -1;
> >   }
> >
> >
>
> Thank you for the patch. The return logic could be simpler
> doing out handling common for error and success path with
> just one call to close. Not related to this change though.
>
> Adding bpf maintainers to the thread

Ohh. That's odd.
I see the patch in:
https://patchwork.kernel.org/project/netdevbpf/list/?delegate=121173
but not in my gmail.
vger is probably slow.
