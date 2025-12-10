Return-Path: <linux-kselftest+bounces-47360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4FCB27D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D7CE3007E72
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EE2302CD0;
	Wed, 10 Dec 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsf+6D6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78711FA15E;
	Wed, 10 Dec 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357605; cv=none; b=tJ6jUQYX+cx8JqsecjQMAdWTIFeEIKw8GsdDO4gSuJeQX7k8X6KSBHawloBB4+CciSueVT8LSFR88oKZfaORLr3UktrSzM5rtO+s1pRxIK41MQI7H2mhxqUCWk7B6X3eldQw8xrLjOgEBTNPcsmBLUVEXJUHrXcMd7g8EP5ky+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357605; c=relaxed/simple;
	bh=oqXaLvXswMKR+X2NSjmtZjLulAjooLz8zXWxpFKC5gU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyZzRp44TknpZpqcGYx0bDpfiyB6r35VTDI9coxUxSLoBOGVOVIiAapYSkGCEAgqQmsSrZNkqy9jLz7KXX15vFtskYs1GEOzGRjKteat5Qw12GHWXhN0ioiggE56vz0/CmcDcVDKyW7cKLBfINz34asu36kJGtagbiP7MOduLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsf+6D6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB0AC4CEF1;
	Wed, 10 Dec 2025 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765357604;
	bh=oqXaLvXswMKR+X2NSjmtZjLulAjooLz8zXWxpFKC5gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lsf+6D6QnPyGxIZXwPzfrXUtzDCVCpGR+vO/EihFAs1tk3RfdmWxcKvDYnZvoZYfi
	 4z5SS5CUfJyRXeggB84EkC4vq/RidZpaH+bYolEBNlfbAXaQU9c5E7UjdVWzBnrV3r
	 47opve41e8Wy98D00sXEYf8jx56PPS4Ago/1xmacGWPQuZcO+vKxMgNmq3KFD4R58D
	 iEmx1yPajqhcS+AK4YSJEOEQvzLLRYHmqeKLMgtXZlY7UiDpnlisjxqo0zqY8lFiz+
	 keF2gu+l42iNrFK3MlD7yMvEsdI23+nkngU45mPu6qF75wzkregYU6sM1b7p6IGytA
	 c3xFyyAP5T2sQ==
Date: Wed, 10 Dec 2025 18:06:40 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: tls: fix warning of
 uninitialized variable
Message-ID: <20251210180640.62fc3145@kernel.org>
In-Reply-To: <aTQE9WDQxBA3g6Gr@horms.kernel.org>
References: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
	<aTQE9WDQxBA3g6Gr@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Dec 2025 10:27:01 +0000 Simon Horman wrote:
> Thanks for the update. Overall this seems good to me, however,
> net-next is currently closed.

FWIW after Simon made this comment more fixes for various ksft warnings
got posted, I think we should apply them now and to be consistent I'll
also take this one.

