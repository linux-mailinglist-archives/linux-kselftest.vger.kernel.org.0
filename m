Return-Path: <linux-kselftest+bounces-29497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E05A6A5F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 13:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D4D189A6D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDE221D92;
	Thu, 20 Mar 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MfKW5vZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1E21D3D4;
	Thu, 20 Mar 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472366; cv=none; b=qTynRqnteDeYuO77zDAl2PypVvn6TRhk0SFr3w7swAcHLD1vUD46IDPrswmglkoTKLPGrUlCtFh1pkkTF3OdShStGWLekhNqEvNIgM+363JiM4lhXlRpL9w8kpLyVZybtX0BeIjfGgFUfC38pnkX6DmSpAjpwmxhCaMD/27vLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472366; c=relaxed/simple;
	bh=RP8m+cI8EIFrcJC5Arx0ydpQjxHIdTN1PNVsy4F58hc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BadrG8FWCfamMV4fXd18oQIxiRtZdedK2OrhbbSUemP7eN+PXPCZ9ZvaN4aM8TN9Z5hQ9DPB0WXp4rQCGQAMAX9reNy8T7s5PlrzALQSaQMN2f+dWiaiSLaRWI4r9HsmNuoNH0appTN0CCfPPutedhxs9uqJMVe6cDJBtm6YA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MfKW5vZd; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tvEeX-0063Kz-Ud; Thu, 20 Mar 2025 13:05:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=6fOje8AeUS/Yxn3hx5OTHsOh5tHx9bATkJVXXWk7VAw=; b=MfKW5vZd3fMkyXspnk8lBKIt8z
	MpZ0BJLYCCPteWSSD4spC/GfH71VWrqxTiMecNO40Pv2Ukl6PlgCk3SAE+wvzotNrolapGX3LHkNK
	sdKqt/1ki5let0Ms7sWBEh3mk3y3CefAZEahJUQKXht95KPm6d7wE9zMBpdbs02gSZ8aRxYO9kBYg
	bYzFZgSUYehTiUiXoErtg7a75uxcJs3WcQ3ypZ9DBHJoEsDdNMvjAsU9vleGqXwVA/NKlXJ7dtPFX
	ZsasutGAkB47/RuqCoyDLISON8W+n4wT2iGejFXLEcSplmjLmeyWEHcVCRJZ0LP+JGlpo/8GW6z5X
	xtbgzHrA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tvEeW-000461-EZ; Thu, 20 Mar 2025 13:05:36 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tvEeQ-00H9rZ-5u; Thu, 20 Mar 2025 13:05:30 +0100
Message-ID: <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>
Date: Thu, 20 Mar 2025 13:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
 <Z9tCnq0rBw+nETfW@pop-os.localdomain>
Content-Language: pl-PL, en-GB
In-Reply-To: <Z9tCnq0rBw+nETfW@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 23:18, Cong Wang wrote:
> On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
>> Signal delivery during connect() may lead to a disconnect of an already
>> established socket. That involves removing socket from any sockmap and
>> resetting state to SS_UNCONNECTED. While it correctly restores socket's
>> proto, a call to vsock_bpf_recvmsg() might have been already under way in
>> another thread. If the connect()ing thread reassigns the vsock transport to
>> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
>>

   *THREAD 1*                      *THREAD 2*

>> connect
>>   / state = SS_CONNECTED /
>>                                 sock_map_update_elem
>>                                 vsock_bpf_recvmsg
>>                                   psock = sk_psock_get()
>>   lock sk
>>   if signal_pending
>>     unhash
>>       sock_map_remove_links
> 
> So vsock's ->recvmsg() should be restored after this, right? Then how is
> vsock_bpf_recvmsg() called afterward?

I'm not sure I understand the question, so I've added a header above: those
are 2 parallel flows of execution. vsock_bpf_recvmsg() wasn't called
afterwards. It was called before sock_map_remove_links(). Note that at the
time of sock_map_remove_links() (in T1), vsock_bpf_recvmsg() is still
executing (in T2).

>>     state = SS_UNCONNECTED
>>   release sk
>>
>> connect
>>   transport = NULL
>>                                   lock sk
>>                                   WARN_ON_ONCE(!vsk->transport)
>>
> 
> And I am wondering why we need to WARN here since we can handle this error
> case correctly?

The WARN and transport check are here for defensive measures, and to state
a contract.

But I think I get your point. If we accept for a fact of life that BPF code
should be able to handle transport disappearing - then WARN can be removed
(while keeping the check) and this patch can be dropped.

My aim, instead, was to keep things consistent. By which I mean sticking to
the conditions expressed in vsock_bpf_update_proto() as invariants; so that
vsock with a psock is guaranteed to have transport assigned.

