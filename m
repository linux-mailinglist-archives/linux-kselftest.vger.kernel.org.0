Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0682778722
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 07:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjHKFx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 01:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjHKFxy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 01:53:54 -0400
Received: from out-66.mta1.migadu.com (out-66.mta1.migadu.com [IPv6:2001:41d0:203:375::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F782D43
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 22:53:52 -0700 (PDT)
Message-ID: <ffd1bb86-ed32-3301-346a-e369219841de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691733229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0vN514ycLDgfH8MPcX9gq+8dxj3gNQV5oVnf0li0cE=;
        b=JGmgvn6cT7iTucUb6YruBhmAOZ9kEYGTR86F5nxUdlIxB1sAjLg16WTdyyeLeQTmzqgKdH
        jGa16MemhcwHh+bjncETZ1dIBXUzxGMceG+QpeyqE8KeRwXCnrlguN+d04BUCLqtJo7fjP
        XWZKQ8rVNuEVS9ZwUFm0eyigLr88Kog=
Date:   Thu, 10 Aug 2023 22:53:38 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
 <20230807064044.GA11180@localhost.localdomain>
 <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
 <20230809081944.GA29707@bogon>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230809081944.GA29707@bogon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/23 1:19 AM, Geliang Tang wrote:
> On Tue, Aug 08, 2023 at 11:03:30PM -0700, Martin KaFai Lau wrote:
>> On 8/6/23 11:40 PM, Geliang Tang wrote:
>>> On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
>>>> On 8/3/23 10:07 PM, Geliang Tang wrote:
>>>>> Use rand() to generate a random netns name instead of using the fixed
>>>>> name "mptcp_ns" for every test.
>>>>>
>>>>> By doing that, we can re-launch the test even if there was an issue
>>>>> removing the previous netns or if by accident, a netns with this generic
>>>>> name already existed on the system.
>>>>>
>>>>> Note that using a different name each will also help adding more
>>>>> subtests in future commits.
>>>
>>> Hi Martin,
>>>
>>> I tried to run mptcp tests simultaneously, and got "Cannot create
>>> namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
>>> So I add this patch to fix it.
>>>
>>> It's easy to reproduce, just run this commands in multiple terminals:
>>>    > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done
>>
>> Not only the "-t mptcp" test. Other tests in test_progs also don't support
>> running parallel in multiple terminals. Does it really help to test the bpf
>> part of the prog_tests/mptcp.c test by running like this? If it wants to
>> exercise the other mptcp networking specific code like this, a separate
>> mptcp test is needed outside of test_progs and it won't be run in the bpf
>> CI.
>>
>> If you agree, can you please avoid introducing unnecessary randomness to the
>> test_progs where bpf CI and most users don't run in this way?
> 
> Thanks Martin. Sure, I agree. Let's drop this patch.

Thanks you.

>> I have a high level question. In LPC 2022
>> (https://lpc.events/event/16/contributions/1354/), I recall there was idea
>> in using bpf to make other mptcp decision/policy. Any thought and progress
>> on this? This set which only uses bpf to change the protocol feels like an
>> incomplete solution.
> 
> We are implementing MPTCP packet scheduler using BPF. Patches aren't
> sent to BPF mail list yet, only temporarily on our mptcp repo[1].
> 
> Here are the patches:
> 
>   selftests/bpf: Add bpf_burst test
>   selftests/bpf: Add bpf_burst scheduler
>   bpf: Export more bpf_burst related functions
>   selftests/bpf: Add bpf_red test
>   selftests/bpf: Add bpf_red scheduler
>   selftests/bpf: Add bpf_rr test
>   selftests/bpf: Add bpf_rr scheduler
>   selftests/bpf: Add bpf_bkup test
>   selftests/bpf: Add bpf_bkup scheduler
>   selftests/bpf: Add bpf_first test
>   selftests/bpf: Add bpf_first scheduler
>   selftests/bpf: Add bpf scheduler test
>   selftests/bpf: add two mptcp netns helpers
>   selftests/bpf: use random netns name for mptcp
>   selftests/bpf: Add mptcp sched structs
>   bpf: Add bpf_mptcp_sched_kfunc_set
>   bpf: Add bpf_mptcp_sched_ops
> 
> If you could take a look at these patches in advance, I would greatly
> appreciate it. Any feedback is welcome.
> 
> [1]
> https://github.com/multipath-tcp/mptcp_net-next.git

Thanks for sharing. I did not go into the details. iiuc, the scheduler is 
specific to a namespace. Do you see if it is useful to have more finer control 
like depending on what IP address it is connected to? BPF policy is usually 
found more useful to have finer policy control than global or per-netns.

The same question goes for the fmod_ret here in this patch. The progs/mptcpify.c 
selftest is as good as upgrading all TCP connections. Is it your only use case 
and no need for finer selection?

