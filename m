Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6476D8C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjHBUpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHBUpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 16:45:35 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F297726AB
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 13:45:33 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so115356fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691009133; x=1691613933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/1Bfm6suFyViDWNlr8+HrMuba+po2ALntmKmq7g2XA=;
        b=fWDVHQD6E/n9Ca7eabCCX6b0FFMGlyISauUxdo0n2rpIZnfZ95RCQCHEPckZtOKLCA
         Sddo6fzWI4gkqr1sajuR+gUUXb/J9BJ7WjG/y+FBliSpaWUz/rczqYOGle4EdddiwjtP
         i4w41LX3Z1PNFXlt8JNAPBre/xxE2c3QRnk/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009133; x=1691613933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/1Bfm6suFyViDWNlr8+HrMuba+po2ALntmKmq7g2XA=;
        b=VjPyfDIEvRpN6y984wQXu6e5iNNqU9l2xtK47Xozy4c/yB/CTNgb0TYUonZKyuUdKR
         4wUfkKqMcVwPYuwva1BOowdyUdL/E3TadaJCp51IKhBUYil3BlaQuGj2+Eyu4mc1o7Hu
         A77RA3aiYglBrNdJKmeVv95BE6Y8C9GZtWMEJiJq6LkaQH43NGKFypagR9DpPa8QT+aV
         az38MYlFHifLfEivqwCg8lv0bUO+VoZjNJFc4J74BE6s9eEj2PFhW11JnwqgU3xPVRq/
         5B2cyS6wy+TeWLxQa4X9sKV6B7bZs49/viwt7eY+ktzKGrT3abdtYOSftnRXXBCCAz6Z
         onAw==
X-Gm-Message-State: ABy/qLY9H+LNlLEvGdh3hO7YJqs7LI/x9qclQqKHWuNLJGAC8ih8nS/0
        F+mzOCQmEZa4IxpDL+wQOQoI2xEHaOnTaNGSLQ4jAA==
X-Google-Smtp-Source: APBJJlEqN8WznNoc2+T+MjGzRWpOC67aOcySrJF83niYlI694u4xO01qbb56VWKDeRmZuTqh3OCCclVzdbbzIgJRr4Y=
X-Received: by 2002:a05:6870:2052:b0:1bb:85c3:929e with SMTP id
 l18-20020a056870205200b001bb85c3929emr16774760oad.48.1691009133246; Wed, 02
 Aug 2023 13:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <CABi2SkVCp_MDh9MgD-UJ_hgJ58ynm22XJ53zE+ZCBSsWFBxiOw@mail.gmail.com>
 <o2tz56m3y2pbbj2sezyqvtw3caqwcqtqqkkfrq632ofpyj4enp@znkxadzn5lmj>
 <CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com> <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
