Return-Path: <linux-kselftest+bounces-44027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A7C08521
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 01:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F234476B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1E303A38;
	Fri, 24 Oct 2025 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm4QgmxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B22E2DE6;
	Fri, 24 Oct 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348818; cv=none; b=tgas6uLm5wOd4GKRX2vyUJYuoqJSjuxpR9PFJG8hzbybb7p+Lhvx4BrVxLI/7dg2FRfhvBGqUMBY92S0A+rb31e8MO1Djh8N304rbvhSXfOfr8oWp+q1ISJWGbJabFsiYeu8d2bnUqQiKQ9VYZbOLhUXgi4LA8g3Qv5Orgd7SeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348818; c=relaxed/simple;
	bh=bLH0hcdr0O2oqgXLTSBZUC6CB3DtR5b2OLsnxHMDaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urz8m2h5IZTnCmhoqlD5+ytkaBAkScjv4OXtrPPl0HC69k2TC2RaG7CUHJhgOW8ydNV8QB+i7ZRxev7GCUxnplnhU5nmX/Ke7bIc/C2YkOBcNjit1/YuLU2JAw3WY+cBhiuOgF6SCc9nhCuzEcJneEfVk2a8UTBs/7WS6xwyRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm4QgmxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2198AC4CEF1;
	Fri, 24 Oct 2025 23:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761348817;
	bh=bLH0hcdr0O2oqgXLTSBZUC6CB3DtR5b2OLsnxHMDaTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xm4QgmxM0CkCUpAccEf6a5yUj0YYyfvZ3QfbpoSFUoooqDuN9shxI4EQ9Ek//stY4
	 S8s5LapaHnFV5UDoAalYcgTy1MeGtyGUrDfdsGnqaNFjkENNJpJbpQ0LOude5lbIW1
	 VqS5ht5UittSmCmDujsLPn8FsgRio2qA6U8wRikoH3xZXOjAgAmJ8AGOKf1n1kT7/3
	 K5iUpdtq70twFWliPfmQeC1RKCjsNoa+6s7rzZOU8f16PVyxksnmR77J5mAZBn7gA4
	 JWIBcyvHbLHr96sKJMNofOR6+gAlTroireSspcBSXfszPK967XrXHRGXtcxAsUOxkI
	 XSod705YCxX+w==
Date: Fri, 24 Oct 2025 16:33:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet	 <corbet@lwn.net>, Simon Horman <horms@kernel.org>, John
 Fastabend	 <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <20251024163336.5fba5cd1@kernel.org>
In-Reply-To: <cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
	<20251023184404.4dd617f0@kernel.org>
	<cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 12:11:11 +1000 Wilfred Mallawa wrote:
> In the previous record_size_limit approach for TLS 1.3, we need to
> account for the ContentType byte. Which complicates get/setsockopt()
> and tls_get_info(), where in setsockopt() for TLS 1.3 we need to
> subtract 1 to the user provided value and in getsockopt() we need add 1
> to keep the symmetry between the two (similarly in tls_get_info()). The
> underlying assumption was that userspace passes up directly what the
> endpoint specified as the record_size_limit.
> 
> With this approach we don't need to worry about it and we can pass the
> responsibility to user-space as documented, which I think makes the
> kernel code simpler.

But we haven't managed to avoid that completely:

+	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||

I understand the motivation, the kernel code is indeed simpler.

Last night I read the RFC and then this patch, and it took me like
10min to get all of it straight in my head. Maybe I was tried but
I feel like the user space developers will judge us harshly for 
the current uAPI.

