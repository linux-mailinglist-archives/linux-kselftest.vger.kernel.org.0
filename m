Return-Path: <linux-kselftest+bounces-14284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8193D9C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0158B285DA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454CC143748;
	Fri, 26 Jul 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="wnV7Jkii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7A148FFA;
	Fri, 26 Jul 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722025823; cv=none; b=jVrcW3I3jEBATGezD+PY9rQ4eMQDA85b7CJBCbDCS7G0bvjAhOthNHaCbTTBdC/IxBWaOwCxxUU4RXFmAuHmMMwQIiGk7KFyiD600Ia9L//YLV62x0pPVfLn169qj63LQ8okb86hpEB1VVPiUqaVG4Ge5K7c1i1u+cJY4xVm6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722025823; c=relaxed/simple;
	bh=L0UWP0ixfAoo0LHpHnsBsWRUwb1cpqgMUWNJWmLMXoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0qZB32c1SsF8kmf8cqhbkdr/qPC+3UlIL3KDy1iAeZfZiPJlAC/FpzzlAYC3eVCaZp7SjGwoA9LycqzO+3VZAMOe3BOR54nvkDB5m1DsOWjAlskvvZE9EMc7COh6KWjol9KWz2HvfkTKz+pWBvqyj8MXLg1hWdBiNx13TBCDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=wnV7Jkii; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sXRZk-00D5qG-AH; Fri, 26 Jul 2024 22:30:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=XSPf08Wy6IQmdrGUD0/lsSy/L1mLLRONWFv0/7FxUUw=; b=wnV7JkiiCM/yX6NpBQL/rRMrmp
	SBMdOTNu18p7Sp9JuNqcCkAHuKJjhz4ooELPsz3B3HxTp9+tzCnGlT9euIa9WmPbBwM8k+YCLJUTR
	oQIYYir8CooSJ9XRscj/ymRWNLaJcTldyGTJ1Xnv6DXvtrYyMbLYsFWA3+70XCpQU6C19gaA1woq2
	cxRqUMLp9iTnFxDBLLey6XWxsAkvnCsJSxTS8qggQqx/l6MRH4D9115lohHc3EFzRxR4Gzi4Ex0XR
	EDLT8Q0NHJgYOh8WjRP29S+kCTDjeLaFAGQ5+atqdH8rPX7OohALrXWOPW2pIEyOXDo8gMOyeBLoX
	3JCiIGOg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sXRZf-0003CM-UF; Fri, 26 Jul 2024 22:30:03 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sXRZM-007T8F-IV; Fri, 26 Jul 2024 22:29:40 +0200
Message-ID: <7ae7a77c-c5ce-4a09-8a6c-b3cd014220f3@rbox.co>
Date: Fri, 26 Jul 2024 22:29:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/6] selftest/bpf: Support more socket types in
 create_pair()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
 <20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
 <87cyn0kqxu.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87cyn0kqxu.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 19:23, Jakub Sitnicki wrote:
> I was going to suggest that a single return path for success is better
> than two (diff below), but I see that this is what you ended up with
> after patch 6.
> 
> So I think we can leave it as is.
> [...]

And speaking of which, would you rather have patch 1 and 6 squashed?


