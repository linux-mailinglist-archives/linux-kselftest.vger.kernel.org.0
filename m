Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9058A77ED63
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 00:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbjHPWre (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347097AbjHPWr3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 18:47:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E12723
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 15:47:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40c72caec5cso125611cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692226038; x=1692830838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmAfMTPz4eh29CLf8sk04qA9x8l/5iZhtjn1NdNuQus=;
        b=wIBTRZDkz6UQoktGyqxoTeEQiN6IHsdC3DKvn5H/h2iBRaohFe6JXoyF0NoAg/2tBp
         pRlR+f/oy57QNKyAN14VMwjBN74w57rH/wr/BPlQeKkBa94KsFYRDmoYjCTp8kCV6hzO
         DoGfbSoSyB9LY2seA1Dqat7bdi9sSxxPWwU1cnXjLX5zzGwDp7FWLBUSyJX7sehzokvT
         GAUMhsc9pZ1Ooyt7lUb0tKj/6Nk4Xi5Q5zftKU53KqgbmokxHTGTOWITXYBDivdT4Ob9
         l/z7ZDuqhiAy8tYSstQMSnht+l47Z0hVa9IsskRBLmlp7Ij+82KBTY14k7C8V66GPHLc
         dxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692226038; x=1692830838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmAfMTPz4eh29CLf8sk04qA9x8l/5iZhtjn1NdNuQus=;
        b=SSrKl3j3KUNHTHBhTpTItDrCORN1lE7zZo9gdJbC7wB3ZGNxo/ILzxyK5B2xIrq1K6
         LSTnFvscPxIbuWXpysIQMVcRzTjUQDKCW+sbNFt8e5053kAxKkSgKa9iNMNaA4h/LO9C
         Pgl/7vb1DvX4OaNC59bJVOU7uxXtqc1k0LeYvbLmfF9/Yq6ZvUTDarxEJQIirHJue6+C
         JpkYdGiBVuBKio4iecjP1BRARAOT1zhoD6UZwL8ta2rP8qxp8PM2APF6DckEcQbNguX3
         L9DXiaR2LaxcRXtvKXMLOSN7xa9pgSf/9Zt4bW5fg6ZRKbJSd2chGQHlluku0s0GQFkh
         KTpA==
X-Gm-Message-State: AOJu0YxyEJ3IkUqF1I01iMozKTPO17a3liUmfLxUfFtrDAJ/lreDbTP9
        HojB845tuJLn7Bqs883fOn24NRcEUj0vaS6pnVldHQ==
X-Google-Smtp-Source: AGHT+IGKhVtNgZhUpSQYcnybxaqwvR/y997m77QY4GFoPXa9zfEq+ZbGp4ISpTVoDw/ZKneDf0Bl3pDyVZg2gBas0+c=
X-Received: by 2002:ac8:118b:0:b0:40f:ec54:973 with SMTP id
 d11-20020ac8118b000000b0040fec540973mr93254qtj.22.1692226037853; Wed, 16 Aug
 2023 15:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-4-7ff9e3e10ba6@cyphar.com>
 <CALmYWFvxLee5+RyLh=vo6kpwMVS-_C7BJ9kmTPDa2tetgHOHPw@mail.gmail.com> <ZNxiLe_jkXpxh3QU@codewreck.org>
In-Reply-To: <ZNxiLe_jkXpxh3QU@codewreck.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 16 Aug 2023 15:46:41 -0700
Message-ID: <CALmYWFvk5N2p4_ANzq0NrcLaMRHrYqpNxzHWi8kvD59aC5ayhg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] memfd: replace ratcheting feature from
 vm.memfd_noexec with hierarchy
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 10:44=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Jeff Xu wrote on Tue, Aug 15, 2023 at 10:13:18PM -0700:
> > > Given that it is possible for CAP_SYS_ADMIN users to create executabl=
e
> > > binaries without memfd_create(2) and without touching the host
> > > filesystem (not to mention the many other things a CAP_SYS_ADMIN proc=
ess
> > > would be able to do that would be equivalent or worse), it seems stra=
nge
> > > to cause a fair amount of headache to admins when there doesn't appea=
r
> > > to be an actual security benefit to blocking this. There appear to be
> > > concerns about confused-deputy-esque attacks[2] but a confused deputy=
 that
