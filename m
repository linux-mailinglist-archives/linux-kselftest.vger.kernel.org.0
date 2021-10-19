Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23644340CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhJSVv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJSVv1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 17:51:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284EBC061746
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:49:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s136so17394423pgs.4
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Oct 2021 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiAYKXU6LKvLzjanHYWWmXBFY+iSjfiEc6TGGYBBgEw=;
        b=fWgHoUbXW88bErHyyMVe6LR3APM6ahymvSBseUQqdQzqNkt+VvsesPzwO4RHFaBlij
         bR+sKZTBVng5lqEvY72dla3yX2mjO8Gt+0AXLjwpbl4jo26VgWOXR1irR1iKCMlkNbC0
         WdSziG/GI9LQnckxhbb+CnFrXp23KZdCwfl9T1asOJ+fnvyB0SiNuOnYqzgpPN+9E+Ma
         ttMFTp8x3CijvS2K73aQIgiNaTDVcnjVVUNIlWlip82kANLzZmDf1Tyk+pxX5WdbfP5z
         uwBvFEVPswtN+iXY5L7p63bbFAJnxlq/iOGSfjGO6+BeN94nZonUF2VIOsn5XLuPYW36
         jY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiAYKXU6LKvLzjanHYWWmXBFY+iSjfiEc6TGGYBBgEw=;
        b=rHw53rcWSTOqVmgKqtP4wvixVntj4vdKKfpHLdHLaA0EQxjdaUEGny21NTnJgOxVIH
         n62oshTQMURfx+YOG6Wj2m7CY7QvGg8TXgm45WwpeowouljIQJaACbc60P2EBsuUPruS
         FT+mknmDmsV/ZL8mKJ7nR0Zss54UVNp4DYWOnIFnZiVp3SJy0cIn21spoJ+zI+fsMr3Q
         aifo0pbPFT4lA8uQMrhT+Uvduo4CvvQWRUg+/T2jFj1qsy67wyOT7V4zuOfqJWHXBabK
         TWcDshxBK8W6f+DLq5AE/lR6DjLaZtleJMJXoyDOU8L70c4/JMxPTYxLPU8R/aEOFThv
         Sx5g==
X-Gm-Message-State: AOAM533AeL3hav2zY17j62n8hNiFiGal5y3CCFAMFt/rsCJZiF5kLjj9
        AM9daIT02nMsXisfFFJdviXfh4GCAzzXmqRsHVShOQ==
X-Google-Smtp-Source: ABdhPJzO56j6stRSQaNbz97xoiOoYnHEVGX7T1UKCAYsxRNSP7iPGeSgEpd1t0abktKdfZIyPYIfrsF0oddX0anc/z4=
X-Received: by 2002:a05:6a00:b95:b0:44c:7c8b:f762 with SMTP id
 g21-20020a056a000b9500b0044c7c8bf762mr2429192pfj.60.1634680153440; Tue, 19
 Oct 2021 14:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
 <20210915195306.612966-2-kaleshsingh@google.com> <20211019164834.465b2a53@gandalf.local.home>
 <CAC_TJvfT-1SeEhDnVjRfcv1SjKmZbcdy=cBVXYeB1GLTv+=e+w@mail.gmail.com> <20211019172600.0f211c98@gandalf.local.home>
In-Reply-To: <20211019172600.0f211c98@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 19 Oct 2021 14:49:02 -0700
Message-ID: <CAC_TJvf63YUZ50PRJaaWSKLaOC_XOag4d7iTM0Lx+RB6qqk-ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] tracing: Add support for creating hist trigger
 variables from literal
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 2:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 14:21:04 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Addition and subtraction are already supported operations. The use
> > case given in Documentation/trace/histogram.rst is for calculating
> > latencies. I don't have a use case where the constants may be needed
> > in the addition/subtraction, but for simplicity and completeness we
> > support them for all operations.
>
> Perhaps we should state that it's mostly added for completeness then.

Good point. I'll update the commit message to clarify it.

Thanks,
Kalesh
>
> Thanks,
>
> -- Steve
