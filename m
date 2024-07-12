Return-Path: <linux-kselftest+bounces-13683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63792FE5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B13E1F239EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D101175545;
	Fri, 12 Jul 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="m4vydiEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0816F8F5;
	Fri, 12 Jul 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801188; cv=none; b=Y31Z2uJmEpIskd4iAGZHhzSd5efb1W+ZIRhyGAT9DE7UJrcU3ozugTax6tuRbhuAFc9XDxytUsFUi3+Ih1qVUcjxkdF3HLxiMmMHzTdVWWSL8hGfrKjGrJDmUhGiRiuXJsNeUljE/4mSGWOgCFWBwffv3lLCmOPBxPGFPSqadEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801188; c=relaxed/simple;
	bh=spTcCUAvIKeRiZqhNrAtZXqPPUtuzdfi0TREE6gKYyA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F93M9vm1LqlM63Q07+S9RN7EdXaIWdo/eQFuqGFGOxTmTS5hMPTWmu77As3nI8UHs4uM3ekZuU4mDfpmV+07/hpi/f3AzSrqXn68/dv1f7afmAph8wQkR7uR8zyy9t8mYTUqR4Ky+BTn6DWTOJEOFYqCQwRgupZv5iPN+gEwK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=m4vydiEH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fnfBwcbL3Qe8863nzBkCMy1pP5U04LNp3AM575Iq/Ys=; b=m4vydiEHqcGM57I27dW0pq2LMN
	mJxl3/wDSZ/XwciUK9IeeSgA1RP463FcySbP6SYAG7luhN020GBbc4d0JwSsYNo5mqfINp6GzkE+n
	lfAsOeJNx10Bzyx8XiWeNCvO8j3gfTd5Zl6I2jfE2zj7G7A6m6RQD0sRuXpjAAl2wRzazslN79xUy
	e+af9LUvwEal2OezBb8vbcs92ukgFWewM9cpjPPI5mJwH/vEhHZbderWWjdfsKtPynH4bIUnLlEos
	x1bcEbAzvI2ipaSDjTusPu0RwantiAZpKE65HlONKqO9w4WtYCL6JFm9E+OkL22BxKMlVP3bDpeXk
	8nt+e7Aw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sSIzb-000KYz-6O; Fri, 12 Jul 2024 18:19:31 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sSIza-000C6s-0O;
	Fri, 12 Jul 2024 18:19:30 +0200
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Manu Bretelle <chantra@meta.com>,
 KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Florent Revest <revest@google.com>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org>
 <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
 <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
 <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net>
 <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org>
 <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
 <CAADnVQJXcGB69o1s5GcLYV=OYS+hmqxGJVvtDH3YrVQc1o_=Tg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e35b2a2b-aa5e-b107-1fb9-927e43e06d88@iogearbox.net>
Date: Fri, 12 Jul 2024 18:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJXcGB69o1s5GcLYV=OYS+hmqxGJVvtDH3YrVQc1o_=Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27334/Fri Jul 12 10:35:53 2024)

On 7/12/24 6:07 PM, Alexei Starovoitov wrote:
> On Fri, Jul 12, 2024 at 6:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 7/11/24 4:00 PM, Puranjay Mohan wrote:
>> [...]
>>> I was able find the root cause of this bug and will send a fix soon!
>>>
>>>> Unable to handle kernel paging request at virtual address ffff0000c2a80e68
>>>
>>> We are running this test on Qemu with '-cpu max', this means 52-bit
>>> virtual addresses are being used.
>>>
>>> The trampolines generation code has the following two lines:
>>>
>>>                emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
>>>                emit_call((const u64)__bpf_tramp_enter, ctx);
>>>
>>> here the address of struct bpf_tramp_image is moved to R0 and passed as
>>> an argument to __bpf_tramp_enter().
>>>
>>> emit_addr_mov_i64() assumes that the address passed to it is in the
>>> vmalloc space and uses at most 48 bits. It sets all the remaining bits
>>> to 1.
>>>
>>> but struct bpf_tramp_image is allocated using kzalloc() and when 52-bit
>>> VAs are used, its address is not guaranteed to be 48-bit, therefore we
>>> see this bug, where  0xfff[0]0000c2a80e68 is converted to
>>> 0xfff[f]0000c2a80e68 when the trampoline is generated.
>>>
>>> The fix would be use emit_a64_mov_i64() for moving this address into R0.
>>
>> It looks like there is still an issue left. A recent CI run on bpf-next is
>> still hitting the same on arm64:
>>
>> Base:
>>
>>     https://github.com/kernel-patches/bpf/commits/series/870746%3D%3Ebpf-next/
>>
>> CI:
>>
>>     https://github.com/kernel-patches/bpf/actions/runs/9905842936/job/27366435436
>>
>>     [...]
>>     #89/11   fexit_bpf2bpf/func_replace_global_func:OK
>>     #89/12   fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
>>     #89/13   fexit_bpf2bpf/func_replace_progmap:OK
>>     #89      fexit_bpf2bpf:OK
>>     Error: The operation was canceled.
> 
> Let's denylist that test again for now?

Agree, done/pushed now.

