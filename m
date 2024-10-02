Return-Path: <linux-kselftest+bounces-18865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9698CEBE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 10:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E4F1C2111D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D37194A75;
	Wed,  2 Oct 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BrLVF9XM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D470194A52
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857691; cv=none; b=lRLAJ5bBuZtg3b4TTccz3Db7fwQidKQc1LVrUqdKFuMmor4krjYYYpkDJO6wmQUs06VYxMMZEhVIyfFAiNthc8mRu3JE98m73e0R816+J20Q2jUEzZ8ZLd3QiHr7XsGo0QBdFBpFlYQIdFAuNGdbNOuHJH3xveHLfy1e+s/dtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857691; c=relaxed/simple;
	bh=XPeH6vkyj1VLzGltpfrOTJ+H6dt17+dZU2/WLNRc9wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU5dy21G7WyjYyWdRvNN5sxrg5aUYIOxE64RvlnFOpT2yLzVZyyIAXcTNN7U1UhaQDhnTN8H1t+JbYTGntYaQcIP3xkXS9wFKh5hDWdCMewFwQMYb6XJOI+7vnvfTwin7ne5C4az85sZNNN6s+ersM93vNDrQoDuSFu9A77yDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BrLVF9XM; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1svui7-007Keb-Oo; Wed, 02 Oct 2024 10:27:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=3dzYHqUhVpEdv+qGLjHqmkMkatBIOm9n+RLyyWhSE74=; b=BrLVF9XMIp6T+yVHjiJ6ZCprlv
	/eywjn10dpMnEcAUuvqAJ+vEHueM3G0WZ4ZwCJM5N9gfFlkUVSXbuXJCu9A05vxQJcKwtr80Xf+Hh
	Fat72sipZc3J4OyHSu73cEHt0DKbCXuhzS8S5ki86NwXQPRlEU1+Mez1nRRKXi0qAvorl3Lo55mz9
	LMFwYwdMZJeEAk+km+WYPH8+GnSeT2zIY9NktUNazBxtXJy1G/sMZGFu2aMdLrC5g65tXpvOe8aUt
	kr9546Z+w7wB49+eb5OOouA59yNXvqqHfvRndzx7y7p7wmkL3x7ibEaKQJ5x3HdpjmswO6cLYyk/l
	RhL7pdJA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1svui6-0008Fz-MB; Wed, 02 Oct 2024 10:27:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1svuhy-00G1GC-5e; Wed, 02 Oct 2024 10:27:42 +0200
Message-ID: <ab60e5c2-90a1-43c3-936b-10520c751dfb@rbox.co>
Date: Wed, 2 Oct 2024 10:27:40 +0200
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
 <e78254c5-8f2f-4dc5-bf81-401caefabdd1@rbox.co>
 <0d4edea2-f989-484f-88bc-d8fb6acd7572@rbox.co>
 <87ikuh78z5.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ikuh78z5.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/24 11:15, Jakub Sitnicki wrote:
> On Fri, Sep 27, 2024 at 12:54 AM +02, Michal Luczaj wrote:
>> ...
>> Here's a follow up: my guess is that some checks are missing. I'm not sure
>> if it's the best approach, but this fixes things for me:
> 
> So you have already found a bug with a negative test. Nice.
> 
> Your patch makes sense to me.

Great, I'll submit it properly.

Another thing I've noticed is that unsupported (non-TCP) sk_msg redirects
fail silently, i.e. send() is successful, then packet appears to be
dropped, but because the BPF_SK_MSG_VERDICT program is never run, the
verdict[SK_DROP] isn't updated. Is this by design?

Also, for unsupported af_vsock sk_skb-to-ingress we hit the warning:

[  233.396654] rx_queue is empty, but rx_bytes is non-zero
[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589 virtio_transport_stream_dequeue+0x2e5/0x2f0

I'll try to fix that. Now, the series begin to grow long. Should the fixes
come separately?

> FYI, I've started a GH repo for anciallary materials for sockmap.
> Code samples, pointers to resources, a backlog of stuff to do (?).
> Inspired by the xdp-project repo:
> 
>   https://github.com/xdp-project/xdp-project
> 
> We can move it to a dedicated project namespace, right now it's at:
> 
>   https://github.com/jsitnicki/sockmap-project/
> 
> Feel free to add stuff there.

Not that I have anything to add, but sure, thanks :)

Michal


