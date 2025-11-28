Return-Path: <linux-kselftest+bounces-46697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27097C92EB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89390349953
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C74298CBC;
	Fri, 28 Nov 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW/2B9BJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F5134AB;
	Fri, 28 Nov 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355259; cv=none; b=fH9Q1L0OvWLmI7AG/3SITUHh+pC/c4+2FpyFqCOXLJU08GxS0GEsBXSoO47P4qAWwgm/zwg8VxeXCbfdQI9CrTG2p02HXmqioUjckHRCscCFmRc/zYlUpq4tFhAlW3orLpEuuz8/PsAbrwhR5beHGWn60JCNOfdbWLlo96kHDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355259; c=relaxed/simple;
	bh=5voKoMVuu7QsuhZYJ1cod2oYlHK99ijfW7kHtIb9TEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoBxV11O/5cL6u+9fsfOtrB6OMfwOPwkQEvff3+6pNI2CS0gAENnFCd8NWadtNzk3cLaSkmn6HgSuBsObParY+g0Ccs3yZrUUpxPKIOPB0u9Uhc5kj9gEgedjIzOz6MLWLBnUjHdNOaM/u31/pO1toRM97GfC1TK8M3nsoBTzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW/2B9BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A4C4CEF1;
	Fri, 28 Nov 2025 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764355258;
	bh=5voKoMVuu7QsuhZYJ1cod2oYlHK99ijfW7kHtIb9TEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fW/2B9BJYsgMSteBfwjqkaBXdcV+7bKUYZxUt9VbApeN5Q1MunbgJ/YRzrcHXdYM/
	 dVP8b1PtqRlarORK91yK4jB44otH9/z7+5/0jKRE9k8mgKrh9yNBxltuUDid5b9WK5
	 e6bJSTXi+moRiRycq/cC2IGQAa4Uk9DEqTtfAkVljzFTr4zHKr83ZqzCnFf5/iKPeg
	 ZAZoDe6iiMJ8t/8l3lscaQzEV0T+IeBzN8AGSDWkEzaVuy3awTZXEfL23hkazPiGwl
	 Vd5TJ0hYMzdw+gx/6HCDlgK1gSl+AxccrNBc1dcdFqKdGh9iCIT3WzvEQ04rcr7K9c
	 UuKCT6gGCkCBw==
Date: Fri, 28 Nov 2025 10:40:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Shuah Khan <shuah@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>
Subject: Re: [PATCH] selftests: mptcp: initialize raw_addr to Null
Message-ID: <20251128104057.047704b5@kernel.org>
In-Reply-To: <603f6c4f-20a1-4b6b-80a8-c9d9d3373d7e@kernel.org>
References: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
	<795a8f3c-eff7-46d9-9175-a4ebe3f9ffd8@kernel.org>
	<20251127170041.0613c50e@kernel.org>
	<603f6c4f-20a1-4b6b-80a8-c9d9d3373d7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 11:34:38 +0100 Matthieu Baerts wrote:
> > Including kselftest.h will be needed.  
> 
> Because mptcp_connect.c is a tool that is used by other selftests, but
> it doesn't interact directly with the selftests, maybe we don't need to
> include it, and only add this #define in mptcp_connect.c?
> 
>   #define __noreturn __attribute__((__noreturn__))

Up to you, I'd be worried that some semi-automated patch generator will
send us a "cleanup" to remove this as duplication. But I'm overly
sensitive to this sort of followups so we can try if you prefer :)

