Return-Path: <linux-kselftest+bounces-9094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAC8B6616
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB8B2149A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DA126F07;
	Mon, 29 Apr 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UC+R6q92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FF1EA90
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432596; cv=none; b=BJ+RnzePCBRK1GsQ/m7H3EAeOyLWOGNWrWLlL/4p7LjnA257H8+FOw4I+aYxrO2VeiZMCnxd9rXuw+CbbnVlFb3+L/MNLFP3f409XSfWOuHvup98fiAg+N2FVx6bsjSNNKAkTL/+QZB/I3HZNZlrJsOD7TzsDw4A1raF+zcDkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432596; c=relaxed/simple;
	bh=u4ArKInx0mn3axBUqLTGogGayKr6CyDk7+sA/kF+kcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNu9ZPY6dZzvA+y0+eJz07puKA7FvvtXvousG9lnOrc/jZcA9raigXchfiPWshLhMgp4tEwiKf5m2MHzsEqqX4HF/fEt/nzs4ZlwDF0DIscEj77Tdp2xltR39eGoFUt3TqYv/C1PboOuf0kTjo7ZR59f6wBuwfnRMvnFzX9XHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UC+R6q92; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432594; x=1745968594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u4ArKInx0mn3axBUqLTGogGayKr6CyDk7+sA/kF+kcU=;
  b=UC+R6q92yae64/MjbsrA8MUV94Ot0Xzy9FwhpWewDEKVNrkaqXrreZas
   euXPXtk9rV9c+6WzHma/px9gz9Vn85xGrgc7UmSp4q0+dvc9RgfqZpKTO
   eeVGGjppp6Hyobn8vNo2AAa/sXePm+9l8kXqmCb9CJ2ozG8ANy69b9Jm9
   ABp5IVl4dRTyqC6Xg5YeXLRT4z0SGoHrLMb6JKWCWdGli26Fj87UIla0T
   q1X7EFZcHS9mq8xc3jNLCqWt4TTNBFH5szC3/vd1D8k6dhC8oZNCHQRzF
   CxUlvP1eTbe2EB1+0cly7zWnfGQcq8DwNVBXnC2LmAQeP0+ik7V5vEK4i
   Q==;
X-CSE-ConnectionGUID: RELJtZBxSDOQv5CtcPm1Vw==
X-CSE-MsgGUID: eDxFeDNwQrmu/nUrtyN9PA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20801500"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20801500"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:16:34 -0700
X-CSE-ConnectionGUID: JCWUM8zxRTOvv9Ces3d7jQ==
X-CSE-MsgGUID: MQLPN2wwTBe9HrpKbbTtdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57131530"
Received: from soc-cp83kr3.sc.intel.com (HELO [10.144.152.150]) ([10.144.152.150])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:16:33 -0700
Message-ID: <5d3c3fa2-5250-41e0-adf7-ee7bf7501b3d@intel.com>
Date: Mon, 29 Apr 2024 16:16:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] KVM: selftests: Add a new option to rseq_test
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
 donsheng <dongsheng.x.zhang@intel.com>
References: <20240416225153.23801-1-zide.chen@intel.com>
 <Zi_3bNOgJl1m0wXy@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <Zi_3bNOgJl1m0wXy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/2024 12:39 PM, Sean Christopherson wrote:
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>
> 
> Why does this have Donghsheng's SoB?  Is this a Co-developed-by situation?

Yes, Co-developed-by is more suitable.

>>
> 
> Put per-patch notes that aren't intended for the final changelog...
> 
>> V2:
>> - removed the busy loop implementation
>> - add the new "-s" option
>>
>> V3:
>> - drop the usleep randomization code
>> - removed the term C-state for less confusion for non-x86 archetectures
>> - changed subject
>> ---
> 
> ...down here below the "---", as this section is ignored by `git am`.  That way
> the maintainer (me) doesn't need to manually delete the notes when applying.

Got it, thank you very much!

>>  tools/testing/selftests/kvm/rseq_test.c | 40 +++++++++++++++++++++++--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
>> +static void help(const char *name)
>> +{
>> +	puts("");
>> +	printf("usage: %s [-h] [-s]\n", name);
>> +	printf(" -s: skip the sanity check for successful KVM_RUN.\n");
> 
> Hmm, -s ends up being somewhat confusing because "sanity" also starts with 's',
> e.g. my first thought is that "./rseq_test -s" would be "run the test with sanity
> checks".
> 
> Maybe -u for unchecked/unverified?

Agree, it's better.

> 	printf(" -u: Don't sanity check the number of successful KVM_RUNs\n");
> 
>> @@ -254,9 +277,22 @@ int main(int argc, char *argv[])
>>  	 * getcpu() to stabilize.  A 2:1 migration:KVM_RUN ratio is a fairly
>>  	 * conservative ratio on x86-64, which can do _more_ KVM_RUNs than
>>  	 * migrations given the 1us+ delay in the migration task.
>> +	 *
>> +	 * Another reason why it may have small migration:KVM_RUN ratio is that,
>> +	 * on systems with large low power mode wakeup latency, it may happen
>> +	 * quite often that the scheduler is not able to wake up the target CPU
>> +	 * before the vCPU thread is scheduled to another CPU.
>>  	 */
>> -	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
>> -		    "Only performed %d KVM_RUNs, task stalled too much?", i);
>> +	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1),
>> +		    "Only performed %d KVM_RUNs, task stalled too much? \n"
>> +		    "  Try to run it with -s option, or disable deep sleep "
>> +		    "states in the system,\n"
>> +		    "  e.g., boot the host with cpuidle.off=1 or other driver "
>> +		    "specific kernel options,\n"
>> +		    "  or do it through the PM QoS interface at runtime: \n"
>> +		    "    cat > /dev/cpu_dma_latency <(echo -e -n "
>> +		    "\"\\x0\\x0\\x0\\x0\"; sleep inf) &\n"
>> +		    "    PID=$! && run_the_test && kill $PID" , i);
> 
> I appreciate trying to be helpful, but this is a bit too verbose.  I would also
> prefer to call out the command line option last, e.g. so that readers don't
> automatically rerun with the sanity check disabled without reading the rest of
> the error message.
> 
> How about this?
> 
> 
> 	TEST_ASSERT(skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1),
> 		    "Only performed %d KVM_RUNs, task stalled too much? \n"
>                     "Try disabling deep sleep states to reduce CPU wakeup latency,\n"
> 		    "e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',\n"
>                     "or run with -u to disable this sanity check", i);

Thank you very much for your patience and your suggestions! I'll adopt
them to V4. How baout to add two white spaces in front of the 2nd, 3rd
and 4th in order to align with the first line (Only performed ... )?

==== Test Assertion Failure ====
  rseq_test.c:286: skip_sanity_check || i > (NR_TASK_MIGRATIONS / 1)
  pid=17851 tid=17851 errno=4 - Interrupted system call
     1  0x00000000004029da: main at rseq_test.c:286
     2  0x00007ff615029d8f: ?? ??:0
     3  0x00007ff615029e3f: ?? ??:0
     4  0x0000000000402ab4: _start at ??:?
  Only performed 22249 KVM_RUNs, task stalled too much?
  Try disabling deep sleep states to reduce CPU wakeup latency,
  e.g. via cpuidle.off=1 or setting /dev/cpu_dma_latency to '0',
  or run with -u to disable this sanity check.

