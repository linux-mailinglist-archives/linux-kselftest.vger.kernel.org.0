Return-Path: <linux-kselftest+bounces-4904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7432D858CD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8531C21E28
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCF71B7E5;
	Sat, 17 Feb 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siUT6ilt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFF1B285;
	Sat, 17 Feb 2024 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134055; cv=none; b=G9y4JCBNzFnX6FUSqqTHmHYNcZ49GaubhYGuyowen9S+wQidBtLkEZp7bsF6v5JyRrts7D9cRRFInHMN/n/b3/yn2TkjUjuH9ECWJBpdRTkuPss4q6KCsKFzTPy66W7BsADZ6ualloqH1CI86IQBBraLgfBs3N38pekmkxsqwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134055; c=relaxed/simple;
	bh=TAP5n1rVZvF9tSNg+8A4StR3ZkRSgV4HRvZCjjDEcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuXwJO5nTEzKzan4uuuLwhHO18c7VTOr29UO7pitnd0zr8BPDoDfYVpGpAU9kc0tHo7VX6qKbRGLQW0F3LFjrUdEonWZJLUlFMQxBRL4dPZUkYvgYiOdy1akN3N5uXy7q9UZwdz5us+59mCX+eF2VEIlLwFeWdTo4PAgwi5rgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siUT6ilt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA579C433C7;
	Sat, 17 Feb 2024 01:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708134055;
	bh=TAP5n1rVZvF9tSNg+8A4StR3ZkRSgV4HRvZCjjDEcMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siUT6iltK+1Xqdm11f3iUZ0/6lWjfVwPKG/F5jFiuF40V3DqFkgk2tEMRVY7QBg1F
	 vw9wVKvt73nfKwf014XryecooCvXtBkNRdaguEtio5XnJS26ilTq+zSuEOHBpm3Nop
	 Ii0BtGuz03wpMQn2PT/O3TeSGiAULJHk6CpRNytJHpy2+4Vc4A4cTOqHF7TGdEDnfg
	 0HlNceYCvko+bHDjBdJSpndRVFPBfyU3DUFBl8ywKQsi5aDsuZyNBQGIA5mBBvaULu
	 g3asx3WbNrWnWGQCIzNytm7vu+jaq96JXxIV2tO1/0q4EO07rIO85zjG0BAvoMy6mO
	 sAj/CkBADuBPw==
Date: Fri, 16 Feb 2024 17:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: shuah@kernel.org, keescook@chromium.org
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 jakub@cloudflare.com
Subject: Re: [PATCH net-next v2 0/4] selftests: kselftest_harness: support
 using xfail
Message-ID: <20240216174054.4e051f9a@kernel.org>
In-Reply-To: <20240216002619.1999225-1-kuba@kernel.org>
References: <20240216002619.1999225-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 16:26:15 -0800 Jakub Kicinski wrote:
> Hi!
> 
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip.
> 
> Clean up and support the use of the full range of ksft exit codes
> under kselftest_harness.
> 
> Merge plan is to put it on top of -rc4 and merge into net-next.
> That way others should be able to pull the patches without
> any networking changes.

I need to rejig these to follow Kees's suggestion from:

https://lore.kernel.org/all/20240216163119.7cc38231@kernel.org/
-- 
pw-bot: cr

