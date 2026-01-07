Return-Path: <linux-kselftest+bounces-48380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32662CFC209
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 06:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D3E730090F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED88260580;
	Wed,  7 Jan 2026 05:57:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B126B95B
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765444; cv=none; b=gFZEcPNNUBLGLIgPEqDMp8k9GAU2sWD+zdrWvYK8ry2lWow9Pqq+LyWFh4Oim3EwknnUQmuP18fOPoAFovvN1FlxZJWGjex78Ta6ct+wkRAo6BZCkDN+PmkG6xxBprwG0V/dhRaF82MdJ2Gbx7PrqhLLPoLHPx/m1cMIgUtAk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765444; c=relaxed/simple;
	bh=zckY3JTsbhzorS2s16UH1LxAB7xdfcUPjIUmaASvJmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REzkQJVn34ibwSorrKGNEacrCYkNAOykIfyqJYP8vcwk2qBztnOAzLyVHg6A9XNEqAZuIudKVqEY/NnFvNVt+/K/1ZMTJZtuehR89H2YAMGoKlnX8EcCzxReySPZXXVdsJi7JPda+FKCxEd1sL76zUW/NQFxQaK0VZyMOCEdOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
Date: Wed, 7 Jan 2026 13:56:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for
 map_create
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 brauner@kernel.org, oleg@redhat.com, sforshee@kernel.org,
 yuichtsu@amazon.com, aalbersh@redhat.com, willemb@google.com,
 kerneljasonxing@gmail.com, paul.chaignon@gmail.com, yatsenko@meta.com,
 memxor@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 rongtao@cestc.cn, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260106172018.57757-8-leon.hwang@linux.dev>
 <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 14fc5738f2b9..e64cc7504731 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
>> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>
>>  	switch (cmd) {
>>  	case BPF_MAP_CREATE:
>> -		err = map_create(&attr, uattr);
>> +		common_attrs.log_true_size = 0;
>> +		err = map_create(&attr, uattr, &common_attrs);
>> +		ret = copy_common_attr_log_true_size(uattr_common, size_common,
>> +						     &common_attrs.log_true_size);
>> +		err = ret ? ret : err;
> 
> When map_create() succeeds, it returns a file descriptor that is already
> installed in the caller's fd table via bpf_map_new_fd(). If
> copy_common_attr_log_true_size() then fails (e.g., user provided a
> read-only buffer for uattr_common), the syscall returns -EFAULT but the
> fd remains installed.
> 
> Could this leak the file descriptor? The user gets an error and has no
> way to know what fd number was allocated, so they cannot close it.
> 

Good catch — you’re right.

If 'map_create()' succeeds and 'copy_common_attr_log_true_size()' later
fails (e.g. returning -EFAULT), the newly created file descriptor would
remain installed and could be leaked.

I’ll fix this in the next revision by explicitly closing the fd when
ret is non-zero.

Thanks,
Leon

> The sequence would be:
>   1. map_create() succeeds, returns fd (e.g., 5)
>   2. copy_common_attr_log_true_size() fails, ret = -EFAULT
>   3. err = ret ? ret : err = -EFAULT
>   4. syscall returns -EFAULT
>   5. map and fd persist, but user cannot close fd 5
> 
>> +		break;
>>  	case BPF_MAP_LOOKUP_ELEM:
>>  		err = map_lookup_elem(&attr);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20756616585


