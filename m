Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481A774980
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 21:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHHT5q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHHT5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 15:57:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F611CA62;
        Tue,  8 Aug 2023 11:11:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-31765aee31bso4492145f8f.1;
        Tue, 08 Aug 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691518295; x=1692123095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88SzAwdTNYvqLEjHXjhAK/237IlUBLCsG6sm48HW9aQ=;
        b=MpyYGxXv9JsLhDqf2/OWxJggreYU5AJ3HdbTp4fkg9vLYK5VegsugkswuKAoOOpKoR
         0UYxldYBF+fciZm99juMqQ8E7W3T5JtmZHNqVW2AG1Hj/VtBuXX5LhFU1B2ByL1Xeqo9
         h9acA7E9NUVTcjrH9QSUc4vWfEJhL4esQKaNt1s/W/RRmhZerS8o2nSPwHHRnOw/snFS
         uWmMiesCo19kIZSu3W+KKkJ8Z2kyrNCbKfbYwzf0pDVrYypOKhqKVXzO96XB9ApxUmtE
         6r6uAo+X8f/SPynns026zpc5J88PPsHv5GVvJUbVdBCvz03K1h7T2VHPr1Zm/1lOGSW7
         CbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518295; x=1692123095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88SzAwdTNYvqLEjHXjhAK/237IlUBLCsG6sm48HW9aQ=;
        b=YC1rM1M1rhMll6BG143frEZSyRvxwq2J3AEFb7kT0t0xY63dgnCJADyqZZEKgNVfYX
         DoFFI8yVN8xa+6bi9HcwKA/08nfQ2Nhg49v9pwXYq3eEaGHAyEl05hYHT2ZhO8/z0LCI
         42+Rg2wKM6Jntg8sNAeEN5GC9vhIsOHM9CokSQjY1tE0hz34XzdaRyVaWknbDZV0topv
         JfZhxh/U1B1OvYhkXezcPQ8BCBDtE312LtTNNsnOmtW/qDg3TTrqmxULreDkghANdnaQ
         X3bT95WYnHXNkOuMCoz2V1yEqo/Dm5zQ6ID/ySur2LsJcrbN3R0eeuUspBTFrRgzobNy
         QTaQ==
X-Gm-Message-State: AOJu0YxWHli2mZozVmk2c8wUcHqITFQ8E2u7M2a881AzDvUDOTIJvUWV
        c35hQXnvoghJWNOXZn6TLxQL4kDOG364GO4XItQ2L7Y+pO+BuVyJ
X-Google-Smtp-Source: AGHT+IGLDeLmFajAKf6hsMke5hoaXhQaTNUNoxeSibZrIT8AT/gN448zZGbCWux3UCQeFaokdIedK819PzVPEL1CnBY=
X-Received: by 2002:ac2:5f66:0:b0:4f9:5426:6622 with SMTP id
 c6-20020ac25f66000000b004f954266622mr6615984lfc.69.1691468605688; Mon, 07 Aug
 2023 21:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com> <20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com>
