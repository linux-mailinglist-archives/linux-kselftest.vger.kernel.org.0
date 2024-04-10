Return-Path: <linux-kselftest+bounces-7603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C88A022F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537BE1F21EAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC1184105;
	Wed, 10 Apr 2024 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f28vyqjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8E184103
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784873; cv=none; b=SC53HEtyY1ha+WXX0TylQ4UC/k/CijYMFrG6E95sd7ISZ/eA5ZYQ1mTh228+buhdQFYNz6GKvRfAvX1p0PmY61G8OwG+aXYW922pOnGaVmlCpLrGft+2d+dLhQG66S7CkKXbcyBWdav6bYVySQ9JVPrlYwSbyFCuEdDLwqQMP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784873; c=relaxed/simple;
	bh=nTCngW3nrSGVCIRXkroP1FsAaiPn/eIdCJe9G+XiqaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3o2abdfS26Ry5JjQe4OCf28iwpouzbLopf1nbcP8lSPcItr6yFHc9m9ViGyr5NaPvZZYNXgex08E0/S2d2F2ACQ/VDSwXDhKuaHOIoa1uxvFkEzbbcb9g6V8nznoW1zR7YuHG4G5b8vyrC7nqWK1iGcgnoFkzOe6IHeXhZBokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f28vyqjg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712784869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f1+MP+UF7zZldgEwkbI/nDmnr9/WctxU9HHYLrU4DTw=;
	b=f28vyqjgk/8ZEL4XlO/vbqXWHNSqr+FgStrOhkgnVuVUxWv30h4DJ9atohz53ijmY9/y1l
	fyOrQJVL6FUJ85qJvexdLQDj3pbZ8wOdzSC5X0qizOeTI0R4K+aBfo2DJi03DbIY4YrJN8
	FPXJYC2RbUakju5lL//5QuT8aP6dhYQ=
Date: Wed, 10 Apr 2024 14:34:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/9/24 11:13 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Some tests, such as the MPTCP bpf tests, require send_recv_data helper
> to run in nonblock mode.
> 
> This patch adds nonblock support for send_recv_data(). Check if it is
> currently in nonblock mode, and if so, ignore EWOULDBLOCK to continue
> sending and receiving.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 137cd18ef3f2..ca16ef2b648e 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -555,6 +555,7 @@ struct send_recv_arg {
>   static void *send_recv_server(void *arg)
>   {
>   	struct send_recv_arg *a = (struct send_recv_arg *)arg;
> +	int flags = fcntl(a->fd, F_GETFL);
>   	ssize_t nr_sent = 0, bytes = 0;
>   	char batch[1500];
>   	int err = 0, fd;
> @@ -578,6 +579,8 @@ static void *send_recv_server(void *arg)
>   		if (nr_sent == -1 && errno == EINTR)
>   			continue;
>   		if (nr_sent == -1) {
> +			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)

I still don't see why it needs to be a non blocking IO. mptcp should work
with blocking IO also, no? Does it really need non blocking IO to make
mptcp test work? I would rather stay with blocking IO in selftest as much as
possible for simplicity reason.

I am afraid the root cause of the EAGAIN thread has not been figured out yet:
https://lore.kernel.org/all/b3943f9a8bf595212b00e96ba850bf32893312cc.camel@kernel.org/

Lets drop patch 3 until it is understood why mptcp needs EAGAIN or non-blocking IO.
It feels like there is some flakiness and it should be understood and avoided.

Other than the comment in patch 2, the first two patches lgtm. Please respin with
the first two patches.

> +				continue;
>   			err = -errno;
>   			break;
>   		}
> @@ -599,6 +602,7 @@ static void *send_recv_server(void *arg)
>   
>   int send_recv_data(int lfd, int fd, uint32_t total_bytes)
>   {
> +	int flags = fcntl(lfd, F_GETFL);
>   	ssize_t nr_recv = 0, bytes = 0;
>   	struct send_recv_arg arg = {
>   		.fd	= lfd,
> @@ -622,8 +626,11 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
>   			       MIN(total_bytes - bytes, sizeof(batch)), 0);
>   		if (nr_recv == -1 && errno == EINTR)
>   			continue;
> -		if (nr_recv == -1)
> +		if (nr_recv == -1) {
> +			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
> +				continue;
>   			break;
> +		}
>   		bytes += nr_recv;
>   	}
>   


