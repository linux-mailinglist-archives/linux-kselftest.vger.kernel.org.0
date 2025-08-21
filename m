Return-Path: <linux-kselftest+bounces-39459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89063B2EF15
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 09:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1932A170F40
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841C261388;
	Thu, 21 Aug 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b="XUUh+GI3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-006a4e02.pphosted.com (mx08-006a4e02.pphosted.com [143.55.148.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8A257851
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.148.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760026; cv=none; b=MwErslnOAkoXWL8KnidpwWdyFnYHTCcA8rRudQq5bmWdQBnKljidUvXrDnsDFoPVZdQIsmNB/2GmkFQ65/4+sxuZo8mbeN37Os1Zu7932EoxnM/dwnATo4lYmbrm0MxfjYVA0ofBnIhs8rqnxywnbTxoIyLO33HJbHSh11/fjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760026; c=relaxed/simple;
	bh=wUIQsxFX55G+x6QsQcOgWeGfBRPg7xDhRjvxQDF2Nfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfti9NoT2HgWUunGIi4/0LDpOo4GZUDdiXBKcGcyS8kvvqmsMK4SwXgiVRuJqmgMzQvxDK3UMCvJPEE6o42wr/MQAiLD1LelZnyG+XjG4mxU/IHmz8KWn0Pzfzc0Ni9rgScY2EKKzsgCcjAaczJONRGJ70Zciw9B8AN8zuR+l4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es; spf=pass smtp.mailfrom=iram.es; dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b=XUUh+GI3; arc=none smtp.client-ip=143.55.148.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iram.es
Received: from pps.filterd (m0316697.ppops.net [127.0.0.1])
	by m0316697.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57L4osO0023074;
	Thu, 21 Aug 2025 08:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=dkim3; bh=9DtbzDD12Qz6WYnPW1b5T7iW+ThW
	te2lDCZ4Qh9R+PM=; b=XUUh+GI3TzGW7zz9AONboijKAiLwkm+7dYKDCOosbynA
	M1DTvMveqaWRNZqs+JFK+zipMsLxJqX8pYsL5jL+BS/X8kTjKuIKrWDt7pRlVOUi
	fuZK8JbMbI4zJmVvtSQWwN6Iv3ym4PqqRwMRCIcHHuYQclauCyl5J3pBbuoyQtz2
	AHa5Z+Gme1TTG3+FmCD7sH4VfJK86oACTM4SKTTE/KqbsBHwo2sCSIdw/K/OdRoI
	UplzZbY9hXyWX2Ag5BWWKi79jdzGdx26SRx0mUpC9cXew2q7TIUWH0B3FtqjYxKO
	OXsQkyIoitqkJfDEF+Ar0rvHLt+lLv7wazLvGItEVw==
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
	by m0316697.ppops.net (PPS) with ESMTPS id 48n0tenm4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:22:52 +0200 (MEST)
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
	by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 3FF6F140749;
	Thu, 21 Aug 2025 08:22:52 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mta-out01.sim.rediris.es (Postfix) with ESMTP id 2E91E14074D;
	Thu, 21 Aug 2025 08:22:52 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tZrUO9GERqxH; Thu, 21 Aug 2025 08:22:52 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
	by mta-out01.sim.rediris.es (Postfix) with ESMTPA id 9A29D140749;
	Thu, 21 Aug 2025 08:22:51 +0200 (CEST)
Date: Thu, 21 Aug 2025 08:22:50 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: linux-kselftest@vger.kernel.org, mpe@ellerman.id.au,
        skhan@linuxfoundation.org, maddy@linux.ibm.com,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: fix typos in tm
Message-ID: <aKa7Or9_QqmmMgKx@lt-gp.iram.es>
References: <20250819123326.7025-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123326.7025-1-rakuram.e96@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfXzxUQCFWLDIGV
 LxI+iyXxRieTyKQ/4LCxMnxNSovfyWYwv3hsgaaFvjlYK91h474kGsG408QwU1mLZNU84ldQYq1
 e+a1Dg9KSv1cHfBKhchNvmev16AG7QdLuwNLmaO5QEzbVz0xdaejnRF91XdVUFztA0a4UDvjKpb
 7xMxSLDLyz7EBkhuH9MT5cnbWC75vpdKxtioJqBR0uMd6RURvFnhJO1gTOH028CpAJr/2nheybj
 IS0G8TvD6b4JowL8QoNOjczIih0IIWdKjayF2DQEOfQmfyNeU1jw66UT/imFUv+s/ZxTYg4z+FX
 wzYM93Dp/XcOSe2MZJMHKeFzWACbiXAJWlvqBWxW5T3Sw5iLBrsLT2UDJhPTxW6bBB2TIVyMIoX
 QhH2FU72N9h0m+xM4/YIAbGQvElVnA==
