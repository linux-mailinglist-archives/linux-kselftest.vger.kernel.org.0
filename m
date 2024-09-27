Return-Path: <linux-kselftest+bounces-18457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292D988122
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C422D283E54
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367961BA865;
	Fri, 27 Sep 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eL8JY6CE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8111BA28C
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428565; cv=none; b=mgdq/WpoMkSutk30kSWMAXx0V/4reaZuiZc0TMIgEbf0v6Das5utYUF52hWSGFHC7vNivWcgBspFMD3iSWheu5KbseKipjVHJnEqXJe9Yh5rWz57/aO/+sLk262oVNC4qCDFAFcaeukWXnzwPul0rnnIcnh+uIh4FaEc6mnWx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428565; c=relaxed/simple;
	bh=9LVM7U9qoJlT9Uhh1DQExS62mXazXMYih3BiV2Pb6gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GS4xsLsVHfyGkZvJ+iM4ddHeb3bcr9/jOFbVx1OkAAfnCc2FWa+fXnQUXBZotoIwSqam2kNI3P6ajiqdCACc5+TKI6U7Yv5Yavn38K+iwpeKmZ9oxmnawLDP/MCEXKaFBytIr272afxINEx0vYXvxmq78VAI0ra4VhIcaf9d4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eL8JY6CE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90349aa7e5so274923466b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727428562; x=1728033362; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMXB/acHnp63ulIQj4Mexrn6RJxHaMq1mectA7Dj3/0=;
        b=eL8JY6CEs0r+PsJzvlaNiIH12dBxzHh2yJ3XZYfjkW1P9E6SZPVdTTy9/SdzC5DTXX
         ZsUxxR4bekaqc5RPPiIouzI6Dlsd+zI/2XXGmuHE8rNulrep/XU7IQCtjtlwxo+trPsg
         ex9P0q8fZN13jnSDDkx5t+/hkmSXbLq7UERKlL6Ie85vB5dqUfu7I7389lUNmEsRtWQu
         Noh8v5MRNDUS5Yp456X4QCTJlF7cQ9Udr/BqODAhcWeL1A1cBGzXFji8d4WCdL0A9Czh
         uF60hHQrlCO0oQVjO0zBX+PkdyNnKjGB82IHexMxOpPuDUbxVHR5Hqa29d/RRiz709Ew
         5Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428562; x=1728033362;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMXB/acHnp63ulIQj4Mexrn6RJxHaMq1mectA7Dj3/0=;
        b=kgqIbtM4GQrf8l/RUUxpMNGmpaq1qR5cildhmL415DX/aJbD3Sr9IRVgx/uJBYNdts
         cwFb8OzPS1WhIPdWoISD66TGgsKxtGnt4T78Mdje4oHC4k49eLcbpM06KRJ7w07dZq2R
         CKaqOKvNMQ8v6viO6QZMRjSXE4DvRyjMRIp7TRRxuBqK8PSyMn4aW2ioJXv1fUYRuBH+
         4JYS9c5kr8CdQFmskER8BGsRrtKlORitiaeErJyQxTrf3txopOUQgR5waK814h1fNqts
         ABuDGsI/0ZxQAP36JCYAPICTWD9/admhH/vqUkuPzmh2ULkA40wYgX0yWyrdABWeKFA9
         ZsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUnMcK+auKRTlQJdIvW/mBgAI5VPpfV/es4SJ3/6VmdjRU276fTETP+c/94TpM0vP81m79C7uC0rOCqkc0a8g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTETf96M7N6UibPiv/DIDCX+bJJP2kG3tq6pSFi8F9w235uH5j
	wx06G2o3nhpLHn2j/MhCHcLAp5C8QF2GRRC+IfUIVNrNRzCEJRU10wLk3ceoq/k=
