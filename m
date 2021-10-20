Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D660434EF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJTPZ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTPZ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 11:25:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E54C06174E
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:23:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t184so3293148pfd.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G/tgOu2U++uQPjqj0kkd4nYpGihFaCQehhixgnnnLM=;
        b=FdohNWF0lePfGiRKbumHGZsAGaLjjDCPzFQFJ5ok+qZV3MvXQXsTce3m8nzuOrUnOr
         HttiXl3VBBlg2SEnXtxSdhhz7nt7n32i+kurO9oz+oBp7/JUPLTfrw8bVeIzI8il5S7y
         +Su1eI0BuwtFDay0O0erLFi3b/nM3KpBQZVvhdsPE7Gp/4mGxEFqpqGmj9rBVgryz6BN
         SaPNpOoiKt0kp6fO0TlMNeoK0ocPWI1b1P11Y8XNcreX1k1KK3F385FOV+dWpZEiNGVx
         5/jrgrsNrsP+j27vJioi2jBsc8BHASyJCxdF9Sg4ljAVZm8zss22Mwm4hbaf1v0w9NTN
         w+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G/tgOu2U++uQPjqj0kkd4nYpGihFaCQehhixgnnnLM=;
        b=YYAIbLZ6eQygR9uBs2ADsSQNigvzrSz5Bv7mysOog9Khapu2oN5d2Tk73Hw7pCyaR6
         0QD40gVaFRydvWfPKKeBboQDsROoVJ/fg0Z91HZJ5LS2O+5vBa/7qgJrWLhe7JRCt8x7
         NBEnZnK35sqdnOHFr3EFZewm5BQ1P02AfnldnyU6iDENgcLMtyx5TTj7avXdVgyzGLbK
         la30Qkj9tx15Wc/dJINUCyFOHueXjWt8ObpIB7Qdad/2CWrCgyWxQt7EQEBG4xTBed+o
         6DhdZye7GNCKjV3MhC4sj7O2l1Fy+v2RZIuGzGJeuW8HOoU56tWyDD9RMtt7HszTqZvk
         l9cw==
X-Gm-Message-State: AOAM532Gz1OsqcyiYjXXVVFRohUf3fwuFSP3dUY2sth6gul/qHGK38U/
        a1HYIBDTd9QQzj/6qiM7amDNJatKKCZ77RWsDzZnUw==
X-Google-Smtp-Source: ABdhPJxMcqpB7sT6+TEBLZlfW/zH2N29UinV40wClq1lYF1N0TvyDt6Cn320FsJLqNSwctbV9rFqwmrYd7zmA3a7PEk=
X-Received: by 2002:a65:6499:: with SMTP id e25mr91668pgv.146.1634743422326;
 Wed, 20 Oct 2021 08:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-3-kaleshsingh@google.com> <20211019222756.1fde436b@gandalf.local.home>
 <CAC_TJvcZ4ndpQpsj4ANj9LpzSu6GfPSdxpVc0XShbi9u_bSUyw@mail.gmail.com> <20211020111301.0032a43d@gandalf.local.home>
In-Reply-To: <20211020111301.0032a43d@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 08:23:31 -0700
Message-ID: <CAC_TJve8pEHSvPAWecX9Lx04q7_bWd2izv=5FJLc=3vSKiDnZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tracing: Add division and multiplication support
 for hist triggers
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

On Wed, Oct 20, 2021 at 8:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 20 Oct 2021 07:54:59 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > Is it worth adding something like this for the multiplication case as well?
>
> No, multiplication is a pretty fast operation, and the added branches to
> test would cause more overhead than what you would save. But, division is a
> very slow operation, and I believe that even with the extra branches it
> would still help.
>
> If we do this, it should be a separate patch anyway, where we can actual do
> measurements to see if there was an improvement, and revert if not.

Sounds good. Thanks for the clarification Steve.

- Kalesh

>
> -- Steve
