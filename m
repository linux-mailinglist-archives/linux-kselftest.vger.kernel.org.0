Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6916B83AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 22:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCMVCn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 17:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCMVCV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 17:02:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA28C972
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 14:01:11 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so2333248ild.11
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678741261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMqHKIxdMm3dM36ZLNxuSyWdPqYMqCbdnka0e38R2kM=;
        b=pCSbxY1IuGxxgCsf0OZvGcJr4x3ejeAiZt5AqE/8KtXUT6a+XnM4fYT0xGMmfxKIZB
         z24W/gF6BCKBX3jZg7GUjSMyrN1JLCgtWHPzTCkc1T4ZkN6ofeusc7MX224Gw+4eGVCb
         bSiHxzOPnT/tgh1eTvMv6Td9mt0ppgKWiHP4rp5LrH8qmMbSAAHcV0hm/Mz1Kh4vxNvf
         +MNCXtxGIF7aN+DnLGiAZJKL0CTcYgt5S+QDG+Fr4w1wJbW39XzCpwVt5tDuWg7gHetc
         kqTodPJZj/HZGb3LZqnXeZ/M7vi3ZXd8SkOEbpkZDfg5BL1eS9pgZvYvhU/VxS7z02ci
         i5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMqHKIxdMm3dM36ZLNxuSyWdPqYMqCbdnka0e38R2kM=;
        b=HU4RCONAVug06Lom1wcv/x0sK6Xoy8xkL/5JayNjqZPLCWq51RPn8lUDQ4mI5HNGs1
         jo3p/1w8U9m4+7XU4nhQV4K+bijRrhEB1GZEC+OLY6rkDMomlaJ7Wkn7u4y8OJk0FjL8
         l82DTYLXiPAC1STRjHHYaXDn7411b8CQHKAxPxoOvAsbOv07kjbQxP5Fhn4Xmk+Pur+t
         VoM7TX6MLdFQy1xAT7HVrAMH1rQgWSa5stJbN6ung0O+mn43lGUDPyomSk1F3yDxeqsj
         s0g40GgC4ekjukQWvplhYwbb/8TrSlgnZpGx85H/l7S1YxPVgKCxcRSgdlUSX5r9IMpX
         Ilbg==
X-Gm-Message-State: AO0yUKXOZu+oD5PNikBtnn2jHr6ZBA8rH/a4/odkigPrfcajnCRYTgBn
        JUWsmmMu8qkih+qVxCb3UGja8g==
X-Google-Smtp-Source: AK7set87hROC3DrRy/WHpgTl+q0g7aJEMwmTNpv2ADoDCdSubwZnPqmWHhNg4NYrayS39Mj3cpUa+Q==
X-Received: by 2002:a92:7302:0:b0:315:6fc5:ea46 with SMTP id o2-20020a927302000000b003156fc5ea46mr746590ilc.2.1678741261504;
        Mon, 13 Mar 2023 14:01:01 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:a33c:9b70:2c95:9544])
        by smtp.gmail.com with ESMTPSA id e12-20020a02a78c000000b004046f72271esm32031jaj.100.2023.03.13.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:01:01 -0700 (PDT)
Date:   Mon, 13 Mar 2023 15:00:57 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Ross Zwisler <zwisler@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/2] use canonical ftrace path whenever
 possible
Message-ID: <20230313210057.GB592900@google.com>
References: <20230310192050.4096886-1-zwisler@kernel.org>
 <20230313205628.1058720-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313205628.1058720-1-zwisler@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 13, 2023 at 02:56:26PM -0600, Ross Zwisler wrote:
> From: Ross Zwisler <zwisler@google.com>
> 
> v3 here:
> https://lore.kernel.org/all/20230310192050.4096886-1-zwisler@kernel.org/

Sorry, this should have been:
https://lore.kernel.org/all/20230310175209.2130880-1-zwisler@kernel.org/

> 
> Changes since v3:
>  * Added braces around a few multi-line if/else statements (Steven Rostedt)
>  * Added Reviewed-by from Steven to patch 1
>  * Rebased onto the current bpf/bpf-next
> 
> Ross Zwisler (2):
>   bpf: use canonical ftrace path
>   selftests/bpf: use canonical ftrace path
> 
>  include/uapi/linux/bpf.h                            |  8 ++++----
>  samples/bpf/cpustat_kern.c                          |  4 ++--
>  samples/bpf/hbm.c                                   |  4 ++--
>  samples/bpf/ibumad_kern.c                           |  4 ++--
>  samples/bpf/lwt_len_hist.sh                         |  2 +-
>  samples/bpf/offwaketime_kern.c                      |  2 +-
>  samples/bpf/task_fd_query_user.c                    |  4 ++--
>  samples/bpf/test_lwt_bpf.sh                         |  2 +-
>  samples/bpf/test_overhead_tp.bpf.c                  |  4 ++--
>  tools/include/uapi/linux/bpf.h                      |  8 ++++----
>  tools/testing/selftests/bpf/get_cgroup_id_user.c    |  9 +++++++--
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c    |  7 ++++++-
>  .../selftests/bpf/prog_tests/task_fd_query_tp.c     |  9 +++++++--
>  .../selftests/bpf/prog_tests/tp_attach_query.c      |  9 +++++++--
>  .../testing/selftests/bpf/prog_tests/trace_printk.c | 10 +++++++---
>  .../selftests/bpf/prog_tests/trace_vprintk.c        | 10 +++++++---
>  .../selftests/bpf/progs/test_stacktrace_map.c       |  2 +-
>  tools/testing/selftests/bpf/progs/test_tracepoint.c |  2 +-
>  tools/testing/selftests/bpf/test_ftrace.sh          |  7 ++++++-
>  tools/testing/selftests/bpf/test_tunnel.sh          | 13 +++++++++----
>  tools/testing/selftests/bpf/trace_helpers.c         |  8 ++++++--
>  21 files changed, 85 insertions(+), 43 deletions(-)
> 
> 
> base-commit: 22df776a9a866713d9decfb92b633bcfdb571954
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
