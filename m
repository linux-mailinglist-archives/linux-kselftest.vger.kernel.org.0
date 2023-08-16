Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7577D9F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 07:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjHPFpR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 01:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbjHPFoo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 01:44:44 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C494;
        Tue, 15 Aug 2023 22:44:42 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 76401C009; Wed, 16 Aug 2023 07:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1692164677; bh=4gbF64ZAps2tu8Us8hVmy7bZFfqOLG3YAt1/kY1ChvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxpolGnipyoWx6NOs1Wo2RpVLOc+yxa4jjFF12DjfWBz8Auah8rAfmB8pHTN3YuGu
         eLs5+UdNOMA9lhc71/oJTy2R9g1UIO11cPq2Z3tkaFLxJ8ytoyZ1pVn6wYv0CqbjFr
         QpIfTqw060s51OxpvNjQ7V49+nI3W2kebtvnxWk2IDtleiW+HeT/l/ukow9vtA+qRD
         vk8aWqdxw5A0qVyTGqm7i3CwvQY5nlCPAJH/04DeMhfpdFUmnOlmz9lFpuk6tOvyLG
         lgvW9zea711VF9wFQMFXnZbbkOe8AalL/QbxF4gTQAC1p1k/tUxJlwSAyQ8RPrBpiB
         Gik41FMsf2v9Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2C5C1C009;
        Wed, 16 Aug 2023 07:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1692164676; bh=4gbF64ZAps2tu8Us8hVmy7bZFfqOLG3YAt1/kY1ChvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Le9BCk3BgokIeFhQZ+E2qn5OLRfVeXZzjZj6lNANgyEGwg69oTq4rzoHh3BlR2+ky
         VK9y9v0mZn9j0gHRq4yv8ICwuk5hMQqiuVQv1K7ifIlEASm3suPqJ8iJLyHZVw4yDL
         mAWxPdPvf505aXF6nXW8ZOLxRLR9y/01xn948nv0roYzxswTm08gkUYHE6offRFNMr
         ANBAlzKf0paytsaUQdQ2/XLSVoIwjgEsXq4IAIGcnXPkoCpzDSwfk8t8Wm/4tyKCNM
         ect0SxgtjREzw1KK+2kTc+huXX6/Xf0xmSgO9ulctpEPmqUgJpVa0OFv9UKN8Doo0g
         p2bvpBnLDL9ug==
Received: from localhost (odin [local])
        by odin (OpenSMTPD) with ESMTPA id 014ee523;
        Wed, 16 Aug 2023 05:44:28 +0000 (UTC)
Date:   Wed, 16 Aug 2023 14:44:13 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/5] memfd: replace ratcheting feature from
 vm.memfd_noexec with hierarchy
Message-ID: <ZNxiLe_jkXpxh3QU@codewreck.org>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
 <20230814-memfd-vm-noexec-uapi-fixes-v2-4-7ff9e3e10ba6@cyphar.com>
 <CALmYWFvxLee5+RyLh=vo6kpwMVS-_C7BJ9kmTPDa2tetgHOHPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALmYWFvxLee5+RyLh=vo6kpwMVS-_C7BJ9kmTPDa2tetgHOHPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jeff Xu wrote on Tue, Aug 15, 2023 at 10:13:18PM -0700:
> > Given that it is possible for CAP_SYS_ADMIN users to create executable
> > binaries without memfd_create(2) and without touching the host
> > filesystem (not to mention the many other things a CAP_SYS_ADMIN process
> > would be able to do that would be equivalent or worse), it seems strange
> > to cause a fair amount of headache to admins when there doesn't appear
> > to be an actual security benefit to blocking this. There appear to be
> > concerns about confused-deputy-esque attacks[2] but a confused deputy that
> > can write to arbitrary sysctls is a bigger security issue than
> > executable memfds.
> >
> Something to point out: The demo code might be enough to prove your
> case in other distributions, however, in ChromeOS, you can't run this
> code. The executable in ChromeOS are all from known sources and
> verified at boot.
> If an attacker could run this code in ChromeOS, that means the
> attacker already acquired arbitrary code execution through other ways,
> at that point, the attacker no longer needs to create/find an
> executable memfd, they already have the vehicle. You can't use an
> example of an attacker already running arbitrary code to prove that
> disable downgrading is useless.
> I agree it is a big problem that an attacker already can modify a
> sysctl.  Assuming this can happen by controlling arguments passed into
> sysctl, at the time, the attacker might not have full arbitrary code
> execution yet, that is the reason the original design is so
> restrictive.

I don't understand how you can say an attacker cannot run arbitrary code
within a process here, yet assert that they'd somehow run memfd_create +
execveat on it if this sysctl is lowered -- the two look equivalent to
me?

CAP_SYS_ADMIN is a kludge of a capability that pretty much gives root as
soon as you can run arbitrary code (just have a look at the various
container escape example when the capability is given); I see little
point in trying to harden just this here.
It'd make more sense to limit all sysctl modifications in the context
you're thinking of through e.g. selinux or another LSM.

(in the context of users making their own containers, my suggestion is
always to never use CAP_SYS_ADMIN, or if they must give it to a separate
minimal container where they can limit user interaction)


FWIW, I also think the proposed =2 behaviour makes more sense, but this
is something we already discussed last month so I won't come back to it
as not really involved here.

-- 
Dominique Martinet | Asmadeus
