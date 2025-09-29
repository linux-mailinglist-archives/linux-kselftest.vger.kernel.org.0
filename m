Return-Path: <linux-kselftest+bounces-42567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C3BA87AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 10:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40FE3C3DB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8D27F756;
	Mon, 29 Sep 2025 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oR2sH/11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7322045B7;
	Mon, 29 Sep 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136295; cv=none; b=aqus8fLPbtnMTHGZkeJs8h+rk6m0hVNAifWUxSU42u7Z/PSThJTc6oiTpeIOhip30812KC9/CZqFewpYEuQT68X/hlEwvMibFNp9VSChHTKrr+zeL/W6BPR9nT5T5MOMYF97tF1gPQE6D/4LPqJs5LEu1chcXYkkRgd7n2li+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136295; c=relaxed/simple;
	bh=kPyJwZajcIrfsAryOr4Zhm56MCN/CBXtjjFS4hvGfZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2Kduw9KI/9CM2n1w+gSG+u6kf/iPIs4ubfNlOLwRrP43x5OKKgq1Z3hx6RZEnZlva8a7bwLvS8MclbTBEKUDy3tf+cV5o5PT+TRddFx9cALEnJ887h2BQUkGDIJoUoxss0GxJWCHshae1fa+jypQ9MvJVYvarKayb4mkjon/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oR2sH/11; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EDC081A0FDA;
	Mon, 29 Sep 2025 08:58:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7445606AE;
	Mon, 29 Sep 2025 08:58:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03EC6102F183D;
	Mon, 29 Sep 2025 10:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759136283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IA4upKGkVVoh8UqeMuLrdhghOn3Qbp3K2AMCSyA8Bo0=;
	b=oR2sH/11xKpwWpute79UTBo379x6/iHym2DRBwn8GDL3kjT8Uz+CL1R8S36z+f6ZBsvo+I
	baotOzhP79xRoUtNAbg4MU1feNO/4zDneI3Okipq5gQTW3/XixYRXARQzYccsKXlXTCTYz
	XQ8jkcD9dm8ybpyAzYULnP/C3DbtFCT3A6rs4FPESI8altYqTgE4qBX2n7RADlW+YB+MyA
	ree9/s5DAjCnhFaUjG/MKF1vhYR7fWRBEfJj6OZ6UPcf1o3lENAFzhgI9oEmi9jDEqqZMq
	TOT6ahG3RHR+knFupLgdq8JemZ9UaXoQTitGVwoQsOhP0BPK5HBdzGXwz2DlLg==
Message-ID: <4c4edfc4-f69e-43d3-8bb7-95d00bad45c5@bootlin.com>
Date: Mon, 29 Sep 2025 10:57:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com>
 <20250924-xsk-v4-4-20e57537b876@bootlin.com> <aNVEiTJywHNJeEzL@boxer>
 <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com> <aNZ9VWLgNGHQg1Tv@boxer>
 <CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/27/25 1:19 PM, Alexei Starovoitov wrote:
