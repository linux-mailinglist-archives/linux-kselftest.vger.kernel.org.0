Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85E6F7B71
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 05:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjEEDVl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEEDVe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 23:21:34 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137511DAB
        for <linux-kselftest@vger.kernel.org>; Thu,  4 May 2023 20:21:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so1089462a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 May 2023 20:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683256863; x=1685848863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuHz1ga8iYYT3T2UezfJAayUdEePBZ0K98E4KKO6lr0=;
        b=WLRPobWtNTXI+Tq/qWsGl3AfIvzw0jmzVCLXthehEsHmTI990BjAbZ9iCCLyObfjI1
         oLwWzYNMYBc2zhoB4qwDLsdtlj6wIDRjy0d6WyZP1nBTu+wCkR5V/lsgWqTGVSQ8hvc2
         jnmJvNOv3q32Pg2z6rGHKdCX16GWWVfi2TwVXvYwF27/reE+WXmNxUuWARoNmjVWkt5j
         3UciFHGxA1JAzJMtM4SYOnjjdlCHYndxNbgn9JXiC7/ANbM7J3iEOabxdnandZO7QurW
         P7xqFUM77vCnMdxGcHoDav5F5ui8pIiHjDl+6qJqRj+qOi7NxwDdcwAar7OfxwP7prnS
         zNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256863; x=1685848863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuHz1ga8iYYT3T2UezfJAayUdEePBZ0K98E4KKO6lr0=;
        b=dySPRD01CXurhfy8iqyZ5hWdeDwFb5QR7nrAe5iqZhgIidwNf/hWoxeYf4ptnyYjbv
         Pq9w5wvbShITOYRYHQQ0OVkTmRg+UPt/gzLFQCfhS7FsDoUx6v3dYJzP1/fR3k2y46G7
         +ID4pH0AdwkUXDMLvqqz0PTSIIBHCWo6E2kgthnuAnffHN5AwhqzKu6SAEi6Ekn6rEin
         mxOKat0xUMHG37qOWcAS9RcmceIETkHx48JwuNkjcLbwkCQDFu1zTTe6jz2n+P7aQPSG
         KQJZI08fRkGSd5M5XY6aF0ebxqpyOmkc++xuEebzDxyh639dy80ZZ3J2bEjEBKyRhCLJ
         512A==
X-Gm-Message-State: AC+VfDyMxaOiRxcdsyjQ5Mn7SavFGyNcc3WiCU6IjObz8NkIdbe413XH
        U+pXV2fGBPjpO5fV+295HZebiA==
X-Google-Smtp-Source: ACHHUZ6HpiO6PuX63DKsP4o4xrLtKGOT4wwh6m+jy09qIntVA+v7OufF9xrMtLzZW1J5J/VMLzXZPg==
X-Received: by 2002:a17:902:ea07:b0:1a9:a408:a502 with SMTP id s7-20020a170902ea0700b001a9a408a502mr62192plg.1.1683256863462;
        Thu, 04 May 2023 20:21:03 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d70100b001a072aedec7sm399064ply.75.2023.05.04.20.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:21:03 -0700 (PDT)
Message-ID: <f26d4f76-d932-576c-cbb9-31158d3a0e4b@bytedance.com>
Date:   Fri, 5 May 2023 11:20:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add testcase for
 bpf_task_under_cgroup
To:     Yonghong Song <yhs@meta.com>, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
 <20230504031513.13749-3-zhoufeng.zf@bytedance.com>
 <63138022-e28f-a63c-6f4c-61b61e585641@meta.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <63138022-e28f-a63c-6f4c-61b61e585641@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/5/4 22:46, Yonghong Song 写道:
> 
> 
> On 5/3/23 8:15 PM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> test_progs:
>> Tests new kfunc bpf_task_under_cgroup().
>>
>> The bpf program saves the new task's pid within a given cgroup to
>> the remote_pid, which is convenient for the user-mode program to
>> verify the test correctness.
>>
>> The user-mode program creates its own mount namespace, and mounts the
>> cgroupsv2 hierarchy in there, call the fork syscall, then check if
>> remote_pid and local_pid are unequal.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Ack with a few nits below. You can carry my Ack in the
> next revision.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> 

Will do

