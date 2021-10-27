Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547443BEDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhJ0BSM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbhJ0BSL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:18:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A7C061570
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:15:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q187so1300837pgq.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOM1t1mdsB+vMIZOqpURx1Aj73if+RCOkMBAhH7ofr8=;
        b=nYQoGCN+iMpFRaTFW/grBCxnwnU7DV72AjYMkfoswZBVwu4VoaMY2zac0p8Uq8mBle
         WYimfrc0mfs9ZHRINzzZM0Yj9Gj35y4ZxRKc2sZaUOw3KfxpnimTiG1aQ6bhc/LK2S7K
         FvOA6hhPr6qgJ8JnXNmXjcit75eqhMPhsiUlEZJn99y+MvC2umdaX1kcQnbgCjP+x+tD
         xu8tEHfou40vzxdTihhE70AUBygBz0M/0fOeb81G34DPNL5ia9hZlFcTTSV5xPXx6fHX
         uxyXCdrpvq7/gSLTwzoGRs6fxeHnYkOIQ5q2bao/Gjt2TXmZF218tmO7U97GRy6Y2DbX
         UWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOM1t1mdsB+vMIZOqpURx1Aj73if+RCOkMBAhH7ofr8=;
        b=IwE9LaT3246aEIIZMG46ffsSLcxUWwvFxLihxTbiLr70wuPTuDbtJz/R9kmzKpuuU+
         1OUuErWxGgZCP52t/IrTTSh9B6rWVJgum/Qv+gcStZD55wjk9P5FILB6kmYdEivf8K8S
         36hweRyGJbiW5EW3yDjh4lbs3TIoYlLipvjjqMqrPRSb1rTnj1sTV3Jx+T7HV2m7RE8t
         troPF14qAKA1M0bdnAuspWTH4t8SbnCDVqLG3ZvMnhJGHH3gh80B7ftXz/g/dEl/DKE9
         ow9gZd+IalXV9lEp2gI3m18vaZ0hgRRlGJQW/Fw/l796Qhq7Xbs9fGwbHRVxK0Hn3mCH
         FZkQ==
X-Gm-Message-State: AOAM533o9EJwbxzdj11R3U2L0GuUZqPHNV3rMS+LO93BSaIm3wtfRTru
        TTYFUt1eIjaPAOfksL1fBl+t971nCcMlge9UmK4n4w==
X-Google-Smtp-Source: ABdhPJw3HM2ttj24uXzv1jjaRTP+7zt82rESebmzg2uoIpU0RY2pwWx5+jQ2AWdGwdXbHAUl+V/qgzntWNV8ms8J1rY=
X-Received: by 2002:aa7:8246:0:b0:44b:4870:1b09 with SMTP id
 e6-20020aa78246000000b0044b48701b09mr30086990pfn.82.1635297345864; Tue, 26
 Oct 2021 18:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
 <20211025200852.3002369-8-kaleshsingh@google.com> <20211026214311.583c728d90d41778c38201dd@kernel.org>
 <CAC_TJvfQQCyuSZqjzC0fuAah84uLgHJv5T+WtR8=9h5fN9nrLA@mail.gmail.com>
 <20211026174420.0056bde2@gandalf.local.home> <CAC_TJveMumb=BkGL53d_rS08uQ35fz1B7cM9jp8eKoCz0MUG_Q@mail.gmail.com>
 <20211026202020.026e7907@rorschach.local.home>
In-Reply-To: <20211026202020.026e7907@rorschach.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Oct 2021 18:15:34 -0700
Message-ID: <CAC_TJvf8areGd1rQMbJV4r+J6JP2-DWXBLQwKRZEOzNWL_rqrQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 5:20 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 16:36:03 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > On my setup I without any of the changes applied (config hist triggers enabled):
> >
> > ./ftracetests
> >
> > # of passed:  41
> > # of failed:  40
> > # of unresolved:  0
> > # of untested:  0
> > # of unsupported:  32
> > # of xfailed:  0
> > # of undefined(test bug):  0
> >
> > Do all the tests pass for you, before any of the changes in this
> > series? Maybe some of the tests need updating?
>
> All my tests past, and I don't push any code if they fail.
>
> I'd like to understand why you have these failures. Are the test from
> the kernel you are testing?

The results are from the kernel before I apply any of the patches. I
am testing on an Android emulator (cuttlefish) with 5.15.0-rc6 kernel.
The tests clearly work so it must be something on my end. I'll
investigate and get back to you.

Thanks,
Kalesh

>
> -- Steve
