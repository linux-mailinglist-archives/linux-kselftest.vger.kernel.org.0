Return-Path: <linux-kselftest+bounces-45932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7EC6BF50
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DFA44E6430
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 23:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E482F690B;
	Tue, 18 Nov 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="No7V5DrD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C32D6612
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507550; cv=none; b=LTG0sK2XZY6z+im5i5LB2cWVYz+gCH2EpTRT5t3F3ISlGnmV5oJQ+CfbsZitTf2/sr8vUVSjdaBECL9M7m06GcyRzmsMvowEKNmINHiN1o+SUWzJJXwWEjZpkoeOfrCOvOku51WaRti/zgpnGYJneI4NjZLQLVwWJZT/RFxV+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507550; c=relaxed/simple;
	bh=e/Hnql5X24YAHbZdXDFtkYfQnmz3FhRh0cWocj6LGAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkz0vUdKsygErC85+DdE+Si8nltQDiEuLHDBxnd9ae1AMGzZEHv62Ao2PevoSzU1RY4oZYMKLeB5cojY3KrzEBmyKP8sjQpWhu+0PtZmKSyWdue4/NS9u8v7OCHcaTO/ZVYEqSAN7iYakhZzYvPR4mwpDUtNT/LN1PlL/Nlav1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=No7V5DrD; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ed9de08-9a5b-4fc9-9213-ca918dafea0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763507542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xaoTNRkEc4AwUxJW2GrHJgy21+EkedavIk+JMyDtFX0=;
	b=No7V5DrDej+c5MpOesXj0Sy7BeZ+JSAWRkE392Kxi6iS6pIqF3qnFkLFcpmTwS3NbuSAVa
	BQxNZeLLyguQ7j1Bv3FXE8gK3DnDjrf9T5htpKXVcSD1dYYhETPU/qEBRqeq5ktpfDtsYN
	TtcmiiQAPV9YPxKM8Eod1rE0U1kPFKc=
Date: Tue, 18 Nov 2025 15:12:13 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next v1 1/5] selftests/bpf: use sockaddr_storage instead of
 addr_port in cls_redirect test
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
 <20251115225550.1086693-2-hoyeon.lee@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251115225550.1086693-2-hoyeon.lee@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/15/25 2:55 PM, Hoyeon Lee wrote:

>   struct tuple {
>   	int family;

The "family" is not needed either. Just use the ss_family from src or 
dst. The 'struct tuple' can be removed also?

I'm on the fence about whether this "struct sockaddr_storage" change is 
worth the code churn. Are patch 1 and 2 the only tests that need this
change?

Patch 3 and 4 make sense. Patch 3 and 4 are applied.

Please post patch 5 as a separate patch on its own.

> -	struct addr_port src;
> -	struct addr_port dst;
> +	struct sockaddr_storage src;
> +	struct sockaddr_storage dst;
>   };


