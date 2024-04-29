Return-Path: <linux-kselftest+bounces-9021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F28B5AFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5E2831CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAB7640E;
	Mon, 29 Apr 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="anw3SI+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2809468
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399791; cv=none; b=k8X8FMRX7CnMgrL7YqATubAGjkuwQjH4Qu+41Ul+vybotJUfDfBdeRPRog7AFAgu85EO4K06eWLIpLZCBz+eKYdEf25qR0lavDlRqai6Yyunm2pjc2XNtz2qLyXEwQR+NHGXrDf8MrnOJMYFsRq4C1q8LVAlB2kaYShYxJbennU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399791; c=relaxed/simple;
	bh=2fJ5xeQeA6KeYE5PU+AdrKYf1O7FBI8o/A5sh/SrCuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HtqJUL/OczsbcGWH9N5peInSEul2+sR0di4F79RH0naOkC9pD7oIYrYDPh9EcDrOBn157nILUrmHTobK/xE+8NEZ9b7ISnGB9nHn/woXaVDk+cSpwh4fVielfItRz4gp+KFftgSL8k/srfKNNF5Cyhs6gvit62tRrLjshloTzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=anw3SI+V; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714399785;
	bh=OSV4xQE36WJK5s4wJOfO2BbSCoo6uuLgwgYmh3Q3rks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=anw3SI+VLR2Hx2VXa+Klq6C0hfY7AHmNOgWE1DdUeM5M9JDFlyHVVmSeNnk3bXzwn
	 QHZJ0khvJBZh7GOYRjtCytgHd5d78U0ru7HWVrff9LjHe6uEe1ymL/3Drv3KP9aaVe
	 lCN6YCDYKXz1fH0l/dFZ5xfIwTU0GNj1K+v2ipRbaSV9FUyZ80bMYKv6WBSQElrGLO
	 dJP3csukXWhrz/+zriUv29T6F47cx7ORSQeujGSsIf6JCrf+4VJe7ESAl04cv6z1qQ
	 4uBLFgT4setEpap0WjcCP7a8eDT3nUeTr2NoH9+qhqPK/Utx6JZK4cypTMa/BOmEXH
	 ItzFx3DMLn+bQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSlZd07lqz4wcd;
	Tue, 30 Apr 2024 00:09:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, shuah@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH 2/3] selftest/powerpc: Add flags.mk to support pmu
 buildable
In-Reply-To: <20240229093711.581230-2-maddy@linux.ibm.com>
References: <20240229093711.581230-1-maddy@linux.ibm.com>
 <20240229093711.581230-2-maddy@linux.ibm.com>
Date: Tue, 30 Apr 2024 00:09:43 +1000
Message-ID: <874jbkjm54.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> When running `make -C powerpc/pmu run_tests` from top level selftests
> directory, currently this error is being reported
>
> make: Entering directory '/home/maddy/linux/tools/testing/selftests/powerpc/pmu'
> Makefile:40: warning: overriding recipe for target 'emit_tests'
> ../../lib.mk:111: warning: ignoring old recipe for target 'emit_tests'
> gcc -m64    count_instructions.c ../harness.c event.c lib.c ../utils.c loop.S  -o /home/maddy/selftest_output//count_instructions
> In file included from count_instructions.c:13:
> event.h:12:10: fatal error: utils.h: No such file or directory
> 12 | #include "utils.h"
>   |          ^~~~~~~~~
> compilation terminated.
>
> This is due to missing of include path in CFLAGS. That is, CFLAGS and
> GIT_VERSION macros are defined in the powerpc/ folder Makefile which
> in this case not involved.
>
> To address the failure incase of executing specific sub-folder test directly,
> a new rule file has been addded by the patch called "flags.mk" under
> selftest/powerpc/ folder and is linked to all the Makefile of powerpc/pmu
> sub-folders.

This patch made my selftest build go from ~10s to ~50s !

I tracked it down to "git describe" being run hundreds of times.

> diff --git a/tools/testing/selftests/powerpc/flags.mk b/tools/testing/selftests/powerpc/flags.mk
> new file mode 100644
> index 000000000000..28374f470126
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/flags.mk
> @@ -0,0 +1,12 @@
> +#This checks for any ENV variables and add those.
> +
> +#ifeq ($(GIT_VERSION),)
 
This isn't right, # is a comment in make syntax, so this line is just a
comment. It needs to be "ifeq".

> +GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
 
Using '=' here means Make re-runs the command every time the variable is
used. Previously that was OK because the variable was set once and then
exported. But now that it's a Make variable in each file it leads to
"git describe" being run a few hundred times.

I've squashed in those fixes, no need to send a v2.

cheers

