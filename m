Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40273A51B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjFVPeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjFVPdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 11:33:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297219BE;
        Thu, 22 Jun 2023 08:33:51 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57028539aadso79708547b3.2;
        Thu, 22 Jun 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687448031; x=1690040031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9YxWAFEqb4aZB9la7sp5IBlusGAGgOD1WQIKix2beE=;
        b=WgXpp27PsTA2f7oImGzQO1HHaL2zDsgBS5U2220/lWFYA335AuUNNaIbaf43YvVS4S
         Ey7x6iAIgJVfnJYaw4xx+g/t1OF58aQlMJ4hrSSMHxWKlornrDN6xySVX8ol7VfifVl0
         hd8zHggoy87BXc/vAByXw2y19FvG8bcMSGhdxmAqSm1Q7P7PqvmhIZ7stf3bFlqbC11p
         YHas+T23Ub9NyXEp4IV+IGqI2u0yZNp37CM3gB+5CmYIQUgRXqYUf3sl9SLBLRRqr1tY
         iVkbxFspCrcfuDxcDudA5bFPC+Jfs36mRicammnqhTnVc2tNtS17U7lR+jSioEwChBdW
         8eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687448031; x=1690040031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9YxWAFEqb4aZB9la7sp5IBlusGAGgOD1WQIKix2beE=;
        b=RTZly2wVLXoIiitvxguxY1w1VMFBjREYTBZPcJaPiW8TJgRWjUk1h7LEMcej84RJ4O
         GVIfxPyajyXhfFA19FYR3PYlHkkEq04Doq/4RMnGDliFh8N5tnVLnd13fYBjMVTQ/ceX
         9BZTvjvMdYGfpaFAQxkuh1LLfZQAPHIj9kSSKUDyUvr2WUqeKmGiesz5maIc32wAIchM
         wUB64SzUnIdWsQcO1XJHIGxaMbXmgHiKNCM1Ibk7F5sq0GB55dhfdAENAWQVMDFeX1VX
         knF9G6vveU5TN7iwzmfEGYMy3+kiKj4OXfAGFsYLEgk5qm6s9zjfrgYY2dYb0OggD4MH
         eXLA==
X-Gm-Message-State: AC+VfDzGqrvaNmRQiViPj8RTtZW6rCAFA2QAeZkrC2rw+VkGjrY2sCzS
        py2jTm+Jgi1pj87kDYdLAkk=
X-Google-Smtp-Source: ACHHUZ4LpykQWuRr1yrbo/g4sSuMng8kTi4NSslt/P8nMURwGshMz4hfSHUekExYnxIafxMfxFP/Yw==
X-Received: by 2002:a81:8007:0:b0:56d:40da:1fc2 with SMTP id q7-20020a818007000000b0056d40da1fc2mr19836528ywf.50.1687448030921;
        Thu, 22 Jun 2023 08:33:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9e96:aa3:eeff:a087? ([2600:1700:6cf8:1240:9e96:aa3:eeff:a087])
        by smtp.gmail.com with ESMTPSA id r188-20020a0de8c5000000b0056d1a2455c1sm1900962ywe.38.2023.06.22.08.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:33:50 -0700 (PDT)
Message-ID: <2e51ad4c-c264-9929-4549-669d1025d63b@gmail.com>
Date:   Thu, 22 Jun 2023 08:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Verify that the cgroup_skb
 filters receive expected packets.
To:     Yonghong Song <yhs@meta.com>, Kui-Feng Lee <thinker.li@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-3-kuifeng@meta.com>
 <bf4d7953-8c85-2de1-7fdc-0968da1767ab@meta.com>
