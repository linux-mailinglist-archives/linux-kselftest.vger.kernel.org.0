Return-Path: <linux-kselftest+bounces-8034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5C8A5E3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E838C1F21AF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026915958E;
	Mon, 15 Apr 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0FP3bNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CFE1591F9
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223404; cv=none; b=TYNrJSwlAEG/oYCuy2vxe71bRH0JgMnp7+7r6VKm0bMS7I/ZOE6yL4FX+oRhst/AMgnRMHkduDH2IDiQO/2Ifrq/06y32ZvSjX4+21yWxWoDWjc1v2eaN9ByIAs99x8WTPawWgRUHSawIv+7uxHR/stgTTdyWu9hnNraErg62no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223404; c=relaxed/simple;
	bh=JdZ2ft8ajhi7XcRKr62X1PXPTF0E0SljDzQ8sipHzvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q31rzlVqUBsnn91xpfIlAQfLRM5fMPtTcSz1R+ElOx0wrbGaNVCbCuqitsIw1ER5cZ/HiGVxb7YwOUS+W5vZQVoOkK9GAt1sSB2lwojeM6QHkNH424/rkXh3AA9lJ2rZQ03Fc3zvMGI2Bts6JiLgwJ6eotGhUlwP8Sqk0KF8zlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0FP3bNf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc00203faso66507257b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713223402; x=1713828202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNlQW7VRvItZmB++ihw1UtQoUB7JfArp7CvrzW4eQN8=;
        b=d0FP3bNfzHOIQYxxuXwxfD65q0hUWIgxqampIySpGtXZNvER8MsxvqkZZi9t9j4bzX
         wsdSSb3vjzulBXy+gxw01Lvy6+cLiyrq+T4zu0blfV9tN6v2Wr42lc78GmM1VrB7BhXe
         BWdWmodoItAq3OVHgF40iyTVpnbngYu4xP59OTuFL8aWbErJzCqmoMOvZi9LRWXyNDKl
         MWNHjqITAK6LqiccJDoTdASuG30n4nYqhjquyduvz9wXITLI1LlIolQvYa+LJr5AZijZ
         9JhySQjsciMu/km3/zVJ1/2Pl1C1FYwM35QXYujh7UuTgURm3QY8esljR1HZpoj83DeX
         UxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223402; x=1713828202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNlQW7VRvItZmB++ihw1UtQoUB7JfArp7CvrzW4eQN8=;
        b=R/uoR0K2/0CCJkbhhO97jxBLaV/uQxjGgrCyM0B4iNumIMDBHJ+qTic3A/WGMn++ue
         AQKs8Jvp1fG7GU0Vg8g1hEcZVPnIfpDrMdUcAhOQKr7Lr24on96Kd9mU8EvzkIRTGmH2
         yL4rQk3oF5jRouv3qhN9TnhI1rKg7iWqpkxIUKCOnLBdeW3P5yh4lGz+Zfl38QvcL/O5
         Y4fMiOXZW9LOvUrIikicfYSy0+h7T0rG2JMExRK/DCxyf7aOJHpsOqPTCmmT/tZX/Lrh
         hH7OXJXWRCXRFlZ8Ne7w5QTJ/hTNSPleX0FCYCHccc9U5WGpU347HmdK4QcIsj+Gc9+O
         +Wvw==
X-Gm-Message-State: AOJu0Yzi95xQazXObDbWgJFuUDpaLMgo/ERhZSxG8uuIEJdct8WUz79K
	N1BTMI+Mp/ezal2ZN9LyVE0dMEUqrDTV7Bty6+xJr5WGAnO1I3SSXs8nJIXRYTsjDLn+3XDTXMJ
	xCg==
X-Google-Smtp-Source: AGHT+IEfmDbSnPcLyTj3kB7ynDfm0gZCdDWY03bFWzZtTPBwr9BAGYZ6FgzSOSNLmALtN1qyK9VfamdnZXM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100e:b0:de0:ecc6:4681 with SMTP id
 w14-20020a056902100e00b00de0ecc64681mr1434196ybt.1.1713223402272; Mon, 15 Apr
 2024 16:23:22 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:23:20 -0700
In-Reply-To: <20240413053749.74313-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413053749.74313-1-zide.chen@intel.com>
Message-ID: <Zh226A1xyCW6PtZ5@google.com>
Subject: Re: [PATCH V2] KVM: selftests: Take large C-state exit latency into consideration
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Zide Chen wrote:
> Currently, the migration worker delays 1-10 us, assuming that one
> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
> latencies are large enough, for example, hundreds or even thousands
> of microseconds on server CPUs, it may happen that it's not able to
> bring the target CPU out of C-state before the migration worker starts
> to migrate it to the next CPU.
> 
> If the system workload is light, most CPUs could be at a certain level
> of C-state, which may result in less successful migrations and fail the
> migration/KVM_RUN ratio sanity check.
> 
> This patch adds a command line option to skip the sanity check in
> this case.
> 
> Additionally, seems it's reasonable to randomize the length of usleep(),
> other than delay in a fixed pattern.

This belongs in a separate patch.  And while it's reasonable on the surface, I
doubt think it buys us anything, and it makes an already non-deterministic test
even less deterministic.  In other words, unless a random sleep time helps find
more bugs or finds the original bug faster, just drop the randomization.

> V2:
> - removed the busy loop implementation
> - add the new "-s" option

This belongs in the ignored part of the patch...
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>

...down here.

> ---
>  tools/testing/selftests/kvm/rseq_test.c | 37 +++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 28f97fb52044..515cfa32a925 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -150,7 +150,7 @@ static void *migration_worker(void *__rseq_tid)
>  		 * Use usleep() for simplicity and to avoid unnecessary kernel
>  		 * dependencies.
>  		 */
> -		usleep((i % 10) + 1);
> +		usleep((rand() % 10) + 1);
>  	}
>  	done = true;
>  	return NULL;
> @@ -186,12 +186,35 @@ static void calc_min_max_cpu(void)
>  		       "Only one usable CPU, task migration not possible");
>  }
>  
> +static void usage(const char *name)

Uber nit, "help()" is more common than "usage()".

> @@ -254,9 +279,15 @@ int main(int argc, char *argv[])
>  	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
>  	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
>  	 * migrations given the 1us+ delay in the migration task.
> +	 *
> +	 * Another reason why it may have small migration:KVM_RUN ratio is that,
> +	 * on systems with large C-state exit latency, it may happen quite often
> +	 * that the scheduler is not able to wake up the target CPU before the
> +	 * vCPU thread is scheduled to another CPU.
>  	 */
> -	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
> -		    "Only performed %d KVM_RUNs, task stalled too much?", i);
> +	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2),
> +		    "Only performed %d KVM_RUNs, task stalled too much? "
> +		    "Try to turn off C-states or run it with the -s option", i);

I think it's worth explicitly telling the user how to reduce CPU wakeup latency.
Also, are C-states called that on other architectures?  E.g. maybe this to avoid
confusing the user?  Not a big deal, e.g. I've no objection whatsoever to the
comment, but it seems easy enough to avoid confusing the user.

		    "Try setting /dev/cpu_dma_latency to reduce CPU wakeup latency, "
		    "or run with -s to skip this sanity check", i);

