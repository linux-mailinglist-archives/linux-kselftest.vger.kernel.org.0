Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E99434E95
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJTPIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhJTPIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 11:08:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B09C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:06:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v8so3189325pfu.11
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA5LDMLmQNAk4mwbdEDR73f2u+dlkeGRsK+VXTs6ThI=;
        b=qw0BgtZf/0TzG5SWIZCjab5Al2kESh2kxIpGfkr6TDKXJZU6o/MsqgiR7dsR84o5CD
         zNojPvHgJOdIPYTtXIczvYFyhqVQsH0cpLBzqOEa2AB+UeC2GyoYaabJ/xohhIendpuC
         +diUEFPxJMiNRN+OZrTkpY0as7zQcor4Cz4dKD2hYCR1oUbUE5z5wKzNLgjbNLBSD9Qs
         gLKdzvEwnevqbfqOReLyXugBaxsi3q4ie4OGwhOWF15zfHLaIOaeWaIk2cAMA89ju1Dr
         2Gg+lu0sOyewXKe/TWhFIwBHcaSzsu4gLVqlLA2HUptThhmpgsMx3evpjdII3cW4jvu1
         19Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA5LDMLmQNAk4mwbdEDR73f2u+dlkeGRsK+VXTs6ThI=;
        b=k2WAe0qa7WuWl7TSo/wiLyApsY2fTBSoLBarM+QizZo7oCMCL/zFr65r3Iut0zL97G
         n+ovlfdI2AUrqtfp09VReprjeZKsWqa9a2mse9Z3GJ+jpvK1tFusCf5gGhVAZNE+RonU
         ZLc2DPw6zLMz1IRhhTeItPmuhek0BwjDxQXzw1lXExy1xWXg9wT1KH2zW6jkF9kuE+9w
         3a/xTof0p4PP6ngejBks4/YLvqQaMaNFZbgIpk3Rtq/tSvZyfkcxG3xUpgFroCkpCPET
         RLVJh58j8BlshLQPer7AeO6FvGJ2LUX19v36uKSBqEBhfH8eb/dcj4RamjA7Sp8Rfv21
         K/qw==
X-Gm-Message-State: AOAM5327UPFJWS7wtCeXn/WR1O8jNld2j2lws8TpVXTNAEiSf0WRwLww
        Dnkz/eXjMVtxrJK1hOxt+y2FDqoogC93Ei+C+axSSg==
X-Google-Smtp-Source: ABdhPJx2ufcue5ufHjxLV9BXDHmvvqB9AgktcirsLSNc4Zb83OhPq/SFmJcQhb4c46ewzF3bn9I+pN4OZXyqUA0BkcM=
X-Received: by 2002:a05:6a00:17a6:b0:44d:df1f:5626 with SMTP id
 s38-20020a056a0017a600b0044ddf1f5626mr274186pfg.59.1634742396800; Wed, 20 Oct
 2021 08:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-4-kaleshsingh@google.com> <20211020102807.0b07bc81@gandalf.local.home>
In-Reply-To: <20211020102807.0b07bc81@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 08:06:26 -0700
Message-ID: <CAC_TJvfQCjZPS50-k2Pxo0jCcfxQ7oa1MZxQdADyjnwQ_TBzRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist triggers expression
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 20, 2021 at 7:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 18:31:40 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > +     minus_op = strrchr(str, '-');
> > +     if (minus_op) {
> > +             /* Unfortunately, the modifier ".sym-offset" can confuse things. */
> > +             if (minus_op - str >= 4 && !strncmp(minus_op - 4, ".sym-offset", 11))
> > +                     goto out;
> >
>
> I was thinking about this, and perhaps we can add this later, but we could
> just replace all ".sym-offset" with ".symXoffset" after receiving it from
> the user. Then it won't be an issue during prasing.

That's a good idea. It would clean things up a bit and avoid bailing
out if the user has a sym-offest in an expression string. I can send a
separate patch for this.

>
> -- Steve