X-Google-Smtp-Source: AGHT+IH3O4+hKM0lE4zHGax913Dr+EWizpQPWKnOcfuA3BSxQ5PYgz+syrsbt0m6z7mRYNlXemozsw==
X-Received: by 2002:a17:906:4fc6:b0:a8d:6648:813f with SMTP id a640c23a62f3a-a93c48f14a8mr231865966b.3.1727428561539;
        Fri, 27 Sep 2024 02:16:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997d20sm106082766b.196.2024.09.27.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:15:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <0d4edea2-f989-484f-88bc-d8fb6acd7572@rbox.co> (Michal Luczaj's
	message of "Fri, 27 Sep 2024 00:54:04 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
	<87ttfxy28s.fsf@cloudflare.com>
	<42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
	<877cccqnvj.fsf@cloudflare.com>
	<e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
	<0d4edea2-f989-484f-88bc-d8fb6acd7572@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 27 Sep 2024 11:15:58 +0200
Message-ID: <87ikuh78z5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 27, 2024 at 12:54 AM +02, Michal Luczaj wrote:
> On 9/24/24 12:25, Michal Luczaj wrote:
>> On 8/19/24 22:05, Jakub Sitnicki wrote:
>>> On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
>>>> On 8/6/24 19:45, Jakub Sitnicki wrote:
>>>>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>>>>> Great, thanks for the review. With this completed, I guess we can unwind
>>>>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>>>>> wanted to take care of yourself or can I give it a try?
>>>>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>>>>>
>>>>> I haven't stated any work on. You're welcome to tackle that.
>>>>>
>>>>> All I have is a toy test that I've used to generate the redirect matrix.
>>>>> Perhaps it can serve as inspiration:
>>>>>
>>>>> https://github.com/jsitnicki/sockmap-redir-matrix
>>>>
>>>> All right, please let me know if this is more or less what you meant and
>>>> I'll post the whole series for a review (+patch to purge sockmap_listen of
>>>> redir tests, fix misnomers). [...]
>>>
>>> Gave it a look as promised. It makes sense to me as well to put these
>>> tests in a new module. There will be some overlap with sockmap_listen,
>>> which has diverged from its inital scope, but we can dedup that later.
>>>
>>> One thought that I had is that it could make sense to test the not
>>> supported redirect combos (and expect an error). Sometimes folks make
>>> changes and enable some parts of the API by accient.
>> 
>> All right, so I did what sockmap_listen does: check
>> test_sockmap_listen.c:verdict_map[SK_PASS] to see if the redirect took
>> place for a given combo. And that works well... except for skb/msg to
>> ingress af_vsock. Even though this is unsupported and no redirect
>> actually happens, verdict appears to be SK_PASS. Is this correct?
>
> Here's a follow up: my guess is that some checks are missing. I'm not sure
> if it's the best approach, but this fixes things for me:

So you have already found a bug with a negative test. Nice.

Your patch makes sense to me.


FYI, I've started a GH repo for anciallary materials for sockmap.
Code samples, pointers to resources, a backlog of stuff to do (?).
Inspired by the xdp-project repo:

  https://github.com/xdp-project/xdp-project

We can move it to a dedicated project namespace, right now it's at:

  https://github.com/jsitnicki/sockmap-project/

Feel free to add stuff there.

> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b..c87295f3476d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2715,6 +2715,11 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
>  	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
>  }
>  
> +static inline bool sk_is_vsock(const struct sock *sk)
> +{
> +	return sk->sk_family == AF_VSOCK;
> +}
> +
>  /**
>   * sk_eat_skb - Release a skb if it is no longer needed
>   * @sk: socket to eat this skb from
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 242c91a6e3d3..07d6aa4e39ef 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -647,6 +647,8 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
>  	sk = __sock_map_lookup_elem(map, key);
>  	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>  		return SK_DROP;
> +	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
> +		return SK_DROP;
>  
>  	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
>  	return SK_PASS;
> @@ -675,6 +677,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
>  		return SK_DROP;
>  	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>  		return SK_DROP;
> +	if (sk_is_vsock(sk))
> +		return SK_DROP;
>  
>  	msg->flags = flags;
>  	msg->sk_redir = sk;
> @@ -1249,6 +1253,8 @@ BPF_CALL_4(bpf_sk_redirect_hash, struct sk_buff *, skb,
>  	sk = __sock_hash_lookup_elem(map, key);
>  	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
>  		return SK_DROP;
> +	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
> +		return SK_DROP;
>  
>  	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
>  	return SK_PASS;
> @@ -1277,6 +1283,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
>  		return SK_DROP;
>  	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
>  		return SK_DROP;
> +	if (sk_is_vsock(sk))
> +		return SK_DROP;
>  
>  	msg->flags = flags;
>  	msg->sk_redir = sk;

