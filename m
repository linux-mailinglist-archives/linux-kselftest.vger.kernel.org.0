Return-Path: <linux-kselftest+bounces-43844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EBBFF05C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 05:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBEC54F3B09
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BB2C11E5;
	Thu, 23 Oct 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5vDLq+m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52297296BDB
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761190403; cv=none; b=bwbfRpyl3lyDIdJQoiOZMouVkMKVSesWgbKQcV7hXCcZBHrPUYVuPu7KmXKYgnzSVyz+MqvGEwcrZ2z+Nrzox3AJDUr5yBHtRVGxfATtD5Fe+HVyx4ikp+LNNNB/kEoljhBD1vSHPeb9PDhglvXUtNdiZjMYoBZa5s0HCUwMvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761190403; c=relaxed/simple;
	bh=rjXOwxRtxkk2oHYZHUep1sjCXyXRMdvcsnOVmsOF83w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=UOcBGSK01V6GJ+sG6xV2WwpMO3JPm97Ao1+7QM5LCE7wmH+o5tMl2f7K72eHm5iC9rEOc9vc6R4tlgoeQ/PWfXVh9YL/6y5hbk9Dd98xkiWEoQr6P6eDrpfL4Dw6earSnWGHZ/vuysAyjMuVAU0PXUyjn0D8pKTyg+tw8kDxJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W5vDLq+m; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761190389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcpWG26LCI1Q1SU/KTO/Q6ZIE4Wpos0XpZBa+VH9Mfw=;
	b=W5vDLq+mvn4Cf2BjUpu6YoWmJ0uPnK8nqz1hDwbfbvp6+lHECubTqRR5SYPhlpj6FSSD1I
	xGaM0UhswEocZ7u9epOuUTZiA5YBB8GsRwEqsUGzNrlWUWQruVLYzwXab4ZDTdLz1M7koO
	lUTcGBtO1j7k97Y2xL3V6trBqDNoqS4=
Date: Thu, 23 Oct 2025 03:33:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Guard addr_space_cast code
 with __BPF_FEATURE_ADDR_SPACE_CAST
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
X-Migadu-Flow: FLOW_OUT

October 22, 2025 at 23:33, "Yonghong Song" <yonghong.song@linux.dev mailt=
o:yonghong.song@linux.dev?to=3D%22Yonghong%20Song%22%20%3Cyonghong.song%4=
0linux.dev%3E > wrote:


>=20
>=20On 10/22/25 12:18 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When compiling the BPF selftests with Clang versions that do not su=
pport

> If=C2=A0you are really using llvm18, then I found there are some other
> build failures as well, e.g.,
>=20

Yes=20i'm using llvm18

> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_common.h:=
47:15: error: conflicting types for 'bpf_arena_alloc_pages'
>  47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr=
, __u32 page_cnt,
>  | ^
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlin=
ux.h:160636:48: note: previous declaration is here
>  160636 | extern void __attribute__((address_space(1))) *bpf_arena_allo=
c_pages(void *p__map, void __attribute__((address_space(1))) *addr__ign, =
u32 page_cnt, int node_id, u64 flags) __weak __ksym;
>  | ^


I hadn't encountered this error before, but it started appearing after I =
upgraded LLVM to version 20.


$ make V=3D1

/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tool=
s/sbin/bpftool btf dump file /home/chenjiayuan/code/upstream/bpf-next/vml=
inux format c > /home/chenjiayuan/code/upstream/bpf-next/tools/testing/se=
lftests/bpf/tools/include/.vmlinux.h.tmp
cmp -s /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/b=
pf/tools/include/.vmlinux.h.tmp /home/chenjiayuan/code/upstream/bpf-next/=
tools/testing/selftests/bpf/tools/include/vmlinux.h || mv /home/chenjiayu=
an/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/.vmli=
nux.h.tmp /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftest=
s/bpf/tools/include/vmlinux.h
clang  -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/chenj=
iayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include -=
I/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf -I/=
home/chenjiayuan/code/upstream/bpf-next/tools/include/uapi -I/home/chenji=
ayuan/code/upstream/bpf-next/tools/testing/selftests/usr/include -std=3Dg=
nu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -idirafter =
/usr/lib/llvm-20/lib/clang/20/include -idirafter /usr/local/include -idir=
after /usr/include/x86_64-linux-gnu -idirafter /usr/include    -DENABLE_A=
TOMICS_TESTS   -O2 --target=3Dbpfel -c progs/stream.c -mcpu=3Dv3 -o /home=
/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/stream.bp=
f.o
In file included from progs/stream.c:8:
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_=
arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages=
'
   47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr=
, __u32 page_cnt,
      |               ^
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tool=
s/include/vmlinux.h:152158:14: note: previous declaration is here
 152158 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr__ig=
n, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
        |              ^
In file included from progs/stream.c:8:
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_=
arena_common.h:49:5: error: conflicting types for 'bpf_arena_reserve_page=
s'
   49 | int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 =
page_cnt) __ksym __weak;
      |     ^
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tool=
s/include/vmlinux.h:152160:12: note: previous declaration is here
 152160 | extern int bpf_arena_reserve_pages(void *p__map, void *ptr__ign=
, u32 page_cnt) __weak __ksym;
        |            ^
In file included from progs/stream.c:8:
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/bpf_=
arena_common.h:50:6: error: conflicting types for 'bpf_arena_free_pages'
   50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 pag=
e_cnt) __ksym __weak;
      |      ^
/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tool=
s/include/vmlinux.h:152159:13: note: previous declaration is here
 152159 | extern void bpf_arena_free_pages(void *p__map, void *ptr__ign, =
u32 page_cnt) __weak __ksym;
        |             ^
3 errors generated.
make: *** [Makefile:761: /home/chenjiayuan/code/upstream/bpf-next/tools/t=
esting/selftests/bpf/stream.bpf.o] Error 1

$ clang --version
Ubuntu clang version 20.1.8 (++20250804090239+87f0227cb601-1~exp1~2025080=
4210352.139)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-20/bin

$ pahole --version
v1.29


I updated LLVM via https://apt.llvm.org/. Could this be caused by some bi=
naries or libraries still using LLVM 18?

