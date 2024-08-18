Return-Path: <linux-kselftest+bounces-15588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD91955A91
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 04:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFF41C20AAE
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C62900;
	Sun, 18 Aug 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVx0K4JS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946FF2581;
	Sun, 18 Aug 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723947207; cv=none; b=RyB83anuXUri2wPxG+bF6sSOc0/0mfnX0h1jDzlUUUp0uYd0noEzO/zuQKGwlApt7ClOw9CWtX8pgpuFPYsVCyR6a8p67ZP6WzH3Ieg+3Yxx0rq/DrrCYZVrHh5Q+R0HC4XcZx+Sy+fgYvsiA7wOOiQwoHGMTUdSXvfdd4ShG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723947207; c=relaxed/simple;
	bh=BrdPWcqAOYdeEhwl679VOuDPNfbtrI20oqwd3LsX580=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZUkefejAzfC/aDPvcbdRdXqBP/Dg3NaC3ZXoAcPn59+RIRlPgW7QwrT1O1C+zNhhE/stLXphlem7wcNsqVy63S+vSTyfAgHPp4gSH8GxUwfUJNyDznMXP1AqoxpsYMTzy8Maepjfoqtv6AmH+5xRYSOpksX/qNKojZ7fKKP9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVx0K4JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E84BC116B1;
	Sun, 18 Aug 2024 02:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723947206;
	bh=BrdPWcqAOYdeEhwl679VOuDPNfbtrI20oqwd3LsX580=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NVx0K4JSZsEg9P79KKaHwToGVhp023NLSPong7wSPdICkRm/h2zWnckZnmXU+QQ3F
	 vCt9T46akcIzAhs2L6S5exDyXyxxN2IWBezTcI7dOi951MmpWvfvGqrDmqy5YMpXZZ
	 Oqqb+L/5BWBG2qwIdQs2tS24wPvAnK/qbHDAQJ36epNB9FUgcmSnsdkrffaA3dY92y
	 erFEN8in/3aWQS7vSKM65b1Ud0Sf51hCof5n5lUkwjyN0dcTKudIStsHbohZEy7+JX
	 /PTZYjsAOuO2dcpttXOSUdl15FkTW419tyA7mmQezaQY/iuM/msjRoD0NCb3+ZZITx
	 do2/smE2fmQdg==
Message-ID: <db295f729981cd0eaebb93c5939b515f50882c11.camel@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add mptcp subflow subtest
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola
 Lysenko <mykolal@fb.com>,  Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Daniel Xu <dxu@dxuuu.xyz>, Manu Bretelle <chantra@meta.com>
Date: Sun, 18 Aug 2024 10:13:18 +0800
In-Reply-To: <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
References: 
	<20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-0-2b4ca6994993@kernel.org>
	 <20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org>
	 <2136317a-3e95-4993-b2fc-1f3b2c28dbdc@linux.dev>
	 <8a2ff1bd-52dc-421d-87b7-fc2f56e81da2@kernel.org>
	 <716cbd56-4a44-4451-a6f3-5bacef3e0729@linux.dev>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Martin, Matt,

