Return-Path: <linux-kselftest+bounces-21752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5129C35CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 02:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647031C21973
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050AC749A;
	Mon, 11 Nov 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dayWE9ri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E828EC;
	Mon, 11 Nov 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287019; cv=none; b=spixLD4NE3d5sLZhr3JAaeeRgQKX2kqyg2/D2VTudCgUahza403U6UiO//z21VHtCU1McjBSjsH/3TkB2kxg7xbgn61kMKi5MZANKkEzQ/6tkuB+BOVFZ1MmFQb62yVJoDZh5wXZbRxPDjaKRPeq7r/vba2vjZ5zmubKL4zZZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287019; c=relaxed/simple;
	bh=QG/zhBWiCy70k/GuKQr3ws1iZtC9IDEjJESgh16/QMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvYZCHYe4GR5QIh17AIAxsaPZVbMr/KRWypBI4dQfmnwY55i3M0yyDECFJI/L5yd6AeomGarFtnujyedFAbuB0vT71QU+0dEeWD4l3657yM3FmsWFHgAjDf5D9l+sAZ2QHNebxrNROoYbRb3vX4O5XVHev0ZMQ/jrim3bFjYvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dayWE9ri; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso174943139f.0;
        Sun, 10 Nov 2024 17:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731287017; x=1731891817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6gYKvXLGGIzqVwA6huSqeg9IOgIP9Fx1WH6gy+b/lk=;
        b=dayWE9riP84LkaTVysy6fMsNEShzgrCZH3MXQ9vQUSq5LKWnVgcIQJajMYjsTLEoEM
         vAemqsQrvYNRp74QfR0zfNaD3EuSbkX0EtHI4RNm6Ts+kZ8tF5G3D3Ot++DcLnOFS8dV
         3ypeZ6G5LeO6oSYjZrjEHZwqC36bgC4ezHiLh58id1mVNZ+4vLqkPunTrb1gNQAhEuuM
         Y1nckE1H6YVKhKJ1HE4s1SuScAjqQAb2s2cjeCWwHYq717+Mqe48FQIJiVj6sqrr2LSt
         aYe/Nk64tzXukD4bAcZxqvnjHQlCai9a/1kkgEHoiejQ7xi3RQV77lFC8YOGcdAFnKOE
         MKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731287017; x=1731891817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6gYKvXLGGIzqVwA6huSqeg9IOgIP9Fx1WH6gy+b/lk=;
        b=dGmUpUYT8IDPmxvfZk7bI561u+7b/gH9Wav6eLyEWKI765NXCzoPv8zyMOLujI/Jl1
         ewv4OjPmhg3ssP5nneh61w3GhPw4A50nNgJKK0988gcOScmPay8UyV5fLja8M2jVInWx
         UTtkosGY5wlKhhPZTyHfdpizyvyRex3Fxpa70qDr1mExmY5z4UDBI7GjRtsTC5vw+bme
         hYrjMf6AZiTptqLQjFH7mPvUSpe11kdJ3Yp8EdvglTC82t6WKlVCJadA4C+Y6RW1aA2L
         oZObiQe+T6NROqwJmtmdr9QH52XQTMorrS85FDb7ZjY+ecRguwdLfRaDBMmDb9YcReMY
         ipbw==
X-Forwarded-Encrypted: i=1; AJvYcCV3+xmv+zuvzf4YIkFbb9XuIFYG8vlN8f7nDzUPWQHBl2FjtNhes5KcuJxHjeHdmlWgE1vb56em@vger.kernel.org, AJvYcCWDe+s+ykZ+RYQ/RcADGUwkJoUyd5sIo5xL2aZsS2Ymtx/sFPfXI0gPxOz4s/b0TnS/KKURRCXvHTY6JuU=@vger.kernel.org, AJvYcCX73odQ7I0xzTq1OwVRN+T+7mQUXjV4FMqnu2TkPJvt//NqCP1Wo2TfAKS9ruAhssel+yqCjxEN3kFnTkc6FxcR@vger.kernel.org
X-Gm-Message-State: AOJu0YxrETW/V/lZNM7WVU35/4hwYyqPxoC8RVm3SMOSNQCEgRKz4zT1
	viQhkWmIqAuCF2v4mPq+ovgZ3b8CqiJR0NAcmEf4CvRD3thlPksN
X-Google-Smtp-Source: AGHT+IH4hwtMhrQkHW25RHvYt4Et6gwTmHLP2pPYPJHbuyHs92iTXlPK+NjmW9lx0g2QOPWnpVvZJg==
X-Received: by 2002:a05:6602:2c84:b0:837:7e21:1688 with SMTP id ca18e2360f4ac-83e033433d4mr1199214639f.11.1731287017158;
        Sun, 10 Nov 2024 17:03:37 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:54c3:8c58:2087:8094? ([2601:282:1e02:1040:54c3:8c58:2087:8094])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4de787414bbsm1077661173.52.2024.11.10.17.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 17:03:36 -0800 (PST)
Message-ID: <0729c59e-e495-4668-b486-4362393bd15d@gmail.com>
Date: Sun, 10 Nov 2024 18:03:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] ipv6: Fix soft lockups in fib6_select_path
 under high next hop churn
