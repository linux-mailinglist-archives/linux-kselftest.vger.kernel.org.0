Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DCB67F371
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 02:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjA1BFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 20:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjA1BFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 20:05:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D488003F;
        Fri, 27 Jan 2023 17:05:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA40B82209;
        Sat, 28 Jan 2023 01:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E6AC433D2;
        Sat, 28 Jan 2023 01:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674867937;
        bh=zwFp7OLE6mqJKvAqS7r9p7cbYPOOvzIRKPKfObXqSoY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XDIjFePXZuzRFpjSEAYdUjb5XASHHgwnmAa+rIdsQk63qoa0t+2d/lESKzDfmyRGw
         FaC2gSa5y7C86A+OON757UIWOSb1/9g/IIRK/BxgLNEVX+AaqJxm+p9q9ht0RDJx0v
         kM3sNP0e6gNb4ip5M1K1EDFwDCpq/UdgpagoQPBj9/DhROl/2+KAU61TMeT2dC5yHi
         zC9Bq7e5kINRJNqI83oVG7d/9Ljywy3BMOVMs29HsJ2dSJNF3cqZ1P+D1CaX8RdtCu
         U2rvTUYSbADbgiPU4k3oT0R4kNZgRB+Y/NBI4Xlop17K46ItDhxwBpwEHOW2hEYUIV
         QJb17uXjA3PXA==
Date:   Sat, 28 Jan 2023 10:05:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Donglin Peng <dolinux.peng@gmail.com>, mhiramat@kernel.org,
        xiehuan09@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] tracing/probe: add a char type to show the character
 value of traced arguments
Message-Id: <20230128100533.38af2d809099cc8cecba8f3d@kernel.org>
In-Reply-To: <20230124173800.639a8165@gandalf.local.home>
References: <20221219110613.367098-1-dolinux.peng@gmail.com>
        <20230124173800.639a8165@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 24 Jan 2023 17:38:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Looking back at emails that happened when I was off ;-)
> 
> Masami, what's you thoughts about this patch?

Oops, I also missed this.

Thanks for updating the patch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I'll pick this to the for-next.

Thank you!


> 
> -- Steve
> 
> 
> On Mon, 19 Dec 2022 03:06:13 -0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> 
> > There are scenes that we want to show the character value of traced
> > arguments other than a decimal or hexadecimal or string value for debug
> > convinience. I add a new type named 'char' to do it and a new test case
> > file named 'kprobe_args_char.tc' to do selftest for char type.
> > 
> > For example:
> > 
> > The to be traced function is 'void demo_func(char type, char *name);', we
> > can add a kprobe event as follows to show argument values as we want:
> > 
> > echo  'p:myprobe demo_func $arg1:char +0($arg2):char[5]' > kprobe_events
> > 
> > we will get the following trace log:
> > 
> > ... myprobe: (demo_func+0x0/0x29) arg1='A' arg2={'b','p','f','1',''}
> > 
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > Changes in v6:
> >  - change "\'%c\'" to "'%c'" in trace_probe.c
> > 
> > Changes in v5:
> >  - wrap the output character with single quotes
> >  - add a test case named kprobe_args_char.tc to do selftest
> > 
> > Changes in v4:
> >  - update the example in the commit log
> > 
> > Changes in v3:
> >  - update readme_msg
> > 
> > Changes in v2:
> >  - fix build warnings reported by kernel test robot
> >  - modify commit log
> > ---
> >  Documentation/trace/kprobetrace.rst           |  3 +-
> >  kernel/trace/trace.c                          |  2 +-
> >  kernel/trace/trace_probe.c                    |  2 +
> >  kernel/trace/trace_probe.h                    |  1 +
> >  .../ftrace/test.d/kprobe/kprobe_args_char.tc  | 47 +++++++++++++++++++
> >  5 files changed, 53 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > 
> > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > index 4274cc6a2f94..007972a3c5c4 100644
> > --- a/Documentation/trace/kprobetrace.rst
> > +++ b/Documentation/trace/kprobetrace.rst
> > @@ -58,7 +58,7 @@ Synopsis of kprobe_events
> >    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> >    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> >  		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > -		  (x8/x16/x32/x64), "string", "ustring" and bitfield
> > +		  (x8/x16/x32/x64), "char", "string", "ustring" and bitfield
> >  		  are supported.
> >  
> >    (\*1) only for the probe on function entry (offs == 0).
> > @@ -80,6 +80,7 @@ E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
> >  Note that the array can be applied to memory type fetchargs, you can not
> >  apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
> >  wrong, but '+8($stack):x8[8]' is OK.)
> > +Char type can be used to show the character value of traced arguments.
> >  String type is a special type, which fetches a "null-terminated" string from
> >  kernel space. This means it will fail and store NULL if the string container
> >  has been paged out. "ustring" type is an alternative of string for user-space.
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 6d7ef130f57e..c602081e64c8 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5615,7 +5615,7 @@ static const char readme_msg[] =
> >  	"\t           $stack<index>, $stack, $retval, $comm,\n"
> >  #endif
> >  	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
> > -	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
> > +	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
> >  	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> >  	"\t           <type>\\[<array-size>\\]\n"
> >  #ifdef CONFIG_HIST_TRIGGERS
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index bb2f95d7175c..794a21455396 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
> > +DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "'%c'")
> >  
> >  int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
> >  {
> > @@ -93,6 +94,7 @@ static const struct fetch_type probe_fetch_types[] = {
> >  	ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
> >  	ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
> >  	ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> > +	ASSIGN_FETCH_TYPE_ALIAS(char, u8, u8,  0),
> >  	ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
> >  
> >  	ASSIGN_FETCH_TYPE_END
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index de38f1c03776..8c86aaa8b0c9 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -164,6 +164,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x16);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
> >  
> > +DECLARE_BASIC_PRINT_TYPE_FUNC(char);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(string);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
> >  
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > new file mode 100644
> > index 000000000000..285b4770efad
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> > @@ -0,0 +1,47 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: Kprobe event char type argument
> > +# requires: kprobe_events
> > +
> > +case `uname -m` in
> > +x86_64)
> > +  ARG1=%di
> > +;;
> > +i[3456]86)
> > +  ARG1=%ax
> > +;;
> > +aarch64)
> > +  ARG1=%x0
> > +;;
> > +arm*)
> > +  ARG1=%r0
> > +;;
> > +ppc64*)
> > +  ARG1=%r3
> > +;;
> > +ppc*)
> > +  ARG1=%r3
> > +;;
> > +s390*)
> > +  ARG1=%r2
> > +;;
> > +mips*)
> > +  ARG1=%r4
> > +;;
> > +*)
> > +  echo "Please implement other architecture here"
> > +  exit_untested
> > +esac
> > +
> > +: "Test get argument (1)"
> > +echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char" > kprobe_events
> > +echo 1 > events/kprobes/testprobe/enable
> > +echo "p:test $FUNCTION_FORK" >> kprobe_events
> > +grep -qe "testprobe.* arg1='t'" trace
> > +
> > +echo 0 > events/kprobes/testprobe/enable
> > +: "Test get argument (2)"
> > +echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):char arg2=+0(${ARG1}):char[4]" > kprobe_events
> > +echo 1 > events/kprobes/testprobe/enable
> > +echo "p:test $FUNCTION_FORK" >> kprobe_events
> > +grep -qe "testprobe.* arg1='t' arg2={'t','e','s','t'}" trace
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
