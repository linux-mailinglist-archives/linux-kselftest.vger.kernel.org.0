Return-Path: <linux-kselftest+bounces-15101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C794D914
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 01:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850E31C217A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7478E16CD3B;
	Fri,  9 Aug 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1cQpn/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE96169382
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245813; cv=none; b=lGZBK54vVnOQ2nsa+PRsNSXDZGDvs4KHMgVPvuKBezUw2a6larFDSpXDyNDI6inOZj9wBpyiBhctV6BStjzgKkPhrNmUyXDJB9Yhsu4QAhPyxIMNAku8HUqAEDiGA/5iCE9E6iVPAmDTIzG3G5vpxSNLjo79JgOeBQfiHoxP3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245813; c=relaxed/simple;
	bh=WL/HqGzpWDBGHE5OIgzlj+VDfF/DsCrnuxradylzqtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP0Qrc04jzw3qsYIC0KlU4HiQvrq0sSt/iiVNOKZQzw3Qa7ZuxLkTWt69ZlckXDLyXtOlQUDW1FLNiq3sC8b0QPtU8Kej/4+EkYhsQ4+gKh+FVT3iMdezlbN1YMhXuPNEeh00WkWOIw2RTMthsE9KsB9UL1lUy4zaQeEU2qIO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1cQpn/r; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1ca9d19-ccbb-48c2-b834-b9f53209f348@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723245809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzmEkEDjjjvHaZPgB6k9EknA7BVvJwusR9+hi+TKs0M=;
	b=n1cQpn/rkiPGV0hTSVeEt2XsjhJh6ML6p8abekPx2+V0Fqe59d7dgXPFBslUzKDpcVZ81Y
	sxj8V4BJffPpvFy9dK6/rrCiENYVcdQ0gOyKbjXhHEj+/0pSJ/HlevWdj+FFyZLQXypEQR
	9g/9sJZavHenzj4RuEQIvkoLj9IJHRo=
Date: Fri, 9 Aug 2024 16:23:16 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: convert
 get_current_cgroup_id_user to test_progs
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
 linux-kselftest@vger.kernel.org
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
 <20240806-convert_cgroup_tests-v2-1-180c57e5b710@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240806-convert_cgroup_tests-v2-1-180c57e5b710@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/24 12:55 AM, Alexis Lothoré (eBPF Foundation) wrote:
> +void test_cgroup_get_current_cgroup_id(void)
> +{
> +	struct get_cgroup_id_kern *skel;
> +	const struct timespec req = {
> +		.tv_sec = 0,
> +		.tv_nsec = 1,
> +	};
> +	int cgroup_fd;
> +	__u64 ucgid;
> +
> +	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);

missing close(cgroup_fd)

pw-bot: cr

> +	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
> +		return;
> +
> +	skel = get_cgroup_id_kern__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "load program"))
> +		goto cleanup_cgroup;
> +
> +	if (!ASSERT_OK(get_cgroup_id_kern__attach(skel), "attach bpf program"))
> +		goto cleanup_progs;
> +
> +	skel->bss->expected_pid = getpid();
> +	/* trigger the syscall on which is attached the tested prog */
> +	if (!ASSERT_OK(syscall(__NR_nanosleep, &req, NULL), "nanosleep"))
> +		goto cleanup_progs;
> +
> +	ucgid = get_cgroup_id(TEST_CGROUP);
> +
> +	ASSERT_EQ(skel->bss->cg_id, ucgid, "compare cgroup ids");
> +
> +cleanup_progs:
> +	get_cgroup_id_kern__destroy(skel);
> +cleanup_cgroup:
> +	cleanup_cgroup_environment();
> +}