On Wed, 2024-08-14 at 15:37 -0700, Martin KaFai Lau wrote:
> On 8/14/24 3:04 AM, Matthieu Baerts wrote:
> > Hi Martin,
> > 
> > Thank you for your reply!
> > 
> > On 14/08/2024 03:12, Martin KaFai Lau wrote:
> > > On 8/5/24 2:52 AM, Matthieu Baerts (NGI0) wrote:
> > > > +static int endpoint_init(char *flags)
> > > > +{
> > > > +    SYS(fail, "ip -net %s link add veth1 type veth peer name
> > > > veth2",
> > > > NS_TEST);
> > > > +    SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST,
> > > > ADDR_1);
> > > > +    SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> > > > +    SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST,
> > > > ADDR_2);
> > > > +    SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > > > +    if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s",
> > > > NS_TEST,
> > > > ADDR_2, flags)) {
> > > > +        printf("'ip mptcp' not supported, skip this test.\n");
> > > > +        test__skip();
> > > 
> > > It is always a skip now in bpf CI:
> > > 
> > > #171/3   mptcp/subflow:SKIP
> > > 
> > > This test is a useful addition for the bpf CI selftest.
> > > 
> > > It can't catch regression if it is always a skip in bpf CI
> > > though.
> > 
> > Indeed, for the moment, this test is skipped in bpf CI.
> > 
> > The MPTCP CI checks the MPTCP BPF selftests that are on top of net
> > and
> > net-next at least once a day. It is always running with the last
> > stable
> > version of iproute2, so this test is not skipped:
> > 
> >     #169/3   mptcp/subflow:OK
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10384566794/job/28751869426#step:7:11080
> > 
> > > iproute2 needs to be updated (cc: Daniel Xu and Manu, the
> > > outdated
> > > iproute2 is something that came up multiple times).
> > > 
> > > Not sure when the iproute2 can be updated. In the mean time, your
> > > v3 is
> > > pretty close to getting pm_nl_ctl compiled. Is there other
> > > blocker on this?
> > 
> > I will try to find some time to check the modifications I suggested
> > in
> > the v3, but I don't know how long it will take to have them ready,
> > as
> > they might require some adaptations of the CI side as well, I need
> > to
> > check. On the other hand, I understood adding a duplicated version
> > of
> > the mptcp.h UAPI header is not an option either.
> > 
> > So not to block this (already old) series, I thought it would help
> > to
> > first focus on this version using 'ip mptcp', while I'm looking at
> > the
> > selftests modifications. If these modifications are successful, I
> > can
> > always resend the patch 2/3 from the v3 later, and using
> > 'pm_nl_ctl'
> > instead of 'ip mptcp', to be able to work with IPRoute2 5.5.
> > 
> > Do you think that could work like that?
> 
> If there is CI started covering it, staying with the 'ip mptcp' is
> fine.
> 
> The bpf CI has to start testing it asap also. The iproute2 package
> will need to 
> be updated on the bpf CI side. I think this has to be done
> regardless.
> 
> It will be useful to avoid the uapi header dup on its own. The last
> one you have 
> seems pretty close.
> 
> > 
> > > > +        goto fail;
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +fail:
> > > > +    return -1;
> > > > +}
> > > > +
> > > > +static int _ss_search(char *src, char *dst, char *port, char
> > > > *keyword)
> > > > +{
> > > > +    return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst
> > > > %s %s %d
> > > > > grep -q '%s'",
> > > > +              NS_TEST, src, dst, port, PORT_1, keyword);
> > > > +}
> > > > +
> > > > +static int ss_search(char *src, char *keyword)
> > > > +{
> > > > +    return _ss_search(src, ADDR_1, "dport", keyword);
> > > > +}
> > > > +
> > > > +static void run_subflow(char *new)
> > > > +{
> > > > +    int server_fd, client_fd, err;
> > > > +    char cc[TCP_CA_NAME_MAX];
> > > > +    socklen_t len = sizeof(cc);
> > > > +
> > > > +    server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1,
> > > > 0);
> > > > +    if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> > > > +        return;
> > > > +
> > > > +    client_fd = connect_to_fd(server_fd, 0);
> > > > +    if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> > > > +        goto fail;
> > > > +
> > > > +    err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc,
> > > > &len);
> > > > +    if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
> > > > +        goto fail;
> > > > +
> > > > +    send_byte(client_fd);
> > > > +
> > > > +    ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search
> > > > fwmark:0x1");
> > > > +    ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search
> > > > fwmark:0x2");
> > > > +    ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> > > > +    ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> > > 
> > > Is there a getsockopt way instead of ss + grep?
> > 
> > No there isn't: from the userspace, the app communicates with the
> > MPTCP
> > socket, which can have multiple paths (subflows, a TCP socket). To
> > keep
> > the compatibility with TCP, [gs]etsockopt() will look at/modify the
> > whole MPTCP connection. For example, in some cases, a setsockopt()
> > will
> > propagate the option to all the subflows. Depending on the option,
> > the
> > modification might only apply to the first subflow, or to the
> > user-facing socket.
> > 
> > For advanced users who want to have different options set to the
> > different subflows of an MPTCP connection, they can use BPF: that's
> > what
> > is being validated here. In other words, doing a 'getsockopt()'
> > from the
> > userspace program here will not show all the different marks and
> > TCP CC
> > that can be set per subflow with BPF. We can see that in the test:
> > a
> > getsockopt() is done on the MPTCP socket to retrieve the default
> > TCP CC
> > ('cc' which is certainly 'cubic'), but we expect to find another
> > one
> > ('new' which is 'reno'), set by the BPF program from patch 1/2. I
> > guess
> > we could use bpf to do a getsockopt() per subflow, but that's seems
> > a
> > bit cheated to have the BPF test program setting something and
> > checking
> > if it is set. Here, it is an external way. Because it is done from
> > a
> 
> I think the result is valid by having a bpf prog to inspect the value
> of a sock. 
> Inspecting socket is an existing use case. There are many existing
> bpf tests 
> covering this inspection use case to ensure the result is legit. A
> separate 
> cgroup/getsockopt program should help here (more on this below).
> 
> > dedicated netns, it sounds OK to do that, no?
> 
> Thanks for the explanation. I was hoping there is a way to get to the
> underlying 
> subflow fd. It seems impossible.
> 
> In the netns does help here. It is not only about the ss iterating a
> lot of 
> connections or not. My preference is not depending on external
> tool/shell-ing if 
> possible, e.g. to avoid the package update discussion like the
> iproute2 here. 
> The uapi from the testing kernel is always up-to-date. ss is another
> binary but 
> arguably in the same iproute2 package. There is now another extra
> "grep" and 
> pipe here. We had been bitten by different shell behaviors and some
> arch has 
> different shells ...etc.
> 
> I think it is ok to take this set as is if you (and Gelang?) are ok
> to followup 
> a "cgroup/getsockopt" way to inspect the subflow as the very next
> patch to the 
> mptcp selftest. It seems inspecting subflow will be a common test
> going forward 
> for mptcp, so it will be beneficial to have a "cgroup/getsockopt" way
> to inspect 
> the subflow directly.
> 
> Take a look at a recent example [0]. The mptcp test is under a cgroup
> already 
> and has the cgroup setup. An extra "cgroup/getsockopt" prog should be
> enough. 
> That prog can walk the msk->conn_list and use bpf_rdonly_cast (or the

I encountered some difficulties while walking the msk->conn_list in
BPF.

I added mptcp_for_iach_stubflow() and other helpers related to
list_dentry into progs/mptcp_bpf.h:

static inline int list_is_head(const struct list_head *list, const
struct list_head *head)
{
        return list == head;
}

#define list_entry(ptr, type, member) \
        container_of(ptr, type, member)

#define list_first_entry(ptr, type, member) \
        list_entry((ptr)->next, type, member)

#define list_next_entry(pos, member) \
        list_entry((pos)->member.next, typeof(*(pos)), member)

#define list_entry_is_head(pos, head, member) \
        list_is_head(&pos->member, (head))

#define list_for_each_entry(pos, head, member) \
        for (pos = list_first_entry(head, typeof(*pos), member); \
             !list_entry_is_head(pos, head, member); \
             pos = list_next_entry(pos, member))

#define mptcp_for_each_subflow(__msk, __subflow) \
        list_for_each_entry(__subflow, &((__msk)->conn_list), node)

Then used them in progs/mptcp_subflow.c like this:

SEC("cgroup/getsockopt")
int _getsockopt(struct bpf_sockopt *ctx)
{
        struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
mptcp_sock);
        struct mptcp_subflow_context *subflow;
        __u32 token = 0;

        if (!msk || ctx->level != SOL_TCP ||
			ctx->optname != TCP_CONGESTION)
                return 1;

        subflow = list_first_entry(&msk->conn_list,
			struct mptcp_subflow_context, node);
        token = subflow->token;
        bpf_trace_printk(fmt, sizeof(fmt), msk, token); 

        return 1;
}

And got some access errors:

; token = subflow->token; @ mptcp_subflow.c:92
13: (61) r4 = *(u32 *)(r1 +524)
access beyond struct list_head at off 524 size 4

How can I resolve these errors? Shouldn't I walk the msk->conn_list
like this? Or use bpf_iter instead? Please give me some advice?

Thanks,
-Geliang

> bpf_core_cast macro in libbpf) to cast a pointer to tcp_sock for
> readonly. It 
> will allow to inspect all the fields in a tcp_sock.
> 
> Something needs to a fix in patch 2(replied separately), so a re-spin
> is needed.
> 
> pw-bot: cr
> 
> [0]:
> https://lore.kernel.org/all/20240808150558.1035626-3-alan.maguire@oracle.com/
> 
> 
> 


