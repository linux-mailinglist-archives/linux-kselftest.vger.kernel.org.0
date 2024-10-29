Return-Path: <linux-kselftest+bounces-21006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B69B52D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D227F1F23A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AF2076CA;
	Tue, 29 Oct 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="chyg9Pjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A42076AB;
	Tue, 29 Oct 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230583; cv=none; b=WE5AVy8dlAaZW87NrAENB1TQMakrVPMXsYCmc2mnEvi45x1I1rwRZYY7zPljy25XKfiYVy/W9eZiQcXcqYboyR4WWzOGr+uUGZfywYM5F+cH40ghjpwxkQsDxr5R1a6ilUWHGLUgC8wYYL34hs8fcssugFKo5zvtPyqnSSiVF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230583; c=relaxed/simple;
	bh=RwWoWVgaDpPPX60vTGGSi501SyjRryOxD96ACvk1Ufc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzubABpf0e/bVloN9SQVwHsvPhpFxPYQJesRuxiJB09/CaaQ0KBf/11eKge1HiDRB+TJmB+HwcLGVywb39NtSseUYiHBX66Fft6apn7evPofsXVEt18nr9GFSCVkpruCaiLk6ZiLnNp7zvbKebCCsZ3X0HrVGnIufm+bGLWtWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=chyg9Pjg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1d6b9d1d-6ce4-488b-9884-3025f06c5e3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730230577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fdfkYeCo2M3OehFrjF+LyPfFmwW+N0QFnqT8DPIsjw=;
	b=chyg9Pjgq1SJVlFlHn5zNxEjGIt/xyKo85vJXNJKxgpZlGt4kJT/aSMnJRwZDtILOA/oap
	rP2TohvqW4s+Rma9KgqxLB2BahZWk8I7GZD6DB3n6drJck7syb2dmYycqGTw28D9l36bGd
	5CW9QHgqS7DrZy7DIyxMemBxfwAh25g=
Date: Tue, 29 Oct 2024 12:36:07 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Use make/remove netns helpers in
 mptcp
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matthieu Baerts <matttbe@kernel.org>
References: <99e57c7470ac338da18f02ef3af5936c8b21f5a7.1729757268.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <99e57c7470ac338da18f02ef3af5936c8b21f5a7.1729757268.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/24/24 1:11 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> New netns selftest helpers make_netns() and remove_netns() has been added
> in network_helpers.c, let's use them in mptcp selftests too.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/mptcp.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index d2ca32fa3b21..8276398f7d6a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -66,12 +66,18 @@ struct mptcp_storage {
>   
>   static struct nstoken *create_netns(void)
>   {
> -	SYS(fail, "ip netns add %s", NS_TEST);
> -	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +	struct nstoken *nstoken;
>   
> -	return open_netns(NS_TEST);
> -fail:
> -	return NULL;
> +	if (make_netns(NS_TEST) < 0)
> +		return NULL;
> +
> +	nstoken = open_netns(NS_TEST);
> +	if (!nstoken) {
> +		log_err("open netns %s failed", NS_TEST);
> +		remove_netns(NS_TEST);
> +	}
> +
> +	return nstoken;
>   }

This can be further simplified by using the netns_new() and netns_free(). Then 
create_netns() and remove_netns() can be removed from mptcp.c. Take a look at a 
recent usage in prog_tests/btf_skc_cls_ingress.c.

pw-bot: cr

>   
>   static void cleanup_netns(struct nstoken *nstoken)
> @@ -79,7 +85,7 @@ static void cleanup_netns(struct nstoken *nstoken)
>   	if (nstoken)
>   		close_netns(nstoken);
>   
> -	SYS_NOFAIL("ip netns del %s", NS_TEST);
> +	remove_netns(NS_TEST);
>   }
>   
>   static int start_mptcp_server(int family, const char *addr_str, __u16 port,


