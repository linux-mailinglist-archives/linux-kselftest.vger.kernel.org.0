Return-Path: <linux-kselftest+bounces-43850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD3BFFB0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581F04F5082
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661FA2DAFDE;
	Thu, 23 Oct 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L+YyG4hO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFD2DC344
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205805; cv=none; b=SVhg4+7tIfKF5qHLpBbKTLz2MdjkyjjrVEgy/cXxBgo56P6SAMCdZB0IgGr3a1MXvrcS6gDyqZX+8ErIcXRAePLl6cggrQ9gB/SWaVPSzYINlUNOVNUCSbCRl7bGDjB9dipAGXZuK+KFpE1ur1aIpypkOjjL7ORJmagmAXtZzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205805; c=relaxed/simple;
	bh=bE9DUULRUYQBlQg9VZE7ioXLtTLw+Uog0xQNXv5k1sM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=n48pip8MUYoLD5kbcOGKLEZW+pU8+v5v3Kw4z+0S59LSPBrM+OaWAAf4J7fqD10FXHSvK04wlp+B0O8J+01KZksimJge6UbpTPRHKlI80sGJpJBujBKk1NkU2tQ5PBhBAg9H9yqDxz+OP1bnBDbXnVx1K6hya2qaEyta387twhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L+YyG4hO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761205790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vd+5huyqIQSpq/F65arGSoTaP04RVAJffOfxOov/K3k=;
	b=L+YyG4hOJhDKQtn8sYeccPOpwpkB2Ngem/oETqNQvZhUnLhxYBVxvE6JwqACJjZlqGkP3u
	1+DJxQwOvfTYJyT5x5qPL4uOguRdzm+zygddYMhAiTVCEACK2Xm/C+XZi7xzltwRh9E0ZJ
	VXl2f304JdRx7QmIdZm/BqvBQXEV2WI=
Date: Thu, 23 Oct 2025 07:49:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e@linux.dev>
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
In-Reply-To: <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev>
References: <20251022071825.238909-1-jiayuan.chen@linux.dev>
 <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
 <0643875cea56f4e4fd78c7e9222b24e269136155@linux.dev>
 <84906f32-955d-4fda-b87d-56c052ddfd87@linux.dev>
X-Migadu-Flow: FLOW_OUT

October 23, 2025 at 11:42, "Yonghong Song" <yonghong.song@linux.dev mailt=
o:yonghong.song@linux.dev?to=3D%22Yonghong%20Song%22%20%3Cyonghong.song%4=
0linux.dev%3E > wrote:


>=20
>=20On 10/22/25 8:33 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> October 22, 2025 at 23:33, "Yonghong Song" <yonghong.song@linux.dev=
 mailto:yonghong.song@linux.dev?to=3D%22Yonghong%20Song%22%20%3Cyonghong.=
