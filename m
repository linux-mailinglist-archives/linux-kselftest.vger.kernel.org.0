Return-Path: <linux-kselftest+bounces-13394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1192C2C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659591F26CE1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BE17B050;
	Tue,  9 Jul 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lnFuvy6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71115B116;
	Tue,  9 Jul 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547103; cv=none; b=ONtKzA+x3yHqlytlwAEDvCIRnrn/e8COO3TzlHqLqKtzG04Cqo2VH3H2A01RA9vO9fJHiIM6DcXDP1PlxVxer53eRjSGEKlO7+vz+vIypShQKARcSpStiKzWpMA/7U078qd/E8l8O6h49qI3Nn2R+yJzD1QJuXBAMh9sn74Hz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547103; c=relaxed/simple;
	bh=uW2pwfCD2YttDafcEflC65MfG5HeMeAMEQ9t4zeoL9I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fNRwlzJyCOJpbVTvALojZdezYOBkXN+7VUSUQo1ssfnirYPw0CqqME8N25DFoJohpOxlOwbpTnCCp/+nEDsMHRw+BpQ2CDfY8AULYiSxABXqAQ3GW8AUQrYX/21jGDT8xhXtsDlkDzg4A5+VZ023A/rkV1SgceF51HrmSM7iGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lnFuvy6e; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XpJVqSkqCMHi4vFYbD1YivXt6e6jHPNXwLAFd99ctoM=; b=lnFuvy6eh/8y4YIp8Auv5i2jaq
	/qYPfypDxkTsOGeqDGbIYIn+mjD4n309whiAQ5575bRIk7tsSM9fimg52wvX0nbbiLKev/6rd34bM
	4YN5TISe16+i+QDbocnmXcSdC3dPFqXwjek2FWo0HdIpSNGO2xa5X+d5mWQ4l5xySGynctHdvjSFR
	QmbYFUUQ5u5LJkTEI6DWT3eI+17D9FslQun5k/JSbG2x031USQTkQgmswcb1h8/UhG5+krNXINB+r
	1CS0gUj5b9WF9GJKSWQSEdh0TWoqGdOchbz3AEJ1C1S8is+dVeNzs4R7iQm77qozJ/8fMwwFsWFnH
	ra3U89AQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sREtL-000Do5-Bz; Tue, 09 Jul 2024 19:44:39 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sREtK-000H95-0B;
	Tue, 09 Jul 2024 19:44:38 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: KP Singh <kpsingh@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
Date: Tue, 9 Jul 2024 19:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27331/Tue Jul  9 10:38:11 2024)

On 7/8/24 6:42 PM, KP Singh wrote:
> On Mon, Jul 8, 2024 at 6:09 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 7/8/24 5:35 PM, Puranjay Mohan wrote:
>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>> On 7/8/24 5:26 PM, KP Singh wrote:
>>>>> On Mon, Jul 8, 2024 at 5:00 PM Puranjay Mohan <puranjay@kernel.org> wrote:
>>>>>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>>>>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>>>>>>>> fexit_sleep test runs successfully now on the CI so remove it from the
>>>>>>>> deny list.
>>>>>>>
>>>>>>> Do you happen to know which commit fixed it? If yes, might be nice to have it
>>>>>>> documented in the commit message.
>>>>>>
>>>>>> Actually, I never saw this test failing on my local setup and yesterday
>>>>>> I tried running it on the CI where it passed as well. So, I assumed that
>>>>>> this would be fixed by some commit. I am not sure which exact commit
>>>>>> might have fixed this.
>>>>>>
>>>>>> Manu, Martin
>>>>>>
>>>>>> When this was added to the deny list was this failing every time and did
>>>>>> you have some reproducer for this. If there is a reproducer, I can try
>>>>>> fixing it but when ran normally this test never fails for me.
>>>>>
>>>>> I think this never worked until
>>>>> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.org/
>>>>> was merged, FTrace direct calls was blocking tracing programs on ARM,
>>>>> since then it has always worked.
>>>>
>>>> Awesome, thanks! I'll add this to the commit desc then when applying.
>>>
>>> The commit that added this to the deny list said:
>>> 31f4f810d533 ("selftests/bpf: Add fexit_sleep to DENYLIST.aarch64")
>>>
>>> ```
>>> It is reported that the fexit_sleep never returns in aarch64.
>>> The remaining tests cannot start.
>>> ```
> 
> It may also have something to do with sleepable programs. But I think
> it's generally in the category of "BPF tracing was catching up with
> ARM", it has now.

Hm, the latest run actually hangs in fexit_sleep (which is the test right after
fexit_bpf2bpf). So looks like this was too early. It seems some CI runs pass on
arm64 but others fail:

   https://github.com/kernel-patches/bpf/actions/runs/9859826851/job/27224868398 (fail)
   https://github.com/kernel-patches/bpf/actions/runs/9859837213/job/27224955045 (pass)

Puranjay, do you have a chance to look into this again?

>>> So, if the lack of Ftrace direct calls would be the reason then the
>>> failure would be due to fexit programs not being supported on arm64.
>>>
>>> But this says that the selftest never returns therefore is not related
>>> to ftrace direct call support but another bug?
>>
>> Fwiw, at least it is passing in the BPF CI now.
>>
>> https://github.com/kernel-patches/bpf/actions/runs/9841781347/job/27169610006


