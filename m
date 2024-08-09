Return-Path: <linux-kselftest+bounces-15103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB794D948
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B00B2245C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAC016D4FA;
	Fri,  9 Aug 2024 23:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ab6g/+yC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA4161328
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247373; cv=none; b=OOpRVFmYU3LSHvCbEH+ntcnsu8vQqFs3o67a4eS7QkxQV25ijq31CKKvZAlViYNFPDAKIVyfNXaZXNLIvBrvp6ZuZe9qBtkpmIhfnYAxczCHh7R1RH3NtyFKA4zpa9eUSw5otnryOiKodbc8WgzUFzu8B5FytN6bX9RTVjEhodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247373; c=relaxed/simple;
	bh=g1rCBxTQnBiRXXtVThAYP88nGw+rsQgIPLeDP6qNRus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmP/aM3OMMyu+wttREu1m83/wW2BraacfcSNW2BeJM3e/vFu9dgocFIrv912yUKV4liHOPcU7Gwq7lyBJuPcOYQa0g8nmD3rEyCxxLP9Aic/qtvv1jYYS7AniGllnyVqua9K5Z3E34VEkJwAI/09xuimeFBodf33HxSCU5CdDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ab6g/+yC; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f85ee226-122c-479f-a831-de5f986fb3c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723247368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPcuHL2v7l8p+f3+M7/L32h5WIKjLU9wPjEM5bv5Z/E=;
	b=Ab6g/+yCSxwlSqTNfmT+w0Hqyi4jQ4WVJPM2wH0OZ7t3BhsrH+O+3QCBYC23lFOIrAPOnr
	lJgsiD+PvGHcVyWxhMta76BOoQ5EWfeTRu9ygDlgi+DFWxCprafhc4j5oOEGUO54ei4mN4
	ymP/R/JXHAmMDsEgJZpN5g3P9wRHpSc=
Date: Fri, 9 Aug 2024 16:49:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: convert
 test_cgroup_storage to test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
 <20240806-convert_cgroup_tests-v2-2-180c57e5b710@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240806-convert_cgroup_tests-v2-2-180c57e5b710@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/24 12:55 AM, Alexis Lothoré (eBPF Foundation) wrote:
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "cgroup_storage.skel.h"
> +
> +#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
> +#define PING_CMD "ping localhost -c 1 -W 1 -q"
> +
> +void test_cgroup_storage(void)
> +{
> +	struct bpf_cgroup_storage_key key;
> +	struct cgroup_storage *skel;
> +	unsigned long long value;
> +	int cgroup_fd;
> +	int err;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);

Same. cgroup_fd is leaked.

> +	if (!ASSERT_OK_FD(cgroup_fd, "create cgroup"))
> +		return;
> +
> +	skel = cgroup_storage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	skel->links.bpf_prog =
> +		bpf_program__attach_cgroup(skel->progs.bpf_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.bpf_prog, "attach program"))
> +		goto cleanup_progs;
> +
> +	/* Check that one out of every two packets is dropped */
> +	err = SYS_NOFAIL(PING_CMD);

Better create a netns for network traffic test. It is pretty simple and there 
are existing examples to borrow, e.g. the setup_test_env() in 
prog_tests/sock_addr.c. The netns setup should be done after the 
cgroup_setup_and_join().


