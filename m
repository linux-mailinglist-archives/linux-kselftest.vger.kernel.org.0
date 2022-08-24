Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5759F333
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiHXFvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 01:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiHXFvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 01:51:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EC8983A
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 22:50:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i77so12593387ioa.7
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AC7zCaF3e8Y+iHmuxARbY9jPts0EPE4BM5zbxUNhoek=;
        b=dDGkvgzoflDmqWDoHb48wLOOAS1PQAqS5JRc+aY/3J/NRzkRHugIWZ67703oSCDJAP
         MU89etvAPwtSuig/F6UsnBBPEyRODvTmo/qfxb4HtLucIbtlqNCo6w3r25lkDOpSb/u9
         iBSOYvHDhbSaGDeFrimVXcyYU2g7OhhpSbmcnB7NB7HVPh4Qw1kp0EMfkFchF+1pBco2
         aX6+pZ+tfwaGVXAQ5Qcu4suv3M31YH6dot3T4NKx1bGtN1Xi1D1qT+/cX86Rd0tfsieU
         eZNXZnT702X6vv6mLwEoYb3uhzyIJ9n1SgaumaXKWtI35yjaPq7kvi+aDE8QwFne2tcw
         dKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AC7zCaF3e8Y+iHmuxARbY9jPts0EPE4BM5zbxUNhoek=;
        b=mJWPkjUtZSUgPgaFvzWgqQtKBykCUVvlhKFWtDAbQioGDNJ+7AFi83iqSg/IwQ32ue
         8NZs96r/1v4D4jmTURdtW7Z8V3PJB/bXKJ99NgHp0q0sOq3hPwdTjJ2ndgkVrbZd+HZh
         9TE5stvLsW7SGRNMMWVJ2ZiuwfG7DRDoUgJSiVi5hWf8igv3wXGBo1XfNnCWffsgTLwb
         IBIQ46/bb2d7eLdaD9zjxMZb605lEVV/hLotXTsB4CiGmx9gyTjBQClYx285uJVeGBfF
         oSG7HCq5u44NITDrxaqWIUhDpaH+jknOVefqny7Ic1foFFOLXNDdx7VDmdQulm4yubvV
         mSVA==
X-Gm-Message-State: ACgBeo15u+YbA+KhuTAuUX2vM3fZJlgp4rqXBV+iYZyuiRghFusuhEeK
        7igxxuEyjhxcjf133/7s8gta1S5x23odBxWNJrF8/zfb7+oOGQ==
X-Google-Smtp-Source: AA6agR72tjvf/Lk7mASJIUYOIujsj/pk0L0uiHQFWZ0A0yMSn6X8gEoBJezHh/k+tO0XnGTlYUyXQ3YRs1IZ3jdKcho=
X-Received: by 2002:a5d:8988:0:b0:67c:625:ee3 with SMTP id m8-20020a5d8988000000b0067c06250ee3mr12484340iol.150.1661320244042;
 Tue, 23 Aug 2022 22:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220823211958.2519055-1-adelg@google.com> <YwWx07EbaB90jDUN@kroah.com>
In-Reply-To: <YwWx07EbaB90jDUN@kroah.com>
From:   Andrew Delgadillo <adelg@google.com>
Date:   Tue, 23 Aug 2022 22:50:33 -0700
Message-ID: <CAEHm+vHHRLW1c2fhrgCx0Nh63udxMLCSwone-JTm22o2Q37abA@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add a taint selftest
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Sasha Levin <sashalevin@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 10:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 23, 2022 at 09:19:58PM +0000, Andrew Delgadilo wrote:
> > From: Andrew Delgadillo <adelg@google.com>
> >
> > When testing a kernel, one of the earliest signals one can get is if a
> > kernel has become tainted. For example, an organization might be
> > interested in mass testing commits on their hardware. An obvious first
> > step would be to make sure every commit boots, and a next step would be
> > to make sure there are no warnings/crashes/lockups, hence the utility of
> > a taint test.
>
> What's wrong with the tools/debugging/kernel-chktaint script?
>
> Why do we need another "get what the taint status is" program?

The main functionality that this selftests has that kernel-chktaint
does not is that it exits with a non-zero status code if the kernel is
tainted. kernel-chktaint outputs information to stdout based on the
taint status, but will always exit 0.

The issue with this is that it cannot be plugged into a test runner
that checks the exit code of a test script. In other words, if I
wanted to plug it into git bisect, I would have to wrap
kernel-chktaint in a command that transformed the output to an exit
code. Sure that is doable, but it is not as simple as it could be.

More concretely, I am setting kselftest runs against kernel commits
(with a harness that logs kselftest runs into some other
infrastructure), and such a test that is missing is a kselftest that
checks the kernel's taint status. One could argue that one should just
create a kselftest target that calls into kernel-chktaint and parse
the output there to determine what the exit status is, but that seems
fragile as a change in the underlying script could break it. For
example, if I want to test for taint #18, and I am grepping for the
string " * an in-kernel test has been run (#18)", I will actually get
a false positive because the underlying script does not check for
taint #18. Contrived example yes, but I think it shows that textual
grepping for errors is error prone (as an aside, I'll send a patch to
update the script to check for the new taint bit).

> thanks,
>
> greg k-h
