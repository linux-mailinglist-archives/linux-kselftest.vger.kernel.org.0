Return-Path: <linux-kselftest+bounces-8288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DDC8A8FEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 02:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2083C28264F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86434382;
	Thu, 18 Apr 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWY3guh8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7F19A
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399588; cv=none; b=FOjDsmxiJjvqZ5IegDhxWNii84uj8Y5Abq/m3gmKJ/nNaIVnDFbE8zABICTBC3UrHYEOFZ9GkqoOuZKWMDzElQ/F62L7ZLgWc5Y4yJ41YTYerPekXRG7/6jUBbF79HrVCrW/HlpO1/RhAT0SQtcDb6kc5bQS4WI+Q53ldt+A8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399588; c=relaxed/simple;
	bh=xscj0G611Os4aNrRhrQks9sNkgFjR0tKghCAUCLYSPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CadendsVUtDhzyMS8yh+5Hg6BZLfxU8PSrA4Sdb2rdgArSaL+Nok0Cc4OwPDkXNXG/+tja7Sjd/7qx41qcTXfHByREaNoOauYz5RzzkU/CScvXZOSRKszi1ZmMlgBH+MI9rmYwxp/hlQDRBVPutJecXjxePezw3kCjIgXhNMBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWY3guh8; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <edbaf9f4-7ca9-43da-aeca-f605274461b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713399585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmld9TWh1qCxKykECnDSVg4zTGCQDK3LNOxoNl86g+s=;
	b=vWY3guh8Yjp9tHWLGfbX+Y1WJShHD8evJGICxpH/XvdZmtvUgunhqSSV8oOe2h7+8WzpmN
	IHzmpn60j69Hx4PSIYAFQC4gfiUkA7b2IGYUTvFL6EI+WT1vX/qi7YrMPjhbb1YNHS0uzT
	kiPmhYYui7z+adxuY73FxDN8lKW3XNY=
Date: Wed, 17 Apr 2024 17:19:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 09/14] selftests/bpf: Use log_err in
 network_helpers
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
 <efc8ea4e2c544f9959d7c265c80f4dac5e798c4a.1713262052.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <efc8ea4e2c544f9959d7c265c80f4dac5e798c4a.1713262052.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/16/24 3:13 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helpers ASSERT_OK/GE/OK_PTR should avoid using in public functions.
> This patch uses log_err() to replace them in network_helpers.c, then
> uses ASSERT_OK_PTR() to check the return values of all open_netns().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 19 ++++++++++++++-----
>   .../selftests/bpf/prog_tests/empty_skb.c      |  2 ++
>   .../bpf/prog_tests/ip_check_defrag.c          |  2 ++
>   .../selftests/bpf/prog_tests/tc_redirect.c    |  2 +-
>   .../selftests/bpf/prog_tests/test_tunnel.c    |  4 ++++
>   .../selftests/bpf/prog_tests/xdp_metadata.c   | 16 ++++++++++++++++
>   6 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 836436688ca6..4fd3ab4fa72c 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -458,22 +458,30 @@ struct nstoken *open_netns(const char *name)
>   	struct nstoken *token;
>   
>   	token = calloc(1, sizeof(struct nstoken));
> -	if (!ASSERT_OK_PTR(token, "malloc token"))
> +	if (!token) {
> +		log_err("Failed to malloc token");
>   		return NULL;
> +	}
>   
>   	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
> -	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
> +	if (token->orig_netns_fd <= 0) {

The test is incorrect. just test == -1.

Also, I think there is an existing bug that orig_netns_fd will be leaked in the 
later "goto fail;" case.

> +		log_err("Failed to open /proc/self/ns/net");
>   		goto fail;
> +	}
>   
>   	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
>   	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> -	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
> +	if (nsfd <= 0) {

Same here.

> +		log_err("Failed to open netns fd");
>   		goto fail;

I meant here regarding to the existing bug that leaks orig_netns_fd.



