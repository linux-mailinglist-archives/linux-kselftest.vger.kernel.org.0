Return-Path: <linux-kselftest+bounces-45367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804DC4FA9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 989884E296C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0DE3A9BF3;
	Tue, 11 Nov 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HTtUTGkk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938F3A8D7F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891408; cv=none; b=fNBbBKMcyLF7Hx+z+1iO6vj2iFQnKzeWoix15nI7zDhZOpGogqmQBHPaMZ1zC1nE1T2T/+PQFEvUu+Hvf5eh0mItxRQmnim78v8JwErBRV9xN8uRPMWijzbFuzJ0AmE/oYiW1BRYnK+acp6r/82keychMzokJ52yOHj4qdg53Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891408; c=relaxed/simple;
	bh=pf9287Nm/svDI3j2821AotR6J9vTBpBVd1lkt8X4XTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTjt3JiNsJ2IWugWGGehGXefWB42USvdSDjB76x9PTArlT5dgngHAl/M6NCCeDY6SjC0j4eAzt7P5KWJfr1yCgLMxnpeD0N7xwg0ZwdKqkZw9tYWTFGtNlFfBSe7Na3vqBgMIo6r0WS4bN/EfBFTZY41GUsx408kdPSKhk712k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HTtUTGkk; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b63ecae1-b777-4d0d-b8b5-d56f5e602fb3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762891394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APxeb2ZQ4nzLpce0oksEL6Cz9ImKl249/UkYNszKKNk=;
	b=HTtUTGkkD/HgkYFsd6bHpdDdpHHunWpZwSh4954l9yHuj1Mz7oP/k+/Cq5doWeUwTaUgOH
	zZveTXGjJ6cj+9LkwOtuManNpevcnsNcvC3qCwCLtczFCZrfbgrfpGr3iuM3h/ocTDD3CI
	RMW31ppcRdCx6ICgjYOuLaX2hxZat5s=
Date: Tue, 11 Nov 2025 12:03:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] selftests/bpf: test_xsk: Fix spelling mistake
 "conigure" -> "configure"
To: Colin Ian King <coking@nvidia.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251106110419.16265-1-coking@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251106110419.16265-1-coking@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/25 3:04 AM, Colin Ian King wrote:
> There is a spelling mistake in an ASSERT_OK message. Fix it.
> 
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/xsk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
> index dd4c35c0e428..04f9a5e73e5e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
> @@ -74,7 +74,7 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
>   	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
>   		goto delete_tx;
>   
> -	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
> +	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "configure ifobj"))

Please squash with another typo fixes (https://lore.kernel.org/bpf/20251106110016.15960-1-coking@nvidia.com/)
into one single patch and use the "bpf-next" tag.

pw-bot: cr
>   		goto delete_rx;
>   
>   	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);


