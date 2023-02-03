Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27C2689000
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 08:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjBCHAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBCHAW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 02:00:22 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021FF65EF0
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 23:00:18 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k4so4430434vsc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Feb 2023 23:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbzT1FQNEmaS1Fq7BXjYIIpb2bUbkeqUBQhvRAmSRec=;
        b=whqTS9KQ2Wx0JsJ5jPsmKM+AcLdS/Ub9HHrPlTlWifEnh6KZ32CmAy5QWJIMD4cTEV
         jo2sk8IFKxARWQZWiv0oFzrA/KSjNVSIRWRKDTplJP6saYDN/5F/AYhE/Dt8j+MZImZy
         DO4lWxdQpox/qdCKLYsC6PbkHo9+jftXkGCoNADF4gSD3HhhPQ8GJdY/Z+mJhYZxVn6c
         6g6eFRA8L8zRzWlVWZMvHlOLqrgm7HqTwb+SBrODYteEyZIXhmPCDXVyR+QdXWZkyEbF
         jIUSyQY2qqCgN5Ws89G8H4Y+UV7Xk9KO96f3/1CFXrWXTbGr64efj1yo74rn7IQ3j3ml
         6hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbzT1FQNEmaS1Fq7BXjYIIpb2bUbkeqUBQhvRAmSRec=;
        b=7grCrGzP03z21HvjGleveY7rKHQ+LDOK1uImlf+BLIhm1DG8YRuqe9kYGT5Z08g5Kb
         c/AV3qY1LmQyTqDdWwv/r9ki4g9hFybDcGXrWTdJYw9QIUtUefJnvvtWV0xk0tkvhmI4
         BcpOMhzINPth7WOSUGWTEydUskkCjL0ZgoGMWob9nIsfpgYrapoN+v5Sk+hH2CWwYBmp
         OxGK9Eg021flSdFSjRay/dxKZJBNE8H7Mv55/Nj9Z6E2jbzvOAo8I2S+ViykZCBI5vyD
         D/EjogVnD3QtJWj6BsC3Qju1R7/fiNRm17CkNZzbrS+kJFyIjF5tZfWa5glIPrFVIfaZ
         YJxw==
X-Gm-Message-State: AO0yUKW1Gp5aBj7rryqykTowOkoYEAfRoaH6dYJXbK7NJIVmlCtAID0P
        wO8gbSNdBPbuGsi//234J9LzGPJWVYNad3zjmYu0Ww==
X-Google-Smtp-Source: AK7set8sK6QtEx/EgR0ZDaA9xoQHrr2H7fiqNNEAhOBy0YYaXP+Xe/mRMgXpV2MsalMb5tGxstdPCWShv1CnuEJq++M=
X-Received: by 2002:a05:6102:204d:b0:3f1:53d4:9e87 with SMTP id
 q13-20020a056102204d00b003f153d49e87mr1316305vsr.34.1675407616935; Thu, 02
 Feb 2023 23:00:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuei_Tr-vN9GS7SfFyU1y9hNysnf=PB7kT0=yv4MiPgVg@mail.gmail.com>
 <Y9B4/pR5t2o51coY@monkey> <CA+G9fYtt_FR54zwStiTguiyS0QDHe-x5+2Py9_hvxKAbYHM_fg@mail.gmail.com>
 <CADYN=9+=p0cYu63feXfZVXZTGruJP_i5dA3AuP0G6Fh_rfQO0g@mail.gmail.com> <Y9wxD0ngdo832Az5@monkey>
In-Reply-To: <Y9wxD0ngdo832Az5@monkey>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Feb 2023 12:30:06 +0530
Message-ID: <CA+G9fYs92bgdfYGj7uudnnnUA7hm82sggpWmSjwdKA9qjZvW7A@mail.gmail.com>
Subject: Re: selftests: memfd: run_hugetlbfs_test.sh - invalid opcode: 0000
 [#1] PREEMPT SMP
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pranith Kumar <bobby.prani@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 3 Feb 2023 at 03:24, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 02/02/23 16:29, Anders Roxell wrote:
> > On Thu, 2 Feb 2023 at 15:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Hi Mike,
> > >
> > > On Wed, 25 Jan 2023 at 06:04, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > >
> > > > On 01/05/23 15:14, Naresh Kamboju wrote:
> > > > > While running selftests: memfd: run_hugetlbfs_test.sh on qemu_i386 and i386 the
> > > > > following invalid opcode was noticed on stable-rc 6.1 and  6.0.
> > > > >
> > > > > This is always reproducible on stable-rc 6.1 and  6.0 with qemu_i386 and i386.
> > > > > Build, config and test log details provided in the below links [1].
> > > >
> > > > Hello Naresh,
> > > >
> > > > I have tried to create this issue a few times without success.  Since I
> > > > do not have i386 HW, I am using qemu_i386.  If I use the supplied config,
> > > > my kernel does not boot.  I then try to modify config options which I
> > > > think are not relevant.  By the time I get to a config that will boot, I
> > > > can not recreate the issue. :(
> > > >
> > > > Just curious if you have any suggestions?  Or, Wondering if anyone else has
> > > > suggestions on how to proceed?
> > >
> > > Please install tuxmake and run attached script to reproduce reported issues,
> > > $ pip3 install tuxmake
> >
> > oops, a typo, should be 'tuxrun' not 'tuxmake'.
> >
> > https://tuxrun.org/
> >
> > Cheers,
> > Anders
> >
> > > $ ./memfd-crash-test-qemu-i386.sh
> > >
> > > This script downloads kernel Image and rootfs and runs run_hugetlbfs_test.sh.
> > > If you have any questions please get back to me.
> > > For your reference I have attached logs.txt
>
> Sorry, I am still a bit confused.
>
> Was the intention to attach the script 'memfd-crash-test-qemu-i386.sh'?

Might be due to the emailer not allowing scripts files upload / download.

> The only attachment I have seen is 'logs.txt' which is the output of the run.

I have sent you a private email with a reproducer script.

> --
> Mike Kravetz