Content-Language: en-US
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Adrian Oliver <kernel@aoliver.ca>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, Omid Ehtemam-Haghighi
 <oeh.kernel@gmail.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106010236.1239299-1-omid.ehtemamhaghighi@menlosecurity.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20241106010236.1239299-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/24 6:02 PM, Omid Ehtemam-Haghighi wrote:
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
> 
> Apply RCU primitives in the problematic code sections to resolve the
> issue. Where necessary, update the references to fib6_siblings to
> annotate or use the RCU APIs.
> 
> Include a test script that reproduces the issue. The script
> periodically updates the routing table while generating a heavy load
> of outgoing IPv6 traffic through multiple iperf3 clients. It
> consistently induces infinite soft lockups within a couple of minutes.
> 
> Kernel log:
> 
>  0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
>  1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
>  2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
>  3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
>  4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
>  5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
>  6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
>  7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
> -- <IRQ stack> --
>  8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
>     [exception RIP: fib6_select_path+299]
>     RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
>     RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
>     RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
>     RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
>     R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
> 10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
> 11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
> 12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
> 13 [ffffbd13003d3a18] ip6_rcv_finish_core.constprop.0 at ffffffff8dd950d0
> 14 [ffffbd13003d3a30] ip6_list_rcv_finish.constprop.0 at ffffffff8dd96274
> 15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
> 16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
> 17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
> 18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
> 19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
> 20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
> 21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
> 22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
> 23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
> 24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
> 25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
> 26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
> 27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
> 28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
> 29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
> 30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb
> 
> Fixes: 66f5d6ce53e6 ("ipv6: replace rwlock with rcu and spinlock in fib6_table")
> Reported-by: Adrian Oliver <kernel@aoliver.ca>
> Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Omid Ehtemam-Haghighi <oeh.kernel@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v6 -> v7: 
> 	* Rebased on top of 'net-next'
> 
> v5 -> v6:
> 	* Adjust the comment line lengths in the test script to a maximum of
> 	  80 characters
> 	* Change memory allocation in inet6_rt_notify from gfp_any() to GFP_ATOMIC for
> 	  atomic allocation in non-blocking contexts, as suggested by Ido Schimmel
> 	* NOTE: I have executed the test script on both bare-metal servers and
> 	  virtualized environments such as QEMU and vng. In the case of bare-metal, it
> 	  consistently triggers a soft lockup in under a minute on unpatched kernels.
> 	  For the virtualized environments, an unpatched kernel compiled with the
> 	  Ubuntu 24.04 configuration also triggers a soft lockup, though it takes
> 	  longer; however, it did not trigger a soft lockup on kernels compiled with
> 	  configurations provided in:
> 
> 	  https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> 	  leading to potential false negatives in the test results.
> 
> 	  I am curious if this test can be executed on a bare-metal machine within a
> 	  CI system, if such a setup exists, rather than in a virtualized environment.
> 	  If that’s not possible, how can I apply a different kernel configuration,
> 	  such as the one used in Ubuntu 24.04, for this test? Please advise.
> 
> v4 -> v5:
> 	* Addressed review comments from Paolo Abeni.
> 	* Added additional clarifying comments in the test script.
> 	* Minor cleanup performed in the test script.
> 
> v3 -> v4:
> 	* Added RCU primitives to rt6_fill_node(). I found that this function is typically
> 	  called either with a table lock held or within rcu_read_lock/rcu_read_unlock
> 	  pairs, except in the following call chain, where the protection is unclear:
> 
> 		rt_fill_node()
> 		fib6_info_hw_flags_set()
> 		mlxsw_sp_fib6_offload_failed_flag_set()
> 		mlxsw_sp_router_fib6_event_work()
> 
> 	  The last function is initialized as a work item in mlxsw_sp_router_fib_event()
> 	  and scheduled for deferred execution. I am unsure if the execution context of
> 	  this work item is protected by any table lock or rcu_read_lock/rcu_read_unlock
> 	  pair, so I have added the protection. Please let me know if this is redundant.
> 
> 	* Other review comments addressed
> 
> v2 -> v3:
> 	* Removed redundant rcu_read_lock()/rcu_read_unlock() pairs
> 	* Revised the test script based on Ido Schimmel's feedback
> 	* Updated the test script to ensure compatibility with the latest iperf3 version
> 	* Fixed new warnings generated with 'C=2' in the previous version
> 	* Other review comments addressed
> 
> v1 -> v2:
> 	* list_del_rcu() is applied exclusively to legacy multipath code
> 	* All occurrences of fib6_siblings have been modified to utilize RCU
> 	  APIs for annotation and usage.
> 	* Additionally, a test script for reproducing the reported
> 	  issue is included
> ---
>  net/ipv6/ip6_fib.c                            |   8 +-
>  net/ipv6/route.c                              |  45 ++-
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../net/ipv6_route_update_soft_lockup.sh      | 262 ++++++++++++++++++
>  4 files changed, 297 insertions(+), 19 deletions(-)
>  create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


