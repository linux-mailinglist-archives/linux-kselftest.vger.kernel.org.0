Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974FDA3A5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfH3Pbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 11:31:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37214 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3Pbi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 11:31:38 -0400
Received: by mail-io1-f67.google.com with SMTP id q12so14856552iog.4
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2019 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dvyo6oUnovUM1KkwAmeMZvZdETszrFSP9d+1xtXeBAY=;
        b=Re7G4/STBbK/+RGJsNi6DB2cisy5CRzH57YGOwsYmjwb8RO3j04UVg6NSIQtKlmaIi
         6qaia3NQZ5uU/XQIL3nBRnAAYEP3jSj3tWL9xyWbcA//0U+B/SiC52SF6G6SiJ2NkJcQ
         g9sc0URxPDqC23464nRSk92Z4JG660Njofbl1jOpyI+5sfWPpK3b8z6cV8yw96UqtM6P
         wZGDpMksz5c2Z8z4UGxpCJfFVZxR7Mq5mDXRIMt1PIRcxoIBGOi2VrW0coggPbSOhvWt
         4SHZTdKr9RklHVG4n/WbBhuCPZP2MzcdMrUxaewaZ/dQXz19UwuN9O6lcwXLzhW6Hhwy
         jy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dvyo6oUnovUM1KkwAmeMZvZdETszrFSP9d+1xtXeBAY=;
        b=LQ3uoQIdWcAa4ThUrC5u41rMmYdq4cLY3iYJrNjUhZmedoU44zyawWe6NNNMBuxnjF
         XIgfnmCiONlWWDpPnRBbDXnl3dnM2lqSkOCzGQaq6N4J3mj3ayGpskBB+g8mB0doJR0d
         hl5FkxpuqmEgutWjCszwxf1uzQDRnCCHJEDXd8SdBS/xdFiOJROhODUD53ghMDos7LvH
         xYaSmXKJV55+ohHaa32DhJdzbciOGLafheWnkdHZlOKndmtJ0lW35sGejsvBuQWX/cf+
         E4gjU8kgg5UI5mS7XC7JRhhofC0I6lzo3aaeaqyoRZ6af6h/sJaPuqFkYDMEm+BkJb3R
         qGNg==
X-Gm-Message-State: APjAAAX7SnWUN159le3wbAF9fYD1yjSNXn653vXNu73CCifszgTesh6o
        9hGSs7MqXMBMRVf71KzSyxz4GA==
X-Google-Smtp-Source: APXvYqzId3SbBWmFtoh761168yy6H9oaWQmQxOIZYIBRGcgRAptzNNRRtEx2PtBDJyj9pib0yDaycg==
X-Received: by 2002:a5e:8e4a:: with SMTP id r10mr4555992ioo.100.1567179097306;
        Fri, 30 Aug 2019 08:31:37 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:d1e4:8e0c:bfac:7e42])
        by smtp.gmail.com with ESMTPSA id a21sm4530735ioe.27.2019.08.30.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:31:36 -0700 (PDT)
Date:   Fri, 30 Aug 2019 09:31:35 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     shuah <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alakesh Haloi <alakesh.haloi@gmail.com>
Subject: Re: [PATCH] selftests/seccomp: fix build on older kernels
Message-ID: <20190830153135.GD7627@cisco>
References: <20190826144302.7745-1-tycho@tycho.ws>
 <201908291003.005EB96606@keescook>
 <f01c3383-0184-9770-c72e-7fe08b552112@kernel.org>
 <1a3e9d47-73f5-9cf5-e050-46a455b6a6cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a3e9d47-73f5-9cf5-e050-46a455b6a6cc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 09:19:00AM -0600, shuah wrote:
> On 8/29/19 6:45 PM, shuah wrote:
> > On 8/29/19 11:06 AM, Kees Cook wrote:
> > > On Mon, Aug 26, 2019 at 08:43:02AM -0600, Tycho Andersen wrote:
> > > > The seccomp selftest goes to some length to build against older kernel
> > > > headers, viz. all the #ifdefs at the beginning of the file. 201766a20e30
> > > > ("ptrace: add PTRACE_GET_SYSCALL_INFO request") introduces some
> > > > additional
> > > > macros, but doesn't do the #ifdef dance. Let's add that dance here to
> > > > avoid:
> > > > 
> > > > gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> > > > In file included from seccomp_bpf.c:51:
> > > > seccomp_bpf.c: In function ‘tracer_ptrace’:
> > > > seccomp_bpf.c:1787:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’
> > > > undeclared (first use in this function); did you mean
> > > > ‘PTRACE_EVENT_CLONE’?
> > > >    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > > >                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> > > >    __typeof__(_expected) __exp = (_expected); \
> > > >               ^~~~~~~~~
> > > > seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
> > > >    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > > >    ^~~~~~~~~
> > > > seccomp_bpf.c:1787:20: note: each undeclared identifier is
> > > > reported only once for each function it appears in
> > > >    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > > >                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> > > >    __typeof__(_expected) __exp = (_expected); \
> > > >               ^~~~~~~~~
> > > > seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
> > > >    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > > >    ^~~~~~~~~
> > > > seccomp_bpf.c:1788:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’
> > > > undeclared (first use in this function); did you mean
> > > > ‘PTRACE_EVENT_EXIT’?
> > > >      : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
> > > >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> > > >    __typeof__(_expected) __exp = (_expected); \
> > > >               ^~~~~~~~~
> > > > seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
> > > >    EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> > > >    ^~~~~~~~~
> > > > make: *** [Makefile:12: seccomp_bpf] Error 1
> > > > 
> > > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > > > Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> > > 
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Alakesh Haloi also sent a fix[1] for this. I prefer Tycho's solution
> > > (one #ifndef and a Fixes line). Shuah, can you please apply this?
> > > 
> > 
> > Kees,
> > 
> > Yes I will pick this up.
> > 
> > thanks,
> > -- Shuah
> > 
> 
> Applied after fixing the following checkpatch error in the commit log:
> 
> ERROR: Please use git commit description style 'commit <12+ chars of sha1>
> ("<title line>")' - ie: 'commit 201766a20e30 ("ptrace: add
> PTRACE_GET_SYSCALL_INFO request")'
> #82:
> 
> Now reads as follows:
> 
> Commit 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
>     introduces some additional macros, but doesn't do the #ifdef dance.
>     Let's add that dance here to avoid:

Ah, good to know. Thanks!

Tycho
