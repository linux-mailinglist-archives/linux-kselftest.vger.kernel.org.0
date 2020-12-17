Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C082DDB8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgLQWn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 17:43:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLQWn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 17:43:59 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608244996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S3rCsR4wz25bQqtxLvPPE+bxBFLx2igc0E9oZoBixU=;
        b=wRinoYpzeL4ipkhvpMBgUpezoNqnN4BwXIz6yCt/nstpu+1cIIa6AhqenWWWDuIGhiMkOk
        CgBSGq+EQLUSN9blubISX09j3JB1cUFFvM2gc/4yVDkCmqEjWMRmnRN92OKprWuQFH8G+K
        NkwxrRjg1k0PiQEkjqiHBNmoHeasdsNX94jSGQkWfCKi19W1Rbw3cvPUrm9IpD7TwUC+nV
        ACdc6YScpXoHcP5diNMP4a5qX4wgyfeDV4LsY8msOVkwEM82YjXZOFroP2V/QtN6nSvTIX
        30LaegIh2ac27qxKzekW++HDO7k8ZZdzcFJWCHEJnmZDQHdeC3vadvqArXeZTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608244996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/S3rCsR4wz25bQqtxLvPPE+bxBFLx2igc0E9oZoBixU=;
        b=++W/DH+pERsrf2PJVkJS5SNOxNLygeL5yW5v2CfziX3B5GGLBVUk7yuB5f3LQe/a8v69Ue
        IAySbYQONXjuIgAQ==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <871rfoscz4.fsf@nanos.tec.linutronix.de>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de>
Date:   Thu, 17 Dec 2020 23:43:16 +0100
Message-ID: <87mtycqcjf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17 2020 at 15:50, Thomas Gleixner wrote:
> On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
>
>> +void write_pkrs(u32 new_pkrs)
>> +{
>> +	u32 *pkrs;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_PKS))
>> +		return;
>> +
>> +	pkrs = get_cpu_ptr(&pkrs_cache);
>
> So this is called from various places including schedule and also from
> the low level entry/exit code. Why do we need to have an extra
> preempt_disable/enable() there via get/put_cpu_ptr()?
>
> Just because performance in those code paths does not matter?
>
>> +	if (*pkrs != new_pkrs) {
>> +		*pkrs = new_pkrs;
>> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
>> +	}
>> +	put_cpu_ptr(pkrs);

Which made me look at the other branch of your git repo just because I
wanted to know about the 'other' storage requirements and I found this
gem:

> update_global_pkrs()
> ...
>	/*
>	 * If we are preventing access from the old value.  Force the
>	 * update on all running threads.
>	 */
>	if (((old_val == 0) && protection) ||
>	    ((old_val & PKR_WD_BIT) && (protection & PKEY_DISABLE_ACCESS))) {
>		int cpu;
>
>		for_each_online_cpu(cpu) {
>			u32 *ptr = per_cpu_ptr(&pkrs_cache, cpu);
>
>			*ptr = update_pkey_val(*ptr, pkey, protection);
>			wrmsrl_on_cpu(cpu, MSR_IA32_PKRS, *ptr);
>			put_cpu_ptr(ptr);

1) per_cpu_ptr() -> put_cpu_ptr() is broken as per_cpu_ptr() is not
   disabling preemption while put_cpu_ptr() enables it which wreckages
   the preemption count. 

   How was that ever tested at all with any debug option enabled?

   Answer: Not at all

2) How is that sequence:

	ptr = per_cpu_ptr(&pkrs_cache, cpu);
	*ptr = update_pkey_val(*ptr, pkey, protection);
	wrmsrl_on_cpu(cpu, MSR_IA32_PKRS, *ptr);

   supposed to be correct vs. a concurrent modification of the
   pkrs_cache of the remote CPU?

   Answer: Not at all

Also doing a wrmsrl_on_cpu() on _each_ online CPU is insane at best.

  A smp function call on a remote CPU takes ~3-5us when the remote CPU
  is not idle and can immediately respond. If the remote CPU is deep in
  idle it can take up to 100us depending on C-State it is in.

  Even if the remote CPU is not not idle and just has interrupts
  disabled for a few dozen of microseconds this adds up.

  So on a 256 CPU system depending on the state of the remote CPUs this
  stalls the CPU doing the update for anything between 1 and 25ms worst
  case.

  Of course that also violates _all_ CPU isolation mechanisms.

  What for?

  Just for the theoretical chance that _all_ remote CPUs have
  seen that global permission and have it still active?

  You're not serious about that, right?

The only use case for this in your tree is: kmap() and the possible
usage of that mapping outside of the thread context which sets it up.

The only hint for doing this at all is:

    Some users, such as kmap(), sometimes requires PKS to be global.

'sometime requires' is really _not_ a technical explanation.

Where is the explanation why kmap() usage 'sometimes' requires this
global trainwreck in the first place and where is the analysis why this
can't be solved differently?

Detailed use case analysis please.

Thanks,

        tglx



