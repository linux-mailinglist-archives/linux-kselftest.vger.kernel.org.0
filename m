Return-Path: <linux-kselftest+bounces-9353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117BB8BAAE9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2253282C2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA6515219D;
	Fri,  3 May 2024 10:42:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25551514FD
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732954; cv=none; b=HNvxS9bEjDbUEOvlBxJQdPluSEb8Cr5yP/PS/mLki8rzuHOMyVymG1WoSaKdKmVq6lctZmCATsKDFEidUpVlREq80ZABMCP/BYpmwi2ZUWj+R37H2VlzwY/Me6Kbylaf8HzcmLMoBvxbkie3y/BVKgTWmjfLXfRySfWbSZJXQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732954; c=relaxed/simple;
	bh=gW0ZdB8g/4OZxuWPb4Ff5Gkt9s4SqMGjKN8I8fEnPL0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aFT2Q4XQpEnJGOMmBIAjNNsxRg/oKRIuX3A3jnxzExP2KK6HK+csx6Fl654C5Zt+O/AlVdWWenI2SdzkUa/P+WDeABo48m3RG2KWHq5DghuJQ/IxtEcljTDKqOIrtqBb/7lrId8htf4YtuXXwT36JAbM2Z34jElUWamTGL9YF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW6ng00rBz4x0C;
	Fri,  3 May 2024 20:42:30 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: maddy@linux.ibm.com, spoorthy@linux.ibm.com, linux-kselftest@vger.kernel.org
In-Reply-To: <20240422133453.1793988-1-mpe@ellerman.id.au>
References: <20240422133453.1793988-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] selftests/powerpc: Convert pmu Makefile to for loop style
Message-Id: <171473286290.451432.6519963116892693691.b4-ty@ellerman.id.au>
Date: Fri, 03 May 2024 20:41:02 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 23:34:52 +1000, Michael Ellerman wrote:
> The pmu Makefile has grown more sub directories over the years. Rather
> than open coding the rules for each subdir, use for loops.
> 
> 

Applied to powerpc/next.

[1/2] selftests/powerpc: Convert pmu Makefile to for loop style
      https://git.kernel.org/powerpc/c/822a04957cc5e675570645f506270797a1cf2865
[2/2] selftests/powerpc: Install tests in sub-directories
      https://git.kernel.org/powerpc/c/dda32e37d397f5937cc24a6e98b71d3645f51afa

cheers

