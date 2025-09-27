Return-Path: <linux-kselftest+bounces-42541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083BBA5E3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38881B22A41
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DF2E0400;
	Sat, 27 Sep 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9RqxR7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C62DFF18
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Sep 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758971983; cv=none; b=HNHjkmNx7yCWwXS3wU1BwtjXeSf64mnuiVgPqNhMH5XiktH6MOBh+TtWJCkUfx5zz4rDFTBjgYA6sUM/MHx1RCs0iraHdn9x5IG9cwQMJbaLXgcdes+XRQTYMFRWAGdkyKMaNjFSIdy/c74sicxEOwhuhPQ2AwTwb1csVD0YixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758971983; c=relaxed/simple;
	bh=lyQK3dj3jb79A9aBAEl6D8zz7Yd9JsVkwnwAPGtyMMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zcnt2hobsTgPQ+X6qayXtg0hcSsxGHng3M73Hx42OEbopOo2YpmW4Pf4dPOWwcXaTaAANd1Mh4/9V/a45e/tr67vMADdvbWw+AKz5KqOM/xGNTt9RPT91sWtsSu4FJANEBVz+pwRlvS5joM10VJ8gzjQhaq0LVWNNWjY+rAetVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9RqxR7B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso2082312f8f.1
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Sep 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758971979; x=1759576779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJlOnjCtecqKlwNZP2ZTCvHch+/LxWyg3xr+1OSMJVs=;
        b=W9RqxR7BCrus8J1Ry5NVOGWfomuvyc4e+9IZC4dGE7NdSNIBVN+PGMJkvo9iMHcw1e
         qnuvpXZ5GrGSme6+h3BeF/CJak3wMCTKLtWSYBbVlm8tsfgb+6x2w41drV76vtl4ZOZ8
         TQ0w3AxTEQoHGjVC5vH4kXLK94VPj0eOkK2O35GVX+s7AUaH3a+JO0nKDnvtQh9UjzTU
         d8Ct5AM2aVPO7S71jNQE9FT5mn3MJDbd35VPPf8TyhotuyFc1HxrLWaGr9j++g8EK88A
         a6fcHLJbmdFUEoa9kmTGlwaAlzQnRnhebrSq5iM1B+CTLfADkyUkjqYrbfCbNcIn05Ta
         0B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758971979; x=1759576779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJlOnjCtecqKlwNZP2ZTCvHch+/LxWyg3xr+1OSMJVs=;
        b=VcvbsaMQxYDsD8euFkqMJHSqOHrcohSX769jNb01zNkpXrXWoWi/rKds3E3KCdgY+4
         OdX7wCEG4/G96ppwY9f0a0VGnMWsJFHLusTuP1P09pjlUk/Zld16tQcQmuUDRzXZpw6L
         U06D8LjyUOBYr5idN7qzgKqadXQGyhx+Efhz9Kn3jAf18m2/I0JkEGCWqx/3iERsc5zb
         HGzjykCuB9mJQHjD/r8PSS8SwjSf7F7VqEyEvGrLMk04wfJnNRtiMLRV2PhpbmKO7o6k
         NCdE6tfvPIJtsR9qMeBui02Re0Y9n+ICs424uD/qPkhxKBm/Ng0PuK/7h+fvdGFjzhWb
         OTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhOwg4Cz+BCSq2VGogGduNQ5lrxskLP7jT3gSfYB70wtFuO7uQhcqrV6Bs7WehCvfqnnbjRs2sO/tpObva2yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N/cFlHukTmhLD0TiE48u1p6+flnuBUJcEUMvN1xnRyCiP6Wt
	n3GudP1JpzzqDEAbt7c6bGC3YqmmLIrcHF1qEBfQIOxwDByU2msB36rqG+a5jXEl/CjByMjVzwm
	/RovZYM+mD6fNZ4BpDdRJxxJkcDIidrs=
X-Gm-Gg: ASbGncvt5dT4IAqnW3re7AJTYfcmY95wUoekzSc6iFx3aJstutHi8CXSHFvDMYRrjqC
	7BzfUhAvLyfIycrj0XDwV1S8QdNd+VRAM/WJRGXX6gDjCRMV3vd7sSPm3YHdUAUDpaBfw9W32Lu
	LqDrr4e8ja1nOECMnXKoE1eeCveIWL68sIiwi00TuEB0tiwZh2PVvoXyu6MDdNcykTzR7aEVBZ2
	eYaUnNLK/g60ZOC3kHz
