Return-Path: <linux-kselftest+bounces-10007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D798C2347
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5021A1F21C79
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B316F839;
	Fri, 10 May 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KQdR1rZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9716F0C6;
	Fri, 10 May 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340258; cv=none; b=jmqbw/DP3JKjwWV35e+ZgRGbSXa+dJVBGdV8e9dmabU8X8khVt4swc89I7KVWG7sahwaU7gJ5/SlkrwN5F/yVdZbXMnbNsYSgsU7NX3p3oYR2cGj8vsoTmWRtrF5tj8GnIUJw+W6iaYif3eoXdTOTfBcztppbjmVH+CwCN2IzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340258; c=relaxed/simple;
	bh=MuOQCmUzXNyKWcjxb84KgDM7bo5qL9Sff9/5cgSTgyQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S55zchHKqOKTuBdW2l0TqHhQIsotbaKRdwZN4Mc2gpy/4jqE4XqhsFOkJIz0Ym0x4nEVZYDz9cQRgLrdQ/k2XdZlOKfzqr5of/umb4211DLZ5O3063WGyZQxhfIrULO4moScGK27qQ18wKwgZbjh8e7owFMdBAE9u/Y5jR8eigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KQdR1rZy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715340254;
	bh=MuOQCmUzXNyKWcjxb84KgDM7bo5qL9Sff9/5cgSTgyQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KQdR1rZyH79i9HPkv0ze2lsOUVn2BdiLTVYRsF1zHKTkchSG3t1PBrTXH3G4QZjLm
	 coour17sQx6x8JqSy2Vq5deh+PBtF94+9NUJ8e+F0cZhY8dZYV7G5POGBAgWdsmWtJ
	 CgffO67gYdlgsz9t0v0jyUf2y4ILIjgVHFGpOufGZiOnv26N2/YqnnIFHMRWossONs
	 20DRPqgUbNQ2Fl9Pq24kvJ10ntF7dgHAAHBdz6IZt5K7Df0/iQtk9Nx4bS4B3vTK2M
	 uDE8dF67X0GA+7LppCMMLqRnPfXabyF4huJgl9ecG12ZJGxvCKO6qsqfnG2o51XDD8
	 Oz17qnxfMlvrA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8BA63782185;
	Fri, 10 May 2024 11:24:07 +0000 (UTC)
Message-ID: <ebad1587-3016-4eb7-8cfa-4d2e1e60b95a@collabora.com>
Date: Fri, 10 May 2024 16:24:32 +0500
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
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add a null pointer check
 for the serial_test_tp_attach_query
To: kunwu.chan@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
 <20240510095803.472840-5-kunwu.chan@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240510095803.472840-5-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 2:58 PM, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> There is a 'malloc' call, which can be unsuccessful.
> Add the malloc failure checking to avoid possible null
> dereference.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> Changes in v2:
> 	- Use ASSERT* instead of CHECK
> 	- Add suggested-by tag
> ---
>  tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> index 655d69f0ff0b..a5ebfc172ad8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> @@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
>  	attr.wakeup_events = 1;
>  
>  	query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
> +	if (!ASSERT_OK_PTR(query, "malloc"))
> +		return;
> +
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>  	for (i = 0; i < num_progs; i++) {
>  		err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
>  				    &prog_fd[i]);

-- 
BR,
Muhammad Usama Anjum

