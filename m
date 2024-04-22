Return-Path: <linux-kselftest+bounces-8637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA148AD665
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9BB1C20E80
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B11C6B7;
	Mon, 22 Apr 2024 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USQ/LheI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1D1BC30
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820479; cv=none; b=kfClAM916Hnu+vPGqErSOA2IZXkixDN/Q9N+jw3E5h/ZkY9z8XlXqlB6DEz0xQDKOHmXhdRjUuZDX4x2DGkwWrAshS9BCNEYGyXPTXLoK60cHk3tM0xCTdP+z5k6mZNvaSy6avsaWS/IBNiTq9RlHI1I/zJgO61R8lpCnN3dwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820479; c=relaxed/simple;
	bh=cRWZVwE66IktVunkaU/Js89Orpl0ItQMJLYsLnFC5EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg/6T0dBMTREGKjxvoMDaDPyf2SQGR5U7ncwZpgft498GcMrV7CUK+p/LXIJ7ve23IIe3f9mr/M24g9VbOXBbZQoVMLKMJ+nQAM4sIzKdo+CB42HJNHsanh5BX4TOVrYQ7uyawbl5ipf3XqNHvRaQPLtQLdA0dyjKBS8HNW6n40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USQ/LheI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713820476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id/YHTuxfiovFyVUV8xQXCNmiVtMWYMuhwFovv6HFqU=;
	b=USQ/LheIMQi2h389U2fetydS4vuPWvPxQCTPTXCiOGyzPogVxgMEdizJ9hUrrDENIDnX/p
	6QMONIa69osC/0d0S8Fwj3lpbSL/DrquhSwWkBoviUK0Ldoj9HRwgy2i5tIdxLHHRyupWx
	efcpyH4+CJUr69ZPnKjRGIM55vFzhfo=
Date: Mon, 22 Apr 2024 14:14:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
 <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev>
 <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/18/24 9:37 AM, Jordan Rife wrote:
>> The test_sock_addr.{c,sh} can be retired as long as all its tests are migrated
>> to sock_addr.c
> 
> test_sock_addr.c has a few more test dimensions than
> prog_tests/sock_addr.c currently does, so it covers a few more
> scenarios.
> 
> struct sock_addr_test {
>      const char *descr;
>      /* BPF prog properties */
>      load_fn loadfn;
>      enum bpf_attach_type expected_attach_type;
>      enum bpf_attach_type attach_type;
>      /* Socket properties */
>      int domain;
>      int type;
>      /* IP:port pairs for BPF prog to override */
>      const char *requested_ip;
>      unsigned short requested_port;
>      const char *expected_ip;
>      unsigned short expected_port;
>      const char *expected_src_ip;
>      /* Expected test result */
>      enum {
>          LOAD_REJECT,
>          ATTACH_REJECT,
>          ATTACH_OKAY,
>          SYSCALL_EPERM,
>          SYSCALL_ENOTSUPP,
>          SUCCESS,
>      } expected_result;
> };
> 
> We focus on the "happy path" scenarios currently in
> prog_tests/sock_addr.c while test_sock_addr.c has test cases that
> cover a range of scenarios where loading or attaching a BPF program
> should fail. There are also a few asm tests that use program loader
> functions like sendmsg4_rw_asm_prog_load which specifies a series of
> BPF instructions directly rather than loading one of the skeletons.
> Adding in these test dimensions and migrating the test cases is a
> slightly bigger lift for this patch series. Do we want to try to
> migrate all of these to prog_tests/sock_addr.c in order to fully
> retire it?

I don't want to keep this set hostage too much until everything is migrated from 
test_sock_addr.c. As long as for the tests you find useful in test_sock_addr.c 
in this patch set and moved them to prog_tests/sock_addr.c, it is heading in the 
right direction. For the moved test, please remove them from test_sock_addr.c so 
that it is clear what else needs to be done.

[ Side note for future migration attempt, at least for the LOAD_REJECT one, it 
probably makes sense to write it like progs/verifier_*.c ]


