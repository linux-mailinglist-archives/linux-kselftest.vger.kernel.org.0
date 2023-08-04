Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0E76F8E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 06:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDE0o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 00:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHDE0n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 00:26:43 -0400
Received: from out-98.mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803694229
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 21:26:41 -0700 (PDT)
Message-ID: <de5118d6-3dfe-9185-dbfa-c797f2821ce2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691123197; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m082I1X9tbhjiROnfjM2jHYq1ftKJQeenvc+niZ4Cz4=;
        b=r7HILlHe7qtM8mdPN1M9YxKznXH26/pkhJZWm8x4FppG3rvuS7a0kxExrHjfW44V6uoGm3
        WfzZ8o6wxbk087JzIhHSJkwcUWal+76Bn8tcBHo+WOIIrDgb9wwYTccBs/1mfdKzsy0qdK
        xQTi76W9uccn4yQOKHqHlmCiY7IOsJs=
Date:   Thu, 3 Aug 2023 21:26:24 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v9 4/4] selftests/bpf: Add mptcpify test
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
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
References: <cover.1691069778.git.geliang.tang@suse.com>
 <92ee6be5a465601ff3a2df29b6a517086e87ca3c.1691069778.git.geliang.tang@suse.com>
 <1bf7f5cf-a944-a284-28af-83a6603542fb@linux.dev>
 <20230804022459.GA28296@localhost>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230804022459.GA28296@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/3/23 7:24 PM, Geliang Tang wrote:
> Hi Yonghong,
> 
> On Thu, Aug 03, 2023 at 06:23:57PM -0700, Yonghong Song wrote:
>>
>>
>> On 8/3/23 6:41 AM, Geliang Tang wrote:
>>> Implement a new test program mptcpify: if the family is AF_INET or
>>> AF_INET6, the type is SOCK_STREAM, and the protocol ID is 0 or
>>> IPPROTO_TCP, set it to IPPROTO_MPTCP. It will be hooked in
>>> update_socket_protocol().
>>>
>>> Extend the MPTCP test base, add a selftest test_mptcpify() for the
>>> mptcpify case. Open and load the mptcpify test prog to mptcpify the
>>> TCP sockets dynamically, then use start_server() and connect_to_fd()
>>> to create a TCP socket, but actually what's created is an MPTCP
>>> socket, which can be verified through the outputs of 'ss' and 'nstat'
>>> commands.
>>>
>>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>    .../testing/selftests/bpf/prog_tests/mptcp.c  | 94 +++++++++++++++++++
>>>    tools/testing/selftests/bpf/progs/mptcpify.c  | 25 +++++
>>>    2 files changed, 119 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index 4407bd5c9e9a..caab3aa6a162 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -6,6 +6,7 @@
>>>    #include "cgroup_helpers.h"
>>>    #include "network_helpers.h"
>>>    #include "mptcp_sock.skel.h"
>>> +#include "mptcpify.skel.h"
>>>    char NS_TEST[32];
>>> @@ -195,8 +196,101 @@ static void test_base(void)
>>>    	close(cgroup_fd);
>>>    }
>>> +static void send_byte(int fd)
>>> +{
>>> +	char b = 0x55;
>>> +
>>> +	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
>>> +}
>>> +
>>> +static int verify_mptcpify(void)
>>> +{
>>> +	char cmd[256];
>>> +	int err = 0;
>>> +
>>> +	snprintf(cmd, sizeof(cmd),
>>> +		 "ip netns exec %s ss -tOni | grep -q '%s'",
>>> +		 NS_TEST, "tcp-ulp-mptcp");
>>
>> Could you show what is the expected output from the above command line
>>    ip netns exec %s ss -tOni
>> ?
>> This way, users can easily reason about the ss states based on tests.
> 
> There're too many items in the output of command 'ip netns exec %s ss -tOni':
> 
> '''
> State Recv-Q Send-Q Local Address:Port  Peer Address:Port Process
> ESTAB 0      0          127.0.0.1:42225    127.0.0.1:44180 cubic wscale:7,7 rto:201 rtt:0.034/0.017 ato:40 mss:16640 pmtu:65535 rcvmss:536 advmss:65483 cwnd:10 bytes_received:1 segs_out:1 segs_in:3 data_segs_in:1 send 39152941176bps lastsnd:7 lastrcv:7 lastack:7 pacing_rate 78305882352bps delivered:1 app_limited rcv_space:33280 rcv_ssthresh:33280 minrtt:0.034 snd_wnd:33280 tcp-ulp-mptcp flags:Mec token:0000(id:0)/3a1e0d3c(id:0) seq:c2802f11c5228db6 sfseq:1 ssnoff:49d3c135 maplen:1
> ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic wscale:7,7 rto:201 rtt:0.036/0.02 mss:16640 pmtu:65535 rcvmss:536 advmss:65483 cwnd:10 bytes_sent:1 bytes_acked:2 segs_out:3 segs_in:2 data_segs_out:1 send 36977777778bps lastsnd:7 lastrcv:7 lastack:7 pacing_rate 72200677960bps delivery_rate 8874666664bps delivered:2 rcv_space:33280 rcv_ssthresh:33280 minrtt:0.015 snd_wnd:33280 tcp-ulp-mptcp flags:Mmec token:0000(id:0)/39429ce(id:0) seq:e3ed00de37c805c sfseq:1 ssnoff:d4e4d561 maplen:0
> '''
> 
> We only care about this 'tcp-ulp-mptcp' item.
> 
> Show all output will confuse users. So we just pick and test the only
> item we care.

Thanks. Originally I thought at least we should put one line in
the comment which has 'tcp-ulp-mptcp' like

ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic 
wscale:7,7 rto:201 rtt:0.036/0.02 mss:16640 pmtu:65535 rcvmss:536 
advmss:65483 cwnd:10 bytes_sent:1 bytes_acked:2 segs_out:3 segs_in:2 
data_segs_out:1 send 36977777778bps lastsnd:7 lastrcv:7 lastack:7 
pacing_rate 72200677960bps delivery_rate 8874666664bps delivered:2 
rcv_space:33280 rcv_ssthresh:33280 minrtt:0.015 snd_wnd:33280 
tcp-ulp-mptcp flags:Mmec token:0000(id:0)/39429ce(id:0) 
seq:e3ed00de37c805c sfseq:1 ssnoff:d4e4d561 maplen:0

or simplified version

ESTAB 0      0          127.0.0.1:44180    127.0.0.1:42225 cubic
... tcp-ulp-mptcp flags:Mmec ...

But people familiar with 'ss' should be able to dump it and get
the above (maybe without tcp-ulp-mptcp) easily. So I am okay
with no additional comments.

> 
>>
>>> +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
>>> +		err++;
>>> +
>>> +	snprintf(cmd, sizeof(cmd),
>>> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
>>> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
>>> +		 "NR==1 {next} {print $2}", "1");
>>
>> The same thing here. Could you show the expected output with
>>     ip netns exec %s nstat -asz %s
>> ?
> 
> The output of 'ip netns exec %s nstat -asz %s' is:
> 
> '''
> #kernel
> MPTcpExtMPCapableSYNACKRX       1                  0.0
> '''
> 
> The same, we only check if it contains an MPTcpExtMPCapableSYNACKRX, not
> show the output.
> 
> -Geliang
> 
>>
>>> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
>>> +		err++;
>>> +
>>> +	return err;
>>> +}
>>> +
>> [...]
