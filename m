Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4577D2B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbjHOS6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjHOS6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:58:13 -0400
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78532108
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 11:58:03 -0700 (PDT)
Message-ID: <afdc1b5f-650e-99a6-7fe8-ccd6463066f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692125880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5DcgThCjjtE1+nYureWow+fA/SCBcwrGd6zc9WACKM=;
        b=rSvIj7fRML9vmcrA9nhPpNeVu4VEXDPVQZGAKxuORdlmijW7hssGuyZy9lT+z9uiFzAG5p
        89liqVk4ra5EJjydxE7yrMUDLiQ1MOXke6kbk+6Ajwkeg7Bejl7HC+Akd7JykIlbGd/GM7
        5tWVZG8W0DWS9XWMzfXR98ebD5W3PWE=
Date:   Tue, 15 Aug 2023 11:57:52 -0700
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next v13 4/4] selftests/bpf: Add mptcpify test
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
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1691808484.git.geliang.tang@suse.com>
 <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
 <00809f4a-e7ca-bf53-7824-e22791ee6738@linux.dev>
 <20230815100816.GA24858@bogon>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230815100816.GA24858@bogon>
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

On 8/15/23 3:08 AM, Geliang Tang wrote:
> On Mon, Aug 14, 2023 at 11:23:49PM -0700, Martin KaFai Lau wrote:
>> On 8/11/23 7:54 PM, Geliang Tang wrote:
>>> +static int verify_mptcpify(int server_fd)
>>> +{
>>> +	socklen_t optlen;
>>> +	char cmd[256];
>>> +	int protocol;
>>> +	int err = 0;
>>> +
>>> +	optlen = sizeof(protocol);
>>> +	if (!ASSERT_OK(getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen),
>>> +		       "getsockopt(SOL_PROTOCOL)"))
>>> +		return -1;
>>> +
>>> +	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "protocol isn't MPTCP"))
>>> +		err++;
>>> +
>>> +	/* Output of nstat:
>>> +	 *
>>> +	 * #kernel
>>> +	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
>>> +	 */
>>> +	snprintf(cmd, sizeof(cmd),
>>> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
>>> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
>>> +		 "NR==1 {next} {print $2}", "1");
>>
>> Is the mp-capable something that the regular mptcp user want to learn from a
>> fd also? Does it have a simpler way like to learn this, eg. getsockopt(fd,
>> SOL_MPTCP, MPTCP_xxx), instead of parsing text output?
> 
> Thanks Martin. Yes, you're right. A better one is using getsockopt
> (MPTCP_INFO) to get the mptcpi_flags, then test the FALLBACK bit to make
> sure this MPTCP connection didn't fallback. This is, in other word, this
> MPTCP connection has been established correctly. Something like this:
> 
> +       optlen = sizeof(info);
> +       if (!ASSERT_OK(getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &optlen),
> +                      "getsockopt(MPTCP_INFO)"))
> +               return -1;
> +
> +       if (!ASSERT_FALSE(info.mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK,
> +                         "MPTCP fallback"))
> +               err++;
> 
> It's necessary to add this further check after the MPTCP protocol check
> using getsockopt(SOL_PROTOCOL). Since in some cases, the MPTCP protocol
> check is not enough. Say, if we change TCP protocol into MPTCP using
> "cgroup/sock_create", the hook of BPF_CGROUP_RUN_PROG_INET_SOCK in
> inet_create(), this place is too late to change the protocol. Although
> sk->sk_protocol is set to MPTCP correctly, and the MPTCP protocol check
> using getsockopt(SOL_PROTOCOL) will pass. This MPTCP connection will
> fallback to TCP connection. So this further check is needed.

If I read it correctly, it sounds like the "ip netns... nstat.... awk...grep..." 
can be replaced with the getsockopt(MPTCP_INFO)?  If that is the case, could you 
respin one more time to do getsockopt(MPTCP_INFO) instead? I would like the test 
to avoid parsing text output and have less dependency on external binary/library 
if possible (On top of 'ip', the above uses nstat, awk, grep...). This will make 
the bpf CI and other developers' environment tricky to maintain. eg. fwiw, 
although unrelated to the commands used above, my dev environment suddenly like 
to give this text output when I run "e"grep: "egrep: warning: egrep is 
obsolescent; using grep -E"

>>
>>> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
>>
>>