> On Fri, Sep 26, 2025 at 12:47 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
>>
>> On Fri, Sep 26, 2025 at 08:39:28AM +0200, Bastien Curutchet wrote:
>>> Hi Maciej,
>>>
>>> On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
>>>> On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>>>>> testapp_stats_rx_dropped() generates pkt_stream twice. The last
>>>>> generated is released by pkt_stream_restore_default() at the end of the
>>>>> test but we lose the pointer of the first pkt_stream.
>>>>>
>>>>> Release the 'middle' pkt_stream when it's getting replaced to prevent
>>>>> memory leaks.
>>>>>
>>>>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>>>>> ---
>>>>>    tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
>>>>> index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c9337d16333b7174ecaed0999 100644
>>>>> --- a/tools/testing/selftests/bpf/test_xsk.c
>>>>> +++ b/tools/testing/selftests/bpf/test_xsk.c
>>>>> @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct test_spec *test)
>>>>>            struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
>>>>>            u32 i;
>>>>> + if (test->ifobj_rx->xsk->pkt_stream != test->rx_pkt_stream_default)
>>>>> +         /* Packet stream has already been replaced so we have to release this one.
>>>>> +          * The newly created one will be freed by the restore_default() at the
>>>>> +          * end of the test
>>>>> +          */
>>>>> +         pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
>>>>
>>>> I don't see why this one is not addressed within test case
>>>> (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_umem()).
>>>>
>>>
>>> pkt_stream_receive_half() can be used by other tests. I thought it would be
>>
>> So is pkt_stream_replace_half() and other routines that eventually call
>> pkt_stream_generate() and overwrite the pkt_stream, right?
>>
>> It just feels odd to have a special treatment in one function and other
>> are left as-is just because currently we don't have another abusive test
>> case.
>>
>> Maybe it's enough of bike-shedding here, just wanted to clarify on my POV.
>>
>> In the end don't get me wrong here, this interface is a bit PITA for me
>> and thanks for whole effort!
> 
> My reading of this discussion that it doesn't block the series
> and can be done in the follow up if necessary.
> 
> So I was planning to apply it, but it found real bugs:
> 
> ./test_progs -t xsk
> [   18.066989] bpf_testmod: loading out-of-tree module taints kernel.
> [   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
> [   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x11c98b
> [   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
> [   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000
> 0000000000000000
> [   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff
> 0000000000000000
> [   32.220900] page dumped because: page_pool leak
> [   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
> [   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G
>        O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
> [   32.224638] Tainted: [O]=OOT_MODULE
> [   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   32.224641] Call Trace:
> [   32.224644]  <IRQ>
> [   32.224646]  dump_stack_lvl+0x4b/0x70
> [   32.224653]  bad_page.cold+0xbd/0xe0
> [   32.224657]  __free_frozen_pages+0x838/0x10b0
> [   32.224660]  ? skb_pp_cow_data+0x782/0xc30
> [   32.224665]  bpf_xdp_shrink_data+0x221/0x530
> [   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
> [   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
> [   32.224673]  ? xsk_destruct_skb+0x321/0x800
> [   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
> [   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
> [   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
> [   32.224688]  ? veth_set_channels+0x920/0x920
> [   32.224691]  ? get_stack_info+0x2f/0x80
> [   32.224693]  ? unwind_next_frame+0x3af/0x1df0
> [   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
> [   32.224700]  ? common_startup_64+0x13e/0x148
> [   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
> [   32.224706]  ? stack_trace_save+0x84/0xa0
> [   32.224709]  ? stack_depot_save_flags+0x28/0x820
> [   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
> [   32.224716]  ? timerqueue_add+0x217/0x320
> [   32.224719]  veth_poll+0x115/0x5e0
> [   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
> [   32.224726]  ? update_load_avg+0x1cb/0x12d0
> [   32.224730]  ? update_cfs_group+0x121/0x2c0
> [   32.224733]  __napi_poll+0xa0/0x420
> [   32.224736]  net_rx_action+0x901/0xe90
> [   32.224740]  ? run_backlog_napi+0x50/0x50
> [   32.224743]  ? clockevents_program_event+0x1cc/0x280
> [   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
> [   32.224749]  handle_softirqs+0x151/0x430
> [   32.224752]  do_softirq+0x3f/0x60
> [   32.224755]  </IRQ>
> [   32.224756]  <TASK>
> [   32.224757]  __local_bh_enable_ip+0x58/0x60
> [   32.224759]  __dev_direct_xmit+0x295/0x540
> [   32.224762]  __xsk_generic_xmit+0x180a/0x2df0
> [   32.224764]  ? ___kmalloc_large_node+0xdf/0x130
> [   32.224767]  ? __mutex_unlock_slowpath.isra.0+0x330/0x330
> [   32.224770]  ? __rtnl_unlock+0x65/0xd0
> [   32.224773]  ? xsk_create+0x700/0x700
> [   32.224774]  ? netdev_run_todo+0xce/0xbe0
> [   32.224777]  ? _raw_spin_lock_irqsave+0x7b/0xc0
> [   32.224780]  xsk_sendmsg+0x365/0x770
> [   32.224782]  ? xsk_poll+0x640/0x640
> [   32.224783]  __sock_sendmsg+0xc1/0x150
> [   32.224787]  __sys_sendto+0x1d0/0x260
> [   32.224790]  ? __ia32_sys_getpeername+0xb0/0xb0
> [   32.224793]  ? fput+0x29/0x80
> [   32.224796]  ? __sys_bind+0x187/0x1c0
> [   32.224798]  ? __sys_bind_socket+0x90/0x90
> [   32.224801]  ? randomize_page+0x60/0x60
> [   32.224804]  ? fget+0x18e/0x230
> [   32.224807]  __x64_sys_sendto+0xe0/0x1b0
> [   32.224810]  ? fpregs_assert_state_consistent+0x57/0xe0
> [   32.224812]  do_syscall_64+0x46/0x180
> [   32.224815]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> and at the end:
> 
> # ERROR: [receive_pkts] Receive loop timed out
> test_xsk:FAIL:Run test unexpected error: -1 (errno 12)
> #251/32  ns_xsk_drv/XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF:FAIL
> #251     ns_xsk_drv:FAIL
> Summary: 1/67 PASSED, 0 SKIPPED, 1 FAILED
> 
> [   99.308243] page_pool_release_retry() stalled pool shutdown: id
> 185, 48 inflight 60 sec
> [  159.724173] page_pool_release_retry() stalled pool shutdown: id
> 185, 48 inflight 120 sec
> 
> 
> The test is great and the work to make it run as part of test_progs
> paid off big time.
> 
> But we cannot enable it by default, since it will be crashing CI VMs.
> 
> Please reproduce the above issue.
> You might need
> CONFIG_DEBUG_VM=y
> and other mm debug flags.
> 

I did reproduce the issue with CONFIG_DEBUG_VM=y

> If the fix can be done quickly let's land the fix first.
> If not, please respin the series, but disable the test by default
> until the bug is fixed.

I won't have much time this week to investigate this further, so I'll 
respin the series with this test in the 'flaky table'.

Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


