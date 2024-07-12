Return-Path: <linux-kselftest+bounces-13651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D098E92F6AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864CB1F22B37
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2213D62F;
	Fri, 12 Jul 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AIEO+UKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCD12F37B;
	Fri, 12 Jul 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771607; cv=none; b=fXmjToat/7PaGClFxmKwtX48XEXoP5RdvEw05kbDPMfuz5MbauUNEutFixDxhSbA7P4qsK2Ewc0Ay6+V1TLxJ6NC5CrgQX3qAWIsyP3EQMXT8nd0oXmvXvE8Ot3vmFxWdN3VfUZd3BHQAx/nPwJb4Ltli/Hmi1ZRoy9k+5GZ2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771607; c=relaxed/simple;
	bh=0/rwx0Bqtb+ua3ORpNZKSGNN0rqbdcUeTrf3gRq5VMc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=EON1YS5u1kD92iwUqT23X19ihGy0mfJLJgPtWLwrU6s1SZ2wN799jnbnNzwmW/masipXcOZQ1eq+HuCiEkO9GJWLebmGUSc9pN7nlptAe7+Y1Atk8XOFHGUUwjhasuSxPuwE8bVsdnIN1TD5Tg2lRwAWhEQzwLdRfmZE57G9eYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AIEO+UKk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720771551; x=1721376351; i=markus.elfring@web.de;
	bh=0/rwx0Bqtb+ua3ORpNZKSGNN0rqbdcUeTrf3gRq5VMc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AIEO+UKkNGIYT2eD2jM807IZeCZUQRpKVRFxlNOsFwbs/faaedvj/OKLCqQKnGsM
	 /eTa1zc5XF4OiKmU9+Wv/6IovOfTh8lVWFaV41InITw7TV4uLIiI9lKTGsNTgHnyN
	 XKvwTx91DTUAeTlp+Fh7uzlHK+P6Ec7AgIpWy0R/rmqzBNH8X5tFH6WiqFtCBWpV2
	 XC6xXBfZP1K8cyrOXV/pl+MBlY1LQJrTk2Wk4uMaqntK2NZRYQC/+DOZRgZIBVZ0c
	 85cOcGYPD0TnoKFlDmV7AcOiRwBhfy8BRA9epl6bu7yFbTY+8eGIHF77qlcZlGpBh
	 AN9tG0Kw+On2mYXglg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1sSSGl35Kj-004Dzo; Fri, 12
 Jul 2024 10:05:50 +0200
Message-ID: <c341e275-4fac-4aaa-8117-55b654c5c006@web.de>
Date: Fri, 12 Jul 2024 10:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Sowmini Varadhan <sowmini.varadhan@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20240711071018.2197252-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] selftests/bpf:fix a resource leak in main()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240711071018.2197252-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oUKZu+vu7nh0tSLh70wUSTHqD7mlZPuZbblnC97isWPywN3CTY6
 MPLrEhxWiR67ygcNJpTwqVGA3labNhi1dKl5KFpKV+GSKPatdSX9jQu5BU7Yw41pl9L0khE
 BS8SItbfWWC0KLCxFfKS52Qz0qoPRs0CPBeHY9tijMnQiK2oPcUKDdvr6SCBBBCkMik3Dcq
 WJFX2Hct0JyLaHPWty/rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HgQa9a9Ceu0=;kI7GpdLvjL6wxQl9enFajHXsUOX
 U2EUwR5u25ajvlySVYPhKLvZ9BGjkGkLfMWmUkNjRc/sP+IElmi9GqFV9Hwe7GHLvbKD2ce2D
 edhrCbrU0iyImnQp1Bneb3mO4GeuNEg/xpHyqp2fvroX26ktj6WDyvZPwV0s1JUjjlxNah1Lq
 em9Uj7sCDdcUFp+Zx5b3N5fOC8e6M4qwnupF/LNd8mc1dbZOvvFqPcd7IsZ2pZjVw7yIW6gsx
 6RNRV9TuZwiKRlDHsUnjGoHaSi+t0EJ0DkJiv1yanVyGm2ukO2Hs+sJwqCN4AVL2XodilUdOZ
 nHs/kOvBbLwBS48eGGT/ajp277hvAYh+Lxji+7m9Up22FcOHyP1uvdzrOZhrlkNkMIodvOwzs
 ZRAbmfCsT7siMvnj+CNexjmUY7dN7fFMCnG/sTo3W4/XD/XR8G3qAwREp4rVcpJiCwL7LFEgO
 cT2sO7po4wdlXPcBTKP6SUY23FSsVnnGIc93TbLl+JXCjfAOyj6tQRjwSwmFSctPrHdbMdfkX
 v4qOUeH6pJbZk0QAPn4LTd5kPyAGSHHlelzdbyNBY92AAeLzxPus4wgg1ubHR971HbLTH0I+d
 gmyGP58sM5lSz8Pxe67v7JnBUY+5JDD41O5wgJtuVCqr/axGDSqRIm0akxQ020dpJfUNLuyv+
 rceBz64i/G9Bf16NHpMM9e2+qAxadgM/eSpxAlNMuF2yzh8vzTI0PQF+QBXXvZi+yQuDmHFo0
 gKC74Wjk4xktcIJVw6dWZ3xvOUHF6sB0EZzjxXQ7rwsQXj1A0JnouVEV8ZkHsVKHc+szmZnV4
 JuvYPkmGF+VuI+aycuuEkngA==

> The requested resources should be closed before return in main(), otherw=
ise
> resource leak will occur. Add a check of cg_fd before close().
>
> Fixes: 435f90a338ae ("selftests/bpf: add a test case for sock_ops perf-e=
vent notification")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Please reconsider such information once more.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n398
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv6.10-rc7#n5


How many source code analysis tools should be able to point out that the r=
eturn value
from the call of a function like pthread_create() should get more developm=
ent attention
(also for discussed test functions)?
https://elixir.bootlin.com/linux/v6.10-rc7/source/tools/testing/selftests/=
bpf/test_tcpnotify_user.c#L122

See also:
* https://cwe.mitre.org/data/definitions/252.html

* https://wiki.sei.cmu.edu/confluence/display/c/POS54-C.+Detect+and+handle=
+POSIX+library+errors


Regards,
Markus

