Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D457129FBF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 04:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgJ3DDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Oct 2020 23:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgJ3DDH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Oct 2020 23:03:07 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B06C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 20:03:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so6006703lfc.7
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Oct 2020 20:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qetmnWNVsQksjakl8dXjUkaIoxiVzA6keFiGM2ap5AY=;
        b=AybJN8x6VEeLGCBEBx81sKm96EvpYJ8EOMN+ehVaa6kd1osmMtolGYpNiB+P0jXeBh
         JKcVuff4V9jHq7LjenAGN4DP3DoekAwTcbRvi61IrciA2+MhWuRptX/cfrMWp2rh9BUL
         WfSbatM3Au8j1fzzyV3HW0euf/Cis4dc9BCinMZ0G63d+e5Ck9hSrP0cmSaexwCaLIK9
         WfxfJxdjfpqlNROWMWoWk7G1JjCULiMI0/IvyTkN/Ok5//vRUceaGL6seL1jFZ9UpPZ/
         9JxTapyOGkoyBE2PhKDWHY3u4CBkCKKhDihE7xCjbPZeuq44+LhTw7iHPhvtRuHFZqre
         rTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qetmnWNVsQksjakl8dXjUkaIoxiVzA6keFiGM2ap5AY=;
        b=ZwIXt2gYgcaC6ZZ3SEQHhO/H7WvxvJiFOjHrvkOhHAE+BSv28YfQ5CpeMhRxqlRFYr
         EqxCcGPUAPrfWztA0TTpgt6BHYwnaP8u2LatTlEnXPjUcS2HktwFucfGqjI3jrNo20jd
         e3ukSbDkpysBnjhk+Q7blqbyjQ4jthDU+vwwe4Kqf4uolgKJtyfNQQ4ljxClS23qdIVV
         /Ig1VwJWvEYgsEifuu/sVhH0Gpgy9NCOlVt7cslMHGNz8hidgRXdwiG/sPLyipbJb3fC
         3yCxpkJlQMkx3Oo+cg9M7kAhmQUSqCRfAnsRxY/RkViKjTxtq0nN+MOEWovgzhTDhpcT
         LCdQ==
X-Gm-Message-State: AOAM533NoOqOpYxjoqrNtLGRWd1zPJRYYccwlnIP+nQ791pqdnFUYOHK
        blYS8w+NZsl9DShKzV7to3OTWpXZh57PCyCwIkcuyQ==
X-Google-Smtp-Source: ABdhPJzYTNXH60XmJevS1nU77QTkbnJdxDa2BUkj+JK2GK03XFm5dsruLADHPeQtCXNc8JlilkKNtelCRS8CC6e1sv0=
X-Received: by 2002:a19:c357:: with SMTP id t84mr39422lff.34.1604026983869;
 Thu, 29 Oct 2020 20:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-2-mic@digikod.net>
 <CAG48ez3CKa12SFHjVUPnYzJm2E7OBWnuh3JzVMrsvqdcMS1A8A@mail.gmail.com> <afa8e978-d22c-f06a-d57b-e0d1a9918062@digikod.net>
In-Reply-To: <afa8e978-d22c-f06a-d57b-e0d1a9918062@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 04:02:37 +0100
Message-ID: <CAG48ez0eXxjRJ2S3pbYqEsp8xVCdHQMKrPg9WHPB_Rv_kWC_nA@mail.gmail.com>
Subject: Re: [PATCH v22 01/12] landlock: Add object management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 29, 2020 at 10:30 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 29/10/2020 02:05, Jann Horn wrote:
> > On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> A Landlock object enables to identify a kernel object (e.g. an inode).
> >> A Landlock rule is a set of access rights allowed on an object.  Rules
> >> are grouped in rulesets that may be tied to a set of processes (i.e.
> >> subjects) to enforce a scoped access-control (i.e. a domain).
[...]
> >> diff --git a/security/landlock/object.c b/security/landlock/object.c
> > [...]
> >> +void landlock_put_object(struct landlock_object *const object)
> >> +{
> >> +       /*
> >> +        * The call to @object->underops->release(object) might sleep =
e.g.,
> >
> > s/ e.g.,/, e.g./
>
> I indeed prefer the comma preceding the "e.g.", but it seems that there
> is a difference between UK english and US english:
> https://english.stackexchange.com/questions/16172/should-i-always-use-a-c=
omma-after-e-g-or-i-e
> Looking at the kernel documentation makes it clear:
> $ git grep -F 'e.g. ' | wc -l
> 1179
> $ git grep -F 'e.g., ' | wc -l
> 160
>
> I'll apply your fix in the whole patch series.

Ooh, sorry. I didn't realize that that's valid in UK English...
