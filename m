Return-Path: <linux-kselftest+bounces-43845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77BBFF068
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 05:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138643A778F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE129D27F;
	Thu, 23 Oct 2025 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dOCpIJxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1F20468D
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190989; cv=none; b=c/VVIkHaCJxN1dJP+LuANEUapyYTJELo6sBbeap4u+G+XwHnlu/yrGaoP1GD4WY8UP1EfLITgO9VxLDXXWfBddVsYLE37oca2ho5EKCTts7Jxu8AGf/1yCevJ5iEYE1yolq2TfVAPRarD2SK/SLOJe0nDSmyegmNpWQ11fV6fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190989; c=relaxed/simple;
	bh=056uXdqgwqieEClGZzofKTBO+ZAItkTj1Y/IlynwVNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9yp5J+V6ZJzZVSa8bAOay8L9dJaH9iM3xU4tmB1eu1+flSpsBW4Qb0jyVUeYaPs7iqLWJIhVhk+bnjFkDi8T3nomnpyBnajyYtG7hCIXzCvQ59pwtMsp67HpnlHZ5UhtYZGg/qVrP722C+U8fYuqbbUnLrAbkYZDWFO4wokrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dOCpIJxB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761190983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEEdoiySbKRfhgdihnabhC19qOOy3rtiDBHXYSkJ3YI=;
	b=dOCpIJxBMdnvIUuz8sWluoZcX+X3diKDhqv/8ORjgvDO6I+RdnZA0p4aufksxSdOYOJj5M
	XXKNQSk0Bq1TIeRPOmw1mv8g4/+rM/UG2gvJUItceqfhV6Ah0x4O8nIwO10NUHfmN2cBOP
	SS8kGyC2BCAAAGrHx3Lfr2ttul2Vkt8=
Date: Wed, 22 Oct 2025 20:42:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Guard addr_space_cast code
 with __BPF_FEATURE_ADDR_SPACE_CAST
Content-Language: en-GB
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Puranjay Mohan <puranjay@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
 <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/22/25 8:33 PM, Jiayuan Chen wrote:
> October 22, 2025 at 23:33, "Yonghong Song" <yonghong.song@linux.dev mailto:yonghong.song@linux.dev?to=%22Yonghong%20Song%22%20%3Cyonghong.song%40linux.dev%3E > wrote:
>
>
>> On 10/22/25 12:18 AM, Jiayuan Chen wrote:
>>
>>> When compiling the BPF selftests with Clang versions that do not support
>> If you are really using llvm18, then I found there are some other
>> build failures as well, e.g.,
>>
> Yes i'm using llvm18
>
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
>>   47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
>>   | ^
>> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:160636:48: note: previous declaration is here
>>   160636 | extern void __attribute__((address_space(1))) *bpf_arena_alloc_pages(void *p__map, void __attribute__((address_space(1))) *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
>>   | ^
>
> I hadn't encountered this error before, but it started appearing after I upgraded LLVM to version 20.
>
>
> $ make V=1
>
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool btf dump file /home/chenjiayuan/code/upstream/bpf-next/vmlinux format c > /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/.vmlinux.h.tmp
> cmp -s /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/.vmlinux.h.tmp /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h || mv /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/.vmlinux.h.tmp /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h
> clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf -I/home/chenjiayuan/code/upstream/bpf-next/tools/include/uapi -I/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/usr/include -std=gnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-20/lib/clang/20/include -idirafter /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include    -DENABLE_ATOMICS_TESTS   -O2 --target=bpfel -c progs/stream.c -mcpu=v3 -o /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/stream.bpf.o
> In file included from progs/stream.c:8:
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
>     47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
>        |               ^
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:152158:14: note: previous declaration is here
>   152158 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
>          |              ^
> In file included from progs/stream.c:8:
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:49:5: error: conflicting types for 'bpf_arena_reserve_pages'
>     49 | int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
>        |     ^
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:152160:12: note: previous declaration is here
>   152160 | extern int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt) __weak __ksym;
>          |            ^
> In file included from progs/stream.c:8:
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:50:6: error: conflicting types for 'bpf_arena_free_pages'
>     50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
>        |      ^
> /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:152159:13: note: previous declaration is here
>   152159 | extern void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt) __weak __ksym;
>          |             ^
> 3 errors generated.
> make: *** [Makefile:761: /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/stream.bpf.o] Error 1
>
> $ clang --version
> Ubuntu clang version 20.1.8 (++20250804090239+87f0227cb601-1~exp1~20250804210352.139)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-20/bin
>
> $ pahole --version
> v1.29

Please try pahole version 1.30.

>
>
> I updated LLVM via https://apt.llvm.org/. Could this be caused by some binaries or libraries still using LLVM 18?


