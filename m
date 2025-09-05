Return-Path: <linux-kselftest+bounces-40834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A66B45905
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B93AFA08
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA09350821;
	Fri,  5 Sep 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvzIcV8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04034F49F
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078889; cv=none; b=dB6YirwnQN7+VfCjGuKTeSZb5lZgqg2BwYB+CIip3kTlVFOS2oACayl5GO3oH9AA5WcG8EYxK2yENtfGQ70LLZtLmyj1jExmjPwy45ecAE0dTi6cf4XyVw/TYqHbfIO3wFldO4OGGsoOZ5VmSkNDMGLB+pD1ij6Qz1RS7XFvpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078889; c=relaxed/simple;
	bh=00lP1MO7V96rpDy5Iqjhv/dbeh8Q0ASIz04S3hGBHjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BEfdC1eE6MSGRssBBGQ9b4uwhWLDzA+0iBCCl0Q7Ug1pg8J/4mxPTiSddXelfx+IyMWyM7FzHwaimDS0blMWdDm9xq/LwPWsZSQ+5mYUHIwn77GefZ9Y91mEITMqh31ml//orLHCovuLd0WHPkqHtubxjByYdKua5PfXgriE8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvzIcV8o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757078885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3WiqqmvmkyU9dyNVWkSqj8OsGhyXBJbKIwB2/k8dKmc=;
	b=OvzIcV8oKiGX/LOJsTCvfrx/sTgGcBXSghXuz6gkMZVeWEXjFzniNuLz06e4ZGuyv74bG0
	rkMPRmY/Q7REZhpFpvDszKoNrmkHqvgHRZyrwlXBIYzQ/CEjuRTVjn/cEXzngi07CMoaE0
	PKz7VYEEQw244w0BdfG/eR1iRYlK+iw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Ki0k8vfKOiWseRdgnk4ymQ-1; Fri, 05 Sep 2025 09:28:04 -0400
X-MC-Unique: Ki0k8vfKOiWseRdgnk4ymQ-1
X-Mimecast-MFC-AGG-ID: Ki0k8vfKOiWseRdgnk4ymQ_1757078883
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so17141375e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 06:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078883; x=1757683683;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WiqqmvmkyU9dyNVWkSqj8OsGhyXBJbKIwB2/k8dKmc=;
        b=gWUxo1N+u6kCnpxwCYT+sg/aH6Sg2Ol3SN84ikiliJAW05Wii18eFiqqnuACYP0hiP
         7ulZQhjkerkWhE1HpKudIPTDWZsK7b9A7o7GVFEtMnYa82AIFhXCZH1mlypsjd/L2lj1
         maApNY8A6FOhJmkWW0VuXHCADlect8lumvRb2iBkWZ63b8EtSiJHtM0GpzakJ4xA8m3v
         C7VsYag4PohAaejyCrY3udNO9cKU3T/8sThHCEPgMGNoBjlLFjRCUEVypIQr8uAfV36n
         i6wR+bAWPg1Z3U4WW0G0utB31rAwRLPKYC/ofaGbRzz5k5WBwIGhsx8oe7HmDXEkPKHl
         GnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVg+fWHTNpusAi0m8i39rWQ3kFb6mBz1pCwCais6zDkuuR9dg0R7E3cdYml2BVQRhVpT3filEX6DTz031XQNwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Z5JWiXBfqD38671LzX5f1p93kkqSrDPb7JMh3Ph0q+uxKb9u
	3CNjy5z2OY5JtXc1mnDcGRusXK8q1HKsxVp/2gwM/KjpHV+Wb1daxSIWgL/WGZatH2Jfv8gLqbN
	wQsBZkdswApGKgSo4i+8UV60YGR78wTTZzi/aeOqgOyiuyZ8RGOc42NPVWEF5Lg+d63uppg==
