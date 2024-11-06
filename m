Return-Path: <linux-kselftest+bounces-21511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F19BE20D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D877C284050
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064C1DD0E2;
	Wed,  6 Nov 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHM+RXbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EA1D5ACF
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884282; cv=none; b=u/KdWMl/d+X6kBlD01D9FsnG7B0ZUHlYL3rZwpDLzpoU1ou63IQbpMXJO3YWjNySScMsP8cw8rSVk+eE+2/Iy/X/te32xeOIjDZ7iu+h6ifn9qKhheXEMU6ovrKAi5PpS066VY7asbVP0hV93UEWWfH3bDJbwL1qGG/anugk+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884282; c=relaxed/simple;
	bh=q7SJcZmF11fUNIjvJGOzX6ykdvC1BruvADyGOTxpGys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9xrP88Umbdpw5Aczi+Nu49sRJB/tsoEK0seyt1NUw0PocRzoYaI9Xpp51T55wHKxnZeKqqvXg4sZzKNgq+fUD7XbgZUBKzwJq2NCSJ2k4bV627mYfHLktiIVZer8SB6cGYvIJZGyUtJpqLmibtOg0mu7CICWL2ar4Trc/Nx+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHM+RXbI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhphUlT0//AFWE/BWTlSiiQ4wKfg50gq57SuG58vcR8=;
	b=QHM+RXbInezUJnKp/deTF0X0NksZg2gyzMQx4Dl2Vy2mBM6NLmkEpwXpC1YBjFKG2TIs6G
	87GOYS9B3xzm7HPV+epyYKTyn2oxmPuwunKxPD4TLXb2H8Zvf2MbtXf+vCKQ2d61nmoU/G
	U+8R9b96T/Rou/SApuP1zQZPDMM8ekg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-TO2Cq21oOEGAndNXxzBMVA-1; Wed, 06 Nov 2024 04:11:17 -0500
X-MC-Unique: TO2Cq21oOEGAndNXxzBMVA-1
X-Mimecast-MFC-AGG-ID: TO2Cq21oOEGAndNXxzBMVA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381d0582ad3so3136982f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 01:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884276; x=1731489076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhphUlT0//AFWE/BWTlSiiQ4wKfg50gq57SuG58vcR8=;
        b=loBG11m1PKQaUn+5DOd3BUBrn9eiLGVi0d8KaUzV6245HjE0zDmC7Udrb5/xoH+bSb
         43UHLR0zwJMYL3x5skvvjzMX3vmjNfwZHQN4cX89Q6YlWYEW67fCJczF67ZilNKNA9Lf
         jMnBoMhrtSk5w068ww+ODTu4incBUwfAav3vyQHYmOmQxsNETvIEazo1Nv2RyUlYrnhn
         cbNxWYk2THzPrscHENOdboiAX2/AvqdpEyczdGVWH0XhzCk21OkLzWmFWlQBp2PAQv3E
         8EP7gQYTwT8QlfbfFZAeBYxtD0+Z2OKvY9Iq1GlsFjx9hJzK0s22JdZbUesPNuBQlwZJ
         aJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCX2/8RnDAGKRnL8xi8s8Cips9BNHzmTFQ5t1Zwd2TPkXmp2lVMbKSouFzKWzc2tXOEwDafUDtCraQXo8ni47eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0jD9u04HO9u+laZ4CgKPus33Kvh8DsrTut6bKiZrZFeeAvgD
	eXCGnwC2zvnDxj5Y1iHGXl05sZqPbtTVhxO8HUodLvDkHHMnJ6M7goGVzcKG47BH5fTy0556Oab
	GpA5ErbmKvwPeP3HYsR12k0EVl1IFoMJ3irevZHRjEogEKxNzmrsuZdu2rpicVSfJUZdcasw2vN
	cZ
X-Received: by 2002:a05:6000:18a3:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-381c7ac41eamr17677493f8f.44.1730884275737;
        Wed, 06 Nov 2024 01:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLzHYI2BIeljzaiHEBHx+CtBhdAyO2CLbKJ8wxJbMqDl6oNHSvyKiDGGB2gz9wKtNBsoA3kg==
X-Received: by 2002:a05:6000:18a3:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-381c7ac41eamr17677405f8f.44.1730884274708;
        Wed, 06 Nov 2024 01:11:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6b35c0sm15348155e9.16.2024.11.06.01.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:11:14 -0800 (PST)
Message-ID: <60999fc9-e1d6-4bb3-aa30-f959216a1b29@redhat.com>
Date: Wed, 6 Nov 2024 10:11:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] ipv6: release nexthop on device removal
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1730828007.git.pabeni@redhat.com>
 <604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com>
 <b5000fd7-c613-4d04-b8d7-53c193d36236@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b5000fd7-c613-4d04-b8d7-53c193d36236@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 22:40, David Ahern wrote:
> On 11/5/24 11:23 AM, Paolo Abeni wrote:
>> The CI is hitting some aperiodic hangup at device removal time in the
>> pmtu.sh self-test:
>>
>> unregister_netdevice: waiting for veth_A-R1 to become free. Usage count = 6
>> ref_tracker: veth_A-R1@ffff888013df15d8 has 1/5 users at
>> 	dst_init+0x84/0x4a0
>> 	dst_alloc+0x97/0x150
>> 	ip6_dst_alloc+0x23/0x90
>> 	ip6_rt_pcpu_alloc+0x1e6/0x520
>> 	ip6_pol_route+0x56f/0x840
>> 	fib6_rule_lookup+0x334/0x630
>> 	ip6_route_output_flags+0x259/0x480
>> 	ip6_dst_lookup_tail.constprop.0+0x5c2/0x940
>> 	ip6_dst_lookup_flow+0x88/0x190
>> 	udp_tunnel6_dst_lookup+0x2a7/0x4c0
>> 	vxlan_xmit_one+0xbde/0x4a50 [vxlan]
>> 	vxlan_xmit+0x9ad/0xf20 [vxlan]
>> 	dev_hard_start_xmit+0x10e/0x360
>> 	__dev_queue_xmit+0xf95/0x18c0
>> 	arp_solicit+0x4a2/0xe00
>> 	neigh_probe+0xaa/0xf0
>>
>> While the first suspect is the dst_cache, explicitly tracking the dst
>> owing the last device reference via probes proved such dst is held by
>> the nexthop in the originating fib6_info.
>>
>> Similar to commit f5b51fe804ec ("ipv6: route: purge exception on
>> removal"), we need to explicitly release the originating fib info when
>> disconnecting a to-be-removed device from a live ipv6 dst: move the
>> fib6_info cleanup into ip6_dst_ifdown().
>>
>> Tested running:
>>
>> ./pmtu.sh cleanup_ipv6_exception
>>
>> in a tight loop for more than 400 iterations with no spat, running an
>> unpatched kernel  I observed a splat every ~10 iterations.
>>
>> Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")
> 
> are you sure that is the correct Fixes? That commit is June 2019 and
> there have been stable periods since then without netdev release problems.

"Sure" is a big word ;) AFAICS the mentioned commit let fib6_info store
indirectly the extra dev reference via nexthop and does not clean it at
device removal time.

Note that the issue is not deterministic - I needed ~30 mptu.sh
iterations in a row to see it, so it could go unnoticed for a long time.

>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>  - dropped unintended whitespace change
>> ---
>>  net/ipv6/route.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks!

Paolo


