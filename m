Return-Path: <linux-kselftest+bounces-3174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996A0830E93
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 22:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159E9B25D7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 21:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E725574;
	Wed, 17 Jan 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h6m3Cvnd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D825570
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526617; cv=none; b=k7Yy/114UBXwYCHhqZQsKClydjedfgZyQYjW8clAowcVISJ2w9pYxTpgJnpIVDIt9NTe5u2srwyVcKe/6L1krVrXBhs8ZU+CaOZ1awlo+n+jEGwy1CDmNnXXY4XrKgo0NHeDW24P/C2zGCnknLs3PULmkNSUOQRNTH2GWOdV+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526617; c=relaxed/simple;
	bh=93LlwyHyTkQO2KrqYA5lB0CVoPPZAC3B0Z1WLjl1+Ww=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=ZKcN2w7nFP0G2ClptLw1tKyuPLdhug7/aEqeFe54/ZjtgcwXdRaJFZA9qhOyLr6XGbh1nNZpym0Sm2Lve4SNWOPiGYJRBCEOf5Zt4F5AWchgesgQfhRvRYTPY0FtkmLJ+kb8l1KwDhIw75jkzo2xdKlscGEMNRGr/RHApHpo4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h6m3Cvnd; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73235f05-8474-4341-b70b-34bd0e6dfac5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705526613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ct5ToPw3LUaNOoDO1thQP66v+Llmlbh3AXHo2CAPhSc=;
	b=h6m3CvndLIJ5uzrmzBqR1nJWilSirVxV4yW+4QLzpTzKLqgIyNSmf14X7yh2YdXJREN8jX
	i/xsrAeU6zEK0x6m8rcAy1E4gxL0gxMcC6UGQXrSJUXqewmGBjkv8WNuBSNwmJLVk5Ceuf
	eWkXKO6Nc2SIe0RB69QFBga8uc1sZK0=
Date: Wed, 17 Jan 2024 13:23:25 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <j-t.hinz@alumni.tu-berlin.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
 <51fd5249-140a-4f1b-b20e-703f159e88a3@linux.dev>
 <65a7f855821cc_6d500294d0@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65a7f855821cc_6d500294d0@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 7:55 AM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 1/16/24 7:17 AM, Willem de Bruijn wrote:
>>> Jörn-Thorben Hinz wrote:
>>>> A BPF application, e.g., a TCP congestion control, might benefit from or
>>>> even require precise (=hardware) packet timestamps. These timestamps are
>>>> already available through __sk_buff.hwtstamp and
>>>> bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs were
>>>> not allowed to set SO_TIMESTAMPING* on sockets.
>>
>> This patch only uses the SOF_TIMESTAMPING_RX_HARDWARE in the selftest. How about
>> others? e.g. the SOF_TIMESTAMPING_TX_* that will affect the sk->sk_error_queue
>> which seems not good. If rx tstamp is useful, tx tstamp should be useful also?
> 
> Good point. Or should not be allowed to be set from BPF.
> 
> That significantly changes process behavior, e.g., by returning POLLERR.
>   
>>>>
>>>> Enable BPF programs to actively request the generation of timestamps
>>>> from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
>>>> network device must still be done separately, in user space.
>>
>> hmm... so both ioctl(SIOCSHWTSTAMP) of the netdevice and the
>> SOF_TIMESTAMPING_RX_HARDWARE of the sk must be done?
>>
>> I likely miss something. When skb is created  in the driver rx path, the sk is
>> not known yet though. How the SOF_TIMESTAMPING_RX_HARDWARE of the sk affects the
>> skb_shinfo(skb)->hwtstamps?
> 
> Indeed it does not seem to do anything in the datapath.
> 
> Requesting SOF_TIMESTAMPING_RX_SOFTWARE will call net_enable_timestamp
> to start timestamping packets.
> 
> But SOF_TIMESTAMPING_RX_HARDWARE does not so thing.
> 
> Drivers do use it in ethtool get_ts_info to signal hardware
> capabilities. But those must be configured using the ioctl.
> 
> It is there more for consistency with the other timestamp recording
> options, I suppose.
> 

Thanks for the explanation on the SOF_TIMESTAMPING_RX_{HARDWARE,SOFTWARE}.

__sk_buff.hwtstamp should have the NIC rx timestamp then as long as the NIC is 
ioctl configured.

Jorn, do you need RX_SOFTWARE? From looking at net_timestamp_set(), any socket 
requested RX_SOFTWARE should be enough to get a skb->tstamp for all skbs. A 
workaround is to manually create a socket and turn on RX_SOFTWARE.

It will still be nice to get proper bpf_setsockopt() support for RX_SOFTWARE but 
it should be considered together with how SO_TIMESTAMPING_TX_* should work in 
bpf prog considering the TX tstamping does not have a workaround solution like 
RX_SOFTWARE.

It is probably cleaner to have a separate bit in sk->sk_tsflags for bpf such 
that the bpf prog won't be affected by the userspace turning it on/off and it 
won't change the userspace's expectation also (e.g. sk_error_queue and POLLERR).

The part that needs more thoughts in the tx tstamp is how to notify the bpf prog 
to consume it. Potentially the kernel can involve a bpf prog to collect the tx 
timestamp when the bpf bit in sk->sk_tsflags is set. An example on how TCP-CC is 
using it will help to think of the approach here.


