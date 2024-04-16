Return-Path: <linux-kselftest+bounces-8220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1805E8A7510
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EADFB213B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 19:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795F1384AD;
	Tue, 16 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvTpRwW7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D60137C33
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296625; cv=none; b=nM5XODDcUq6KmKb8xePd0t7F2yW0U0FiVgNeDt8nDU8N7daAeBJIqSjmid/ny7XNltd+PxlCGG6gw2zed+twe/qcYwBbNsADRCNDucXn3kaQqBuML5KNirhqPm8XeMDjsLTJPwiUYvUU8WS8WVcRE5+2Bj7pOdETHstvhwESDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296625; c=relaxed/simple;
	bh=0IPQk3Y6FYUcjy+k00KnrGq4MmM1NUsayaT1wvyAFWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYSKOC0YBzmSdl9QujmHfz5MhO9xkRmsMTEBbItMuu2M+g/P4UL9iatpA3JSspaa9+HTI21d+9m9qRUHYva3xPvFAbISTZJc4yT9wNvOB4P/mRxr+/CDj1uhJIBCkC8npJcZYWo3GTLTa52txMEm40OUH8dcrCur9iEPBbc5+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvTpRwW7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713296624; x=1744832624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0IPQk3Y6FYUcjy+k00KnrGq4MmM1NUsayaT1wvyAFWs=;
  b=dvTpRwW7UIspBrkfKtSWQ3PHd30jutaMBRB43LqRvUhLCGvX5uidh+JI
   qQEQPOew1/1em4NHT+lYJDpuNPJOGZk10QnK1Zjz/4fZ4vdqKYM2FMu34
   WMRHwPSojo9+y8aNzsDff1hoUBCLBnxeJcD1x+knX8UHrg5ZtbMP7wZ3R
   u7zsOpsrT2KvFy5ZDO4vsBBCAehEWnTcQpmMW9ZxeGeUXtdPl20xD3nm5
   fXbOzxfnQq20FGRw2FVKa8jpj2RXaFFcp5zJhXiX1aQvlb5vIJMsTzMHQ
   /C2GhZIaaDcotLvlM+WsC1BaLaxS3sNafgALrFGOVlba99LGTGlx5/+LL
   A==;
X-CSE-ConnectionGUID: TEy3zDLWS3GOGCuSUUfqNw==
X-CSE-MsgGUID: WVQZQ0BpRfKIxu58agpLxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19319747"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19319747"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:43:43 -0700
X-CSE-ConnectionGUID: Q1Ys6zb/TC6tUmsXULbUeQ==
X-CSE-MsgGUID: k7XRWl5jT1i/JX0DKRPzbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22425545"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.71]) ([10.24.10.71])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:43:34 -0700
Message-ID: <2fd55858-2124-45e3-89f5-eb9faf733429@intel.com>
Date: Tue, 16 Apr 2024 12:43:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] KVM: selftests: Take large C-state exit latency into
 consideration
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com
References: <20240413053749.74313-1-zide.chen@intel.com>
 <Zh226A1xyCW6PtZ5@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <Zh226A1xyCW6PtZ5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/2024 4:23 PM, Sean Christopherson wrote:
> On Fri, Apr 12, 2024, Zide Chen wrote:
>> Currently, the migration worker delays 1-10 us, assuming that one
>> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
>> latencies are large enough, for example, hundreds or even thousands
>> of microseconds on server CPUs, it may happen that it's not able to
>> bring the target CPU out of C-state before the migration worker starts
>> to migrate it to the next CPU.
>>
>> If the system workload is light, most CPUs could be at a certain level
>> of C-state, which may result in less successful migrations and fail the
>> migration/KVM_RUN ratio sanity check.
>>
>> This patch adds a command line option to skip the sanity check in
>> this case.
>>
>> Additionally, seems it's reasonable to randomize the length of usleep(),
>> other than delay in a fixed pattern.
> 
> This belongs in a separate patch.  And while it's reasonable on the surface, I
> doubt think it buys us anything, and it makes an already non-deterministic test
> even less deterministic.  In other words, unless a random sleep time helps find
> more bugs or finds the original bug faster, just drop the randomization.

OK, I will drop it.
> 
>> V2:
>> - removed the busy loop implementation
>> - add the new "-s" option
> 
> This belongs in the ignored part of the patch...
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> ...down here.

My bad. Will move it here.

> 
>> ---
>>  tools/testing/selftests/kvm/rseq_test.c | 37 +++++++++++++++++++++++--
>>  1 file changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
>> index 28f97fb52044..515cfa32a925 100644
>> --- a/tools/testing/selftests/kvm/rseq_test.c
>> +++ b/tools/testing/selftests/kvm/rseq_test.c
>> @@ -150,7 +150,7 @@ static void *migration_worker(void *__rseq_tid)
>>  		 * Use usleep() for simplicity and to avoid unnecessary kernel
>>  		 * dependencies.
>>  		 */
>> -		usleep((i % 10) + 1);
>> +		usleep((rand() % 10) + 1);
>>  	}
>>  	done = true;
>>  	return NULL;
>> @@ -186,12 +186,35 @@ static void calc_min_max_cpu(void)
>>  		       "Only one usable CPU, task migration not possible");
>>  }
>>  
>> +static void usage(const char *name)
> 
> Uber nit, "help()" is more common than "usage()".

OK, will do.

> 
>> @@ -254,9 +279,15 @@ int main(int argc, char *argv[])
>>  	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
>>  	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
>>  	 * migrations given the 1us+ delay in the migration task.
>> +	 *
>> +	 * Another reason why it may have small migration:KVM_RUN ratio is that,
>> +	 * on systems with large C-state exit latency, it may happen quite often
>> +	 * that the scheduler is not able to wake up the target CPU before the
>> +	 * vCPU thread is scheduled to another CPU.
>>  	 */
>> -	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
>> -		    "Only performed %d KVM_RUNs, task stalled too much?", i);
>> +	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 2),
>> +		    "Only performed %d KVM_RUNs, task stalled too much? "
>> +		    "Try to turn off C-states or run it with the -s option", i);
> 
> I think it's worth explicitly telling the user how to reduce CPU wakeup latency.

OK, I will add more details in the TEST_ASSERT() statement.

> Also, are C-states called that on other architectures?  E.g. maybe this to avoid
> confusing the user?  Not a big deal, e.g. I've no objection whatsoever to the
> comment, but it seems easy enough to avoid confusing the user.

Yes, I agree C-State is not the best term here. I can remove the word
C-state from this patch.

Initially I thought it's OK since C-State is an arch independent term
from ACPI spec. But in Linux, it's not adopted by other arch code other
than x86 and ARM.  Furthermore, the ARM Architecture Reference Manual
simply uses "low power mode" and doesn't adopt the term C-State.