X-Proofpoint-ORIG-GUID: dekISzUxjEsl9mhdAw4dYyAVtqwl57f9
X-Authority-Analysis: v=2.4 cv=FYpuBJ+6 c=1 sm=1 tr=0 ts=68a6bb3c cx=c_pps
 a=QKUl0uxKTaJPacWKUfn9WA==:117 a=QKUl0uxKTaJPacWKUfn9WA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=iTEgFMkIZdcFuMyAKaIA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: dekISzUxjEsl9mhdAw4dYyAVtqwl57f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

On Tue, Aug 19, 2025 at 06:03:24PM +0530, Rakuram Eswaran wrote:
> Fixed multiple typos in powerpc/tm reported by Codespell

I don't know what Codespell is, but if you don't understand the context,
you end up with quite a few mistakes.

> 
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
>  tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-signal-stack.c    | 4 ++--
>  tools/testing/selftests/powerpc/tm/tm-sigreturn.c       | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-tar.c             | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-tmspr.c           | 2 +-
>  tools/testing/selftests/powerpc/tm/tm-trap.c            | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
> index 4a61e9bd12b4..8aee18819603 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
> @@ -42,7 +42,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
>  #else
>  	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
>  #endif
> -	/* Should segv on return becuase of invalid context */
> +	/* Should segv on return because of invalid context */
>  	segv_expected = 1;
>  }
>  
> diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
> index 68807aac8dd3..e793b5d97c48 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2015, Michael Neuling, IBM Corp.
>   *
> - * Test the kernel's signal delievery code to ensure that we don't
> + * Test the kernel's signal delivery code to ensure that we don't
>   * trelaim twice in the kernel signal delivery code.  This can happen

trelaim does not exist AFAICS, but treclaim does (actually did since TM
has been removed from the architecture).

>   * if we trigger a signal when in a transaction and the stack pointer
>   * is bogus.
> @@ -52,7 +52,7 @@ int tm_signal_stack()
>  
>  	/*
>  	 * The flow here is:
> -	 * 1) register a signal handler (so signal delievery occurs)
> +	 * 1) register a signal handler (so signal delivery occurs)
>  	 * 2) make stack pointer (r1) = NULL
>  	 * 3) start transaction
>  	 * 4) cause segv
> diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> index ffe4e5515f33..4dfb25409393 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> @@ -5,7 +5,7 @@
>   *
>   * Test the kernel's signal returning code to check reclaim is done if the
>   * sigreturn() is called while in a transaction (suspended since active is
> - * already dropped trough the system call path).
> + * already dropped through the system call path).
>   *
>   * The kernel must discard the transaction when entering sigreturn, since
>   * restoring the potential TM SPRS from the signal frame is requiring to not be
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
> index f2a9137f3c1e..ea420caa3961 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-tar.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
> @@ -50,7 +50,7 @@ int test_tar(void)
>  			"bne	2b;"
>  			"tend.;"
>  
> -			/* Transaction sucess! TAR should be 3 */
> +			/* Transaction success! TAR should be 3 */
>  			"mfspr  7, %[tar];"
>  			"ori	%[res], 7, 4;"  // res = 3|4 = 7
>  			"b	4f;"
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> index dd5ddffa28b7..e2c3ae7c9035 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
> @@ -9,7 +9,7 @@
>   * - TFIAR  - stores address of location of transaction failure
>   * - TFHAR  - stores address of software failure handler (if transaction
>   *   fails)
> - * - TEXASR - lots of info about the transacion(s)
> + * - TEXASR - lots of info about the transaction(s)
>   *
>   * (1) create more threads than cpus
>   * (2) in each thread:
> diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
> index 97cb74768e30..99acb7c78403 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-trap.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
> @@ -91,9 +91,9 @@ void trap_signal_handler(int signo, siginfo_t *si, void *uc)
>  			 * LE endianness does in effect nothing, instruction (2)
>  			 * is then executed again as 'trap', generating a second
>  			 * trap event (note that in that case 'trap' is caught
> -			 * not in transacional mode). On te other hand, if after
> +			 * not in transactional mode). On the other hand, if after
>  			 * the return from the signal handler the endianness in-
> -			 * advertently flipped, instruction (1) is tread as a
> +			 * advertently flipped, instruction (1) is thread as a

Looks like nonsense, it's actually very likely that the original author
meant "treated" (or handled).

>  			 * branch instruction, i.e. b .+8, hence instruction (3)
>  			 * and (4) are executed (tbegin.; trap;) and we get sim-
>  			 * ilaly on the trap signal handler, but now in TM mode.
> -- 
> 2.43.0
> 
> 


Gabriel

 


