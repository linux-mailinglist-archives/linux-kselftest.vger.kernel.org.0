Return-Path: <linux-kselftest+bounces-17813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50375976889
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D127FB20C53
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CB19F42D;
	Thu, 12 Sep 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="h2tOyOeK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FC19C546
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142537; cv=none; b=qEyIZS0EnBxy8PlfTlZWW6qfKDz7CsYCGE4CpQBjarbgW4l/kP6iHTxzEJMFjV+YnaCO8Q8AYKWvF+0TYaSVFkYgMcqV56GJuQ006Za2Tu3jXIqsTe8YbftmEfsBdT1lj0mhSLkqOh4WBWPKgDhSoanBiRAvA03XR4UM6/69vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142537; c=relaxed/simple;
	bh=sf6RLJQbOo98LU0FegKfU/j/7pgM17uNQOpfmUZoNS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TGgldXevkDsyBZMJL0sJCoegfcIchy9t5WbUDfURjLihc1fL229UbKMJJYBsFJoFtBDlauv7GjqLzF/PNguKxK8LWOTmiYuoR/UI1V+WoC7Po0bMRMPDpJZpbUkeESaT07hsI8CCiFfnnb521iMYcBZyMLzD28SLcZ4bYwV8EfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=h2tOyOeK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726142533;
	bh=BMGO0Q5c6i08GrxSwq0x1WRfiK8gP9JXFevm1J/Ncdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h2tOyOeKw28shchITfPuRD1sFkbC0sy57QsN/hN1iNUDdiH/y6AFd6CjHbMFxiz/z
	 x2Wg2QAGkfkPv7yhK/BlOf/RPo/e0KJ71kJV74vYfHTE1mCMjel3956OPLUGhR2fFm
	 /BGzU+C9uNSF9Ge7ntEePz90Wp/twtcIT26u2jdb91w95r8PRZLXnZewTMWTz22rF0
	 +mh4YDpRnUc1VgicXvcN5Aj5EM9for68ZqztHrUDBhPpYI3rYg0EmRy5uLKd+Tga/m
	 olQ+R0e+VreNcabK1iYG4VzMGBuplYj9KXF/3TsXiSwCVhA3PfdW7NTqkezVo9+2y1
	 8QF0dzxECzD1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4GJj1GY1z4wb5;
	Thu, 12 Sep 2024 22:02:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, shuah@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20240812094152.418586-1-maddy@linux.ibm.com>
References: <20240812094152.418586-1-maddy@linux.ibm.com>
Subject: Re: [PATCH v2] selftest/powerpc/benchmark: remove requirement libc-dev
Message-Id: <172614240959.1297852.18225617540845109128.b4-ty@ellerman.id.au>
Date: Thu, 12 Sep 2024 22:00:09 +1000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 15:11:52 +0530, Madhavan Srinivasan wrote:
> Currently exec-target.c file is linked as static and this
> post a requirement to install libc dev package to build.
> Without it, build-break when compiling selftest/powerpc/benchmark.
> 
>   CC       exec_target
> /usr/bin/ld: cannot find -lc: No such file or directory
> collect2: error: ld returned 1 exit status
> 
> [...]

Applied to powerpc/next.

[1/1] selftest/powerpc/benchmark: remove requirement libc-dev
      https://git.kernel.org/powerpc/c/8c9c01ce695eea84d19482e7429e3d54ceb7585c

cheers

