Return-Path: <linux-kselftest+bounces-30053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0603A7A02A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB416654B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28B24634F;
	Thu,  3 Apr 2025 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig+s+hYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FD248868;
	Thu,  3 Apr 2025 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673049; cv=none; b=nKtltPSprvliOdX2RYkMFG/jA+5A7GV1FJq3b4AQGJ0t8uzz+8GsVdZt1FvcHbCqc2RG7bo7mN0mmsQyjrnu+FHNL/l4nWRo8SCD2sTZjBtES7f6z9MXg5z+RHooiBCtkSz5QEJjdkqLtQzrNbELVSyM/vlttY3Xti7U3x5M+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673049; c=relaxed/simple;
	bh=Coan5fmk6E+RdsNlnuGPbdLAJylFKtntjKLClwzjJaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzi1PXCwaV3gXAw88T6tFy7BknM1j0pihjDnZfbbiSSYMAwergX2vqUvHwpl3GhwczX7C8f+432rBAz/2p2d+DkAFWE37BcZgx2DRwIzdgzDxVNQrramaH5Y5+gzsbpUdN59vADeHtOX2NLLUOPO7oDd6UwZuaZreI+EE2TNIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig+s+hYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BCFC4CEE3;
	Thu,  3 Apr 2025 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743673048;
	bh=Coan5fmk6E+RdsNlnuGPbdLAJylFKtntjKLClwzjJaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ig+s+hYaQHzELTAg91ITV3teiTpfEPSBqrj1zwv+43dLClfpkRJkweKQjDhZi5/DD
	 60T+pB1Vsw8mwP1oep0aPlOJB3J1sbGZD7lp7GYk6YOedMHnmUAQRf0zVwyIoRUDsq
	 JQjwivrt7PURqX7GDdNgCHbrHqJQlKZsTlKbRmHVATsX7EOD8Wo1dAZVyp9S4z9JzS
	 q0B+Xx8rUulz4PdpXr+1A5LEZS/AERYSxxHDdJT9A0NtWH17lr3ClT3RPpzmty4d4o
	 MziNvs8DbfXpSbqeH4MLoUf+23Pamfd4fXKme6Rp4ccnEZv+rBVl5CT1SPb16UNyjm
	 C0mrk8uMmXKlg==
Message-ID: <78b2d2ad-4e0e-41b7-95b4-b7fe945dfe13@kernel.org>
Date: Thu, 3 Apr 2025 11:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: add perf test for
 adjust_{head,meta}
To: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Anton Protopopov <aspsk@isovalent.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Jordan Rome <linux@jordanrome.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>,
 David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-3-jiayuan.chen@linux.dev>
 <20250402172447.75ed447f@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250402172447.75ed447f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/04/2025 02.24, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 11:23:45 +0800 Jiayuan Chen wrote:
>> which is negligible for the net stack.
>>
>> Before memset
>> ./test_progs -a xdp_adjust_head_perf -v
>> run adjust head with size 6 cost 56 ns
>> run adjust head with size 20 cost 56 ns
>> run adjust head with size 40 cost 56 ns
>> run adjust head with size 200 cost 56 ns
>>
>> After memset
>> ./test_progs -a xdp_adjust_head_perf -v
>> run adjust head with size 6 cost 58 ns
>> run adjust head with size 20 cost 58 ns
>> run adjust head with size 40 cost 58 ns
>> run adjust head with size 200 cost 66 ns
> 
> FWIW I'm not sure if this is "negligible" for XDP like you say,
> but I defer to Jesper :)

It would be too much for the XDP_DROP use-case, e.g. DDoS protection and
driver hardware eval. But this is changing a BPF-helper, which means it
is opt-in by the BPF-programmer.  Thus, we can accept larger perf
overhead here.

I suspect your 2 nanosec overhead primarily comes from the function call
overhead.  On my AMD production system with SRSO mitigation enabled I
expect to see around 6 ns overhead (5.699 ns), which is sad.

I've done a lot of benchmarking of memset (see [1]). One take-away is
that memset with small const values will get compiled into very fast
code that avoids the function call (basically QWORD MOVs).  E.g. memset
with const 32 is extremely fast[2], on my system it takes 0.673 ns (and
0.562 ns comes from for-loop overhead).  Thus, it is possible to do
something faster, as we are clearing very small values. I.e. using a
duff's device construct like I did for remainder in [2].

In this case, as this is a BPF-helper, I am uncertain if it is worth the
complexity to add such optimizations... I guess not.
This turned into a long way of saying, I'm okay with this change.

[1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench_memset.c

[2] 
https://github.com/netoptimizer/prototype-kernel/blob/35b1716d0c300e7fa2c8b6d8cfed2ec81df8f3a4/kernel/lib/time_bench_memset.c#L520-L521

--Jesper

