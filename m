Return-Path: <linux-kselftest+bounces-13144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D0926A5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 23:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD00B249EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E2191F8E;
	Wed,  3 Jul 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xSUE+Vpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AB4778E
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042492; cv=none; b=JCjMWqAASOJvVrTGpDC8jrQ7bnTzunuu2Muf6U0zOsmalzzzzVinB7gPF5R6vjmmk0aGqg8DshCmGlrYaTXRxDtQuA7INebn+gqzoXETA7mLC9Jn6aa3DIurugnlFYPqD2zUNr8RdWc2fxIeLjGhpj8RPNbriDWUanMJ3PEP0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042492; c=relaxed/simple;
	bh=o/eB9ad+QYBa9JFjz1mvMnoqm8Bn2jmLJca35JK67zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0NrefFgEZiaP8aSkvaomKeO9TXKei3UP6upVd39iNn6pTHLd1QMUCehGit0ik9ngrtqoEsbTyB7pZulTECTqzMLjFl4g/F8ef4jaJSO5CIal4vt/zkqB9EKDlCy1OMf0fCjk2rZf8mo2vHYqAHZyDrSxd30BrftOUou0p/R/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xSUE+Vpb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720042487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAmao8TUiGzEBUxl0uM2ab6QR3/2VoC1vCaH2XHCX/M=;
	b=xSUE+VpbIZ6UVM5ZDS92MZAEOXxO+b5eWd3wQkL7Nz7IEGw030nVCbhbNPa1n3NwXS3haL
	q82hjiqgTkz/LUtQZ1vqxlv7CyYACpisDCECg+suK9owd+23MT/GPdOUIbZhw1u9JpuF3f
	xONu6VwzBfqbVQIVzdRJ3ZdPqX1EkHM=
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
Message-ID: <5b9f6be0-96f3-4471-9852-cf87c4845f7a@linux.dev>
Date: Wed, 3 Jul 2024 14:34:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/9] selftests/bpf: Add backlog for
 network_helper_opts
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
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
 <7ee521c76e45a536da7940c19a4d8de235e63e78.1719623708.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7ee521c76e45a536da7940c19a4d8de235e63e78.1719623708.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/28/24 6:20 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Some callers expect __start_server() helper to pass their own "backlog"
> value to listen() instead of the default of 1. So this patch adds struct
> member "backlog" for network_helper_opts to allow callers to set "backlog"
> value via start_server_str() helper.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 2 +-
>   tools/testing/selftests/bpf/network_helpers.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 44c2c8fa542a..16cbb3fdcabf 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
>   	}
>   
>   	if (type == SOCK_STREAM) {
> -		if (listen(fd, 1) < 0) {
> +		if (listen(fd, opts->backlog ? : 1) < 0) {


iirc, listen(fd, 0 /* backlog */) can be used to enforce syncookie. Meaning 
backlog 0 is a legit value.

Using 0 as a default and changing it to 1 here is fine. It makes the test 
program easier to write for the common case. Enforcing syncookie mode by using 
backlog 0 is a niche use case but it should at least have a way for the caller 
to do that.

May be using -ve backlog to do that, like

	if (listen(fd, opts->backlog ? max(opts->backlog, 0): 1) < 0)


>   			log_err("Failed to listed on socket");
>   			goto error_close;
>   		}
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 9ea36524b9db..8339c4e4b075 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -25,6 +25,7 @@ struct network_helper_opts {
>   	int timeout_ms;
>   	bool must_fail;
>   	int proto;
> +	int backlog;

and add a comment here to explain the meaning of the -ve backlog.

>   	int (*post_socket_cb)(int fd, void *opts);
>   	void *cb_opts;
>   };