Content-Language: en-US
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <bf4d7953-8c85-2de1-7fdc-0968da1767ab@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/21/23 21:15, Yonghong Song wrote:
> 
> 
> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>> This test case includes four scenarios:
>> 1. Connect to the server from outside the cgroup and close the connection
>>     from outside the cgroup.
>> 2. Connect to the server from outside the cgroup and close the connection
>>     from inside the cgroup.
>> 3. Connect to the server from inside the cgroup and close the connection
>>     from outside the cgroup.
>> 4. Connect to the server from inside the cgroup and close the connection
>>     from inside the cgroup.
>>
>> The test case is to verify that cgroup_skb/{egress, ingress} filters
>> receive expected packets including SYN, SYN/ACK, ACK, FIN, and FIN/ACK.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
>>   tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
>>   tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
>>   .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 399 ++++++++++++++++++
>>   .../selftests/bpf/progs/cgroup_tcp_skb.c      | 382 +++++++++++++++++
>>   5 files changed, 829 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c
>>
>> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c 
>> b/tools/testing/selftests/bpf/cgroup_helpers.c
>> index 9e95b37a7dff..2caee8423ee0 100644
>> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
>> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
>> @@ -277,6 +277,18 @@ int join_cgroup(const char *relative_path)
>>       return join_cgroup_from_top(cgroup_path);
>>   }
>> +/**
>> + * join_root_cgroup() - Join the root cgroup
>> + *
>> + * This function joins the root cgroup.
>> + *
>> + * On success, it returns 0, otherwise on failure it returns 1.
>> + */
>> +int join_root_cgroup(void)
>> +{
>> +    return join_cgroup_from_top(CGROUP_MOUNT_PATH);
>> +}
>> +
>>   /**
>>    * join_parent_cgroup() - Join a cgroup in the parent process workdir
>>    * @relative_path: The cgroup path, relative to parent process 
>> workdir, to join
>> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h 
>> b/tools/testing/selftests/bpf/cgroup_helpers.h
>> index f099a166c94d..5c2cb9c8b546 100644
>> --- a/tools/testing/selftests/bpf/cgroup_helpers.h
>> +++ b/tools/testing/selftests/bpf/cgroup_helpers.h
>> @@ -22,6 +22,7 @@ void remove_cgroup(const char *relative_path);
>>   unsigned long long get_cgroup_id(const char *relative_path);
>>   int join_cgroup(const char *relative_path);
>> +int join_root_cgroup(void);
>>   int join_parent_cgroup(const char *relative_path);
>>   int setup_cgroup_environment(void);
>> diff --git a/tools/testing/selftests/bpf/cgroup_tcp_skb.h 
>> b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
>> new file mode 100644
>> index 000000000000..1054b3633983
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/cgroup_tcp_skb.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2023 Facebook */
> 
> /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> 
>> +
>> +/* Define states of a socket to tracking messages sending to and from 
>> the
>> + * socket.
>> + *
>> + * These states are based on rfc9293 with some modifications to support
>> + * tracking of messages sent out from a socket. For example, when a 
>> SYN is
>> + * received, a new socket is transiting to the SYN_RECV state defined in
>> + * rfc9293. But, we put it in SYN_RECV_SENDING_SYN_ACK state and when
>> + * SYN-ACK is sent out, it moves to SYN_RECV state. With this 
>> modification,
>> + * we can track the message sent out from a socket.
>> + */
>> +
>> +#ifndef __CGROUP_TCP_SKB_H__
>> +#define __CGROUP_TCP_SKB_H__
>> +
>> +enum {
>> +    INIT,
>> +    CLOSED,
>> +    SYN_SENT,
>> +    SYN_RECV_SENDING_SYN_ACK,
>> +    SYN_RECV,
>> +    ESTABLISHED,
>> +    FIN_WAIT1,
>> +    FIN_WAIT2,
>> +    CLOSE_WAIT_SENDING_ACK,
>> +    CLOSE_WAIT,
>> +    CLOSING,
>> +    LAST_ACK,
>> +    TIME_WAIT_SENDING_ACK,
>> +    TIME_WAIT,
>> +};
>> +
>> +#endif /* __CGROUP_TCP_SKB_H__ */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c 
>> b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> new file mode 100644
>> index 000000000000..1b78e8ab3f02
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>> @@ -0,0 +1,399 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Facebook */
>> +#include <test_progs.h>
>> +#include <linux/in6.h>
>> +#include <sys/socket.h>
>> +#include <sched.h>
>> +#include <unistd.h>
>> +#include "cgroup_helpers.h"
>> +#include "testing_helpers.h"
>> +#include "cgroup_tcp_skb.skel.h"
>> +#include "cgroup_tcp_skb.h"
>> +
>> +#define CGROUP_TCP_SKB_PATH "/test_cgroup_tcp_skb"
>> +
>> +static int install_filters(int cgroup_fd,
>> +               struct bpf_link **egress_link,
>> +               struct bpf_link **ingress_link,
>> +               struct bpf_program *egress_prog,
>> +               struct bpf_program *ingress_prog,
>> +               struct cgroup_tcp_skb *skel)
>> +{
>> +    /* Prepare filters */
>> +    skel->bss->g_sock_state = 0;
>> +    skel->bss->g_unexpected = 0;
>> +    *egress_link =
>> +        bpf_program__attach_cgroup(egress_prog,
>> +                       cgroup_fd);
>> +    if (!ASSERT_NEQ(*egress_link, NULL, "egress_link"))
>> +        return -1;
> 
> !ASSERT_OK_PTR(...)

Sure!

> 
>> +    *ingress_link =
>> +        bpf_program__attach_cgroup(ingress_prog,
>> +                       cgroup_fd);
>> +    if (!ASSERT_NEQ(*ingress_link, NULL, "ingress_link"))
>> +        return -1;
> 
> !ASSERT_OK_PTR(...)
> 
>> +
>> +    return 0;
>> +}
>> +
>> +static void uninstall_filters(struct bpf_link **egress_link,
>> +                  struct bpf_link **ingress_link)
>> +{
>> +    bpf_link__destroy(*egress_link);
>> +    *egress_link = NULL;
>> +    bpf_link__destroy(*ingress_link);
>> +    *ingress_link = NULL;
>> +}
>> +
> [...]
>> +
>> +static int close_connection(int *closing_fd, int *peer_fd, int 
>> *listen_fd,
>> +                struct cgroup_tcp_skb *skel)
>> +{
>> +    __u32 saved_packet_count = 0;
>> +    int err;
>> +    int i;
>> +
>> +    /* Wait for ACKs to be sent */
>> +    saved_packet_count = skel->bss->g_packet_count;
>> +    usleep(100000);        /* 0.1s */
>> +    while (skel->bss->g_packet_count != saved_packet_count) {
>> +        saved_packet_count = skel->bss->g_packet_count;
>> +        usleep(100000);    /* 0.1s */
>> +    }
> 
> Should we put a limitation in the number of loop iterations
> just in case that something went wrong or too slow?

Sure! It make sense to me.

[...]
