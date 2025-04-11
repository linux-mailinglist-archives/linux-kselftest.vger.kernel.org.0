Return-Path: <linux-kselftest+bounces-30592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CEBA85C26
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A8C3B4771
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37069298CA3;
	Fri, 11 Apr 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="K4DhqlWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DB0296172;
	Fri, 11 Apr 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371933; cv=none; b=deUq4Yzr/4MkU4cN+LAQajJA+qjNZjPScAuAlEW6wslk+ZiO8szaWC1LyJvwiGLV3HCfnN4onzA+jF7tqJqz6GXlPDEEpZV7NMgq0G5uS+w65Fi9L+E4TOQUYW6z03Ek1qDpEtOI8wS8blqNFi8S/712FpU/m+YU0gYbIwEplSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371933; c=relaxed/simple;
	bh=O0N+6GXXWBWmxO5Ai1rMinbW2jzeIAui0qM9ywV+tto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXE8NIRmfW+KvqwwYARGSJ/TyfL0XIemeX2jOXAnCLUjzQ1tdmnoEC5iNVPCX5zGFaa7cXCEzJpbeOG965aEQOvAbGVs5eyrObzT8CoECOuSOWvqDr6TmJeq9RHVwnZz9I5jbEP/dKYgtt9ZAn+qpbXrDYpv5YvhJbNZpRvU0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=K4DhqlWO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cow-005rnG-UL; Fri, 11 Apr 2025 13:45:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=bQZGP4rGJ3pEUvgfbYcy86zaGN9DlYadoqfiCi3oZ60=; b=K4DhqlWOkE/ovz9FA4jn6i1Yb+
	+aLYPnJfySrff6fydwmssBbGbeWPry3LwIGfju+62saMuCcF9zjNmmuwlvFKUA2GL2hjsh/svGubW
	ol9u8YC5pYUQ/OfDJ+9OOwRu8HSkxCL+kfX2cwsRHBcrjGE2SnQ3KbRJYtpkakIiS85DdMzg/Ka7t
	Cwtn/HU1345cqIZk/L0yV7gugH2NuHbqTXxsnucc+6/LwEDAVT3LWcw9zDb0+UK1udK71TpRmjc3h
	21A++sIeYsFQWv8XB+anuwW2+3h/CryPdoiQbSAPJxH3zX3s0WCucyg0YWr/ka5x6OWJZvahGFToB
	Um1WcFAA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Cow-0000MV-2k; Fri, 11 Apr 2025 13:45:18 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3Coe-00D8D3-1r; Fri, 11 Apr 2025 13:45:00 +0200
Message-ID: <07d453c8-7790-4b45-a18a-a416bea94e34@rbox.co>
Date: Fri, 11 Apr 2025 13:44:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
 <877cccqnvj.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <877cccqnvj.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 22:05, Jakub Sitnicki wrote:
> On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
>> On 8/6/24 19:45, Jakub Sitnicki wrote:
>>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>>> Great, thanks for the review. With this completed, I guess we can unwind
>>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>>> wanted to take care of yourself or can I give it a try?
>>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>>>
>>> I haven't stated any work on. You're welcome to tackle that.
>>>
>>> All I have is a toy test that I've used to generate the redirect matrix.
>>> Perhaps it can serve as inspiration:
>>>
>>> https://github.com/jsitnicki/sockmap-redir-matrix
>>
>> All right, please let me know if this is more or less what you meant and
>> I'll post the whole series for a review (+patch to purge sockmap_listen of
>> redir tests, fix misnomers). [...]
> 
> Gave it a look as promised. It makes sense to me as well to put these
> tests in a new module. There will be some overlap with sockmap_listen,
> which has diverged from its inital scope, but we can dedup that later.
>> One thought that I had is that it could make sense to test the not
> supported redirect combos (and expect an error). Sometimes folks make
> changes and enable some parts of the API by accient.
> 
> Just a suggestion. This will be a nice improvement to the test coverage
> even without the negative tests.
> ...

So this took me for a bit of a journey (sorry for delay), but after
tweaking some things here and there, here's v2 [1]. There are not that many
changes, but I did try introducing negative tests and deduping vs.
sockmap_listen. Please let me know what you think.

https://lore.kernel.org/bpf/20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co/

Thanks,
Michal


