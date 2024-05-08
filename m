Return-Path: <linux-kselftest+bounces-9707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBA8BFFA2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D150D1C22708
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18984DE9;
	Wed,  8 May 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5pvVf/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7A26291;
	Wed,  8 May 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176805; cv=none; b=Q1/cXvUO4pj6bO5+raO+7cLnBM6QXKX5biRwPNIdG+Wyw5koY9OEZQaQrHNXe4PetXl+Wi/Utvd9JOiVYxBNH/dOuE0z9QhawKVRrFlRFPbZRkhW1psassveNKT0G+CRQwvzY0Gi6TbZtx4SY1f4P1y8O74Xp37xmKmm9VXJCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176805; c=relaxed/simple;
	bh=k4/XzfxHm2HAV59nufUVMe2H7Iyjec3oXI258oBkEsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTK9uIqpYv6cvn67BefLvSY8aIe6YF8tEkEx03fydCJqyhws2gV2ksjfmVTBFueLJdqY7S4DSN683WCWnKDGMskg4gkCQAvs+5M7NZiedCnZQTMYDaVB7Aa9btKfGG9T21tb7NcGVYidP2Cf5Ls/TTc4ai7uM/iYZKwSmRPzgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5pvVf/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF9C113CC;
	Wed,  8 May 2024 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176804;
	bh=k4/XzfxHm2HAV59nufUVMe2H7Iyjec3oXI258oBkEsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5pvVf/2/25oH20Wp+8UM3NI9VvyFNF9xzxQzAYiZ7bhv7EqRNqPZj/ahCuz0r6oq
	 mx6ia0xOCwyBONjFaGGjG/x9Yn/ixG23LVGcNfskpCzzJruetudJJ2UWSSW7jDPM2m
	 ljsmjZRCgB0F3+xHeXWGeMMWC3gHTMqD4cy002k0tgHnzfzmpUSJJvBPG3sKJFm4a3
	 mBylBci6We7oEM4mErgeSeeMAZ6Vuq6Zhoa6rym9918JFCNd1kedKuFewztKSoMf0p
	 seVAZdMSzj+6LPs4J30quX1XI3M9f9F+3J7tcXnYgxGawaaRGj/nDqz5/OLo77KiAc
	 Y3QGK9FaXVxww==
Date: Wed, 8 May 2024 07:00:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, edliaw@google.com,
 ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com,
 bongsu.jeon@samsung.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alexandre.belloni@bootlin.com, jarkko@kernel.org,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-ID: <20240508070003.2acdf9b4@kernel.org>
In-Reply-To: <ZjrpieLKXFhklVwR@linux.bj.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
	<20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
	<ZjrpieLKXFhklVwR@linux.bj.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 10:55:05 +0800 Tao Su wrote:
> Back to commit 38c957f07038, I don't see any advantage in using LINE_MAX.
> Can we use a fixed value instead of LINE_MAX? E.g., 1024, 2048. Then we
> just need to revert commit 809216233555.

SGTM, FWIW. The print is printing a test summary line, printing more
than 1k seems rather unreasonable. Other facilities, like TH_LOG(),
should be used for displaying longer info.