X-Google-Smtp-Source: AGHT+IE/8kjdOpfLVHLONIbxVJySVHCTebxcS+AchC7X+h8+eAJSQaSSm3VZ5ohxYM2cNjZfF5Ea7BqI+k5sWd9cnhg=
X-Received: by 2002:a05:6000:2509:b0:3fa:5925:4b07 with SMTP id
 ffacd0b85a97d-40e45a9280dmr8125948f8f.18.1758971978632; Sat, 27 Sep 2025
 04:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-xsk-v4-0-20e57537b876@bootlin.com> <20250924-xsk-v4-4-20e57537b876@bootlin.com>
 <aNVEiTJywHNJeEzL@boxer> <fd600cd5-062e-4806-9e8e-b7f6aacad242@bootlin.com> <aNZ9VWLgNGHQg1Tv@boxer>
In-Reply-To: <aNZ9VWLgNGHQg1Tv@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 27 Sep 2025 12:19:27 +0100
X-Gm-Features: AS18NWDtQbz9DZq8vxqL04kjSoY9eMmtejmUmGibpefP6w_KaVbyNhB1QiIHlQ4
Message-ID: <CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/15] selftests/bpf: test_xsk: fix memory
 leak in testapp_stats_rx_dropped()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:47=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Sep 26, 2025 at 08:39:28AM +0200, Bastien Curutchet wrote:
> > Hi Maciej,
> >
> > On 9/25/25 3:32 PM, Maciej Fijalkowski wrote:
> > > On Wed, Sep 24, 2025 at 04:49:39PM +0200, Bastien Curutchet (eBPF Fou=
ndation) wrote:
> > > > testapp_stats_rx_dropped() generates pkt_stream twice. The last
> > > > generated is released by pkt_stream_restore_default() at the end of=
 the
> > > > test but we lose the pointer of the first pkt_stream.
> > > >
> > > > Release the 'middle' pkt_stream when it's getting replaced to preve=
nt
> > > > memory leaks.
> > > >
> > > > Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutch=
et@bootlin.com>
> > > > ---
> > > >   tools/testing/selftests/bpf/test_xsk.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing=
/selftests/bpf/test_xsk.c
> > > > index 8d7c38eb32ca3537cb019f120c3350ebd9f8c6bc..eb18288ea1e4aa1c933=
7d16333b7174ecaed0999 100644
> > > > --- a/tools/testing/selftests/bpf/test_xsk.c
> > > > +++ b/tools/testing/selftests/bpf/test_xsk.c
> > > > @@ -536,6 +536,13 @@ static void pkt_stream_receive_half(struct tes=
t_spec *test)
> > > >           struct pkt_stream *pkt_stream =3D test->ifobj_tx->xsk->pk=
t_stream;
> > > >           u32 i;
> > > > + if (test->ifobj_rx->xsk->pkt_stream !=3D test->rx_pkt_stream_defa=
ult)
> > > > +         /* Packet stream has already been replaced so we have to =
release this one.
> > > > +          * The newly created one will be freed by the restore_def=
ault() at the
> > > > +          * end of the test
> > > > +          */
> > > > +         pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> > >
> > > I don't see why this one is not addressed within test case
> > > (testapp_stats_rx_dropped()) and other fix is (testapp_xdp_shared_ume=
m()).
> > >
> >
> > pkt_stream_receive_half() can be used by other tests. I thought it woul=
d be
>
> So is pkt_stream_replace_half() and other routines that eventually call
> pkt_stream_generate() and overwrite the pkt_stream, right?
>
> It just feels odd to have a special treatment in one function and other
> are left as-is just because currently we don't have another abusive test
> case.
>
> Maybe it's enough of bike-shedding here, just wanted to clarify on my POV=
.
>
> In the end don't get me wrong here, this interface is a bit PITA for me
> and thanks for whole effort!

My reading of this discussion that it doesn't block the series
and can be done in the follow up if necessary.

So I was planning to apply it, but it found real bugs:

