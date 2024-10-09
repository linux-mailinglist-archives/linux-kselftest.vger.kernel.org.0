Return-Path: <linux-kselftest+bounces-19352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30757996CA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14281F2209D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9A19DF44;
	Wed,  9 Oct 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pdo8gp3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A1199EB4;
	Wed,  9 Oct 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481710; cv=none; b=UXs+pZxTqtWa3wlcC3lAuBlW6Oc1IW5Ugevs2VEAvn2HgBbQoQ7AksJNR+fffYKl+V1bHizN4/4Bwri/vIgvXWTakAeNvgMWlJxxoSs/yKS1zWQZU2lBV6rQCEZuRg0E2t6oxqUnO7l9Ya8dfFU3qnzvYQ2rnHYnR7VE2b5jmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481710; c=relaxed/simple;
	bh=4X5DGfyWxEPM/0ikMp5z7NrlJL6XW2GVIEdgsZkNuW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0AoaDF3U53GMvwVYSH4DQZ09SMJ4hZ6p54vTmVXmbcOOcHD0ZesA7mE/vQq2sx+CR7rfhZL5bbmPy7NrN2LTnn1f61boBNjlM9w47eLnAfwIPHGRK8YeMQXTy2f7oWr7KsYeHgmV9ZmfnaQnTlzwrLDhmLGK+UUdZnpO0O7p9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pdo8gp3L; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89305E0003;
	Wed,  9 Oct 2024 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728481699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1t3g4J+GTOeYfumohKa7CpVJ/L96IZxUx7EresHVtC0=;
	b=Pdo8gp3LYcIn3zEYWZupx4IHoSn3b5WR4Ko6S+em+Jqr+sM9QmappQQz52qxpXJ5BniXfJ
	EROjtUNgpgVL1gdh+YEPDZGxrlH84vdi1pw7WOTYl+U5cJdoGWcWzJ+j6FAVmE44J1w8B+
	7JJKwWWZH1TB0Zc9caIHkkukvuNHNVJMqJx530ekfKzuBUMtyOYOi9Sh0dNobYFeNxzc06
	svkjGaPx45QQVUlz4t6Qfl5NePLjmVp3W7jc7NXmBbkhDvGw9EDuBgmbqFCFro3dAQycsg
	z36Kz/v+5Bxq1UDarsn+CHZ3AGH/fKY64RH6W9Pv+8LO6Y9JeToXxbZ9ScuBYQ==
Message-ID: <d7451a56-f883-4e98-b3a7-407138d09181@bootlin.com>
Date: Wed, 9 Oct 2024 15:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix error compiling
 cgroup_ancestor.c with musl libc
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20241008231232.634047-1-tony.ambardar@gmail.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20241008231232.634047-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Tony,

On 10/9/24 01:12, Tony Ambardar wrote:
> Existing code calls connect() with a 'struct sockaddr_in6 *' argument
> where a 'struct sockaddr *' argument is declared, yielding compile errors
> when building for mips64el/musl-libc:
> 
> In file included from cgroup_ancestor.c:3:
> cgroup_ancestor.c: In function 'send_datagram':
> cgroup_ancestor.c:38:38: error: passing argument 2 of 'connect' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    38 |         if (!ASSERT_OK(connect(sock, &addr, sizeof(addr)), "connect")) {
>       |                                      ^~~~~
>       |                                      |
>       |                                      struct sockaddr_in6 *
> ./test_progs.h:343:29: note: in definition of macro 'ASSERT_OK'
>   343 |         long long ___res = (res);                                       \
>       |                             ^~~
> In file included from .../netinet/in.h:10,
>                  from .../arpa/inet.h:9,
>                  from ./test_progs.h:17:
> .../sys/socket.h:386:19: note: expected 'const struct sockaddr *' but argument is of type 'struct sockaddr_in6 *'
>   386 | int connect (int, const struct sockaddr *, socklen_t);
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> This only compiles because of a glibc extension allowing declaration of the
> argument as a "transparent union" which includes both types above.
> 
> Explicitly cast the argument to allow compiling for both musl and glibc.

Thanks for the fix and the details :) Indeed it looks like all other tests
perform this cast on connect (either to (void *) or (struct sockaddr *)) to
prevent this issue, so that's a miss on my side when I rewrote this test.

> Cc: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> Fixes: f957c230e173 ("selftests/bpf: convert test_skb_cgroup_id_user to test_progs")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> index 9250a1e9f9af..3f9ffdf71343 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
> @@ -35,7 +35,7 @@ static int send_datagram(void)
>  	if (!ASSERT_OK_FD(sock, "create socket"))
>  		return sock;
>  
> -	if (!ASSERT_OK(connect(sock, &addr, sizeof(addr)), "connect")) {
> +	if (!ASSERT_OK(connect(sock, (struct sockaddr *)&addr, sizeof(addr)), "connect")) {
>  		close(sock);
>  		return -1;
>  	}


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

