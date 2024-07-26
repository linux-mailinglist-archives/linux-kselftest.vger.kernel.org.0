Return-Path: <linux-kselftest+bounces-14266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B381B93D11B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA64282074
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F1178CC3;
	Fri, 26 Jul 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OUYwRHen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5302B9C4;
	Fri, 26 Jul 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989641; cv=none; b=XouiFfZQGfirdY4KaG9K66zRoOMkJ0m7QmgieBI4g9cSCwyCvRSHrRmeipa0/SSqUaYx3gOXAfOT00Q+SfiJ/s85upMvdI73/WUGdELypWAevBVaM5IsXuZWCnD4BZ+j8HRbK25LLZrTURnozVYGHtuceMTzSGUfzA0CHY4Phw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989641; c=relaxed/simple;
	bh=CYJ9+RV8RP+wnm+A3mW0JV2X0JjvWYVeKw9feENPbq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d//n4X+Kd8EYncVVHSmlw3+luiPRP1SnedB3i1t+9XjJOnoZ8Gli/tri8pDBRkaWNJIFN/hAaEGh2DBmWIEm6Ut3a5SWfMHoj1fpprBc8E3BtDZNiRjCKr73HqvZWnSJ1avCRcIpDKI28/RXyoPnT+TI7w6Y5hGABrZDnIXMwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OUYwRHen; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sXIA7-00E0Mm-6w; Fri, 26 Jul 2024 12:26:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=QNU5SWIVB3Ip5Gyd6oYlfDuASwK+ulpWrf4D1omspng=; b=OUYwRHenPnSUfs4gqsnQeqpxv6
	kwZzDdNDOUxH/+KJLdYan37dZyYHn4+vLuz6YHOFy4QevdaCE1BMnoTWYGMmYiS+SuQPzJXsoGvD/
	Bw5sm4HsWBx7OyCvj6UNBoBM9sJKZ3sXZswEBJwNNpY5LPjpwvyYxhC1TL/LOfSOjUcONcblTaZ6l
	5OtxS0wGqXNOHnY7Aq6fZ8KQw4jVqdtFXPYllW1nb3m6Jy1KUv2nCGPpQ4agDKRl2lO7uEwFhf1/Z
	FgyD5e0fGdmJx68l5HqEejj4mVjwWcsi5o7WsaYe43rTYi2eO84TRNRMqlXXcifxhK+gFA+BeK5sy
	0cZts+Jg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sXIA6-0007JO-Bg; Fri, 26 Jul 2024 12:26:58 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sXIA0-0060hj-Nh; Fri, 26 Jul 2024 12:26:52 +0200
Message-ID: <2ecb3f66-0806-4854-b2ee-cfd4845949e4@rbox.co>
Date: Fri, 26 Jul 2024 12:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 3/6] selftest/bpf: Simplify inet_socketpair() and
 vsock_unix_redir_connectible()
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
 <20240724-sockmap-selftest-fixes-v1-3-46165d224712@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240724-sockmap-selftest-fixes-v1-3-46165d224712@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 13:32, Michal Luczaj wrote:
> Replace implementation with a call to a generic function.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Patch subject is incorrect, it should be: "... and
vsock_socketpair_connectible()". Sorry for confusion.

Michal


