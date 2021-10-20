Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D5434F63
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJTP5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJTP5t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 11:57:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C2C06174E
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:55:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so2808751pjb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/kHF6YsBF0VnFXO19L7hIupe8qJPMdaf854o+HCwfY=;
        b=n3Sfk7DBuCbUQBAVU+XdZOeEDfYz0+/5PejRxjeF5kgf5dC2r5cMA+EjmkJK66yLPf
         Ohe+vhlvv8njUtj+4NTNp3b4O8rDqAJv0TNkOJOToWwmLLNvMrG3D8B0GF4KfsAay1M8
         SVYw7YiBso2iMLaEYVb94B3+5O2eFZGC38pYqxN/vPBwzYdy7FS9NEXizjLh+zrsV6ns
         nU1oORRslCtBD+6Cz/Vi68/DPUpJFRUZw4fBJLVgruoDPvkkGM5mixxsNGicoqcx5M7D
         sxmyJnFtkbsWlTJAkn2rLQlnlOhlKdCyqBBwQGpBW7MOziZh7vRo0qAmCGcWrjhRM3aX
         XFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/kHF6YsBF0VnFXO19L7hIupe8qJPMdaf854o+HCwfY=;
        b=eMMTgEzhXa+4hDfMM9EWmH4VBjQFnSjWK6TUo3Qy/A89ICqiX6GZyjjfyN396TaLWr
         AoTXvRDhFJknd2uwd8kwizHm3WVYHxsqOWulV9gXKtSjOQ1zvSRUIF6511GKQj8ELkZF
         5GsK45VVw8vYwtN7tOrTv48TdTU/v9BEzq3jWe1bLB8RVP3xui/voIra8ZjD4/m3gDem
         hL3mmG9uOFd8tSBZKawVvAGDrm2/QnaQlLTQRJPjkPezLQ1v5xIuZsAG7nqI66qJVert
         kBGPFs26F6RTLUWmAp1bEv4Q9quiS9fPh6B8MvCYKtoY4cjPr1OYNb3ov17yvcfB0MKt
         D6HA==
X-Gm-Message-State: AOAM530Br+qyjTRWs3wionSaRgX01+zbB+f1F+sPxICK8gdA2eOP0vIj
        0Z7ifgu3JE7+68gxOYu85P0qkeXshkNDfmYZZeYehQ==
X-Google-Smtp-Source: ABdhPJzeAuq3bsrp4zGPtvJDaThlVFfE7hzvsZDkBB7AVCKsDdiOlQZSBJZzZpYrOV5jzm0t9MHyGJR16lYvshygQvw=
X-Received: by 2002:a17:90b:4a81:: with SMTP id lp1mr841396pjb.124.1634745333907;
 Wed, 20 Oct 2021 08:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211020013153.4106001-1-kaleshsingh@google.com>
 <20211020013153.4106001-2-kaleshsingh@google.com> <20211020113234.45657902@gandalf.local.home>
In-Reply-To: <20211020113234.45657902@gandalf.local.home>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Oct 2021 08:55:23 -0700
Message-ID: <CAC_TJvdOx_=CY8u02hWzxkEpipPQTk2bvb1oOtN7uoURPffsDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] tracing: Add support for creating hist trigger
 variables from literal
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

On Wed, Oct 20, 2021 at 8:32 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 19 Oct 2021 18:31:38 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > @@ -89,6 +91,8 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
> >  #define HIST_FIELD_OPERANDS_MAX      2
> >  #define HIST_FIELDS_MAX              (TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
> >  #define HIST_ACTIONS_MAX     8
> > +#define HIST_CONST_MAX               4
>
> BTW, why is there a limit to the number of constants?

The motivation was to limit the number of hist_fields that can be
created for constants. These are also indirectly limited by the max
number of subexpressions (3) and the max number of vars/keys that can
be defined, so I don't feel strongly about keeping it.

Thanks,
Kalesh

>
> -- Steve
>
> > +#define HIST_CONST_DIGITS_MAX        21
> >
