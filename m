Return-Path: <linux-kselftest+bounces-15518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D2954D6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962811F2319F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DEB1BD034;
	Fri, 16 Aug 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2HtIXfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8F14F9D6
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821319; cv=none; b=iN3f/F5g6IXbTtzZnTj5lUwB6N3mZPLI3inzle8jWfHU1JuO5uswwXrKv2TqXJ4opXoObkN4LX4DGmRWjAp2vB1S/xLn/QUrnrPGw6Jct9h9uVsvmnzdgzei2qsun3iu2Rw4m8OCrkKy3pwEjQGiMoHFxnHqv6NQehiuYY4RQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821319; c=relaxed/simple;
	bh=af3Wnlrqj51wLxCll+j/L/Km0zd0Y1WnD5ggVCwcI5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YrPQv9sIflPCW9GTHnrWRuP0nyQ9SA8KBL9+w7qvYoog0bw4KqzkM/iWQJCcQjBtvu1orx0CEboyFziK4Os7MpjPUW+So3PSaH1An4Me2uyC8Pu3uTxxIP2YhQC0JiBDtvtEvsQHEqgPqpH15XI/otQQVL+CjsIyeBbura60Lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2HtIXfT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11741a4c92so2178788276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723821317; x=1724426117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=audPgIvH9vGhPjDTkEQr2zmmu/dkfSOsV7tEwPaTB5k=;
        b=K2HtIXfTI8m1akQM5of/uUdvLpNW2K8kPVBREgA2W3NCSCF5D+eD2G+R+lfVVUuM8G
         FYhx16U78i7uQEjbH9NynuqpEUyrPm2NAv1ysBqVQZFhDqiFBnUjGF7Xoj1IbcpZ3J/i
         zad+9wFLveze/EBA3EOIWT3hMQRWny6y2sWLxmvv6b2aLeoZhdyjlc6zZ84E8dr7Xq50
         I49Lwt+t6A3iTb1xLuBhUEK/m9/e+9AUDVoEUGLFpd2emELRd15VpRWRMVLnDJBDO/CX
         sGdGDRmvZ4dWwoK5coCinS4T2G6P1y/i46P1UdX4Ueiik7SmU/izcmjokYpcBtktOb1I
         1n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821317; x=1724426117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=audPgIvH9vGhPjDTkEQr2zmmu/dkfSOsV7tEwPaTB5k=;
        b=JXWgCsw48Id1AHUBncGjeMNSW07mxm8gfzO8/czLFz7v3mhjtotK7ght6TJgRoKO1L
         bZR1+6wP+12t9zuF0iLMNAR/yDCnjZmtN+hsO+gImAKtILzoN/3KwLUBw8Ld+I9zhaoB
         8OJxlvGsaH4at5HtxAIyQpYjT0QeHnW9aZf6tnCcHRUz+gaQETeRdl7xAWqL9Zr3ZjwV
         ljLF9iVwYtfpunqfuqw/Ve9gfIVRJiROYtyrwagnctrJfyMGn6jqCTLrp+kTQYrwloMq
         0naBocmxmWjKfLGbWC7CAxQ3wXAw5i2th7tQgseo6/oaw6D1atWZDypHltc7PQj0iUPr
         ClxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZKJqJzN/NhjQYvXD6NLK8xGl6EhJccIuA35ZfGw3c11LmvLHzSz6ZSpqLIj18ce8CgFQAgBmKnjMByZaRkiYAvK8DMXV4sJOxhpzegg3n
X-Gm-Message-State: AOJu0YwWNb+9ZoXEQbwRz8P+YWv45iZb2cpexZZ/9fGFYH6lr6KhGBpd
	xxlNSi0Alh1JmlpMEfM0IjDspnLsPZRLFYU53ze9GbsmQ64vpTL6dhqPKfsSVhNDczYKUDOZ/rb
	VTQ==
X-Google-Smtp-Source: AGHT+IFV3YYIqX95vEiDKWYNQFidNCj03voRsbMLSjJM2NsLTxC+YavJPcOkhhWt87y2JW6LNHEg1k7uXPs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6987:0:b0:e05:fb86:1909 with SMTP id
 3f1490d57ef6-e1180e9caa5mr12919276.6.1723821316975; Fri, 16 Aug 2024 08:15:16
 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:15:15 -0700
In-Reply-To: <20240106083346.29180-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240106083346.29180-1-dongli.zhang@oracle.com>
Message-ID: <Zr9tA1Zo9QXmCm9V@google.com>
Subject: Re: [PATCH 1/1] KVM: selftests: add kvmclock drift test
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Jan 06, 2024, Dongli Zhang wrote:
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
> new file mode 100644
> index 000000000000..324f0dbc5762
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c

For better or worse, our selftests naming adds a _test at the end.

However, should we call this kvm_clock_hotplug_test.c?  That way the file level
comment isn't necessary (those these always become stale), and David's live update
suggestion won't conflict.

