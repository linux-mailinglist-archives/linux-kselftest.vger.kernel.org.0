Return-Path: <linux-kselftest+bounces-9071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB98B6279
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163FA284070
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197113B2A4;
	Mon, 29 Apr 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xz6Az1+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921117597
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419568; cv=none; b=PiHEGB/yPVML4m9tC0yCPHhYpvGuwx4WNBWY1OZINowDdxPFEN4EZ9E1JzXJjT+GVXWMRXzTdfOJ28asRRfhbR3ibzNE26kDUpqvjJicTrSmwrNVhOypp0Nto8iLXOJauUW7N9aTBnciYm/e71u5aBN/qmnyvYTVNfC/VyMZy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419568; c=relaxed/simple;
	bh=JRtxdLkfzKIrxD/3LIGHg/Ivs7QrlpWQUo2COaYYXIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iaFWOTDBMobqqohNVPUuwwWHjTELbWXp+jPT9uEdqtqgBxwMiVC+bzzkx+lO6k3g+SSmL3ncHXlXw2eVljAC1JbfdoryFv4CyHgFxDtGauNgAcdTivyuqo9xPzMmFl5yod8g+ivbkM7GApKPPVt/sfJ61JQRNKsLOtkpzn3WXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xz6Az1+E; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso7598447b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714419566; x=1715024366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWdlcs3YEVtf1pgb8qjIY/JurboELnLgEhx/PSBt9A=;
        b=Xz6Az1+EeZLM0pHgxeEQv0sZJ6BZ3FUX1WEYtHi2oGh0TiA2LzuTs3HqRraBK+8tFw
         ghY08gABChqZshp2BsUQ16raePsU0HlXlOmFr9x6u6irq0a2/UBZ2BIx+ZTax9/BHsdM
         kAB2ObWuWoFYoSwJ0pHSvMaXUfVN7Tj4MrpP1TEOcNESpnsSXffsCuQpApgbCTOPIlRG
         2H700MMoFI8GvPCr+75yLi0YPZTrS/sq0IOzTdpFAdkf3xo8/qR50e1wWmPiDJBoul+y
         xJYIRnhUgs9E1p3IEm1fJFYEIys/8V2yQsNKyKcp+08i1P2/fbsDrBPNijUUkIyoRYlr
         W0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419566; x=1715024366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWdlcs3YEVtf1pgb8qjIY/JurboELnLgEhx/PSBt9A=;
        b=gjiNEyhOT1dGYW3Zri/r56bXGgmfGGv8QUWDfdqgs4/94mMhQ9sc0I00pCWyakc+Ak
         Pp3Jal2Rp/kueWKc89E2TUT+IPUXe9iW53wO/zMxKWQgNND7XC7GhCmhkMr7tfVeHhBw
         PsAp7VsjZoQoiZZPKtuIxqKOu2KflijG46mKgPuDnQqxCBmbMdYhr+vbDlF89Zq42AxZ
         E/uWPi9/r8k1zwRAFUvcdaBVn9jPQZRr7v0+0f/DW5RtmI4wJ73s+1MK0uDsvX/yM+0Y
         mgSTrc8LyxCjCpp+UZJab9s/gvqGJSnCCxtpjDZvjjnJETgeTi26/VKk+sbU/DAhYbRb
         K1lg==
X-Gm-Message-State: AOJu0YyLjg8ilFjnmcG3YwSm8foE+83Jm5rWNtuUkLVFBvtuxubtruqu
	+tSeC1vPstdslSnkRN/KMdV9a7I7kTYqMpqL85A7TxU5dtm4/AOAvaciALhG/LsAmuvNmW2aKRS
	2hA==
X-Google-Smtp-Source: AGHT+IHyMp0GghfU4UXAfk84ZJHHi/VvT5BGJ7p5BMQ1/cpnPLjQsS8Twy0o3e1Z69pdVvlISv/IIR575zg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d9cf:0:b0:611:5a9d:bb0e with SMTP id
 b198-20020a0dd9cf000000b006115a9dbb0emr130321ywe.4.1714419566117; Mon, 29 Apr
 2024 12:39:26 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:39:24 -0700
