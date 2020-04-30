Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142971BEDD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Apr 2020 03:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD3Bqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Apr 2020 21:46:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53012 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgD3Bqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Apr 2020 21:46:52 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jTyHp-0003HS-Ma
        for linux-kselftest@vger.kernel.org; Thu, 30 Apr 2020 01:46:49 +0000
Received: by mail-lf1-f69.google.com with SMTP id a14so1582058lfl.15
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Apr 2020 18:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVuhEfZpOX8zl0XrP5R3QxgNpzSuscXtdUcKEPTXcAw=;
        b=CO1MK2ZRHrHNz5PhgAYfb0VzqtIgUYbInl731liQ9CIZbxbvxYoITtlzqTqTkZH09O
         XkM7CFuOO8Gtgv2vZ/ROqV+OhC8vk9EUUG6fG4H7ieye+4MDN+LDnrK3bVEw0Kih1C8G
         HwKOLyuPVLhSFP+jMh9EkrL5YEl69MX/6MUzdp+kBfH/zOPlYP/5l79wgQ/xAJkAQAvh
         4nQR5i/lbZU4fQg9G+P3x+hhNfOMsex2udczshRqQ5ufMkAwa4ZwQ/xWJXfMsY1XgaD/
         by1C9uo+QiyydhH2ctMURhG1aJUE7DVLYhm2EcYTWw5j8UlNU77Jes598YLTDqzty4WG
         3X1A==
X-Gm-Message-State: AGi0PuYQL9MxquaO0UFrSNDn+RmXqijuTBRUoRCEeDB03wQIm9tH+JeC
        QRElTvHyVJ7PPBF62NM85nO2lYrPRosqwtQR4ExGteIN2KL+vNZSRq5fiQkH7HDq4Xx2+Ijhn8O
        9uq7w1/UJ59BdOj+Oha+8PS3sdku/JemwwnrnY81+Pl+w/57NBQQuP9dN+YJ5
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr427914lfb.205.1588211209078;
        Wed, 29 Apr 2020 18:46:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypI7R19gF9LgFBelDF2FuhIWm27jDVYI4pmc4QOgz1v/QrtHGQwil15pQXdCxVNyk6TX/71TL/yaxQLxn01Tr28=
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr427894lfb.205.1588211208743;
 Wed, 29 Apr 2020 18:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200429095044.24625-1-po-hsu.lin@canonical.com> <20200429122855.02594f33@gandalf.local.home>
In-Reply-To: <20200429122855.02594f33@gandalf.local.home>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 30 Apr 2020 09:46:36 +0800
Message-ID: <CAMy_GT88BD6Ty9=gtqhsm2UPf8aX-=SHZrWj_-UZJONnk73+nQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet
 situation as unsupported
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, mingo@redhat.com,
        shuah <shuah@kernel.org>, Colin King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 30, 2020 at 12:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 29 Apr 2020 17:50:44 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> > When the required module for the test does not exist, use
> > exit_unsupported instead of exit_unresolved to indicate this test is
> > not supported.
> >
> > By doing this we can make test behaviour in sync with the
> > irqsoff_tracer.tc test in preemptirq, which is also treating module
> > existence in this way. Moreover, the test won't exit with a non-zero
> > return value if the module does not exist.
> >
> > Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> > Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> > Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> > Fixes: af2a0750f374 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")
>
> I don't think this deserves the Fixes tags.
Hello Steven,

OK I will remove these Fixes tags and resubmit V2 if Masami agrees
with this change.

>
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
> >  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
>
> I'm fine with these changes if Masami is. But it is Masami's call as his
> infrastructure is more sensitive to the return calls than mine. I just run
> the test and see what passes. I don't actually look at the return codes.
Another thing to note is that this will also change the "# of
unresolved" and "# of unsupported" in the summary at the end of the
test report.

Thanks
Po-Hsu
>
> -- Steve
>
>
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > index d75a869..3d6189e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  echo "Let the module run a little"
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > index 801ecb6..3d0e3ca 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  if [ ! -f kprobe_events ]; then
> > diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > index b02550b..dd8b10d 100644
> > --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > @@ -5,7 +5,7 @@
> >  rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  echo "Waiting for irq work"
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > index 1a4b4a4..26dc06a 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > @@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  : "Wildcard should be resolved after loading module"
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > index d861bd7..4e07c69 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > @@ -8,7 +8,7 @@ rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  MOD=trace_printk
>
