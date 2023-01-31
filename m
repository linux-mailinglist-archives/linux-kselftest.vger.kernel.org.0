Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7D682116
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 01:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjAaAxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 19:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjAaAxV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 19:53:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F2E04D;
        Mon, 30 Jan 2023 16:53:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so12868901pjb.2;
        Mon, 30 Jan 2023 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBYldhL8pTWqB3BqjInd39Jcu1r7g+Kxk37exfegHcI=;
        b=b2JJ+b1c9pBa8vvw60U+wt9PkFe5oyfkppoG3QrQ87BnswsR71K9MpcVrNozZ0KEl9
         iTWvvLBgatoqKHqb6RGO2U0OBAGlFhmmvTKR+EOnV6G0vmqVsaFbIIZ5mCtMKBQSlwBi
         3GQRUOXLnd9r8sN1TETlMzsj90KMrqLFo0/MPNPWZpUb3BTndbH3/f0+cUxOoPUWa3r9
         S45J7wxzZ7ZP1H2+0ZMHL8U43McqdX5yE5c7WbMZ2Gt0sUWoJLCEr3GyfgdL1hsFVrcb
         ptERI7CQ7JT2q/qCOZLBgsPUgumiZ7Mx46Qt46T+g82ykILDsAjTcEopgWvEaT5LCi19
         2AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBYldhL8pTWqB3BqjInd39Jcu1r7g+Kxk37exfegHcI=;
        b=RoA4DMUskHxKxd4lDfxENUTTGMxG3NnZ9khN3DObgQFROscifoldPZ1nOMbEl6g3TR
         5SrtBVb6dk4lqzCxPdketEj/M8one+pvG1RF49+rIKLUgYN59q07csUKY1IRinFxgP5y
         3KcqRwhJEjjtl7H7feWs6mzXH/MtH/umK2rvKBL0ZWQz30rld2EhPlYMaPSOLmA2m7V9
         dAg5KP02D1i5usAYKEUiLS3n3yN1YVD26fOuevGT3LFn8cb3YI/z24IQ/WgbpJp4eEJe
         DHstn1LmcTK1c5S3dJuBULDGxaznKsYfYQPWrklQ0lwdiku6xQ5CBXjit5U6aBn8khiC
         VnCA==
X-Gm-Message-State: AO0yUKVnh3I8Ohx/Z7RgX8kFEBgyu8fy1gYeyXbljk6wBhanK4+5e1FU
        w7TaHIeYcvC9mWOUY96q+kE2tnhExHU=
X-Google-Smtp-Source: AK7set+A0QTFKRqjBMuZoq4Wo4mo09+R9ZCV1G/LpP3BiEvAwLBrdpiNXf+1CYEjx249igNHV4hxTA==
X-Received: by 2002:a17:902:f095:b0:196:1d89:7002 with SMTP id p21-20020a170902f09500b001961d897002mr7677082pla.31.1675126399830;
        Mon, 30 Jan 2023 16:53:19 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:a52d])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ba9100b001967692d6f5sm3742819pls.227.2023.01.30.16.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 16:53:19 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:53:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
Message-ID: <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-4-zwisler@google.com>
 <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
 <20230130145932.37cf6b73@gandalf.local.home>
 <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
 <20230130183419.0626dc21@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130183419.0626dc21@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 30, 2023 at 06:34:19PM -0500, Steven Rostedt wrote:
> On Mon, 30 Jan 2023 12:03:52 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > So this change will break the tests. We cannot do it.  
> > >
> > > Could we add a way to try to mount it?
> > >
> > > If anything, the tests should not have the path hard coded. It should then
> > > look to see if it is mounted and use the path that is found. Otherwise it
> > > should try mounting it at the correct location.
> > >
> > > Feel free to take the code from libtracefs (and modify it):
> > >
> > > https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n89
> > >
> > > It will make the test code much more robust.  
> > 
> > The point is not about tests. The point is that this change might break
> > some users that are working today with /sys/kernel/debug/tracing.
> 
> > It also might be mounted differently.
> > For example from another system:
> > cat /proc/mounts|grep trace
> > tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
> > tracefs /sys/kernel/debug/tracing tracefs rw,relatime 0 0
> 
> Yes, and the code works when it's mounted multiple times.
> 
> > 
> > So I suggest leaving the code as-is.
> 
> Why?  I want to make /sys/kernel/debug/tracing deprecated. It's a hack to
> not break old code. I've had complaints about that hack, and there's even
> systems that disable the auto mounting (that is, /sys/kernel/debug/tracing
> would not exist in such configs) This was never expected to be a permanent
> solution.

I don't think /sys/kernel/debug/tracing can ever be deprecated.
There are plenty of user space applications (not bpf related at all) that
expect it to be in that location.

Quick search shows:

android profiler:
https://android.googlesource.com/platform/external/perfetto/+/refs/heads/master/src/tools/dump_ftrace_stats/main.cc#60

java profiler:
https://github.com/jvm-profiling-tools/async-profiler/blob/master/src/perfEvents_linux.cpp#L85

> If anything, leaving hardcoded calls like that forces the user to mount
> debugfs when they may not want to. The entire point of tracefs was to allow
> users to have access to the trace events without having to expose debugfs
> and all the crud it brings with it. This was requested several times before
> it was added.

All makes sense.

> What is your technical reason for not modifying the code to look for
> tracefs in /sys/kernel/tracing and if it's not there try
> /sys/kernel/debug/tracing, and if both are not found, try mounting it.

libbpf already has code to probe both locations.
The point that full deprecation of /sys/kernel/debug/tracing is not possible,
hence no point doing the diff:
48 files changed, 96 insertions(+), 95 deletions(-)
It doesn't move the needle. Just a code churn.
