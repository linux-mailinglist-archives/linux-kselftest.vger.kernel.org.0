Return-Path: <linux-kselftest+bounces-9683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC78BF723
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F8D284F82
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A072E40C;
	Wed,  8 May 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMrBsgr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DE3B298;
	Wed,  8 May 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153789; cv=none; b=EGqcGGM/g8DueLiwaWqHOJoGDjg2bPRgPKoWpQ6uo1wDVyS0KksbrJTSLilG9JUUpqrGatnhOL2vEdIOfP25TuklN2VfXfD8HDhOdJUSosFO1IfAEhHxzN6eiIlR/Qn1pseCAr68LP66kTcUZkXBv214mQ/iEBuf+7lOjDXaa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153789; c=relaxed/simple;
	bh=uSc6/F8e+7rFoVsQ6llcJbirZ3srNGLSdVcX9PY6dFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nl7S56goMjkuyQxjZvgHqzbkNOacTbzjtZ7FK2UqQsIPWIawpKVqQG/p1XEi7RyAtyh7gVPf3LGgmcB1gEItNhFM1LLdLlPTTf4xs9qh++41W55EIDFrAyzAt8bIBoprQwzX6/g0dJaWbhGPv2q8Xa6s+UfxfynZO4fv7pPzWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMrBsgr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B71C4AF17;
	Wed,  8 May 2024 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715153789;
	bh=uSc6/F8e+7rFoVsQ6llcJbirZ3srNGLSdVcX9PY6dFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vMrBsgr5Ntv8vEb5Wf0oFCiz716SpRC1/cH+4HxjtkIgjPFEIAT43XIMOJiyFEV8r
	 5H3aIdkSo4cG1A5cHNsAzsntRKz5oaV4iZ7eD7oZsqbWz0Npd0LXE2iDgI8Kc/O71A
	 uGaMvrdpY48GXT9ITcCqJuv8BdiS0ZOJLUMnp5Bv6oI1zSQDEeT2dWiASpMknsfdkw
	 ZSgJ6AMgjRs18bCuHCg1cqauasvhGhEcFfHzZuxI92+qOUG3Tmn7Z0uQO8LNkZvmib
	 YApL6r57WmT3/skOS8opW6JZr8b6BOZMNMWYerEB/XEGaClFz0mNAnyI72JwssSeQv
	 N2GtCx40jfi/w==
Message-ID: <42d0718f-296d-48ca-a21a-b4708e9bd6e9@kernel.org>
Date: Wed, 8 May 2024 09:36:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
 <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com>
 <843ea6eb-a28d-437c-9c98-0b8c8816c518@kernel.org>
 <CAADnVQLA+2uoJJAJNFoK-EnUjLAwxJjxOXAizLWhcx4mf+C2Vg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQLA+2uoJJAJNFoK-EnUjLAwxJjxOXAizLWhcx4mf+C2Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for your reply!

On 07/05/2024 22:54, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 9:03 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Alexei,
>>
>> Thank you for the review!
>>
>> On 07/05/2024 16:49, Alexei Starovoitov wrote:
>>> On Tue, May 7, 2024 at 3:53 AM Matthieu Baerts (NGI0)
>>> <matttbe@kernel.org> wrote:
>>>>
>>>> From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>>>>
>>>> Move Nicolas's patch into bpf selftests directory. This example added a
>>>> test that was adding a different mark (SO_MARK) on each subflow, and
>>>> changing the TCP CC only on the first subflow.
>>>>
>>>> This example shows how it is possible to:
>>>>
>>>>     Identify the parent msk of an MPTCP subflow.
>>>>     Put different sockopt for each subflow of a same MPTCP connection.
>>>>
>>>> Here especially, we implemented two different behaviours:
>>>>
>>>>     A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
>>>>     MPTCP connection. The order of creation of the current subflow defines
>>>>     its mark.
>>>
>>>> The TCP CC algorithm of the very first subflow of an MPTCP
>>>>     connection is set to "reno".
>>>
>>> why?
>>> What does it test?
>>> That bpf_setsockopt() can actually do it?
>>
>> Correct.
>>
>> Here is a bit of context: from the userspace, an application can do a
>> setsockopt() on an MPTCP socket, and typically the same value will be
>> set on all subflows (paths). If someone wants to have different values
>> per subflow, the recommanded way is to use BPF.
>>
>> We can indeed restrict this test to changing the MARK only. I think the
>> CC has been modified just not to check one thing, but also to change
>> something at the TCP level, because it is managed differently on MPTCP
>> side -- but only when the userspace set something, or when new subflows
>> are created. The result of this operation is easy to check with 'ss',
>> and it was to show an exemple where this is set only on one subflow.
>>
>>> But the next patch doesn't check that it's reno.
>>
>> No, I think it is checked: 'reno' is not hardcoded, but 'skel->data->cc'
>> is used instead:
>>
>>   run_subflow(skel->data->cc);
>>
>>> It looks to me that dropping this "set to reno" part
>>> won't change the purpose of the rest of selftest.
>>
>> Yes, up to you. If you still think it is better without it, we can
>> remove the modification of the CC in patch 3/4, and the validation in
>> patch 4/4.
> 
> The concern with picking reno is extra deps to CI and every developer.
> Currently in selftests/bpf/config we do:
> CONFIG_TCP_CONG_DCTCP=y
> CONFIG_TCP_CONG_BBR=y
> 
> I'd like to avoid adding reno there as well.
> Will bpf_setsockopt("dctcp") work?

We picked Reno because this is an inlined kernel module that is always
built: there is no kernel config to set, no extra deps. Also, it is
usually not used as default, mostly used as fallback, so the
verification should not be an issue.

We can switch to DCTCP or BBR if you prefer, but I think it is "safer"
with Reno, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


