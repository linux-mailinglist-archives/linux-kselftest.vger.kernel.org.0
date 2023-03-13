Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332606B8336
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCMU5f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCMU5d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 16:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DFC8B317;
        Mon, 13 Mar 2023 13:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B2D9614D5;
        Mon, 13 Mar 2023 20:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41405C433D2;
        Mon, 13 Mar 2023 20:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741051;
        bh=FvPsyX72CjxlJgwPPQ0SI92LE0LVha0nXzy8vJXXD6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZJfd+Pifk1LQRZ1I+PomQWtGL7T7PIhrwQ9xX45ipw8VPKKm6gopnobZI/NB1IvX
         DJnROndP/zkxNKHGBet4zV97JQfOSyammDQvaIzUyjMw8OyJWnk5DsV1cutwzXqpKh
         nNdOjx23vydtQFfvtD31BxJMnehnCSLlgnhyigu5scLhmENX9QpK+1pTOS/mwJbmXT
         3iURODJ89aOgEXrJLgZgLPFSZ9GbKPRdcnF404vxFRPzXJBRvhNElfOY1p2rGdfoWl
         kGJBSZOnnAKzHDFwjVHSSrooxRBKLtYuJE1xnQ+g290oUg4ADJ40Rr2+Gkbwr+xGbs
         /TSopWQH4wPyQ==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v4 0/2] use canonical ftrace path whenever possible
Date:   Mon, 13 Mar 2023 14:56:26 -0600
Message-Id: <20230313205628.1058720-1-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230310192050.4096886-1-zwisler@kernel.org>
References: <20230310192050.4096886-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

v3 here:
https://lore.kernel.org/all/20230310192050.4096886-1-zwisler@kernel.org/

Changes since v3:
 * Added braces around a few multi-line if/else statements (Steven Rostedt)
 * Added Reviewed-by from Steven to patch 1
 * Rebased onto the current bpf/bpf-next

Ross Zwisler (2):
  bpf: use canonical ftrace path
  selftests/bpf: use canonical ftrace path

 include/uapi/linux/bpf.h                            |  8 ++++----
 samples/bpf/cpustat_kern.c                          |  4 ++--
 samples/bpf/hbm.c                                   |  4 ++--
 samples/bpf/ibumad_kern.c                           |  4 ++--
 samples/bpf/lwt_len_hist.sh                         |  2 +-
 samples/bpf/offwaketime_kern.c                      |  2 +-
 samples/bpf/task_fd_query_user.c                    |  4 ++--
 samples/bpf/test_lwt_bpf.sh                         |  2 +-
 samples/bpf/test_overhead_tp.bpf.c                  |  4 ++--
 tools/include/uapi/linux/bpf.h                      |  8 ++++----
 tools/testing/selftests/bpf/get_cgroup_id_user.c    |  9 +++++++--
 .../selftests/bpf/prog_tests/kprobe_multi_test.c    |  7 ++++++-
 .../selftests/bpf/prog_tests/task_fd_query_tp.c     |  9 +++++++--
 .../selftests/bpf/prog_tests/tp_attach_query.c      |  9 +++++++--
 .../testing/selftests/bpf/prog_tests/trace_printk.c | 10 +++++++---
 .../selftests/bpf/prog_tests/trace_vprintk.c        | 10 +++++++---
 .../selftests/bpf/progs/test_stacktrace_map.c       |  2 +-
 tools/testing/selftests/bpf/progs/test_tracepoint.c |  2 +-
 tools/testing/selftests/bpf/test_ftrace.sh          |  7 ++++++-
 tools/testing/selftests/bpf/test_tunnel.sh          | 13 +++++++++----
 tools/testing/selftests/bpf/trace_helpers.c         |  8 ++++++--
 21 files changed, 85 insertions(+), 43 deletions(-)


base-commit: 22df776a9a866713d9decfb92b633bcfdb571954
-- 
2.40.0.rc1.284.g88254d51c5-goog

