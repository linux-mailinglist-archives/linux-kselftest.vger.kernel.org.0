Return-Path: <linux-kselftest+bounces-7600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9818A01DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836B91F23722
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232D31836DA;
	Wed, 10 Apr 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ohAS6a+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF511836CF
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784015; cv=none; b=O3Ai3hgLsH2+9Jd62rppElW1NmKnHgTiU8dVT9q3vQlWaVWKEg/R2QPxZZKFsOxJDja+TMAgSyZoG1JsfX4UV0c+8iAkpEGO+t0fBum2umqmYs3C9rtLk6adV1BTCV2TjGk0iRLU6KJIBe+F05gJOnsmIN0X81TvwnTi8Hn29mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784015; c=relaxed/simple;
	bh=REkXgz1nvwfSQazm/q64YEAox4iA/CcshWlq42TMmc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLL3oBg9L34oRD7FrcZcoLJuOd3gNLFovtLTyDqqgO/u6jvV9Z7cYPFH1OXHnXMq7QqwiJpm5oHR41u0OuONEzHHhhFTSzVtV7ahXf60Jn9L7HtMIxvbafHjvgESbr6sScQwKO4kMIGY6l9p3mzVxhlWg4WFfiAnnnglpsOfWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ohAS6a+1; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d914a95-0d79-44fb-96b8-ca0b34744455@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712784011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFQHL0dbndzxsL9DsXyf/uU+3MLrYDNeJdtA9F0MJys=;
	b=ohAS6a+1M9mFM0RnUX4olxNOHfqJU7uA3IjuWaWUNF88vOwQ3OHmP/ACXg+9NgmaGPs6gu
	V1tVKceAKEPvcHWbXFnycV1edhmje+syhvwLwYv1RjiooZKRQXvNuJ7Z4w76zK9z99yiHN
	8wIqWdfx8whlYsUOk+lhdmUaloous4o=
Date: Wed, 10 Apr 2024 14:20:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Export send_recv_data
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
 <a5cfd3271d91756deca82fafbc41f17819b6e67a.1712729342.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a5cfd3271d91756deca82fafbc41f17819b6e67a.1712729342.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/9/24 11:13 PM, Geliang Tang wrote:
> +int send_recv_data(int lfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	struct send_recv_arg arg = {
> +		.fd	= lfd,
> +		.bytes	= total_bytes,
> +		.stop	= 0,
> +	};
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
> +	if (err) {
> +		log_err("pthread_create");
> +		return err;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1)
> +			break;
> +		bytes += nr_recv;
> +	}
> +
> +	if (bytes != total_bytes) {
> +		log_err("recv");
> +		return -1;

This is still not right. It needs to write arg.stop and do pthread_join().

pw-bot: cr

> +	}
> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	if (IS_ERR(thread_ret)) {
> +		log_err("thread_ret");
> +		return -1;
> +	}
> +
> +	return 0;
> +}