In-Reply-To: <20230801.032503-medium.noises.extinct.omen-CStYZUqcNLCS@cyphar.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Aug 2023 13:45:21 -0700
Message-ID: <CABi2SkUnJ4NiRMtSXdLtHXWrY23iKLdGiUuTgc0Yrtq16-KkeA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> > > > >  * vm.memfd_noexec=2 shouldn't reject old-style memfd_create(2) syscalls
> > > > >    because it will make it far to difficult to ever migrate. Instead it
> > > > >    should imply MFD_EXEC.
> > > > >
> > > > Though the purpose of memfd_noexec=2 is not to help with migration  -
> > > > but to disable creation of executable memfd for the current system/pid
> > > > namespace.
> > > > During the migration,  vm.memfd_noexe = 1 helps overwriting for
> > > > unmigrated user code as a temporary measure.
> > >
> > > My point is that the current behaviour for =2 means that nobody other
> > > than *maybe* ChromeOS will ever be able to use it because it requires
> > > auditing every program on the system. In fact, it's possible even
> > > ChromeOS will run into issues given that one of the arguments made for
> > > the nosymfollow mount option was that auditing all of ChromeOS to
> > > replace every open with RESOLVE_NO_SYMLINKS would be too much effort[1]
> > > (which I agreed with). Maybe this is less of an issue with
> > > memfd_create(2) (which is much newer than open(2)) but it still seems
> > > like a lot of busy work when the =1 behaviour is entirely sane even in
> > > the strict threat model that =2 is trying to protect against.
> > >
> > It can also be a container (that have all memfd_create migrated to new API)
>
> If ChromeOS would struggle to rewrite all of the libraries they use,
> containers are in even worse shape -- most container users don't have a
> complete list of every package installed in a container, let alone the
> ability to audit whether they pass a (no-op) flag to memfd_create(2) in
> every codepath.
>
> > One option I considered previously was "=2" would do overwrite+block ,
> > and "=3" just block. But then I worry that applications won't have
> > motivation to ever change their existing code, the setting will
> > forever stay at "=2", making "=3" even more impossible to ever be used
> >  system side.
>
> What is the downside of overwriting? Backwards-compatibility is a very
> important part of Linux -- being able to use old programs without having
> to modify them is incredibly important. Yes, this behaviour is opt-in --
> but I don't see the point of making opting in more difficult than
> necessary. Surely overwite+block provides the security guarantee you
> need from the threat model -- othewise nobody will be able to use block
> because you never know if one library will call memfd_create()
> "incorrectly" without the new flags.
>
>
> > > If you want to block syscalls that don't explicitly pass NOEXEC_SEAL,
> > > there are several tools for doing this (both seccomp and LSM hooks).
> > >
> > > [1]: https://lore.kernel.org/linux-fsdevel/20200131212021.GA108613@google.com/
> > >
> > > > Additional functionality/features should be implemented through
> > > > security hook and LSM, not sysctl, I think.
> > >
> > > This issue with =2 cannot be fixed in an LSM. (On the other hand, you
> > > could implement either =2 behaviour with an LSM using =1, and the
> > > current strict =2 behaviour could be implemented purely with seccomp.)
> > >
> > By migration, I mean  a system that is not fully migrated, such a
> > system should just use "=0" or "=1". Additional features can be
> > implemented in SELinux/Landlock/other LSM by a motivated dev.  e.g. if
> > a system wants to limit executable memfd to specific programs or fully
> > disable it.
> > "=2" is for a system/container that is fully migrated, in that case,
> > SELinux/Landlock/LSM can do the same, but sysctl provides a convenient
> >  alternative.
> > Yes, seccomp provides a similar mechanism. Indeed, combining "=1" and
> > seccomp (block MFD_EXEC), it will overwrite + block X mfd, which is
> > essentially what you want, iiuc.However, I do not wish to have this
> > implemented in kernel, due to the thinking that I want kernel to get
> > out of business of "overwriting" eventually.
>
> See my above comments -- "overwriting" is perfectly acceptable to me.
> There's also no way to "get out of the business of overwriting" -- Linux
> has strict backwards compatibility requirements.
>

I agree, if we weigh on the short term goal of letting the user space
applications to do minimum, then having 4 state sysctl (or 2 sysctl,
one controls overwrite, one disable/enable executable memfd) will do.
But with that approach, I'm afraid a version of the future (say in 20
years), most applications stays with memfd_create with the old API
style, not setting the NX bit. With the current approach, it might seem
to be less convenient, but I hope it offers a bit of incentive to make
applications migrating their code towards the new API, explicitly
setting the NX bit.  I understand this hope is questionable, we might
still end up the same in 20 years, but at least I tried :-). I will
leave this decision to maintainers when you supply patches for that,
and I wouldn't feel bad either way, there is a valid reason on both sides.

To supplement, there are  two other ways for what you want:
1> seccomp to block MFD_EXEC, and leaving the setting to 1.
2> implement the blocking using a security hook and LSM, imo, which is
probably the most common way to deal with this type of request (block
something).
I admit those two ways will be less convenient than just having sysctl
do all the things, from the user space's perspective.

Thanks




-Jeff
