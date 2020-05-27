Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2AB1E37A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 07:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgE0FEr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 01:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgE0FEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 01:04:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDAC061A0F;
        Tue, 26 May 2020 22:04:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f189so23227923qkd.5;
        Tue, 26 May 2020 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0dxXLwYUzzntAQ3SR+LnnZK2T5JDa+N93Z0JKfXHz8=;
        b=TSZii9K8kquFuxxz+iwN8SHSf7+tsAr8CWEwl8SiN8OfbBbZaroUp0E3uvVqUYK4Ja
         lNiKQSMtcrLxWyCrx5lFEHFpICfHGoRyO9QHbVHCIqMVEs7sxq0qAhpB8YCyHh8+zJJ9
         CFTYD71odTEfyehVsmG4BH45rBBX8mkDZdwS6hWr5ko3oqX/NW7uIrSbB4tL+Umifc+u
         okCcFDzGCgxypPjXBe52Bo3onRBW26IhX0KDZ4JmLPZk4Vphr3oX9KoR+P77fyBw9E2d
         bbLgo0jXt/JCWDtODIWL+DGuL05hCTwdoe/+tdMVkHVDchdZFuVvYcdVxuutp1QKkht2
         qX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0dxXLwYUzzntAQ3SR+LnnZK2T5JDa+N93Z0JKfXHz8=;
        b=jht5bgi5KgKqHpmOEjnuBkPAzwZUFHPU+YVXQcvk5NkWAYoyCruIYtoBrs+733Frkh
         hbj4sARKReN340x+QiO959tzSz1HKqz1GY3qGrasNIfmVXlJCzOTdiB1pbu/hfLdPUEh
         tDz3oohiSWmhXHhDIqvP/8B7hEtzknYHXRipza8Gp1xuXNVaATsk8WJwHI6Wf2qjJnpc
         FGxtKxMtMY9DvH+UnFTd4Rqp8z3cli6LbbsqGnHanQV0goPfbUH/e2JDdfRbh+SEDz0j
         Ej316MBxt/cX3oLIhl01VSP8X7+cukOxN+0MWeLp+teJoCUVI2PAjlx7jMLnbbpfOHB0
         lUqA==
X-Gm-Message-State: AOAM531kqv67iKGxmT0NLNtgA0/Qq/VOKOPznsmgRLFPjQck101ajqd6
        oeRdu0HFUt4qTy8EVLYevsEtDfpoj7/aXrt6kME=
X-Google-Smtp-Source: ABdhPJwf1J0qIffX5mNiVWzptFuX0EwLar4iDhidLBMA+m5rI/+SMS9fNO7yhJKh0ydSOXH/JjoalZH8HZy+blr9Zsk=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr2497147qkl.437.1590555886435;
 Tue, 26 May 2020 22:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <xuny367so4k3.fsf@redhat.com> <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
 <xunyv9kiou7w.fsf@redhat.com>
In-Reply-To: <xunyv9kiou7w.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 22:04:35 -0700
Message-ID: <CAEf4Bzau5MWYqP1XfZzYVj6tf7Y9fmJRgjbO00DzOmJ_iGschg@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 26, 2020 at 9:52 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> >>>>> On Tue, 26 May 2020 15:32:10 -0700, Andrii Nakryiko  wrote:
>
>  > On Thu, May 21, 2020 at 11:41 PM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >>
>  >> Actually, a bit more needed :)
>
>  > From the other kselftest thread, it seems like selftests are not
>  > supporting builds out-of-tree. With that, wouldn't it be simpler to
>  > build in tree and then just copy selftests/bpf directory to wherever
>  > you need to run tests from? It would be simple and reliable. Given I
>  > and probably everyone else never build and run tests out-of-tree, it's
>  > just too easy to break this and you'll be constantly chasing some
>  > non-obvious breakages...
>
>  > Is there some problem with such approach?
>
> This is `make install` ;).

So patch #2, #5, and #7 is solving just `make install` problem?..

My point is that by building in tree and then just copying everything
under selftests/bpf directory to wherever you want to "install" it
would just work. And won't require complicating already complicated
Makefile. Any problem with such approach?


>
> I personally do not need OOT build, but since it's in the code,
> I'd prefer either fix it or remove it, otherwise it's
> misleading. But I have not got reply from kselftest.
>
>  >>
>  >> >>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
>  >>
>  >> > I had a look, here are some fixes.
>  >> > Yauheni Kaliuta (8):
>  >> >   selftests/bpf: remove test_align from Makefile
>  >> >   selftests/bpf: build bench.o for any $(OUTPUT)
>  >> >   selftests/bpf: install btf .c files
>  >> >   selftests/bpf: fix object files installation
>  >> >   selftests/bpf: add output dir to include list
>  >> >   selftests/bpf: fix urandom_read installation
>  >> >   selftests/bpf: fix test.h placing for out of tree build
>  >> >   selftests/bpf: factor out MKDIR rule
>  >>
>  >> >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
>  >> >  1 file changed, 55 insertions(+), 22 deletions(-)
>  >>
>  >> > --
>  >> > 2.26.2
>  >>
>  >>
>  >> --
>  >> WBR,
>  >> Yauheni Kaliuta
>  >>
>
>
> --
> WBR,
> Yauheni Kaliuta
>
