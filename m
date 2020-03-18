Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFDD18A08E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCRQfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Mar 2020 12:35:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36114 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCRQfp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Mar 2020 12:35:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so4124874wme.1;
        Wed, 18 Mar 2020 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfLgkduxAp4htlcsfGDuWI+s08y9/Umq76QtG5EHZo4=;
        b=seeTap8Uk34sP2mcmhqFEpQzmySl1rVKeAk1WlRql7aZSJrsgsJG/+D+ntVqrpr6G6
         dpVftFu3J+okk26645m2qhf9RSx2tW6PT6Q01EDveayk/L4vuraRrGahE+H5PPJWV5cV
         eIfiK0B4b/z44Z0kcTNVZGG/b69Jk5eWmP245eEUhZlxDMaCVltq+3OKQb8KR8dztJ9D
         5Dgstbz6UQ/DA4ZE12dDwLc6nnC9FVxEX1nxNcmWDTOMp8AxW4wTRdaCe4S6nYnMnie1
         nHz929WnBUO/IQyXuTzvadIPCg/diwct/UCSGMVMV9+AvaXDfEDoqD3WBkMAsCG+qNto
         y4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfLgkduxAp4htlcsfGDuWI+s08y9/Umq76QtG5EHZo4=;
        b=E2Yi/8gedy5ZrGLbRxaZ0OTl8nub3IgXiS+ofNTBKFT6O+mykJk52/w+czdSp7G8DX
         yKDTddSM90Vm+r8BynW6MhptEXaPHQsdtGDG545nA68hawUiN3kY0bPTTq46zulLtUlN
         X31i47+wZw8wE0118F4AKsUlcTB/xSskEh+/wivPX7CK9Nju9hWeuoMWPQYuutkHMinq
         +OMvaVBodJJSgWsaCDYWjRWwgoZOBn5VFMj6cVgLJasnxYZNdud07FvRkKCR3dY0fZDf
         7AXG9FUWQOyXKmxYgMm4Tsq/BWfskmz9jbfmxgK6a1N4gnGAw+QBcyWQIK6a2F1UYHE9
         VPuA==
X-Gm-Message-State: ANhLgQ3xb9YGbs2rRQXtlvH/pTnW42lyArssO2oeueWtJJVJpOi+bS5h
        qjJCYiFOkZ+S9APnz3i6FOo3+T9pIddC6EzyX60=
X-Google-Smtp-Source: ADFU+vu2QWQkKBtflBTFuidPm1/T1qvuW/Ss7fkj1Lg/0XjTaiO4xSCscQo9uSKn4ue76Y1f9vZtrFyGoxKICkAGlvA=
X-Received: by 2002:a1c:2504:: with SMTP id l4mr6225840wml.72.1584549343920;
 Wed, 18 Mar 2020 09:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200317213222.421100128@goodmis.org> <20200318111345.0516642e@gandalf.local.home>
In-Reply-To: <20200318111345.0516642e@gandalf.local.home>
From:   Shuah Khan <shuahkhan@gmail.com>
Date:   Wed, 18 Mar 2020 10:35:29 -0600
Message-ID: <CAKocOOPBiHsh6Y6gVcwcaUOv7CD=eqtKM+-6L23WzuCnUyR26A@mail.gmail.com>
Subject: Re: [RFC][PATCH 12/11] selftest/ftrace: Fix function trigger test to
 handle trace not disabling the tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 18, 2020 at 9:13 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The ftrace selftest "ftrace - test for function traceon/off triggers"
> enables all events and reads the trace file. Now that the trace file does
> not disable tracing, and will attempt to continually read new data that is
> added, the selftest gets stuck reading the trace file. This is because the
> data added to the trace file will fill up quicker than the reading of it.
>
> By only enabling scheduling events, the read can keep up with the writes.
> Instead of enabling all events, only enable the scheduler events.
>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

+  linux-kselttest and my LF email.

thanks,
-- Shuah