Or if the live update code fits nicely in this test, then kvm_clock_drift_test.c
is probably a good name.

> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The kvmclock drift test. Emulate vCPU hotplug and online to verify if
> + * there is kvmclock drift.
> + *
> + * Adapted from steal_time.c

This is really uninteresting.

> + * Copyright (C) 2020, Red Hat, Inc.
> + * Copyright (C) 2024 Oracle and/or its affiliates.
> + */
> +
> +#include <asm/kvm_para.h>
> +#include <asm/pvclock.h>
> +#include <asm/pvclock-abi.h>
> +#include <sys/stat.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define NR_VCPUS		2
> +#define NR_SLOTS		2
> +#define KVMCLOCK_SIZE		sizeof(struct pvclock_vcpu_time_info)
> +/*
> + * KVMCLOCK_GPA is identity mapped
> + */
> +#define KVMCLOCK_GPA		(1 << 30)
> +
> +static uint64_t kvmclock_gpa = KVMCLOCK_GPA;

Why hardcode an address?  Can't the test have a global "struct pvclock_vcpu_time_info"
whose address is then queried by the host by reading the MSR?

Actually, can't the pvclock reads and asserts be done in the guest?  Which is
arguably better since the guest observing drift (or not) is what we really care
about.  Then the host side of the test never needs to resolve a host virtual
address for the pvclock_vcpu_time_info structure.

> +static void guest_code(int cpu)
> +{
> +	struct pvclock_vcpu_time_info *kvmclock;
> +
> +	/*
> +	 * vCPU#0 is to detect the change of pvclock_vcpu_time_info

Just vCPU0, which is the usually terminology in KVM land.

> +	 */

	/* Single line comments should look like this. */

> +	if (cpu == 0) {

Rather than switch inside the guest code, just use vcpu_arch_set_entry_point()
to point vCPU1 at a different function entirely.  Then most of the commetns go
away, and the code is generally much easier to read.

> +		GUEST_SYNC(0);
> +
> +		kvmclock = (struct pvclock_vcpu_time_info *) kvmclock_gpa;
> +		wrmsr(MSR_KVM_SYSTEM_TIME_NEW, kvmclock_gpa | KVM_MSR_ENABLED);
> +
> +		/*
> +		 * Backup the pvclock_vcpu_time_info before vCPU#1 hotplug
> +		 */
> +		kvmclock[1] = kvmclock[0];
> +
> +		GUEST_SYNC(2);
> +		/*
> +		 * Enter the guest to update pvclock_vcpu_time_info
> +		 */
> +		GUEST_SYNC(4);
> +	}
> +
> +	/*
> +	 * vCPU#1 is to emulate the vCPU hotplug
> +	 */
> +	if (cpu == 1) {
> +		GUEST_SYNC(1);
> +		/*
> +		 * This is after the host side MSR_IA32_TSC
> +		 */

Rather than add comments, use an enum to describe the stages:

	enum {
		SYNC_VCPU0_???
		SYNC_VCPU1_???
		SYNC_VCPU0_???
		SYNC_VCPU1_???
	}

That said, why does this test "emulate" hotplug?  Why not literally hotplug a
vCPU?  It's probably _less_ code, and the annoying NR_VCPUS #define goes away too,
because you can do:

	vm = vm_create_with_one_vcpu(&vcpu0, vcpu0_code);

	<setup kvmclock>

	vcpu1 = vm_vcpu_add(vm, 1, vcpu1_code);

Then you probably only need one sync, from vCPU to alert the host that kvmclock
is setup.

> +		GUEST_SYNC(3);
> +	}
> +}
> +#define CLOCKSOURCE_PATH "/sys/devices/system/clocksource/clocksource0/current_clocksource"
> +
> +static void check_clocksource(void)
> +{
> +	char *clk_name;
> +	struct stat st;
> +	FILE *fp;
> +
> +	fp = fopen(CLOCKSOURCE_PATH, "r");
> +	if (!fp) {
> +		pr_info("failed to open clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		return;
> +	}
> +
> +	if (fstat(fileno(fp), &st)) {
> +		pr_info("failed to stat clocksource file: %d; assuming TSC.\n",
> +			errno);
> +		goto out;
> +	}
> +
> +	clk_name = malloc(st.st_size);
> +	TEST_ASSERT(clk_name, "failed to allocate buffer to read file\n");
> +
> +	if (!fgets(clk_name, st.st_size, fp)) {
> +		pr_info("failed to read clocksource file: %d; assuming TSC.\n",
> +			ferror(fp));
> +		goto out;
> +	}
> +
> +	TEST_ASSERT(!strncmp(clk_name, "tsc\n", st.st_size),

TEST_REQUIRE, not TEST_ASSERT, i.e. skip the test if the clocksource isn't
supported, don't cause a failure.

> +		    "clocksource not supported: %s", clk_name);
> +out:
> +	fclose(fp);
> +}

This can all be replaced with:

	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());

