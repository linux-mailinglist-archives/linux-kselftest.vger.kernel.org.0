Return-Path: <linux-kselftest+bounces-21199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC69B7874
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9262B22F48
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C8198E93;
	Thu, 31 Oct 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z73tf9kf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C9193439
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369610; cv=none; b=BdfQSJBtrp+F6+PvuYyqVbPfShcbSHgxwoHZu/yW2rBGTOG5LouY01M7CuCsGjAwfgeRrjOC7wgTiYaD5ZW/4ycKe38TrdcjpoB0Yfh8sNTz/ufJQ0XVJzX+8GpSZ2zvyAucjA6f99vWGIyLkJSl56fwfIcUnuadjv996DvHLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369610; c=relaxed/simple;
	bh=fXxSVMz93g9pT9H5CH7uPNFmTLZeJHNmc6B1HbdMZts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTsVBwe+tVFMkGbR3heB6+2QOyqm/6axnn20wPYTDGftswld/w/NfXCWQzAzBybbqRv1rgd62s9SF7gnq6Izywb86ZJufAGubYDBoMdL2r7OvWAzW4KdZVENeCb03SlhGb1Ia3e9dII8vI6PZZAkQ2gPRLjZ6rfDWAn68WHIE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z73tf9kf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730369607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qpsGLSEnI+XWmBEuuVMwNo+r2BaEC8hB8NVYcY+RYc=;
	b=Z73tf9kfBwhD5MUXKsCWATHDPPC+DxZk/BRcxIRazXqBpyRoGS9bHpDbNaR1psrlXfQdpf
	LRyHh7yIRXnc6Gt26B48p4aRaqn+hRiCmkgd1yrbv5dfH6dn21eLBOf8fu2IF3VuqgRfbf
	KapxgCU1j6bzIxX+AYYA6gFOLDZ9V6c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-IstJP6dTOKKAtZkVnDRb3A-1; Thu, 31 Oct 2024 06:13:25 -0400
X-MC-Unique: IstJP6dTOKKAtZkVnDRb3A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so429273f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730369604; x=1730974404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qpsGLSEnI+XWmBEuuVMwNo+r2BaEC8hB8NVYcY+RYc=;
        b=dNSrkE9LUGigTGbvb0je4WLAkIEBs08cDAFcNw0JEzIMOSt6PqzyZ3BZMU5iUUEVCi
         BaKCawRLV54XsbTz+fUOh/jOg6JcHsSIoixtSUxts/oXu3V/giJTnWPgH4pfgx0nvQ93
         nVvSYDMU78zOVpm2BPr1wvZLwXIHID4mYWxUy+A4ojVX/CXvO64KuMZy1FXsMkdEW4j8
         abq3sQKXXo6DP+ZgTUJ1hXjBsYnQFBlh2RfoBQxIbd94IhRZBNfMS24t87H1ngNe9x5i
         SgwP/qScwZ1LifRCyzENylPunldKOyn7U5ACI0BdyPTw/mc0wEj01pJydzUj60mu9A2r
         toug==
X-Forwarded-Encrypted: i=1; AJvYcCVzdIOeAOGRwp0T5oe8eG84NCcCT5RLFwv+cw9GatetV1YrANzlArPRDp2zrwk8ZBxIDIc3vjsIe5eRvl1Rw10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMKO2Xw1X/uExQ3/Fb5pYl+E+WTOfHOGL/qu5RC9NTBLWhaAN
	ewm8BkGwZ6qlDAz5bYmxYZhCfAdSaphJQTZ74h0XQ8br+zKN/9/9RcL8UXhHv2dmDAWPSMYouzO
	/KwnmEzLcnauEHHE/2Xg2lQWyJpLE+03crO83BxgegBBsO0qS0jdD0xEkdyZPwin4yA==
X-Received: by 2002:a05:6000:18a5:b0:369:9358:4634 with SMTP id ffacd0b85a97d-381be7c80a7mr2432261f8f.19.1730369604511;
        Thu, 31 Oct 2024 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7Z4vtf7/u6NjtUKe9akOrVpf/NCyjOUCTQtYcxrwIu/laeojTfp3Q1NBwmWGlWwyZTZGmQ==
X-Received: by 2002:a05:6000:18a5:b0:369:9358:4634 with SMTP id ffacd0b85a97d-381be7c80a7mr2432230f8f.19.1730369604041;
        Thu, 31 Oct 2024 03:13:24 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e565csm1653659f8f.48.2024.10.31.03.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:13:23 -0700 (PDT)
Message-ID: <0dc8c829-23f0-4904-8017-fc98c079f0ab@redhat.com>
Date: Thu, 31 Oct 2024 11:13:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Adrian Oliver <kernel@aoliver.ca>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@idosch.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025073003.2079945-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241025073003.2079945-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/25/24 09:30, Omid Ehtemam-Haghighi wrote:
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
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Given the issue is long-standing, and the fix is somewhat invasive, I
suggest steering this patch on net-next.

Would that be ok for you?

Thanks,

Paolo


