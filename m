Return-Path: <linux-kselftest+bounces-48382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD0CFC300
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 07:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE58301DB94
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 06:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CE27587D;
	Wed,  7 Jan 2026 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RXxPw2q8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1117E792
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767767533; cv=none; b=VZ2UJyYNlLWEcOdgicUxmaGVNkZ5bClIQ5aew73ekr02rP+JB+D3CQddHCB9JXEqAX9AHPDwlXo+RjDkvdnns3iEU89qydUJtWhDobhG0RhCuSC5zpLGXoZcWtZYdG4GvBFRpp6Q26p6hprCVeLMk1VRjhfcAS2gJ9d2avjvnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767767533; c=relaxed/simple;
	bh=uGeMEPVRkSpC2V0Et/jcxXoOPjhyW6CgqXy2Of33Llo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1YhtP1xqbI3HqnESd3lUlIWC7KqRk+lLPkFbGDn/fgJTyVgJVE8AX8qnHO+vhHqvB7UrOlmasB1WFpE9dqWpmbz5Uyw61lASkoStbIlBUE2uN0p3md9JmDPZ3ZVM+OWk5uPAPiKnITyEjqoRZv62twhNiJ8q6AoxyNHZYao+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RXxPw2q8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a936f459-a7a1-431d-8ef8-cae5cf4d2196@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767767523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSuPmFTwU8SaKs0RPK0cyiAQml5VD95wZprmiScp9NI=;
	b=RXxPw2q85UPGYKCScgWbYZi1Hbvbk1vwLOaBqW8aO/60324qQrBvV7dFwVVpNEYywGSeuT
	eDbywsD7RSGWvXg3wjFrrpuY+GhjzaqKMwz0Cj7bc5Zz/4IwZpBsrL9x5K0/bCpM6g0CuY
	S4rc/dpAWi+1mX1tcz55XSSizoXh/94=
Date: Wed, 7 Jan 2026 14:31:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v4 7/9] bpf: Add common attr support for
 map_create
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 sforshee@kernel.org, yuichtsu@amazon.com, aalbersh@redhat.com,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260106172018.57757-8-leon.hwang@linux.dev>
 <db428e27fdf0110ea05cdadf8980c7758d7f4dcd61289293394db7e34ce99601@mail.kernel.org>
 <28ace50f-9ae6-46da-a05d-eab31f33f9cb@linux.dev>
 <CAADnVQJLifBhcpe5ci7FBB2uzTR5OXPji5RPq2NLSoVXpTfScg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJLifBhcpe5ci7FBB2uzTR5OXPji5RPq2NLSoVXpTfScg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/1/26 14:20, Alexei Starovoitov wrote:
> On Tue, Jan 6, 2026 at 9:57 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 7/1/26 01:44, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 14fc5738f2b9..e64cc7504731 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>
>>> [ ... ]
>>>
>>>> @@ -6279,7 +6345,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>>>>
>>>>      switch (cmd) {
>>>>      case BPF_MAP_CREATE:
>>>> -            err = map_create(&attr, uattr);
>>>> +            common_attrs.log_true_size = 0;
>>>> +            err = map_create(&attr, uattr, &common_attrs);
>>>> +            ret = copy_common_attr_log_true_size(uattr_common, size_common,
>>>> +                                                 &common_attrs.log_true_size);
>>>> +            err = ret ? ret : err;
>>>
>>> When map_create() succeeds, it returns a file descriptor that is already
>>> installed in the caller's fd table via bpf_map_new_fd(). If
>>> copy_common_attr_log_true_size() then fails (e.g., user provided a
>>> read-only buffer for uattr_common), the syscall returns -EFAULT but the
>>> fd remains installed.
>>>
>>> Could this leak the file descriptor? The user gets an error and has no
>>> way to know what fd number was allocated, so they cannot close it.
>>>
>>
>> Good catch — you’re right.
>>
>> If 'map_create()' succeeds and 'copy_common_attr_log_true_size()' later
>> fails (e.g. returning -EFAULT), the newly created file descriptor would
>> remain installed and could be leaked.
>>
>> I’ll fix this in the next revision by explicitly closing the fd when
>> ret is non-zero.
> 
> No. The refactoring was wrong. Don't make the kernel do extra work.
> Patch 3 introduced a bug and closing fd is not a solution.
> Such a pattern can be exploited for DoS.

You’re right — closing the fd after the fact is not the correct
solution, and introducing extra work in the kernel is undesirable. Doing
so could also open the door to DoS-style abuse.

The correct approach is to copy log_true_size into common_attrs
before allocating and installing the new fd, so that a failure in
copying cannot leave behind a partially created object.

I’ll rework this accordingly in the next revision.

Thanks,
Leon



