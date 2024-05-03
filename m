Return-Path: <linux-kselftest+bounces-9375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A828B8BB040
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DB32863D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4E154455;
	Fri,  3 May 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Lb9f9vCE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81C153BD2;
	Fri,  3 May 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751293; cv=none; b=ezflZhv9Rmko6z5my0cQ0auDt9U4ye++jc924TSm9DPcOJqmEumjzvgheS7Ho8NQQC7P/t7dwhUcSZqAtCJVjKq3snr28lhgAuvta4k8oc8lAxr8EiLVjuI+I3US8Qp9ww0R/nGtsCSPEX/cIHVMAdtJAqXpnUM85qBweSuIoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751293; c=relaxed/simple;
	bh=Gi57PnaSyxj86AO7nfWeJDnXmY0LCGAjn3DvnN/WWVk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lfF0U2tL6icsxfmWSFNu6MCj64KTiFYLw4Qa+E4FhW6ZXrTaAzaHvXPpOr/+kyBqPCBSH/McIfeyrIxKZ776JPCkVPYwr58nzk5TQn6T16blyvZAp7odzFmroNlfYAdKjFfo3GUpQekf7xeMmu1sKBzpdwBhg9m4gia56OSqe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Lb9f9vCE; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1Mms1nJYekqnIQG20iD+aIhue9+zCOecetn66x4QcBQ=; b=Lb9f9vCE6m+/eqCCO1fEr9PmjU
	p6wRQEOrA04SblKdyydwNzKv5HdE5h+4ErxYxulFkG6Q56DuIt7wzrDwgaC+ouOh4w5ep9RDnLPXL
	jlfoS1qNWp4JADAyPXv/j501H4peMwDA0DW50RCdEXFwcLug02R6zTm/SsxqWUdmKnWMEenAqMMW1
	PqIPsU9SYeLoPgtXQK7F/bDkfeDzQKVNFZVdmY2h6+3Qx+xk/JkGxnOQUTDk3JfehgzrpdaBfdZ+D
	Po0HMTAT+wXhIknDOCTah0JZcQ/LiwceH4/pq8S4XS/ORjjFQHzRpumoNMapkh706nvk1pLC23KBm
	/KXK46jw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2v7f-000IQM-0M; Fri, 03 May 2024 17:47:32 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2v8F-0006tI-2S;
	Fri, 03 May 2024 17:47:31 +0200
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add a null pointer check for
 the serial_test_tp_attach_query
To: Kunwu Chan <chentao@kylinos.cn>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240424020444.2375773-1-chentao@kylinos.cn>
 <20240424020444.2375773-5-chentao@kylinos.cn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <79df3541-5557-05fa-a81e-84728d509bfc@iogearbox.net>
Date: Fri, 3 May 2024 17:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240424020444.2375773-5-chentao@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27264/Fri May  3 10:24:33 2024)

On 4/24/24 4:04 AM, Kunwu Chan wrote:
> There is a 'malloc' call, which can be unsuccessful.
> Add the malloc failure checking to avoid possible null
> dereference.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> index 655d69f0ff0b..302b25408a53 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> @@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
>   	attr.wakeup_events = 1;
>   
>   	query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
> +	if (CHECK(!query, "malloc()", "error:%s\n", strerror(errno)))

Series looks reasonable, small nit on CHECK() : Lets use ASSERT*() macros given they are
preferred over the latter :

if (!ASSERT_OK_PTR(buf, "malloc"))

> +		return;
> +
>   	for (i = 0; i < num_progs; i++) {
>   		err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
>   				    &prog_fd[i]);
> 


