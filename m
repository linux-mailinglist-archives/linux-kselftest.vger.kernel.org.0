Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4053E43D997
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 04:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJ1DB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 23:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhJ1DB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 23:01:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FFAC061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 19:59:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l186so4957014pge.7
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qcGlXwseyhQvDxLjOR5ajAV6VxNHCsQF0+nodus9VQ=;
        b=n911yFUNLpyC7fYO2MLdIAmD5pOTKRgjP3CUghSF3cxrpv4/jRNUHSilbGMZIYsQNa
         okuTcxZnouwUvdFIeBYNtp7a0F4FSjufGY/c6YC8mDZYgv4fZAx6DWvBnQmcQiQ9scO6
         1HZE90E/8AlrGD5cYqgV7ohdnzYCwMBrAVx2/0veOr0zQ6WIH5Elqmh6tNNAL1UdBPJG
         vdS5jHxiIPem++trLFW+YqX9CV1Ed8u6qk5JGu6Vc5Pa7wmkt8BruyewYvHskbEHfA2s
         Vt223zhuX/WlC6aRrr/hyHcuV/IqXMazlU/0hSwFrnvVIj4S+/eIQSIi6WLuU3KkRaeE
         HrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qcGlXwseyhQvDxLjOR5ajAV6VxNHCsQF0+nodus9VQ=;
        b=a1p1OA+0P3aMVSZrczjIZT/V98fbD9UgRdWr+0vKfxvov2x9/chwkcPqOcDXtMIhMP
         Ax47Ct51pAlxkIh09QEyYwNSw1d0sX96Zx2N45gTR39JjSoZNSQYZLCZCL6yQkn3C86H
         +5Sk20cuAeGmzUjud4AmeoI6vjhF1fGanetX/ddWOiBkTVscG18o7bqlZRLCC373PRz8
         vgEV1ZegWiSXl72kmg7aipQIN+hTfjtV85D2wQjL++uY2scDQd0nTzu6Tf/KYwhoeY1U
         YIfCOPX14o3n4sxBtM+o8/WRueLD9RnpMMXkGhoPJ/0AJcNFXw30Od/3jacBcfUB2SRn
         8wNg==
X-Gm-Message-State: AOAM530ZNXAdMtjrd6F9uDktoJCMxBPZKyuTZlCc3kxRLZE1ZaTB/sQa
        mG6Hw9dhyrotnVCvn87IVjd2DLd1WuzA8dMHd+WH1g==
X-Google-Smtp-Source: ABdhPJzu5KK1MQDGOIwEN7uCtY6OI9kdjFI43cChJxiLrJ6wWdf+kC9i+RjLlJX1ycTzqLzn986Ja3YtUQlKIopNPJ0=
X-Received: by 2002:a63:618d:: with SMTP id v135mr1249184pgb.79.1635389941763;
 Wed, 27 Oct 2021 19:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
 <20211027205919.1648553-3-kaleshsingh@google.com> <20211028065849.76b1bd7151e440881298b523@kernel.org>
 <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
 <20211027195454.60993c83@rorschach.local.home> <20211028094351.617b7c2ea7c56055ee68d909@kernel.org>
In-Reply-To: <20211028094351.617b7c2ea7c56055ee68d909@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 27 Oct 2021 19:58:50 -0700
Message-ID: <CAC_TJveUiij8SQwfHVOYhQASq7bd0PUbyu7k0QLh-8S5ttC+wQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 27, 2021 at 5:43 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 27 Oct 2021 19:54:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 27 Oct 2021 16:26:00 -0700
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > > > Why don't you use 'tac'? I love that idea :)
> > > > Did you find any issue?
> > >
> > > Hi Masami,
> > >
> > > Thanks for the reviews. As with the first set of patches using tac
> > > gives a regression here, though I'm not sure why it doesn't work -- I
> > > also thought reversing the order would handle any dependencies
> > > correctly.
> >
> > Right, because are triggers not added by list_add_rcu() which adds to
> > the head of the list.
>
> Oops, so are the triggers shown in the reverse order?
> (newer entry is top, older one is bottom)
> Then do we need this patch, because we don't care about the
> dependency.

In the case of the hist expression tests. they create a variable:
echo 'hist:keys=common_pid:x=1+2' >> trigger

Then print its value in another histogram:
echo 'hist:keys=common_pid:vals=$x' >> trigger

At least in this case, the triggers are listed from oldest (top) to
newest (bottom):
cat trigger
hist:keys=common_pid:vals=hitcount:x=3:sort=hitcount:size=2048 [active]
hist:keys=common_pid:vals=hitcount,$x:sort=hitcount:size=2048 [active]

So we need to remove the trigger with the var ref first.

- Kalesh
>
> > If anything, shouldn't things be removed in order?
>
> Hmm, I think the trigger itself might better to be changed. If any dependency in
> the trigger list, it can not be restored from the copied file, like
> below may fail.
>
> cat events/foo/bar/trigger > /tmp/foo.bar.trigger
> cat /tmp/foo.bar.trigger > events/foo/bar/trigger
>
> (of course we can use 'tac' to restore it ...)
>
> This is
>
> Thank you,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
