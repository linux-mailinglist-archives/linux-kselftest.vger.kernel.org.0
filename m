Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781E5179B41
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 22:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbgCDVtn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 16:49:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbgCDVtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 16:49:43 -0500
Received: from mail-yw1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1j9btd-0000WD-3n
        for linux-kselftest@vger.kernel.org; Wed, 04 Mar 2020 21:49:41 +0000
Received: by mail-yw1-f70.google.com with SMTP id u140so4710997ywf.13
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 13:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D15ynwrrHMGu8Lvf29PfzDkO2Xnj0Kx0WtMUcRAoGUk=;
        b=lo8Dc3iElNrF0j7qPc6y+Z2cRcHyiJcA8x8PJ9KOAxMn2KaZFVdBzTX43pkjMmuYDK
         MMWGzSheheQtYI8bt+ys0QFSPTk49o6B7KJyNYyoXN0Dqc3sCev6xnUykt8Ldu5EJlPL
         Tjk5TbbjgQcYlrN/3t1GYtiBz93yz1ZS+z7+R4HoPZs9fnT7TIwIdpKt/gGUsnybyg8L
         4xFvBq+PhAAhfd9Iy8/r+Sw//ttX1VHEc/A6zj6JfTJpcYFibhExUiS8gJ48lelGs03Y
         vktRmyMmDoY6DdPXcS+ozuAEDHNazx+Jvy6yvBSsmM4JxHWgPaBqb+qDhnuFaC7Khu/q
         FPOg==
X-Gm-Message-State: ANhLgQ1MgcAbeVp0ZrT2wKHk83x1WUfsXYRyMlwju0JRS9EuIiaUxvk2
        hNWhazV5llCYdqYLWzYshSlsy1d3ID0A6WhjOLNanHY15PhPH47F5YqRlOSjIZN5Ol94Y5u96Ka
        KFxAJj987lAj4mdRoxLJBXvVYFrH/4YmFCb+kJZM1dnCBFw==
X-Received: by 2002:a81:1c0a:: with SMTP id c10mr3094617ywc.142.1583358580152;
        Wed, 04 Mar 2020 13:49:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvZJaZ2FtmAIkALFVCfi34cHUNwTZA1Ei8eY+3Av/7AbgzCPgrLFiRi2PMqNWVrh806Nnr7ZA==
X-Received: by 2002:a81:1c0a:: with SMTP id c10mr3094602ywc.142.1583358579744;
        Wed, 04 Mar 2020 13:49:39 -0800 (PST)
Received: from localhost ([2605:a601:af9b:a120:d987:fd11:6482:bff3])
        by smtp.gmail.com with ESMTPSA id d2sm5077945ywe.36.2020.03.04.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:49:38 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:49:37 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Use printf instead of echo in kprobe
 syntax error tests
Message-ID: <20200304214937.GA2347@ubuntu-x1>
References: <20200304161435.23019-1-seth.forshee@canonical.com>
 <20200304155004.7dd033a3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304155004.7dd033a3@gandalf.local.home>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 03:50:04PM -0500, Steven Rostedt wrote:
> On Wed,  4 Mar 2020 10:14:35 -0600
> Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > @@ -37,7 +37,7 @@ fi
> >  
> >  check_error 'p vfs_read ^$none_var'	# BAD_VAR
> >  
> > -check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
> > +check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
> >  check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
> >  check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
> >  
> > @@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
> >  # instruction boundary check is valid on x86 (at this moment)
> >  case $(uname -m) in
> >    x86_64|i[3456]86)
> > -    echo 'p vfs_read' > kprobe_events
> > +    printf 'p vfs_read' > kprobe_events
> >      if grep -q FTRACE ../kprobes/list ; then
> >  	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
> >      fi
> > @@ -89,13 +89,13 @@ esac
> >  
> >  # multiprobe errors
> >  if grep -q "Create/append/" README && grep -q "imm-value" README; then
> > -echo 'p:kprobes/testevent _do_fork' > kprobe_events
> > +printf 'p:kprobes/testevent _do_fork' > kprobe_events
> >  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> > -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> > -check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
> > -check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
> > -check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> > -check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
> > +printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
> > +check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
> > +check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
> > +check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
> > +check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
> >  fi
> >  
> >  exit 0
> 
> 
> This change causes my tests to fail:
> 
> ++ echo 'Test command: p vfs_read arg1="abcd'
> Test command: p vfs_read arg1="abcd
> ++ echo
> ++ grep 'trace_kprobe: error:' -A 3 error_log
> [61913.240093] trace_kprobe: error: Invalid fetch argument
>   Command: p vfs_read arg1="abcd
>                            ^
> +++ tail -n 1 error_log
> +++ wc -c
> ++ N=29
> +++ expr 13 + 21
> ++ test 34 -eq 29

Ah, I did miss a couple of backslashes that need to be escaped there.
The test passes for me without it though, so mabye printf behavior is
less consistent than I thought.

I'll send a v2, hopefully it will work better for you.

Seth
