Return-Path: <linux-kselftest+bounces-49149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E02D32698
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A22DF30954FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6729A33E;
	Fri, 16 Jan 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w8mhEmgH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70970287263;
	Fri, 16 Jan 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572646; cv=none; b=ZOexds6/RoiN3KtYlDDM2nsXPEcCvxnpGzJgyWtzQLvcJM2/t28ukZBUX6o4rhzozaAyw3E/MzJz+2Nr+6YgiJO5Nghrw38cU5Oe0BucrkQEHRgS4ag1uq+ZYAH0GW3pLcUHmFkLKP3sizKRWWSlc/nkE+MNdk3C22Wt51ZiBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572646; c=relaxed/simple;
	bh=+jgDwfGEgZ/gfdC0Vw6xWmOfG9Ku+O5C3mi5MoII2Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZMj28On5QplQTByCOBhqhuYMzh7R+Rv1C5dEIJLTgWechfGqQn0lDszvZsSFDAThPf0lRBh5UifJPibtSoSBceMZC1cW41EFzTYrU2y+q/XmAwzhNtjfg7v9SaroAlh7ClO8NWnzMASUy03aPkRlcoK3ORTjRhGFPqdUZZSDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w8mhEmgH; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36cf80a8-a224-4191-b235-50c2b3dd73f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768572632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LltPikOjfn91v4eQf5wN9GiDkEuZIGDG/ABublmrXDA=;
	b=w8mhEmgHxpePEGZgYwqycR5BSjb33zglHkzQuRAsu+5zMXMstSGTHQduak5A1ZSIqRYQXY
	o9x8dMApX3LtTYR7BWK/oeGQkMMJXJlPGMVkv8KG5CKuCfZBxEONIBfv/JLQGdz++mNDlO
	bpWCLY7R0NEnSryu+da6E+wrKAi1XZk=
Date: Fri, 16 Jan 2026 22:10:12 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Add syscall common attributes
 support for prog_load
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260112145616.44195-1-leon.hwang@linux.dev>
 <20260112145616.44195-5-leon.hwang@linux.dev>
 <CAEf4BzZbcA2T8+OR1_68sxq9Chukmh8beyz+018O22U=SsafrA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZbcA2T8+OR1_68sxq9Chukmh8beyz+018O22U=SsafrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/16 08:54, Andrii Nakryiko wrote:
> On Mon, Jan 12, 2026 at 6:59 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> The log buffer of common attributes would be confusing with the one in
>> 'union bpf_attr' for BPF_PROG_LOAD.
>>
>> In order to clarify the usage of these two log buffers, they both can be
>> used for logging if:
>>
>> * They are same, including 'log_buf', 'log_level' and 'log_size'.
>> * One of them is missing, then another one will be used for logging.
>>
>> If they both have 'log_buf' but they are not same totally, return -EUSERS.
> 
> why use this special error code that we don't seem to use in BPF
> subsystem at all? What's wrong with -EINVAL. This shouldn't be an easy
> mistake to do, tbh.
> 

-EUSERS was suggested by Alexei.

However, I agree with you that it is better to use -EINVAL here.

>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf_verifier.h |  4 +++-
>>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>>  kernel/bpf/syscall.c         |  9 ++++++---
>>  3 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4c9632c40059..da2d37ca60e7 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -637,9 +637,11 @@ struct bpf_log_attr {
>>         u32 log_level;
>>         struct bpf_attrs *attrs;
>>         u32 offsetof_log_true_size;
>> +       struct bpf_attrs *attrs_common;
>>  };
>>
>> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs);
>> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs,
>> +                               struct bpf_attrs *attrs_common);
>>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_verifier_log *log);
>>
>>  #define BPF_MAX_SUBPROGS 256
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index 457b724c4176..eba60a13e244 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
>>  }
>>
>>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_attrs *attrs, u64 log_buf,
>> -                            u32 log_size, u32 log_level, int offsetof_log_true_size)
>> +                            u32 log_size, u32 log_level, int offsetof_log_true_size,
>> +                            struct bpf_attrs *attrs_common)
>>  {
>> +       const struct bpf_common_attr *common_attr = attrs_common ? attrs_common->attr : NULL;
>> +
> 
> There is something to be said about naming choices here :) it's easy
> to get lost in attrs_common being actually bpf_attrs, which contains
> attr field, which is actually of bpf_common_attr type... It's a bit
> disorienting. :)
> 

I see your point about the naming being confusing.

The original intent of 'struct bpf_attrs' was to provide a shared
wrapper for both 'union bpf_attr' and 'struct bpf_common_attr'. However,
I agree that using 'attrs_common' here makes the layering harder to follow.

If that approach is undesirable, how about introducing a dedicated
structure instead, e.g.:

struct bpf_common_attrs {
	const struct bpf_common_attr *attr;
	bpfptr_t uattr;
	u32 size;
};

This should make the ownership and intent clearer.

Thanks,
Leon

[...]


