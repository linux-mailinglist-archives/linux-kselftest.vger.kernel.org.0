Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0614295F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhJKRo1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJKRo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 13:44:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960BC061570
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 10:42:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls18so13790422pjb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Oct 2021 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIgVsm94kxYUZNiL4Bxn3wPBnd3IejzU3gHnaJvMuG4=;
        b=NDDjxJTvpXyqQZqINNCpwq5QuvZPHy3ezHcVfOu79DTvi2kj8uT8BS7XQM8rbR+Gse
         abrAepFyJpMx1OnUkC119hHQ/wfKy+HbF3egevze0eKjs0CjaKmO4D3JpHdvnYHrpGpz
         DMiJSWLleg8CkwUxu015qDgfkK26DS6o6pfv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIgVsm94kxYUZNiL4Bxn3wPBnd3IejzU3gHnaJvMuG4=;
        b=sgpQTBIMsIHvZFWz72NkSE1EmZXgWDU6CBf3hXN4HK3rx7lax0OI1o3EUMolVRH7tY
         MhL/e9VJ1z0eT6JF/fOqNHs4NcJiyX4LyuwOpcTGPQ7jiZQpCoh5X+R1bO8GPfcaJ6N/
         rtt5GGT5hGp5aMs3nLqzmx8wMmbFfb7N/pOc62PISNAYyUG21u7ldEn9h+c0DQmEmmlz
         DjN0nOQKVBQDJSnQ03EqheVjoagonsNF13nsCuWlS2ZDvCvd90YB882vhnWHVkmkpEOu
         Uv/w6NKtTy1l0avSgg1inXPwHw8rOnndwUmz6NrQaXgpyGJkp5vosCW3gWNzOtpygjto
         aJuA==
X-Gm-Message-State: AOAM532FQ7D1AVRJicTGoqP7E2bOZzrOgvpD5ueKSuQzg/o7H/WbbUZT
        a8vm9QyKSDt6npB0djyMEnPhjQ==
X-Google-Smtp-Source: ABdhPJxRFGXIkK5xAjJsnJbx4wTgEPcUz4yu5js7dOpHpJw7GqQdiivS87ywjxfQRe0afyXSmRxh2w==
X-Received: by 2002:a17:902:f551:b0:13e:fb56:f519 with SMTP id h17-20020a170902f55100b0013efb56f519mr25796087plf.0.1633974145574;
        Mon, 11 Oct 2021 10:42:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4sm9091145pfu.94.2021.10.11.10.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:42:25 -0700 (PDT)
Date:   Mon, 11 Oct 2021 10:42:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110111022.21B600CC2@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
 <YWGQckkJuKB4yAfg@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWGQckkJuKB4yAfg@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 09, 2021 at 03:52:02PM +0300, Alexey Dobriyan wrote:
> On Fri, Oct 08, 2021 at 04:55:04PM -0700, Kees Cook wrote:
> > This makes sure that wchan contains a sensible symbol when a process is
> > blocked.
> 
> > Specifically this calls the sleep() syscall, and expects the
> > architecture to have called schedule() from a function that has "sleep"
> > somewhere in its name.
> 
> This exposes internal kernel symbol to userspace.

Correct; we're verifying the results of the wchan output, which produces
a kernel symbol for blocked processes.

> Why would want to test that?

This is part of a larger series refactoring/fixing wchan[1], and we've
now tripped over several different failure conditions, so I want to make
sure this doesn't regress in the future.

> Doing s/sleep/SLEEP/g doesn't change kernel but now the test is broken.

Yes; the test would be doing it's job, as that would mean there was a
userspace visible change to wchan, so we'd want to catch it and either
fix the kernel or update the test to reflect the new reality.

> 
> > For example, on the architectures I tested
> > (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":
> 
> > +/*
> > + * Make sure that wchan returns a reasonable symbol when blocked.
> > + */
> 
> Test should be "contains C identifier" then?

Nope, this was intentional. Expanding to a C identifier won't catch the
"we unwound the stack to the wrong depth and now all wchan shows is
'__switch_to'" bug[2]. We're specifically checking that wchan is doing
at least the right thing for the most common blocking state.

> 
> > +int main(void)
> > +{
> > +	char buf[64];
> > +	pid_t child;
> > +	int sync[2], fd;
> > +
> > +	if (pipe(sync) < 0)
> > +		perror_exit("pipe");
> > +
> > +	child = fork();
> > +	if (child < 0)
> > +		perror_exit("fork");
> > +	if (child == 0) {
> > +		/* Child */
> > +		if (close(sync[0]) < 0)
> > +			perror_exit("child close sync[0]");
> > +		if (close(sync[1]) < 0)
> > +			perror_exit("child close sync[1]");
> 
> Redundant close().

Hmm, did you maybe miss the differing array indexes? This closes the
reading end followed by the writing end of the child's pipe.

> 
> > +		sleep(10);
> > +		_exit(0);
> > +	}
> > +	/* Parent */
> > +	if (close(sync[1]) < 0)
> > +		perror_exit("parent close sync[1]");
> 
> Redundant close().

It's not, though. This closes the write side of the parent's pipe.

> 
> > +	if (read(sync[0], buf, 1) != 0)
> > +		perror_exit("parent read sync[0]");
> 
> Racy if child is scheduled out after first close in the child.

No, the first close will close the child's read-side of the pipe, which
isn't being used. For example, see[3].

The parent's read of /proc/$child/wchan could technically race if the
child is scheduled out after the second close() and before the sleep(),
but the parent is doing at least 2 syscalls before then. I'm open to
a more exact synchronization method, but this should be sufficient.
(e.g. Using ptrace to catch sleep syscall entry seemed like overkill.)

-Kees

[1] https://lore.kernel.org/lkml/20211008111527.438276127@infradead.org/
[2] https://lore.kernel.org/lkml/20211008124052.GA976@C02TD0UTHF1T.local/
[3] https://man7.org/tlpi/code/online/diff/pipes/pipe_sync.c.html

> 
> > +	snprintf(buf, sizeof(buf), "/proc/%d/wchan", child);
> > +	fd = open(buf, O_RDONLY);
> > +	if (fd < 0) {
> > +		if (errno == ENOENT)
> > +			return 4;
> > +		perror_exit(buf);
> > +	}
> > +
> > +	memset(buf, 0, sizeof(buf));
> > +	if (read(fd, buf, sizeof(buf) - 1) < 1)
> > +		perror_exit(buf);
> > +	if (strstr(buf, "sleep") == NULL) {
> > +		fprintf(stderr, "FAIL: did not find 'sleep' in wchan '%s'\n", buf);
> > +		return 1;
> > +	}
> > +	printf("ok: found 'sleep' in wchan '%s'\n", buf);
> > +
> > +	if (kill(child, SIGKILL) < 0)
> > +		perror_exit("kill");
> > +	if (waitpid(child, NULL, 0) != child) {
> > +		fprintf(stderr, "waitpid: got the wrong child!?\n");
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}

-- 
Kees Cook
