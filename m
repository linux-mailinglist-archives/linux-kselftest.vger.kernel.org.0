Return-Path: <linux-kselftest+bounces-30950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AAA8B92C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAD0189B1E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792E4C6E;
	Wed, 16 Apr 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OqXc+HW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9166FBF;
	Wed, 16 Apr 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806813; cv=none; b=F2ElmUbm3b6P40mz1nzAs3tqcglw9FWaXEvaodwHAZR5DGHdNfo2BuHC5xKjOW83CT5+CDrWqpDMzAtRI57stMvnxXrxtZKx2y+iM7ku6Klf+ZeggAyPLCP/l9jVhK5VpwLBrFNgi8gQRCUtS/QCv/K/3A5Vcoq96i2aTQvO1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806813; c=relaxed/simple;
	bh=4qIM6NDApAy+iQcMJjhG+V5szdj3jxVPua3mI1f89bw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FYhHR2o7L+sZVwYs3jz4rIPYVS8Lr8WX84RpFTgigZKV3phsjAsdiFJnmVIWk8u6nMt9pMMoZgTiJ0mv88PA5A2xeHYcZYceH4Kygrwl2gUGIJzqZ9t65i/iTfSoHOWUNa0nx7/n4f8ILkyksoTgNC/ZxM9eDwz74POIW4SRqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OqXc+HW5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u51wt-002mjC-Nu; Wed, 16 Apr 2025 14:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=crDf7Ip/1JD64ubcfZIDIgxNvqURgDue9Ofx9nsrBaE=; b=OqXc+HW5jOJBt0DSI9pRew7obI
	G7v9uG4x6ZoWt4/198n7KvxuaCpNA1yS9JcyU3t7ZeVCt5wOMto1r8UD2vNTxPN68vHWMsWm0Q43T
	3KGjJuuKRRsamJDnZGpy9bkFLcNkXQ1pxGCqesZB5zxvtA9Zni+HasGbF9EeY989VSB03aNtRaG43
	CfMMhlEzKm4eVHpePIEh1PIiAfjvJtcELz07/KMNKc+pfZL+R2LzpzzcGIcF0SveV7oPHG1x/RyKS
	ZyrY0K+utd4JgJ4Q0znHzX2ag3Go2L/h0i5i0mXEfWuBEeuDXVMQSNGcRue3t8bkY3DZsQ+7O7fpU
	MduH9caQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u51ws-0000hV-I2; Wed, 16 Apr 2025 14:33:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u51wc-008Du8-Be; Wed, 16 Apr 2025 14:32:46 +0200
Message-ID: <d81e3e32-55f7-4764-aac8-ec959ae87175@rbox.co>
Date: Wed, 16 Apr 2025 14:32:44 +0200
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
To: Jiayuan Chen <mrpre@163.com>
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
 linux-doc@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
 <20250411-selftests-sockmap-redir-v2-5-5f9b018d6704@rbox.co>
 <ckmjezlvp565ndplzmjmezvh6yc5enlxjgzcyd6uhn7trbuyxn@x56gl73w3mfm>
Content-Language: pl-PL, en-GB
In-Reply-To: <ckmjezlvp565ndplzmjmezvh6yc5enlxjgzcyd6uhn7trbuyxn@x56gl73w3mfm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/25 15:17, Jiayuan Chen wrote:
> On Fri, Apr 11, 2025 at 01:32:41PM +0200, Michal Luczaj wrote:
>> Test redirection logic. All supported and unsupported redirect combinations
>> are tested for success and failure respectively.
>> ...
>> +	for (r = redirs; r < redirs + ARRAY_SIZE(redirs); r++) {
>> +		enum bpf_attach_type attach_type;
>> +		struct test_sockmap_listen *skel;
> 
> Could we create a new BPF program file, such as test_sockmap_redir.c,
> instead of reusing existing ones? This file would be specifically
> dedicated to serving the sockmap_redir.c functionality.
> 
> I understand there are already some duplicate programs, but isn’t this
> exactly the goal of our current work—to make the test examples more
> comprehensive and cleaner?

Sure, I get your point. I'll do that.

Thanks,
Michal

