Return-Path: <linux-kselftest+bounces-18370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E87986721
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 21:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D12845CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0A14659F;
	Wed, 25 Sep 2024 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgT8KXNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FB142E83
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727293549; cv=none; b=JUpJk74cA+dTVXK5BYXUkSa6ftSCZ0OVmc5N12ETdZdDWK4jn5zj4OSyueUGOreRMp1q3eKRjhIcH0OOFf+vTEbpPJTtHN6keEc5lX0tCWmXKN699pJaw/25Gv7b6j5HZDLWiHDGvjkmWDQErK2qlEI8OcV6Ba//R87Hj0AwIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727293549; c=relaxed/simple;
	bh=/+kdZQ5YHJwk5UqW5/x5VvZy36jmX/1B0aCZVsLz934=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg2uup0sovtyLUpNZrGA5V41UnQCHE+WHFXa9gozzUJnSjzmX30oEJzHWrVoepuLtrJwtyR0zUW3cki9grZ0XqxoYENdtFdn9KUSU1m9uU+EOHIPjiKD7JiNrMw02MUtW0bJ2pnBr7yDVE1b5h3ic8GmHc/+mOgL+2QY/Msv4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgT8KXNL; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97229412-7506-4b71-b77a-0993b2f07c60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727293544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cl+NY6biSh5nINCc+id3pfw9oMtmyYXAOxWEXpGs8ic=;
	b=xgT8KXNLGBDFMYK6h/xeqLhMy9HNx2NijbwLLNN1DCzbhE7MUHDViEplQcSANS/w2hbFM5
	VksTKHCTRpqyi6bgXDV2Q5zC0cQVvZLAxw1BD4+6UNtmOmbf0H7Jow37QLH33GhAAJYrWi
	RkTw9YuQmIOxYM8r1lrkidraCF2Ab70=
Date: Wed, 25 Sep 2024 12:45:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 0/2] bpf: devmap: provide rxq after redirect
To: Paolo Abeni <pabeni@redhat.com>,
 Florian Kauer <florian.kauer@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <brouer@redhat.com>, linux-kselftest@vger.kernel.org
References: <20240911-devel-koalo-fix-ingress-ifindex-v4-0-5c643ae10258@linutronix.de>
 <dd84c2d8-1571-41e9-8562-a4db232fbc38@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <dd84c2d8-1571-41e9-8562-a4db232fbc38@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/19/24 11:12 AM, Paolo Abeni wrote:
> On 9/11/24 10:41, Florian Kauer wrote:
>> rxq contains a pointer to the device from where
>> the redirect happened. Currently, the BPF program
>> that was executed after a redirect via BPF_MAP_TYPE_DEVMAP*
>> does not have it set.
>>
>> Add bugfix and related selftest.
>>
>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>> ---
>> Changes in v4:
>> - return -> goto out_close, thanks Toke
>> - Link to v3: https://lore.kernel.org/r/20240909-devel-koalo-fix-ingress- 
>> ifindex-v3-0-66218191ecca@linutronix.de
>>
>> Changes in v3:
>> - initialize skel to NULL, thanks Stanislav
>> - Link to v2: https://lore.kernel.org/r/20240906-devel-koalo-fix-ingress- 
>> ifindex-v2-0-4caa12c644b4@linutronix.de
>>
>> Changes in v2:
>> - changed fixes tag
>> - added selftest
>> - Link to v1: https://lore.kernel.org/r/20240905-devel-koalo-fix-ingress- 
>> ifindex-v1-1-d12a0d74c29c@linutronix.de
>>
>> ---
>> Florian Kauer (2):
>>        bpf: devmap: provide rxq after redirect
>>        bpf: selftests: send packet to devmap redirect XDP
>>
>>   kernel/bpf/devmap.c                                |  11 +-
>>   .../selftests/bpf/prog_tests/xdp_devmap_attach.c   | 114 +++++++++++++++++++--
>>   2 files changed, 115 insertions(+), 10 deletions(-)
> 
> Alex, Daniel: this will go directly via the bpf tree, right?

The patches lgtm also. Yes, it can directly go to the bpf tree.

It is useful if I can get an ack from netdev (Paolo?) at least for patch 1. Thanks.


