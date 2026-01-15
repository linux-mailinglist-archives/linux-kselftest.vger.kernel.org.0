Return-Path: <linux-kselftest+bounces-49012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF81D24366
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E13F301DBBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002936999D;
	Thu, 15 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcLisfuF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78013AF2;
	Thu, 15 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477043; cv=none; b=HS8NrFhwhWLRHu86yb1g6YXsLfya9rGOBch+dj0KjJhRw0+gf730uF89SDtEepKXFQA1jmTMs/m/AFOwXaQw6uhPEni5iNqfnJ0PFZxJ2KlJzfFwccu2r6kUKlUTHrJU7GwLL+QHjZjxYWLx9LatAvWiDGqKVMw/ginXNFjHzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477043; c=relaxed/simple;
	bh=vkIzwfRGqIwgDFLWaaKZAZ1qPknhurUQ4gb7zX9UXi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNC3/DAvG+Nw4gXrXedOfpAjpjnHJyG0RoUklTng8iNR/V3jspVxxFZZzvgPmWk8MoyW9fGh2I7FEsRS/uJc07/BDcZkRJij91/m7RXc5/cpoX6nnycklTeXFnVQIkxOeGzqWXJDjwdSyDvbFmoaxzuFyNmNldrfLUyQU6y32kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcLisfuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7906EC116D0;
	Thu, 15 Jan 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768477043;
	bh=vkIzwfRGqIwgDFLWaaKZAZ1qPknhurUQ4gb7zX9UXi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lcLisfuFMJNu7Mi2IoGsd+OgYrKXZFdBeotwKgmhiJr5pH6GrwMUoVVsAMGHG90Ni
	 DE2I8Gbj6LOpYPeEeKlFc0b1KH2/urzWQzyfwDhFHzRo2+0fmwKOUV8V8vy1UPUFCU
	 BRycbm3BvNCOhXW/Y5ZhlPFPQNvWVlfLGCA0rzsiquDzcQvWYL8Ycrh0j63NOwS8Ih
	 A6xTSvGa+ppDf9l3i3KPMX0pkjF38veJo1/EgPQ+C8sItaAIicfrEJyb3pOer4E7UD
	 iPeV13sgTEoMR7s3/kxsXZ2oON49VqWJH1Cj7w7txrWUOE6dCqEf+sQddnxMXWdjLp
	 6fmhnn3kgsImQ==
Message-ID: <cb87916e-223a-4a80-a372-c4f930ebe243@kernel.org>
Date: Thu, 15 Jan 2026 11:37:19 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: remove converted bpftool test
 scripts
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
 <20260114-bpftool-tests-v1-4-cfab1cc9beaf@bootlin.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260114-bpftool-tests-v1-4-cfab1cc9beaf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-01-14 09:59 UTC+0100 ~ "Alexis Lothoré (eBPF Foundation)"
<alexis.lothore@bootlin.com>
> Now that test_bpftool_map.sh and test_bpftool_metadata.sh are integrated
> into test_bpftool runner, remove those.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks a lot!

