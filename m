Return-Path: <linux-kselftest+bounces-13321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212292A6E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F551C217DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF01465B0;
	Mon,  8 Jul 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DyIcfXcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D71459E4;
	Mon,  8 Jul 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454981; cv=none; b=DfjwDKOJ8qTdVV9s9Lu7d9jNmIdxEONxrUxNsRygfHbWz6XNwq/c594yukGYvTtUYNvWnlF6JJybLRNAOQ5wwA7tOYYJV7GZe2EhJjoID064VArY0XKpecjUUDUJ76MwIi5CKLPFvmGf/oGn34DbPSHsMT9l/FflZ0qM29k3uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454981; c=relaxed/simple;
	bh=5UUMbZ9BMP2iZlMi/Ce9B3qTnQwj+5AK1mPDHSiO96g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JNUAZp5XuDghFQQ4uafM2vAuM093WRmJiRLLhOdoEro/nfZzI4bQFac22ZpSInV1aeSZaEfKaMh1MVY2ck0BKjsKOAecZBr+uybxvaKh+Wx7vkGKBF8QjMTtitFeDbgRw8+RkU9V045bJu4uo7YiHEIhr3266LoHgemWiKunAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DyIcfXcX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BYMw4PkO0c1841DWd8BfJBLvuDDuy0SgzlndAgQELBc=; b=DyIcfXcXFaK+CSjicpdiJBM0I1
	sG/qlVXkATYr7W0ltZFQK36hc9yJo5smDd1ZGigeeEFproHEDvS5SPQruvIu0ZRhyrrGFLAYXQqeX
	DjaYXVxt03XSjPgzQnYF17Vp1Vpn3U5sGv/Z6+CdOYwNR+j0eLWRZHGfS/KqQh972c5pFcMf/qv2a
	75vcrubeixHMbCQXbjxEzLkTWUebZIxcSufP2v/Cv/QnZll0OA4VvlKv0pY5jzQJZUZTt9UOxkl7k
	V0yA/bgsniVTwrjeWXhNx2dxX72X/s3BcPglyX6KiX8eJXnYSOsBxS5QoWfYCpHMyYcZWVS8TTRjs
	NX0rtHWQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQqvh-000GrA-Pb; Mon, 08 Jul 2024 18:09:29 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQqvg-000HJy-02;
	Mon, 08 Jul 2024 18:09:28 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Puranjay Mohan <puranjay@kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>,
 Florent Revest <revest@google.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
Date: Mon, 8 Jul 2024 18:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mb61ped836gn7.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

On 7/8/24 5:35 PM, Puranjay Mohan wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
> 
>> On 7/8/24 5:26 PM, KP Singh wrote:
>>> On Mon, Jul 8, 2024 at 5:00 PM Puranjay Mohan <puranjay@kernel.org> wrote:
>>>>
>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>
>>>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>>>>>> fexit_sleep test runs successfully now on the CI so remove it from the
>>>>>> deny list.
>>>>>
>>>>> Do you happen to know which commit fixed it? If yes, might be nice to have it
>>>>> documented in the commit message.
>>>>
>>>> Actually, I never saw this test failing on my local setup and yesterday
>>>> I tried running it on the CI where it passed as well. So, I assumed that
>>>> this would be fixed by some commit. I am not sure which exact commit
>>>> might have fixed this.
>>>>
>>>> Manu, Martin
>>>>
>>>> When this was added to the deny list was this failing every time and did
>>>> you have some reproducer for this. If there is a reproducer, I can try
>>>> fixing it but when ran normally this test never fails for me.
>>>
>>> I think this never worked until
>>> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.org/
>>> was merged, FTrace direct calls was blocking tracing programs on ARM,
>>> since then it has always worked.
>>
>> Awesome, thanks! I'll add this to the commit desc then when applying.
> 
> The commit that added this to the deny list said:
> 31f4f810d533 ("selftests/bpf: Add fexit_sleep to DENYLIST.aarch64")
> 
> ```
> It is reported that the fexit_sleep never returns in aarch64.
> The remaining tests cannot start.
> ```
> 
> So, if the lack of Ftrace direct calls would be the reason then the
> failure would be due to fexit programs not being supported on arm64.
> 
> But this says that the selftest never returns therefore is not related
> to ftrace direct call support but another bug?

Fwiw, at least it is passing in the BPF CI now.

https://github.com/kernel-patches/bpf/actions/runs/9841781347/job/27169610006