X-Gm-Gg: ASbGncvfEGrVNctHUPKuGAwAVLfZviiSpcbdggKmKF+oLSZoe4Yg+jOQTdkCl1ud3gm
	2tatvu8/xKEG2u0ltun1bNZ1731WvoWU5GlF/5sMWIgeFNXw+MMidFQ+iAj2NqUcHXtXKhPWXLk
	Cet2ABCnfDwfhhms9rxbF3IJARrF7xb/FJSlFp1Xh2tFqpZ+S3fvcL4SC6TWlMGr80FRtLICWBO
	4ImwNkpHEG8a25yfsSucapClfdXicfVvmZpZ7liv6C0ifQbieNKVwrgLZeMl2/GGkL7frdZM4Pl
	C6W4myJQWBcbgbrwiE2jbJAtEqcAKkuviEBcka53Ixs2lacT2f3Nvk1XuMZFDt5YHOlXPvasoy+
	ffoOByOrKQI0N8EeQhcIvKb10i55IH0pEsdlt+xbQ4D6SMOaSEcqOTFS4
X-Received: by 2002:a5d:64c3:0:b0:3e4:d981:e31f with SMTP id ffacd0b85a97d-3e4d981e979mr899288f8f.60.1757078882900;
        Fri, 05 Sep 2025 06:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzbvGKGMXC1b4s32EUu5W51ZgOauNi8Zf/J3DfcPBT1LhN4y6O0qNuzW+PSJeZxpA24bWOw==
X-Received: by 2002:a5d:64c3:0:b0:3e4:d981:e31f with SMTP id ffacd0b85a97d-3e4d981e979mr899266f8f.60.1757078882342;
        Fri, 05 Sep 2025 06:28:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm31599368f8f.47.2025.09.05.06.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:28:01 -0700 (PDT)
Message-ID: <0118a233-90fc-484b-b539-d8df641a25ad@redhat.com>
Date: Fri, 5 Sep 2025 15:28:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250905: x86_64: udpgso_bench.sh triggers NULL deref in
 zerocopy_fill_skb_from_iter
From: David Hildenbrand <david@redhat.com>
To: Eric Dumazet <edumazet@google.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Biggers <ebiggers@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Pengtao He <hept.hept.hept@gmail.com>
References: <CA+G9fYsmo39mXw-U7VKJgHWTBB5bXNgwOqNfmDWRqvbqmxnD2g@mail.gmail.com>
 <CANn89iKciN019j88sGYpi_Boi7ggJoSnV4gOW=5grp+skkKnBA@mail.gmail.com>
 <a4e4be39-b0e6-4632-878d-0765c9475984@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a4e4be39-b0e6-4632-878d-0765c9475984@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 15:07, David Hildenbrand wrote:
