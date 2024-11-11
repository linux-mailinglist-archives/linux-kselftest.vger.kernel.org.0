Return-Path: <linux-kselftest+bounces-21831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0C9C49C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37667288346
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23011BD9C9;
	Mon, 11 Nov 2024 23:34:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1E156883;
	Mon, 11 Nov 2024 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368049; cv=none; b=HcTBqCqp6K5ZbHnPNwEt/YzueuFy97e3wKYlAAPFXJ9zBMAarzZC59su1YsQDmslGmRhCU/rXbjB4OizWGnaowAxz72qEHvp4ZDSbc9NC1as4Nz+4jmjNe5Z3IC5poylX+yMyhv7JPJo3kCJ/hah5RLVebHjOk81mnEgOmgY3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368049; c=relaxed/simple;
	bh=4zALWIkyyeBw3jfHm1d5aAgbVDMeuwAIm38FhgXE8ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owkm7aeaKXlPBJC4xZQ9i9gbV78U4XUAREML42mzZ8tek6ZRDZ0nMQ8ClPuQeH2rd/iLEjjPeiEkN4rBCW2tc5w5ewdi5XPCKrVqgBsxYItzKWNJ7R9t7sD3r0ujKvETNvA3s0Hw4PPjVXWqAIqszDXqPAQlUuiO+HzUL9PdhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2ECA1480;
	Mon, 11 Nov 2024 15:34:35 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A9563F6A8;
	Mon, 11 Nov 2024 15:34:05 -0800 (PST)
Date: Mon, 11 Nov 2024 23:34:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] kselftest/arm64: Use a define for SVCR
Message-ID: <ZzKUaqv_K-MRTti4@arm.com>
References: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
 <20241107-arm64-fp-ptrace-fpmr-v1-2-3e5e0b6e3be9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-arm64-fp-ptrace-fpmr-v1-2-3e5e0b6e3be9@kernel.org>

On Thu, Nov 07, 2024 at 01:38:05AM +0000, Mark Brown wrote:
> For some reason when we're accessing SVCR in the FP tests we use the raw
> numerical version of the register name rather than hiding that behind a
> preprocessor macro for readability. Since we already use the generated
> defines for sysreg bitfields in other the KVM selftests let's do the same
> thing here, also replacing the defines for the SVCR bitfields which we
> have.
> 
> The build setup for fp-ptrace is a little fun so we have to manually define
> __ASSEMBLY__ in the source code for that.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I get an error when trying to build this out of tree:

/home/cmarinas/work/linux/tools/testing/selftests/../../../tools/arch/arm64/include/asm/sysreg.h:132:10: fatal error: asm/sysreg-defs.h: No such file or directory
  132 | #include "asm/sysreg-defs.h"
      |          ^~~~~~~~~~~~~~~~~~~

Probably sysreg-defs.h has not been generated yet. Too late to figure it
out now.

-- 
Catalin

