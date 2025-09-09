Return-Path: <linux-kselftest+bounces-41079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEAB50935
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74E068176F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D7D287274;
	Tue,  9 Sep 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEb7U+wg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89ECDDC3;
	Tue,  9 Sep 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460352; cv=none; b=G947OloZLkZOJOQpQHTiPagVQ/dkF/xgx1uUFp30m/EvEKIkEzjeSnLT6VKmIgJYdXqyhDSjH2hBCuBpnO7B0foICg+9QWICdZ9aaFh7rT4F6ZJjOG5VDFX4U9Tdysy5sPqoWPuDSSOE5wnwbFqjO+d7E5T35/KzanptaW1w2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460352; c=relaxed/simple;
	bh=MmJedLQVQoPpZEmi6tcHTlPXnNg/dw0WgmTvxcraOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCs+bngG8o5W7MkRARMND5r2CIC2gE661FRQscCV0yPip5hY/DDb1iRM2AWT5+Z+9A9fY0wEiwBmH4wf79UtW+56Zg3AKRzEyFdD4J89wcXBD8fwGrrpOwbt30jvdROKlOL2phXqR0a4ji6tg5/4GTQoNaz1v6L1alAeDXli9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEb7U+wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14F6C4CEF4;
	Tue,  9 Sep 2025 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460352;
	bh=MmJedLQVQoPpZEmi6tcHTlPXnNg/dw0WgmTvxcraOiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEb7U+wgQZLXonc4+Au+nE7Rg0TM+QO/1u6BPBSjyzh18acc8z+nKSEAjEJzFM18w
	 owYQnivEsa5aZudPIpuoY+3+5kO0Iy1tLi7KEs9Uiw95n4SdFwZ8wOGIjblpmCy/Wh
	 JJVZDSXqfs8w0XSolFsF/49Mrv+cyUnOKCTwsr64ogwhx0NMqi+C5jLrT/0FnnJ7wq
	 B4rAE/YMgC2bTFH1LBE2O7+Tn8HvTu+6MjLlQzQkw7ZK62W37dgzTGvVXddFjNM5mX
	 fcKfGtw7Q3QjJrD8kzUhiAWBDxME04a6AmaZ5O1O9y4v4+VPFFcqrnxE54/bJRjOUU
	 RAW/lS4bqESNw==
Date: Tue, 9 Sep 2025 16:25:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nai-Chen(Simone) Cheng" <bleach1827@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/net: fix unused return value warnings in
 ksft.h
Message-ID: <20250909162551.5224a3dc@kernel.org>
In-Reply-To: <a3d1c5ca-cdce-428d-8c1c-6a1f59e2dd76@gmail.com>
References: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
	<20250908182018.28d9ff10@kernel.org>
	<a3d1c5ca-cdce-428d-8c1c-6a1f59e2dd76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 18:00:17 +0800 Nai-Chen(Simone) Cheng wrote:
> Would it be acceptable to:
> 1. Send a v2 of this patch with the direct void casting approach and 
> more precise commit message?
> 2. Send a separate patch to fix the selftests Makefile clean target to 
> include $(INSTALL_DEPS_TARGET)?

Sounds good!

