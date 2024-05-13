Return-Path: <linux-kselftest+bounces-10131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB88C3CC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864BD1F20F02
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861C1474B2;
	Mon, 13 May 2024 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JD9XVGjf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0F1474A0;
	Mon, 13 May 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587036; cv=none; b=IF0nOo0W7d3D3kqClvzCX7zHS3s7bY9bmoHBoyl9px0ocfY6m/bsHIbLIn8aTqH22p8A9xfbOp7+fTz7iIgsErH9bdNISP884yKF0Kn3+/MT+jhRI1yTf6ITMkl9y0VDyYuJ+Sv3o2TFZb4fiq/NkoMhq3vvH/QW5au+NRph4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587036; c=relaxed/simple;
	bh=b2qyThKrEXROa5UsqCfJs5RqQ6LvqWVkpGEAlf5h7zo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YjkBVway6VVWvGq5Cn5VBXewdzbYEG69Vl4++Eo/HzhN3nxupUZaFW8sBWVWNFIv1nOl3kCrOwGTCqbaWK2a5gOUFS+NNeHbnRsOvN1iKTE5JB4kB/zp7iX03ZQuU6etgOMa3tv276tJ3BUenDH/lzpa3kltfyjS1R+rDz5pWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JD9XVGjf; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715586792; x=1716191592; i=markus.elfring@web.de;
	bh=afouwgxXsDL3wwqwmPj0DrSGZAI4iej4a0NwiQc/opQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JD9XVGjfwWsXwGsMNEne9Laq2+6O9huzgUeHey/rSmtqC1sDyiZw0hxTqAFObbV6
	 MhOQvONjmLNumTiKm+lnuBCEd6R7gZ9Lof7IV0AUm9mgQej4jJrb+HJmgARBhDnxs
	 UKUYvPK8mHAGrcdbybejEcigTdtqxhpygmzq8lyi0HWWWpIx5W4pSA8AVNihKvso8
	 1G69wmB5F0qWhJg/kIsjWAc3gQbgmPRva2bZmuO76XziGwH7a41vJlbWYnyuLjMPp
	 Pe6kbekSxDg8YeYjFjkTnUkNnAi4sQTAuFhx3cxOsFIHT4+OGEDCcfe5ypdWY9yI6
	 rNltlO36/0IrtKMeDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JEu-1s9BNi2VuE-002mNB; Mon, 13
 May 2024 09:53:12 +0200
Message-ID: <5dca19e5-6dd2-40f3-ae54-a4154e7d00be@web.de>
Date: Mon, 13 May 2024 09:52:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>,
 Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240510095803.472840-2-kunwu.chan@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add some null pointer
 checks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240510095803.472840-2-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0qk556X1UoKRP1d2KUauvi0VtAOXwmbAC6L/EY2Q15ZO1iJRJbc
 d77Fky6GThq/k9gouG6fF5OqxAIIpSXeG10tGR0S5QoBNvLPYG2wQT6YO3Qk7igdkuqqk4e
 ZxadIQ1wbisRXc93q7N7bwqh9e3MLrHwwKhOfSrKXtiRMsMhq9LnbvOfH3WhhL6ElMcCmAA
 4yvCu1pRWJJIOj6hMtH9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ul5fiYkhqWw=;Diwge/DZwN1fc5Y2JRQzn3zMuVW
 6Cl3u/3RgS0oPiw/6ht2sQxev4EFBdf+leywX1BBO6WQ4KcwZCzN7pABbqVbIvDXnCYRK3jLt
 /srMMw+mJm2Q0KQzj3cqZIBfAcIR/RI/3CYtNJ1IJgdBDB0S3tzDkPm00yzaeu2plrfyO5to1
 tjZkRH5y+o2S0fagXOUsyKmRtN8RJtcJGHWe0AxAqgnMKPQrkSZRZes6AqBpT9aXPu0MdQSbh
 Ff47a7jTW7SbeS5MQQZcvCfAuTDsbfdKUPbVJTFpV+dypRjBARI+34+d5l/eBx2hxDeXNoMR+
 FVjuKzc5yAt4XT3SBt1zO2wgoswdbZ7bRcks7qh82GJLu0Nju5IJdnYiP4Y+8yfnTrrL81Z6H
 xKqrkyDQxVECSsMovYbultCBK3fZcOAuUGmFyhtAy3JIuHb1pspU+070rD1SD3Ir84ec1DRIY
 IJssxTAaabqD0q/9pijMDbLe3re2HBZDgQ4fnjeJtZWTPwOjKJxMEgK3cO9mkitQMYaUVMMgd
 x6J2bl0jRz/rjHB9AMxRrkmJ8bF1dNF5c2mZS6+dtZBuwSs20+V46yg2lrYcDi7ch+uiDG5nt
 mFXko9o4+PQdZI6FaHuc9fpCedvn3p/tn9o6GsgKc5CeeC9wFZrTdn4dG8mNekPiqrKhElEmD
 LRV0TBl3B1AjVOE0p6dBbmlS39hSFpVdSvvFyRg+ty3otrdAWvyoAELJfKKMrMhc7flJW5muE
 CLW8Z+g1uQUCandg5gT04LzUiyNhbBXD1wd+ZK9eX9gcFVoUfIxyApw7OwfzTK/gTrxgl0z3a
 XOwM3SelmRf7DkjQbk5uWgcqzuqCSceiZbOsltYfgsFBw=

> There is a 'malloc' call, which can be unsuccessful.

                  two calls?


> This patch will add the malloc failure checking
=E2=80=A6

Please use imperative wordings for improved change descriptions also in yo=
ur patches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

