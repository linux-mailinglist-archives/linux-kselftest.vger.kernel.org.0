Return-Path: <linux-kselftest+bounces-8289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253618A9029
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 02:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EA3282CFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D2523D;
	Thu, 18 Apr 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXoMgPLq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2014C69
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401373; cv=none; b=lcPgmmTq7pZDJS0TK20SI9n3Il/G8MSAy3hTj6o6ayRfhdfaqKFci6mGhr/w77oIk5NVsgXVEE0OixxqgTH8fITer3ZNqIm+7x6Dd0Xl6kMVVB/b8dQZxhOSViBQHEiC7hPo+leKxrn+XtOc5opRmArwpfosT7ZCg+7rZ0hAqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401373; c=relaxed/simple;
	bh=F/SkmoQvSLWZ7QJaggfJvpFq6OEWRVn9qMxeTf9LvM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq2tn3iWCnI9g5m1xd/rBporsIvIwC+WfeE8jt38q4kN0DhdoLIl9Q+f3/77fAKTK283VCfFl80bf3zxDP0igVYk1157JWv6olLTzR2mizJZzFSwilvPzWsCu9ehmGPQ2wXHWSFtZyy6s82JWMQ796o7NpCh9OoQGMSPo4vpN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXoMgPLq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713401369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2R/bhzkqU116/NpQeIcCt+dReP6JwLb0WVDt23oS7A=;
	b=hXoMgPLqYrqlqpzea3HP+pt6VK3cxm6EshAaFRPTEnsnLBh2zaFKZQVkNYFAtDpmLc86yG
	0Wzk7FLlGlY1zPsF6jGDTYDDakEUSNcH/aPeJb4T9XDDvkPhY1QyenFGm568QZYLiTqPOJ
	/AJ1zVymfUEs+gqxa5g9gbAnQq8l3pA=
Date: Wed, 17 Apr 2024 17:49:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
 <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/24 10:08 AM, Jordan Rife wrote:
>> Can the test_sock_addr.{c,sh} be retired after this patch?
> I know it's not used in the BPF CI tests, but is it still used in any
> other contexts?

If anyone depends on the test_sock_addr binary, it will have to start using 
"./test_progs -t sock_addr".

The test_sock_addr.{c,sh} can be retired as long as all its tests are migrated 
to sock_addr.c


