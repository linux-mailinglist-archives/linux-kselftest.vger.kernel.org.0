Return-Path: <linux-kselftest+bounces-3250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92520832D1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED002832A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659055761;
	Fri, 19 Jan 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrpjNmSw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6F54FB8;
	Fri, 19 Jan 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681617; cv=none; b=dYUn48IKDgVMn6S2cVdMrjcizB/sPiYNXqH7OU38Zpt+FAxBuNuYh0AbpyZ4oF9Q2agiVVUHVkbzILTY+BuEthySOCecEbASAJ2GyRADMOA9eISGOauvnHu0A6rExpT3JxoHeMO8SyrWENmA5/PTldNmaITQ7Bb361h/mihLmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681617; c=relaxed/simple;
	bh=UDkBSfnsj5R5kyHYyJkEIZX2KXRkPcu3b93+iOKGDaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD48cjQ/U6dkZXJkxE8mQvQHF64gjyY/NwAX8DBXg6P37Jb6E2FIXbe6C9Fz5Qcc6X8zW8YXKA1JHfguG73MF4eTIjUYdWYu/9uuKuicksXgNaqCks6rT3UYHNB83roWCGtjFYnwxm0UnBt1NY5whE4yXrdGHTgISQs7Huf7fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrpjNmSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75D4C433F1;
	Fri, 19 Jan 2024 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705681617;
	bh=UDkBSfnsj5R5kyHYyJkEIZX2KXRkPcu3b93+iOKGDaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrpjNmSwdEcjBGZF+t2nesdl5TJr/CSmh8KI0hb6PLu5ydf0TEcPPty6+gQTdx2Xq
	 8NNvR4bg0yjVCui7BSKw54lvIanCXJ0jCJxPFnsjjCD7X/FHqoLCUTK2zf5BhwBYSQ
	 V9RrSPzEamumdGhRaDRvmNZLyldmbuKoXRAFwTwsL+iXd4nbUGJhnA9JP9iTzYUR44
	 /QOPRzr3AdyprzeAHcjdDSlwBuJci1wPkzGdYXcNE4xmy/OOosauEkXOf4zwy9Uxtr
	 Nmcs2BUejVYtg7hmwa9wI3yINtlpqVI3bUCmRuXYwlrhLqBEhll8LMoyDQPVBj3glE
	 H7Y7fyyXQED8A==
Date: Fri, 19 Jan 2024 16:26:52 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/net: Argument value mismatch when calling
 verify_counters()
Message-ID: <20240119162652.GG89683@kernel.org>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118-tcp-ao-test-key-mgmt-v1-1-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-1-3583ca147113@arista.com>

On Thu, Jan 18, 2024 at 02:51:34AM +0000, Dmitry Safonov wrote:
> From: Mohammad Nassiri <mnassiri@ciena.com>
> 
> The end_server() function only operates in the server thread
> and always takes an accept socket instead of a listen socket as
> its input argument. To align with this, invert the boolean values
> used when calling verify_counters() within the end_server() function.

Hi Dmitry,

I see that this is correct, but I am wondering
if it fixes a user-visible bug. If so, could
some text about that go here?

> 
> Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
> Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
> Link: https://lore.kernel.org/all/934627c5-eebb-4626-be23-cfb134c01d1a@arista.com/
> [amended 'Fixes' tag and carried-over to lkml]
> Signed-off-by: Dmitry Safonov <dima@arista.com>

...

