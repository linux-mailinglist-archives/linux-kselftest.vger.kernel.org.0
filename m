Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B117696960
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjBNQYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 11:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBNQYR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 11:24:17 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD42BF21
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 08:23:55 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i26so64083ila.11
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Feb 2023 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MCeZLLD36scDNZoKo/i+quNrCjBM4LKtgguziA0l4w=;
        b=nrdh9Z84zfj9LOzMn+lI3fFgOtcYXOWVU476R4GXqb9T+5knOUZpcH0VWXUlyLOxUk
         QqBT0KIl0spl/VcfYVEgjfpa3reZeqFn6LkRNAou/eWgMwMxs0xNytzbFVOBdoRfsYQf
         08f8GdbBGvf0cxHosWyzpCaaf8teMxqt2IuA1Hux58Ax11ArqRxzzee3UVrvjGb9Ok8v
         xsBBmAlBuDXdGClv7qD+kVheX0zIaa6rHgmcpMaZqvZb1dEntk7oe7e8Kp/brO8/EJD/
         3v8nzTfxjOjv+AGP5Fg9AYOPYaLWx8JaN9SV1SQC7NsuBwhCqUOGxJLyOxRjd1l0/N2m
         XSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MCeZLLD36scDNZoKo/i+quNrCjBM4LKtgguziA0l4w=;
        b=h5qZ2ezKs9VEKVw1NUFH1zLsoT0isp8zrSxlWSpjv6gTp2Z18cWcflRyQCaDftlltE
         c6eJHpBW02HCCq0iwRjp62gAN2tq6TMVDFfLJzn21Otf3TZQZulfUa6KI9KaNz4y6/nW
         iUfzhVmxsoEPaOVudb5vlk7fBD/8qyOL663+7Ws8LQXAEPN9WVJsh+Dm++TxrrKN8GNT
         BKvCuHVa/Q9QHg7QOT5UWsKCwyjmetUqw446ZKDOR4OLByiXGHIexcWlYULOjHDWQXc0
         c5wnipKigkOPeCcDAzwSfxbvcA/dKQmsMBIt7g2ajGG9CnT+tiPa+HgLpQNCdKXwuCPB
         fKSA==
X-Gm-Message-State: AO0yUKUlJBaajR8J0zOTC0Vlfbh84UepqKEOFnJ3Y5kMb41+4QW4NevM
        3Qh1HZXiak0XLboN0qPjzVH0fA==
X-Google-Smtp-Source: AK7set+wJTuQl8bVzZfJEVNUDl1DwEE7qqT3W2fILJ4rTMV1GNjuooGt41tO4/tI3+LbmRiqF1wXoA==
X-Received: by 2002:a05:6e02:160a:b0:312:5834:f6cf with SMTP id t10-20020a056e02160a00b003125834f6cfmr2942825ilu.1.1676391833204;
        Tue, 14 Feb 2023 08:23:53 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5ac1:1b03:ce8:c64b])
        by smtp.gmail.com with ESMTPSA id h10-20020a056e021b8a00b00313be472e06sm4870411ili.67.2023.02.14.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:52 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:23:48 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: use canonical ftrace path
Message-ID: <Y+u1lL49CB86VSuE@google.com>
References: <20230213221835.592763-1-zwisler@google.com>
 <Y+r4jLwWvhcvyuih@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+r4jLwWvhcvyuih@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 13, 2023 at 06:57:16PM -0800, Stanislav Fomichev wrote:
> On 02/13, Ross Zwisler wrote:
> > The canonical location for the tracefs filesystem is at
> > /sys/kernel/tracing.
> 
> > But, from Documentation/trace/ftrace.rst:
> 
> >    Before 4.1, all ftrace tracing control files were within the debugfs
> >    file system, which is typically located at /sys/kernel/debug/tracing.
> >    For backward compatibility, when mounting the debugfs file system,
> >    the tracefs file system will be automatically mounted at:
> 
> >    /sys/kernel/debug/tracing
> 
> > Many comments and samples in the bpf code still refer to this older
> > debugfs path, so let's update them to avoid confusion.  There are a few
> > spots where the bpf code explicitly checks both tracefs and debugfs
> > (tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
> > those alone so that the tools can continue to work with both paths.
> 
> Doesn't seem to apply cleanly to bpf-next?
> 
> https://github.com/kernel-patches/bpf/pull/4584

Oh, apologies, I was using Linus's master branch as my baseline.
I'll send out a v2.