In-Reply-To: <20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 8 Aug 2023 09:52:49 +0530
Message-ID: <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 20 Jul 2023 at 21:04, Lorenz Bauer <lmb@isovalent.com> wrote:
>
> Currently the bpf_sk_assign helper in tc BPF context refuses SO_REUSEPORT
> sockets. This means we can't use the helper to steer traffic to Envoy,
> which configures SO_REUSEPORT on its sockets. In turn, we're blocked
> from removing TPROXY from our setup.
>
> The reason that bpf_sk_assign refuses such sockets is that the
> bpf_sk_lookup helpers don't execute SK_REUSEPORT programs. Instead,
> one of the reuseport sockets is selected by hash. This could cause
> dispatch to the "wrong" socket:
>
>     sk = bpf_sk_lookup_tcp(...) // select SO_REUSEPORT by hash
>     bpf_sk_assign(skb, sk) // SK_REUSEPORT wasn't executed
>
> Fixing this isn't as simple as invoking SK_REUSEPORT from the lookup
> helpers unfortunately. In the tc context, L2 headers are at the start
> of the skb, while SK_REUSEPORT expects L3 headers instead.
>
> Instead, we execute the SK_REUSEPORT program when the assigned socket
> is pulled out of the skb, further up the stack. This creates some
> trickiness with regards to refcounting as bpf_sk_assign will put both
> refcounted and RCU freed sockets in skb->sk. reuseport sockets are RCU
> freed. We can infer that the sk_assigned socket is RCU freed if the
> reuseport lookup succeeds, but convincing yourself of this fact isn't
> straight forward. Therefore we defensively check refcounting on the
> sk_assign sock even though it's probably not required in practice.
>
> Fixes: 8e368dc72e86 ("bpf: Fix use of sk->sk_reuseport from sk_assign")
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Joe Stringer <joe@cilium.io>
> Link: https://lore.kernel.org/bpf/CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com/
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---

Hi Lorenz, Kuniyuki, Martin,

I am getting a KASAN (inline mode) splat on bpf-next when I run
./test_progs -t btf_skc_cls_ingress, and I bisected it to this commit:
9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign")

