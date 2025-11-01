Return-Path: <linux-kselftest+bounces-44579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51BC2838E
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558A14204C4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E422797A9;
	Sat,  1 Nov 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7Bpn5tI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B401DB34C;
	Sat,  1 Nov 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016393; cv=none; b=qsZdEtSo7nAHyi01OnQmdc/L8CfpwMVjh5DjuP78Wo88g6E2Z1q31vcszuaBBdBnKNn/lk/74UqRy18NjtHdos90WQQwTugzWNolOi3sbmPPZLKP0fzdf3EaOzkIs6m31j7dp5/YaDdif3hGsKAMPDhrYpSuIbO+BZSsqrQBFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016393; c=relaxed/simple;
	bh=tXz80GymAFDc9PJPdp7m4Y+/zOrosc0Xr2xnW0aOzG8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q/N81JeYL87Usyeqxzv+J0dL8RxTxjD4Cp7OTThrJQEAHlr9z86ZH6izGpoijvuZ6/AdyQdSqKSWtPXzuWBgPezxymrq53VMsdWgpvSpWrcuPO/aX2XQLD6EXrLxWTKS9/+fHUpx0STxAAiu2YZb04HXouEMsh8bGiOPIPAWxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7Bpn5tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A3C4CEF1;
	Sat,  1 Nov 2025 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016392;
	bh=tXz80GymAFDc9PJPdp7m4Y+/zOrosc0Xr2xnW0aOzG8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=g7Bpn5tI3pzqyyFyNqNynrp91wtCotMSjIyaz6Ev7bz3PcmpJQW69lQ2ult8Lxcwo
	 AK5m8cNbypT81m59r0eYiJgptWpfSTr0E5JtZkB9oJfgxftExL9nWQMJvnm2NEg0w/
	 UzLoTWQnkjw08VMOVMxTe8VaRf7WNU8s3nkTamL7OnZPJ7V2otvfHI2XM2IW47e3ac
	 3NEnbFF5spWBRpKgz39js7j1NoHOh5y5ZSbwssNlntM52/M0Fvh7xx8xa8kMdXVyCy
	 fgWaDa+orbxJUj+GbpTZ9a9TPndvWJq3uDfCzjGUcGzCOpZ9SVkgxpyga1E7jYLe+I
	 qAyqYLao8WbsQ==
Message-ID: <5f7078cc-dc32-4d7a-888e-922efcba43b6@kernel.org>
Date: Sat, 1 Nov 2025 16:59:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2 0/2] Print map ID on successful creation
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 bpf@vger.kernel.org
Cc: alan.maguire@oracle.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-GB
In-Reply-To: <20251030210655.3938262-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-30 14:06 UTC-0700 ~ Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com>
> Hi all,
> 
> I have tried looking at an issue from the bpftool repository:
> https://github.com/libbpf/bpftool/issues/121 and this RFC tries to add


This is not longer a RFC :)


> that enhancement.
> 
> Summary: Currently when a map creation is successful there is no message
> on the terminal, printing IDs on successful creation of maps can help
> notify the user and can be used in CI/CD.
> 
> The first patch adds the logic for printing and the second patch adds a
> simple selftest for the same.
> 
> The github issue is not fully solved with these two patches, as there
> are other bpf objects that might need similar additions. Would
> appreciate any inputs on this.


What's your question, exactly?

Thanks,
Quentin

