Return-Path: <linux-kselftest+bounces-18429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769EE987B65
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 00:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CE1283C63
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5321B012B;
	Thu, 26 Sep 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="XEdH2ijv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2C1B0125
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391285; cv=none; b=F997QT+52qwh6+KwhNjbBkWSKpBUalysoBy88Xzv7txYgnWJjXIkPkEFQObAu0IhcDiX6F1HDdxhXWJtyHQsMcBsMtVmsatGONf/e0bLGctmVqJRjbJR05uGurcPZuQLqrbjY8FhHtoYWxgR816ipsJj8KkOAAeH0Hk8qhwIe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391285; c=relaxed/simple;
	bh=kbf1Hx2X9g0pcS4tCElPoL2MRBJu6qAAlywYMNvf7FM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m/DkoTIAOuAq6v2asEqJIeueQoovJUFGpY/a3iQQLDRGl/YLx1DCxMKSlvYksk5yvKtNoTCPP0ZS6cVjURrd5/aJv20na+J29cs+gLJUPUNnQaptsHC6us2SSG/uwb2PNdm8/IUSWAKMKlp/zJyFNgksjA7D8hyQqMoSOgLdQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=XEdH2ijv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1stxNS-00982x-RV; Fri, 27 Sep 2024 00:54:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=gGA/yVdCAgObbnRJuDAOi7HXx6TBon3dkl4vpZ3i2Ug=; b=XEdH2ijv9mbK07E12Fu8xI8ebG
	ftG8UGjOFGpmfzw/hhy+zt4BnnPAcpF9svYZKlTZO3moG9LMrwcde3AEW5N0FxxwHBKAnGM1+XdlS
	uSQBA/jTwsm4/kchg7Ijlp91U7nzpiTYKPqzoKKSSMthi4qIVSb8nBv0Bwb61OQTnAij2Ag5EUpw0
	Q6rcUzccl2BmK3V2lwo3vEtnpNw0VsaZOOy8x56Bw+68tXWEaPBpXw7qZquWsmIVqVzlbhhRcqdPs
	Ynu4rtdHqqOc/YOYJVBHIibejnP7jbha738N1bczrdNy6wyACHszseNZ7vpHmoIAhnDbdU8xAEced
	u91RpQqg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1stxNM-00083Q-49; Fri, 27 Sep 2024 00:54:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1stxN8-00CsW5-KT; Fri, 27 Sep 2024 00:54:06 +0200
Message-ID: <0d4edea2-f989-484f-88bc-d8fb6acd7572@rbox.co>
Date: Fri, 27 Sep 2024 00:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
From: Michal Luczaj <mhal@rbox.co>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
 <877cccqnvj.fsf@cloudflare.com>
 <e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 12:25, Michal Luczaj wrote:
> On 8/19/24 22:05, Jakub Sitnicki wrote:
>> On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
>>> On 8/6/24 19:45, Jakub Sitnicki wrote:
>>>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>>>> Great, thanks for the review. With this completed, I guess we can unwind
>>>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>>>> wanted to take care of yourself or can I give it a try?
>>>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>>>>
>>>> I haven't stated any work on. You're welcome to tackle that.
>>>>
>>>> All I have is a toy test that I've used to generate the redirect matrix.
>>>> Perhaps it can serve as inspiration:
>>>>
>>>> https://github.com/jsitnicki/sockmap-redir-matrix
>>>
>>> All right, please let me know if this is more or less what you meant and
>>> I'll post the whole series for a review (+patch to purge sockmap_listen of
>>> redir tests, fix misnomers). [...]
>>
>> Gave it a look as promised. It makes sense to me as well to put these
>> tests in a new module. There will be some overlap with sockmap_listen,
>> which has diverged from its inital scope, but we can dedup that later.
>>
>> One thought that I had is that it could make sense to test the not
>> supported redirect combos (and expect an error). Sometimes folks make
>> changes and enable some parts of the API by accient.
> 
> All right, so I did what sockmap_listen does: check
> test_sockmap_listen.c:verdict_map[SK_PASS] to see if the redirect took
> place for a given combo. And that works well... except for skb/msg to
> ingress af_vsock. Even though this is unsupported and no redirect
> actually happens, verdict appears to be SK_PASS. Is this correct?

Here's a follow up: my guess is that some checks are missing. I'm not sure
if it's the best approach, but this fixes things for me:

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..c87295f3476d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2715,6 +2715,11 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
 	return sk->sk_family == AF_UNIX && sk->sk_type == SOCK_STREAM;
 }
 
+static inline bool sk_is_vsock(const struct sock *sk)
+{
+	return sk->sk_family == AF_VSOCK;
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 242c91a6e3d3..07d6aa4e39ef 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -647,6 +647,8 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
 	sk = __sock_map_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
+		return SK_DROP;
 
 	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
 	return SK_PASS;
@@ -675,6 +677,8 @@ BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
 		return SK_DROP;
 	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
 		return SK_DROP;
+	if (sk_is_vsock(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;
@@ -1249,6 +1253,8 @@ BPF_CALL_4(bpf_sk_redirect_hash, struct sk_buff *, skb,
 	sk = __sock_hash_lookup_elem(map, key);
 	if (unlikely(!sk || !sock_map_redirect_allowed(sk)))
 		return SK_DROP;
+	if ((flags & BPF_F_INGRESS) && sk_is_vsock(sk))
+		return SK_DROP;
 
 	skb_bpf_set_redir(skb, sk, flags & BPF_F_INGRESS);
 	return SK_PASS;
@@ -1277,6 +1283,8 @@ BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
 		return SK_DROP;
 	if (!(flags & BPF_F_INGRESS) && !sk_is_tcp(sk))
 		return SK_DROP;
+	if (sk_is_vsock(sk))
+		return SK_DROP;
 
 	msg->flags = flags;
 	msg->sk_redir = sk;


