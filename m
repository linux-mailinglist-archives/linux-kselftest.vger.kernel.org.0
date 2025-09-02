Return-Path: <linux-kselftest+bounces-40646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D0B40DD5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C47F1B27FE4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7112934DCDB;
	Tue,  2 Sep 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB/utJB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1C1EA6F;
	Tue,  2 Sep 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841142; cv=none; b=bJrkl+ojN70e17chBLHr9BhUgHusaYPYLMTNUwLQQBzGg9l2DM5TIB7e77yqhMCW7BOZs/MCNaE2qywNJWKbPfj74yjiplK9Bfem2Kj1qXDBaLeRfMz/k+PgYvT+JT1TSanNwKjd8VZxZdiH4LHYejfiGmcXxpzW7CdnlF9zLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841142; c=relaxed/simple;
	bh=L3vFT/IdelDACrDSgTsu4sB7gj4eAGW0cv9aqFaXkqo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lbLCEwr3vg4whNVXIquvUmhtI9jATHfPW73S5BbMuTjBQMjFeX7WA5Jtq6dkHXBe1FrOjjdVr98BPb6lrWX7S00dUvRuS4b/98PDI21+M/+8bIaagMjsqe/cNvYgugnxNq5QE1NfNf7sTjRMx5AXrhg+hCrveeMFb27n1TAvdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB/utJB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3014EC4CEED;
	Tue,  2 Sep 2025 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756841142;
	bh=L3vFT/IdelDACrDSgTsu4sB7gj4eAGW0cv9aqFaXkqo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LB/utJB1l2CGLT2DgzE5quO99KtNIWQhXKOf2cTDZ05pV4ig9lIDLl05OiHqSbDq3
	 nnXQadFDjFYMy2am6p74oD3v+6X1kylUmYHMFRfEKgF96sBjJ+pG0rloVVhAwmcavN
	 6ddjsfOuVdh54O9MHj862KVRliN9HDo0imVPDqp46IUAXCCLgKsSMd3fnPsdqkIILU
	 TNB4hRJmZiOVROwYUZZXlWG9/+ectAPG3lulmBngpi7OzgQAHIG2qpsyt00gS46CA6
	 9kC+hdpBPE0gV5LQd5uDM7GI//g+NNe3UWXyIDpTQwAKZHJ9GpKMdGMNA2oC0NPK2A
	 pFnvsTh6R7Yzg==
Date: Tue, 2 Sep 2025 21:25:33 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Christoph Paasch <cpaasch@openai.com>, Gang Yan <yangang@kylinos.cn>
Message-ID: <83d76f61-e8ad-4c8d-b38b-d197cefe4088@kernel.org>
In-Reply-To: <20250902120933.5dbd61cf@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org> <d5397026-92eb-4a43-9534-954b43ab9305@kernel.org> <20250902120933.5dbd61cf@kernel.org>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <83d76f61-e8ad-4c8d-b38b-d197cefe4088@kernel.org>

2 Sept 2025 21:09:36 Jakub Kicinski <kuba@kernel.org>:

> On Tue, 2 Sep 2025 16:29:33 +0200 Matthieu Baerts wrote:
>> On 01/09/2025 11:39, Matthieu Baerts (NGI0) wrote:
>>> This series contains 4 independent new features:
>>>
>>> - Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.
>>>
>>> - Patches 2-3: make ADD_ADDR retransmission timeout adaptive + simplify
>>> =C2=A0 selftests.=C2=A0
>>
>> I just noticed that NIPA reported some issues due to these 2 patches. In
>> short, some packets (MPTCP ADD_ADDR notifications) can now be
>> retransmitted quicker, but some tests check MIB counters and don't
>> expect retransmissions. If the environment is a bit slow, it is possible
>> to have more retransmissions. We should adapt the tests to avoid false
>> positives.
>>
>> Is it possible to drop just these two patches? Or do you prefer to mark
>> the whole series as "Changes requested"?
>
> Your call, we can also apply as is. mptcp-join is ignored, anyway.

I realised patch 3/6 is going to cause issues when running on older
kernels, so we would need to revert it if we want to apply all patches.

But if you prefer a v2 for the whole series instead of applying 1,4-6,
I can also do that :)

Cheers,
Matt