> > > can write to arbitrary sysctls is a bigger security issue than
> > > executable memfds.
> > >
> > Something to point out: The demo code might be enough to prove your
> > case in other distributions, however, in ChromeOS, you can't run this
> > code. The executable in ChromeOS are all from known sources and
> > verified at boot.
> > If an attacker could run this code in ChromeOS, that means the
> > attacker already acquired arbitrary code execution through other ways,
> > at that point, the attacker no longer needs to create/find an
> > executable memfd, they already have the vehicle. You can't use an
> > example of an attacker already running arbitrary code to prove that
> > disable downgrading is useless.
> > I agree it is a big problem that an attacker already can modify a
> > sysctl.  Assuming this can happen by controlling arguments passed into
> > sysctl, at the time, the attacker might not have full arbitrary code
> > execution yet, that is the reason the original design is so
> > restrictive.
>
> I don't understand how you can say an attacker cannot run arbitrary code
> within a process here, yet assert that they'd somehow run memfd_create +
> execveat on it if this sysctl is lowered -- the two look equivalent to
> me?
>
It might require multiple steps for this attack, one possible scenario:
1> control a write primitive in CAP_SYSADMIN process's memory,  change
arguments of sysctl call, and downgrade the setting for memfd, e.g. change
it=3D0 to revert to old behavior (by default creating executable memfd)
2> control a non-privileged process that creates and writes to
memfd, and write the contents with the binary that the
attacker wants. This process just needs non-executable memfd, but
isn't updated yet.
3> Confuse a non-privilege process to execute the memfd the attacker
wrote in step 2.

In chromeOS, because all the executables are from verified sources,
attackers typically can't easily use the step 3 alone (without step
2),  and memfd was such a hole that enables an unverified executable.

In the original design, downgrading is not allowed, the attack chain
of 2/3 is completely blocked.  With this new approach, attackers will
try to find an additional step (step 1) to make the old attack (step 2
and 3) working again. It is difficult but I can't say it is
impossible.

> CAP_SYS_ADMIN is a kludge of a capability that pretty much gives root as
> soon as you can run arbitrary code (just have a look at the various
> container escape example when the capability is given); I see little
> point in trying to harden just this here.

I'm not an expert in containers, if the industry is giving up on
privileged containers, then the reasoning makes sense.
From ChromeOS point of view, we don't use runc currently, so I think
it makes more sense for runc users to drive these features.  The
original design is with runc's in mind, and even privileged containers
can't downgrade its own setting.

> It'd make more sense to limit all sysctl modifications in the context
> you're thinking of through e.g. selinux or another LSM.
>
I agree,  when I think more about this.
Security features fit LSM better, LSM can do additional "allow/deny"
on otherwise allowed behavior from user space code. Based on that,
"disallow downgrading" fits LSM better.  Also from the same reasoning,
I have second thoughts on the "=3D2", originally the "MEMFD_EXE was left
out due to the thinking, if user code explicitly setting MEMFD_EXE,
sysctl should not block it, it is the work of LSM. However, the "=3D2"
has evolved to block MEMFD_EXE completely ... alas .. it might be too
late to revert this, if this is what devs want, it can be that way.

Thanks
Best regards,
-Jeff




-Jeff

> (in the context of users making their own containers, my suggestion is
> always to never use CAP_SYS_ADMIN, or if they must give it to a separate
> minimal container where they can limit user interaction)
>
>
> FWIW, I also think the proposed =3D2 behaviour makes more sense, but this
> is something we already discussed last month so I won't come back to it
> as not really involved here.
>
> --
> Dominique Martinet | Asmadeus
