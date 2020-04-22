Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4301B3AAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDVJBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 05:01:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45749 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVJBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 05:01:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so746597pgl.12;
        Wed, 22 Apr 2020 02:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kLNU6bywMxPQAzhQibyTFEQXB5wKYkebBNpzsfqmEsI=;
        b=BHYtNJtexUjAkRn8xHYcbDD0eUpRuRFubbD6k4HJ4EmrbPRmWfzQ7V7vm6jSBVZMHE
         NH/K6xdpCnujf5YBIwskzoyEQoWXF2TB1AesH/NUjmZSiBW5yuFG/iuMD/oyZ9VdNv1d
         Ip1AkC9IoGKXmvYNO6tEI1mlg/juFw0fBRwQ+3UTQIgZQ831gfTzHzAmte5KS/wiO47Y
         1VIoNWNZrxdk0HO+BJ9YkmeRO8boukCh+TpgADBYVICnF1EXBaa4qdO/uHDKWx+U4vT0
         7PJnwlDf4OrJlcrgsIRUvHPOlRq4bfRGVxJaThDyXXd1lvrgHLsBaLBxKD7AagEnv9fn
         SThA==
X-Gm-Message-State: AGi0Pub2vglTjJtiygS5TrskUE0bDTOYA++ep3Wh1GiGQljEaDJLc//Z
        bfpNlM5/Lj9HheMh2vXoCqE=
X-Google-Smtp-Source: APiQypKzgk5fa3wmZT7e/J9cqGf+LP8qVU5ez17Kll3ph8OmMYJs+cTDJM+SR2tWhTzTGKci8f6zlQ==
X-Received: by 2002:a63:79c9:: with SMTP id u192mr24835648pgc.7.1587546100119;
        Wed, 22 Apr 2020 02:01:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r13sm4683580pgj.9.2020.04.22.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 02:01:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B5C20402A1; Wed, 22 Apr 2020 09:01:37 +0000 (UTC)
Date:   Wed, 22 Apr 2020 09:01:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jessica Yu <jeyu@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200422090137.GW11244@42.do-not-panic.com>
References: <1587386035-5188-1-git-send-email-yangtiezhu@loongson.cn>
 <1587386035-5188-4-git-send-email-yangtiezhu@loongson.cn>
 <20200420181931.GJ11244@42.do-not-panic.com>
 <675147f7-2762-c574-4c3d-de6b25a5a44a@loongson.cn>
 <20200421144931.GA20103@linux-8ccs>
 <13aeb92d-047f-29a4-4d18-dcbd0519a218@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13aeb92d-047f-29a4-4d18-dcbd0519a218@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 22, 2020 at 04:55:34PM +0800, Tiezhu Yang wrote:
> On 04/21/2020 10:49 PM, Jessica Yu wrote:
> > +++ Tiezhu Yang [21/04/20 11:07 +0800]:
> > > On 04/21/2020 02:19 AM, Luis Chamberlain wrote:
> > > > On Mon, Apr 20, 2020 at 08:33:54PM +0800, Tiezhu Yang wrote:
> > > > > If module name is empty, it is better to return directly at
> > > > > the beginning
> > > > > of request_module() without doing the needless
> > > > > call_modprobe() operation.
> > > > > 
> > > > > Call trace:
> > > > > 
> > > > > request_module()
> > > > >       |
> > > > >       |
> > > > > __request_module()
> > > > >       |
> > > > >       |
> > > > > call_modprobe()
> > > > >       |
> > > > >       |
> > > > > call_usermodehelper_exec() -- retval = sub_info->retval;
> > > > >       |
> > > > >       |
> > > > > call_usermodehelper_exec_work()
> > > > >       |
> > > > >       |
> > > > > call_usermodehelper_exec_sync() -- sub_info->retval = ret;
> > > > >       |
> > > > >       | --> call_usermodehelper_exec_async() --> do_execve()
> > > > >       |
> > > > > kernel_wait4(pid, (int __user *)&ret, 0, NULL);
> > > > > 
> > > > > sub_info->retval is 256 after call kernel_wait4(), the function
> > > > > call_usermodehelper_exec() returns sub_info->retval which is 256,
> > > > > then call_modprobe() and __request_module() returns 256.
> > > > > 
> > > > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > > Thanks for looking into this. I still cannot find where
> > > > userspace it returns 256. Can you? If I run modprobe without
> > > > an argument I see 1 returned.
> > > > 
> > > > At least kmod [0] has a series of cmd helper structs, the one
> > > > for modprobe
> > > > seems to be kmod_cmd_compat_modprobe, and I can see -1 returned which
> > > > can be converted to 255. It can also return EXIT_FAILURE or
> > > > EXIT_SUCCESS
> > > > and /usr/include/stdlib.h defines these as 1 and 0 respectively.
> > 
> > I'm also seeing modprobe return 1 as exit status when I run it without
> > arguments. I don't think the 256 value is coming from modprobe though,
> > see below -
> > 
> > > > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/
> > > > 
> > > >   Luis
> > > 
> > > Here is my understanding:
> > > 
> > > When build and execute the following application, we can see the
> > > exit status is 256.
> > > 
> > > $ ./system
> > > modprobe: FATAL: Module  not found in directory
> > > /lib/modules/4.18.0-147.5.1.el8_1.x86_64
> > > exit status = 256
> > > 
> > > $ ./execl
> > > modprobe: FATAL: Module  not found in directory
> > > /lib/modules/4.18.0-147.5.1.el8_1.x86_64
> > > exit status = 256
> > 
> > I am going to guess this has something to do with how system() and
> > waitpid() (and the wait family of syscalls in general) encode the exit
> > status in their return values. According to their man pages, you need
> > to use the appropriate WIF* macros to get the actual exit code of the
> > child process.
> > 
> > From system(3):
> > 
> >    the return value is a "wait status" that can be examined using the
> >    macros described in waitpid(2).  (i.e., WIFEXITED(),
> >    WEXITSTATUS(), and so on)
> > 
> > From waitpid(2):
> > 
> >     If  wstatus  is  not  NULL,  wait()  and  waitpid() store status
> >     information in the int to which it points.  This integer can be
> >     inspected with the following macros (which take the integer
> >     itself as an argument, not a pointer to it, as is done in wait()
> >     and waitpid()!):
> > 
> >       WEXITSTATUS(wstatus)
> >              returns the exit status of the child.  This consists of
> >              the least significant 8 bits of the status argument that
> >              the child specified in a call to exit(3) or _exit(2) or
> >              as the argument for a return statement in main(). This
> >              macro should be employed only if WIFEXITED returned
> >              true.
> > 
> > In your test code, you are reading &status directly. To obtain the
> > exit status, you need to use WEXITSTATUS(status), or right shift the
> > value by 8 bits. That gives you 1, which was the original exit code
> > given by modprobe. That's why you see an exit code of 1 when running
> > modprobe directly and you see 256 when using system() and waitpid()
> > and don't use the WIF* macros.
> > 
> > As for why __request_module() returns 256, I am guessing this would
> > come from kernel_wait4(), but I did not dive into the call path to
> > verify this yet.
> 
> +Cc Al Viro <viro@zeniv.linux.org.uk>
> 
> Hi Al,
> 
> When module name is empty, __request_module() returns 256.
> What do you think about this case and patch?
> Thank you very much for your attention.

Its because of an old issue umh.c, I'll send a patch.

  Luis
