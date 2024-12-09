Return-Path: <linux-kselftest+bounces-23013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCB9E8F7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608461633C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6F216E35;
	Mon,  9 Dec 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ejwH2zdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E04216E11;
	Mon,  9 Dec 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738090; cv=none; b=jrk6iLxPtEtpjky7STY8dITaFcX8DANiH+ptGsO4EgBG6TwYlF4nI+bIhIcxQAtinAh79zNlzuPg3oc0gH90NJ57v+yy0Z+nUPtji1fieGCB3t35y6/Tfi5Q3DV2iz18yc1EoEEaTLmATauyDdkCJuGZxTS+DBwIGPUvPKiQ9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738090; c=relaxed/simple;
	bh=clkDD/hFzOpTf+A8bULiJOQ+kAJSyG2C2ULzsTu2MA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdqKzYTNi3l2J+BqX8dzPVOgz1t2MpijBHuriD5CDiXbZnohL4rusafo88Mm/cB2O5mVMw2meQ//m5jrmdWOwYTR6NOv3fWDPyHmJvR+IMiPv8u/J9CHFCb0Bqy3a3DOb8l1QXv7nO2/hOfpdiR0yIlr4Lrjnb+odactuUMqKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ejwH2zdS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tKaT6-00C3iJ-A6; Mon, 09 Dec 2024 10:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=tK3XrgO4rJBXU+NGoXT2L1GQ41DfzfPq/M0ZOmM/Iww=; b=ejwH2zdSIHvMkdk9KzA+Cp4fqP
	Qd/Hb8hwU52NFWjBiF7pRozGKEyOQxt2FEEqq28K+r2lFYdK0YzJQezePdh5pqzkP6LSo/huGbMnF
	JDHDA/XrchTB4VtZ7WpGJ5wWHs18u+fH/EJqlN56QUaFVfew8xh6Ao5Gpa/wPAXpjqdTmNE9sCFbd
	rYhcy+tlUTjZD268Ul14wsCtMXxU9yJA8bCRn8HXZ4tNpKQPLleJ25WEn+s92dqsKf7Rex6wvBf5I
	GSZSvDKWdJi2wSdek35OOl17/8rF3OlZGwPAOn29derjNboFBF9aHT/FBqN1IshXUo9mFK1pmTL7J
	PwLZ3CMw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tKaT5-0000ju-6b; Mon, 09 Dec 2024 10:54:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tKaSr-005Bsn-Fk; Mon, 09 Dec 2024 10:54:05 +0100
Message-ID: <046f2c47-53c7-461e-a5b0-8fe4ae0faacc@rbox.co>
Date: Mon, 9 Dec 2024 10:54:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: Fix update element with same
To: John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
 <20241202-sockmap-replace-v1-1-1e88579e7bd5@rbox.co>
 <675684786d66c_1abf208ea@john.notmuch>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <675684786d66c_1abf208ea@john.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 06:47, John Fastabend wrote:
> Michal Luczaj wrote:
>> Consider a sockmap entry being updated with the same socket:
>>
>> 	osk = stab->sks[idx];
>> 	sock_map_add_link(psock, link, map, &stab->sks[idx]);
>> 	stab->sks[idx] = sk;
>> 	if (osk)
>> 		sock_map_unref(osk, &stab->sks[idx]);
>>
>> Due to sock_map_unref(), which invokes sock_map_del_link(), all the psock's
>> links for stab->sks[idx] are torn:
>>
>> 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
>> 		if (link->link_raw == link_raw) {
>> 			...
>> 			list_del(&link->list);
>> 			sk_psock_free_link(link);
>> 		}
>> 	}
>>
>> And that includes the new link sock_map_add_link() added just before the
>> unref.
>>
>> This results in a sockmap holding a socket, but without the respective
>> link. This in turn means that close(sock) won't trigger the cleanup, i.e. a
>> closed socket will not be automatically removed from the sockmap.
>>
>> Stop tearing the links when a matching link_raw is found.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> Thanks. LGTM.
> 
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

Thanks, and sorry for a missing tag:

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")