bash-5.2# ./test_progs -t btf_skc_cls_ingress
[   51.611015] bpf_testmod: loading out-of-tree module taints kernel.
[   51.611434] bpf_testmod: module verification failed: signature
and/or required key missing - tainting kernel
[   51.809645] ==================================================================
[   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
[   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
[   51.810848]
[   51.810955] CPU: 4 PID: 226 Comm: test_progs Tainted: G
OE      6.5.0-rc2-g9c02bec95954 #51
[   51.811467] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-2.fc39 04/01/2014
[   51.811968] Call Trace:
[   51.812118]  <IRQ>
[   51.812239]  dump_stack_lvl+0x4a/0x80
[   51.812452]  print_report+0xcf/0x670
[   51.812660]  ? __pfx___lock_acquire+0x10/0x10
[   51.812930]  kasan_report+0xda/0x110
[   51.813140]  ? tcp_v6_rcv+0x2d7d/0x3440
[   51.813363]  ? tcp_v6_rcv+0x2d7d/0x3440
[   51.813585]  tcp_v6_rcv+0x2d7d/0x3440
[   51.813808]  ? __pfx_tcp_v6_rcv+0x10/0x10
[   51.814051]  ? __pfx_raw6_local_deliver+0x10/0x10
[   51.814322]  ? lock_acquire+0x18e/0x4b0
[   51.814543]  ? ip6_input_finish+0xda/0x240
[   51.814783]  ip6_protocol_deliver_rcu+0x12a/0x1310
[   51.815067]  ? find_held_lock+0x2d/0x110
[   51.815293]  ip6_input_finish+0x118/0x240
[   51.815526]  ? __pfx_lock_release+0x10/0x10
[   51.815770]  ip6_input+0xc4/0x300
[   51.815972]  ? __pfx_ip6_input+0x10/0x10
[   51.816204]  ? ip6_rcv_core+0x996/0x1990
[   51.816431]  ipv6_rcv+0x3bf/0x780
[   51.816625]  ? __pfx_ipv6_rcv+0x10/0x10
[   51.816853]  ? lock_acquire+0x18e/0x4b0
[   51.817088]  ? process_backlog+0x1d8/0x620
[   51.817325]  ? __pfx_ipv6_rcv+0x10/0x10
[   51.817546]  __netif_receive_skb_one_core+0x11a/0x1b0
[   51.817837]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[   51.818166]  ? mark_held_locks+0x94/0xe0
[   51.818392]  process_backlog+0xd3/0x620
[   51.818614]  __napi_poll.constprop.0+0xa3/0x540
[   51.818890]  net_rx_action+0x3b4/0xa80
[   51.819113]  ? __pfx_net_rx_action+0x10/0x10
[   51.819365]  ? reacquire_held_locks+0x490/0x4b0
[   51.819631]  __do_softirq+0x202/0x83f
[   51.819852]  ? __pfx___do_softirq+0x10/0x10
[   51.820103]  ? tick_nohz_stop_idle+0x19e/0x280
[   51.820360]  ? __dev_queue_xmit+0x818/0x2d50
[   51.820608]  do_softirq+0x47/0xa0
[   51.820817]  </IRQ>
[   51.820954]  <TASK>
[   51.821080]  __local_bh_enable_ip+0xf2/0x120
[   51.821324]  __dev_queue_xmit+0x83c/0x2d50
[   51.821561]  ? __pfx_mark_lock+0x10/0x10
[   51.821795]  ? __pfx___dev_queue_xmit+0x10/0x10
[   51.822064]  ? lock_acquire+0x18e/0x4b0
[   51.822285]  ? find_held_lock+0x2d/0x110
[   51.822511]  ? lock_release+0x1de/0x620
[   51.822737]  ? ip6_finish_output+0x666/0x1250
[   51.822998]  ? __pfx_lock_release+0x10/0x10
[   51.823238]  ? mark_held_locks+0x94/0xe0
[   51.823467]  ip6_finish_output2+0xd8d/0x1bb0
[   51.823717]  ? ip6_mtu+0x13f/0x350
[   51.823928]  ? __pfx_ip6_finish_output2+0x10/0x10
[   51.824195]  ? find_held_lock+0x2d/0x110
[   51.824427]  ? lock_release+0x1de/0x620
[   51.824650]  ip6_finish_output+0x666/0x1250
[   51.824906]  ip6_output+0x1ed/0x6c0
[   51.825113]  ? __pfx_ip6_output+0x10/0x10
[   51.825343]  ? ip6_xmit+0xed5/0x1f40
[   51.825551]  ? __pfx_ip6_finish_output+0x10/0x10
[   51.825821]  ? nf_hook_slow+0xa9/0x180
[   51.826048]  ip6_xmit+0xbd2/0x1f40
[   51.826248]  ? lock_acquire+0x181/0x4b0
[   51.826470]  ? __pfx_ip6_xmit+0x10/0x10
[   51.826696]  ? __pfx_dst_output+0x10/0x10
[   51.826937]  ? __pfx_lock_acquire+0x10/0x10
[   51.827176]  ? release_sock+0x53/0x180
[   51.827393]  ? __pfx_inet6_csk_route_socket+0x10/0x10
[   51.827684]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   51.827993]  inet6_csk_xmit+0x31c/0x570
[   51.828215]  ? __pfx_inet6_csk_xmit+0x10/0x10
[   51.828467]  __tcp_transmit_skb+0x1708/0x3630
[   51.828732]  ? __pfx___tcp_transmit_skb+0x10/0x10
[   51.829017]  ? __alloc_skb+0x110/0x280
[   51.829238]  ? __pfx___alloc_skb+0x10/0x10
[   51.829474]  ? __tcp_send_ack.part.0+0x64/0x590
[   51.829743]  tcp_rcv_state_process+0xeba/0x4ff0
[   51.830015]  ? __pfx_tcp_rcv_state_process+0x10/0x10
[   51.830298]  ? __pfx_mark_lock+0x10/0x10
[   51.830524]  ? find_held_lock+0x2d/0x110
[   51.830756]  ? lock_release+0x1de/0x620
[   51.830988]  ? __release_sock+0xd8/0x2b0
[   51.831215]  ? tcp_v6_do_rcv+0x34e/0x13a0
[   51.831443]  tcp_v6_do_rcv+0x34e/0x13a0
[   51.831665]  ? __local_bh_enable_ip+0xa6/0x120
[   51.831935]  __release_sock+0x12c/0x2b0
[   51.832158]  release_sock+0x53/0x180
[   51.832365]  __inet_stream_connect+0x6a2/0x1100
[   51.832634]  ? __pfx___inet_stream_connect+0x10/0x10
[   51.832934]  ? __pfx_woken_wake_function+0x10/0x10
[   51.833209]  ? lockdep_hardirqs_on_prepare+0x27b/0x3f0
[   51.833501]  inet_stream_connect+0x57/0xa0
[   51.833743]  __sys_connect+0x106/0x130
[   51.833973]  ? __sys_setsockopt+0x19d/0x410
[   51.834211]  ? __pfx___sys_connect+0x10/0x10
[   51.834460]  ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
[   51.834780]  __x64_sys_connect+0x72/0xb0
[   51.835019]  ? syscall_enter_from_user_mode+0x20/0x50
[   51.835312]  do_syscall_64+0x3c/0x90
[   51.835523]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   51.835818] RIP: 0033:0x7f99941965b4
[   51.836034] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84
00 00 00 00 00 90 f3 0f 1e fa 80 3d b5 8d 12 00 00 74 13 b8 2a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 10
89 55
[   51.837071] RSP: 002b:00007ffc9a4a3ea8 EFLAGS: 00000202 ORIG_RAX:
000000000000002a
[   51.837507] RAX: ffffffffffffffda RBX: 00007ffc9a4a42a8 RCX: 00007f99941965b4
[   51.837920] RDX: 000000000000001c RSI: 00007ffc9a4a3f10 RDI: 0000000000000008
[   51.838318] RBP: 00007ffc9a4a3ee0 R08: 0000000000000010 R09: 0000000000000000
[   51.838721] R10: 00007f999408a730 R11: 0000000000000202 R12: 0000000000000003
[   51.839126] R13: 0000000000000000 R14: 00007f999433c000 R15: 0000000000ce2d90
[   51.839527]  </TASK>
[   51.839658]
[   51.839759] The buggy address belongs to the object at ffff8881053f0330
[   51.839759]  which belongs to the cache request_sock_TCPv6 of size 344
[   51.840491] The buggy address is located 92 bytes inside of
[   51.840491]  allocated 344-byte region [ffff8881053f0330, ffff8881053f0488)
[   51.841199]
[   51.841298] The buggy address belongs to the physical page:
[   51.841663] page:00000000e92b0bb6 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x1053f0
[   51.842213] head:00000000e92b0bb6 order:1 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   51.842741] flags:
0x2fffe0000010200(slab|head|node=0|zone=2|lastcpupid=0x7fff)
[   51.843170] page_type: 0xffffffff()
[   51.843374] raw: 02fffe0000010200 ffff8881016463c0 dead000000000122
0000000000000000
[   51.843819] raw: 0000000000000000 0000000080140014 00000001ffffffff
0000000000000000
[   51.844263] page dumped because: kasan: bad access detected
[   51.844578]
[   51.844691] Memory state around the buggy address:
[   51.845125]  ffff8881053f0280: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   51.845599]  ffff8881053f0300: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   51.846069] >ffff8881053f0380: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   51.846476]
                         ^
[   51.846684]  ffff8881053f0400: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   51.847109]  ffff8881053f0480: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[   51.847526] ==================================================================
[   51.847961] Disabling lock debugging due to kernel taint
#30/1    btf_skc_cls_ingress/conn:OK
#30/2    btf_skc_cls_ingress/syncookie:OK
#30      btf_skc_cls_ingress:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

KASAN is pointing to this part of the commit:
0xffffffff8305164d is in tcp_v6_rcv (../include/net/inet6_hashtables.h:122).
117 return NULL;
118
119 if (!prefetched)
120         return sk;
121
122 if (sk->sk_protocol == IPPROTO_TCP) { // bad access
123         if (sk->sk_state != TCP_LISTEN)
124                 return sk;
125 } else if (sk->sk_protocol == IPPROTO_UDP) {

Let me know if you have trouble reproducing or need any other information.
