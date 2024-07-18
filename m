Return-Path: <linux-kselftest+bounces-13902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B553093702B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EBB1C21C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB3144D35;
	Thu, 18 Jul 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gHyXwT6K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0081751
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338897; cv=none; b=ramwnaXpriyortilsrTyMjnZB31YtTT57u5rte+xbhnJbNfVnjI2DDCHU+UiVxcrtGg73j0v4Ioe/vAgKB3aOPT3loKwjYYvqFMvXZH8FamZYUGMxQx9lCgaqK1EqNXEV0Q2/5UvzQW1Un/7eLqiopiIcc/ojfO0MuPpATdeEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338897; c=relaxed/simple;
	bh=W6mwy9dDWgsUnkHBPRfD7Z4EC9HkvwHEtuiDWAFaSjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTxEI0DsAoRIsJAtupCjbDMXfCQ1YyPD7gf08LSZSuf29G+KOprkJmqiitOeMpkPloVNm1YALIi8dyVRCnA3ZU9jVCLntK4osbrgjE4vnk1Y+YxzjMofsnirKjBqR9yS2oKCXx4gqGwyKFoMkQgItAdpAxyVRnNiieUV+/cPVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gHyXwT6K; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721338893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kyh7EuVXg6+fizdPDv0qki2IwysyRHSOAa5lUHNyc0U=;
	b=gHyXwT6KBNcFMLwfWgiVDRfnPWz0PnA6NcagGqSHoSieq2ByEiCZfUCyh7/xruV6Orslj2
	mTcKxftq+ibUZewxtrq0UqaMZJ2jFx0dTKL/cweZ/gbDnPHoooNuB2R729Ix7kg0WRohc+
	fe6kS7ZRQFGX/hyoTr4PFteXcPl4cHo=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: martin.lau@kernel.org
Message-ID: <5a92dbc9-fa96-4267-ac89-9fde6ab64ad9@linux.dev>
Date: Thu, 18 Jul 2024 14:41:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/5] selftests/bpf: Drop must_fail from
 network_helper_opts
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1721282219.git.tanggeliang@kylinos.cn>
 <3faf336019a9a48e2e8951f4cdebf19e3ac6e441.1721282219.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <3faf336019a9a48e2e8951f4cdebf19e3ac6e441.1721282219.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/24 11:22 PM, Geliang Tang wrote:
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 15e0e0bb7553..48c27c810db7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -277,33 +277,6 @@ int client_socket(int family, int type,
>   	return -1;
>   }
>   
> -static int connect_fd_to_addr(int fd,
> -			      const struct sockaddr_storage *addr,
> -			      socklen_t addrlen, const bool must_fail)
> -{
> -	int ret;
> -
> -	errno = 0;
> -	ret = connect(fd, (const struct sockaddr *)addr, addrlen);
> -	if (must_fail) {
> -		if (!ret) {
> -			log_err("Unexpected success to connect to server");
> -			return -1;
> -		}
> -		if (errno != EPERM) {
> -			log_err("Unexpected error from connect to server");
> -			return -1;
> -		}
> -	} else {
> -		if (ret) {
> -			log_err("Failed to connect to server");

There was log_err on connect() failure.

> -			return -1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>   		    const struct network_helper_opts *opts)
>   {
> @@ -318,7 +291,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>   		return -1;
>   	}
>   
> -	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
> +	if (connect(fd, (const struct sockaddr *)addr, addrlen))

log_err is gone now.

>   		goto error_close;
>   
>   	return fd;
> @@ -383,7 +356,7 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
>   		return -1;
>   	}
>   
> -	if (connect_fd_to_addr(client_fd, &addr, len, false))
> +	if (connect(client_fd, (const struct sockaddr *)&addr, len))

Same here.

>   		return -1;
>   
>   	return 0;



