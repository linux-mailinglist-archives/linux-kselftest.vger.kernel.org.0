Return-Path: <linux-kselftest+bounces-3134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5499883008E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 08:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FDA1F24BA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811DBA27;
	Wed, 17 Jan 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aQdvwjzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5DC139
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476833; cv=none; b=Poe9f0bHVr8Z0QJgBvjwCGO012Vz2iVR5x49r3bbZJwbwBnGyTPkn3JMObJj5dNuGzEt6bX8gCxFzAkupd6K/LtVvS1jbzSix4McdrJrD/Hh0JJRg7xvDMiS1puHlndlOMwVETjZx4nF5s2yorVx7XxksAz2zCs4RPIlJv8RrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476833; c=relaxed/simple;
	bh=3YX7pDoceQX+E+TvVPVvV9f2P0ODXQ1tsjMOk7kPRaE=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=b4tSdTJJGhbjAtDQhL5+LrjMNCyCRmS4mL/BHYgSXeua5IMvEEdPKQNezs1C2NX975TBXgtmli4PeQemty0AT6YsNbq1DkR1aj9M7ntHRmtYUxNa0vm3g86OXpuI0IWjYVDT2kjJKEpbGSKmANjOnn958+w3/267+PrHr4WCgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aQdvwjzu; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51fd5249-140a-4f1b-b20e-703f159e88a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705476829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oceJQDqoX4I7y29qmqcV6++w314V1TBOmZ9jW9CBGiQ=;
	b=aQdvwjzuKH4Mw5ibWflyGPsS2g6+/CnLCjfdWOoPu0k8znSNt+CmydaGi3uV2EL0WxLGIj
	HOh40RCMoLdQ5nCvicBMUfyAcwmxm+kSVLSCdG3nstmn6gvvdTFHBlB5ZxjM1kHTX/1RBu
	BRRVKyn3CHDDArGpEzjoYJHSW7U+2oc=
Date: Tue, 16 Jan 2024 23:33:39 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
Content-Language: en-US
To: =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <j-t.hinz@alumni.tu-berlin.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/16/24 7:17 AM, Willem de Bruijn wrote:
> Jörn-Thorben Hinz wrote:
>> A BPF application, e.g., a TCP congestion control, might benefit from or
>> even require precise (=hardware) packet timestamps. These timestamps are
>> already available through __sk_buff.hwtstamp and
>> bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs were
>> not allowed to set SO_TIMESTAMPING* on sockets.

This patch only uses the SOF_TIMESTAMPING_RX_HARDWARE in the selftest. How about 
others? e.g. the SOF_TIMESTAMPING_TX_* that will affect the sk->sk_error_queue 
which seems not good. If rx tstamp is useful, tx tstamp should be useful also?

>>
>> Enable BPF programs to actively request the generation of timestamps
>> from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
>> network device must still be done separately, in user space.

hmm... so both ioctl(SIOCSHWTSTAMP) of the netdevice and the 
SOF_TIMESTAMPING_RX_HARDWARE of the sk must be done?

I likely miss something. When skb is created in the driver rx path, the sk is 
not known yet though. How the SOF_TIMESTAMPING_RX_HARDWARE of the sk affects the 
skb_shinfo(skb)->hwtstamps?