> On 05.09.25 14:55, Eric Dumazet wrote:
>> On Fri, Sep 5, 2025 at 2:30 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>
>>> The following kernel crash was noticed on x86_64 running selftests net
>>> udpgso_bench.sh
>>> on Linux next-20250905 tag.
>>>
>>> Regression Analysis:
>>> - New regression? yes
>>> - Reproducibility? Re-validation is in progress
>>>
>>> First seen on next-20250905
>>> Bad: next-20250905
>>> Good: next-20250904
>>>
>>> Test regression: next-20250905 x86_64 selftests net BUG kernel NULL
>>> pointer dereference zerocopy_fill_skb_from_iter
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> x86_64:
>>>    Test:
>>>       * selftests: net: udpgso_bench.sh
>>>
>>> Test error:
>>> selftests: net: udpgso_bench.sh
>>> ipv4
>>> tcp
>>>
>>> <trim>
>>>
>>> # tcp zerocopy
>>> [  991.110488] SELinux: unrecognized netlink message: protocol=4
>>> nlmsg_type=19 sclass=netlink_tcpdiag_socket pid=64835 comm=ss
>>> # RTNETLINK answers: Invalid argument
>>> [  991.129878] BUG: kernel NULL pointer dereference, address: 0000000000000008
>>> [  991.136850] #PF: supervisor read access in kernel mode
>>> [  991.141986] #PF: error_code(0x0000) - not-present page
>>> [  991.147118] PGD 0 P4D 0
>>> [  991.149657] Oops: Oops: 0000 [#1] SMP PTI
>>> [  991.153661] CPU: 0 UID: 0 PID: 64842 Comm: udpgso_bench_tx Tainted:
>>> G S                  6.17.0-rc4-next-20250905 #1 PREEMPT(voluntary)
>>> [  991.165907] Tainted: [S]=CPU_OUT_OF_SPEC
>>> [  991.169825] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>>> 2.7 12/07/2021
>>> [  991.177209] RIP: 0010:zerocopy_fill_skb_from_iter
>>> (include/linux/page-flags.h:284)
>>> [ 991.182954] Code: 4d 85 c0 0f 84 04 01 00 00 44 39 c7 41 0f 4d f8 4c
>>> 63 de 4a 8b 54 dc 30 49 89 d6 4d 29 ce 49 c1 fe 06 49 d3 ee 4d 85 f6
>>> 74 24 <48> 8b 4a 08 f6 c1 01 0f 85 cb 00 00 00 0f 1f 44 00 00 31 c9 48
>>> f7
>>> All code
>>> ========
>>>      0: 4d 85 c0              test   %r8,%r8
>>>      3: 0f 84 04 01 00 00    je     0x10d
>>>      9: 44 39 c7              cmp    %r8d,%edi
>>>      c: 41 0f 4d f8          cmovge %r8d,%edi
>>>     10: 4c 63 de              movslq %esi,%r11
>>>     13: 4a 8b 54 dc 30        mov    0x30(%rsp,%r11,8),%rdx
>>>     18: 49 89 d6              mov    %rdx,%r14
>>>     1b: 4d 29 ce              sub    %r9,%r14
>>>     1e: 49 c1 fe 06          sar    $0x6,%r14
>>>     22: 49 d3 ee              shr    %cl,%r14
>>>     25: 4d 85 f6              test   %r14,%r14
>>>     28: 74 24                je     0x4e
>>>     2a:* 48 8b 4a 08          mov    0x8(%rdx),%rcx <-- trapping instruction
>>>     2e: f6 c1 01              test   $0x1,%cl
>>>     31: 0f 85 cb 00 00 00    jne    0x102
>>>     37: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>>>     3c: 31 c9                xor    %ecx,%ecx
>>>     3e: 48                    rex.W
>>>     3f: f7                    .byte 0xf7
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>      0: 48 8b 4a 08          mov    0x8(%rdx),%rcx
>>>      4: f6 c1 01              test   $0x1,%cl
>>>      7: 0f 85 cb 00 00 00    jne    0xd8
>>>      d: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>>>     12: 31 c9                xor    %ecx,%ecx
>>>     14: 48                    rex.W
>>>     15: f7                    .byte 0xf7
>>> [  991.201691] RSP: 0018:ffffb11281d0ba90 EFLAGS: 00010202
>>> [  991.206910] RAX: ffffe14ec4208000 RBX: 0000000000005000 RCX: 0000000000000009
>>> [  991.214033] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000001000
>>> [  991.221156] RBP: ffffb11281d0bb88 R08: 00000000000020ff R09: ffffe14ec4208000
>>> [  991.228280] R10: 0000000000000005 R11: 0000000000000006 R12: ffff96b4825f4200
>>> [  991.235406] R13: 0000000000000001 R14: 000000003d6277bf R15: 0000000000000000
>>> [  991.242529] FS:  00007f41e80b9740(0000) GS:ffff96b83bc1b000(0000)
>>> knlGS:0000000000000000
>>> [  991.250608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  991.256378] CR2: 0000000000000008 CR3: 0000000106c42003 CR4: 00000000003706f0
>>> [  991.263513] Call Trace:
>>> [  991.265956]  <TASK>
>>> [  991.268055] __zerocopy_sg_from_iter (net/core/datagram.c:?)
>>> [  991.272674] ? kmalloc_reserve (net/core/skbuff.c:581)
>>> [  991.276599] skb_zerocopy_iter_stream (net/core/skbuff.c:1867)
>>> [  991.281219] tcp_sendmsg_locked (net/ipv4/tcp.c:1283)
>>> [  991.285493] tcp_sendmsg (net/ipv4/tcp.c:1393)
>>> [  991.288896] inet6_sendmsg (net/ipv6/af_inet6.c:661)
>>> [  991.292466] __sock_sendmsg (net/socket.c:717)
>>> [  991.296126] __sys_sendto (net/socket.c:?)
>>> [  991.299785] __x64_sys_sendto (net/socket.c:2235 net/socket.c:2231
>>> net/socket.c:2231)
>>> [  991.303622] x64_sys_call (arch/x86/entry/syscall_64.c:41)
>>> [  991.307462] do_syscall_64 (arch/x86/entry/syscall_64.c:?)
>>> [  991.311128] ? irqentry_exit (kernel/entry/common.c:210)
>>> [  991.314881] ? exc_page_fault (arch/x86/mm/fault.c:1536)
>>> [  991.318720] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>>> [  991.323762] RIP: 0033:0x7f41e814b687
>>> [ 991.327352] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00
>>> 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10
>>> 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff
>>> ff
>>> All code
>>> ========
>>>      0: 48 89 fa              mov    %rdi,%rdx
>>>      3: 4c 89 df              mov    %r11,%rdi
>>>      6: e8 58 b3 00 00        call   0xb363
>>>      b: 8b 93 08 03 00 00    mov    0x308(%rbx),%edx
>>>     11: 59                    pop    %rcx
>>>     12: 5e                    pop    %rsi
>>>     13: 48 83 f8 fc          cmp    $0xfffffffffffffffc,%rax
>>>     17: 74 1a                je     0x33
>>>     19: 5b                    pop    %rbx
>>>     1a: c3                    ret
>>>     1b: 0f 1f 84 00 00 00 00 nopl   0x0(%rax,%rax,1)
>>>     22: 00
>>>     23: 48 8b 44 24 10        mov    0x10(%rsp),%rax
>>>     28: 0f 05                syscall
>>>     2a:* 5b                    pop    %rbx <-- trapping instruction
>>>     2b: c3                    ret
>>>     2c: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>>>     33: 83 e2 39              and    $0x39,%edx
>>>     36: 83 fa 08              cmp    $0x8,%edx
>>>     39: 75 de                jne    0x19
>>>     3b: e8 23 ff ff ff        call   0xffffffffffffff63
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>      0: 5b                    pop    %rbx
>>>      1: c3                    ret
>>>      2: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
>>>      9: 83 e2 39              and    $0x39,%edx
>>>      c: 83 fa 08              cmp    $0x8,%edx
>>>      f: 75 de                jne    0xffffffffffffffef
>>>     11: e8 23 ff ff ff        call   0xffffffffffffff39
>>> [  991.346124] RSP: 002b:00007ffdd843ba50 EFLAGS: 00000202 ORIG_RAX:
>>> 000000000000002c
>>> [  991.353680] RAX: ffffffffffffffda RBX: 00007f41e80b9740 RCX: 00007f41e814b687
>>> [  991.360806] RDX: 000000000000f180 RSI: 000056251f1fd100 RDI: 0000000000000005
>>> [  991.367931] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>> [  991.375063] R10: 0000000004000000 R11: 0000000000000202 R12: 0000000000000000
>>> [  991.382193] R13: 000056251f1fb080 R14: 000001a670e438d8 R15: 0000000000000005
>>> [  991.389357]  </TASK>
>>> [  991.391571] Modules linked in: mptcp_diag tcp_diag inet_diag
>>> xt_conntrack xfrm_user ipip bridge stp llc geneve vxlan act_csum
>>> act_pedit openvswitch nsh nf_nat nf_conntrack nf_defrag_ipv6
>>> nf_defrag_ipv4 psample cls_flower sch_prio xt_mark nft_compat
>>> nf_tables sch_ingress act_mirred cls_basic sch_fq_codel vrf pktgen
>>> macvtap macvlan tap x86_pkg_temp_thermal ip_tables x_tables [last
>>> unloaded: test_bpf]
>>> [  991.426812] CR2: 0000000000000008
>>> [  991.430121] ---[ end trace 0000000000000000 ]---
>>> [  991.434733] RIP: 0010:zerocopy_fill_skb_from_iter
>>> (include/linux/page-flags.h:284)
>>> [ 991.440477] Code: 4d 85 c0 0f 84 04 01 00 00 44 39 c7 41 0f 4d f8 4c
>>> 63 de 4a 8b 54 dc 30 49 89 d6 4d 29 ce 49 c1 fe 06 49 d3 ee 4d 85 f6
>>> 74 24 <48> 8b 4a 08 f6 c1 01 0f 85 cb 00 00 00 0f 1f 44 00 00 31 c9 48
>>> f7
>>> All code
>>> ========
>>>      0: 4d 85 c0              test   %r8,%r8
>>>      3: 0f 84 04 01 00 00    je     0x10d
>>>      9: 44 39 c7              cmp    %r8d,%edi
>>>      c: 41 0f 4d f8          cmovge %r8d,%edi
>>>     10: 4c 63 de              movslq %esi,%r11
>>>     13: 4a 8b 54 dc 30        mov    0x30(%rsp,%r11,8),%rdx
>>>     18: 49 89 d6              mov    %rdx,%r14
>>>     1b: 4d 29 ce              sub    %r9,%r14
>>>     1e: 49 c1 fe 06          sar    $0x6,%r14
>>>     22: 49 d3 ee              shr    %cl,%r14
>>>     25: 4d 85 f6              test   %r14,%r14
>>>     28: 74 24                je     0x4e
>>>     2a:* 48 8b 4a 08          mov    0x8(%rdx),%rcx <-- trapping instruction
>>>     2e: f6 c1 01              test   $0x1,%cl
>>>     31: 0f 85 cb 00 00 00    jne    0x102
>>>     37: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>>>     3c: 31 c9                xor    %ecx,%ecx
>>>     3e: 48                    rex.W
>>>     3f: f7                    .byte 0xf7
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>      0: 48 8b 4a 08          mov    0x8(%rdx),%rcx
>>>      4: f6 c1 01              test   $0x1,%cl
>>>      7: 0f 85 cb 00 00 00    jne    0xd8
>>>      d: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>>>     12: 31 c9                xor    %ecx,%ecx
>>>     14: 48                    rex.W
>>>     15: f7                    .byte 0xf7
>>> [  991.459215] RSP: 0018:ffffb11281d0ba90 EFLAGS: 00010202
>>> [  991.464434] RAX: ffffe14ec4208000 RBX: 0000000000005000 RCX: 0000000000000009
>>> [  991.471557] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000001000
>>> [  991.478681] RBP: ffffb11281d0bb88 R08: 00000000000020ff R09: ffffe14ec4208000
>>> [  991.485807] R10: 0000000000000005 R11: 0000000000000006 R12: ffff96b4825f4200
>>> [  991.492930] R13: 0000000000000001 R14: 000000003d6277bf R15: 0000000000000000
>>> [  991.500054] FS:  00007f41e80b9740(0000) GS:ffff96b83bc1b000(0000)
>>> knlGS:0000000000000000
>>> [  991.508132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  991.513870] CR2: 0000000000000008 CR3: 0000000106c42003 CR4: 00000000003706f0
>>> [  991.520994] note: udpgso_bench_tx[64842] exited with irqs disabled
>>>
>>>
>>> ## Source
>>> * Kernel version: 6.17.0-rc4
>>> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
>>> * Git describe: next-20250905
>>> * Git commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
>>> * Architectures: x86_64
>>> * Toolchains: clang-nightly
>>> * Kconfigs: defconfig+selftests/*/config
>>>
>>> ## Build
>>> * Test log: https://qa-reports.linaro.org/api/testruns/29777495/log_file/
>>> * LAVA test log: https://lkft.validation.linaro.org/scheduler/job/8434053#L16943
>>> * Test details:
>>> https://regressions.linaro.org/lkft/linux-next-master/next-20250905/log-parser-test/oops-oops-oops-smp-pti/
>>> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32GkXBGNRNDEj5d64zd73eXhXQC
>>> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32GkU7mdlpISpPeeeEwIfAJuzqG/
>>> * Kernel config:
>>> https://storage.tuxsuite.com/public/linaro/lkft/builds/32GkU7mdlpISpPeeeEwIfAJuzqG/config
>>>
>>> --
>>> Linaro LKFT
>>> https://lkft.linaro.org
>>
>> I suspect a bug added in mm/gup.c recently
>>
>> commit db076b5db550aa34169dceee81d0974c7b2a2482
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Mon Sep 1 17:03:40 2025 +0200
>>
>>       mm/gup: remove record_subpages()
>>
>>       We can just cleanup the code by calculating the #refs earlier, so we can
>>       just inline what remains of record_subpages().
>>
>>       Calculate the number of references/pages ahead of times, and record them
>>       only once all our tests passed.
>>
>>       Link: https://lkml.kernel.org/r/20250901150359.867252-20-david@redhat.com
>>       Signed-off-by: David Hildenbrand <david@redhat.com>
>>       Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
> 
> Yes, fix already on its way:
> 
> https://lkml.kernel.org/r/5090355d-546a-4d06-99e1-064354d156b5@redhat.com
> 

#syz dup: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register

-- 
Cheers

David / dhildenb


