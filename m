Return-Path: <linux-kselftest+bounces-10005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A18C231C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83611C20E3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F916F85D;
	Fri, 10 May 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A/6t1HAQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6854662;
	Fri, 10 May 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340130; cv=none; b=KvNJFoMqC1bYb2W29pta+O1f2WFQgtx2SG+rplv+Zh3rQ5bG+6Ysa4lDmljgjFaQRmlkflKOnFNCWYns/L9VmElQlMixWgyyZUxE0P3a0aF7CAWbiRWWnHvYQQk/cZsdbRgHnsj3r+8u7T6mqYNK0wTpcTwApbP+j3g3bL1/oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340130; c=relaxed/simple;
	bh=mSAKbILicGZ2jA5iMQsYhrs50+CCyAKG0Vj/7T7WIbs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u6rV5+jKMnb4zL/KKmGeLTGkp+IGH3ZW8ivr40/vSA2+FnELCsk1nqCaTmfAjBuNLPKoBDMBSy55KBcfJSgLXFPp72KcR0/HImlzijbAziRlEuavyxlKG3RPjJ+G3xkBTpzWL5oL8dQlCUUk71Wv9owVkurbOku75Jw8MZ3eCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A/6t1HAQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715340127;
	bh=mSAKbILicGZ2jA5iMQsYhrs50+CCyAKG0Vj/7T7WIbs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A/6t1HAQ00Bj/IZpnkIEAylqRa9rLnfmYz/sCKuUB6k1TPeLsjsFqOPIfTBwTbfF+
	 hNIdfIbUWitan2i4UUPD1UpcGmF5C6ZouZVjnRCys4z4Nk9Bx0LdH0iZRN0SLuXD6l
	 HRlXrcqJ5CQOw534nw9RCz82ihmHofCPlnYt3J5ntuFWq9fvamRzSEq4CkEUgLyAKl
	 mcSiKT+Ml58yxsduGrCdn4kYavQHEdUutFDHtpuhufu+pD+kkAlx4RcfPDTYAz0LVX
	 IdWWXhh1e/4m2rYTkvJQ7hYpY/c7IknWzwlB3/dKn8t1tcukxa/tvVQlU94bEJ/XHO
	 VKWCFNAx6NfMg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A8AFD3782185;
	Fri, 10 May 2024 11:22:02 +0000 (UTC)
Message-ID: <e3d20115-df52-4d1f-98d6-928277f9ca36@collabora.com>
Date: Fri, 10 May 2024 16:22:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf/sockopt: Add a null pointer
 check for the run_test
To: kunwu.chan@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
 <20240510095803.472840-3-kunwu.chan@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240510095803.472840-3-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 2:58 PM, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> There is a 'malloc' call, which can be unsuccessful.
> Add the malloc failure checking to avoid possible null
> dereference and give more information
> about test fail reasons.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> index 5a4491d4edfe..bde63e1f74dc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> @@ -1100,6 +1100,12 @@ static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring)
>  		}
>  
>  		optval = malloc(test->get_optlen);
> +		if (!optval) {
> +			log_err("Failed to allocate memory");
> +			ret = -1;
> +			goto close_sock_fd;
> +		}
> +
>  		memset(optval, 0, test->get_optlen);
>  		socklen_t optlen = test->get_optlen;
>  		socklen_t expected_get_optlen = test->get_optlen_ret ?:

-- 
BR,
Muhammad Usama Anjum

