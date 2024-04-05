Return-Path: <linux-kselftest+bounces-7292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B084899EBF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A884B2183B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6748616D9B2;
	Fri,  5 Apr 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhNEvKlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6A16D309;
	Fri,  5 Apr 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325130; cv=none; b=RNriGSmXxxVTRpUFsHn20TS9YRruGAbcDO9vziinaddP+Et/qdCymV1w/m5H2d1PE2nwdtdcDXF/MI11njPEm0uOFQsHWGiVEQZbTbhcOmQURBcMxkv4fg3birF6DwEjDr32LqtHPLQPTV7unj3uFnR0P9vizM44H421PywlOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325130; c=relaxed/simple;
	bh=XqlrFMow+DfUuNoWXAqGHAP/Ea4CAhFI638WoT8N7pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3mfYfwN/xyI/nsr+MtnPkTOjOdk9hjtpT3GT+JnwGsfOE8fRuO/k8H25TJ0nv8cKwR6mJGxQjtmnTn/i4S0uhkU6fvMpVJKqfLUXRHp3dV2At76jehaoHrhvXXe+87lPFiW8trRaocaUBbui+2Bs+idxTs5KgCEfc6aqpwFYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhNEvKlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50964C433F1;
	Fri,  5 Apr 2024 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712325129;
	bh=XqlrFMow+DfUuNoWXAqGHAP/Ea4CAhFI638WoT8N7pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HhNEvKloXhrbkZjlX8IYjDuZJaFgymf8W5wsAn8acyNT8mCWNDlQnLej/XJRmGp6n
	 YobD5bq01JoXW1mYrEvPGDHu4OD+ZCOcJ+q12YXJXoZ7mIk9+IUHs2j97w5xttftb8
	 f/IVlx/IPLTD5U+FkWkRJjRgfoyxwqBnveoV7Wl5CiS4MCH2rosebxt/9aX9LqJ9JS
	 urYTLlErPoOutuNBI/lje/lo9lPtGPaXwAnbTqPQvbuT6onGFUYKOgwJtT/tZnWUam
	 0njrX9NWk+S9Ziy2dI4XDhZI3nMic/MZuGUuwXL5Xjb8zaP8CAbEgY7lTNXn0p4uqF
	 tE/pJETO9SvVg==
Message-ID: <39588f6b-b466-4a1a-bd30-729c5da37a22@kernel.org>
Date: Fri, 5 Apr 2024 15:52:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 1/2] mptcp: add last time fields in mptcp_info
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
 <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
 <CANn89i+2TMNF7chYaDFEBNRng3iLPaXBqXKNtZYevDd95-PqmQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89i+2TMNF7chYaDFEBNRng3iLPaXBqXKNtZYevDd95-PqmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for the review!

On 05/04/2024 15:29, Eric Dumazet wrote:
> On Fri, Apr 5, 2024 at 3:06 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds "last time" fields last_data_sent, last_data_recv and
>> last_ack_recv in struct mptcp_sock to record the last time data_sent,
>> data_recv and ack_recv happened. They all are initialized as
>> tcp_jiffies32 in __mptcp_init_sock(), and updated as tcp_jiffies32 too
>> when data is sent in __subflow_push_pending(), data is received in
>> __mptcp_move_skbs_from_subflow(), and ack is received in ack_update_msk().
>>
>> Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
>> exposed with TCP, this patch exposes the last time "an action happened" for
>> MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
>> mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
>> deltas between now and the newly added last time fields in mptcp_sock.
>>
>> Also add three reserved bytes in struct mptcp_info not to have holes in
>> this structure exposed to userspace.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  include/uapi/linux/mptcp.h | 4 ++++
> 
> 
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 73fdf423de44..2ec2fdf9f4af 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -896,6 +896,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>  {
>>         struct sock *sk = (struct sock *)msk;
>> +       u32 now = tcp_jiffies32;
>>         u32 flags = 0;
>>         bool slow;
>>
>> @@ -930,6 +931,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>         info->mptcpi_snd_una = msk->snd_una;
>>         info->mptcpi_rcv_nxt = msk->ack_seq;
>>         info->mptcpi_bytes_acked = msk->bytes_acked;
>> +       info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
>>         mptcp_data_unlock(sk);
>>
>>         slow = lock_sock_fast(sk);
> 
>  lock_sock_fast(sk) can sleep and be quite slow...
> 
> I suggest you reload now = jiffies32;

Good point, it would make more sense to reload it after this lock!

(or defining "now" only here, under this lock_sock_fast(), and move the
block here above that is under the data spin lock, after, so all the
"time" counter are "in sync"?)

pw-bot: changes-requested

> 
> 
>> @@ -942,6 +944,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>         info->mptcpi_bytes_retrans = msk->bytes_retrans;
>>         info->mptcpi_subflows_total = info->mptcpi_subflows +
>>                 __mptcp_has_initial_subflow(msk);
>> +       info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
>> +       info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
>>         unlock_sock_fast(sk, slow);
>>  }
>>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
>>
>> --
>> 2.43.0
>>
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


