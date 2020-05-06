Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E71C65A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 May 2020 03:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgEFBqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 21:46:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46321 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgEFBqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 21:46:36 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jW98r-00051M-Dr
        for linux-kselftest@vger.kernel.org; Wed, 06 May 2020 01:46:33 +0000
Received: by mail-lf1-f69.google.com with SMTP id q11so216907lfe.21
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 18:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B7yS8vfVpzW+bK3bCu1s781EudQm0LhQfkvys8g52o=;
        b=nMMarBpKjeUudh0r/molV29ZaNOdPyQaIjiSqhSK92Y+bKsyl5VAkxt+NgVE0z1LzK
         hv4YVl3hJ58lJ2wFjMszG7ecRNyTI54W4QOmaQF3apALXSRhlxDckBSC3CjaxuUFTF4W
         jqO/8sU/tVJWYePzP0U172xHjc9ag2QhTGKlF4pVcCJmmA7SdPGW6AVTX5DaWFyo8t6Z
         1wMyKKrI4ntd7DYJSrL4jWda3Nh4RKJ35IgoDjm6FCjJTFRD0scvpJMT7KMKK+HoA0+9
         E5Nugt7a7HNo2MkV3KAvcFCLyofDAITrf7SC8HL3vuiITYGgU8T6W+dBRrxXg8UfPES5
         ZhoA==
X-Gm-Message-State: AGi0PubpIPg8xhg/vSwpdXHNvl0XzuX/0Po6U6FrD/6WQBdaBz24WHao
        m02a1RqtuBwj/R0/XJIhvg2pPLmpnDb84xB0YeZZSCrHJaZNR9iSD2gKpLl1Cnbcx1FpEx2T5w6
        O45MrzIP2/GM+48ri8jeNlnaNTfJwcLly6t8Ad2u//eIsl2UewIh0OuXM18QX
X-Received: by 2002:a2e:910e:: with SMTP id m14mr3149527ljg.141.1588729592880;
        Tue, 05 May 2020 18:46:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypKuOYHIUMYt6ojTcSw/TDbURUf5WO6gJf1Kd8Jas019NkaxPEO+rYB8lhaFaJsGc6VfsnRf75BAETP9FLg5EUA=
X-Received: by 2002:a2e:910e:: with SMTP id m14mr3149521ljg.141.1588729592605;
 Tue, 05 May 2020 18:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200505101445.27063-1-po-hsu.lin@canonical.com> <20200505090912.7114f420@gandalf.local.home>
In-Reply-To: <20200505090912.7114f420@gandalf.local.home>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 6 May 2020 09:46:21 +0800
Message-ID: <CAMy_GT8r8H21Ly3N5VFkiPi0qUCkPCvy8SU3Ns2vesaS8xvffQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: mark irqsoff_tracer.tc test as
 unresolved if the test module does not exist
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>, joel@joelfernandes.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 5, 2020 at 9:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> You keep forgetting to Cc Shuah's other email.
Thanks!
I got the recipients list from the get_mainter.pl.

>
> On Tue,  5 May 2020 18:14:45 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> > The UNRESOLVED state is much more apporiate than the UNSUPPORTED state
> > for the absence of the test module, as it matches "test was set up
> > incorrectly" situation in the README file.
> >
> > A possible scenario is that the function was enabled (supported by the
> > kernel) but the module was not installed properly, in this case we
> > cannot call this as UNSUPPORTED.
> >
> > This change also make it consistent with other module-related tests
> > in ftrace.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> Shuah,
>
> Can you take this after Masami gives his ack (if he does that is).
>
> Thanks,
>
> -- Steve
>
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  .../testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > index cbd1743..2b82c80e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > @@ -17,7 +17,14 @@ unsup() { #msg
> >      exit_unsupported
> >  }
> >
> > -modprobe $MOD || unsup "$MOD module not available"
> > +unres() { #msg
> > +    reset_tracer
> > +    rmmod $MOD || true
> > +    echo $1
> > +    exit_unresolved
> > +}
> > +
> > +modprobe $MOD || unres "$MOD module not available"
> >  rmmod $MOD
> >
> >  grep -q "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
>
