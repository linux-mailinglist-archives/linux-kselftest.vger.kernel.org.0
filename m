Return-Path: <linux-kselftest+bounces-16556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE41962C81
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A26B221C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C118787E;
	Wed, 28 Aug 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOStaX5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFC13C3D5;
	Wed, 28 Aug 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859400; cv=none; b=OzijT1JEiCmfBao8MR+vUsYA518lvD6LwCY+1r8zBJ5q5Sgb2/F1eA8W1DN01FjuL6MX2/O3oR+Mx3N/m66WKq37hmsuihYku8k2KApUGuP0FkBO+DIaHNumgj/4pqOFnWsOVE83VlR0ljcI7dGPy4ETNWpV0Zx5+o4M+TetFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859400; c=relaxed/simple;
	bh=Dlhs8LfJSCT3cfMO28XcC6tM2o1n/hPpRHJALPiDcFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJoOK2f9TnK1pT4fXK1TvcKMWPLRtXspTD71LsrT6CLf98E396Uif5Pwz8t0SwtZw4eXsDIOxEasKhAPqbhuXAF9CQlW1ly5FV1RlsZyCMnRjGBj2+9i9IxnDTIVRLuykVrBq3OF6YqT65DOWCwKPDATyZvAavpb8Y6D+UDANjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOStaX5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD831C581B9;
	Wed, 28 Aug 2024 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859399;
	bh=Dlhs8LfJSCT3cfMO28XcC6tM2o1n/hPpRHJALPiDcFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eOStaX5SrccSw1ut4q8+c7U6YhtxT5M8Np+hgrMGAQV8GxFF6bEyZMrfoSAyZDER5
	 X0AbPHuHbYSnKavuNbK95dGk9/B6eG7KdjeMFZWDk6mGmzieQU+PLcAW64ToNOO/Bs
	 18TRK6Zu42TqbVW/iUqpENXw8QzZpGBdGy6ZvWTPLn3vY8E+rVZntceaSAwLpZV+9s
	 zYpsrcq/tk7N6WPHyQicAAgmrXIoOwFiQ0tUSWzCl81hvykh4adesZbjDcyu3PXPrE
	 c/R/bG09BuZ5LKCJJGefsGmepp1Hr+5sJHkckfprwrFn6s4qc+jsznOrNrxHy+mopn
	 lQWOp2bxmwnVA==
Date: Wed, 28 Aug 2024 08:36:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240828083637.329447c9@kernel.org>
In-Reply-To: <Zs87rhH9e_Lw-icJ@mini-arch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<Zs87rhH9e_Lw-icJ@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 08:01:02 -0700 Stanislav Fomichev wrote:
> I don't see anything about building the binary itself. Am I missing
> something or should we also have some makefile magic to do it?
> I'm not sure packetdrill is packaged by the distros... Presumably
> we want the existing NIPA runners to run those tests as well?

We already build it from source, for netfilter.

