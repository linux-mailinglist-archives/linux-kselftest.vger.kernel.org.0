Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF716B55B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 00:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCJXes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 18:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCJXeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 18:34:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A9115B6F;
        Fri, 10 Mar 2023 15:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D21FB82433;
        Fri, 10 Mar 2023 23:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF026C433D2;
        Fri, 10 Mar 2023 23:34:35 +0000 (UTC)
Date:   Fri, 10 Mar 2023 18:34:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zwisler@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
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
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: use canonical ftrace path
Message-ID: <20230310183434.64ade329@gandalf.local.home>
In-Reply-To: <20230310175209.2130880-1-zwisler@kernel.org>
References: <20230310175209.2130880-1-zwisler@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 Mar 2023 10:52:08 -0700
zwisler@kernel.org wrote:

> From: Ross Zwisler <zwisler@google.com>
> 
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> Many comments and samples in the bpf code still refer to this older
> debugfs path, so let's update them to avoid confusion.  There are a few
> spots where the bpf code explicitly checks both tracefs and debugfs
> (tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
> those alone so that the tools can continue to work with both paths.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
