Return-Path: <linux-kselftest+bounces-13147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52475926B06
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 23:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE621F217F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867C1946B3;
	Wed,  3 Jul 2024 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLYBF+zO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F972190694
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043622; cv=none; b=S+ygg5JfpmZNe3sBKC/hnaoL/es1WkV9pCKm5TPHMcRloo5Zwv/Gkz0GsA8urhBf736kWZTdih+2oLDymsCmSLoevhwsaDiX7huig/F/IfMD8HmOFX1ty9+esAsOoouJtlw8ntV1NdL7twbHhQkw5HJ9ZDWCU0SbC/eP+R0VCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043622; c=relaxed/simple;
	bh=dFZ8KJBDyueT7rmvSnHNEtUPKd8YFR8yjNmX1yhU/yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPLMJ32Un5ZCpbynQ6Uj0GAI9V4q4HEvvAtY7ME+2cFBkgo3E7esPQhfXgLWnZzk9n8p82Jw4aZ6VdEu2BiU37exzi7HqevixRap82Hx8MBV+wr4ePYoy1YtN6HC5PzeeBbuSwG1ubuiCTjjsz/vY0RbXSa+zz0k1AB5owFU4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLYBF+zO; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720043619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nXh5Dt21KFgrYA1McG2uMKWzhV2NgvD08tQxeVoYHU=;
	b=PLYBF+zOg43qiRGnullNCvbxIGVx2AB8en+9dZNNXPBSdgu4rRkMgJYQgxduTtDrwedWsj
	4AvQCdSKXoqxpe0a93B7UQST2PVgDtI7ZVYe0QYSEYIUGuJjUAeHHBLUDa79QlQiW7IQ1G
	+fUtTLrNmTi1uFnUbY138oOE138w4K0=
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
Message-ID: <b7d8c5ef-b2de-4d29-b206-f6e7ed79ae99@linux.dev>
Date: Wed, 3 Jul 2024 14:53:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 6/9] selftests/bpf: Use start_server_str in
 sk_lookup
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
 <06045a7bd4014d62e762778f149efa837d66b8dc.1719623708.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <06045a7bd4014d62e762778f149efa837d66b8dc.1719623708.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/28/24 6:20 PM, Geliang Tang wrote:
> +static int make_server(int sotype, const char *ip, int port,
> +		       struct bpf_program *reuseport_prog)
> +{
> +	struct cb_opts cb_opts = {
> +		.family = is_ipv6(ip) ? AF_INET6 : AF_INET,
> +		.sotype = sotype,
> +		.reuseport = reuseport_prog,
> +	};
> +	struct network_helper_opts opts = {
> +		.backlog	= SOMAXCONN,
> +		.post_socket_cb = setsockopts,
> +		.cb_opts	= &cb_opts,
> +	};
> +	int err, fd;
> +
> +	fd = start_server_str(cb_opts.family, sotype, ip, port, &opts);
> +	if (!ASSERT_GT(fd, 0, "start_server_str"))

ASSERT_G(E). probably helpful to add a new ASSERT_OK_FD into the test_progs.h to 
avoid this in the future.

> +		return -1;


