Return-Path: <linux-kselftest+bounces-30952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF8A8B936
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3463AB34F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276B1BF58;
	Wed, 16 Apr 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lW39PM8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F34A24;
	Wed, 16 Apr 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806870; cv=none; b=DDuulVWgh/HRYMh7AllnY1GIr8XCNRrfAdJYOXg03gKBe8AtzMSwQIPAVYTkziMTDkOUBfzrWTdDiJ0U+d6k4XrHKGZyKgq2y3KFKzBy9osA7PxoXDrjt13Wg4FlwRHbPJPa3phgYkL4jGVQoKIlhHg7IgAlHEfYThwkMtv29ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806870; c=relaxed/simple;
	bh=WWcwwTC7EZdfHdRfTryGVgalV2DWfrLjxVOpvMgt8U0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sfEGWriHi0ojcJmsOK/JiJqRqzTee7Zd8aa01S3Bh7TQU4swhSyoZLf7pEZXRi2Ju0c2f/Q/pFhDudHmyyfj2vM1WkVZRmPu6bElcDFsWHkSIneejIhwLYiW8Pk1NL5VUNtvpFsJqiDkyqn8gJmdFa2nsaDmMplWNTetSulptRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lW39PM8L; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u51y6-002cy9-3G; Wed, 16 Apr 2025 14:34:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=UjqFfqPx6cvEdccJ7oOBXQZaC6kTqAwp1SpYt+j3Nkc=; b=lW39PM8LFm7wlVgceI3BzJ7ww7
	WgizwU0MwPokEk38E4P+a8BzogJpl40MwoGfW6A6/deK5sv7jnxoUANTcwECI8mpr7KqT4damgkQQ
	hwTeRRN+sXAac17IdM9ChTP99T9WFX8Sfkd+Q0SQirHE7Up0T20or+iZl1eDBc/6ralfzc98ZKgbf
	DKU1ufcnq6rBX1VWqYqtdcLdUlTZuWafbQhmPRFP6VC5VezKMijh5PACFXXNa6Q/JzBLpUbBMgZky
	QRnPSj8DZrPs3fsICGD6LW2DfkOYgqt8/f4fQoSsx4eKKqTl8IqErW9l++pUi5Sxwobix1a+5g/4I
	HAt/1qYg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u51xz-0005AD-Gd; Wed, 16 Apr 2025 14:34:11 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u51xm-007llz-BQ; Wed, 16 Apr 2025 14:33:58 +0200
Message-ID: <adbb8f18-4490-4785-aa5c-2942a53c09c3@rbox.co>
Date: Wed, 16 Apr 2025 14:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next v2 5/9] selftests/bpf: Add selftest for
 sockmap/hashmap redirection
To: Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <mrpre@163.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
 <20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
 <fnsy7wey4vaewoyur5363w2q2nb7dvljmaroijflgq2hfqbumo@gqdged7tly47>
 <87a58mh9co.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <87a58mh9co.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 19:54, Jakub Sitnicki wrote:
> On Fri, Apr 11, 2025 at 09:09 PM +08, Jiayuan Chen wrote:
>> On Fri, Apr 11, 2025 at 01:32:41PM +0200, Michal Luczaj wrote:
>>> Test redirection logic. All supported and unsupported redirect combinations
>>> are tested for success and failure respectively.
>>>
>>> BPF_MAP_TYPE_SOCKMAP
>>> BPF_MAP_TYPE_SOCKHASH
>>> 	x
>>> sk_msg-to-egress
>>> sk_msg-to-ingress
>>> sk_skb-to-egress
>>> sk_skb-to-ingress
>>
>> Could we also add test cases for SK_PASS (and even SK_DROP)?
>> Previously, we encountered deadlocks and incorrect sequence issues when
>> the program returned SK_PASS, so explicit testing for these cases would
>> be helpful.
>>
>> If implemented, this test would fully exercise all code paths and
>> demonstrate a complete example that covers every aspect of
>> sockmap's packet steering and connection management capabilities.
> 
> This could easily be a follow up in my mind.
> 
> [...]

Yeah, I wouldn't mind doing this in multiple steps.

That said, with SK_PASS/SK_DROP involved, are we sticking with the name
"sockmap_redir"?

