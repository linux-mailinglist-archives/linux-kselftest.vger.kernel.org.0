Return-Path: <linux-kselftest+bounces-8760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42A8B072A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2A1F22173
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DD15921D;
	Wed, 24 Apr 2024 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W5M6XgWc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8F158211;
	Wed, 24 Apr 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954135; cv=none; b=Eo0ug7v3m5W0Jcr2gc1BeCNYs2bJurckkUjkGH1WR51wV+pHQmKZaq4qGetd9vJ5p/ckpst6VMTSvS4B5hsU5fiIkjTUb6SJQD7vZqgW0G0hFAkQKDhagX1xgXjF1B3Nv0mO4tA7n+HUBTyG9NphheP05pjAwTKUHCfTy2ITA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954135; c=relaxed/simple;
	bh=S+8tLFz8PqdpmPk9GLNuV9GGLXz9ZgJvD9u5g+3nVz4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=G02ayHH+0dbX3pR5utmcKISz+gCumIZDhKoZCrRPWJew2p2FU2H5Z5g6k5IPj02yXKmdtfLShA0xRGHC/hAkxCfDYRbCa6ZNJAgfRfcLHOd5Pjqe4KGb1/Z0wHhVPRfnouSyVCzIZ3i9HZy4EAkToo8br7HMRpsZed1JvhEl68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W5M6XgWc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713954088; x=1714558888; i=markus.elfring@web.de;
	bh=S+8tLFz8PqdpmPk9GLNuV9GGLXz9ZgJvD9u5g+3nVz4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W5M6XgWcQc6NXXpuPIsS+Oi3sjLW++hq1HDl8tUfSqkQjZ5yy3ZFhJbTqRn/zEUt
	 cdSISmCgYgY8mJce4JIgmjPdHeqKXyPMlmSNeBrt446rqdgFvpoz7YR4IFTMk033K
	 cx7UnhDlDawodbRD3EPM25VmmNJNArxvcJ5mVrAXZevs9xxnf4wD3VePOILWHS4ah
	 EGVW0F0rImyKsWFzwCYZ2M0GPpZrswv1goFC3N9QtrxStelrcKjiLIS//Gn342RPX
	 p2o+I6f7x/Vh8TzKTJu7cQ/mFigI9W+RENw7iHA8UAcTWgh2hbdGuWN+2DX1xA3J7
	 P+2FQyWxVUG8D9CZtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1s7VBN2fK1-00TV25; Wed, 24
 Apr 2024 12:21:28 +0200
Message-ID: <ba66425f-d164-4c95-a5af-4b8fc7bd93fe@web.de>
Date: Wed, 24 Apr 2024 12:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240424020444.2375773-3-chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf/sockopt: Add a null pointer
 check for the run_test
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424020444.2375773-3-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KC6bNGqm6X3itQnerJETpmr4GAAO8pJRrAeWhMYeh8rhXZtT7ln
 gEOJqQMgnHXenqg22lUjHfm6UKnKN7DpfcDp2WkY+arEQ1GxXKQ3GCyblAhvv8/c3yNS3lI
 0+TMfcMXcfYSxoxWmlUE8IW1DBAiAzqt/kHoPT8yG+OvoFBqBNMzAwikWUrRpkkUDN+SLO0
 /hLsQV33Y07Fcj0Qr6ucg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hJUp4csJDOQ=;KIkK5uVgFabHMkVvLjvlayCilyp
 Zzdkeze4299HSKaYXMVNIoFgQPKwroFjH0BAh+0BsKnkbKTtDwXpDA1sdmvbUgu7hk9buvu1C
 DX92oe3A8dFwQbpzKv4sjMdLX/qV+q5O2ra8+uuIGH+L61BU1Qyrw5qHseO0JdngndFKCPuh5
 OmztHZSG1XjEYFfPuoSZl/AtYyZ8+K+x1wAeeXjKkTcxdXoph97EdYQYCMZwVtS4kastsiUqn
 KgTcd06RdHLhmaNZH9JOk/AGZ1/79Mm5Ra1jawJqV4GeU08Y9covCfHulHElpJBNjVoOBOdIZ
 Ro4bbq0ytbcINtFO2/Xx3QM18JxBqJFxu21/MYk55kfVOY2rT4M11jHhJtYzZu0ERMP4AjMJE
 6w7vn+jAVbAKe8vBsYLQXRpBLUt9lJ5RT8czoRKgff9y90IoQmJcOHz0qokJ4gr8HkGdFUrjX
 sNgM4Q7yycl1b23okDV2IWU9YM8+XkkgLjtGwQqqadAC/zvuHnIFn2+G93QmtleTwOU8/a3bu
 73GIu4fu8W6NwzZwLQBVFcDpLKo6eIv/oUAhXTpEAuV6Vj7iQzrxyjXIKetbWSQVtoKXCQVPo
 Te6uDYfY08CNqLzflLuCjnGKrXEoCM5JGGCwYsJkPT4N0hgk9iFGbpLHgkmM+7cCQktOSggit
 Kgw0Dtj6PscxaF4GraezkgRc+39Pk7Mw6nFyRgPUNKpPdmQFM5KErjtn5IDpMVKMCgHcTEI9T
 xS2H3clKTtPcoAD+9QYs82KcJKeQ8/f5wDpT+Zu5WdyoQqqojzuUkuH1RF7DualhA5nLdIcgc
 IV+MizNFTlkZfvTlw+wC+1gfAlgukK/m0wCJ6QwIbFyV0=

=E2=80=A6
> This patch will add the malloc failure checking
=E2=80=A6

* Please use a corresponding imperative wording for the change description=
.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


Regards,
Markus

