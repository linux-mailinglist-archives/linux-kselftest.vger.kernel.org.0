Return-Path: <linux-kselftest+bounces-9175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CEE8B83C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 02:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A45284A6D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140B2114;
	Wed,  1 May 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSkTurmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32297492
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524051; cv=none; b=FOEx1WTXdNGPnL42usBfUF6EcQ8zy5QUylCaoMHpAXCXr7/+YM2ZN+OOt24+dtYr2rSaU61Qljmi/i5QlTCgB3xcUh9YLsh5JKwyGmwFPygrY5dN1UVaLzD0H40bjLUaaSfLdHjXzetbz9/ve0XFpOSrEi7j6Sl1c+6CxX1h8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524051; c=relaxed/simple;
	bh=DvRZn0YkYoGOFeC6Hd6FMkq8OBughIT3EN9z+cXbVyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx9mFQxKJEYGqiEKr9BxFdJATzh4jchj6l1V6Oilhre8+O7gvLYODQtpwRHxahQzMOebWQiua/qqKcslpwDZpci1jiEehNUHdCcxae7KT0fN0wwKTWE90X2GafzrMxk5R5igzoJQrTJYAKCRROcXNaQtjln89GnCtpetIqN3MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSkTurmd; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5148f33-cb4f-4e84-8182-b68a9c038d3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714524047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsLhW8OsAHNbWQn+96nTp6LroytLS+VC0zUDcZpqbG0=;
	b=GSkTurmd2UjQEf8zH5Jm26HqtN435YPprfcoop4FO2pBweiJXm4cG4n8k42YrVbg6L837W
	p4UxJjUS3JxYLqL60X4rC2EpMsT/fN1VyByowadgL/T+LTIkkwV8odHiQBbdlyYNqjc4SQ
	8sss4JPJy8l1mF57ynqNVD/kfEVOjzM=
Date: Tue, 30 Apr 2024 17:40:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Add setsockopt for
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
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
 <0f676d51126bf7c260a71cfb60df0d1acb23e552.1714014697.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0f676d51126bf7c260a71cfb60df0d1acb23e552.1714014697.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 8:23 PM, Geliang Tang wrote:
> +static int setsockopt_reuseport(int fd, const void *optval, socklen_t optlen)
> +{
> +	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, optval, optlen);
>   }
>   

[ ... ]

>   void free_fds(int *fds, unsigned int nr_close_fds)
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index c62b54daa914..540ecfc52bd7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -28,6 +28,9 @@ struct network_helper_opts {
>   	bool noconnect;
>   	int type;
>   	int proto;
> +	int (*setsockopt)(int fd, const void *optval, socklen_t optlen);
> +	const void *optval;
> +	socklen_t optlen;

optval and optlen could be in the stack of the (*setsockopt) callback.
e.g. the "int on;" could be local to the setsockopt_reuseport() instead of 
adding optval/len to the network_helper_opts. Passing one optval in 
network_helper_opts could be less flexible when we want to do multiple 
setsockopt() after socket().

Another nit I would like to make, rename this from (*setsockopt) to 
(*post_socket_cb) because this callback could do more than setsockopt, e.g. 
adding a sk local storage to a socket fd before bind(). Also, add a "const 
struct post_socket_opts *opts" for future extension, Like:

struct post_socket_opts {};

int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);

Patch 6 will need two setsockopt cb functions because of different optval but I 
believe the tradeoff is worth it for this callback doing more than just one 
setsockopt.

Patch 1 to 3 have been applied. Thanks.


