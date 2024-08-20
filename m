Return-Path: <linux-kselftest+bounces-15741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D2957B98
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 04:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B286E1C23AF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F54381A4;
	Tue, 20 Aug 2024 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UFSC/uEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A351C6B4;
	Tue, 20 Aug 2024 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122081; cv=none; b=D0qWupNnFygJoRp7toNQ2M9ln5UJb6couMQ4Tvtdpssewof0H/9owOeOPPeyuVUmPmQrvNm+5mhNRKxEO4wvB4XJmv2Iukxib0gQq6BithHVDlHtp9i3yK0R/Xftl2SyOlIO6i0fNuUZBjdojwp5HymY3mu+rY1xlKPfgkT4EHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122081; c=relaxed/simple;
	bh=rduHVECQBMUm0FaieuznQk/9x6ta6bIhQsY86ZpLIYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJCCc0uOP8q5J415tzUDO8SsIU6oL+E2fAaZca2JvvG56S04lT94q2ohnLXs3MQpqY08Uqqj1b+uSAAiAg54nO+CXz7npYeAa6rE4GtH9cjWqIxEwsnhw0i1YPxZuYVsqnhT/TZyi39f/xvcFgGBFmRh/ys+g84AwA5QI4j55yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UFSC/uEo; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6e8187c-c0d0-08d0-ad6f-472155e8b8e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724122077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZZzpONHvdRTZ1cYQQuR/ToMgSyAjZPT3fZDdgfv8Wg=;
	b=UFSC/uEoryvHjGtyLepXmDKlsdpWfeL26Ltuym5x8xeyumkWP1I2tKvj6G7Rf5MWuQfhg2
	jyx3Nad1eONw+JvKguyHUoOOfs9VVuEBKk8JjUW8P3tJDBYtDDv7jXwIVk5RdSH8+7qyNi
	Hj+PNVnMD9LCBiPqDnSnSU8qymkFf2E=
Date: Tue, 20 Aug 2024 10:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240820023622.29190-1-hao.ge@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20240820023622.29190-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi

I apologize for the confusion.

  I mistakenly thought that my previous email 
(https://lore.kernel.org/all/20240820023447.29002-1-hao.ge@linux.dev/)

didn't send due to network issues on my computer, so I resent it.

However, it seems that was not the case.

Please kindly disregard this patch as it is identical to the previous one.

I sincerely apologize for wasting everyone's time

On 8/20/24 10:36, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> Smatch reported the following warning:
>      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
>      warn: variable dereferenced before check 'buf' (see line 454)
>
> It seems correct,so let's modify it based on it's suggestion.
>
> Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> check in get_xlated_program()") fixed an issue in the test_verifier.c
> once,but it was reverted this time.
>
> Let's solve this issue with the minimal changes possible.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
> Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/testing_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index d5379a0e6da8..34dfea295c8e 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -451,7 +451,7 @@ int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt)
>   
>   	*cnt = xlated_prog_len / buf_element_size;
>   	*buf = calloc(*cnt, buf_element_size);
> -	if (!buf) {
> +	if (!*buf) {
>   		perror("can't allocate xlated program buffer");
>   		return -ENOMEM;
>   	}
Thanks

Best regards

Hao