In-Reply-To: <20240416225153.23801-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416225153.23801-1-zide.chen@intel.com>
Message-ID: <Zi_3bNOgJl1m0wXy@google.com>
Subject: Re: [PATCH V3] KVM: selftests: Add a new option to rseq_test
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	donsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Zide Chen wrote:
> Currently, the migration worker delays 1-10 us, assuming that one
> KVM_RUN iteration only takes a few microseconds.  But if the CPU low
> power wakeup latency is large enough, for example, hundreds or even
> thousands of microseconds deep C-state exit latencies on x86 server
> CPUs, it may happen that it's not able to wakeup the target CPU before
> the migration worker starts to migrate the vCPU thread to the next CPU.
> 
> If the system workload is light, most CPUs could be at a certain low
> power state, which may result in less successful migrations and fail the
> migration/KVM_RUN ratio sanity check.  But this is not supposed to be
> deemed a test failure.
> 
> This patch adds a command line option to skip the sanity check in
> this case.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>

Why does this have Donghsheng's SoB?  Is this a Co-developed-by situation?

> 

Put per-patch notes that aren't intended for the final changelog...

> V2:
> - removed the busy loop implementation
> - add the new "-s" option
> 
> V3:
> - drop the usleep randomization code
> - removed the term C-state for less confusion for non-x86 archetectures
> - changed subject
> ---

...down here below the "---", as this section is ignored by `git am`.  That way
the maintainer (me) doesn't need to manually delete the notes when applying.

>  tools/testing/selftests/kvm/rseq_test.c | 40 +++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

> +static void help(const char *name)
> +{
> +	puts("");
> +	printf("usage: %s [-h] [-s]\n", name);
> +	printf(" -s: skip the sanity check for successful KVM_RUN.\n");

Hmm, -s ends up being somewhat confusing because "sanity" also starts with 's',
e.g. my first thought is that "./rseq_test -s" would be "run the test with sanity
checks".

Maybe -u for unchecked/unverified?

	printf(" -u: Don't sanity check the number of successful KVM_RUNs\n");

> @@ -254,9 +277,22 @@ int main(int argc, char *argv[])
>  	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
>  	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
>  	 * migrations given the 1us+ delay in the migration task.
> +	 *
> +	 * Another reason why it may have small migration:KVM_RUN ratio is that,
> +	 * on systems with large low power mode wakeup latency, it may happen
> +	 * quite often that the scheduler is not able to wake up the target CPU
> +	 * before the vCPU thread is scheduled to another CPU.
>  	 */
> -	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
> -		    "Only performed %d KVM_RUNs, task stalled too much?", i);
> +	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1),
> +		    "Only performed %d KVM_RUNs, task stalled too much? \n"
> +		    "  Try to run it with -s option, or disable deep sleep "
> +		    "states in the system,\n"
> +		    "  e.g., boot the host with cpuidle.off=1 or other driver "
> +		    "specific kernel options,\n"
> +		    "  or do it through the PM QoS interface at runtime: \n"
> +		    "    cat > /dev/cpu_dma_latency <(echo -e -n "
> +		    "\"\\x0\\x0\\x0\\x0\"; sleep inf) &\n"
> +		    "    PID=$! && run_the_test && kill $PID" , i);

I appreciate trying to be helpful, but this is a bit too verbose.  I would also
prefer to call out the command line option last, e.g. so that readers don't
automatically rerun with the sanity check disabled without reading the rest of
the error message.

How about this?


	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1),
		    "Only performed %d KVM_RUNs, task stalled too much? \n"
                    "Try disabling deep sleep states to reduce CPU wakeup latency,\n"
		    "e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',\n"
                    "or run with -u to disable this sanity check", i);

