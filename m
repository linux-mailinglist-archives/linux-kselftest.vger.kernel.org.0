Return-Path: <linux-kselftest+bounces-9682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA78BF71E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EA284315
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 07:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB362BCE8;
	Wed,  8 May 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIU/PHy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF52BB03;
	Wed,  8 May 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153783; cv=none; b=aXof1I1Dz0SUxP8VANeXGAY8IkX5oF2Sj3ZEzHQA9nC//TFtPgtm4Vu7/IDNnEAgIfb8P6IF+iohtslPQe2CN8kGo7w1+DvUwBxd9KjP0Huh2SU5A59rNWRhivex2iXLYjwElM3bdAEZLg83w5RAJAnny7oqDtekxIOOx5I5KZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153783; c=relaxed/simple;
	bh=cHpeGbQQdZmrqFcIMijvSWhcpBQuIhaTwJ7sISwqIx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Btgt8Nv42F2yxeN+SFqEUdYJMulpN96clLWa46IaQMwgFocXs0aY26wj+0nm3uh7GpSPYsvjZfownxs1j+7Gbkvx5yYQNB9Hj+DB4vBKYTO3pNzbnT7jefKSiKz7Cr0yu11CHHyguxTV1YLqXncBRGXbvpuJRgQIrAhsJPr+JNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIU/PHy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74571C113CC;
	Wed,  8 May 2024 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715153782;
	bh=cHpeGbQQdZmrqFcIMijvSWhcpBQuIhaTwJ7sISwqIx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MIU/PHy7zVYLORjc8XaXaS0Y463ri+C1q86/07kB7nqQNhu2pSOs1koNQ0uZLedbv
	 LG1NUjWhzSAr/vWH2A23Q9o5kTH6VpGI8lKgCQv6uvdSXDFvc8qUfKMGbpqDvih9ar
	 D2eoLXfwtGpcln3ni2faYiusDAlQ6JgrRpSinZGPRuQVqYpmbxUmTAiFsoj1RaTz+H
	 b6xXI37fzFewQOX9brpqw86x8716amO9c2SAV6eSzki2pa6CDCHjWbJqJXypEozv7v
	 Cri6DAQ6t3RD1qVRhcBmc2rG5K1ivOvpBHazwSXXvOvWY+2xa1f87EQ6iXlH6jN7X1
	 UI+XNU279bzXQ==
Message-ID: <b7d28a78-63f0-4531-b14f-2ad79454b2cd@kernel.org>
Date: Wed, 8 May 2024 09:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
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
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
 <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
 <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
 <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for your reply!

On 07/05/2024 22:51, Alexei Starovoitov wrote:
> On Tue, May 7, 2024 at 9:02 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Alexei,
>>
>> Thank you for the review!
>>
>> On 07/05/2024 16:44, Alexei Starovoitov wrote:
>>> On Tue, May 7, 2024 at 3:53 AM Matthieu Baerts (NGI0)
>>> <matttbe@kernel.org> wrote:
>>>>
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
>>>> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
>>>> simpolify the code.
>>>>
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> index baf976a7a1dd..9d1b255bb654 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
>>>>         close(cgroup_fd);
>>>>  }
>>>>
>>>> +#define RUN_MPTCP_TEST(suffix)                                 \
>>>> +do {                                                           \
>>>> +       if (test__start_subtest(#suffix))                       \
>>>> +               test_##suffix();                                \
>>>> +} while (0)
>>>
>>> Please no.
>>> Don't hide it behind macros.
>>
>> I understand, I'm personally not a big fan of hiding code being a macro
>> too. This one saves only one line. Geliang added a few more tests in our
>> tree [1], for a total of 9, so that's only saving 9 lines.
>>
>> Related to that, if you don't mind, Geliang also added another macro --
>> MPTCP_SCHED_TEST -- for tests that are currently only in our tree [2]
>> (not ready yet). We asked him to reduce the size of this macro to the
>> minimum. We accepted it because it removed quite a lot of similar code
>> with very small differences [3]. Do you think we should revert this
>> modification too?
> 
> Yeah. Pls don't hide such things in macros.
> Refactor into helper function in normal C.

Sure, we will revert that.

> But, what do you mean "in your tree" ?
> That's your development tree and you plan to send all that
> properly as patches to bpf-next someday?

Yes, correct, we have some WIP patches in MPTCP development tree where
we added a new bpf_struct_ops structure to implement new MPTCP packet
schedulers in BPF. This work was paused for a while because we had to
refine the packet scheduler API, but this task is now ongoing. Hopefully
we will be able to send patches to bpf-next this "soon".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


