Return-Path: <linux-kselftest+bounces-13337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23792AADF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA233B2188E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C014A60E;
	Mon,  8 Jul 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i09MMIIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4FE748A
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472692; cv=none; b=K5VsmJCc/ddZFvE+g9jeqv8enQBF/wj6jAxz5JUB0x5YVXq7lkIbnCxdeWYp4jsAPLoye9oXc2cIaT4pY3DJK/jjvHXmP7DO5Muh6HgerEcwaLaIgMX0O6DlSE9hLxIxYchO9w2yENI5uj9Ba032rsfjb+U4g0JxcM4fMCgBWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472692; c=relaxed/simple;
	bh=48wGpzejvi0ufp6WOf11H9R4pEiImT2iXCUdnnpyuao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWVr58TEJ4qpDGbzPKefAXr/lY3furgc6pLZ7/lI8oNFUs3BSHLNAp2sxtveiHwH1VSNLjP/9xC1ntY53Oh8MJBYDWd+czCkOs+VVbx86yKmhNVlpVX/AMnWg9POhKQLr38SljlIhIpR7EKqkmy1tjg0zMptkZBWeWgMI0VfefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i09MMIIv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720472687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kOK7dGqYKjc7/S1oTeZheuaIiJQzpsTJbEdOn5pwPY=;
	b=i09MMIIvnDxwLs14CCqx5byy/4r7UzoYAj41+Ip+kY+JVsqVgZ7dAczmVrRlgAGx4hxfg+
	mvLQLWB8nn+81SQRRrQ/VcemVr2158zkiWVXQgJ5EFj7dtEnxiigHRoDeNWEQGOOsCcb8R
	Ij97ph0JDzqdaKFQsch3YzPPgbE/9N8=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <c575540f-fb92-4955-bae1-30c029f49bd7@linux.dev>
Date: Mon, 8 Jul 2024 14:04:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 07/12] selftests/bpf: Set expect_errno for
 cgroup_skb_sk_lookup
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
 <49c13acb05e74e13b1a20c8bbb89d26376ffbf11.1720405046.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <49c13acb05e74e13b1a20c8bbb89d26376ffbf11.1720405046.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/24 7:29 PM, Geliang Tang wrote:
> From: Geliang Tang<tanggeliang@kylinos.cn>
> 
> EINPROGRESS is skipped in run_lookup_test() in cgroup_skb_sk_lookup
> tests, but it is still showed in the log:
> 
>   ./test_progs -t cgroup_skb_sk_lookup -v
> 
>   run_cgroup_bpf_test:PASS:skel_open_load 0 nsec
>   run_cgroup_bpf_test:PASS:cgroup_join 0 nsec
>   run_cgroup_bpf_test:PASS:cgroup_attach 0 nsec
>   run_lookup_test:PASS:start_server 0 nsec
>   run_lookup_test:PASS:getsockname 0 nsec
>   (network_helpers.c:300: errno: Operation now in progress) Failed to \
>                                                  connect to server

This log is fine as-is and no need to "fix". The network_helpers failed in doing 
some socket operations and log this fact without treating it as a test_progs 
failure.

The individual test does expect this socket operation to fail, so test_progs 
does not report ":FAIL" for this test. CI is also smart enough and only shows 
the individual test's details log when that test ":FAIL" (i.e. the ASSERT_* failed).

>   run_lookup_test:PASS:connect_fd_to_fd 0 nsec
>   run_lookup_test:PASS:connect_to_fd 0 nsec
>   run_lookup_test:PASS:accept 0 nsec
>   #51      cgroup_skb_sk_lookup:OK
> 
> To fix this, set EINPROGRESS as "expect_errno" of network_helper_opts and
> pass it to connect_fd_to_fd(). Skip this expect_errno when must_fail is
> false too in connect_fd_to_addr().
> 
> connect_fd_to_fd() returns "0" when connect() fails but "expect_errno"
> matched. So "err" is "0" after invoking connect_fd_to_fd() in
> run_lookup_test(). "err = -errno" is needed to get the real error number
> before checking value of "err".