./test_progs -t xsk
[   18.066989] bpf_testmod: loading out-of-tree module taints kernel.
[   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
[   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x11c98b
[   32.210084] flags: 0x1fffe0000000000(node=3D0|zone=3D1|lastcpupid=3D0x7f=
ff)
[   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000
0000000000000000
[   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff
0000000000000000
[   32.220900] page dumped because: page_pool leak
[   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
[   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G
      O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
[   32.224638] Tainted: [O]=3DOOT_MODULE
[   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   32.224641] Call Trace:
[   32.224644]  <IRQ>
[   32.224646]  dump_stack_lvl+0x4b/0x70
[   32.224653]  bad_page.cold+0xbd/0xe0
[   32.224657]  __free_frozen_pages+0x838/0x10b0
[   32.224660]  ? skb_pp_cow_data+0x782/0xc30
[   32.224665]  bpf_xdp_shrink_data+0x221/0x530
[   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
[   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
[   32.224673]  ? xsk_destruct_skb+0x321/0x800
[   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
[   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
[   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
[   32.224688]  ? veth_set_channels+0x920/0x920
[   32.224691]  ? get_stack_info+0x2f/0x80
[   32.224693]  ? unwind_next_frame+0x3af/0x1df0
[   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
[   32.224700]  ? common_startup_64+0x13e/0x148
[   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
[   32.224706]  ? stack_trace_save+0x84/0xa0
[   32.224709]  ? stack_depot_save_flags+0x28/0x820
[   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
[   32.224716]  ? timerqueue_add+0x217/0x320
[   32.224719]  veth_poll+0x115/0x5e0
[   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
[   32.224726]  ? update_load_avg+0x1cb/0x12d0
[   32.224730]  ? update_cfs_group+0x121/0x2c0
[   32.224733]  __napi_poll+0xa0/0x420
[   32.224736]  net_rx_action+0x901/0xe90
[   32.224740]  ? run_backlog_napi+0x50/0x50
[   32.224743]  ? clockevents_program_event+0x1cc/0x280
[   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
[   32.224749]  handle_softirqs+0x151/0x430
[   32.224752]  do_softirq+0x3f/0x60
[   32.224755]  </IRQ>
[   32.224756]  <TASK>
[   32.224757]  __local_bh_enable_ip+0x58/0x60
[   32.224759]  __dev_direct_xmit+0x295/0x540
[   32.224762]  __xsk_generic_xmit+0x180a/0x2df0
[   32.224764]  ? ___kmalloc_large_node+0xdf/0x130
[   32.224767]  ? __mutex_unlock_slowpath.isra.0+0x330/0x330
[   32.224770]  ? __rtnl_unlock+0x65/0xd0
[   32.224773]  ? xsk_create+0x700/0x700
[   32.224774]  ? netdev_run_todo+0xce/0xbe0
[   32.224777]  ? _raw_spin_lock_irqsave+0x7b/0xc0
[   32.224780]  xsk_sendmsg+0x365/0x770
[   32.224782]  ? xsk_poll+0x640/0x640
[   32.224783]  __sock_sendmsg+0xc1/0x150
[   32.224787]  __sys_sendto+0x1d0/0x260
[   32.224790]  ? __ia32_sys_getpeername+0xb0/0xb0
[   32.224793]  ? fput+0x29/0x80
[   32.224796]  ? __sys_bind+0x187/0x1c0
[   32.224798]  ? __sys_bind_socket+0x90/0x90
[   32.224801]  ? randomize_page+0x60/0x60
[   32.224804]  ? fget+0x18e/0x230
[   32.224807]  __x64_sys_sendto+0xe0/0x1b0
[   32.224810]  ? fpregs_assert_state_consistent+0x57/0xe0
[   32.224812]  do_syscall_64+0x46/0x180
[   32.224815]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

and at the end:

# ERROR: [receive_pkts] Receive loop timed out
test_xsk:FAIL:Run test unexpected error: -1 (errno 12)
#251/32  ns_xsk_drv/XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF:FAIL
#251     ns_xsk_drv:FAIL
Summary: 1/67 PASSED, 0 SKIPPED, 1 FAILED

[   99.308243] page_pool_release_retry() stalled pool shutdown: id
185, 48 inflight 60 sec
[  159.724173] page_pool_release_retry() stalled pool shutdown: id
185, 48 inflight 120 sec


The test is great and the work to make it run as part of test_progs
paid off big time.

But we cannot enable it by default, since it will be crashing CI VMs.

Please reproduce the above issue.
You might need
CONFIG_DEBUG_VM=3Dy
and other mm debug flags.

If the fix can be done quickly let's land the fix first.
If not, please respin the series, but disable the test by default
until the bug is fixed.

