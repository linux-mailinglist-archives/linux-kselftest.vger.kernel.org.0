Return-Path: <linux-kselftest+bounces-19408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D6997882
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2802846CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36461E3DD8;
	Wed,  9 Oct 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JTieHRHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F11E3786;
	Wed,  9 Oct 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513104; cv=none; b=RrzjCf62Z94gIlkZ8F/6oF1lSoJ4zz6Bj3n9sV1PWQ6aZTUk9uzPEuCSMJ9F2nOCqmWFv5uye2DYhkedOgrpK6qhcegEilytfML+jiywod7ofZCwFx4CO0P3VMbj0dovXm+ULIhhPRoTNMMwMyr+ZJlh1GTS9wDqClgSDbzHfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513104; c=relaxed/simple;
	bh=s16GKP7PIIzYD3NjhkiAU6d8d8MyvTH/H5PWTSkhsKU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=afc8S/76Fa2Q9I3MfBz7o9XpEyrPLXfwkUFa39bJZls6JWzkknuwR9VZCYbbQTlfkjkiF3NyY0JFwu/wnYzPKexAUDU8XciHsyWx9jrZ08XsYC9sbH4mGvrdZDk3+UgWa/rNYk2UpAuXeSLZTPY4ubaVXFVStgosra5XuuZusrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JTieHRHn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1syfDQ-001qmc-2R; Thu, 10 Oct 2024 00:31:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=IBi/mETRE54sSOUeSu5Xs+ajeMs0LsADF1LzwwtI7CQ=; b=JTieHRHn55ksiW920a9adiNGcQ
	WqcC/H16K1/TkPDVf5YkAQQxZTB5aefDlgXeinGOTQfzYsl1Jp8oSmZi+D2cFcZ3aq31SGhtBQPjZ
	6Eegz61Z31dJfC4GY1R1x0hSB/hLhGJymNEvWNqbHlo0GNhdqkOKyWF52EG0qWG+4UrwErkLBgEdX
	pTlMGhBqkrCufZxgXx9eONTxvIQuFQ7iug8oNAc1xpUaWc34cTYxEFeZpyJ7C1ooQ2YeS931y0Zv+
	g3KIKPQxYNhJjGmKM9bU2eN6BJs5n2mdpJmUS8LsllV048ghqCRzS+vGxDamC111aJKYaXnTslU7E
	VgIBHzfQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1syfDP-0005ul-0C; Thu, 10 Oct 2024 00:31:31 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1syfD9-00Esvy-UY; Thu, 10 Oct 2024 00:31:16 +0200
Message-ID: <dc968352-4ce6-46a0-af69-058e29aa0df4@rbox.co>
Date: Thu, 10 Oct 2024 00:31:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
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
 <ab60e5c2-90a1-43c3-936b-10520c751dfb@rbox.co>
 <87y12xy5fe.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <87y12xy5fe.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 11:46, Jakub Sitnicki wrote:
> That's curious. We don't override the proto::sendmsg callback for
> protocols which don't support sk_msg redirects, like UDP:
> 
> https://elixir.bootlin.com/linux/v6.12-rc2/source/net/ipv4/udp_bpf.c#L114
> 
> The packet should get delivered to the peer socket as w/o sockmap.
> I will have to double check that.

Ugh, no, you're right. I was checking the wrong queue all that time...
Sorry for the confusion.

> Thanks. And yes - if possible, better to push fixes separately. Because
> they go through the bpf tree, and they will still land in the upcoming
> -rc releases (and get backported).
> 
> While improvements go through bpf-next. Of course that sometimes makes
> life more difficult if the improvements depend on some fixes...

I'm afraid that's the case for the redir selftest to run cleanly.
Anyway, so those are the fixes mentioned, targeting bpf:
https://lore.kernel.org/bpf/20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co/

> Not sure if anything from bpf-next gets backported if it has a Fixes
> tag. We can ask the stable kernel maintainers, if needed.

