Return-Path: <linux-kselftest+bounces-22152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D709D03C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238E3B268AD
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AFE1A9B39;
	Sun, 17 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="q2vt/Rw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A119DF95
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Nov 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846334; cv=none; b=C9EwtNoUWjkVcUb3k3rF5CAAwO6qwWaMEpOJLN1Rmb5VxuTpTZUlOi26TFrcIHa0rd3gBp4/mlF5CQPgY6TuwjVICUMqsqTEl4kGWbt27YkEPLwLVh2vRNrPMdgZClK64HiagYrMnNk26vi5eE6DWX/fUAoGdGdBXiO7wOmbmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846334; c=relaxed/simple;
	bh=aIE+Omebybd47Zmb8GWakGh9XtOGA3iHrZQrJgCbR34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xbc91vv0PPqAFShTYq8H9pvAMoAmEFDf3E94+L3xStF+oU+zryKTZIZFV3sISWeBtCCYRzeqH2RaUYFWSaktzFB3H+8XVf5j3MarqEmjCBcMU3qKPm6SY4gDoSixNZWIxelv5ednKiDtj+EUlM/tPfKjcqgByyXucOT+RC1ns8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=q2vt/Rw/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846328;
	bh=uRzVzixg7Mdrf8EHXUktOJebAXNU4c5koSYvpP+Je94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q2vt/Rw/H042E51ndsAlxlFUiH2elh52Ixzt3p4JWijdzEuUa4aiC0hS9q2RjCCVE
	 n2LNOdSzJ/B81JVUxH82moV88IHik4ksZPzTJgqjIeUYz7HG9lyMJt0om1gaMhEnVp
	 RctwJwdgt+XyRKidEroGn1RUBEesbw+PloaqiEqdLmdZMAfV5DGPKDEFqygOkVgOOu
	 y5aqKfNvxqSJBgFojBwovxXy1FWaJlkJ2vJcA3lzgHx88mw/tHwZWzxRExJucO5c05
	 JHq7fHFbHW5/UKFlINQpBHimUVBuwxpARRrK9sEeXZgb6BC8wIQp6wnbXhcQCSxSyg
	 9CstAHYe4Ov3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj36rNrz4xfH;
	Sun, 17 Nov 2024 23:25:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kselftest@vger.kernel.org
In-Reply-To: <20241106130453.1741013-1-mpe@ellerman.id.au>
References: <20241106130453.1741013-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] selftests/powerpc: Lower run time of count_stcx_fail test
Message-Id: <173184539745.890800.18144294267684223790.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 07 Nov 2024 00:04:49 +1100, Michael Ellerman wrote:
> The count_stcx_fail test runs for close to or just over 2 minutes, which
> means it sometimes times out.
> 
> That's overkill for a test that just demonstrates some PMU counters
> are working. Drop the 64 billion instruction case, to lower the runtime
> to ~30s.
> 
> [...]

Applied to powerpc/next.

[1/5] selftests/powerpc: Lower run time of count_stcx_fail test
      https://git.kernel.org/powerpc/c/3b9bde403aafa55dcbe7dc250b95af917610f139
[2/5] selftests/powerpc: Give all tests 2 minutes timeout
      https://git.kernel.org/powerpc/c/5543d595954eefb3a6faa18a6dc7b1b3d6022052
[3/5] selftests/powerpc: Fix 32-bit BE build errors on Ubuntu 24.04
      https://git.kernel.org/powerpc/c/d5f578f90a34d85f1cabd4c27af1b2d9fbffe64b
[4/5] selftests/powerpc: Return errors from all tests
      https://git.kernel.org/powerpc/c/c6a75555b4b2643365a007b7162a670d69aa28fe
[5/5] selftests/powerpc: Detect taint change in mitigation patching test
      https://git.kernel.org/powerpc/c/a8a54a65cac4f8202df36f925b6746328802d05f

cheers

