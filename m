Return-Path: <linux-kselftest+bounces-14285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B304493D9DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6266B1F2464B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982F149DEA;
	Fri, 26 Jul 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="CmpbNjeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E559146A8A;
	Fri, 26 Jul 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026252; cv=none; b=b5VjSLSszKXisEInYxZ8GP2tvu3cjL/YV8nR/6Rwl4TCyFRdSgUZUHJwUlw6FtUVp+55d/3XiPtmO6ttRj3s2M/FHHYx2AffXmk1PSdhVCUcvIjweHuXIES7NcERjBk5YXPaonAi0LPFF+KFceHZBiwN3ZcMNAn7upJ33WHNgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026252; c=relaxed/simple;
	bh=ln6JshEbLcepjZxJ/nVYC65kpYBAf5nmkVvRA5OmFf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNLmNNDJyhXRy4iY9ISWQB7fPPP0PAuDmHom75pMI+4Hxtxk0ih3YUM6wgBCT6b15PkyOMdgGj6oQCw8Pc10TKz+Dc9TF/h77ebBWN5S1dKH3grn5pKYixj3dZHRDyuWAaZn5fpGoDUo4VoTqUd6UXDoYluPJ0ZT4juZqQS3gTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=CmpbNjeR; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sXRgn-00FBZ5-Br; Fri, 26 Jul 2024 22:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=/3Nmd6zu5RaZAXZSJe8iELsIdgxLmZtJVkNbN9DE66k=; b=CmpbNjeRNk0EZe6q7d4G+Y1iJp
	Wkt6VJvFn0Z3xMelyizn839FwNKVrNKIMD5K1Dc5YFXaPGCJUobGLGiM2A+P6XUPZP7K0bDs/iFWx
	UYGE1QTJq0e0frg3vS+u6LUNiSSe/wOb3A4/VOHnL3ezZswHfD1jUnnIcn02AbsD1JGJU0M9Ef2TZ
	JWHMsp/ju8zk1d5/TnTAOquKunHUzEYmRJggRUUO8WYq8JDr5s2KNmnrJhTM8Dma6FkQyXW0huknU
	0y6epXsnxaNj3SQRU6T5QOSHu2A/DauKDWfo+hjmLji7mwaRhDW3/vo7AnNwmEr+uwi2UqbbuauQc
	Q/eGB03Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sXRgm-0003q1-CH; Fri, 26 Jul 2024 22:37:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sXRgi-007lsE-8t; Fri, 26 Jul 2024 22:37:16 +0200
Message-ID: <3e2e0a59-587a-4ef3-96e1-8542103dd9d6@rbox.co>
Date: Fri, 26 Jul 2024 22:37:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 6/6] selftest/bpf: Introduce __attribute__((cleanup))
 in create_pair()
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
 <20240724-sockmap-selftest-fixes-v1-6-46165d224712@rbox.co>
 <878qxokqrd.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <878qxokqrd.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/24 19:27, Jakub Sitnicki wrote:
> On Wed, Jul 24, 2024 at 01:32 PM +02, Michal Luczaj wrote:
>> +#define take_fd(fd)                                                            \
>> +	({                                                                     \
>> +		__auto_type __val = (fd);                                      \
>> +		fd = -EBADF;                                                   \
>> +		__val;                                                         \
>> +	})
> 
> Probably should operate on a pointer to fd to avoid side effects, like
> __get_and_null macro in include/linux/cleanup.h. take_fd is effectively
> __get_and_null(fd, -EBADFD).
> [...]

OK, I'll just make use of stuff from cleanup.h.