song%40linux.dev%3E > wrote:
> >=20
>=20> >=20
>=20> > On 10/22/25 12:18 AM, Jiayuan Chen wrote:
> > >=20
>=20>  When compiling the BPF selftests with Clang versions that do not s=
upport
> >=20
>=20> >=20
>=20> > If=C2=A0you are really using llvm18, then I found there are some =
other
> > >  build failures as well, e.g.,
> > >=20
>=20>  Yes i'm using llvm18
> >=20
>=20> >=20
>=20> > /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_arena_com=
mon.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
> > >  47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *=
addr, __u32 page_cnt,
> > >  | ^
> > >  /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/=
vmlinux.h:160636:48: note: previous declaration is here
> > >  160636 | extern void __attribute__((address_space(1))) *bpf_arena_=
alloc_pages(void *p__map, void __attribute__((address_space(1))) *addr__i=
gn, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> > >  | ^
> > >=20
>=20>  I hadn't encountered this error before, but it started appearing a=
fter I upgraded LLVM to version 20.
> >=20
>=20>  $ make V=3D1
> >=20
>=20>  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/b=
pf/tools/sbin/bpftool btf dump file /home/chenjiayuan/code/upstream/bpf-n=
ext/vmlinux format c > /home/chenjiayuan/code/upstream/bpf-next/tools/tes=
ting/selftests/bpf/tools/include/.vmlinux.h.tmp
> >  cmp -s /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selfte=
sts/bpf/tools/include/.vmlinux.h.tmp /home/chenjiayuan/code/upstream/bpf-=
next/tools/testing/selftests/bpf/tools/include/vmlinux.h || mv /home/chen=
jiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/include/=
.vmlinux.h.tmp /home/chenjiayuan/code/upstream/bpf-next/tools/testing/sel=
ftests/bpf/tools/include/vmlinux.h
> >  clang -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian -I/home/c=
henjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/tools/inclu=
de -I/home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
 -I/home/chenjiayuan/code/upstream/bpf-next/tools/include/uapi -I/home/ch=
enjiayuan/code/upstream/bpf-next/tools/testing/selftests/usr/include -std=
=3Dgnu11 -fno-strict-aliasing -Wno-compare-distinct-pointer-types -idiraf=
ter /usr/lib/llvm-20/lib/clang/20/include -idirafter /usr/local/include -=
idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include -DENABLE_=
ATOMICS_TESTS -O2 --target=3Dbpfel -c progs/stream.c -mcpu=3Dv3 -o /home/=
chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf/stream.bpf=
.o
> >  In file included from progs/stream.c:8:
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_=
pages'
> >  47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *ad=
dr, __u32 page_cnt,
> >  | ^
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/tools/include/vmlinux.h:152158:14: note: previous declaration is here
> >  152158 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr=
__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> >  | ^
> >  In file included from progs/stream.c:8:
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/bpf_arena_common.h:49:5: error: conflicting types for 'bpf_arena_reserve=
_pages'
> >  49 | int bpf_arena_reserve_pages(void *map, void __arena *addr, __u3=
2 page_cnt) __ksym __weak;
> >  | ^
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/tools/include/vmlinux.h:152160:12: note: previous declaration is here
> >  152160 | extern int bpf_arena_reserve_pages(void *p__map, void *ptr_=
_ign, u32 page_cnt) __weak __ksym;
> >  | ^
> >  In file included from progs/stream.c:8:
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/bpf_arena_common.h:50:6: error: conflicting types for 'bpf_arena_free_pa=
ges'
> >  50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 p=
age_cnt) __ksym __weak;
> >  | ^
> >  /home/chenjiayuan/code/upstream/bpf-next/tools/testing/selftests/bpf=
/tools/include/vmlinux.h:152159:13: note: previous declaration is here
> >  152159 | extern void bpf_arena_free_pages(void *p__map, void *ptr__i=
gn, u32 page_cnt) __weak __ksym;
> >  | ^
> >  3 errors generated.
> >  make: *** [Makefile:761: /home/chenjiayuan/code/upstream/bpf-next/to=
ols/testing/selftests/bpf/stream.bpf.o] Error 1
> >=20
>=20>  $ clang --version
> >  Ubuntu clang version 20.1.8 (++20250804090239+87f0227cb601-1~exp1~20=
250804210352.139)
> >  Target: x86_64-pc-linux-gnu
> >  Thread model: posix
> >  InstalledDir: /usr/lib/llvm-20/bin
> >=20
>=20>  $ pahole --version
> >  v1.29
> >=20
>=20Please try pahole version 1.30.
>=20
>=20>=20
>=20> I updated LLVM via https://apt.llvm.org/. Could this be caused by s=
ome binaries or libraries still using LLVM 18?
> >
>


thanks, but version 1.30 didn't work in my tests - even pahole's master b=
ranch fails, only the next branch works...


It seems that the 'old' pahole parses some kfuncs incorrectly, for exampl=
e bpf_dynptr_slice().


./tools/sbin/bpftool btf dump file ../../../../vmlinux | grep bpf_dynptr_=
slice -A 2
	'KF_bpf_dynptr_slice' val=3D23
	'KF_bpf_dynptr_slice_rdwr' val=3D24
	'KF_bpf_dynptr_clone' val=3D25
	'KF_bpf_percpu_obj_new_impl' val=3D26
--
[68242] FUNC 'bpf_dynptr_slice' type_id=3D68241 linkage=3Dstatic         =
     <- missing corresponding DECL_TAG ?
[68243] FUNC 'bpf_dynptr_slice_rdwr' type_id=3D68241 linkage=3Dstatic
[68244] DECL_TAG 'bpf_kfunc' type_id=3D68243 component_idx=3D-1
[68245] FUNC_PROTO '(anon)' ret_type_id=3D38 vlen=3D5

