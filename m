Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC6F7DBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEEHZL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjEEHZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 03:25:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2384A1208B
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 00:25:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so1384142a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 May 2023 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683271508; x=1685863508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/qdnaVHGbo5sTEeG8RkWLSuEiz/WhzVfQSjPiv7Kp4=;
        b=Hvx4r0ofBjpdT7u3lf4oHfHRPM9T1pMafCIv4Ki1xguK5s1GjC7YApxubklmXIrZAL
         FurWPA9auBohvJE/RQ1NEqAz7iHi/fD/Spk2QhtVf4JI5x/KtfUQMH5nZZ3LoxUG12p/
         VwKT5Gb5QXCCgQUF4L0DKyPL9C+zCC/Dckq2935/OU7AXz2HnhxwBY9YULsQagiRE4T+
         lahuNbTZ0hLjwpSD/Ra/KE/sk/3oa1UgBjDWz0C0ruCY605nVr6xu26aWeFD6tF+VSAT
         s+zfkp4PMrVKdJ21LfqOa6VKs/lzuwn3/Wx7DR9xN/gESHi6JaSfkynTQWt5mCJZ60WR
         0X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683271508; x=1685863508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/qdnaVHGbo5sTEeG8RkWLSuEiz/WhzVfQSjPiv7Kp4=;
        b=YlHp2xyhl5PFRonM2/y7xECjxt6rs2h0yyvX6IQMxFs338MPV0YobQsTb8t3namd1p
         icvFZvlci+/LeZee/q/WHr64EOx1COEg91VSsohbF+yJi6VLkpt3TFo9utvAshZPSuPh
         f1pwT26LusmKmX04bx/q6cCkiDMu40tpThTcwF0UZBS0o/lIDLgSci33ym42rWBSfrbT
         3IhChOxV63pzSOi2t1Zy7u5tFgqyMYjdnjAejjXXA7Yq9oubjiw3mDeBT6hBUSP9lyIY
         fqpH0zoycu7P7vTk5T68xqeymZK7mYaL1nvMfUqaY2RH7U03sKI1KFw6ihwOKtdgd0Yg
         dlzQ==
X-Gm-Message-State: AC+VfDw7hKnxmNbxiMR5Ym+vUKgYGb1ip8ZN3l3bt+VUBEjodA5667vR
        4QmZ4hM8L+aaUnPvT8SmxIeaqw==
X-Google-Smtp-Source: ACHHUZ67RZhfjPIsI+RI1hVc64uLyzcO4dFlk9fem+VubK53ckCJsorOKHDKpaeSgSlGWfiiMLfWfA==
X-Received: by 2002:a17:902:7c07:b0:1aa:e739:4097 with SMTP id x7-20020a1709027c0700b001aae7394097mr494944pll.5.1683271508646;
        Fri, 05 May 2023 00:25:08 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902b70400b001a661000398sm934599pls.103.2023.05.05.00.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:25:08 -0700 (PDT)
Message-ID: <194f1ac1-6bb0-e3fc-5394-ad5cb95721d0@bytedance.com>
Date:   Fri, 5 May 2023 15:24:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add testcase for
 bpf_task_under_cgroup
To:     Hao Luo <haoluo@google.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com>
 <20230505060818.60037-3-zhoufeng.zf@bytedance.com>
 <CA+khW7hZb6EJcoXUzkvrHKztsQ_J4cN+RRQjF-a73A8zE8S_NA@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CA+khW7hZb6EJcoXUzkvrHKztsQ_J4cN+RRQjF-a73A8zE8S_NA@mail.gmail.com>
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

在 2023/5/5 15:13, Hao Luo 写道:
> On Thu, May 4, 2023 at 11:08 PM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>
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
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Hi Feng,
> 
> I have a comment about the methodology of the test, but the patch
> looks ok to me. Why do we have to test via a tracing program? I think
> what we need is just a task and a cgroup. Since we have the kfunc
> bpf_task_from_pid() and bpf_cgroup_from_id(), we can write a syscall
> program which takes a pid and a cgroup id as input and get the task
> and cgroup objects directly in the program.
> 
> I like testing via a syscall program because it doesn't depend on the
> newtask tracepoint and it should be simpler. But I'm ok with the
> current version of the patch, just have some thoughts.
> 
> Hao

Yes, your method is also very good. The reason why I did this is because 
of Song's suggestion before, hope that the parameter of the hook point 
will have a task, so I chose this to test.
