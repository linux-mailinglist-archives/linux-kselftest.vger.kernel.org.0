Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4166185269
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgCMXgg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:36:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42644 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMXgf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:36:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so5901520pgs.9
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd46IjK0yt6XO4QbOjAhJTVOuU89Qv/mYd0OnSTaqqU=;
        b=TzqBcARbIEe1MXAyG/voQg5JT04CeA+MLX+H8A5ZD2w7Po+wO2rZvmgzQg8Y67qBmh
         cCOAvsJZeRtxbT2rPswjcZVrFA8ILE/hnRAeNv5+zWsTy3BvSP6TUzew7Qu8DosKL5Vx
         CG1NQVuV+A6yHtcHoYjquf+mGZc2346Ekt0HPPd6Mi5H3kWFneB8R7H4DgbPnwy1Xob7
         v3vNSN97R1en00gwOA3MKshxyeApuQrAu+0CLoteNVYyPsoQ9VPyjcmxWTmSjkduYAhB
         JGjCCTBWkEuHNOvr9Tgd7CpwU1bc23IHTuc/c+FVm60NAxOfLgbgz/kkcMK/Mkh5bYAC
         m6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd46IjK0yt6XO4QbOjAhJTVOuU89Qv/mYd0OnSTaqqU=;
        b=X//oA6JBlf62gLkjyAWBJ6L7JhQvGMb9R6iFcIsG706Pp86J6i5DUrFP7wSDn3m6cJ
         q78LImgzMMLNrxNyfH9vJLkdLgarGyNFda/equl+7oXlWcFKF90+LKj1Qlto4nRgDfaL
         exW2RNDlC7pll7kgceVUPdc5inv5gOPKAj1GsjX3xOz72hxHC9jvy/lGpn1ZdNdDyudK
         sDBhsXDx3kLYiqUZy8+Mo1yHhOCRwVsW4F8OT5vavucEPn4EsyC+tbi5eZPNeFJTJrn9
         fVepCpsowtA/pWUrzo18luqHX8pgrh65dzQnD5hFBDtS7X4d6jagy1wn8zeW/hh6Izjf
         9XBw==
X-Gm-Message-State: ANhLgQ1JDDuds6fThvHO14TwvD5r+kztmpMgzgwbey3kn7Nr1LwC6Eav
        gAlMrfzdIf00icfZmhgFLV3MYWq9M8CQAYZcbzeK/A==
X-Google-Smtp-Source: ADFU+vuPGMOBQ3z8n/rq9B/aDhOBpRIqAjYEM7FF4sWCjC1HFmv002fpapxfNj8+wxSu7fimilu0kTczHUAGvKiGd5c=
X-Received: by 2002:aa7:8283:: with SMTP id s3mr16224344pfm.106.1584142592983;
 Fri, 13 Mar 2020 16:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200228191821.42412-1-davidgow@google.com> <dd15aa59-d2ef-d42e-1a4f-82b42e2ea350@gmail.com>
 <ec2f35ef-54d2-cd67-5e30-33ce7612a6d4@kernel.org>
In-Reply-To: <ec2f35ef-54d2-cd67-5e30-33ce7612a6d4@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Mar 2020 16:36:21 -0700
Message-ID: <CAFd5g46DnKGXNzUe_om+f+kc6efKUP5PFZHwo1VcN6PpWJGicQ@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: kunit: Make the KUnit documentation
 less UML-specific
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frank.rowand@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 9:05 AM shuah <shuah@kernel.org> wrote:
>
> On 3/2/20 9:50 AM, Frank Rowand wrote:
> > Hi David,
> >
> > On 2/28/20 1:18 PM, David Gow wrote:
> >> Remove some of the outmoded "Why KUnit" rationale, and move some
> >> UML-specific information to the kunit_tool page. Also update the Getting
> >> Started guide to mention running tests without the kunit_tool wrapper.
> >>
> >> Signed-off-by: David Gow <davidgow@google.com>
> >> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >> Sorry: I missed a couple of issues in the last version. They're fixed
> >> here, and I think this should be ready to go.
> >>
> >> Changelog:
> >>
> >> v4:
> >> - Fix typo: s/offsers/offers
> >> - Talk about KUnit tests running on most "architectures" instead of
> >>    "kernel configurations.
> >> v3:
> >> https://lore.kernel.org/linux-kselftest/20200214235723.254228-1-davidgow@google.com/T/#u
> >> - Added a note that KUnit can be used with UML, both with and without
> >>    kunit_tool to replace the section moved to kunit_tool.
> >> v2:
> >> https://lore.kernel.org/linux-kselftest/f99a3d4d-ad65-5fd1-3407-db33f378b1fa@gmail.com/T/
> >> - Reinstated the "Why Kunit?" section, minus the comparison with other
> >>    testing frameworks (covered in the FAQ), and the description of UML.
> >> - Moved the description of UML into to kunit_tool page.
> >> - Tidied up the wording around how KUnit is built and run to make it
> >>    work
> >>    without the UML description.
> >> v1:
> >> https://lore.kernel.org/linux-kselftest/9c703dea-a9e1-94e2-c12d-3cb0a09e75ac@gmail.com/T/
> >> - Initial patch
> >
> > Thanks for all the changes.  The documents are now much more understandable
> > and useful.
> >
>
> Is this ready to go? If it goes through doc tree:
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>
> Otherwise, I can pic it up.

Yep, looks good to me.
