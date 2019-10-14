Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B643D611F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfJNLT3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 07:19:29 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42744 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfJNLT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 07:19:29 -0400
Received: by mail-qk1-f169.google.com with SMTP id f16so15500113qkl.9
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9BBMSyhpBFdWtL0DjmQ2VJj8KhYROwcWMbTk9Hb1B0=;
        b=RkC9m+IK0fs73s5Uzn2fnqeFmvD/cXftcnapDExyR9iQ+WMXDX3KLeTnqv42vGdQp9
         XF+WSLI3JbKXK1vPMyIr+ttyNM8N/+g7PhMlggQHLIiN3pmPdnEzYNs72E9luqxVABoU
         uN3u8Bch+7WokI1aIKd++nwmFCvp6w/YkoKEFWud/VrwdPl1zUAPM7lkJNKZZIWvZ0JI
         /n64ygq7w2QxNuQlJ9+9NRxTYFlz12y/RbSNs2eS/CdMSn0/onjSLeCxMFbFcTqLPt7f
         Wbtxd0C8Rl+5TxvHfpw6ZWhI8O6akr8aOm9MTQNnbafAtE9PsySRfkuTmvnKEE086YoW
         7nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9BBMSyhpBFdWtL0DjmQ2VJj8KhYROwcWMbTk9Hb1B0=;
        b=C/7tt5wuFM4mEbui2Tfz+oUIw7IHMqJ6Ah8db+x4zmBkwD1+Ds5cbUapcoMVX32Mlm
         INstP8nK5Hsm9qiBcAzwZAxmj8KT+U+iUiy4OLwWdpQhlaHUMXuPmzY023ExPwX4AeC9
         cH9LPxenRB/JFlsAyfqXLllAUSydSf4G+7GKr7pxgeF7G1kzWyR4FN80UARLJuOMaaQR
         ttpc5zM4cUJwkdPuPLj9NtpoMl3jW8QNxVQmaO/j/mOfK/aDdcqsmN1PfXz1h2qD8ulp
         ECgWwp6Uf3YdMT9WVE1RiYzZ2Dw6nZ5I3+NvM07iFbYrZUHfPM8VL9FtogP4mazghJmc
         6/Ew==
X-Gm-Message-State: APjAAAUvXpfRcFgpTMUcC7IFdUJpVSOgsyP+TYl0d0Ka9R4gNale1i1g
        I1lS98YJVDb0MA2+kIwaSWwvu3xOvT4ZCLyV/5diwA==
X-Google-Smtp-Source: APXvYqw4f1MGUziTj5YCtLk7mfKa8lIfqbZ/uq5fx4Oduhglc0vFDtje21AgyBjjqRMgvcveYJXDUbvmpFIC+MygRDg=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr29602822qkm.250.1571051967455;
 Mon, 14 Oct 2019 04:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org> <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan> <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan>
In-Reply-To: <20191014085414.GB31760@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 13:19:15 +0200
Message-ID: <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        George Kennedy <george.kennedy@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 14, 2019 at 10:54 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > You are suposed to run the run.sh script in the bin directory.
> >
> > Yeah that does work.
> >
> > Would be helpful to have usage instructions instead of failing. :)
>
> I do not think that these scripts are ever supposed to be the used in
> production testing, you need much more than this to produce results
> reliably. I would expect that they are supposed to be a form of very
> minimal documentation.

Yes, I just added them as quick hints: some repros are 32-bits; each
needs a new dir; some external timeout is needed for each test.
