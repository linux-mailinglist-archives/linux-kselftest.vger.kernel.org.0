Return-Path: <linux-kselftest+bounces-29527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC300A6B09D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E2D4A3405
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509E22687A;
	Thu, 20 Mar 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="DppHj6DT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385283594E;
	Thu, 20 Mar 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509022; cv=none; b=sJ7iJKAM5XlLaytAraGQONkhgKHOHlmnw3SfWMxyIQXwPzLjayD+9E45znho337iY4pNlFJ9HgKyHe2qNjEQakAIfWLqxsB81W8whNP4YSiItQaEnhIWMBWJp/cJi7J8JLDPCew0CIGJ/iTDuMasBYylNLbNAvGFsGvDoFHokBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509022; c=relaxed/simple;
	bh=znUtvKKc0CdQfSr9afLsvnM83KX4tqIW527OQlcZHb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5MxiupNvnQstwg1sH9fpkemhSZuSTdIWXaeUY+fW5nbra0LC7d2XZbVgShRZW9vwGq06LHRsEVO/cBt/JL0l4VEs0gfgbtaQPUffu72U0RQp/a8Z2QsPvwcf0+pBLYMjVCnsObNL3155L/pXDcRAhon1nXMGs3v014F7IBhzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=DppHj6DT; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tvOBx-007Y5y-9Q; Thu, 20 Mar 2025 23:16:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=XqP8KhBPjAdHvJU8dNi3259DC9br7mRBDOfW+7RNQzY=; b=DppHj6DTTO+TwyljifZmNfwXzd
	YxvW1rLrTunS7A7GoivopZq8kYbfVcTY5k7EXvJLzfwWm+nHgOrRliepkIMEawCYJbJn6IrR4mEA9
	6nS1dQh9hdKF1Fp6vpy+ER+8FygdouS5cDE1xukqpeP8Fm/exitNpWIlUBszLqmgDv/SNpqzpdwsm
	8QiHK5Ij8zD9F+eAnzXuat3gNC3Lu+EkGFIOJTkt7qWMUqPdQYgOPGYzTjC+ZIhhfTRHJ4FUWU73I
	IkN4aA7wbJTIwT4wgoAYh6i8bFevWhTcODB1l+BebSWdJypoHnSkG08bigEUBMyJhgXpHK25e3Y5O
	w/cbYWVw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tvOBv-0007kq-OP; Thu, 20 Mar 2025 23:16:43 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tvOBq-001YeG-Fv; Thu, 20 Mar 2025 23:16:38 +0100
Message-ID: <d78bbd0c-5a56-4a5c-be84-567d98aa281e@rbox.co>
Date: Thu, 20 Mar 2025 23:16:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>
 <Z9yAnhMsupaaVCII@pop-os.localdomain>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <Z9yAnhMsupaaVCII@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 21:54, Cong Wang wrote:
> On Thu, Mar 20, 2025 at 01:05:27PM +0100, Michal Luczaj wrote:
>> On 3/19/25 23:18, Cong Wang wrote:
>>> On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
>>>> Signal delivery during connect() may lead to a disconnect of an already
>>>> established socket. That involves removing socket from any sockmap and
>>>> resetting state to SS_UNCONNECTED. While it correctly restores socket's
>>>> proto, a call to vsock_bpf_recvmsg() might have been already under way in
>>>> another thread. If the connect()ing thread reassigns the vsock transport to
>>>> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
>>>>
>>
>>    *THREAD 1*                      *THREAD 2*
>>
>>>> connect
>>>>   / state = SS_CONNECTED /
>>>>                                 sock_map_update_elem
>>>>                                 vsock_bpf_recvmsg
>>>>                                   psock = sk_psock_get()
>>>>   lock sk
>>>>   if signal_pending
>>>>     unhash
>>>>       sock_map_remove_links
>>>
>>> So vsock's ->recvmsg() should be restored after this, right? Then how is
>>> vsock_bpf_recvmsg() called afterward?
>>
>> I'm not sure I understand the question, so I've added a header above: those
>> are 2 parallel flows of execution. vsock_bpf_recvmsg() wasn't called
>> afterwards. It was called before sock_map_remove_links(). Note that at the
>> time of sock_map_remove_links() (in T1), vsock_bpf_recvmsg() is still
>> executing (in T2).
> 
> I thought the above vsock_bpf_recvmsg() on the right side completed
> before sock_map_remove_links(), sorry for the confusion.

No problem, I see why you've might. Perhaps deeper indentation would make
things clearer.

>>>>     state = SS_UNCONNECTED
>>>>   release sk
>>>>
>>>> connect
>>>>   transport = NULL
>>>>                                   lock sk
>>>>                                   WARN_ON_ONCE(!vsk->transport)
>>>>
>>>
>>> And I am wondering why we need to WARN here since we can handle this error
>>> case correctly?
>>
>> The WARN and transport check are here for defensive measures, and to state
>> a contract.
>>
>> But I think I get your point. If we accept for a fact of life that BPF code
>> should be able to handle transport disappearing - then WARN can be removed
>> (while keeping the check) and this patch can be dropped.
> 
> I am thinking whether we have more elegant way to handle this case,
> WARN looks not pretty.

Since the case should never happen, I like to think of WARN as a deliberate
eyesore :)

>> My aim, instead, was to keep things consistent. By which I mean sticking to
>> the conditions expressed in vsock_bpf_update_proto() as invariants; so that
>> vsock with a psock is guaranteed to have transport assigned.
> 
> Other than the WARN, I am also concerned about locking vsock_bpf_recvmsg()
> because for example UDP is (almost) lockless, so enforcing the sock lock
> for all vsock types looks not flexible and may hurt performance.
>
> Maybe it is time to let vsock_bpf_rebuild_protos() build different hooks
> for different struct proto (as we did for TCP/UDP)?

By UDP you mean vsock SOCK_DGRAM? No need to worry. VMCI is the only
transport that features VSOCK_TRANSPORT_F_DGRAM, but it does not
implemented read_skb() callback, making it unsupported by BPF/sockmap.


