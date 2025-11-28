Return-Path: <linux-kselftest+bounces-46680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCACC90741
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 567CF34E44D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8E1C5D44;
	Fri, 28 Nov 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln/e5OD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8720B22;
	Fri, 28 Nov 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290870; cv=none; b=Cms50GJ4HAabTKAO2NPinpC3WZWPb+GVb71heilJf9qIt3bCGLeHnW27xZL9AJaRC8U0dBKgjv6suETZOz/TDuh/ou/rVH9DVpzNSOK8IHgnHVNxMINrVsevQ/JUD3HbmKv1DcZQWbgwyt5QDSphsRRqQPTGmfn4kOmSQfJH0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290870; c=relaxed/simple;
	bh=KSFigX3mQH03MUV5DsDXRhIb5B6qAvBrmCG/YPhRIPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKJUcayL+Yz42gXnLDku6kZQY7UsrgMpSuB7sgg9mz1mj4D40XjiJXq3RM+cwcR/UVhXo/ILNW0xcxCme15vYkkxTgZ98FbrrP/G+PQVdxDkeyVy71bL6jh7F729qSP511z29HkidxAR2+bFgn88G3Clq7D5HtNKM6PicnJALFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln/e5OD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA151C4CEF8;
	Fri, 28 Nov 2025 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764290870;
	bh=KSFigX3mQH03MUV5DsDXRhIb5B6qAvBrmCG/YPhRIPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ln/e5OD7p3wbr8HfEBYAvMPMarHKj023XvTLBKGOH2yAn79pKQ4Y92Nb7RDq6X3/V
	 KPyH7hkIY8NjJK3Dj9cSOFuaXyk5d4AzxGKPqxknfHQNJ++l+1gHLN5Cfujd0SVVqX
	 E2LY5yQK0xbben7QpG/o2Diq7jLA5q28+mPmIyEbAuDYYmnWpK07juujtjDFMolZC+
	 Y9oDPT9P0zbcOywQZSf2/2SlyMl48DSQ5b8kGZnRUI/kEPQPMkUPVUDQNXn7NR6BIQ
	 7HLwsGlUJ2Atrk44c6bvat7LAlIoO/HQW1K5YlzCy/1v5fo2UEw7YeE5muP4K0VGpQ
	 5uAiqCZEr+b5w==
Date: Thu, 27 Nov 2025 16:47:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] netconsole: support automatic target
 recovery
Message-ID: <20251127164748.4db1e1fe@kernel.org>
In-Reply-To: <v44skio47zulg6jok5wq7w2ylw4abk7dxtjarlgnuz7hukvbts@7clzpd7cqc5u>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
	<20251126173646.696537af@kernel.org>
	<v44skio47zulg6jok5wq7w2ylw4abk7dxtjarlgnuz7hukvbts@7clzpd7cqc5u>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 23:07:02 +0000 Andre Carvalho wrote:
> > Should we not be listening for the REGISTER event then? On boot
> > we force UP the device if we find it, theoretically there may
> > be a case where user space is not configured to UP the device,
> > and then we'd never resume the target?  
> 
> This is indeed a limitation on the current implementation. Based on
> your feedback, I'm working on a new version of this series handling REGISTER
> instead of UP and ensuring we force UP the device.
> This will make it consistent with the boot behavior you described.
> 
> Based on my tests, I can't force the device UP while handling the REGISTER event.
> I believe this is due to dev_open attempting to lock the device which is already held.
> For this reason, I'm resorting to defering this to a workqueue, similar to my approach 
> on v1 [1] (but correctly handling target_list lock).
> 
> Let me know if this approach makes sense or if I'm missing something.

SG, that's probably the most resilient solution.

