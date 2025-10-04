Return-Path: <linux-kselftest+bounces-42750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8270BB88C1
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 05:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76AE64E185A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207C221FCC;
	Sat,  4 Oct 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+6Lp6AJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0D1EB195
	for <linux-kselftest@vger.kernel.org>; Sat,  4 Oct 2025 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547337; cv=none; b=dMnCsETbfrbo73Brxi2VjO1EUZ09rCcPzQ3IX/C0TqzigqOrGgly5KIJvbo6cP/YmXKE2m3Yn+yd52EGjhofCIzQZrrecRu6BFmgyqsKcyNmASRxuj3cDpqbzmnjfMurU+5ggidRA65v3QZcOt7mqXGQn+uC0rhhwH2kCLw+AUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547337; c=relaxed/simple;
	bh=SA0GQY/BUXdQlPfp3N1GJWXZvhF2ZRNt7QOm5VUjtSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlZf5I2QP0pWjOAzZF6K7J8W2vnDH3z2HBkkwdSHdhlgNXLCwWaDufNE0BD++btFEMAurjSzhrQ1mDqIvZ5Q9mTm+lUPWZjgQAfHArpjMu0OxAAM1SrmdgSgCGQfaL2W9jYK5rnfCOQaEOEwI7Jw4terDlxEAXDtqwWC1Mpo6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+6Lp6AJ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43eebdf1-5ea9-4991-88c3-f0780d7c42c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759547331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn+pcM7PQPj2tE8YHaK7fwhWUvFKFy4bznwVXHweHVY=;
	b=Z+6Lp6AJQO+Zr74dHglZWtWNzr+SiYMEOYvM1NBytfEaRtdZk+9vh5xO6BrGJT7K+ripU8
	k2Lei0zV0flgdgHrgFezD7ItwSjz7jIC00eS0NcU1EWRQ8tQRnpXkLYn2bqAmhp0S2BwWg
	rFdNwQEBOODNFwRPFky0yyUYKz4b4Bo=
Date: Fri, 3 Oct 2025 20:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
To: Eduard Zingerman <eddyz87@gmail.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
 <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/3/25 4:37 PM, Eduard Zingerman wrote:
> On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
>> When trying to build the latest BPF selftests, with a debug kernel
>> config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:
>>
>>   progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>     579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
>>         |                ^
>>   progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
>>   .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_dynptr_size' declared here
>>    120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
>>           |              ^
>>   progs/dynptr_success.c:579:7: error: incompatible integer to pointer conversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-Wint-conversion]
>>     579 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
>>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_dynptr_slice'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>     596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
>>         |                ^
>>   progs/dynptr_success.c:596:7: error: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]
>>     596 |         data = bpf_dynptr_slice(&ptr, 0, NULL, 10);
>>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> I don't have these errors without the debug kernel config from
>> kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
>> is not declared in vmlinux.h. It is declared there without debug.config.
>>
>> The fix is similar to what is done in dynptr_fail.c which is also using
>> bpf_dynptr_slice(): bpf_kfuncs.h is now included.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
> 
> I can reproduce similar issue when including
> kernel/configs/debug.config with my regular dev config, but for
> different functions: bpf_rcu_read_{un,}lock().
> 
> However, this is not a way to fix this.
> Kfuncs are not supposed to just disappear from DWARF.
> 
> Running pahole in verbose mode I see the following output:
> 
>   $ pahole -V \
>       --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs \
>       --btf_features=attributes \
>       --lang_exclude=rust \
>       --btf_encode_detached=/dev/null vmlinux
>   ...
>   matched function 'bpf_rcu_read_lock' with 'bpf_rcu_read_lock.cold'
>   ...
> 
> Alan, Ihor, does this sound familiar?

This is most likely the issue addressed in this patch:
https://lore.kernel.org/dwarves/f7553b3f-5827-4f50-81a9-9bd0802734b9@linux.dev/

There wasn't a new pahole release with it yet.

