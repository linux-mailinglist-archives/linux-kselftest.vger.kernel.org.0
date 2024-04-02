Return-Path: <linux-kselftest+bounces-6999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCB895AA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2BA1C22BF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E315A490;
	Tue,  2 Apr 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3JwUknJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFF15A480;
	Tue,  2 Apr 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078804; cv=none; b=CPdhg0R1LpFU9N42syGVEK5iZBNyXEf7BZV1YVT7g9/H+ygH8/diONUTsHlClhrgAZGQZXlPsAIon4oJdzYRbcN34aUm2+gCK8zlJV+rPtZ00iI/CUSMI7F4v7rbKp4Akc1hjbqmgB6YOpWBuGg1Kts+Uxi05KQ2Vf+oDVdqHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078804; c=relaxed/simple;
	bh=/LlWi+nHiVaYoUcMo4r+W3TZ9IHhmss6ZVAXDoL8A7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzqTfWXqysAktuMFT+XxP/C560SV+XbXpOEC7NLxWAcOkIAOu5FcRyrb08MZ0TxYLelXAEnQYvzw5fATfbo8yT38UNHTJjHIoUI6DiEklxKQXGE29vYPW5upmEuQW5CEhaAEyYbWTdVMQNPakCFJjPzLWQUuLuOmeZ6d2LxU3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3JwUknJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AB3C433F1;
	Tue,  2 Apr 2024 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712078803;
	bh=/LlWi+nHiVaYoUcMo4r+W3TZ9IHhmss6ZVAXDoL8A7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J3JwUknJYBFaMhfin+6JxcTBMMUDzyIsfduzSlf+yV2oH/JKMkVQwLcJ36ONuH8Ky
	 zaFm54HfZk2yXJ39lzqLEKb6T1QBBYZ4tQ3kf+oz7fT7fSPCKng0W4v/TFuXfW11+V
	 9hWQQhGxLNMUVVOSlTCyU+nqP5DAL3jqyyOjYsH4coUP0316pxmXRa53Kgeh4BY0MM
	 Gxz919WC0LyRAA5JOrZn96Y2FC2nNXbjVZVYLl28gjBsNd4Yu5twNx3EhNcmbgLuZK
	 5K1K+KSzqpHxtodXRSpPEbOLCPagf0VMdxj0YE34th2Sq6Nd4Yf4ZS0rIuTiM68n4d
	 aifDRGE25PfDw==
Date: Tue, 2 Apr 2024 10:26:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/7] selftests: net: add scaffolding for
 Netlink tests in Python
Message-ID: <20240402102642.65681bf4@kernel.org>
In-Reply-To: <87il0zith6.fsf@nvidia.com>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-4-kuba@kernel.org>
	<87il0zith6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 17:53:41 +0200 Petr Machata wrote:
> > +def ksft_ge(a, b, comment=""):
> > +    global KSFT_RESULT
> > +    if a < b:
> > +        KSFT_RESULT = False  
> 
> Hmm, instead of this global KSFT_RESULT business, have you considered
> adding and raising an XsftFailEx, like for the other outcomes? We need
> to use KSFT_RESULT-like approach in bash tests, because, well, bash.
> 
> Doing it all through exceptions likely requires consistent use of
> context managers for resource clean-up. But if we do, we'll get
> guaranteed cleanups as well. I see that you use __del__ and explicit
> "finally: del cfg" later on, which is exactly the sort of lifetime
> management boilerplate that context managers encapsulate.
> 
> This stuff is going to get cut'n'pasted around, and I worry we'll end up
> with a mess of mutable globals and forgotten cleanups if the right
> patterns are not introduced early on.

I wanted to support the semantics which the C kselftest harness has,
by which I mean EXPECT and ASSERT. The helpers don't raise, just record
the failure and keep going. ASSERT semantics are provided by the
exceptions.

I thought it may be easier to follow and write correct code if we raise
ASSERTS explicitly in the test, rather than in the helpers. I mean - if 
the programmer has to type in "raise" they are more likely to realize
they need to also add cleanup.

But TBH I'm happy to be persuaded otherwise, I couldn't find a strong
reason to do it one way or the other. I have tried to integrate with
unittest and that wasn't great (I have one huge test I need to port
back now). I don't know if pytest is better, but I decided that we
should probably roll our own. What "our own" exactly is I don't have
strong opinion.

