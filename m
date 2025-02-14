Return-Path: <linux-kselftest+bounces-26651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CBEA35EB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA8718878A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C2263F5C;
	Fri, 14 Feb 2025 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IcI2eyFy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908892753FC;
	Fri, 14 Feb 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538810; cv=none; b=oo2KvAvEPsAKrsaKSTdtFcZ257zWzO4mbzh3/RFrsdlGnlbhpe0YLrPpZRJeYTIREo+5uXLR5ZKwL469vtg82VOyJFeGjG3cX2qDvrOFYSaoiIi2kzWJRQh2aY/pReKb4+jauANM9LpQBF3oOFs8nm6l/x3qjK39FEb96amr35Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538810; c=relaxed/simple;
	bh=0AlT1O7TrgsvxUKgar6f2gcLwXNkDq4nO2XZNybwd+g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V/vaVF8fHkoMF8cwmcCcYC9pJttoDevmqX4ere9D1zOplXsmS59lSLkLBB+PfmgB0gAzew7g5SluH6HNMnAypTfvz9cjJL0ivR4cHUCCQjo0lsZER7Fb1DDdIgIoXw9ZC6j1KfpbYjciGp7crW+y69/2M6vTQXCNKivETqHS8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IcI2eyFy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tivVL-005YOe-Oy; Fri, 14 Feb 2025 14:13:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=V/whWYHcOSkvvULaaimZjbjRTzvQ7aYNv8+YZm5uC2s=; b=IcI2eyFyJowLwbk9JUQTWm/Qkb
	Mza1k3QZTmQZFy3F4YZ8LKts/ISzW7AbUnSB9s5Ob8glVVSmKcyqeadnv7MLv+mTR/Q+66ceh+gKl
	hZh33f0lGmDFnQrw3KA4Zv6MhEIbYOcvHGs8V4zEnKXOU2xjiSm5GMqN4TZY9xw+EC6aSYf181aPA
	AkzLBOtF5I8p4145aLLsAFq4f6/wbFyaeuKultByPDSdN+pITbL+8oBDxrrALIKRP9dZ7D0Cz6ts6
	KsaNI4KPokHv0EcU6jXcNI+j3imQ2MVafWxHaHycX7Dfmd35qeu5S3NksKBuBIZiByzWKa85vrxCE
	OfDikubA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tivVJ-00007b-TW; Fri, 14 Feb 2025 14:13:14 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tivVB-00Fbkn-6w; Fri, 14 Feb 2025 14:13:05 +0100
Message-ID: <d1e1b325-c328-410f-a530-f5cfc86ba753@rbox.co>
Date: Fri, 14 Feb 2025 14:12:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net 4/4] selftest/bpf: Add vsock test for sockmap
 rejecting unconnected
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 12:58, Michal Luczaj wrote:
> ...
> This does not test datagram vsocks. Even though it hardly matters. VMCI is
> the only transport that features VSOCK_TRANSPORT_F_DGRAM, but it has an
> unimplemented vsock_transport::readskb() callback, making it unsupported by
                                 ^^^^^^^
Ugh, read_skb().

Sorry,
Michal