>> ---
>>   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>>   .../bpf/prog_tests/task_under_cgroup.c        | 54 +++++++++++++++++++
>>   .../bpf/progs/test_task_under_cgroup.c        | 51 ++++++++++++++++++
>>   3 files changed, 106 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x 
>> b/tools/testing/selftests/bpf/DENYLIST.s390x
>> index c7463f3ec3c0..5061d9e24c16 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>> @@ -26,3 +26,4 @@ user_ringbuf                             # failed to 
>> find kernel BTF type ID of
>>   verif_stats                              # 
>> trace_vprintk__open_and_load unexpected error: 
>> -9                           (?)
>>   xdp_bonding                              # failed to auto-attach 
>> program 'trace_on_entry': -524                        (trampoline)
>>   xdp_metadata                             # JIT does not support 
>> calling kernel function                                (kfunc)
>> +test_task_under_cgroup                   # JIT does not support 
>> calling kernel function                                (kfunc)
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c 
>> b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
>> new file mode 100644
>> index 000000000000..fa3a98eae5ef
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/task_under_cgroup.c
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Bytedance */
>> +
>> +#include <sys/syscall.h>
>> +#include <test_progs.h>
>> +#include <cgroup_helpers.h>
>> +#include "test_task_under_cgroup.skel.h"
>> +
>> +#define FOO    "/foo"
>> +
>> +void test_task_under_cgroup(void)
>> +{
>> +    struct test_task_under_cgroup *skel;
>> +    int ret, foo = -1;
> 
> You do not need to initialize 'foo' here.
> 
>> +    pid_t pid;
>> +
>> +    foo = test__join_cgroup(FOO);
>> +    if (!ASSERT_OK(foo < 0, "cgroup_join_foo"))
>> +        return;
>> +
>> +    skel = test_task_under_cgroup__open();
>> +    if (!ASSERT_OK_PTR(skel, "test_task_under_cgroup__open"))
>> +        goto cleanup;
>> +
>> +    skel->rodata->local_pid = getpid();
>> +    skel->bss->remote_pid = getpid();
>> +    skel->rodata->cgid = get_cgroup_id(FOO);
>> +
>> +    ret = test_task_under_cgroup__load(skel);
>> +    if (!ASSERT_OK(ret, "test_task_under_cgroup__load"))
>> +        goto cleanup;
>> +
>> +    ret = test_task_under_cgroup__attach(skel);
>> +    if (!ASSERT_OK(ret, "test_task_under_cgroup__attach"))
>> +        goto cleanup;
>> +
>> +    pid = fork();
>> +    if (pid == 0)
>> +        exit(0);
>> +
>> +    ret = (pid == -1);
>> +    if (ASSERT_OK(ret, "fork process"))
>> +        wait(NULL);
>> +
>> +    test_task_under_cgroup__detach(skel);
>> +
>> +    ASSERT_NEQ(skel->bss->remote_pid, skel->rodata->local_pid,
>> +           "test task_under_cgroup");
>> +
>> +cleanup:
>> +    close(foo);
>> +
>> +    test_task_under_cgroup__destroy(skel);
> 
> Let us just do:
> cleanup:
>      test_task_under_cgroup__destroy(skel);
>      close(foo);
> 
> This is the reverse order of test__join_cgroup() and 
> test_task_under_cgroup__open().
> 
>> +}
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c 
>> b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>> new file mode 100644
>> index 000000000000..79d98e65c7eb
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Bytedance */
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#include "bpf_misc.h"
>> +
>> +struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
>> +long bpf_task_under_cgroup(struct task_struct *task, struct cgroup 
>> *ancestor) __ksym;
>> +void bpf_cgroup_release(struct cgroup *p) __ksym;
>> +struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
>> +void bpf_task_release(struct task_struct *p) __ksym;
>> +
>> +const volatile int local_pid;
>> +const volatile __u64 cgid;
>> +int remote_pid;
>> +
>> +SEC("tp_btf/task_newtask")
>> +int BPF_PROG(handle__task_newtask, struct task_struct *task, u64 
>> clone_flags)
>> +{
>> +    struct cgroup *cgrp = NULL;
>> +    struct task_struct *acquired;
>> +
>> +    if (local_pid != (bpf_get_current_pid_tgid() >> 32))
>> +        return 0;
>> +
>> +    acquired = bpf_task_acquire(task);
>> +    if (!acquired)
>> +        return 0;
>> +
>> +    if (local_pid == acquired->tgid)
>> +        goto out;
>> +
>> +    cgrp = bpf_cgroup_from_id(cgid);
>> +    if (!cgrp)
>> +        goto out;
>> +
>> +    if (bpf_task_under_cgroup(acquired, cgrp))
>> +        remote_pid = acquired->tgid;
>> +
>> +out:
>> +    if (acquired)
>> +        bpf_task_release(acquired);
>> +    if (cgrp)
>> +        bpf_cgroup_release(cgrp);
> 
> Let us do:
> out:
>      if (cgrp)
>          bpf_cgroup_release(cgrp);
>      bpf_task_release(acquired);
> 
>> +    return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";

